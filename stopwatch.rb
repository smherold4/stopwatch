class Stopwatch
	include Singleton
	
	class << self
		
		def instance
			@instance ||= new
		end
		
		def start(label)
			instance.start(label)
		end
	
		def stop(label, obj = nil)
			obj.inspect
			instance.stop(label)
		end
	
		def check(label = nil)
			label ? instance.measurements[label] : instance.measurements
		end
		
	end
			
	def measurements
		@measurements ||= Hash.new { |this, key| this[key] = Measurement.new }
	end
	
	def start(label)
		measurements[label].start
	end
	
	def stop(label)
		measurements[label].stop
	end
	
	class Measurement
		
		def initialize
			@times = []
		end
		
		def start
			@current_start_time = Time.now
		end
		
		def stop
			raise "You must start before you can stop" unless @current_start_time
			@times << Time.now - @current_start_time
			@current_start_time = nil
			@times.last
		end
		
		def average
			return nil unless @times.present?
			@times.inject(:+)/(@times.length)
		end
		
		def inspect
			{ avg_time: average, count: @times.length, last_3: @times.last(3) }.to_s
		end
		
	end
	
end