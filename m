Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5ABD10F26
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 19:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCkpx-0002es-O0; Sun, 17 Nov 2024 14:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpq-0002dw-WD
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:28 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpo-0005q0-RQ
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 14:21:26 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tCkpY-00000002GSf-3Bhz; Sun, 17 Nov 2024 20:21:08 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: =?UTF-8?q?=5BPATCH=20v3=2000/24=5D=20Multifd=20=F0=9F=94=80=20device=20state=20transfer=20support=20with=20VFIO=20consumer?=
Date: Sun, 17 Nov 2024 20:19:55 +0100
Message-ID: <cover.1731773021.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This is an updated v3 patch series of the v2 series located here:
https://lore.kernel.org/qemu-devel/cover.1724701542.git.maciej.szmigiero@oracle.com/

Changes from v2:
* Reworked the non-AIO (generic) thread pool to use Glib's GThreadPool
instead of making the current QEMU AIO thread pool generic.

* Added QEMU_VM_COMMAND MIG_CMD_SWITCHOVER_START sub-command to the
migration bit stream protocol via migration compatibility flag.
Used this new bit stream sub-command to achieve barrier between main
migration channel device state data and multifd device state data instead
of introducing save_live_complete_precopy_{begin,end} handlers for that as
the previous patch set version did,

* Added a new migration core thread pool of optional load threads and used
it to implement VFIO load thread instead of introducing load_finish handler
as the previous patch set version did.

* Made VFIO device config state load operation happen from that device load
thread instead of from (now gone) load_finish handler that did such load on
the main migration thread.
In the future this may allow pushing BQL deeper into the device config
state load operation internals and so doing more of it in parallel.

* Switched multifd_send() to using a serializing mutex for thread safety
instead of atomics as suggested by Peter since this seems to not cause
any performance regression while being simpler.

* Added two patches improving SaveVMHandlers documentation: one documenting
the BQL behavior of load SaveVMHandlers, another one explaining
{load,save}_cleanup handlers semantics.

* Added Peter's proposed patch making MultiFDSendData a struct from
https://lore.kernel.org/qemu-devel/ZuCickYhs3nf2ERC@x1n/
Other two patches from that message bring no performance benefits so they
were skipped (as discussed in that e-mail thread).

* Switched x-migration-multifd-transfer VFIO property to tri-state (On,
Off, Auto), with Auto being now the default value.
This means hat VFIO device state transfer via multifd channels is
automatically attempted in configurations that otherwise support it.
Note that in this patch set version (in contrast with the previous version)
x-migration-multifd-transfer setting is meaningful both on source AND
destination QEMU.

* Fixed a race condition with respect to the final multifd channel SYNC
packet sent by the RAM transfer code.

* Made VFIO's bytes_transferred counter atomic since it is accessed from
multiple threads (thanks Avihai for spotting it).

* Fixed an issue where VFIO device config sender QEMUFile wouldn't be
closed in some error conditions, switched to QEMUFile g_autoptr() automatic
memory management there to avoid such bugs in the future (also thanks
to Avihai for spotting the issue).

* Many, MANY small changes, like renamed functions, added review tags,
locks annotations, code formatting, split out changes into separate
commits, etc.

* Redid benchmarks.

========================================================================

Benchmark results:
These are 25th percentile of downtime results from 70-100 back-and-forth
live migrations with the same VM config (guest wasn't restarted during
these migrations).

Previous benchmarks reported the lowest downtime results ("0th percentile")
instead but these were subject to variation due to often being one of
outliers.

The used setup for bechmarking was the same as the RFC version of patch set
used.


Results with 6 multifd channels:
            4 VFs   2 VFs    1 VF
Disabled: 1900 ms  859 ms  487 ms
Enabled:  1095 ms  556 ms  366 ms 

Results with 4 VFs but varied multifd channel count:
             6 ch     8 ch    15 ch
Enabled:  1095 ms  1104 ms  1125 ms 


Important note:
4 VF benchmarks were done with commit 5504a8126115
("KVM: Dynamic sized kvm memslots array") and its revert-dependencies
reverted since this seems to improve performance in this VM config if the
multifd transfer is enabled: the downtime performance with this commit
present is 1141 ms enabled / 1730 ms disabled.

Smaller VF counts actually do seem to benefit from this commit, so it's
likely that in the future adding some kind of a memslot pre-allocation
bit stream message might make sense to avoid this downtime regression for
4 VF configs (and likely higher VF count too).

========================================================================

This series is obviously targeting post QEMU 9.2 release by now
(AFAIK called 10.0).

Will need to be changed to use hw_compat_10_0 once these become available.

========================================================================

Maciej S. Szmigiero (23):
  migration: Clarify that {load,save}_cleanup handlers can run without
    setup
  thread-pool: Remove thread_pool_submit() function
  thread-pool: Rename AIO pool functions to *_aio() and data types to
    *Aio
  thread-pool: Implement generic (non-AIO) pool support
  migration: Add MIG_CMD_SWITCHOVER_START and its load handler
  migration: Add qemu_loadvm_load_state_buffer() and its handler
  migration: Document the BQL behavior of load SaveVMHandlers
  migration: Add thread pool of optional load threads
  migration/multifd: Split packet into header and RAM data
  migration/multifd: Device state transfer support - receive side
  migration/multifd: Make multifd_send() thread safe
  migration/multifd: Add an explicit MultiFDSendData destructor
  migration/multifd: Device state transfer support - send side
  migration/multifd: Add migration_has_device_state_support()
  migration/multifd: Send final SYNC only after device state is complete
  migration: Add save_live_complete_precopy_thread handler
  vfio/migration: Don't run load cleanup if load setup didn't run
  vfio/migration: Add x-migration-multifd-transfer VFIO property
  vfio/migration: Add load_device_config_state_start trace event
  vfio/migration: Convert bytes_transferred counter to atomic
  vfio/migration: Multifd device state transfer support - receive side
  migration/qemu-file: Define g_autoptr() cleanup function for QEMUFile
  vfio/migration: Multifd device state transfer support - send side

Peter Xu (1):
  migration/multifd: Make MultiFDSendData a struct

 hw/core/machine.c                  |   2 +
 hw/vfio/migration.c                | 588 ++++++++++++++++++++++++++++-
 hw/vfio/pci.c                      |  11 +
 hw/vfio/trace-events               |  11 +-
 include/block/aio.h                |   8 +-
 include/block/thread-pool.h        |  20 +-
 include/hw/vfio/vfio-common.h      |  21 ++
 include/migration/client-options.h |   4 +
 include/migration/misc.h           |  16 +
 include/migration/register.h       |  67 +++-
 include/qemu/typedefs.h            |   5 +
 migration/colo.c                   |   3 +
 migration/meson.build              |   1 +
 migration/migration-hmp-cmds.c     |   2 +
 migration/migration.c              |   3 +
 migration/migration.h              |   2 +
 migration/multifd-device-state.c   | 193 ++++++++++
 migration/multifd-nocomp.c         |  45 ++-
 migration/multifd.c                | 228 +++++++++--
 migration/multifd.h                |  73 +++-
 migration/options.c                |   9 +
 migration/qemu-file.h              |   2 +
 migration/ram.c                    |  10 +-
 migration/savevm.c                 | 183 ++++++++-
 migration/savevm.h                 |   4 +
 migration/trace-events             |   1 +
 scripts/analyze-migration.py       |  11 +
 tests/unit/test-thread-pool.c      |   2 +-
 util/async.c                       |   6 +-
 util/thread-pool.c                 | 174 +++++++--
 util/trace-events                  |   6 +-
 31 files changed, 1586 insertions(+), 125 deletions(-)
 create mode 100644 migration/multifd-device-state.c


