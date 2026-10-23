Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA06606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlL-00032B-PW; Fri, 23 Oct 2026 15:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkv-0002wI-IG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:50 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkt-0001zi-4s
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:16:45 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKkf-00000007BEN-3OE3; Fri, 23 Oct 2026 21:16:29 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 00/13] VFIO device migration parallel state transitions
Date: Fri, 23 Oct 2026 21:16:11 +0200
Message-ID: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This is an updated v2 patch series of the v1 series located at:
https://lore.kernel.org/qemu-devel/cover.1779217494.git.maciej.szmigiero@oracle.com/
v1 also contains detailed description and benchmarks of downtime performance
improvements brought by this parallelization.

The main change in v2 is that the VFIO parallel state changing threads
are implemented/managed differently.

Specifically, a design based on one that Peter has suggested during the
review of v1 in [1] was implemented:
* The "priority" of existing VM change state handlers is renamed "depth",

* The now-freed "priority" term is used to implement an explicit,
  three-level VM_CHANGE_STATE_PRI_* priority system:
  NORMAL priority is the old cb(), HIGH priority is the old prepare_cb(),
  while a new SYNC priority level is introduced between them.

* Devices that can produce DMA have their VM stop handlers  to HIGH
  level to stop them before VFIO devices start reaching states not capable
  of accepting incoming DMA.
  This affected virtio, net and audio VM state change handlers.

* Interrupt controllers have their handlers moved so they are started
  before VFIO devices at VM_CHANGE_STATE_PRI_HIGH on VM start and stopped
  only after VFIO devices at VM_CHANGE_STATE_PRI_NORMAL.
  To further reinforce this ordering and make sure that it isn't lost in
  some future code refactor, an explicit VMChangeStateHandlerDepth system 
  for these controllers is introduced - much like migration already had
  explicit MigrationPriority values for them.

* The VFIO device state changing threads are now launched and joined just
  once during VM start or VM stop sequence, instead of having been
  launched and joined per each transition.

* The priority/qdev depth adjustment mechanism from v1 and an extra layer
  of indirection for VFIO VM change state handlers are no longer required -
  so were removed.

Note: the PPC and ARM changes are compile-tested only. However, they
are almost trivial so no significant risk is expected from that.

[1]: https://lore.kernel.org/qemu-devel/al42_qzCLAjE-Mch@x1.local/


  runstate: Rename VM change state handlers "priority" to "depth"
  runstate: Introduce VM change state handlers explicit priority levels
  runstate: Add an intermediate VM change state handlers SYNC priority
  hw/vfio: Introduce VFIOPCIDeviceClass
  vfio/migration: Parallelize device state transitions
  spapr/xive: Split VM state change handler into start and stop parts
  runstate: Start/stop interrupt controllers before/after ordinary
    devices
  audio: Split VM state change handler into start and stop parts
  audio: Make sure to stop audio before VFIO gets non-DMA-capable
  net: Split VM state change handler into start and stop parts
  net: Make sure to stop net before VFIO gets non-DMA-capable
  virtio: Split VM state change handler into start and stop parts
  virtio: Make sure to stop virtio before VFIO gets non-DMA-capable

 audio/audio-mixeng-be.c           |  42 ++++--
 audio/audio_int.h                 |   3 +-
 hw/core/vm-change-state-handler.c |  16 ++-
 hw/i386/vapic.c                   |   5 +-
 hw/intc/arm_gicv3_its_kvm.c       |   4 +-
 hw/intc/arm_gicv3_kvm.c           |   4 +-
 hw/intc/spapr_xive_kvm.c          |  80 ++++++-----
 hw/vfio/migration.c               | 230 +++++++++++++++++++++++++++++-
 hw/vfio/pci.c                     |   7 +
 hw/vfio/pci.h                     |  10 +-
 hw/vfio/trace-events              |   2 +
 hw/vfio/vfio-migration-internal.h |   3 +
 hw/virtio/virtio.c                |  32 ++++-
 include/hw/ppc/spapr_xive.h       |   3 +-
 include/hw/vfio/vfio-device.h     |   1 +
 include/hw/virtio/virtio.h        |   3 +-
 include/system/runstate.h         |  55 ++++---
 net/net.c                         |  52 ++++---
 system/runstate.c                 | 115 ++++++++-------
 tests/audio/audio-stubs.c         |   7 +
 20 files changed, 522 insertions(+), 152 deletions(-)


