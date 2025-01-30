Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8E6C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 10:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdRUI-00027E-Qx; Thu, 30 Jan 2025 05:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUH-000271-EN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:09:29 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRUE-00071N-Oh
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 05:09:29 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tdRTy-00000006Tw2-3tNT; Thu, 30 Jan 2025 11:09:10 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 00/33] Multifd 🔀 device state transfer support with VFIO consumer
Date: Thu, 30 Jan 2025 11:08:21 +0100
Message-ID: <cover.1738171076.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.037, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This is an updated v4 patch series of the v3 series located here:
https://lore.kernel.org/qemu-devel/cover.1731773021.git.maciej.szmigiero@oracle.com/

Changes from v3:
* MigrationLoadThread now returns bool and an Error complex error type
instead of just an int.

* qemu_loadvm_load_thread_pool now reports error via migrate_set_error()
instead of dedicated load_threads_ret variable.

* Since the change above uncovered an issue with respect to multifd send
channels not terminating TLS session properly QIOChannelTLS now allows
gracefully handling this situation.

* qemu_loadvm_load_thread_pool state is now part of MigrationIncomingState
instead of being stored in global variables.
This state now also has its own init/cleanup helpers.

* qemu_loadvm_load_thread_pool code is now moved into a separate section
of the savevm.c file, marked by an appropriate comment.

* thread_pool_free() is now documented to have wait-before-free semantic,
which allowed removal of explicit waits from thread pool cleanup paths.

* thread_pool_submit_immediate() method was added since this functionality
is used by both generic thread pool users in this patch set.

* postcopy_ram_listen_thread() now takes BQL around function calls that
ultimately call migration methods requiring BQL.
This fixes one of QEMU tests failing when explicitly BQL-sensitive code
is added later to these methods.

* qemu_loadvm_load_state_buffer() now returns a bool value instead of int.

* "Send final SYNC only after device state is complete" patch was
dropped since Peter implemented equivalent functionality upstream.

* "Document the BQL behavior of load SaveVMHandlers" patch was dropped
since that's something better done later, separately from this patch set.

* Header size is now added to mig_stats.multifd_bytes where it is actually
sent in the zero copy case - in multifd_nocomp_send_prepare().

* Spurious wakeups from qemu_cond_wait() are now handled properly as
pointed out by Avihai.

* VFIO migration FD now allows partial write() completion as pointed out
by Avihai.

* Patch "vfio/migration: Don't run load cleanup if load setup didn't run"
was dropped, instead all objects related to multifd load are now located in
their own VFIOMultifd struct which is allocated only if multifd device state
transfer is actually in use.

* Intermediate VFIOStateBuffers API as suggested by Avihai is now introduced
to simplify vfio_load_state_buffer() and vfio_load_bufs_thread().

* Optional VFIO device config state loading interlocking with loading
other iterables is now possible due to ARM64 platform VFIO dependency on
interrupt controller being loaded first as pointed out by Avihai.

* Patch "Multifd device state transfer support - receive side" was split
into a few smaller patches as suggested by Cédric.

* x-migration-multifd-transfer VFIO property compat changes were moved
into a separate patch as suggested by Cédric.

* Other small changes, like renamed functions and variables/members, added
review tags, code formatting, moved QEMU_LOCK_GUARD() instances closer to
actual protected blocks, etc.

========================================================================

This patch set is targeting QEMU 10.0.

What's not yet present is documentation update under docs/devel/migration
but I didn't want to delay posting the code any longer.
Such doc can still be merged later when the design is 100% finalized.

========================================================================

Maciej S. Szmigiero (32):
  migration: Clarify that {load,save}_cleanup handlers can run without
    setup
  thread-pool: Remove thread_pool_submit() function
  thread-pool: Rename AIO pool functions to *_aio() and data types to
    *Aio
  thread-pool: Implement generic (non-AIO) pool support
  migration: Add MIG_CMD_SWITCHOVER_START and its load handler
  migration: Add qemu_loadvm_load_state_buffer() and its handler
  io: tls: Allow terminating the TLS session gracefully with EOF
  migration/multifd: Allow premature EOF on TLS incoming channels
  migration: postcopy_ram_listen_thread() needs to take BQL for some
    calls
  error: define g_autoptr() cleanup function for the Error type
  migration: Add thread pool of optional load threads
  migration/multifd: Split packet into header and RAM data
  migration/multifd: Device state transfer support - receive side
  migration/multifd: Make multifd_send() thread safe
  migration/multifd: Add an explicit MultiFDSendData destructor
  migration/multifd: Device state transfer support - send side
  migration/multifd: Add multifd_device_state_supported()
  migration: Add save_live_complete_precopy_thread handler
  vfio/migration: Add x-migration-load-config-after-iter VFIO property
  vfio/migration: Add load_device_config_state_start trace event
  vfio/migration: Convert bytes_transferred counter to atomic
  vfio/migration: Multifd device state transfer support - basic types
  vfio/migration: Multifd device state transfer support -
    VFIOStateBuffer(s)
  vfio/migration: Multifd device state transfer - add support checking
    function
  vfio/migration: Multifd device state transfer support - receive
    init/cleanup
  vfio/migration: Multifd device state transfer support - received
    buffers queuing
  vfio/migration: Multifd device state transfer support - load thread
  vfio/migration: Multifd device state transfer support - config loading
    support
  migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
  vfio/migration: Multifd device state transfer support - send side
  vfio/migration: Add x-migration-multifd-transfer VFIO property
  hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
    property

Peter Xu (1):
  migration/multifd: Make MultiFDSendData a struct

 hw/core/machine.c                  |   2 +
 hw/vfio/migration.c                | 754 ++++++++++++++++++++++++++++-
 hw/vfio/pci.c                      |  14 +
 hw/vfio/trace-events               |  11 +-
 include/block/aio.h                |   8 +-
 include/block/thread-pool.h        |  62 ++-
 include/hw/vfio/vfio-common.h      |   7 +
 include/io/channel-tls.h           |  11 +
 include/migration/client-options.h |   4 +
 include/migration/misc.h           |  16 +
 include/migration/register.h       |  54 ++-
 include/qapi/error.h               |   2 +
 include/qemu/typedefs.h            |   6 +
 io/channel-tls.c                   |   6 +
 migration/colo.c                   |   3 +
 migration/meson.build              |   1 +
 migration/migration-hmp-cmds.c     |   2 +
 migration/migration.c              |   6 +-
 migration/migration.h              |   7 +
 migration/multifd-device-state.c   | 192 ++++++++
 migration/multifd-nocomp.c         |  30 +-
 migration/multifd.c                | 248 ++++++++--
 migration/multifd.h                |  74 ++-
 migration/options.c                |   9 +
 migration/qemu-file.h              |   2 +
 migration/savevm.c                 | 195 +++++++-
 migration/savevm.h                 |   6 +-
 migration/trace-events             |   1 +
 scripts/analyze-migration.py       |  11 +
 tests/unit/test-thread-pool.c      |   6 +-
 util/async.c                       |   6 +-
 util/thread-pool.c                 | 184 +++++--
 util/trace-events                  |   6 +-
 33 files changed, 1814 insertions(+), 132 deletions(-)
 create mode 100644 migration/multifd-device-state.c


