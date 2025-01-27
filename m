Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8F0C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcRD1-0005cO-Jm; Mon, 27 Jan 2025 10:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcRCx-0005c1-1y
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:39:27 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcRCu-0005c8-FP
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:39:26 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8DA81F383;
 Mon, 27 Jan 2025 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737992362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqHXx1AWXK5VAWNZsrvdhu+eRsRPvl9FJKWmIzF0VL4=;
 b=RCUf+oagwGnAVgbTBSwddxS5cYu3xgi+QIuCD8nT4V3ckeWwMd1aDL5aZISYujLrWKGgiT
 A/8W85snP5j+V+dNhzD3p+06n5LHp+3V62e9V8QudK4fkORBUcQwLh5sakBk7Aa3YYmxBo
 uu7oA7+xOTg3pX7YdprqSmKBq1GowZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737992362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqHXx1AWXK5VAWNZsrvdhu+eRsRPvl9FJKWmIzF0VL4=;
 b=6yq5GluJWlUQpGrhKTnbJMERp6rcihBe954uDzvklsdjdUTqUC6CNXFj1gJJUm9dEzNM8V
 tNrD0lku9N09PMAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=whi0VKON;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WELt6Wie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737992361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqHXx1AWXK5VAWNZsrvdhu+eRsRPvl9FJKWmIzF0VL4=;
 b=whi0VKONtksiTOipY8RlGudp7fNB1uIimKlWpmKefp2L6EylBd/Fgf1DIezctZPGz4fbF0
 PzOkftnKrszG8kuhp+YcSX3Htey3fwo1ZD4hoXB72nOHyYjS0QK/6CGNnuBlrBUobpg5Mn
 M1PDLQjme3+GpYYDSJUBROZD1Ki7LFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737992361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eqHXx1AWXK5VAWNZsrvdhu+eRsRPvl9FJKWmIzF0VL4=;
 b=WELt6WieJApOAnRW5XDKfiRQ+XDPsz7JUd/g5oIvIE/wf1RXyfUeXzqahCX2BNAVX/n6Rt
 hjYGKv6ii8cKNtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33419137C0;
 Mon, 27 Jan 2025 15:39:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g9JQN6iol2cVHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Jan 2025 15:39:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V7 00/24] Live update: cpr-transfer
In-Reply-To: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
Date: Mon, 27 Jan 2025 12:39:18 -0300
Message-ID: <87y0ywqna1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C8DA81F383
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[11]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,oracle.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> What?
>
> This patch series adds the live migration cpr-transfer mode, which
> allows the user to transfer a guest to a new QEMU instance on the same
> host with minimal guest pause time, by preserving guest RAM in place,
> albeit with new virtual addresses in new QEMU, and by preserving device
> file descriptors.
>
> The new user-visible interfaces are:
>   * cpr-transfer (MigMode migration parameter)
>   * cpr (MigrationChannelType)
>   * incoming MigrationChannel (command-line argument)
>   * aux-ram-share (machine option)
>
> The user sets the mode parameter before invoking the migrate command.
> In this mode, the user starts new QEMU on the same host as old QEMU, with
> the same arguments as old QEMU, plus two -incoming options; one for the main
> channel, and one for the CPR channel.  The user issues the migrate command to
> old QEMU, which stops the VM, saves state to the migration channels, and
> enters the postmigrate state.  Execution resumes in new QEMU.
>
> Memory-backend objects must have the share=on attribute, but memory-backend-epc
> is not supported.  The VM must be started with the '-machine aux-ram-share=on'
> option, which allows auxilliary guest memory to be transferred in place to the
> new process.
>
> This mode requires a second migration channel of type "cpr", in the channel
> arguments on the outgoing side, and in a second -incoming command-line
> parameter on the incoming side.  This CPR channel must support file descriptor
> transfer with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
>
> Why?
>
> This mode has less impact on the guest than any other method of updating
> in place.  The pause time is much lower, because devices need not be torn
> down and recreated, DMA does not need to be drained and quiesced, and minimal
> state is copied to new QEMU.  Further, there are no constraints on the guest.
> By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
> and suspending plus resuming vfio devices adds multiple seconds to the
> guest pause time.
>
> These benefits all derive from the core design principle of this mode,
> which is preserving open descriptors.  This approach is very general and
> can be used to support a wide variety of devices that do not have hardware
> support for live migration, including but not limited to: vfio, chardev,
> vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
> to allow a descriptor to be used in a process that did not originally open it.
>
> How?
>
> All memory that is mapped by the guest is preserved in place.  Indeed,
> it must be, because it may be the target of DMA requests, which are not
> quiesced during cpr-transfer.  All such memory must be mmap'able in new QEMU.
> This is easy for named memory-backend objects, as long as they are mapped
> shared, because they are visible in the file system in both old and new QEMU.
> Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
> so the memfd's can be sent to new QEMU.  Pages that were locked in memory
> for DMA in old QEMU remain locked in new QEMU, because the descriptor of
> the device that locked them remains open.
>
> cpr-transfer preserves descriptors by sending them to new QEMU via the CPR
> channel, which must support SCM_RIGHTS, and by sending the unique name of
> each descriptor to new QEMU via CPR state.
>
> For device descriptors, new QEMU reuses the descriptor when creating the
> device, rather than opening it again.  For memfd descriptors, new QEMU
> mmap's the preserved memfd when a ramblock is created.
>
> CPR state cannot be sent over the normal migration channel, because devices
> and backends are created prior to reading the channel, so this mode sends
> CPR state over a second "cpr" migration channel.  New QEMU reads the second
> channel prior to creating devices or backends.
>
> Example:
>
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would use a new QEMU binary path in terminal 2.
>
>   Terminal 1: start old QEMU
>   # qemu-kvm -qmp stdio -object
>   memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>   -m 4G -machine aux-ram-share=on ...
>
>   Terminal 2: start new QEMU
>   # qemu-kvm -monitor stdio ... -incoming tcp:0:44444
>     -incoming '{"channel-type": "cpr",
>                 "addr": { "transport": "socket", "type": "unix",
>                           "path": "cpr.sock"}}'
>
>   Terminal 1:
>   {"execute":"qmp_capabilities"}
>
>   {"execute": "query-status"}
>   {"return": {"status": "running",
>               "running": true}}
>
>   {"execute":"migrate-set-parameters",
>    "arguments":{"mode":"cpr-transfer"}}
>
>   {"execute": "migrate", "arguments": { "channels": [
>     {"channel-type": "main",
>      "addr": { "transport": "socket", "type": "inet",
>                "host": "0", "port": "44444" }},
>     {"channel-type": "cpr",
>      "addr": { "transport": "socket", "type": "unix",
>                "path": "cpr.sock" }}]}}
>
>   {"execute": "query-status"}
>   {"return": {"status": "postmigrate",
>               "running": false}}
>
>   Terminal 2:
>   QEMU 10.0.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
>
> This patch series implements a minimal version of cpr-transfer.  Additional
> series are ready to be posted to deliver the complete vision described
> above, including
>   * vfio
>   * chardev
>   * vhost and tap
>   * blockers
>   * cpr-exec mode
>   * iommufd
>
> Changes in V2:
>   * cpr-transfer is the first new mode proposed, and cpr-exec is deferred
>   * anon-alloc does not apply to memory-backend-object
>   * replaced hack with proper synchronization between source and target
>   * defined QEMU_CPR_FILE_MAGIC
>   * addressed misc review comments
>
> Changes in V3:
>   * added cpr-transfer to migration-test
>   * documented cpr-transfer in CPR.rst
>   * fix size_t trace format for 32-bit build
>   * drop explicit fd value in VMSTATE_FD
>   * defer cpr_walk_fd() and cpr_resave_fd() to later series
>   * drop "migration: save cpr mode".
>     delete mode from cpr state, and use cpr_uri to infer transfer mode.
>   * drop "migration: stop vm earlier for cpr"
>   * dropped cpr helpers, to be re-added later when needed
>   * fixed an unreported bug for cpr-transfer and migrate cancel
>   * documented cpr-transfer restrictions in qapi
>   * added trace for cpr_state_save and cpr_state_load
>   * added ftruncate to "preserve ram blocks"
>
> Changes in V4:
>   * cleaned up qtest deferred connection code
>   * renamed pass_fd -> can_pass_fd
>   * squashed patch "split qmp_migrate"
>   * deleted cpr-uri and its patches
>   * added cpr channel and its patches
>   * added patch "hostmem-shm: preserve for cpr"
>   * added patch "fd-based shared memory"
>   * added patch "factor out allocation of anonymous shared memory"
>   * added RAM_PRIVATE and its patch
>   * added aux-ram-share and its patch
>
> Changes in V5:
>   * added patch 'enhance migrate_uri_parse'
>   * supported dotted keys for -incoming channel,
>     and rewrote incoming_option_parse
>   * moved migrate_fd_cancel -> vm_resume to "stop vm earlier for cpr"
>     in a future series.
>   * updated command-line definition for aux-ram-share
>   * added patch "resizable qemu_ram_alloc_from_fd"
>   * rewrote patch "fd-based shared memory"
>   * fixed error message in qemu_shm_alloc
>   * added patch 'tests/qtest: optimize migrate_set_ports'
>   * added patch 'tests/qtest: enhance migration channels'
>   * added patch 'tests/qtest: assert qmp_ready'
>   * modified patch 'migration-test: cpr-transfer'
>   * polished the documentation in CPR.rst, qapi, and the
>     cpr-transfer mode commit message
>   * updated to master, and resolved massive context diffs for migration tests
>
> Changes in V6:
>   * added RB's and Acks.
>   * in patch "assert qmp_ready", deleted qmp_ready and checked qmp_fd instead.
>     renamed patch to ""assert qmp connected"
>   * factored out fix into new patch
>     "fix qemu_ram_alloc_from_fd size calculation"
>   * deleted a redundant call to migrate_hup_delete
>   * added commit message to "migration: cpr-transfer documentation"
>   * polished the text of cpr-transfer mode in qapi
>
> Changes in V7:
>   * fixed cpr-transfer test failure for s390
>   * fixed machine_get_aux_ram_share compilation error for Windows
>   * fixed size_t print format compilation error for misc architectures
>   * fixed memory leaks in cpr_transfer_output, cpr_transfer_input, and
>     qemu_file_get_fd
>
> The first 10 patches below are foundational and are needed for both cpr-transfer
> mode and the proposed cpr-exec mode.  The next 6 patches are specific to
> cpr-transfer and implement the mechanisms for sharing state across a socket
> using SCM_RIGHTS.  The last 8 patches supply tests and documentation.
>
> Steve Sistare (24):
>   backends/hostmem-shm: factor out allocation of "anonymous shared
>     memory with an fd"
>   physmem: fix qemu_ram_alloc_from_fd size calculation
>   physmem: qemu_ram_alloc_from_fd extensions
>   physmem: fd-based shared memory
>   memory: add RAM_PRIVATE
>   machine: aux-ram-share option
>   migration: cpr-state
>   physmem: preserve ram blocks for cpr
>   hostmem-memfd: preserve for cpr
>   hostmem-shm: preserve for cpr
>   migration: enhance migrate_uri_parse
>   migration: incoming channel
>   migration: SCM_RIGHTS for QEMUFile
>   migration: VMSTATE_FD
>   migration: cpr-transfer save and load
>   migration: cpr-transfer mode
>   migration-test: memory_backend
>   tests/qtest: optimize migrate_set_ports
>   tests/qtest: defer connection
>   migration-test: defer connection
>   tests/qtest: enhance migration channels
>   tests/qtest: assert qmp connected
>   migration-test: cpr-transfer
>   migration: cpr-transfer documentation
>
>  backends/hostmem-epc.c                 |   2 +-
>  backends/hostmem-file.c                |   2 +-
>  backends/hostmem-memfd.c               |  14 ++-
>  backends/hostmem-ram.c                 |   2 +-
>  backends/hostmem-shm.c                 |  51 ++------
>  docs/devel/migration/CPR.rst           | 182 ++++++++++++++++++++++++++-
>  hw/core/machine.c                      |  22 ++++
>  include/exec/memory.h                  |  10 ++
>  include/exec/ram_addr.h                |  13 +-
>  include/hw/boards.h                    |   1 +
>  include/migration/cpr.h                |  33 +++++
>  include/migration/misc.h               |   7 ++
>  include/migration/vmstate.h            |   9 ++
>  include/qemu/osdep.h                   |   1 +
>  meson.build                            |   8 +-
>  migration/cpr-transfer.c               |  71 +++++++++++
>  migration/cpr.c                        | 224 +++++++++++++++++++++++++++++++++
>  migration/meson.build                  |   2 +
>  migration/migration.c                  | 139 +++++++++++++++++++-
>  migration/migration.h                  |   4 +-
>  migration/options.c                    |   8 +-
>  migration/qemu-file.c                  |  84 ++++++++++++-
>  migration/qemu-file.h                  |   2 +
>  migration/ram.c                        |   2 +
>  migration/trace-events                 |  11 ++
>  migration/vmstate-types.c              |  24 ++++
>  qapi/migration.json                    |  44 ++++++-
>  qemu-options.hx                        |  34 +++++
>  stubs/vmstate.c                        |   7 ++
>  system/memory.c                        |   4 +-
>  system/physmem.c                       | 150 ++++++++++++++++++----
>  system/trace-events                    |   1 +
>  system/vl.c                            |  43 ++++++-
>  tests/qtest/libqtest.c                 |  86 ++++++++-----
>  tests/qtest/libqtest.h                 |  19 ++-
>  tests/qtest/migration/cpr-tests.c      |  62 +++++++++
>  tests/qtest/migration/framework.c      |  74 +++++++++--
>  tests/qtest/migration/framework.h      |  11 ++
>  tests/qtest/migration/migration-qmp.c  |  53 ++++++--
>  tests/qtest/migration/migration-qmp.h  |  10 +-
>  tests/qtest/migration/migration-util.c |  23 ++--
>  tests/qtest/migration/misc-tests.c     |   9 +-
>  tests/qtest/migration/precopy-tests.c  |   6 +-
>  tests/qtest/virtio-net-failover.c      |   8 +-
>  util/memfd.c                           |  16 ++-
>  util/oslib-posix.c                     |  52 ++++++++
>  util/oslib-win32.c                     |   6 +
>  47 files changed, 1472 insertions(+), 174 deletions(-)
>  create mode 100644 include/migration/cpr.h
>  create mode 100644 migration/cpr-transfer.c
>  create mode 100644 migration/cpr.c
>
> base-commit: e8aa7fdcddfc8589bdc7c973a052e76e8f999455

I'd like to merge this series by the end of the week if possible. Please
take a look at some comments from Markus that were left behind in v5.

