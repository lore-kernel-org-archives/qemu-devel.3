Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C3EC54734
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 17:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj0Q1-0005WM-CE; Tue, 27 Aug 2024 13:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Px-0005GE-AQ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:45 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0Pg-0001YR-NX
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 13:55:44 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sj0P7-0002LO-0r; Tue, 27 Aug 2024 19:54:53 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: =?UTF-8?q?=5BPATCH=20v2=2000/17=5D=20Multifd=20=F0=9F=94=80=20device=20state=20transfer=20support=20with=20VFIO=20consumer?=
Date: Tue, 27 Aug 2024 19:54:19 +0200
Message-ID: <cover.1724701542.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is an updated v2 patch series of the v1 series located here:
https://lore.kernel.org/qemu-devel/cover.1718717584.git.maciej.szmigiero@oracle.com/

Changes from v1:
* Extended the QEMU thread-pool with non-AIO (generic) pool support,
implemented automatic memory management support for its work element
function argument.

* Introduced a multifd device state save thread pool, ported the VFIO
multifd device state save implementation to use this thread pool instead
of VFIO internally managed individual threads.

* Re-implemented on top of Fabiano's v4 multifd sender refactor patch set from
https://lore.kernel.org/qemu-devel/20240823173911.6712-1-farosas@suse.de/

* Moved device state related multifd code to new multifd-device-state.c
file where it made sense.

* Implemented a max in-flight VFIO device state buffer count limit to
allow capping the maximum recipient memory usage.

* Removed unnecessary explicit memory barriers from multifd_send().

* A few small changes like updated comments, code formatting,
fixed zero-copy RAM multifd bytes transferred counter under-counting, etc.


For convenience, this patch set is also available as a git tree:
https://github.com/maciejsszmigiero/qemu/tree/multifd-device-state-transfer-vfio

Based-on: <20240823173911.6712-1-farosas@suse.de>


Maciej S. Szmigiero (17):
  vfio/migration: Add save_{iterate,complete_precopy}_started trace
    events
  migration/ram: Add load start trace event
  migration/multifd: Zero p->flags before starting filling a packet
  thread-pool: Add a DestroyNotify parameter to
    thread_pool_submit{,_aio)()
  thread-pool: Implement non-AIO (generic) pool support
  migration: Add save_live_complete_precopy_{begin,end} handlers
  migration: Add qemu_loadvm_load_state_buffer() and its handler
  migration: Add load_finish handler and associated functions
  migration/multifd: Device state transfer support - receive side
  migration/multifd: Convert multifd_send()::next_channel to atomic
  migration/multifd: Add an explicit MultiFDSendData destructor
  migration/multifd: Device state transfer support - send side
  migration/multifd: Add migration_has_device_state_support()
  migration: Add save_live_complete_precopy_thread handler
  vfio/migration: Multifd device state transfer support - receive side
  vfio/migration: Add x-migration-multifd-transfer VFIO property
  vfio/migration: Multifd device state transfer support - send side

 backends/tpm/tpm_backend.c       |   2 +-
 block/file-win32.c               |   2 +-
 hw/9pfs/coth.c                   |   3 +-
 hw/ppc/spapr_nvdimm.c            |   4 +-
 hw/vfio/migration.c              | 520 ++++++++++++++++++++++++++++++-
 hw/vfio/pci.c                    |   9 +
 hw/vfio/trace-events             |  14 +-
 hw/virtio/virtio-pmem.c          |   2 +-
 include/block/thread-pool.h      |  12 +-
 include/hw/vfio/vfio-common.h    |  22 ++
 include/migration/misc.h         |  15 +
 include/migration/register.h     |  97 ++++++
 include/qemu/typedefs.h          |   4 +
 migration/meson.build            |   1 +
 migration/migration.c            |   6 +
 migration/migration.h            |   3 +
 migration/multifd-device-state.c | 193 ++++++++++++
 migration/multifd-nocomp.c       |   9 +-
 migration/multifd-qpl.c          |   2 +-
 migration/multifd-uadk.c         |   2 +-
 migration/multifd-zlib.c         |   2 +-
 migration/multifd-zstd.c         |   2 +-
 migration/multifd.c              | 249 ++++++++++++---
 migration/multifd.h              |  65 +++-
 migration/ram.c                  |   1 +
 migration/savevm.c               | 152 ++++++++-
 migration/savevm.h               |   7 +
 migration/trace-events           |   1 +
 tests/unit/test-thread-pool.c    |   8 +-
 util/thread-pool.c               |  83 ++++-
 30 files changed, 1406 insertions(+), 86 deletions(-)
 create mode 100644 migration/multifd-device-state.c


