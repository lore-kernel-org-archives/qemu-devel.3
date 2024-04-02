Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C4CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 15:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrfew-0002rJ-Gu; Tue, 02 Apr 2024 11:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rrfet-0002q7-Le
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1rrfer-0000a6-Mk
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 11:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712070158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVdYP7lw33bCUp7E573yzbQERCgswbFMDLrv+gGeA78=;
 b=AEd/lCemKnNAHz76DlmZB2dasvhknetjQ2VPAg68V/4Zvf3cczduVUkjSlIcLxvyFZGRdr
 1vufXNzl5HJznLGLkhhhaJTSRtI7UIthj36Rvvx3VVWR7PDvmaCfMtM4l/FnMAwL/HSI4R
 nsThUizF6fOfUlNgAmwwzTFOosG3JaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-EhSoGetBOGyULeQ7WV0sBA-1; Tue, 02 Apr 2024 11:02:36 -0400
X-MC-Unique: EhSoGetBOGyULeQ7WV0sBA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76BA7101A523
 for <qemu-devel@nongnu.org>; Tue,  2 Apr 2024 15:02:36 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61C65492BCD;
 Tue,  2 Apr 2024 15:02:34 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 1/1] virtio-pci: Fix the crash when the vector changes back
 from VIRTIO_NO_VECTOR
Date: Tue,  2 Apr 2024 23:00:10 +0800
Message-ID: <20240402150218.270587-2-lulu@redhat.com>
In-Reply-To: <20240402150218.270587-1-lulu@redhat.com>
References: <20240402150218.270587-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the guest calls virtio_stop and then virtio_reset, the vector will change
to VIRTIO_NO_VECTOR and the IRQFD for this vector will be released. After that
If you want to change the vector back, it will cause a crash.

To fix this, we need to call the function "kvm_virtio_pci_vector_use_one()"
when the vector changes back from VIRTIO_NO_VECTOR

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e433879542..45f3ab38c3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -874,12 +874,14 @@ static int virtio_pci_get_notifier(VirtIOPCIProxy *proxy, int queue_no,
     return 0;
 }
 
-static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
+static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no,
+                                         bool recovery)
 {
     unsigned int vector;
     int ret;
     EventNotifier *n;
     PCIDevice *dev = &proxy->pci_dev;
+    VirtIOIRQFD *irqfd;
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
 
@@ -890,10 +892,21 @@ static int kvm_virtio_pci_vector_use_one(VirtIOPCIProxy *proxy, int queue_no)
     if (vector >= msix_nr_vectors_allocated(dev)) {
         return 0;
     }
+    /*
+     * if this is recovery and irqfd still in use, means the irqfd was not
+     * release before and don't need to set up again
+     */
+    if (recovery) {
+        irqfd = &proxy->vector_irqfd[vector];
+        if (irqfd->users != 0) {
+            return 0;
+        }
+    }
     ret = kvm_virtio_pci_vq_vector_use(proxy, vector);
     if (ret < 0) {
         goto undo;
     }
+
     /*
      * If guest supports masking, set up irqfd now.
      * Otherwise, delay until unmasked in the frontend.
@@ -932,14 +945,14 @@ static int kvm_virtio_pci_vector_vq_use(VirtIOPCIProxy *proxy, int nvqs)
         if (!virtio_queue_get_num(vdev, queue_no)) {
             return -1;
         }
-        ret = kvm_virtio_pci_vector_use_one(proxy, queue_no);
+        ret = kvm_virtio_pci_vector_use_one(proxy, queue_no, false);
     }
     return ret;
 }
 
 static int kvm_virtio_pci_vector_config_use(VirtIOPCIProxy *proxy)
 {
-    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX);
+    return kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX, false);
 }
 
 static void kvm_virtio_pci_vector_release_one(VirtIOPCIProxy *proxy,
@@ -1570,7 +1583,13 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
         } else {
             val = VIRTIO_NO_VECTOR;
         }
+        vector = vdev->config_vector;
         vdev->config_vector = val;
+        /*check if the vector need to recovery*/
+        if ((val != VIRTIO_NO_VECTOR) && (vector == VIRTIO_NO_VECTOR) &&
+            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+            kvm_virtio_pci_vector_use_one(proxy, VIRTIO_CONFIG_IRQ_IDX, true);
+        }
         break;
     case VIRTIO_PCI_COMMON_STATUS:
         if (!(val & VIRTIO_CONFIG_S_DRIVER_OK)) {
@@ -1611,6 +1630,12 @@ static void virtio_pci_common_write(void *opaque, hwaddr addr,
             val = VIRTIO_NO_VECTOR;
         }
         virtio_queue_set_vector(vdev, vdev->queue_sel, val);
+
+        /*check if the vector need to recovery*/
+        if ((val != VIRTIO_NO_VECTOR) && (vector == VIRTIO_NO_VECTOR) &&
+            (vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
+            kvm_virtio_pci_vector_use_one(proxy, vdev->queue_sel, true);
+        }
         break;
     case VIRTIO_PCI_COMMON_Q_ENABLE:
         if (val == 1) {
-- 
2.43.0


