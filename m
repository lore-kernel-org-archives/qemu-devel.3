Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A987C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8p-0001oz-2R; Fri, 11 Sep 2026 05:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8f-0001fb-D1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8d-000822-Ir
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HW5dHu/luwrYtl1kcOiBVGsiXZR8UnfoA5Cn0Bb40EU=;
 b=VbOnRUSONPTQMeeprNRvcpe39VzQbMnssePFUDfQZm2CaiVqraWk46BkkzNN3FGXfefdRh
 tIxbMzFS3PhfoIVKeIcuBAMFTOnJWJyZ1GbXhtYKO1JKEVndk2dR547mpPguYhST4GbVTK
 GY9jnreyuBM56zESq4YH0kUGBAcRkOo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-1rP5fKtgPT6D0NV4i9DHVg-1; Fri, 11 Sep 2026 05:01:37 -0400
X-MC-Unique: 1rP5fKtgPT6D0NV4i9DHVg-1
X-Mimecast-MFC-AGG-ID: 1rP5fKtgPT6D0NV4i9DHVg_1789117296
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4955e865174so2881855e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117296; x=1789722096; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HW5dHu/luwrYtl1kcOiBVGsiXZR8UnfoA5Cn0Bb40EU=;
 b=VxmN/9KEMtxYLSaMgX/WHS0gsUzihW6YsBW8/tTsJFopRIdjc9XZX65RQLMRNMXTgE
 1htf+Pe++zp1bkcpyz1DCVsZ2FC3L3+mLzOfDG8m7vJLWOz97OqN7AJ1I8AIyOYU1/tG
 ixwyNtrJzJ+g5Gg/Fxu1PmnSCQFijmomvzJ3zF/q03hNasjqyy3DzwZPPuHM/Mw0NBFi
 YKu7Ys1uRhFmJgEPpKkK0geouP+TGbJ6e02PleRBLxSrtfNhrJDHwtsuP/jy4DceNs67
 wayhG21yKcrX8lJiSXflov0Ad+fl6VqKJe7mmPOASiP/FQfeH4IzXYcp895lfHcB4IFq
 hjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117296; x=1789722096;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HW5dHu/luwrYtl1kcOiBVGsiXZR8UnfoA5Cn0Bb40EU=;
 b=N5DSMaOsN1CPZ4fFgLn6J3PDHU8Y8LuKOjTVTXXBxD7/0PB/7qxoQR06v2dRggyvax
 RRCax3knNB/lDjgRYQGcOyr3wxeOEGIBjzuZ52FUHRawKgWg4DXqJP5Dhe2RvV5eeRo0
 tJY9ubvY28dtvTV9TuqXokP42dJMwzLJPgVRkOOFeGoZNee7y9CbHC+JQXdRrziL+Lwg
 ACcHxF1AXQ6xvfHZDFgVqnaK943UEtLApst7qga2XlyLSJ6QAsnEIpalTKO2jbctAKpF
 6AmLyjBwWvJIgZbA2iAcKxpmgn8ANqunf6LsjaqXsZ5bwaOOoD9cJRuv0G4DhKH3PyuD
 8VKQ==
X-Gm-Message-State: AFuF++k5CYyjzZjD+bIRKt/2KnAyJZx28WvJ5AK+frxFV53skLV6C8EU
 eUnqjzyA2WojrRNoeGqXN5C+YYx6wXE9NNnH0QUWA87GGptCs/onNfkTUj3Rrskvj6oID+3cYEy
 Ojp7PJjELJX+FIiY+ESHgzmkvdVYuHMue3WVPx0lbhj/Kl905Rg34h1FGzUMYl0ksTPBpGK2Aee
 BYfoYj3TiMbBfIKutdd3wGastREMtuPWi1Xw==
X-Gm-Gg: AYBFou1J6/CiSfB7KGDbvv4cCOdyOeuY1MABDOLdW7xLvvRH88NAHAEJ9go1Oyx0orL
 9djbqIHYQ18Eaps8WjiEEuAgXhaBn4lmj1IDQZnyoUSMr6pJecSE85CGJ1eN1sVoToBCPcImkGy
 DgGcFznaoIT0yCA3lvGJpSRvGY3+70SCsVge5y9A/cBg1SN0KMAZN9V2ZvFcdGFG3CPvFYX0Ar3
 LtGUc+vgl0arho4tcEfwX9YzYMVw1R3f5fhtRPJQqWOQPRzP0350gdr/DOdDtR/T6K/zAYKxpRs
 ux9Un1NeNe5yeI0xAfRHp40sgtkHa+DXQZRbEE8yDgDXBv5G3UqFshPkP+MwscA+Z8Bj2efdHlU
 tCGUpGqkFmLDsoUCPDNeDL/s=
X-Received: by 2002:a05:600c:c4a8:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49e619e0f7amr31508935e9.21.1789117295828; 
 Fri, 11 Sep 2026 02:01:35 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a8:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-49e619e0f7amr31508015e9.21.1789117294803; 
 Fri, 11 Sep 2026 02:01:34 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26be3e0asm147459325e9.1.2026.09.11.02.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:34 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL v2 07/75] hw/display/vhost-user-media: add shared memory
 region BAR
Message-ID: <6439ee6195d23d7bfdb366986bfdd24f7cdb19d6.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Albert Esteve <aesteve@redhat.com>

Expose virtio-media shared memory region 0 (spec 5.22.6.1.6) as a
prefetchable 64-bit PCI BAR (BAR 2) with a VirtIO shm capability.
The size is obtained through GET_SHMEM_CONFIG and requires at least
one shared region. The guest maps host-provisioned MMAP buffers into
this window; QEMU creates a container region on realize, not a
full-sized RAM allocation.

modern-pio-notify is rejected because it claims BAR 2.

vhost-user still needs shareable guest RAM, e.g.:

    -object memory-backend-memfd,id=mem,size=4G,share=on \
    -numa node,memdev=mem

Tested-by: Dorinda Bassey <dbassey@redhat.com>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260901-virtio-media-v2-3-bd3cc9347ab9@redhat.com>
---
 hw/display/vhost-user-media-pci.c | 35 ++++++++++++++++++++++++++
 hw/display/vhost-user-media.c     | 42 ++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/hw/display/vhost-user-media-pci.c b/hw/display/vhost-user-media-pci.c
index 3e09fcfdd0..7681f7505d 100644
--- a/hw/display/vhost-user-media-pci.c
+++ b/hw/display/vhost-user-media-pci.c
@@ -13,12 +13,18 @@
 #include "hw/virtio/vhost-user-media.h"
 #include "hw/virtio/virtio-pci.h"
 
+/* BAR 2 is used for the shared memory region exposed to the guest */
+#define VIRTIO_MEDIA_PCI_SHM_BAR 2
+
+#define VIRTIO_MEDIA_PCI_SHMCAP_ID_SHM 0
+
 #define TYPE_VHOST_USER_MEDIA_PCI "vhost-user-media-pci-base"
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserMEDIAPCI, VHOST_USER_MEDIA_PCI)
 
 struct VHostUserMEDIAPCI {
     VirtIOPCIProxy parent_obj;
     VHostUserMEDIA vdev;
+    MemoryRegion shmbar;
 };
 
 static const Property vumedia_pci_properties[] = {
@@ -32,14 +38,43 @@ static void vumedia_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserMEDIAPCI *dev = VHOST_USER_MEDIA_PCI(vpci_dev);
     DeviceState *dev_state = DEVICE(&dev->vdev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    VirtioSharedMemory *shmem;
+    uint64_t shm_size;
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors = 1;
     }
 
+    if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
+        error_setg(errp, "modern-pio-notify is not supported due to PCI BAR "
+                         "layout limitations");
+        return;
+    }
+
     if (!qdev_realize(dev_state, BUS(&vpci_dev->bus), errp)) {
         return;
     }
+
+    shmem = virtio_find_shmem_region(vdev, VIRTIO_MEDIA_PCI_SHMCAP_ID_SHM);
+    if (!shmem) {
+        error_setg(errp, "vhost-user-media: missing shared memory region");
+        return;
+    }
+    shm_size = memory_region_size(&shmem->mr);
+
+    memory_region_init(&dev->shmbar, OBJECT(vpci_dev),
+                       "vhost-media-pci-shmbar", shm_size);
+    memory_region_add_subregion(&dev->shmbar, 0, &shmem->mr);
+    virtio_pci_add_shm_cap(vpci_dev, VIRTIO_MEDIA_PCI_SHM_BAR, 0,
+                           shm_size, VIRTIO_MEDIA_PCI_SHMCAP_ID_SHM);
+
+    /* After 'realized' so the memory region exists */
+    pci_register_bar(&vpci_dev->pci_dev, VIRTIO_MEDIA_PCI_SHM_BAR,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &dev->shmbar);
 }
 
 static void vumedia_pci_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
index 14edc7c668..eaf99dc6a2 100644
--- a/hw/display/vhost-user-media.c
+++ b/hw/display/vhost-user-media.c
@@ -19,6 +19,7 @@
 #include "standard-headers/linux/virtio_ids.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-media.h"
+#include "migration/blocker.h"
 
 static const int feature_bits[] = {
     VIRTIO_F_VERSION_1,
@@ -259,8 +260,9 @@ static void vu_media_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserMEDIA *media = VHOST_USER_MEDIA(dev);
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
     struct vhost_virtqueue *vhost_vqs;
-    int ret;
+    int ret, nregions;
 
     if (!media->conf.chardev.chr) {
         error_setg(errp, "vhost-user-media: chardev is mandatory");
@@ -290,9 +292,47 @@ static void vu_media_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    ret = media->vhost_dev.vhost_ops->vhost_get_shmem_config(&media->vhost_dev,
+                                                             &nregions,
+                                                             memory_sizes,
+                                                             errp);
+    if (ret < 0) {
+        goto q_fail;
+    }
+
+    if (!nregions || !memory_sizes[0]) {
+        error_setg(errp, "vhost-user-media: backend did not provide "
+                         "shared memory region 0");
+        goto q_fail;
+    }
+
+    if (memory_sizes[0] % qemu_real_host_page_size() != 0) {
+        error_setg(errp, "shared memory region 0 size must be a multiple "
+                         "of the host page size");
+        goto q_fail;
+    }
+
+    if (media->vhost_dev.migration_blocker == NULL) {
+        error_setg(&media->vhost_dev.migration_blocker,
+                   "Migration disabled: devices with VIRTIO Shared Memory "
+                   "Regions do not support migration yet.");
+        ret = migrate_add_blocker_normal(&media->vhost_dev.migration_blocker,
+                                         errp);
+        if (ret < 0) {
+            goto q_fail;
+        }
+    }
+
+    virtio_new_shmem_region(vdev, 0, memory_sizes[0]);
+
     qemu_chr_fe_set_handlers(&media->conf.chardev, NULL,
                              NULL, vu_media_event,
                              NULL, (void *)dev, NULL, true);
+    return;
+
+q_fail:
+    vhost_dev_cleanup(&media->vhost_dev);
+    do_vhost_user_cleanup(vdev, media, vhost_vqs);
 }
 
 static void vu_media_device_unrealize(DeviceState *dev)
-- 
MST


