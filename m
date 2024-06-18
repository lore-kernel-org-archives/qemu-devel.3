Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF6C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbSP-0002o4-CJ; Tue, 18 Jun 2024 12:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSN-0002ha-6M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:15 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbSL-0000nm-0P
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:13:14 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sJbRv-0001aK-VL; Tue, 18 Jun 2024 18:12:48 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: =?UTF-8?q?=5BPATCH=20v1=2000/13=5D=20Multifd=20=F0=9F=94=80=20device=20state=20transfer=20support=20with=20VFIO=20consumer?=
Date: Tue, 18 Jun 2024 18:12:18 +0200
Message-ID: <cover.1718717584.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.45.1
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

This is an updated v1 patch series of the RFC (v0) series located here:
https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/


Changes from the RFC (v0):
* Extend the existing multifd packet format instead of introducing a new
migration channel header.

* As the replacement of switching the migration channel header on or off
introduce "x-migration-multifd-transfer" VFIO device property instead that
allows configuring at runtime whether to send the particular device state
via multifd channels when live migrating that device.

This property defaults to "false" for bit stream compatibility with older
QEMU versions.

* Remove the support for having dedicated device state transfer multifd
channels since the same downtime performance can be attained by simply
reducing the total number of multifd channels in a shared channel
configuration to the number of channels available for RAM transfer in
the dedicated device state channels configuration.

For example, the best downtime from the dedicated device state config
on my setup (achieved in configuration of 10 total multifd channels /
4 dedicated device state channels) can also be achieved in the
shared RAM/device state channel configuration by reducing the total
multifd channel count to 6.

It looks like not having too many RAM transfer multifd channels is
key to having a good downtime since the results are reproducibly
worse with 15 shared channels total, while they are as good as with
6 shared channels if there are 15 total channels but 4 of them are
dedicated to transferring device state (leaving 11 for RAM transfer).

* Make the next multifd channel selection more fair when converting
multifd_send_pages::next_channel to atomic.

* Convert the code to use QEMU thread sync primitives (QemuMutex with
QemuLockable, QemuCond) instead of their Glib equivalents (GMutex,
GMutexLocker and GCond).

* Rename complete_precopy_async{,_wait} to complete_precopy_{begin,_end} as
suggested.

* Rebase onto the last week's QEMU git master and retest.


When working on the updated patch set version I also investigated the
possibility of refactoring VM live phase (non-downtime) transfers to
happen via multifd channels.

However, the VM live phase transfer works differently: it happens
opportunistically until the remaining data drops below the switchover
threshold, rather that transferring always the whole device state data
until their exhaustion.

For this reason, there would need to be some way in the migration
framework to update the remaining data estimate from per-device
saving/transfer queuing thread and then stop these threads when the
decision has been reached in the migration core to stop the VM and
switch over. Such functionality would need to be introduced first.

There would also need to be some fairness guarantees so every device
gets similar access to multifd channels - otherwise there could be a
situation that the remaining data never drops below switchover
threshold because some devices are starved with respect to access to
the multifd transfer channels - as in the VM live phase additional
device data is constantly being generated.

Moreover, there's nothing stopping a QEMU device driver from requiring
different handling (loading, etc.) of VM live phase data from the
post-switchover data.
For cases like this some kind of a new device VM live phase incoming
data load handler would need to be introduced too.

For the above reasons, the VM live phase multifd transfer functionality
isn't a simple extension of the functionality introduced by this patch
set.


For convenience, this patch set is also available as a git tree:
https://github.com/maciejsszmigiero/qemu/tree/multifd-device-state-transfer-vfio


Maciej S. Szmigiero (13):
  vfio/migration: Add save_{iterate,complete_precopy}_started trace
    events
  migration/ram: Add load start trace event
  migration/multifd: Zero p->flags before starting filling a packet
  migration: Add save_live_complete_precopy_{begin,end} handlers
  migration: Add qemu_loadvm_load_state_buffer() and its handler
  migration: Add load_finish handler and associated functions
  migration/multifd: Device state transfer support - receive side
  migration/multifd: Convert multifd_send_pages::next_channel to atomic
  migration/multifd: Device state transfer support - send side
  migration/multifd: Add migration_has_device_state_support()
  vfio/migration: Multifd device state transfer support - receive side
  vfio/migration: Add x-migration-multifd-transfer VFIO property
  vfio/migration: Multifd device state transfer support - send side

 hw/vfio/migration.c           | 545 +++++++++++++++++++++++++++++++++-
 hw/vfio/pci.c                 |   7 +
 hw/vfio/trace-events          |  15 +-
 include/hw/vfio/vfio-common.h |  27 ++
 include/migration/misc.h      |   5 +
 include/migration/register.h  |  70 +++++
 migration/migration.c         |   6 +
 migration/migration.h         |   3 +
 migration/multifd-zlib.c      |   2 +-
 migration/multifd-zstd.c      |   2 +-
 migration/multifd.c           | 336 +++++++++++++++++----
 migration/multifd.h           |  57 +++-
 migration/ram.c               |   1 +
 migration/savevm.c            | 112 +++++++
 migration/savevm.h            |   7 +
 migration/trace-events        |   1 +
 16 files changed, 1132 insertions(+), 64 deletions(-)


