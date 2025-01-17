Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F003FC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 15:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYoHi-0003f7-V0; Fri, 17 Jan 2025 10:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYoHb-0003el-Hx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 10:29:17 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYoHW-000432-HP
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 10:29:13 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17E2B210F5;
 Fri, 17 Jan 2025 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737127748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTKNGTDWBbB8Vb9VvaCWoc4Foi9/E2mhxfgwcgPJbBU=;
 b=QW4syBExCsAx55G9PP0301n2ZEf4Kd4dqI5TZlTc0DjLYaOLvFa1hl6Mp5kN01TzSvJMp+
 pn48k1jeGr/hn3MIy30kQT49OGVdHAELJI9jXyrotoVzl3qU8jbAIwoSrMfb6FMAqihjLu
 Rt8b4RSGv6qwESSLu3A6dYY3ThrmxAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737127748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTKNGTDWBbB8Vb9VvaCWoc4Foi9/E2mhxfgwcgPJbBU=;
 b=I8BjiI9HLcsj4GfZjuSG3JMC78xBRyFukRkEr7Y9wJi8R6LBgGOgPtNMx2yr/4MQkeUivF
 CaknLPJmijnjvsBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737127748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTKNGTDWBbB8Vb9VvaCWoc4Foi9/E2mhxfgwcgPJbBU=;
 b=QW4syBExCsAx55G9PP0301n2ZEf4Kd4dqI5TZlTc0DjLYaOLvFa1hl6Mp5kN01TzSvJMp+
 pn48k1jeGr/hn3MIy30kQT49OGVdHAELJI9jXyrotoVzl3qU8jbAIwoSrMfb6FMAqihjLu
 Rt8b4RSGv6qwESSLu3A6dYY3ThrmxAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737127748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTKNGTDWBbB8Vb9VvaCWoc4Foi9/E2mhxfgwcgPJbBU=;
 b=I8BjiI9HLcsj4GfZjuSG3JMC78xBRyFukRkEr7Y9wJi8R6LBgGOgPtNMx2yr/4MQkeUivF
 CaknLPJmijnjvsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7665113332;
 Fri, 17 Jan 2025 15:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DZE/DUN3imenWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 17 Jan 2025 15:29:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V7 24/24] migration: cpr-transfer documentation
In-Reply-To: <68bee183-ba2b-420c-b885-a6ba630f74fe@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
 <87tt9xec2y.fsf@suse.de> <68bee183-ba2b-420c-b885-a6ba630f74fe@oracle.com>
Date: Fri, 17 Jan 2025 12:29:04 -0300
Message-ID: <87r051e9xb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 1/17/2025 9:42 AM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Add documentation for the cpr-transfer migration mode.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>   docs/devel/migration/CPR.rst | 182 ++++++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 180 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
>>> index 63c3647..d6021d5 100644
>>> --- a/docs/devel/migration/CPR.rst
>>> +++ b/docs/devel/migration/CPR.rst
>>> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>>>   VM is migrated to a new QEMU instance on the same host.  It is
>>>   intended for use when the goal is to update host software components
>>>   that run the VM, such as QEMU or even the host kernel.  At this time,
>>> -cpr-reboot is the only available mode.
>>> +the cpr-reboot and cpr-transfer modes are available.
>>>   
>>>   Because QEMU is restarted on the same host, with access to the same
>>>   local devices, CPR is allowed in certain cases where normal migration
>>> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>>>   Outgoing:
>>>     * Set the migration mode parameter to ``cpr-reboot``.
>>>     * Set the ``x-ignore-shared`` capability if desired.
>>> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
>>> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>>>       ``file`` type, but one can use other types such as ``exec``,
>>>       provided the command captures all the data from the outgoing side,
>>>       and provides all the data to the incoming side.
>>> @@ -145,3 +145,181 @@ Caveats
>>>   
>>>   cpr-reboot mode may not be used with postcopy, background-snapshot,
>>>   or COLO.
>>> +
>>> +cpr-transfer mode
>>> +-----------------
>>> +
>>> +This mode allows the user to transfer a guest to a new QEMU instance
>>> +on the same host with minimal guest pause time, by preserving guest
>>> +RAM in place, albeit with new virtual addresses in new QEMU.  Devices
>>> +and their pinned memory pages will also be preserved in a future QEMU
>>> +release.
>>> +
>>> +The user starts new QEMU on the same host as old QEMU, with command-
>>> +line arguments to create the same machine, plus the ``-incoming``
>>> +option for the main migration channel, like normal live migration.
>>> +In addition, the user adds a second -incoming option with channel
>>> +type ``cpr``.  This CPR channel must support file descriptor transfer
>>> +with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
>>> +
>>> +To initiate CPR, the user issues a migrate command to old QEMU,
>>> +adding a second migration channel of type ``cpr`` in the channels
>>> +argument.  Old QEMU stops the VM, saves state to the migration
>>> +channels, and enters the postmigrate state.  Execution resumes in
>>> +new QEMU.
>>> +
>>> +New QEMU reads the CPR channel before opening a monitor, hence
>>> +the CPR channel cannot be specified in the list of channels for a
>>> +migrate-incoming command.  It may only be specified on the command
>>> +line.
>>> +
>>> +Usage
>>> +^^^^^
>>> +
>>> +Memory backend objects must have the ``share=on`` attribute.
>>> +
>>> +The VM must be started with the ``-machine aux-ram-share=on``
>>> +option.  This causes implicit RAM blocks (those not described by
>>> +a memory-backend object) to be allocated by mmap'ing a memfd.
>>> +Examples include VGA and ROM.
>>> +
>>> +Outgoing:
>>> +  * Set the migration mode parameter to ``cpr-transfer``.
>>> +  * Issue the ``migrate`` command, containing a main channel and
>>> +    a cpr channel.
>>> +
>>> +Incoming:
>>> +  * Start new QEMU with two ``-incoming`` options.
>>> +  * If the VM was running when the outgoing ``migrate`` command was
>>> +    issued, then QEMU automatically resumes VM execution.
>>> +
>>> +Caveats
>>> +^^^^^^^
>>> +
>>> +cpr-transfer mode may not be used with postcopy, background-snapshot,
>>> +or COLO.
>>> +
>>> +memory-backend-epc is not supported.
>>> +
>>> +The main incoming migration channel address cannot be a file type.
>>> +
>>> +If the main incoming channel address is an inet socket, then the port
>>> +cannot be 0 (meaning dynamically choose a port).
>>> +
>>> +When using ``-incoming defer``, you must issue the migrate command to
>>> +old QEMU before issuing any monitor commands to new QEMU, because new
>>> +QEMU blocks waiting to read from the cpr channel before starting its
>>> +monitor, and old QEMU does not write to the channel until the migrate
>>> +command is issued.  However, new QEMU does not open and read the
>>> +main migration channel until you issue the migrate incoming command.
>>> +
>>> +Example 1: incoming channel
>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>> +
>>> +In these examples, we simply restart the same version of QEMU, but
>>> +in a real scenario one would start new QEMU on the incoming side.
>>> +Note that new QEMU does not print the monitor prompt until old QEMU
>>> +has issued the migrate command.  The outgoing side uses QMP because
>>> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
>>> +brevity.
>>> +
>>> +::
>>> +
>>> +  Outgoing:                             Incoming:
>>> +
>>> +  # qemu-kvm -qmp stdio
>>> +  -object memory-backend-file,id=ram0,size=4G,
>>> +  mem-path=/dev/shm/ram0,share=on -m 4G
>>> +  -machine aux-ram-share=on
>>> +  ...
>>> +                                        # qemu-kvm -monitor stdio
>>> +                                        -incoming tcp:0:44444
>>> +                                        -incoming '{"channel-type": "cpr",
>>> +                                          "addr": { "transport": "socket",
>>> +                                          "type": "unix", "path": "cpr.sock"}}'
>>> +                                        ...
>> 
>> I'm attempting this and not having much success. Surely I'm missing
>> something:
>> 
>> 
>> $ qemu-system-x86_64 -cpu host -smp 16 -machine pc,accel=kvm \
>>    -drive id=drive0,if=none,format=qcow2,file=img.qcow2 \
>>    -device virtio-blk-pci,id=image1,drive=drive0,bootindex=0 \
>>    -qmp unix:./dst-qmp.sock,server,wait=off \
>>    -nographic -serial mon:stdio \
>>    -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on \
>>    -m 4G -machine aux-ram-share=on \
>> 
>>    -incoming tcp:0:44444 \
>>    -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}' \
>> 
>>    -trace loadvm_* -trace cpr_* -trace migration_* -trace migrate_* -trace qemu_loadvm_*
>> 
>> cpr_transfer_input cpr.sock
>> cpr_state_load cpr-transfer mode
>> cpr_find_fd pc.bios, id 0 returns 15
>> cpr_find_fd pc.rom, id 0 returns 14
>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 13
>> cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns 12
>> cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns 11
>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 10
>> cpr_find_fd /rom@etc/table-loader, id 0 returns 8
>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 3
>> migrate_set_state new state setup
>> migration_socket_incoming_accepted
>> migration_set_incoming_channel ioc=0x564dc31e7000 ioctype=qio-channel-socket
>> migrate_set_state new state active
>> loadvm_state_setup
>> qemu_loadvm_state_section 1
>> qemu_loadvm_state_section_startfull 2(ram) 0 4
>> qemu_loadvm_state_section 3
>> qemu_loadvm_state_section_partend 2
>> qemu_loadvm_state_section 4
>> qemu_loadvm_state_section_startfull 0(timer) 0 2
>> qemu_loadvm_state_section 4
>> qemu_loadvm_state_section_startfull 1(slirp) 0 4
>> qemu_loadvm_state_section 4
>> qemu_loadvm_state_section_startfull 4(cpu_common) 0 1
>> qemu_loadvm_state_section 4
>> qemu_loadvm_state_section_startfull 5(cpu) 0 12
>> qemu_loadvm_state_section 4
>> qemu_loadvm_state_section_startfull 6(kvm-tpr-opt) 0 1
>> qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
>> qemu_loadvm_state_post_main -1
>> migrate_set_state new state failed
>> migrate_error error=load of migration failed: Operation not permitted
>> loadvm_state_cleanup
>> qemu-system-x86_64: load of migration failed: Operation not permitted
>
> Check for a mismatch between the qemu args on the source vs dest.
> Maybe -cpu.

No.. they're the same:

qemu-system-x86_64 -display none -cpu host -smp 4 -machine pc,accel=kvm
-object
memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m
4G -machine aux-ram-share=on -qmp stdio

qemu-system-x86_64 -display none -cpu host -smp 4 -machine pc,accel=kvm
-object
memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m
4G -machine aux-ram-share=on -incoming tcp:0:44444 -incoming
'{"channel-type": "cpr", "addr": { "transport": "socket", "type":
"unix", "path": "cpr.sock"}}' -monitor stdio


Here's the whole log, see if you spot something:

$ (sleep 5; echo "{ 'execute': 'qmp_capabilities' }
                 { 'execute': 'migrate-set-parameters','arguments':{ 'mode': 'cpr-transfer' } }
                 { 'execute': 'migrate', 'arguments': \
                   { 'channels': [ \
                     {'channel-type': 'main', 'addr': { 'transport': 'socket', 'type': 'inet', \
                                      'host': '0', 'port': '44444' }}, \
                     {'channel-type': 'cpr', 'addr': { 'transport': 'socket', 'type': 'unix', \
                                      'path': 'cpr.sock' }} \
                   ]} \
                 }") | /home/fabiano/qemu-system-x86_64 -display none
                 -cpu host -smp 4 -machine pc,accel=kvm -qmp stdio
                 -object
                 memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
                 -m 4G -machine aux-ram-share=on -trace cpr_* -trace
                 migration_* -trace migrate_* -trace qemu_savevm_*
                 -trace savevm_*

{"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9}, "package": "v9.2.0-987-gfd4129a8b9"}, "capabilities": ["oob"]}}
cpr_find_fd pc.bios, id 0 returns -1
cpr_save_fd pc.bios, id 0, fd 22
cpr_find_fd pc.rom, id 0 returns -1
cpr_save_fd pc.rom, id 0, fd 23
cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 24
cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns -1
cpr_save_fd 0000:00:02.0/vga.rom, id 0, fd 26
cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns -1
cpr_save_fd 0000:00:03.0/e1000.rom, id 0, fd 27
cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
cpr_save_fd /rom@etc/acpi/tables, id 0, fd 28
cpr_find_fd /rom@etc/table-loader, id 0 returns -1
cpr_save_fd /rom@etc/table-loader, id 0, fd 29
cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 30
migration_block_activation active-skipped
{"return": {}}
{"return": {}}
migrate_set_state new state setup
cpr_state_save cpr-transfer mode
cpr_transfer_output cpr.sock
{"return": {}}
migration_socket_outgoing_connected hostname=0
migration_set_outgoing_channel ioc=0x55748ba10270 ioctype=qio-channel-socket hostname=0 err=(nil)
{"timestamp": {"seconds": 1737127025, "microseconds": 606998}, "event": "STOP"}
migration_completion_vm_stop ret 0
migration_transferred_bytes qemu_file 224 multifd 0 RDMA 0
savevm_state_header
savevm_state_setup
migration_bitmap_sync_start
migration_bitmap_sync_end dirty_pages 0
migrate_set_state new state active
migration_thread_setup_complete
migration_transferred_bytes qemu_file 506 multifd 0 RDMA 0
migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
migration_thread_low_pending 0
migrate_set_state new state device
migration_block_activation inactive
migration_precopy_complete
savevm_section_start ram, section_id 2
migration_bitmap_sync_start
migration_bitmap_sync_end dirty_pages 0
savevm_section_end ram, section_id 2 -> 0
savevm_section_start timer, section_id 0
savevm_section_end timer, section_id 0 -> 0
savevm_section_start slirp, section_id 1
savevm_section_end slirp, section_id 1 -> 0
savevm_section_start cpu_common, section_id 4
savevm_section_end cpu_common, section_id 4 -> 0
savevm_section_start cpu, section_id 5
savevm_section_end cpu, section_id 5 -> 0
savevm_section_start kvm-tpr-opt, section_id 6
savevm_section_end kvm-tpr-opt, section_id 6 -> 0
savevm_section_start apic, section_id 7
savevm_section_end apic, section_id 7 -> 0
savevm_section_start cpu_common, section_id 8
savevm_section_end cpu_common, section_id 8 -> 0
savevm_section_start cpu, section_id 9
savevm_section_end cpu, section_id 9 -> 0
savevm_section_start apic, section_id 10
savevm_section_end apic, section_id 10 -> 0
savevm_section_start cpu_common, section_id 11
savevm_section_end cpu_common, section_id 11 -> 0
savevm_section_start cpu, section_id 12
savevm_section_end cpu, section_id 12 -> 0
savevm_section_start apic, section_id 13
savevm_section_end apic, section_id 13 -> 0
savevm_section_start cpu_common, section_id 14
savevm_section_end cpu_common, section_id 14 -> 0
savevm_section_start cpu, section_id 15
savevm_section_end cpu, section_id 15 -> 0
savevm_section_start apic, section_id 16
savevm_section_end apic, section_id 16 -> 0
savevm_section_start kvmclock, section_id 17
savevm_section_end kvmclock, section_id 17 -> 0
savevm_section_start 0000:00:00.0/I440FX, section_id 18
savevm_section_end 0000:00:00.0/I440FX, section_id 18 -> 0
savevm_section_start PCIHost, section_id 19
savevm_section_end PCIHost, section_id 19 -> 0
savevm_section_start PCIBUS, section_id 20
savevm_section_end PCIBUS, section_id 20 -> 0
savevm_section_start fw_cfg, section_id 21
savevm_section_end fw_cfg, section_id 21 -> 0
savevm_section_start dma, section_id 22
savevm_section_end dma, section_id 22 -> 0
savevm_section_start dma, section_id 23
savevm_section_end dma, section_id 23 -> 0
savevm_section_start mc146818rtc, section_id 24
savevm_section_end mc146818rtc, section_id 24 -> 0
savevm_section_start 0000:00:01.1/ide, section_id 25
savevm_section_end 0000:00:01.1/ide, section_id 25 -> 0
savevm_section_start i2c_bus, section_id 26
savevm_section_end i2c_bus, section_id 26 -> 0
savevm_section_start 0000:00:01.3/piix4_pm, section_id 27
savevm_section_end 0000:00:01.3/piix4_pm, section_id 27 -> 0
savevm_section_start 0000:00:01.0/PIIX3, section_id 28
savevm_section_end 0000:00:01.0/PIIX3, section_id 28 -> 0
savevm_section_start i8259, section_id 29
savevm_section_end i8259, section_id 29 -> 0
savevm_section_start i8259, section_id 30
savevm_section_end i8259, section_id 30 -> 0
savevm_section_start ioapic, section_id 31
savevm_section_end ioapic, section_id 31 -> 0
savevm_section_start 0000:00:02.0/vga, section_id 32
savevm_section_end 0000:00:02.0/vga, section_id 32 -> 0
savevm_section_start hpet, section_id 33
savevm_section_end hpet, section_id 33 -> 0
savevm_section_start i8254, section_id 34
savevm_section_end i8254, section_id 34 -> 0
savevm_section_start pcspk, section_id 35
savevm_section_end pcspk, section_id 35 -> 0
savevm_section_start serial, section_id 36
savevm_section_end serial, section_id 36 -> 0
savevm_section_start parallel_isa, section_id 37
savevm_section_end parallel_isa, section_id 37 -> 0
savevm_section_start fdc, section_id 38
savevm_section_end fdc, section_id 38 -> 0
savevm_section_start ps2kbd, section_id 39
savevm_section_end ps2kbd, section_id 39 -> 0
savevm_section_start ps2mouse, section_id 40
savevm_section_end ps2mouse, section_id 40 -> 0
savevm_section_start pckbd, section_id 41
savevm_section_end pckbd, section_id 41 -> 0
savevm_section_start vmmouse, section_id 42
savevm_section_end vmmouse, section_id 42 -> 0
savevm_section_start port92, section_id 43
savevm_section_end port92, section_id 43 -> 0
savevm_section_start 0000:00:03.0/e1000, section_id 44
savevm_section_end 0000:00:03.0/e1000, section_id 44 -> 0
savevm_section_skip smbus-eeprom, section_id 45
savevm_section_skip smbus-eeprom, section_id 46
savevm_section_skip smbus-eeprom, section_id 47
savevm_section_skip smbus-eeprom, section_id 48
savevm_section_skip smbus-eeprom, section_id 49
savevm_section_skip smbus-eeprom, section_id 50
savevm_section_skip smbus-eeprom, section_id 51
savevm_section_skip smbus-eeprom, section_id 52
savevm_section_start acpi_build, section_id 53
savevm_section_end acpi_build, section_id 53 -> 0
savevm_section_start globalstate, section_id 54
migrate_global_state_pre_save saved state: running
savevm_section_end globalstate, section_id 54 -> 0
migrate_error error=Unable to write to socket: Connection reset by peer
migrate_set_state new state failed
migration_thread_after_loop
migration_block_activation active
{"timestamp": {"seconds": 1737127025, "microseconds": 625404}, "event": "RESUME"}
migrate_fd_cleanup
savevm_state_cleanup
qemu-system-x86_64: Unable to write to socket: Connection reset by peer


$ /home/fabiano/qemu-system-x86_64 -display none -cpu host -smp 4
-machine pc,accel=kvm -object
memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m
4G -machine aux-ram-share=on -incoming tcp:0:44444 -incoming
'{"channel-type": "cpr", "addr": { "transport": "socket", "type":
"unix", "path": "cpr.sock"}}' -trace loadvm_* -trace cpr_* -trace
migration_* -trace migrate_* -monitor stdio

cpr_transfer_input cpr.sock
cpr_state_load cpr-transfer mode
QEMU 9.2.50 monitor - type 'help' for more information
cpr_find_fd pc.bios, id 0 returns 15
cpr_find_fd pc.rom, id 0 returns 14
cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 13
cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns 12
cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns 11
cpr_find_fd /rom@etc/acpi/tables, id 0 returns 10
cpr_find_fd /rom@etc/table-loader, id 0 returns 8
cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 3
migrate_set_state new state setup
(qemu) migration_socket_incoming_accepted
migration_set_incoming_channel ioc=0x5565cccb8e70 ioctype=qio-channel-socket
migrate_set_state new state active
loadvm_state_setup
qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
migrate_set_state new state failed
migrate_error error=load of migration failed: Operation not permitted
loadvm_state_cleanup
qemu-system-x86_64: load of migration failed: Operation not permitted

