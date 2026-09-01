Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC17FC624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1NE1-0001zt-TU; Tue, 01 Sep 2026 08:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x1NE0-0001yo-H4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1x1NDy-00074k-KB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 08:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788264261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIcgWeDHp3iKmGpW6Lgkcfewds7jzt3Io0gG8YUmjcw=;
 b=Wx+0TLf2miFVkZIPOCtlSa/fF2PUhmPvAcjeKSnaWUjoqJzpc+gmfWMXEIIkf1pe3Lqmtm
 +QTEJs3dnUQSNkX0qN9lZ86O9kwgW/wbkUOcUIwipNQgeiYtmhmKYPr25Vd4pUwbbozgkG
 niUfku8xr4N37SwJHZCZO98dIzho5po=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Mglzu5xwMKqwaISloFII9g-1; Tue,
 01 Sept 2026 08:04:18 -0400
X-MC-Unique: Mglzu5xwMKqwaISloFII9g-1
X-Mimecast-MFC-AGG-ID: Mglzu5xwMKqwaISloFII9g_1788264257
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DABB19775FB; Tue,  1 Sep 2026 12:04:17 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A4351955F01; Tue,  1 Sep 2026 12:04:14 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 01 Sep 2026 14:04:06 +0200
Subject: [PATCH v2 3/3] hw/display/vhost-user-media: add shared memory
 region BAR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-virtio-media-v2-3-bd3cc9347ab9@redhat.com>
References: <20260901-virtio-media-v2-0-bd3cc9347ab9@redhat.com>
In-Reply-To: <20260901-virtio-media-v2-0-bd3cc9347ab9@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Albert Esteve <aesteve@redhat.com>, manos.pitsidianakis@linaro.org, 
 alex.bennee@linaro.org, Dorinda Bassey <dbassey@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264246; l=6072;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=zIDnrimJu8SaF2bdSpoMB7As/XRQmE0mPXSQDHEFYng=;
 b=eLXzVQ1dNwpXua19FqgODBiowT1446Hl0cWR8mMIbsiCfmA7pJat8tNTtIf+BKnlV/VgeIFTq
 AASWNyYEGEbDCefgBzkvxi75qi4rAwrsunZewYt3oA8lVsgYCWP1CSd
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/display/vhost-user-media-pci.c | 35 ++++++++++++++++++++++++++++++++
 hw/display/vhost-user-media.c     | 42 ++++++++++++++++++++++++++++++++++++++-
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
2.55.0


