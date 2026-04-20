Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D29BF5A8BB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEv6t-00061P-0G; Mon, 20 Apr 2026 16:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6r-00060W-Gg
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:45 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wEv6n-0006NO-LQ
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:20:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CD690C01A6;
 Mon, 20 Apr 2026 23:20:37 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:54b::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id XKYwe10MOSw0-y7QnYXff; Mon, 20 Apr 2026 23:20:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1776716437;
 bh=AFJKds80zAM8tJhj7L+RUZobVEy2LlbiGfFbnCHLRXw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ff3wbagOoq9zhEXu6+sWUshFUM+6GIfX1WyMwmnGdWE2xDnD0mXMMR+Z4v+YIQgdc
 bsM/C5AmdckZWVVO1j2FJWqSuxxDDVCRMQJbxQuXWOu7N8H3VBqTWaun7sFMbHLnXr
 OXbFSa32XpW37h5VpgYI1mnnw/Q0QbVZyuxHqF2c=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH v2 01/10] vhost: move IOTLB functions from vhost-backend.c to
 vhost.c
Date: Mon, 20 Apr 2026 23:20:22 +0300
Message-ID: <20260420202032.714884-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260420202032.714884-1-vsementsov@yandex-team.ru>
References: <20260420202032.714884-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move and rename vhost_backend_update_device_iotlb(),
vhost_backend_invalidate_device_iotlb(), and
vhost_backend_handle_iotlb_msg() from vhost-backend.c to vhost.c.
vhost-backend.c is actually about vhost-kernel backend. But these
functions are shared with vhost-user, so let's move them into
generic place. Moreover, two of three functions becomes static as
they are used only in vhost.c.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-backend.c         | 82 +----------------------------
 hw/virtio/vhost-user.c            |  2 +-
 hw/virtio/vhost.c                 | 85 +++++++++++++++++++++++++++++--
 include/hw/virtio/vhost-backend.h | 11 ----
 include/hw/virtio/vhost.h         |  2 +
 5 files changed, 86 insertions(+), 96 deletions(-)

diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 4367db0d951..fea88afc39a 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -298,7 +298,7 @@ static void vhost_kernel_iotlb_read(void *opaque)
                 break;
             }
 
-            vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
+            vhost_handle_iotlb_msg(dev, &msg.iotlb);
         }
     } else {
         struct vhost_msg msg;
@@ -313,7 +313,7 @@ static void vhost_kernel_iotlb_read(void *opaque)
                 break;
             }
 
-            vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
+            vhost_handle_iotlb_msg(dev, &msg.iotlb);
         }
     }
 }
@@ -392,81 +392,3 @@ const VhostOps kernel_ops = {
         .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
 };
 #endif
-
-int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
-                                             uint64_t iova, uint64_t uaddr,
-                                             uint64_t len,
-                                             IOMMUAccessFlags perm)
-{
-    struct vhost_iotlb_msg imsg;
-
-    imsg.iova =  iova;
-    imsg.uaddr = uaddr;
-    imsg.size = len;
-    imsg.type = VHOST_IOTLB_UPDATE;
-
-    switch (perm) {
-    case IOMMU_RO:
-        imsg.perm = VHOST_ACCESS_RO;
-        break;
-    case IOMMU_WO:
-        imsg.perm = VHOST_ACCESS_WO;
-        break;
-    case IOMMU_RW:
-        imsg.perm = VHOST_ACCESS_RW;
-        break;
-    default:
-        return -EINVAL;
-    }
-
-    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
-        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
-
-    return -ENODEV;
-}
-
-int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
-                                                 uint64_t iova, uint64_t len)
-{
-    struct vhost_iotlb_msg imsg;
-
-    imsg.iova = iova;
-    imsg.size = len;
-    imsg.type = VHOST_IOTLB_INVALIDATE;
-
-    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg)
-        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
-
-    return -ENODEV;
-}
-
-int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
-                                          struct vhost_iotlb_msg *imsg)
-{
-    int ret = 0;
-
-    if (unlikely(!dev->vdev)) {
-        error_report("Unexpected IOTLB message when virtio device is stopped");
-        return -EINVAL;
-    }
-
-    switch (imsg->type) {
-    case VHOST_IOTLB_MISS:
-        ret = vhost_device_iotlb_miss(dev, imsg->iova,
-                                      imsg->perm != VHOST_ACCESS_RO);
-        break;
-    case VHOST_IOTLB_ACCESS_FAIL:
-        /* FIXME: report device iotlb error */
-        error_report("Access failure IOTLB message type not supported");
-        ret = -ENOTSUP;
-        break;
-    case VHOST_IOTLB_UPDATE:
-    case VHOST_IOTLB_INVALIDATE:
-    default:
-        error_report("Unexpected IOTLB message type");
-        ret = -EINVAL;
-        break;
-    }
-
-    return ret;
-}
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 4fb136b7b37..6978d8ee947 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1901,7 +1901,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
 
     switch (hdr.request) {
     case VHOST_USER_BACKEND_IOTLB_MSG:
-        ret = vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
+        ret = vhost_handle_iotlb_msg(dev, &payload.iotlb);
         break;
     case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:
         ret = vhost_user_backend_handle_config_change(dev);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c610007e812..4d42f8bda41 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -916,14 +916,92 @@ static void vhost_region_addnop(MemoryListener *listener,
     vhost_region_add_section(dev, section);
 }
 
+static int vhost_update_device_iotlb(struct vhost_dev *dev,
+                                     uint64_t iova, uint64_t uaddr,
+                                     uint64_t len,
+                                     IOMMUAccessFlags perm)
+{
+    struct vhost_iotlb_msg imsg;
+
+    imsg.iova =  iova;
+    imsg.uaddr = uaddr;
+    imsg.size = len;
+    imsg.type = VHOST_IOTLB_UPDATE;
+
+    switch (perm) {
+    case IOMMU_RO:
+        imsg.perm = VHOST_ACCESS_RO;
+        break;
+    case IOMMU_WO:
+        imsg.perm = VHOST_ACCESS_WO;
+        break;
+    case IOMMU_RW:
+        imsg.perm = VHOST_ACCESS_RW;
+        break;
+    default:
+        return -EINVAL;
+    }
+
+    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg) {
+        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+    }
+
+    return -ENODEV;
+}
+
+static int vhost_invalidate_device_iotlb(struct vhost_dev *dev,
+                                         uint64_t iova, uint64_t len)
+{
+    struct vhost_iotlb_msg imsg;
+
+    imsg.iova = iova;
+    imsg.size = len;
+    imsg.type = VHOST_IOTLB_INVALIDATE;
+
+    if (dev->vhost_ops && dev->vhost_ops->vhost_send_device_iotlb_msg) {
+        return dev->vhost_ops->vhost_send_device_iotlb_msg(dev, &imsg);
+    }
+
+    return -ENODEV;
+}
+
+int vhost_handle_iotlb_msg(struct vhost_dev *dev, struct vhost_iotlb_msg *imsg)
+{
+    int ret = 0;
+
+    if (unlikely(!dev->vdev)) {
+        error_report("Unexpected IOTLB message when virtio device is stopped");
+        return -EINVAL;
+    }
+
+    switch (imsg->type) {
+    case VHOST_IOTLB_MISS:
+        ret = vhost_device_iotlb_miss(dev, imsg->iova,
+                                      imsg->perm != VHOST_ACCESS_RO);
+        break;
+    case VHOST_IOTLB_ACCESS_FAIL:
+        /* FIXME: report device iotlb error */
+        error_report("Access failure IOTLB message type not supported");
+        ret = -ENOTSUP;
+        break;
+    case VHOST_IOTLB_UPDATE:
+    case VHOST_IOTLB_INVALIDATE:
+    default:
+        error_report("Unexpected IOTLB message type");
+        ret = -EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
 static void vhost_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
 {
     struct vhost_iommu *iommu = container_of(n, struct vhost_iommu, n);
     struct vhost_dev *hdev = iommu->hdev;
     hwaddr iova = iotlb->iova + iommu->iommu_offset;
 
-    if (vhost_backend_invalidate_device_iotlb(hdev, iova,
-                                              iotlb->addr_mask + 1)) {
+    if (vhost_invalidate_device_iotlb(hdev, iova, iotlb->addr_mask + 1)) {
         error_report("Fail to invalidate device iotlb");
     }
 }
@@ -1304,8 +1382,7 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         len = MIN(iotlb.addr_mask + 1, len);
         iova = iova & ~iotlb.addr_mask;
 
-        ret = vhost_backend_update_device_iotlb(dev, iova, uaddr,
-                                                len, iotlb.perm);
+        ret = vhost_update_device_iotlb(dev, iova, uaddr, len, iotlb.perm);
         if (ret) {
             trace_vhost_iotlb_miss(dev, 4);
             error_report("Fail to update device iotlb");
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ff94fa17342..57497e197aa 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -222,17 +222,6 @@ typedef struct VhostOps {
     vhost_check_device_state_op vhost_check_device_state;
 } VhostOps;
 
-int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
-                                             uint64_t iova, uint64_t uaddr,
-                                             uint64_t len,
-                                             IOMMUAccessFlags perm);
-
-int vhost_backend_invalidate_device_iotlb(struct vhost_dev *dev,
-                                                 uint64_t iova, uint64_t len);
-
-int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
-                                          struct vhost_iotlb_msg *imsg);
-
 int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
 
 int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 54862f9b445..b292e9f0fed 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -403,6 +403,8 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
 bool vhost_dev_has_iommu(struct vhost_dev *dev);
+int vhost_handle_iotlb_msg(struct vhost_dev *dev, struct vhost_iotlb_msg *imsg);
+
 
 static inline bool vhost_dev_has_feature(struct vhost_dev *dev,
                                          uint64_t feature)
-- 
2.52.0


