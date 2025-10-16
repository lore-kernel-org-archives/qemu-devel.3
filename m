Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D2ACCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MNi-0007Xj-6D; Thu, 16 Oct 2025 07:42:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MN8-0007Et-Ff; Thu, 16 Oct 2025 07:42:21 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v9MMp-0003WD-EU; Thu, 16 Oct 2025 07:42:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 200DEC01BE;
 Thu, 16 Oct 2025 14:41:38 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a8c::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LfP2M73FEmI0-jabrmu5C; Thu, 16 Oct 2025 14:41:37 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760614897;
 bh=4cgovY7tyDau9EmQRY+aKBap0SqRZ3wu+IcsVV5ZIew=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OrheK5kWODMj9Sm46WDHPjCXdSUUw773g/qtifCblTi3dJZ/aIUb5UrRZCV3YRCRz
 QAIhycvDA9+Gu9Rop2ssBVP2TwoNAn5o/s7HKFCRs0zah1HSuInZ7xbiYSrNm7dJuf
 0UXSFQ6rtSJWL1TYLpNWsU4nTKOppKZoQxdVXJr0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: raphael@enfabrica.net,
	pbonzini@redhat.com,
	farosas@suse.de
Cc: mst@redhat.com, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, jasowang@redhat.com
Subject: [PATCH v2 19/25] vhost: support backend-transfer migration
Date: Thu, 16 Oct 2025 14:40:56 +0300
Message-ID: <20251016114104.1384675-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
References: <20251016114104.1384675-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Introduce vhost_dev.backend_transfer field,

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost.c         | 121 +++++++++++++++++++++++++++++++++-----
 include/hw/virtio/vhost.h |   7 +++
 2 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 63036f8214..c46203eb9c 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1325,6 +1325,8 @@ out:
     return ret;
 }
 
+static void vhost_virtqueue_error_notifier(EventNotifier *n);
+
 int vhost_virtqueue_start(struct vhost_dev *dev,
                           struct VirtIODevice *vdev,
                           struct vhost_virtqueue *vq,
@@ -1350,7 +1352,13 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
         return r;
     }
 
-    vq->num = state.num = virtio_queue_get_num(vdev, idx);
+    vq->num = virtio_queue_get_num(vdev, idx);
+
+    if (dev->backend_transfer) {
+        return 0;
+    }
+
+    state.num = vq->num;
     r = dev->vhost_ops->vhost_set_vring_num(dev, &state);
     if (r) {
         VHOST_OPS_DEBUG(r, "vhost_set_vring_num failed");
@@ -1428,6 +1436,10 @@ static int do_vhost_virtqueue_stop(struct vhost_dev *dev,
 
     trace_vhost_virtque_stop_in(dev, vdev->name, idx);
 
+    if (dev->backend_transfer) {
+        return 0;
+    }
+
     if (virtio_queue_get_desc_addr(vdev, idx) == 0) {
         /* Don't stop the virtqueue which might have not been started */
         return 0;
@@ -1565,10 +1577,14 @@ fail_call:
 
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
-    event_notifier_cleanup(&vq->masked_notifier);
+    if (!vq->dev->backend_transfer) {
+        event_notifier_cleanup(&vq->masked_notifier);
+    }
     if (vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
-        event_notifier_cleanup(&vq->error_notifier);
+        if (!vq->dev->backend_transfer) {
+            event_notifier_cleanup(&vq->error_notifier);
+        }
     }
 }
 
@@ -1635,6 +1651,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
 
     hdev->vdev = NULL;
     hdev->migration_blocker = NULL;
+    hdev->_features_wait_incoming = true;
     hdev->busyloop_timeout = busyloop_timeout;
 
     for (i = 0; i < hdev->nvqs; ++i) {
@@ -1717,6 +1734,8 @@ int vhost_dev_connect(struct vhost_dev *hdev, Error **errp)
         goto fail;
     }
 
+    hdev->_features_wait_incoming = false;
+
     for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
         r = vhost_virtqueue_connect(hdev->vqs + i, hdev->vq_index + i);
         if (r < 0) {
@@ -1808,8 +1827,11 @@ void vhost_dev_disable_notifiers_nvqs(struct vhost_dev *hdev,
      */
     memory_region_transaction_commit();
 
-    for (i = 0; i < nvqs; ++i) {
-        virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), hdev->vq_index + i);
+    if (!hdev->backend_transfer) {
+        for (i = 0; i < nvqs; ++i) {
+            virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus),
+                                             hdev->vq_index + i);
+        }
     }
     virtio_device_release_ioeventfd(vdev);
 }
@@ -1967,6 +1989,11 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
 {
     const int *bit = feature_bits;
 
+    if (hdev->_features_wait_incoming) {
+        /* Excessive set is enough for early initialization. */
+        return;
+    }
+
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
         if (!vhost_dev_has_feature_ex(hdev, *bit)) {
             virtio_clear_feature_ex(features, *bit);
@@ -2001,6 +2028,54 @@ const VMStateDescription vmstate_backend_transfer_vhost_inflight = {
     }
 };
 
+const VMStateDescription vmstate_vhost_virtqueue = {
+    .name = "vhost-virtqueue",
+    .fields = (const VMStateField[]) {
+        VMSTATE_EVENT_NOTIFIER(error_notifier, struct vhost_virtqueue),
+        VMSTATE_EVENT_NOTIFIER(masked_notifier, struct vhost_virtqueue),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static int vhost_dev_post_load(void *opaque, int version_id)
+{
+    struct vhost_dev *hdev = opaque;
+    Error *err = NULL;
+    int i;
+
+    if (!check_memslots(hdev, &err)) {
+        error_report_err(err);
+        return -EINVAL;
+    }
+
+    hdev->_features_wait_incoming = false;
+
+    if (hdev->vhost_ops->vhost_set_vring_err) {
+        for (i = 0; i < hdev->nvqs; ++i) {
+            event_notifier_set_handler(&hdev->vqs[i].error_notifier,
+                                       vhost_virtqueue_error_notifier);
+        }
+    }
+
+
+    return 0;
+}
+
+const VMStateDescription vmstate_vhost_dev = {
+    .name = "vhost-dev",
+    .post_load = vhost_dev_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(_features, struct vhost_dev),
+        VMSTATE_UINT64(max_queues, struct vhost_dev),
+        VMSTATE_UINT32_EQUAL(nvqs, struct vhost_dev, NULL),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(vqs, struct vhost_dev,
+                                             nvqs,
+                                             vmstate_vhost_virtqueue,
+                                             struct vhost_virtqueue),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 void vhost_ack_features_ex(struct vhost_dev *hdev, const int *feature_bits,
                            const uint64_t *features)
 {
@@ -2127,19 +2202,24 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     hdev->started = true;
     hdev->vdev = vdev;
 
-    r = vhost_dev_set_features(hdev, hdev->log_enabled);
-    if (r < 0) {
-        goto fail_features;
+    if (!hdev->backend_transfer) {
+        r = vhost_dev_set_features(hdev, hdev->log_enabled);
+        if (r < 0) {
+            warn_report("%s %d", __func__, __LINE__);
+            goto fail_features;
+        }
     }
 
     if (vhost_dev_has_iommu(hdev)) {
         memory_listener_register(&hdev->iommu_listener, vdev->dma_as);
     }
 
-    r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
-    if (r < 0) {
-        VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
-        goto fail_mem;
+    if (!hdev->backend_transfer) {
+        r = hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
+        if (r < 0) {
+            VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
+            goto fail_mem;
+        }
     }
     for (i = 0; i < hdev->nvqs; ++i) {
         r = vhost_virtqueue_start(hdev,
@@ -2179,13 +2259,13 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
         }
         vhost_dev_elect_mem_logger(hdev, true);
     }
-    if (vrings) {
+    if (vrings && !hdev->backend_transfer) {
         r = vhost_dev_set_vring_enable(hdev, true);
         if (r) {
             goto fail_log;
         }
     }
-    if (hdev->vhost_ops->vhost_dev_start) {
+    if (hdev->vhost_ops->vhost_dev_start && !hdev->backend_transfer) {
         r = hdev->vhost_ops->vhost_dev_start(hdev, true);
         if (r) {
             goto fail_start;
@@ -2207,6 +2287,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     }
     vhost_start_config_intr(hdev);
 
+    hdev->backend_transfer = false;
+
     trace_vhost_dev_start_out(hdev, vdev->name);
     return 0;
 fail_iotlb:
@@ -2262,9 +2344,18 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev,
     if (hdev->vhost_ops->vhost_dev_start) {
         hdev->vhost_ops->vhost_dev_start(hdev, false);
     }
-    if (vrings) {
+    if (vrings && !hdev->backend_transfer) {
         vhost_dev_set_vring_enable(hdev, false);
     }
+
+    if (hdev->backend_transfer) {
+        for (i = 0; i < hdev->nvqs; ++i) {
+            struct vhost_virtqueue *vq = hdev->vqs + i;
+
+            event_notifier_set_handler(&vq->error_notifier, NULL);
+        }
+    }
+
     for (i = 0; i < hdev->nvqs; ++i) {
         rc |= do_vhost_virtqueue_stop(hdev,
                                       vdev,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 94a0c75fc8..55ad822848 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -105,6 +105,9 @@ struct vhost_dev {
     VIRTIO_DECLARE_FEATURES(_features);
     VIRTIO_DECLARE_FEATURES(acked_features);
 
+    bool _features_wait_incoming;
+    bool backend_transfer;
+
     uint32_t busyloop_timeout;
     uint64_t max_queues;
     uint64_t backend_cap;
@@ -592,4 +595,8 @@ extern const VMStateDescription vmstate_backend_transfer_vhost_inflight;
     VMSTATE_STRUCT_POINTER(_field, _state, vmstate_inflight, \
                            struct vhost_inflight)
 
+extern const VMStateDescription vmstate_vhost_dev;
+#define VMSTATE_BACKEND_TRANSFER_VHOST(_field, _state) \
+    VMSTATE_STRUCT(_field, _state, 0, vmstate_vhost_dev, struct vhost_dev)
+
 #endif
-- 
2.48.1


