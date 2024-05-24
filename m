Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FCCC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAUaz-0002j2-Im; Fri, 24 May 2024 09:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAUau-0002i0-Fe
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:04:26 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAUas-0002Y4-4s
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:04:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 872AE33AFF;
 Fri, 24 May 2024 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716555860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LMxMMw5N//taVn3sRD/kMLByAqMQr55qXiRRH1k9Bs=;
 b=oODFLutMGq/Yz+RIgTIVGJtgAW/+stGJU5aNo48NvDKMDYsIdugP89N9iqDJPYgm85SvPw
 4OaO1JNnsDBVocT/1qKV5YViEo5lTXu+0cChzfAYgGczO8vjReIXWqcOCc8ldRU8clMdj4
 ijGyEerDBC5veA/iwjw8j6om2aMT5z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716555860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LMxMMw5N//taVn3sRD/kMLByAqMQr55qXiRRH1k9Bs=;
 b=rhIuulGC2uUxYm8tgaU661BRm3RdhbOZ0W0SzJ8UFYvXk9+4ayf68zcZ8lBeGDmAoEqlJ+
 zHIkipEpeRjbuxCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716555860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LMxMMw5N//taVn3sRD/kMLByAqMQr55qXiRRH1k9Bs=;
 b=oODFLutMGq/Yz+RIgTIVGJtgAW/+stGJU5aNo48NvDKMDYsIdugP89N9iqDJPYgm85SvPw
 4OaO1JNnsDBVocT/1qKV5YViEo5lTXu+0cChzfAYgGczO8vjReIXWqcOCc8ldRU8clMdj4
 ijGyEerDBC5veA/iwjw8j6om2aMT5z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716555860;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8LMxMMw5N//taVn3sRD/kMLByAqMQr55qXiRRH1k9Bs=;
 b=rhIuulGC2uUxYm8tgaU661BRm3RdhbOZ0W0SzJ8UFYvXk9+4ayf68zcZ8lBeGDmAoEqlJ+
 zHIkipEpeRjbuxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 548F913A6B;
 Fri, 24 May 2024 13:04:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tgeNOFKQUGanOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 May 2024 13:04:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, Igor
 Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Philippe Mathieu-Daude
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
In-Reply-To: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
Date: Fri, 24 May 2024 10:02:00 -0300
Message-ID: <87le3zgy7r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,habkost.net,gmail.com,linaro.org,oracle.com];
 RCPT_COUNT_TWELVE(0.00)[12]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> This patch series adds the live migration cpr-exec mode.  In this mode, QEMU
> stops the VM, writes VM state to the migration URI, and directly exec's a
> new version of QEMU on the same host, replacing the original process while
> retaining its PID.  Guest RAM is preserved in place, albeit with new virtual
> addresses.  The user completes the migration by specifying the -incoming
> option, and by issuing the migrate-incoming command if necessary.  This
> saves and restores VM state, with minimal guest pause time, so that QEMU may
> be updated to a new version in between.
>
> The new interfaces are:
>   * cpr-exec (MigMode migration parameter)
>   * cpr-exec-args (migration parameter)
>   * memfd-alloc=on (command-line option for -machine)
>   * only-migratable-modes (command-line argument)
>
> The caller sets the mode parameter before invoking the migrate command.
>
> Arguments for the new QEMU process are taken from the cpr-exec-args parameter.
> The first argument should be the path of a new QEMU binary, or a prefix
> command that exec's the new QEMU binary, and the arguments should include
> the -incoming option.
>
> Memory backend objects must have the share=on attribute, and must be mmap'able
> in the new QEMU process.  For example, memory-backend-file is acceptable,
> but memory-backend-ram is not.
>
> QEMU must be started with the '-machine memfd-alloc=on' option.  This causes
> implicit RAM blocks (those not explicitly described by a memory-backend
> object) to be allocated by mmap'ing a memfd.  Examples include VGA, ROM,
> and even guest RAM when it is specified without without reference to a
> memory-backend object.   The memfds are kept open across exec, their values
> are saved in vmstate which is retrieved after exec, and they are re-mmap'd.
>
> The '-only-migratable-modes cpr-exec' option guarantees that the
> configuration supports cpr-exec.  QEMU will exit at start time if not.
>
> Example:
>
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would set a new QEMU binary path in cpr-exec-args.
>
>   # qemu-kvm -monitor stdio -object
>   memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>   -m 4G -machine memfd-alloc=on ...
>
>   QEMU 9.1.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
>   (qemu) migrate_set_parameter mode cpr-exec
>   (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
>   (qemu) migrate -d file:vm.state
>   (qemu) QEMU 9.1.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
>
> cpr-exec mode preserves attributes of outgoing devices that must be known
> before the device is created on the incoming side, such as the memfd descriptor
> number, but currently the migration stream is read after all devices are
> created.  To solve this problem, I add two VMStateDescription options:
> precreate and factory.  precreate objects are saved to their own migration
> stream, distinct from the main stream, and are read early by incoming QEMU,
> before devices are created.  Factory objects are allocated on demand, without
> relying on a pre-registered object's opaque address, which is necessary
> because the devices to which the state will apply have not been created yet
> and hence have not registered an opaque address to receive the state.
>
> This patch series implements a minimal version of cpr-exec.  Future series
> will add support for:
>   * vfio
>   * chardev's without loss of connectivity
>   * vhost
>   * fine-grained seccomp controls
>   * hostmem-memfd
>   * cpr-exec migration test
>
>
> Steve Sistare (26):
>   oslib: qemu_clear_cloexec
>   vl: helper to request re-exec
>   migration: SAVEVM_FOREACH
>   migration: delete unused parameter mis
>   migration: precreate vmstate
>   migration: precreate vmstate for exec
>   migration: VMStateId
>   migration: vmstate_info_void_ptr
>   migration: vmstate_register_named
>   migration: vmstate_unregister_named
>   migration: vmstate_register at init time
>   migration: vmstate factory object
>   physmem: ram_block_create
>   physmem: hoist guest_memfd creation
>   physmem: hoist host memory allocation
>   physmem: set ram block idstr earlier
>   machine: memfd-alloc option
>   migration: cpr-exec-args parameter
>   physmem: preserve ram blocks for cpr
>   migration: cpr-exec mode
>   migration: migrate_add_blocker_mode
>   migration: ram block cpr-exec blockers
>   migration: misc cpr-exec blockers
>   seccomp: cpr-exec blocker
>   migration: fix mismatched GPAs during cpr-exec
>   migration: only-migratable-modes
>
>  accel/xen/xen-all.c            |   5 +
>  backends/hostmem-epc.c         |  12 +-
>  hmp-commands.hx                |   2 +-
>  hw/core/machine.c              |  22 +++
>  hw/core/qdev.c                 |   1 +
>  hw/intc/apic_common.c          |   2 +-
>  hw/vfio/migration.c            |   3 +-
>  include/exec/cpu-common.h      |   3 +-
>  include/exec/memory.h          |  15 ++
>  include/exec/ramblock.h        |  10 +-
>  include/hw/boards.h            |   1 +
>  include/migration/blocker.h    |   7 +
>  include/migration/cpr.h        |  14 ++
>  include/migration/misc.h       |  11 ++
>  include/migration/vmstate.h    | 133 +++++++++++++++-
>  include/qemu/osdep.h           |   9 ++
>  include/sysemu/runstate.h      |   3 +
>  include/sysemu/seccomp.h       |   1 +
>  include/sysemu/sysemu.h        |   1 -
>  migration/cpr.c                | 131 ++++++++++++++++
>  migration/meson.build          |   3 +
>  migration/migration-hmp-cmds.c |  50 +++++-
>  migration/migration.c          |  48 +++++-
>  migration/migration.h          |   5 +-
>  migration/options.c            |  13 ++
>  migration/precreate.c          | 139 +++++++++++++++++
>  migration/ram.c                |  16 +-
>  migration/savevm.c             | 306 +++++++++++++++++++++++++++++-------
>  migration/savevm.h             |   3 +
>  migration/trace-events         |   7 +
>  migration/vmstate-factory.c    |  78 ++++++++++
>  migration/vmstate-types.c      |  24 +++
>  migration/vmstate.c            |   3 +-
>  qapi/migration.json            |  48 +++++-
>  qemu-options.hx                |  22 ++-
>  replay/replay.c                |   6 +
>  stubs/migr-blocker.c           |   5 +
>  stubs/vmstate.c                |  13 ++
>  system/globals.c               |   1 -
>  system/memory.c                |  19 ++-
>  system/physmem.c               | 346 +++++++++++++++++++++++++++--------------
>  system/qemu-seccomp.c          |  10 +-
>  system/runstate.c              |  29 ++++
>  system/trace-events            |   4 +
>  system/vl.c                    |  26 +++-
>  target/s390x/cpu_models.c      |   4 +-
>  util/oslib-posix.c             |   9 ++
>  util/oslib-win32.c             |   4 +
>  48 files changed, 1417 insertions(+), 210 deletions(-)
>  create mode 100644 include/migration/cpr.h
>  create mode 100644 migration/cpr.c
>  create mode 100644 migration/precreate.c
>  create mode 100644 migration/vmstate-factory.c

Hi Steve,

make check is failing. I applied the series on top of master @
70581940ca (Merge tag 'pull-tcg-20240523' of
https://gitlab.com/rth7680/qemu into staging, 2024-05-23).

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/ivshmem-test
...
qemu-system-x86_64: ../system/physmem.c:1634: qemu_ram_verify_idstr:
Assertion `!strcmp(new_block->idstr, idstr)' failed.

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 \
./tests/qtest/test-x86-cpuid-compat -p \
/x86_64/x86/cpuid/auto-level/pc-2.7
...
qemu-system-x86_64: ../system/physmem.c:1634: qemu_ram_verify_idstr:
Assertion `!strcmp(new_block->idstr, idstr)' failed.

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/qmp-cmd-test -p \
/x86_64/qmp/object-add-failure-modes
...
savevm_state_handler_insert: Detected duplicate SaveStateEntry:
id=ram1/RAMBlock, instance_id=0x0

