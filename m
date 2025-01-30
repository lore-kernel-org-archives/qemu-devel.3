Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF7FC02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 20:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdb0j-0006QL-2D; Thu, 30 Jan 2025 15:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdb0g-0006Q1-Mn
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:19:34 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdb0d-0002ZI-AK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:19:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 261711F383;
 Thu, 30 Jan 2025 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738268369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIF35piKTAlPxO2Ny9a5MgZD3SPHllXh/UHx/MXQx88=;
 b=nO/TIwFbNUUdBJifZO/V9v/WVKxCq0wy64A5yOBbQKVRMQcnfjCITttQh4X0KUcOh/+NCg
 VGzMdC9Fa4nMvZIGkBLXOmP7RWTkGT2svnJrpP//FWnuqdPHwLjZRtPnneSSu7AUg/Fi8J
 rZZ6QZwqEGhgjtIl3Kr2vAxd+YKXAao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738268369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIF35piKTAlPxO2Ny9a5MgZD3SPHllXh/UHx/MXQx88=;
 b=PXDo78NxPGlvEGgtE3V5p8ysNuPy92eqVBEZ6ith9/3cibebSTKk4+dbtMKNYQqKG3FvOA
 EZL/SqP2mNdtOZDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nO/TIwFb";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PXDo78Nx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738268369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIF35piKTAlPxO2Ny9a5MgZD3SPHllXh/UHx/MXQx88=;
 b=nO/TIwFbNUUdBJifZO/V9v/WVKxCq0wy64A5yOBbQKVRMQcnfjCITttQh4X0KUcOh/+NCg
 VGzMdC9Fa4nMvZIGkBLXOmP7RWTkGT2svnJrpP//FWnuqdPHwLjZRtPnneSSu7AUg/Fi8J
 rZZ6QZwqEGhgjtIl3Kr2vAxd+YKXAao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738268369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIF35piKTAlPxO2Ny9a5MgZD3SPHllXh/UHx/MXQx88=;
 b=PXDo78NxPGlvEGgtE3V5p8ysNuPy92eqVBEZ6ith9/3cibebSTKk4+dbtMKNYQqKG3FvOA
 EZL/SqP2mNdtOZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8210B1366F;
 Thu, 30 Jan 2025 20:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q433D9Dem2eFVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 30 Jan 2025 20:19:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4 00/33] Multifd =?utf-8?Q?=F0=9F=94=80?= device state
 transfer support with VFIO consumer
In-Reply-To: <cover.1738171076.git.maciej.szmigiero@oracle.com>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
Date: Thu, 30 Jan 2025 17:19:25 -0300
Message-ID: <87tt9gkqb6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 261711F383
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This is an updated v4 patch series of the v3 series located here:
> https://lore.kernel.org/qemu-devel/cover.1731773021.git.maciej.szmigiero@=
oracle.com/
>
> Changes from v3:
> * MigrationLoadThread now returns bool and an Error complex error type
> instead of just an int.
>
> * qemu_loadvm_load_thread_pool now reports error via migrate_set_error()
> instead of dedicated load_threads_ret variable.
>
> * Since the change above uncovered an issue with respect to multifd send
> channels not terminating TLS session properly QIOChannelTLS now allows
> gracefully handling this situation.
>
> * qemu_loadvm_load_thread_pool state is now part of MigrationIncomingState
> instead of being stored in global variables.
> This state now also has its own init/cleanup helpers.
>
> * qemu_loadvm_load_thread_pool code is now moved into a separate section
> of the savevm.c file, marked by an appropriate comment.
>
> * thread_pool_free() is now documented to have wait-before-free semantic,
> which allowed removal of explicit waits from thread pool cleanup paths.
>
> * thread_pool_submit_immediate() method was added since this functionality
> is used by both generic thread pool users in this patch set.
>
> * postcopy_ram_listen_thread() now takes BQL around function calls that
> ultimately call migration methods requiring BQL.
> This fixes one of QEMU tests failing when explicitly BQL-sensitive code
> is added later to these methods.
>
> * qemu_loadvm_load_state_buffer() now returns a bool value instead of int.
>
> * "Send final SYNC only after device state is complete" patch was
> dropped since Peter implemented equivalent functionality upstream.
>
> * "Document the BQL behavior of load SaveVMHandlers" patch was dropped
> since that's something better done later, separately from this patch set.
>
> * Header size is now added to mig_stats.multifd_bytes where it is actually
> sent in the zero copy case - in multifd_nocomp_send_prepare().
>
> * Spurious wakeups from qemu_cond_wait() are now handled properly as
> pointed out by Avihai.
>
> * VFIO migration FD now allows partial write() completion as pointed out
> by Avihai.
>
> * Patch "vfio/migration: Don't run load cleanup if load setup didn't run"
> was dropped, instead all objects related to multifd load are now located =
in
> their own VFIOMultifd struct which is allocated only if multifd device st=
ate
> transfer is actually in use.
>
> * Intermediate VFIOStateBuffers API as suggested by Avihai is now introdu=
ced
> to simplify vfio_load_state_buffer() and vfio_load_bufs_thread().
>
> * Optional VFIO device config state loading interlocking with loading
> other iterables is now possible due to ARM64 platform VFIO dependency on
> interrupt controller being loaded first as pointed out by Avihai.
>
> * Patch "Multifd device state transfer support - receive side" was split
> into a few smaller patches as suggested by C=C3=A9dric.
>
> * x-migration-multifd-transfer VFIO property compat changes were moved
> into a separate patch as suggested by C=C3=A9dric.
>
> * Other small changes, like renamed functions and variables/members, added
> review tags, code formatting, moved QEMU_LOCK_GUARD() instances closer to
> actual protected blocks, etc.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This patch set is targeting QEMU 10.0.
>
> What's not yet present is documentation update under docs/devel/migration
> but I didn't want to delay posting the code any longer.
> Such doc can still be merged later when the design is 100% finalized.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Maciej S. Szmigiero (32):
>   migration: Clarify that {load,save}_cleanup handlers can run without
>     setup
>   thread-pool: Remove thread_pool_submit() function
>   thread-pool: Rename AIO pool functions to *_aio() and data types to
>     *Aio
>   thread-pool: Implement generic (non-AIO) pool support
>   migration: Add MIG_CMD_SWITCHOVER_START and its load handler
>   migration: Add qemu_loadvm_load_state_buffer() and its handler
>   io: tls: Allow terminating the TLS session gracefully with EOF
>   migration/multifd: Allow premature EOF on TLS incoming channels
>   migration: postcopy_ram_listen_thread() needs to take BQL for some
>     calls
>   error: define g_autoptr() cleanup function for the Error type
>   migration: Add thread pool of optional load threads
>   migration/multifd: Split packet into header and RAM data
>   migration/multifd: Device state transfer support - receive side
>   migration/multifd: Make multifd_send() thread safe
>   migration/multifd: Add an explicit MultiFDSendData destructor
>   migration/multifd: Device state transfer support - send side
>   migration/multifd: Add multifd_device_state_supported()
>   migration: Add save_live_complete_precopy_thread handler
>   vfio/migration: Add x-migration-load-config-after-iter VFIO property
>   vfio/migration: Add load_device_config_state_start trace event
>   vfio/migration: Convert bytes_transferred counter to atomic
>   vfio/migration: Multifd device state transfer support - basic types
>   vfio/migration: Multifd device state transfer support -
>     VFIOStateBuffer(s)
>   vfio/migration: Multifd device state transfer - add support checking
>     function
>   vfio/migration: Multifd device state transfer support - receive
>     init/cleanup
>   vfio/migration: Multifd device state transfer support - received
>     buffers queuing
>   vfio/migration: Multifd device state transfer support - load thread
>   vfio/migration: Multifd device state transfer support - config loading
>     support
>   migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
>   vfio/migration: Multifd device state transfer support - send side
>   vfio/migration: Add x-migration-multifd-transfer VFIO property
>   hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
>     property
>
> Peter Xu (1):
>   migration/multifd: Make MultiFDSendData a struct
>
>  hw/core/machine.c                  |   2 +
>  hw/vfio/migration.c                | 754 ++++++++++++++++++++++++++++-
>  hw/vfio/pci.c                      |  14 +
>  hw/vfio/trace-events               |  11 +-
>  include/block/aio.h                |   8 +-
>  include/block/thread-pool.h        |  62 ++-
>  include/hw/vfio/vfio-common.h      |   7 +
>  include/io/channel-tls.h           |  11 +
>  include/migration/client-options.h |   4 +
>  include/migration/misc.h           |  16 +
>  include/migration/register.h       |  54 ++-
>  include/qapi/error.h               |   2 +
>  include/qemu/typedefs.h            |   6 +
>  io/channel-tls.c                   |   6 +
>  migration/colo.c                   |   3 +
>  migration/meson.build              |   1 +
>  migration/migration-hmp-cmds.c     |   2 +
>  migration/migration.c              |   6 +-
>  migration/migration.h              |   7 +
>  migration/multifd-device-state.c   | 192 ++++++++
>  migration/multifd-nocomp.c         |  30 +-
>  migration/multifd.c                | 248 ++++++++--
>  migration/multifd.h                |  74 ++-
>  migration/options.c                |   9 +
>  migration/qemu-file.h              |   2 +
>  migration/savevm.c                 | 195 +++++++-
>  migration/savevm.h                 |   6 +-
>  migration/trace-events             |   1 +
>  scripts/analyze-migration.py       |  11 +
>  tests/unit/test-thread-pool.c      |   6 +-
>  util/async.c                       |   6 +-
>  util/thread-pool.c                 | 184 +++++--
>  util/trace-events                  |   6 +-
>  33 files changed, 1814 insertions(+), 132 deletions(-)
>  create mode 100644 migration/multifd-device-state.c

Hi!

We have build issues:

https://gitlab.com/farosas/qemu/-/pipelines/1649146958

And the postcopy/recovery test is failing. It seems the migration
finishes before the test can issue migrate-pause:

QTEST_QEMU_BINARY=3D./qemu-system-x86_64  ./tests/qtest/migration-test -p
/x86_64/migration/postcopy/recovery/plain
...
{"execute": "migrate-start-postcopy"}
{"return": {}}
{"secs": 1738267018, "usecs": 860991}, "event": "MIGRATION", "data": {"stat=
us": "postcopy-active"}
{"secs": 1738267018, "usecs": 861284}, "event": "STOP"
{"secs": 1738267017, "usecs": 960322}, "event": "MIGRATION", "data": {"stat=
us": "active"}
{"secs": 1738267018, "usecs": 865589}, "event": "MIGRATION", "data": {"stat=
us": "postcopy-active"}
{"secs": 1738267099, "usecs": 120971}, "event": "MIGRATION", "data": {"stat=
us": "completed"}
{"secs": 1738267099, "usecs": 121154}, "event": "RESUME"
{"execute": "query-migrate"}

ERROR:../tests/qtest/migration/migration-qmp.c:172:check_migration_status:
assertion failed (current_status !=3D "completed"): ("completed" !=3D
"completed")


