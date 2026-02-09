Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1402CE7C708
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLrn-0000oQ-Bg; Mon, 09 Feb 2026 02:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLre-0000mi-Aj
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:22 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vpLrb-0004fS-AX
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:39:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CBE3F80751;
 Mon, 09 Feb 2026 10:39:13 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:129::1:13])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BdLXu72As8c0-caXWZhEF; Mon, 09 Feb 2026 10:39:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770622753;
 bh=3kxGtFXbKikU8OlPh4Hj+Z2jzgQgrrcTkLfiKZ+gvMU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ISHpSFt3/iOXd4SIspG3+CCv69dnxFPLDjm9TwN31tPByqWKAx/BRvZylaGM1JPzK
 eo/8+cUkvufGxAS+f2j9gYjPp6DtWwOOZvdy70JjCG7Dx3DomBIbIbKCcOvuv9Nk8q
 n57EpKFyv5on3uG8TWaU7NyWNDMU5ZzuEOrmLUzc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: [PATCH 01/10] vhost: move IOTLB functions from vhost-backend.c to
 vhost.c
Date: Mon,  9 Feb 2026 10:38:58 +0300
Message-ID: <20260209073908.2125178-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
References: <20260209073908.2125178-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
index 4367db0d95..fea88afc39 100644
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
index e820c5cb93..c750b32617 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1906,7 +1906,7 @@ static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
 
     switch (hdr.request) {
     case VHOST_USER_BACKEND_IOTLB_MSG:
-        ret = vhost_backend_handle_iotlb_msg(dev, &payload.iotlb);
+        ret = vhost_handle_iotlb_msg(dev, &payload.iotlb);
         break;
     case VHOST_USER_BACKEND_CONFIG_CHANGE_MSG:
         ret = vhost_user_backend_handle_config_change(dev);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9bf932eaf9..3ee353dce0 100644
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
@@ -1306,8 +1384,7 @@ int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write)
         len = MIN(iotlb.addr_mask + 1, len);
         iova = iova & ~iotlb.addr_mask;
 
-        ret = vhost_backend_update_device_iotlb(dev, iova, uaddr,
-                                                len, iotlb.perm);
+        ret = vhost_update_device_iotlb(dev, iova, uaddr, len, iotlb.perm);
         if (ret) {
             trace_vhost_iotlb_miss(dev, 4);
             error_report("Fail to update device iotlb");
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index ff94fa1734..57497e197a 100644
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
index 54862f9b44..b292e9f0fe 100644
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


