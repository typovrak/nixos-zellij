{ config, pkgs, ... }:

let 
	username = config.username;
	group = config.users.users.${username}.group or "users";
	home = config.users.users.${username}.home;
in {
	system.activationScripts.zellij = ''
		mkdir -p ${home}/.config
		chown ${username}:${group} ${home}/.config
		chmod 700 ${home}/.config

		rm -rf ${home}/.config/zellij
		mkdir ${home}/.config/zellij
		chown ${username}:${group} ${home}/.config/zellij
		chmod 700 ${home}/.config/zellij

		cp ${./config.kdl} ${home}/.config/zellij/config.kdl
		chown ${username}:${group} ${home}/.config/zellij/config.kdl
		chmod 600 ${home}/.config/zellij/config.kdl
	'';

	environment.systemPackages = with pkgs; [
		zellij
	];
}
