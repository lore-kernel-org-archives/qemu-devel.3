Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0F9CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqBf-0003rW-L6; Sun, 14 Jun 2026 15:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBd-0003gG-BA
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqBb-00023c-3v
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+GuTh5V0GuOw0obJKJe9L/Do0KN5TpKDxtGQn1t1Hdw=;
 b=NLmLaukxhUJW75MFb5bRVzk0XU3hpqSIvsib/G7vR60SyIRF+aECp6FBN4efvvjFL9qC73
 XbjxK3thZEqklJtJFKsHnx4jk1TTNAg+VZ42eepkkEaRAGtTtImR2uN7hmNHbNJQioHztR
 bf2QcmWJUUULIZufcBNMfc3PBmU4YZc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-26ruouRpPvS7b80zeFc_og-1; Sun, 14 Jun 2026 15:07:56 -0400
X-MC-Unique: 26ruouRpPvS7b80zeFc_og-1
X-Mimecast-MFC-AGG-ID: 26ruouRpPvS7b80zeFc_og_1781464076
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b37e1f48so17506915e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464075; x=1782068875; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+GuTh5V0GuOw0obJKJe9L/Do0KN5TpKDxtGQn1t1Hdw=;
 b=VR+ShwY5GsgBYbS1PVvRl78pDVAeSQJ74DUAaPhsj4xdssRUKSJLRxbW8bhF+2LRYm
 r6DWEGriT9gofb21shf92VwNKKfVTJDZ+MszG5SgPRPsRnjo6rUV2GmihoyjZdlHWlQ/
 35ERFrGKe4kZDYYLBs0DPVaZ7GOhthR+mal3xKR4VCgEQ+ix/LpkzGlGDzLh7Evskbyc
 tzWwJGZJwzVx8H4ddzba2frCLVSNdIOmTryOFhK+C7F1q6uFfz3ZsWYw5THTxYomk/GI
 OX4GMCi4E3c/lJxWUX5p0UHxnMgXK4S6exycSQ24pgb4ty4zbeU24lquDx4NUoqgq8+D
 9lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464075; x=1782068875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GuTh5V0GuOw0obJKJe9L/Do0KN5TpKDxtGQn1t1Hdw=;
 b=E/lKdtcKkGN1ADkGYraMOHh9R3ndaMHAbwNkuwJS1hYSWcq3HEtvphLJ9yBRmMp3GZ
 FNTHYo2G/pbLd3o4fPemR/7JSDHyLikAK6widvMYyk92X1KVaraiQ8wOumqdolj8EzSB
 SPkeLpgV7K45RqSWdN3Z3MpexuanG6wZW2/nF8x+VPIj7F5rzuVKxdu/Fav7fuWpvS+M
 y+749HqS3igAr+ayIJvV+1tAp6enZzCfYYJg3F8E6pPW6jf5iG7nT6NlftmQvXczfVnO
 cxHo8FfTJsAUboiNZt0qUvDJtJeuO7989uORRWBwqSm2FqWNJ5i3kK5UyIh0//Yjd78L
 xBjw==
X-Gm-Message-State: AOJu0YxOdLgnF7fz+k5HdaXc/rphiScQiF2GH0EFsE+fBtTas9OqFV7G
 eQigdIeCyHcRTfIOszLKePbckgsr1rBvQZxCKztkOBO8Kzw0H2iCpp+E2YJ3KAwyhv91741jN7S
 uABnVNK/n+//VoLd1xoeeIy0Un8bVBRCChY2pgxp7B8uCu2gGvb2Q2f+XfV7E5Vn+K2aJHF8gf2
 taW0fPYG7ysgMcND8Br2JJp3pV+sob/F7QoQ==
X-Gm-Gg: Acq92OH6LTJtXGU+90brEZIq/Ek8TwcbKC2Zaxk5FgR+SSrN6Q0lxLo1Leiy7VyrW1C
 OaOUIaPEPMsG7aTttY/7afXVOi5cfXIEcSg+Oswb9H7hPhgjyoXxcr8Wb7rRWwbeMgul+h1Zvss
 gb09Ovl+21d4QfOdSLM/oHEBtwOmKXBK6Sh/4cb4qZEHrr/bqME36u0aanhh0vGfWFwBb86r3+u
 70ZiMTDfvLuQoFiMf6+o2UcD64pANBcgjiht+9UhIiXbzKHcels9CBER8lfMLnCwqVE99eHtlDq
 h5Qavqh39zE2TQs07UqAyTorKO4S4z7jKDgnrM0srb7UPl3C0E6iY3ft5BJcI6W66TQSkJOEl4f
 uqksh2UPGV9V6bXl6A41BRcdteryFo2owv9xFXzKz5Ek=
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4922006283cmr65638135e9.14.1781464075379; 
 Sun, 14 Jun 2026 12:07:55 -0700 (PDT)
X-Received: by 2002:a05:600c:6542:b0:48a:93f8:dd02 with SMTP id
 5b1f17b1804b1-4922006283cmr65637745e9.14.1781464074772; 
 Sun, 14 Jun 2026 12:07:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922034c1cbsm151846345e9.10.2026.06.14.12.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:54 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 049/106] vhost: move IOTLB functions from vhost-backend.c to
 vhost.c
Message-ID: <e86a41c24adb0391b6d3de8d3f58d9fc044ff9b7.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Move and rename vhost_backend_update_device_iotlb(),
vhost_backend_invalidate_device_iotlb(), and
vhost_backend_handle_iotlb_msg() from vhost-backend.c to vhost.c.
vhost-backend.c is actually about vhost-kernel backend. But these
functions are shared with vhost-user, so let's move them into
generic place. Moreover, two of three functions becomes static as
they are used only in vhost.c.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260206095258.894504-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420202032.714884-2-vsementsov@yandex-team.ru>
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
index 4fb136b7b3..6978d8ee94 100644
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
index c610007e81..4d42f8bda4 100644
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
MST


