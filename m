Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A99AC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 14:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYnYW-0001Am-E2; Fri, 17 Jan 2025 09:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYnYS-00019N-Ui
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 09:42:37 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYnYQ-0004Kd-5A
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 09:42:36 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 826701F454;
 Fri, 17 Jan 2025 14:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737124952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mA77vTevdOvKsoXFtLVxUJene3XFmNMIqIEDO397wNo=;
 b=pR51k8OFxBh8iwg+S9ZTbKdNWn0UwZSufas9UQLbwExlB4Lt3nYPPuTEnZxvsOo8wAIsCO
 bPoFR1rWKZSSvvd7HFiJMeC0JF9lmJouN5ChmN1NpOXBGBlFRenOjMA/bwZGrxXn6CSiv/
 fHhRyB4N94l7KDlS1hh3o8B5nUdShU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737124952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mA77vTevdOvKsoXFtLVxUJene3XFmNMIqIEDO397wNo=;
 b=yPQUNxY/aXNV5+JBfNpJLEtzGdl1fagHWpoWGnBZ6AegIdGKDdgAF5+WeMyfr6wRRaNvyX
 /Yxifk3uOc1pSTBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737124952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mA77vTevdOvKsoXFtLVxUJene3XFmNMIqIEDO397wNo=;
 b=pR51k8OFxBh8iwg+S9ZTbKdNWn0UwZSufas9UQLbwExlB4Lt3nYPPuTEnZxvsOo8wAIsCO
 bPoFR1rWKZSSvvd7HFiJMeC0JF9lmJouN5ChmN1NpOXBGBlFRenOjMA/bwZGrxXn6CSiv/
 fHhRyB4N94l7KDlS1hh3o8B5nUdShU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737124952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mA77vTevdOvKsoXFtLVxUJene3XFmNMIqIEDO397wNo=;
 b=yPQUNxY/aXNV5+JBfNpJLEtzGdl1fagHWpoWGnBZ6AegIdGKDdgAF5+WeMyfr6wRRaNvyX
 /Yxifk3uOc1pSTBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9B4F13332;
 Fri, 17 Jan 2025 14:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PFmxJVdsimduaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 14:42:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V7 24/24] migration: cpr-transfer documentation
In-Reply-To: <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
Date: Fri, 17 Jan 2025 11:42:29 -0300
Message-ID: <87tt9xec2y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Steve Sistare <steven.sistare@oracle.com> writes:

> Add documentation for the cpr-transfer migration mode.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/devel/migration/CPR.rst | 182 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
> index 63c3647..d6021d5 100644
> --- a/docs/devel/migration/CPR.rst
> +++ b/docs/devel/migration/CPR.rst
> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>  VM is migrated to a new QEMU instance on the same host.  It is
>  intended for use when the goal is to update host software components
>  that run the VM, such as QEMU or even the host kernel.  At this time,
> -cpr-reboot is the only available mode.
> +the cpr-reboot and cpr-transfer modes are available.
>  
>  Because QEMU is restarted on the same host, with access to the same
>  local devices, CPR is allowed in certain cases where normal migration
> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>  Outgoing:
>    * Set the migration mode parameter to ``cpr-reboot``.
>    * Set the ``x-ignore-shared`` capability if desired.
> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>      ``file`` type, but one can use other types such as ``exec``,
>      provided the command captures all the data from the outgoing side,
>      and provides all the data to the incoming side.
> @@ -145,3 +145,181 @@ Caveats
>  
>  cpr-reboot mode may not be used with postcopy, background-snapshot,
>  or COLO.
> +
> +cpr-transfer mode
> +-----------------
> +
> +This mode allows the user to transfer a guest to a new QEMU instance
> +on the same host with minimal guest pause time, by preserving guest
> +RAM in place, albeit with new virtual addresses in new QEMU.  Devices
> +and their pinned memory pages will also be preserved in a future QEMU
> +release.
> +
> +The user starts new QEMU on the same host as old QEMU, with command-
> +line arguments to create the same machine, plus the ``-incoming``
> +option for the main migration channel, like normal live migration.
> +In addition, the user adds a second -incoming option with channel
> +type ``cpr``.  This CPR channel must support file descriptor transfer
> +with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
> +
> +To initiate CPR, the user issues a migrate command to old QEMU,
> +adding a second migration channel of type ``cpr`` in the channels
> +argument.  Old QEMU stops the VM, saves state to the migration
> +channels, and enters the postmigrate state.  Execution resumes in
> +new QEMU.
> +
> +New QEMU reads the CPR channel before opening a monitor, hence
> +the CPR channel cannot be specified in the list of channels for a
> +migrate-incoming command.  It may only be specified on the command
> +line.
> +
> +Usage
> +^^^^^
> +
> +Memory backend objects must have the ``share=on`` attribute.
> +
> +The VM must be started with the ``-machine aux-ram-share=on``
> +option.  This causes implicit RAM blocks (those not described by
> +a memory-backend object) to be allocated by mmap'ing a memfd.
> +Examples include VGA and ROM.
> +
> +Outgoing:
> +  * Set the migration mode parameter to ``cpr-transfer``.
> +  * Issue the ``migrate`` command, containing a main channel and
> +    a cpr channel.
> +
> +Incoming:
> +  * Start new QEMU with two ``-incoming`` options.
> +  * If the VM was running when the outgoing ``migrate`` command was
> +    issued, then QEMU automatically resumes VM execution.
> +
> +Caveats
> +^^^^^^^
> +
> +cpr-transfer mode may not be used with postcopy, background-snapshot,
> +or COLO.
> +
> +memory-backend-epc is not supported.
> +
> +The main incoming migration channel address cannot be a file type.
> +
> +If the main incoming channel address is an inet socket, then the port
> +cannot be 0 (meaning dynamically choose a port).
> +
> +When using ``-incoming defer``, you must issue the migrate command to
> +old QEMU before issuing any monitor commands to new QEMU, because new
> +QEMU blocks waiting to read from the cpr channel before starting its
> +monitor, and old QEMU does not write to the channel until the migrate
> +command is issued.  However, new QEMU does not open and read the
> +main migration channel until you issue the migrate incoming command.
> +
> +Example 1: incoming channel
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In these examples, we simply restart the same version of QEMU, but
> +in a real scenario one would start new QEMU on the incoming side.
> +Note that new QEMU does not print the monitor prompt until old QEMU
> +has issued the migrate command.  The outgoing side uses QMP because
> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
> +brevity.
> +
> +::
> +
> +  Outgoing:                             Incoming:
> +
> +  # qemu-kvm -qmp stdio
> +  -object memory-backend-file,id=ram0,size=4G,
> +  mem-path=/dev/shm/ram0,share=on -m 4G
> +  -machine aux-ram-share=on
> +  ...
> +                                        # qemu-kvm -monitor stdio
> +                                        -incoming tcp:0:44444
> +                                        -incoming '{"channel-type": "cpr",
> +                                          "addr": { "transport": "socket",
> +                                          "type": "unix", "path": "cpr.sock"}}'
> +                                        ...

I'm attempting this and not having much success. Surely I'm missing
something:


$ qemu-system-x86_64 -cpu host -smp 16 -machine pc,accel=kvm \
  -drive id=drive0,if=none,format=qcow2,file=img.qcow2 \
  -device virtio-blk-pci,id=image1,drive=drive0,bootindex=0 \
  -qmp unix:./dst-qmp.sock,server,wait=off \
  -nographic -serial mon:stdio \
  -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on \
  -m 4G -machine aux-ram-share=on \

  -incoming tcp:0:44444 \
  -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}' \

  -trace loadvm_* -trace cpr_* -trace migration_* -trace migrate_* -trace qemu_loadvm_*

cpr_transfer_input cpr.sock
cpr_state_load cpr-transfer mode
cpr_find_fd pc.bios, id 0 returns 15
cpr_find_fd pc.rom, id 0 returns 14
cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 13
cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns 12
cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns 11
cpr_find_fd /rom@etc/acpi/tables, id 0 returns 10
cpr_find_fd /rom@etc/table-loader, id 0 returns 8
cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 3
migrate_set_state new state setup
migration_socket_incoming_accepted 
migration_set_incoming_channel ioc=0x564dc31e7000 ioctype=qio-channel-socket
migrate_set_state new state active
loadvm_state_setup 
qemu_loadvm_state_section 1
qemu_loadvm_state_section_startfull 2(ram) 0 4
qemu_loadvm_state_section 3
qemu_loadvm_state_section_partend 2
qemu_loadvm_state_section 4
qemu_loadvm_state_section_startfull 0(timer) 0 2
qemu_loadvm_state_section 4
qemu_loadvm_state_section_startfull 1(slirp) 0 4
qemu_loadvm_state_section 4
qemu_loadvm_state_section_startfull 4(cpu_common) 0 1
qemu_loadvm_state_section 4
qemu_loadvm_state_section_startfull 5(cpu) 0 12
qemu_loadvm_state_section 4
qemu_loadvm_state_section_startfull 6(kvm-tpr-opt) 0 1
qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
qemu_loadvm_state_post_main -1
migrate_set_state new state failed
migrate_error error=load of migration failed: Operation not permitted
loadvm_state_cleanup 
qemu-system-x86_64: load of migration failed: Operation not permitted

> +  {"execute":"qmp_capabilities"}
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "running",
> +              "running": true}}
> +
> +  {"execute":"migrate-set-parameters",
> +   "arguments":{"mode":"cpr-transfer"}}
> +
> +  {"execute": "migrate", "arguments": { "channels": [
> +    {"channel-type": "main",
> +     "addr": { "transport": "socket", "type": "inet",
> +               "host": "0", "port": "44444" }},
> +    {"channel-type": "cpr",
> +     "addr": { "transport": "socket", "type": "unix",
> +               "path": "cpr.sock" }}]}}
> +
> +                                        QEMU 10.0.50 monitor
> +                                        (qemu) info status
> +                                        VM status: running
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "postmigrate",
> +              "running": false}}
> +
> +Example 2: incoming defer
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This example uses ``-incoming defer`` to hot plug a device before
> +accepting the main migration channel.  Again note you must issue the
> +migrate command to old QEMU before you can issue any monitor
> +commands to new QEMU.
> +
> +
> +::
> +
> +  Outgoing:                             Incoming:
> +
> +  # qemu-kvm -monitor stdio
> +  -object memory-backend-file,id=ram0,size=4G,
> +  mem-path=/dev/shm/ram0,share=on -m 4G
> +  -machine aux-ram-share=on
> +  ...
> +                                        # qemu-kvm -monitor stdio
> +                                        -incoming defer
> +                                        -incoming '{"channel-type": "cpr",
> +                                          "addr": { "transport": "socket",
> +                                          "type": "unix", "path": "cpr.sock"}}'
> +                                        ...
> +  {"execute":"qmp_capabilities"}
> +
> +  {"execute": "device_add",
> +   "arguments": {"driver": "pcie-root-port"}}
> +
> +  {"execute":"migrate-set-parameters",
> +   "arguments":{"mode":"cpr-transfer"}}
> +
> +  {"execute": "migrate", "arguments": { "channels": [
> +    {"channel-type": "main",
> +     "addr": { "transport": "socket", "type": "inet",
> +               "host": "0", "port": "44444" }},
> +    {"channel-type": "cpr",
> +     "addr": { "transport": "socket", "type": "unix",
> +               "path": "cpr.sock" }}]}}
> +
> +                                        QEMU 10.0.50 monitor
> +                                        (qemu) info status
> +                                        VM status: paused (inmigrate)
> +                                        (qemu) device_add pcie-root-port
> +                                        (qemu) migrate_incoming tcp:0:44444
> +                                        (qemu) info status
> +                                        VM status: running
> +
> +  {"execute": "query-status"}
> +  {"return": {"status": "postmigrate",
> +              "running": false}}
> +
> +Futures
> +^^^^^^^
> +
> +cpr-transfer mode is based on a capability to transfer open file
> +descriptors from old to new QEMU.  In the future, descriptors for
> +vfio, iommufd, vhost, and char devices could be transferred,
> +preserving those devices and their kernel state without interruption,
> +even if they do not explicitly support live migration.

