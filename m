Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B5BC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaNn-0007tR-3L; Tue, 04 Mar 2025 17:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNk-0007rD-SU
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:04:56 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNi-0000Hx-6M
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:04:56 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaNb-00000000LWQ-1MTn; Tue, 04 Mar 2025 23:04:47 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 00/36] =?UTF-8?q?Multifd=20=F0=9F=94=80=20device=20stat?=
 =?UTF-8?q?e=20transfer=20support=20with=20VFIO=20consumer?=
Date: Tue,  4 Mar 2025 23:03:27 +0100
Message-ID: <cover.1741124640.git.maciej.szmigiero@oracle.com>
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
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This is an updated v6 patch series of the v5 series located here:
https://lore.kernel.org/qemu-devel/cover.1739994627.git.maciej.szmigiero@oracle.com/

What this patch set is about?
Current live migration device state transfer is done via the main (single)
migration channel, which reduces performance and severally impacts the
migration downtime for VMs having large device state that needs to be
transferred during the switchover phase.

Example devices that have such large switchover phase device state are some
types of VFIO SmartNICs and GPUs.

This patch set allows parallelizing this transfer by using multifd channels
for it.
It also introduces new load and save threads per VFIO device for decoupling
these operations from the main migration thread.
These threads run on newly introduced generic (non-AIO) thread pools,
instantiated by the core migration core.

Changes from v5:
* Add bql_locked() assertion to migration_incoming_state_destroy() with a
comment describing why holding BQL there is necessary.

* Add SPDX-License-Identifier to newly added files.

* Move consistency of multfd transfer settings check to the patch adding
x-migration-multifd-transfer property.

* Change packet->idx == UINT32_MAX message to the suggested one.

* Use WITH_QEMU_LOCK_GUARD() in vfio_load_state_buffer().

* Add vfio_load_bufs_thread_{start,end} trace events.

* Invert "ret" value computation logic in vfio_load_bufs_thread() and
  vfio_multifd_save_complete_precopy_thread() - initialize "ret" to false
  at definition, remove "ret = false" at every failure/early exit block and
  add "ret = true" just before the early exit jump label.

* Make vfio_load_bufs_thread_load_config() return a bool and take an
  "Error **" parameter.

* Make vfio_multifd_setup() (previously called vfio_multifd_transfer_setup())
  allocate struct VFIOMultifd if requested by "alloc_multifd" parameter.

* Add vfio_multifd_cleanup() call to vfio_save_cleanup() (for consistency
  with the load code), with a comment describing that it is currently a NOP
  there.

* Move vfio_multifd_cleanup() to migration-multifd.c.

* Move general multifd migration description in docs/devel/migration/vfio.rst
  from the top section to new "Multifd" section at the bottom.

* Add comment describing why x-migration-multifd-transfer needs to be
  a custom property above the variable containing that custom property type
  in register_vfio_pci_dev_type().

* Add object_class_property_set_description() description for all 3 newly
  added parameters: x-migration-multifd-transfer,
  x-migration-load-config-after-iter and x-migration-max-queued-buffers.

* Split out wiring vfio_multifd_setup() and vfio_multifd_cleanup() into
  general VFIO load/save setup and cleanup methods into a brand new
  patch/commit.

* Squash the patch introducing VFIOStateBuffer(s) into the "received buffers
  queuing" commit to fix building the interim code form at the time of this
  patch with "-Werror".
  
* Change device state packet "idstr" field to NULL-terminated and drop
  QEMU_NONSTRING marking from its definition.

* Add vbasedev->name to VFIO error messages to know which device caused
  that error.

* Move BQL lock ordering assert closer to the other lock in the lock order
  in vfio_load_state_buffer().

* Drop orphan "QemuThread load_bufs_thread" VFIOMultifd member leftover
  from the days of the version 2 of this patch set.

* Change "guint" into an "unsigned int" where it was present in this
  patch set.

* Use g_autoptr() for QEMUFile also in vfio_load_bufs_thread_load_config().

* Call multifd_abort_device_state_save_threads() if a migration error is
  already set in the save path to avoid needlessly waiting for the remaining
  threads to do all of their normal work.

* Other minor changes that should not have functional impact, like:
  renamed functions/labels, moved code lines between patches contained
  in this patch set, added review tags, code formatting, rebased on top
  of the latest QEMU git master, etc.

========================================================================

This patch set is targeting QEMU 10.0.

It is also exported as a git tree:
https://gitlab.com/maciejsszmigiero/qemu/-/commits/multifd-device-state-transfer-vfio

========================================================================

Maciej S. Szmigiero (35):
  migration: Clarify that {load,save}_cleanup handlers can run without
    setup
  thread-pool: Remove thread_pool_submit() function
  thread-pool: Rename AIO pool functions to *_aio() and data types to
    *Aio
  thread-pool: Implement generic (non-AIO) pool support
  migration: Add MIG_CMD_SWITCHOVER_START and its load handler
  migration: Add qemu_loadvm_load_state_buffer() and its handler
  migration: postcopy_ram_listen_thread() should take BQL for some calls
  error: define g_autoptr() cleanup function for the Error type
  migration: Add thread pool of optional load threads
  migration/multifd: Split packet into header and RAM data
  migration/multifd: Device state transfer support - receive side
  migration/multifd: Make multifd_send() thread safe
  migration/multifd: Add an explicit MultiFDSendData destructor
  migration/multifd: Device state transfer support - send side
  migration/multifd: Add multifd_device_state_supported()
  migration: Add save_live_complete_precopy_thread handler
  vfio/migration: Add load_device_config_state_start trace event
  vfio/migration: Convert bytes_transferred counter to atomic
  vfio/migration: Add vfio_add_bytes_transferred()
  vfio/migration: Move migration channel flags to vfio-common.h header
    file
  vfio/migration: Multifd device state transfer support - basic types
  vfio/migration: Multifd device state transfer - add support checking
    function
  vfio/migration: Multifd setup/cleanup functions and associated
    VFIOMultifd
  vfio/migration: Setup and cleanup multifd transfer in these general
    methods
  vfio/migration: Multifd device state transfer support - received
    buffers queuing
  vfio/migration: Multifd device state transfer support - load thread
  migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
  vfio/migration: Multifd device state transfer support - config loading
    support
  vfio/migration: Multifd device state transfer support - send side
  vfio/migration: Add x-migration-multifd-transfer VFIO property
  vfio/migration: Make x-migration-multifd-transfer VFIO property
    mutable
  hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
    property
  vfio/migration: Max in-flight VFIO device state buffer count limit
  vfio/migration: Add x-migration-load-config-after-iter VFIO property
  vfio/migration: Update VFIO migration documentation

Peter Xu (1):
  migration/multifd: Make MultiFDSendData a struct

 docs/devel/migration/vfio.rst      |  79 ++-
 hw/core/machine.c                  |   2 +
 hw/vfio/meson.build                |   1 +
 hw/vfio/migration-multifd.c        | 786 +++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h        |  37 ++
 hw/vfio/migration.c                | 111 ++--
 hw/vfio/pci.c                      |  40 ++
 hw/vfio/trace-events               |  13 +-
 include/block/aio.h                |   8 +-
 include/block/thread-pool.h        |  62 ++-
 include/hw/vfio/vfio-common.h      |  34 ++
 include/migration/client-options.h |   4 +
 include/migration/misc.h           |  25 +
 include/migration/register.h       |  52 +-
 include/qapi/error.h               |   2 +
 include/qemu/typedefs.h            |   5 +
 migration/colo.c                   |   3 +
 migration/meson.build              |   1 +
 migration/migration-hmp-cmds.c     |   2 +
 migration/migration.c              |  20 +-
 migration/migration.h              |   7 +
 migration/multifd-device-state.c   | 212 ++++++++
 migration/multifd-nocomp.c         |  30 +-
 migration/multifd.c                | 248 +++++++--
 migration/multifd.h                |  74 ++-
 migration/options.c                |   9 +
 migration/qemu-file.h              |   2 +
 migration/savevm.c                 | 201 +++++++-
 migration/savevm.h                 |   6 +-
 migration/trace-events             |   1 +
 scripts/analyze-migration.py       |  11 +
 tests/unit/test-thread-pool.c      |   6 +-
 util/async.c                       |   6 +-
 util/thread-pool.c                 | 184 +++++--
 util/trace-events                  |   6 +-
 35 files changed, 2125 insertions(+), 165 deletions(-)
 create mode 100644 hw/vfio/migration-multifd.c
 create mode 100644 hw/vfio/migration-multifd.h
 create mode 100644 migration/multifd-device-state.c


