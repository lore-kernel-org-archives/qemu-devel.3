Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E75CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhk9-0003q8-PC; Wed, 21 May 2025 07:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjm-0003dO-SD
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uHhjk-000166-C6
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747827351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3p/a0Mco18zN0Bh70yv0+94scFUHDvA4mUep1qxnV8=;
 b=G2Z1dsQZg/hHtToYFdoLXlbn6BvRfW8QfL/ceAafVqER06q5toXkWsnK4ScKo+8W/BJKSD
 v8krPt3/aya3WxWrPOcJgzVNFD1JADc1qkDUKTlqIrZEc4Zw7jIGOsZyyQTh/+htSLejiU
 eJ32n53Op5EL8Qh+xVVAoXM80UcRufU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-O4I3zrhiMA-RbXf0OLtYNA-1; Wed,
 21 May 2025 07:35:47 -0400
X-MC-Unique: O4I3zrhiMA-RbXf0OLtYNA-1
X-Mimecast-MFC-AGG-ID: O4I3zrhiMA-RbXf0OLtYNA_1747827346
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86365180034E; Wed, 21 May 2025 11:35:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.39])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B710519560B7; Wed, 21 May 2025 11:35:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH RFC 08/16] vhost: add support for negotiating extended
 features.
Date: Wed, 21 May 2025 13:34:02 +0200
Message-ID: <556d26160601ca8e2075ec3619aef4fe39725d11.1747825544.git.pabeni@redhat.com>
In-Reply-To: <cover.1747825544.git.pabeni@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Similar to virtio infra, vhost core maintain the features
status in the widest format available and allow the devices
to implement extended version of the getter/setter.

Some care is needed for features bit manipulation: when clearing
a bit with 'and not' bitwise operations, the bit mask must be
extended to the feature format, or the all highest bits will be
unintentionally cleared.

Note that 'protocol_features' are not extended: they are only
used by vhost-user, and the latter device is not going to implement
extended features soon.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 hw/virtio/vhost.c                 | 58 ++++++++++++++++++++++++-------
 include/hw/virtio/vhost-backend.h | 10 ++++++
 include/hw/virtio/vhost.h         | 13 +++----
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 4cae7c1664..20592473f3 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -985,20 +985,34 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
 static int vhost_dev_set_features(struct vhost_dev *dev,
                                   bool enable_log)
 {
-    uint64_t features = dev->acked_features;
+    virtio_features_t features = dev->acked_features;
     int r;
     if (enable_log) {
-        features |= 0x1ULL << VHOST_F_LOG_ALL;
+        features |= VIRTIO_BIT(VHOST_F_LOG_ALL);
     }
     if (!vhost_dev_has_iommu(dev)) {
-        features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
+        features &= ~VIRTIO_BIT(VIRTIO_F_IOMMU_PLATFORM);
     }
     if (dev->vhost_ops->vhost_force_iommu) {
         if (dev->vhost_ops->vhost_force_iommu(dev) == true) {
-            features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
+            features |= VIRTIO_BIT(VIRTIO_F_IOMMU_PLATFORM);
        }
     }
-    r = dev->vhost_ops->vhost_set_features(dev, features);
+
+#ifdef CONFIG_INT128
+    if ((features >> 64) && !dev->vhost_ops->vhost_set_features_ex) {
+        VHOST_OPS_DEBUG(r, "extended features without device support");
+        r = -EINVAL;
+        goto out;
+    }
+
+    if (dev->vhost_ops->vhost_set_features_ex) {
+        r = dev->vhost_ops->vhost_set_features_ex(dev, features);
+    } else
+#endif
+    {
+        r = dev->vhost_ops->vhost_set_features(dev, features);
+    }
     if (r < 0) {
         VHOST_OPS_DEBUG(r, "vhost_set_features failed");
         goto out;
@@ -1505,12 +1519,29 @@ static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
     }
 }
 
+static int vhost_dev_get_features(struct vhost_dev *hdev,
+                                  virtio_features_t *features)
+{
+    uint64_t features64;
+    int r;
+
+#ifdef CONFIG_INT128
+    if (hdev->vhost_ops->vhost_get_features_ex)
+        return hdev->vhost_ops->vhost_get_features_ex(hdev, features);
+    else
+#endif
+
+    r = hdev->vhost_ops->vhost_get_features(hdev, &features64);
+    *features = features64;
+    return r;
+}
+
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
                    VhostBackendType backend_type, uint32_t busyloop_timeout,
                    Error **errp)
 {
     unsigned int used, reserved, limit;
-    uint64_t features;
+    virtio_features_t features;
     int i, r, n_initialized_vqs = 0;
 
     hdev->vdev = NULL;
@@ -1530,7 +1561,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
-    r = hdev->vhost_ops->vhost_get_features(hdev, &features);
+    r = vhost_dev_get_features(hdev, &features);
     if (r < 0) {
         error_setg_errno(errp, -r, "vhost_get_features failed");
         goto fail;
@@ -1591,7 +1622,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     };
 
     if (hdev->migration_blocker == NULL) {
-        if (!(hdev->features & (0x1ULL << VHOST_F_LOG_ALL))) {
+        if (!(hdev->features & VIRTIO_BIT(VHOST_F_LOG_ALL))) {
             error_setg(&hdev->migration_blocker,
                        "Migration disabled: vhost lacks VHOST_F_LOG_ALL feature.");
         } else if (vhost_dev_log_is_shared(hdev) && !qemu_memfd_alloc_check()) {
@@ -1860,12 +1891,13 @@ static void vhost_start_config_intr(struct vhost_dev *dev)
     }
 }
 
-uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
-                            uint64_t features)
+virtio_features_t vhost_get_features(struct vhost_dev *hdev,
+                                     const int *feature_bits,
+                                     virtio_features_t features)
 {
     const int *bit = feature_bits;
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        uint64_t bit_mask = (1ULL << *bit);
+        virtio_features_t bit_mask = VIRTIO_BIT(*bit);
         if (!(hdev->features & bit_mask)) {
             features &= ~bit_mask;
         }
@@ -1875,11 +1907,11 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
 }
 
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
-                        uint64_t features)
+                        virtio_features_t features)
 {
     const int *bit = feature_bits;
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
-        uint64_t bit_mask = (1ULL << *bit);
+        virtio_features_t bit_mask = VIRTIO_BIT(*bit);
         if (features & bit_mask) {
             hdev->acked_features |= bit_mask;
         }
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index d6df209a2f..de9bcaf95f 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -95,6 +95,12 @@ typedef int (*vhost_new_worker_op)(struct vhost_dev *dev,
                                    struct vhost_worker_state *worker);
 typedef int (*vhost_free_worker_op)(struct vhost_dev *dev,
                                     struct vhost_worker_state *worker);
+#ifdef CONFIG_INT128
+typedef int (*vhost_set_features_ex_op)(struct vhost_dev *dev,
+                                        __uint128_t features);
+typedef int (*vhost_get_features_ex_op)(struct vhost_dev *dev,
+                                        __uint128_t *features);
+#endif
 typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
@@ -186,6 +192,10 @@ typedef struct VhostOps {
     vhost_free_worker_op vhost_free_worker;
     vhost_get_vring_worker_op vhost_get_vring_worker;
     vhost_attach_vring_worker_op vhost_attach_vring_worker;
+#ifdef CONFIG_INT128
+    vhost_set_features_ex_op vhost_set_features_ex;
+    vhost_get_features_ex_op vhost_get_features_ex;
+#endif
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index bb4b58e115..ea5ad117c5 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -106,9 +106,9 @@ struct vhost_dev {
      * future use should be discouraged and the variable retired as
      * its easy to confuse with the VirtIO backend_features.
      */
-    uint64_t features;
-    uint64_t acked_features;
-    uint64_t backend_features;
+    virtio_features_t features;
+    virtio_features_t acked_features;
+    virtio_features_t backend_features;
 
     /**
      * @protocol_features: is the vhost-user only feature set by
@@ -308,8 +308,9 @@ void vhost_virtqueue_mask(struct vhost_dev *hdev, VirtIODevice *vdev, int n,
  * is supported by the vhost backend (hdev->features), the supported
  * feature_bits and the requested feature set.
  */
-uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
-                            uint64_t features);
+virtio_features_t vhost_get_features(struct vhost_dev *hdev,
+                                     const int *feature_bits,
+                                     virtio_features_t features);
 
 /**
  * vhost_ack_features() - set vhost acked_features
@@ -321,7 +322,7 @@ uint64_t vhost_get_features(struct vhost_dev *hdev, const int *feature_bits,
  * the backends advertised features and the supported feature_bits.
  */
 void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
-                        uint64_t features);
+                        virtio_features_t features);
 unsigned int vhost_get_max_memslots(void);
 unsigned int vhost_get_free_memslots(void);
 
-- 
2.49.0


