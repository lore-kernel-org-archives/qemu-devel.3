Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519E0EFCE23
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxq98-0003U9-CM; Wed, 04 Mar 2026 12:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8t-0003FB-Fj
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vxq8r-0004va-O6
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:36:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772645773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtPai8/b13235tXiHfqfh6KX3mRBdNsS410cZ9nv1As=;
 b=TVD3/zOa6h1UdszHl3E1LtIaS+E6LdK7Udv+/BSJiKC2KAvXOaRjo6Sj+0sqauy3k9oPWb
 2r8twVsijdMGODclYvo5d4aRUZatYC0VZWq8FYsfi6wru59mNKheiAbYP1d1f0mZ6Mz9lo
 rEN4xavDasBugxTgWPhB01KgBuRCZZ4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-NGZdSyXtM3aQ7Mhj2w9U5A-1; Wed,
 04 Mar 2026 12:36:09 -0500
X-MC-Unique: NGZdSyXtM3aQ7Mhj2w9U5A-1
X-Mimecast-MFC-AGG-ID: NGZdSyXtM3aQ7Mhj2w9U5A_1772645768
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C72BC1956095; Wed,  4 Mar 2026 17:36:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.212])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D61591958DC5; Wed,  4 Mar 2026 17:36:04 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea DE <dtatulea@nvidia.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Koushik Dutta <kdutta@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Subject: [PATCH 6/7] vhost: add in_order feature to shadow virtqueue
Date: Wed,  4 Mar 2026 18:35:34 +0100
Message-ID: <20260304173535.2702587-7-eperezma@redhat.com>
In-Reply-To: <20260304173535.2702587-1-eperezma@redhat.com>
References: <20260304173535.2702587-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

Some vdpa devices benefit from the in order feature.  Add support to SVQ
so QEMU can migrate these.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 137 +++++++++++++++++++++++++++--
 hw/virtio/vhost-shadow-virtqueue.h |  36 ++++++--
 2 files changed, 160 insertions(+), 13 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 2d8fc82cc06f..60212fcd7bf3 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -12,11 +12,14 @@
 
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "qemu/iov.h"
 #include "qemu/main-loop.h"
 #include "qemu/log.h"
 #include "qemu/memalign.h"
 #include "linux-headers/linux/vhost.h"
 
+#define VIRTIO_RING_NOT_IN_BATCH UINT16_MAX
+
 /**
  * Validate the transport device features that both guests can use with the SVQ
  * and SVQs can use with the device.
@@ -150,7 +153,33 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
 static uint16_t vhost_svq_next_desc(const VhostShadowVirtqueue *svq,
                                     uint16_t id)
 {
-    return svq->desc_state[id].next;
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        return (id == svq->vring.num) ? 0 : ++id;
+    } else {
+        return svq->desc_state[id].next;
+    }
+}
+
+/**
+ * Updates the SVQ free_head member after adding them to the SVQ avail ring.
+ * The new free_head is the next descriptor that SVQ will make available by
+ * forwarding a new guest descriptor.
+ *
+ * @svq Shadow Virtqueue
+ * @num Number of descriptors added
+ * @id ID of the last descriptor added to the SVQ avail ring.
+ */
+static void vhost_svq_update_free_head(VhostShadowVirtqueue *svq,
+                                       size_t num, uint16_t id)
+{
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        svq->free_head += num;
+        if (svq->free_head >= svq->vring.num) {
+            svq->free_head -= svq->vring.num;
+        }
+    } else {
+        svq->free_head = vhost_svq_next_desc(svq, id);
+    }
 }
 
 /**
@@ -202,7 +231,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
         i = next;
     }
 
-    svq->free_head = vhost_svq_next_desc(svq, last);
+    vhost_svq_update_free_head(svq, num, last);
     return true;
 }
 
@@ -306,6 +335,9 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
     svq->num_free -= ndescs;
     svq->desc_state[qemu_head].elem = elem;
     svq->desc_state[qemu_head].ndescs = ndescs;
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        svq->desc_state[qemu_head].in_bytes = iov_size(in_sg, in_num);
+    }
     vhost_svq_kick(svq);
     return 0;
 }
@@ -401,6 +433,12 @@ static void vhost_handle_guest_kick_notifier(EventNotifier *n)
 static bool vhost_svq_more_used(VhostShadowVirtqueue *svq)
 {
     uint16_t *used_idx = &svq->vring.used->idx;
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER) &&
+        svq->batch_last.id != VIRTIO_RING_NOT_IN_BATCH) {
+        return true;
+    }
+
     if (svq->last_used_idx != svq->shadow_used_idx) {
         return true;
     }
@@ -463,6 +501,47 @@ static uint16_t vhost_svq_get_last_used_split(VhostShadowVirtqueue *svq,
     return le32_to_cpu(used->ring[last_used].id);
 }
 
+/*
+ * Gets the next buffer id and moves forward the used idx, so the next time
+ * SVQ calls this function will get the next one.  IN_ORDER version
+ *
+ * @svq: Shadow VirtQueue
+ * @len: Consumed length by the device.
+ *
+ * Return the next descriptor consumed by the device.
+ */
+static int32_t vhost_svq_get_last_used_split_in_order(
+        VhostShadowVirtqueue *svq,
+        uint32_t *len)
+{
+    unsigned num = svq->vring.num;
+    const vring_used_t *used = svq->vring.used;
+    uint16_t last_used = svq->last_used & (num - 1);
+    uint16_t last_used_idx = svq->last_used_idx & (num - 1);
+
+    if (svq->batch_last.id == VIRTIO_RING_NOT_IN_BATCH) {
+        svq->batch_last.id = le32_to_cpu(used->ring[last_used_idx].id);
+        svq->batch_last.len = le32_to_cpu(used->ring[last_used_idx].len);
+    }
+
+    if (unlikely(last_used >= num)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
+                      svq->vdev->name, last_used);
+        return -1;
+    }
+
+    if (svq->batch_last.id == last_used) {
+        svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
+        *len = svq->batch_last.len;
+    } else {
+        *len = svq->desc_state[last_used].in_bytes;
+    }
+
+    svq->last_used += svq->desc_state[last_used].ndescs;
+    svq->last_used_idx++;
+    return last_used;
+}
+
 static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
                                              uint16_t num, uint16_t i)
 {
@@ -474,8 +553,8 @@ static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqueue *svq,
 }
 
 G_GNUC_WARN_UNUSED_RESULT
-static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
-                                              uint16_t id)
+static VirtQueueElement *vhost_svq_detach_buf_split(VhostShadowVirtqueue *svq,
+                                                    uint16_t id)
 {
     uint16_t num = svq->desc_state[id].ndescs;
     uint16_t last_used_chain = vhost_svq_last_desc_of_chain(svq, num, id);
@@ -486,6 +565,33 @@ static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
     return g_steal_pointer(&svq->desc_state[id].elem);
 }
 
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_detach_buf_split_in_order(
+        VhostShadowVirtqueue *svq,
+        uint16_t id)
+{
+    return g_steal_pointer(&svq->desc_state[id].elem);
+}
+
+/*
+ * Return the descriptor id (and the chain of ids) to the free list
+ *
+ * @svq: Shadow Virtqueue
+ * @id: Id of the buffer to return.
+ *
+ * Return the element associated to the buffer if any.
+ */
+G_GNUC_WARN_UNUSED_RESULT
+static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
+                                              uint16_t id)
+{
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        return vhost_svq_detach_buf_split_in_order(svq, id);
+    } else {
+        return vhost_svq_detach_buf_split(svq, id);
+    }
+}
+
 G_GNUC_WARN_UNUSED_RESULT
 static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                            uint32_t *len)
@@ -498,7 +604,18 @@ static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
 
     /* Only get used array entries after they have been exposed by dev */
     smp_rmb();
-    last_used = vhost_svq_get_last_used_split(svq, len);
+
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        int32_t r;
+        r = vhost_svq_get_last_used_split_in_order(svq, len);
+        if (r < 0) {
+            return NULL;
+        }
+
+        last_used = r;
+    } else {
+        last_used = vhost_svq_get_last_used_split(svq, len);
+    }
 
     if (unlikely(last_used >= svq->vring.num)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
@@ -726,6 +843,8 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->next_guest_avail_elem = NULL;
     svq->shadow_avail_idx = 0;
     svq->shadow_used_idx = 0;
+    memset(&svq->batch_last, 0, sizeof(svq->batch_last));
+    svq->last_used = 0;
     svq->last_used_idx = 0;
     svq->vdev = vdev;
     svq->vq = vq;
@@ -742,8 +861,12 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
     svq->desc_state = g_new0(SVQDescState, svq->vring.num);
-    for (unsigned i = 0; i < svq->vring.num - 1; i++) {
-        svq->desc_state[i].next = i + 1;
+    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
+        svq->batch_last.id = VIRTIO_RING_NOT_IN_BATCH;
+    } else {
+        for (unsigned i = 0; i < svq->vring.num - 1; i++) {
+            svq->desc_state[i].next = i + 1;
+        }
     }
 }
 
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index f52c33e65046..ec16a1e83858 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -24,11 +24,19 @@ typedef struct SVQDescState {
      */
     unsigned int ndescs;
 
-    /*
-     * Backup next field for each descriptor so we can recover securely, not
-     * needing to trust the device access.
-     */
-    uint16_t next;
+    union {
+        /*
+         * Total length of the available buffer that is writable by the device.
+         * Only used in packed vq.
+         */
+        uint32_t in_bytes;
+
+        /*
+         * Backup next field for each descriptor so we can recover securely, not
+         * needing to trust the device access.  Only used in split vq.
+         */
+        uint16_t next;
+    };
 } SVQDescState;
 
 typedef struct VhostShadowVirtqueue VhostShadowVirtqueue;
@@ -99,9 +107,25 @@ typedef struct VhostShadowVirtqueue {
     /* Next head to expose to the device */
     uint16_t shadow_avail_idx;
 
-    /* Next free descriptor */
+    /*
+     * Next free descriptor.
+     *
+     * Without IN_ORDER free_head is used as a linked list head, and
+     * desc_next[id] is the next element.
+     * With IN_ORDER free_head is the next available buffer index.
+     */
     uint16_t free_head;
 
+    /*
+     * Last used element of the processing batch of used descriptors if
+     * IN_ORDER.
+     * If SVQ is not processing a batch of descriptors id is set to UINT_MAX.
+     */
+    vring_used_elem_t batch_last;
+
+    /* Last used id if IN_ORDER and split vq */
+    uint16_t last_used;
+
     /* Last seen used idx */
     uint16_t shadow_used_idx;
 
-- 
2.53.0


