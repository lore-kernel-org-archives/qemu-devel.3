Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A2C04FF9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 14:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk2D-0004tO-S5; Tue, 16 Apr 2024 10:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk2B-0004sU-RA
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:43 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk27-0001yS-05
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:43:43 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk1h-0002cY-Ey; Tue, 16 Apr 2024 16:43:13 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: =?UTF-8?q?=5BPATCH=20RFC=2000/26=5D=20Multifd=20=F0=9F=94=80=20device=20state=20transfer=20support=20with=20VFIO=20consumer?=
Date: Tue, 16 Apr 2024 16:42:39 +0200
Message-ID: <cover.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

VFIO device state transfer is currently done via the main migration channel.
This means that transfers from multiple VFIO devices are done sequentially
and via just a single common migration channel.

Such way of transferring VFIO device state migration data reduces
performance and severally impacts the migration downtime (~50%) for VMs
that have multiple such devices with large state size - see the test
results below.

However, we already have a way to transfer migration data using multiple
connections - that's what multifd channels are.

Unfortunately, multifd channels are currently utilized for RAM transfer
only.
This patch set adds a new framework allowing their use for device state
transfer too.

The wire protocol is based on Avihai's x-channel-header patches, which
introduce a header for migration channels that allow the migration source
to explicitly indicate the migration channel type without having the
target deduce the channel type by peeking in the channel's content.

The new wire protocol can be switch on and off via migration.x-channel-header
option for compatibility with older QEMU versions and testing.
Switching the new wire protocol off also disables device state transfer via
multifd channels.

The device state transfer can happen either via the same multifd channels
as RAM data is transferred, mixed with RAM data (when
migration.x-multifd-channels-device-state is 0) or exclusively via
dedicated device state transfer channels (when
migration.x-multifd-channels-device-state > 0).

Using dedicated device state transfer multifd channels brings further
performance benefits since these channels don't need to participate in
the RAM sync process.


These patches introduce a few new SaveVMHandlers:
* "save_live_complete_precopy_async{,wait}" handlers that allow device to
  provide its own asynchronous transmission of the remaining data at the
  end of a precopy phase.

  The "save_live_complete_precopy_async" handler is supposed to start such
  transmission (for example, by launching appropriate threads) while the
  "save_live_complete_precopy_async_wait" handler is supposed to wait until
  such transfer has finished (for example, until the sending threads
  have exited).

* "load_state_buffer" and its caller qemu_loadvm_load_state_buffer() that
  allow providing device state buffer to explicitly specified device via
  its idstr and instance id.

* "load_finish" the allows migration code to poll whether a device-specific
  asynchronous device state loading operation had finished before proceeding
  further in the migration process (with associated condition variable for
  notification to avoid unnecessary polling).


A VFIO device migration consumer for the new multifd channels device state
migration framework was implemented with a reassembly process for the multifd
received data since device state packets sent via different multifd channels
can arrive out-of-order.

The VFIO device data loading process happens in a separate thread in order
to avoid blocking a multifd receive thread during this fairly long process.


Test setup:
Source machine: 2x Xeon Gold 5218 / 192 GiB RAM
                Mellanox ConnectX-7 with 100GbE link
                6.9.0-rc1+ kernel
Target machine: 2x Xeon Platinum 8260 / 376 GiB RAM
                Mellanox ConnectX-7 with 100GbE link
	        6.6.0+ kernel
VM: CPU 12cores x 2threads / 15 GiB RAM / 4x Mellanox ConnectX-7 VF


Migration config: 15 multifd channels total
                  new way had 4 channels dedicated to device state transfer
                  x-return-path=true, x-switchover-ack=true

Downtime with ~400 MiB VFIO total device state size:
                                                       TLS off     TLS on
	migration.x-channel-header=false (old way)    ~2100 ms   ~2300 ms
	migration.x-channel-header=true (new way)     ~1100 ms   ~1200 ms
	IMPROVEMENT                                       ~50%       ~50%


This patch set is also available as a git tree:
https://github.com/maciejsszmigiero/qemu/tree/multifd-device-state-transfer-vfio


Avihai Horon (7):
  migration: Add x-channel-header pseudo-capability
  migration: Add migration channel header send/receive
  migration: Add send/receive header for main channel
  migration: Allow passing migration header in migration channel
    creation
  migration: Add send/receive header for postcopy preempt channel
  migration: Add send/receive header for multifd channel
  migration: Enable x-channel-header pseudo-capability

Maciej S. Szmigiero (19):
  multifd: change multifd_new_send_channel_create() param type
  migration: Add a DestroyNotify parameter to
    socket_send_channel_create()
  multifd: pass MFDSendChannelConnectData when connecting sending socket
  migration/postcopy: pass PostcopyPChannelConnectData when connecting
    sending preempt socket
  migration/options: Mapped-ram is not channel header compatible
  vfio/migration: Add save_{iterate,complete_precopy}_started trace
    events
  migration/ram: Add load start trace event
  migration/multifd: Zero p->flags before starting filling a packet
  migration: Add save_live_complete_precopy_async{,wait} handlers
  migration: Add qemu_loadvm_load_state_buffer() and its handler
  migration: Add load_finish handler and associated functions
  migration: Add x-multifd-channels-device-state parameter
  migration: Add MULTIFD_DEVICE_STATE migration channel type
  migration/multifd: Device state transfer support - receive side
  migration/multifd: Convert multifd_send_pages::next_channel to atomic
  migration/multifd: Device state transfer support - send side
  migration/multifd: Add migration_has_device_state_support()
  vfio/migration: Multifd device state transfer support - receive side
  vfio/migration: Multifd device state transfer support - send side

 hw/core/machine.c              |   1 +
 hw/vfio/migration.c            | 530 ++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events           |  15 +-
 include/hw/vfio/vfio-common.h  |  25 ++
 include/migration/misc.h       |   5 +
 include/migration/register.h   |  67 +++++
 migration/channel.c            |  68 +++++
 migration/channel.h            |  17 ++
 migration/file.c               |   5 +-
 migration/migration-hmp-cmds.c |   7 +
 migration/migration.c          | 110 ++++++-
 migration/migration.h          |   6 +
 migration/multifd-zlib.c       |   2 +-
 migration/multifd-zstd.c       |   2 +-
 migration/multifd.c            | 512 ++++++++++++++++++++++++++-----
 migration/multifd.h            |  62 +++-
 migration/options.c            |  66 ++++
 migration/options.h            |   2 +
 migration/postcopy-ram.c       |  81 ++++-
 migration/ram.c                |   1 +
 migration/savevm.c             | 112 +++++++
 migration/savevm.h             |   7 +
 migration/socket.c             |   6 +-
 migration/socket.h             |   3 +-
 migration/trace-events         |   3 +
 qapi/migration.json            |  16 +-
 26 files changed, 1626 insertions(+), 105 deletions(-)


