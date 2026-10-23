Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95D606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKmT-0003er-RE; Fri, 23 Oct 2026 15:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlp-0003D3-6B
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:42 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKln-000278-Ix
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 15:17:40 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlk-00000007BGe-1VFz; Fri, 23 Oct 2026 21:17:36 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 13/13] virtio: Make sure to stop virtio before VFIO gets
 non-DMA-capable
Date: Fri, 23 Oct 2026 21:16:24 +0200
Message-ID: <c6af3c37f9aecef6603d40b32c65a9df2860d476.1792758436.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

On a VM stop various virtio backends stop their requests from functions
ultimately called from the generic virtio VM state change handler.

For example, virtio-blk flushes all of its in-flight I/O and waits for
virtio_blk_dma_restart_bh() to complete from its stop_ioeventfd method.
virtio-scsi-dataplane has similar in-flight I/O flushing code in its
stop_ioeventfd method.

That stop_ioeventfd method is called from (for example)
virtio_pci_vmstate_change(), which in turn is called from the generic
virtio VM state change handler.

Since VFIO devices start their transition into a state where they no longer
can accept incoming DMA at VM_CHANGE_STATE_PRI_SYNC if these backends are
stopped at VM_CHANGE_STATE_PRI_NORMAL in an unlikely but possible case that
DMA from these virtio devices target a VFIO device BAR it may reach a VFIO
device that has already switched into a non-DMA-capable state.

Fix this by making sure that at VM stop virtio is stopped at HIGH priority
level, so before VFIO devices start reaching states not capable of
accepting incoming DMA.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/virtio/virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 9eefb2e2e670..47c1a5e25c17 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3831,8 +3831,8 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
     }
     vdev->vmstate_start = qdev_add_vm_change_state_handler(DEVICE(vdev),
             NULL, virtio_vmstate_change_start, vdev);
-    vdev->vmstate_stop = qdev_add_vm_change_state_handler(DEVICE(vdev),
-            NULL, virtio_vmstate_change_stop, vdev);
+    vdev->vmstate_stop = qdev_add_vm_change_state_handler_full(DEVICE(vdev),
+            NULL, virtio_vmstate_change_stop, vdev, VM_CHANGE_STATE_PRI_HIGH);
     vdev->device_endian = virtio_default_endian();
     vdev->use_guest_notifier_mask = true;
     QSIMPLEQ_INIT(&vdev->shmem_list);

