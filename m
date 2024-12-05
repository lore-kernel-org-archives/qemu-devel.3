Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C63AE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIZE-000681-0Q; Thu, 05 Dec 2024 15:35:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZC-00067d-Ml
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:18 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1tJIZA-0004oe-MW
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:18 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ee6abf124aso1160332a91.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733430915; x=1734035715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOxyT26bcT3QQMndkO+7h+Piz5kcLrsCzZSCVUpRwzM=;
 b=Qpbih514ovEt4CI0288X5eq4GdZJR8ULYahsw+UwbPu4uxmDsxpKt7GD1K/Nnn+vjJ
 C1LF5fJELT9Wvjxx7K/pw+k0PzS4oKIcmAPpkQUiqye3vgpEz/hRTgYcH4qlWZXp0Xau
 OPEoAhwozBkcdJzT9sRKiHHytitKhutcgKi4qvJmVBrtc+xyNJqU94FhUxRKIyrgRmOy
 Am+jPoWUxijW8UbPxY5wIZJdpddya4riwYuCHq7sGu3E6ToP4AMhA0aLn+eGByqCWxEN
 ljdBoVcIjT02gtJCMRcECKjkls0le/7VGIA1KWF/PvtFrpWMqsb39pOwiHQ1Q5dBw8Qz
 Qz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430915; x=1734035715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOxyT26bcT3QQMndkO+7h+Piz5kcLrsCzZSCVUpRwzM=;
 b=XwrNyUT7pqmfl5BuFBL3OMmCsk1SBw33wyVvaAmvnR5aJfU4s6YzFM+EyHD2MOfaJ8
 XN6AKDnpzq0o0Mv9LDcdomwzlIVP0p48w4uOc2ewJUf4yiSQbXZdTBjdk6R1gVLIK9Vv
 QtZMK9a4nUmgqCVKckeAr6tPcatRR1HTDvoKK/eJEZ6d02G3SqtBJ+tXJ9WIJzeyQmvK
 paCnha4oQ65DiVGb0EvoGm3yNp5+IdAqjWtMwrR3CS//YPUWXQtEcz3UkmPUa/82pHeF
 QzzxX1RCE5vbVMw85GidP+kIUbHg0PLcSeRDcBSB/W2i/YweF6W9PJULchNkXDgnnlLt
 gvSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDShIvSKvnjlBu+H8bERiSKcZ6wmaSGWAp0EOR6yGCvy65lMNxU6E96A1UhZ8Ono8/ZaMc3ipgqFZk@nongnu.org
X-Gm-Message-State: AOJu0YwCKhtIKaOPShonZLkskOF9lWggPsjDqyZhgt0L62PIEL22mHc8
 oYbauMY2dWur9r4uco9T5RPHnWDAHhV7TvohZA+MwociUYe690cD17ZkyQ==
X-Gm-Gg: ASbGncuqQ59ZZ3upjotiytNAY/Qy6iwqoCC87ahdKjLI8GVmkyyRBB/TW2A4jJJPTz1
 hDkpEkCiI4SPt2iucZ/ZPQ9dE4zLxpwskVgWduFxXiWInO8SWtYAoJCIhZ3g4qYLnwg4ubEtvt0
 UtU1nx1DZga4CTGgNU4ep9T+MgLOVXy00MXQvJ3gY360sHa7OnD3viTIF8VB9gGWJWGvTMGu+95
 LaObaH0YLChRdoton+L1aPfBMX2yQGrwYohuGkftB4=
X-Google-Smtp-Source: AGHT+IElkhleK7Y17x5rBUWKryBptOUqd5yjC77Of3O3BhGm0tFCuGgaSjYdyGz/UdDlQLdSb6QSAQ==
X-Received: by 2002:a17:90b:37c5:b0:2ee:f687:6adb with SMTP id
 98e67ed59e1d1-2ef6956008bmr747090a91.3.1733430915319; 
 Thu, 05 Dec 2024 12:35:15 -0800 (PST)
Received: from valdaarhun.. ([2409:4081:2c01:b2be:f39d:e902:7582:5526])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef2701c2f2sm3705905a91.23.2024.12.05.12.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:35:14 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
X-Google-Original-From: Sahil Siddiq <sahilcdq@proton.me>
To: eperezma@redhat.com,
	sgarzare@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, Sahil Siddiq <sahilcdq@proton.me>
Subject: [RFC v4 4/5] vdpa: Allocate memory for svq and map them to vdpa
Date: Fri,  6 Dec 2024 02:04:29 +0530
Message-ID: <20241205203430.76251-5-sahilcdq@proton.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205203430.76251-1-sahilcdq@proton.me>
References: <20241205203430.76251-1-sahilcdq@proton.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allocate memory for the packed vq format and map them to the vdpa
device.

Since "struct vring" and "struct vring_packed's vring" both have
the same layout memory, the implementation in svq start and svq
stop should not differ based on the vq's format.

Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
---
Changes v3 -> v4:
- Based on commit #3 of v3.
- vhost-shadow-virtqueue.c
  (vhost_svq_memory_packed): Remove function.
  (vhost_svq_driver_area_size,vhost_svq_descriptor_area_size): Decouple functions.
  (vhost_svq_device_area_size): Rewrite function.
  (vhost_svq_start): Simplify implementation.
  (vhost_svq_stop): Unconditionally munmap().
- vhost-shadow-virtqueue.h: New function declaration.
- vhost-vdpa.c
  (vhost_vdpa_svq_unmap_rings): Call vhost_vdpa_svq_unmap_ring().
  (vhost_vdpa_svq_map_rings): New mappings.

 hw/virtio/vhost-shadow-virtqueue.c | 47 ++++++++++++++++++++----------
 hw/virtio/vhost-shadow-virtqueue.h |  1 +
 hw/virtio/vhost-vdpa.c             | 34 +++++++++++++++++----
 3 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 6eee01ab3c..be06b12c9a 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -314,7 +314,7 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
         return -EINVAL;
     }
 
-    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
+    if (svq->is_packed) {
         vhost_svq_add_packed(svq, out_sg, out_num, in_sg,
                              in_num, sgs, &qemu_head);
     } else {
@@ -661,19 +661,33 @@ void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
     addr->used_user_addr = (uint64_t)(uintptr_t)svq->vring.used;
 }
 
-size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
+size_t vhost_svq_descriptor_area_size(const VhostShadowVirtqueue *svq)
 {
     size_t desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    size_t avail_size = offsetof(vring_avail_t, ring[svq->vring.num]) +
-                                                              sizeof(uint16_t);
+    return ROUND_UP(desc_size, qemu_real_host_page_size());
+}
 
-    return ROUND_UP(desc_size + avail_size, qemu_real_host_page_size());
+size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq)
+{
+    size_t avail_size;
+    if (svq->is_packed) {
+        avail_size = sizeof(uint32_t);
+    } else {
+        avail_size = offsetof(vring_avail_t, ring[svq->vring.num]) +
+                                                             sizeof(uint16_t);
+    }
+    return ROUND_UP(avail_size, qemu_real_host_page_size());
 }
 
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq)
 {
-    size_t used_size = offsetof(vring_used_t, ring[svq->vring.num]) +
-                                                              sizeof(uint16_t);
+    size_t used_size;
+    if (svq->is_packed) {
+        used_size = sizeof(uint32_t);
+    } else {
+        used_size = offsetof(vring_used_t, ring[svq->vring.num]) +
+                                                           sizeof(uint16_t);
+    }
     return ROUND_UP(used_size, qemu_real_host_page_size());
 }
 
@@ -718,8 +732,6 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd)
 void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
                      VirtQueue *vq, VhostIOVATree *iova_tree)
 {
-    size_t desc_size;
-
     event_notifier_set_handler(&svq->hdev_call, vhost_svq_handle_call);
     svq->next_guest_avail_elem = NULL;
     svq->shadow_avail_idx = 0;
@@ -728,20 +740,22 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, VirtIODevice *vdev,
     svq->vdev = vdev;
     svq->vq = vq;
     svq->iova_tree = iova_tree;
+    svq->is_packed = virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED);
 
     svq->vring.num = virtio_queue_get_num(vdev, virtio_get_queue_index(vq));
     svq->num_free = svq->vring.num;
-    svq->vring.desc = mmap(NULL, vhost_svq_driver_area_size(svq),
+    svq->vring.desc = mmap(NULL, vhost_svq_descriptor_area_size(svq),
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
-    desc_size = sizeof(vring_desc_t) * svq->vring.num;
-    svq->vring.avail = (void *)((char *)svq->vring.desc + desc_size);
+    svq->vring.avail = mmap(NULL, vhost_svq_driver_area_size(svq),
+                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
+                            -1, 0);
     svq->vring.used = mmap(NULL, vhost_svq_device_area_size(svq),
                            PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS,
                            -1, 0);
-    svq->desc_state = g_new0(SVQDescState, svq->vring.num);
-    svq->desc_next = g_new0(uint16_t, svq->vring.num);
-    for (unsigned i = 0; i < svq->vring.num - 1; i++) {
+    svq->desc_state = g_new0(SVQDescState, svq->num_free);
+    svq->desc_next = g_new0(uint16_t, svq->num_free);
+    for (unsigned i = 0; i < svq->num_free - 1; i++) {
         svq->desc_next[i] = cpu_to_le16(i + 1);
     }
 }
@@ -781,7 +795,8 @@ void vhost_svq_stop(VhostShadowVirtqueue *svq)
     svq->vq = NULL;
     g_free(svq->desc_next);
     g_free(svq->desc_state);
-    munmap(svq->vring.desc, vhost_svq_driver_area_size(svq));
+    munmap(svq->vring.desc, vhost_svq_descriptor_area_size(svq));
+    munmap(svq->vring.avail, vhost_svq_driver_area_size(svq));
     munmap(svq->vring.used, vhost_svq_device_area_size(svq));
     event_notifier_set_handler(&svq->hdev_call, NULL);
 }
diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index ce89bafedc..6c0e0c4f67 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -151,6 +151,7 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick_fd);
 void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
 void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
                               struct vhost_vring_addr *addr);
+size_t vhost_svq_descriptor_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
 size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 3cdaa12ed5..97ed569792 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1134,6 +1134,8 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
 
     vhost_vdpa_svq_unmap_ring(v, svq_addr.desc_user_addr);
 
+    vhost_vdpa_svq_unmap_ring(v, svq_addr.avail_user_addr);
+
     vhost_vdpa_svq_unmap_ring(v, svq_addr.used_user_addr);
 }
 
@@ -1181,38 +1183,58 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
                                      Error **errp)
 {
     ERRP_GUARD();
-    DMAMap device_region, driver_region;
+    DMAMap descriptor_region, device_region, driver_region;
     struct vhost_vring_addr svq_addr;
     struct vhost_vdpa *v = dev->opaque;
+    size_t descriptor_size = vhost_svq_descriptor_area_size(svq);
     size_t device_size = vhost_svq_device_area_size(svq);
     size_t driver_size = vhost_svq_driver_area_size(svq);
-    size_t avail_offset;
     bool ok;
 
     vhost_svq_get_vring_addr(svq, &svq_addr);
 
-    driver_region = (DMAMap) {
+    descriptor_region = (DMAMap) {
         .translated_addr = svq_addr.desc_user_addr,
+        .size = descriptor_size - 1,
+        .perm = IOMMU_RO,
+    };
+    if (svq->is_packed) {
+        descriptor_region.perm = IOMMU_RW;
+    }
+
+    ok = vhost_vdpa_svq_map_ring(v, &descriptor_region, errp);
+    if (unlikely(!ok)) {
+        error_prepend(errp, "Cannot create vq descriptor region: ");
+        return false;
+    }
+    addr->desc_user_addr = descriptor_region.iova;
+
+    driver_region = (DMAMap) {
+        .translated_addr = svq_addr.avail_user_addr,
         .size = driver_size - 1,
         .perm = IOMMU_RO,
     };
     ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq driver region: ");
+        vhost_vdpa_svq_unmap_ring(v, descriptor_region.translated_addr);
         return false;
     }
-    addr->desc_user_addr = driver_region.iova;
-    avail_offset = svq_addr.avail_user_addr - svq_addr.desc_user_addr;
-    addr->avail_user_addr = driver_region.iova + avail_offset;
+    addr->avail_user_addr = driver_region.iova;
 
     device_region = (DMAMap) {
         .translated_addr = svq_addr.used_user_addr,
         .size = device_size - 1,
         .perm = IOMMU_RW,
     };
+    if (svq->is_packed) {
+        device_region.perm = IOMMU_WO;
+    }
+
     ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
     if (unlikely(!ok)) {
         error_prepend(errp, "Cannot create vq device region: ");
+        vhost_vdpa_svq_unmap_ring(v, descriptor_region.translated_addr);
         vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
     }
     addr->used_user_addr = device_region.iova;
-- 
2.47.0


