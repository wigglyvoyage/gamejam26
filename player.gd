extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const GRAVITY = 1000.0

func _physics_process(delta):
	# === DEBUG: Check if script is running ===
	print("=== Physics Frame ===")
	
	# === DEBUG: Check gravity and floor detection ===
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		print("Falling! Velocity Y: ", velocity.y)
	else:
		print("On floor!")
	
	# === DEBUG: Check jump input ===
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("JUMPED! Velocity Y: ", velocity.y)
	
	# === DEBUG: Check specific keys directly (bypasses input map) ===
	var left_pressed = Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT)
	var right_pressed = Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT)
	print("A or Left Arrow pressed: ", left_pressed)
	print("D or Right Arrow pressed: ", right_pressed)
	
	# === DEBUG: Check if input actions exist (proper way) ===
	var has_left_action = InputMap.has_action("move_left")
	var has_right_action = InputMap.has_action("move_right")
	print("Has 'move_left' action in InputMap: ", has_left_action)
	print("Has 'move_right' action in InputMap: ", has_right_action)
	
	# === Get movement direction ===
	var direction = Input.get_axis("move_left", "move_right")
	print("Direction value from Input.get_axis: ", direction)
	
	# === Apply movement ===
	if direction:
		velocity.x = direction * SPEED
		print("Moving! Velocity X: ", velocity.x)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		print("Velocity X slowing: ", velocity.x)
	
	# === DEBUG: Final velocity before move (fixed print) ===
	var final_velocity_msg = "Final velocity - X: " + str(velocity.x) + " Y: " + str(velocity.y)
	print(final_velocity_msg)
	
	# === Apply physics ===
	move_and_slide()
	
	# === DEBUG: Check if move_and_slide() did anything ===
	print("Position after move: ", position)
	print("Is on floor after move: ", is_on_floor())
	print("=== End of frame ===")
	print("")  # Empty line for spacing
