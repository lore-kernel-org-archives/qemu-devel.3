Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83596CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPi7Z-0002qf-19; Wed, 20 May 2026 10:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7V-0002q0-Ir
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:42:02 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7T-0002G0-Nm
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:42:01 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wPi7F-00000001uqW-25eN; Wed, 20 May 2026 16:41:45 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] VFIO device migration parallel state transitions
Date: Wed, 20 May 2026 16:41:36 +0200
Message-ID: <cover.1779217494.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

When multiple VFIO devices are present in a VM the fact that their state
transitions on migration happen sequentially has a visible impact on
migration downtime.

This is because both PRE_COPY -> PRE_COPY_P2P -> STOP_COPY transitions on
the source and RESUMING -> RUNNING_P2P -> RUNNING transitions on the target
happen during the switchover phase.
During this phase the VM is stopped so the downtime is ticking.

These device state transitions are performed by VM state change handlers
registered by the VFIO device migration code.

Instead of performing such state transition synchronously launch a thread
performing the state change in parallel with other VFIO devices and other
VM state change handlers at the particular VFIO device qdev tree depth.
Only wait for this thread to finish *after* all other handlers at this
tree depth finish doing their jobs.

To implement the above allow adjustment of priority for VM state change
handlers - specifically allow registering qdev VM state change handlers
below and above the normal priority level for the registering device qdev
tree depth, but still properly ordered with respect to handlers
registered at other tree depths.

This way these state transitions can happen in parallel not only with
respect to other VFIO device instances but also ordinary (serialized)
handlers for other devices at this qdev tree depth.


Downtime results:
               4 VFs    2 VFs    1 VF
Disabled:    1385 ms   758 ms  497 ms
Enabled:      986 ms   653 ms  493 ms 
IMPROVEMENT:   ~29 %    ~14 %    ~0 %

Test VM shape:
vCPU 12 cores x 2 threads, 15 GiB RAM.

VFIO devices in the source and target machine:
Mellanox ConnectX-7 with 100GbE link and ~100 MiB of device state per VF.


Maciej S. Szmigiero (2):
  system/runstate: Allow adjustment of priority for VM state change
    handlers
  vfio/migration: Parallelize device state transitions

 hw/core/vm-change-state-handler.c |  22 ++--
 hw/vfio/migration.c               | 174 ++++++++++++++++++++++++++++--
 hw/vfio/pci.c                     |   2 +
 hw/vfio/vfio-migration-internal.h |   4 +-
 include/hw/vfio/vfio-device.h     |   1 +
 include/system/runstate.h         |   2 +-
 6 files changed, 189 insertions(+), 16 deletions(-)


