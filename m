Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE619C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 20:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkqmJ-0000Zg-Ae; Wed, 19 Feb 2025 15:34:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqmH-0000YO-ER
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:34:41 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqmE-0004K9-Sy
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 15:34:41 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tkqm0-00000007VRQ-34s5; Wed, 19 Feb 2025 21:34:24 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v5 00/36] =?UTF-8?q?Multifd=20=F0=9F=94=80=20device=20stat?=
 =?UTF-8?q?e=20transfer=20support=20with=20VFIO=20consumer?=
Date: Wed, 19 Feb 2025 21:33:42 +0100
Message-ID: <cover.1739994627.git.maciej.szmigiero@oracle.com>
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

This is an updated v5 patch series of the v4 series located here:
https://lore.kernel.org/qemu-devel/cover.1738171076.git.maciej.szmigiero@oracle.com/

Changes from v3:
* Use "unsigned long" for VFIO bytes transferred counter to fixes
test issues on 32-bit platforms.

* Instead of adding BQL holding around qemu_loadvm_state_main() in
postcopy_ram_listen_thread() just add a TODO comment there.

* Drop patches for gracefully handling improperly terminated TLS session
and rely on recent Fabiano's changes to handle this case instead.

* Adapt how MULTIFD_FLAG_DEVICE_STATE value is defined for consistency with
neighboring flags.

* Return Error type and use migrate_set_error() to set it also for save
threads, much like it was previously done for load threads.

* Export SaveLiveCompletePrecopyThreadData and make save threads
take it directly instead of passing individual parameters stored there
to a thread entry point.

* Group all multifd device state save variables in
multifd_send_device_state variable allocated on demand instead of
using multifd-device-state.c globals.

* Export save threads abort flag via
multifd_device_state_save_thread_should_exit() getter function rather
than passing it directly.

* Separate VFIO multifd stuff into migration-multifd.{c,h} files.
Needed moving VFIO migration channel flags to vfio-common.h header file.

* Move x-migration-load-config-after-iter feature to a separate patch near
the end of the series.

* Move x-migration-max-queued-buffers feature to a yet another separate
patch near the end of the series.

* Introduce save/load common vfio_multifd_transfer_setup() and a getter
function for multifd transfer switch called vfio_multifd_transfer_enabled().

* Move introduction of VFIOMigration->multifd_transfer and
VFIODevice->migration_multifd_transfer into the very patch that introduces
the x-migration-multifd-transfer property.

* Introduce vfio_multifd_cleanup() for clearing migration->multifd.

* Split making x-migration-multifd-transfer mutable at runtime into
a separate patch.

* Rename vfio_switchover_start() to vfio_multifd_switchover_start() and
add a new vfio_switchover_start() in migration.c that calls that
vfio_multifd_switchover_start().

* Introduce VFIO_DEVICE_STATE_PACKET_VER_CURRENT.

* Don't print UINT32_MAX value in vfio_load_state_buffer().

* Introduce a new routine for parsing VFIO_MIG_FLAG_DEV_CONFIG_LOAD_READY.

* Add an Error parameter to vfio_save_complete_precopy_thread_config_state()
and propagate it from vfio_save_device_config_state() function that it calls.

* Update the VFIO developer doc in docs/devel/migration/vfio.rst.

* Add comments about how VFIO multifd threads are launched and from where
this happens. Also add comments how they are terminated.

* Other small changes, like renamed functions, added review tags, code
formatting, rebased on top of the latest QEMU git master, etc.

========================================================================

This patch set is targeting QEMU 10.0.

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
  vfio/migration: Make x-migration-multifd-transfer VFIO property
    mutable
  hw/core/machine: Add compat for x-migration-multifd-transfer VFIO
    property
  vfio/migration: Max in-flight VFIO device state buffer count limit
  vfio/migration: Add x-migration-load-config-after-iter VFIO property
  vfio/migration: Update VFIO migration documentation

Peter Xu (1):
  migration/multifd: Make MultiFDSendData a struct

 docs/devel/migration/vfio.rst      |  80 ++-
 hw/core/machine.c                  |   2 +
 hw/vfio/meson.build                |   1 +
 hw/vfio/migration-multifd.c        | 757 +++++++++++++++++++++++++++++
 hw/vfio/migration-multifd.h        |  38 ++
 hw/vfio/migration.c                | 119 +++--
 hw/vfio/pci.c                      |  14 +
 hw/vfio/trace-events               |  11 +-
 include/block/aio.h                |   8 +-
 include/block/thread-pool.h        |  62 ++-
 include/hw/vfio/vfio-common.h      |  36 ++
 include/migration/client-options.h |   4 +
 include/migration/misc.h           |  25 +
 include/migration/register.h       |  52 +-
 include/qapi/error.h               |   2 +
 include/qemu/typedefs.h            |   5 +
 migration/colo.c                   |   3 +
 migration/meson.build              |   1 +
 migration/migration-hmp-cmds.c     |   2 +
 migration/migration.c              |   4 +-
 migration/migration.h              |   7 +
 migration/multifd-device-state.c   | 202 ++++++++
 migration/multifd-nocomp.c         |  30 +-
 migration/multifd.c                | 246 ++++++++--
 migration/multifd.h                |  74 ++-
 migration/options.c                |   9 +
 migration/qemu-file.h              |   2 +
 migration/savevm.c                 | 190 +++++++-
 migration/savevm.h                 |   6 +-
 migration/trace-events             |   1 +
 scripts/analyze-migration.py       |  11 +
 tests/unit/test-thread-pool.c      |   6 +-
 util/async.c                       |   6 +-
 util/thread-pool.c                 | 184 +++++--
 util/trace-events                  |   6 +-
 35 files changed, 2039 insertions(+), 167 deletions(-)
 create mode 100644 hw/vfio/migration-multifd.c
 create mode 100644 hw/vfio/migration-multifd.h
 create mode 100644 migration/multifd-device-state.c


