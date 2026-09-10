Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B556CC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4niQ-0005Ua-EB; Thu, 10 Sep 2026 18:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lW7-0006T9-Kz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVn-0004ha-2D
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HW5dHu/luwrYtl1kcOiBVGsiXZR8UnfoA5Cn0Bb40EU=;
 b=F+LnR/bQsKlx3L01kXI5utCG1oMmTOq72kJ4BqZ2L6bW7Z/XzJoDDK/9P4wqPkiMnzT9xL
 K4Xkgv6mvJGz2mff1vw9V8KCoEe5Sw5KyDsULQrX0xNbryYObBMhUjkJubM8sCFPP+uQFQ
 ukkaTkvWh/xD56qEEsh6gsrVFmDnXr8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-hvobuiZnO82XStHAEjacaQ-1; Thu, 10 Sep 2026 16:12:05 -0400
X-MC-Unique: hvobuiZnO82XStHAEjacaQ-1
X-Mimecast-MFC-AGG-ID: hvobuiZnO82XStHAEjacaQ_1789071124
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48436a5fb42so52191f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071124; x=1789675924; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HW5dHu/luwrYtl1kcOiBVGsiXZR8UnfoA5Cn0Bb40EU=;
 b=kh+2jypM8FI4Skx0Bm9m0tf0/ViVOZI+E+rwnxHSwNUU6i+N9yYsvft+ALdRGpNmEY
 s8hpZmRLlc+y0OR05q3sF8ki6Q+xNRjxx/uDM1aNIswws4W2ePKl9G2bLRa9QO419fkF
 bT4dppfhY4aqOWlj5nyhdy9xtd4XgwerWPlhGtuM1FH2YZlhntzu4f3LH3FcnJyyNZDb
 nRr9oYiE4QLSLRUAdVDl5kWlx0lRKxTLXXSeYGegOjud7GmdYazozpBBid5P6RmlhZzi
 IsKGhtqFFq61oDg8HUawQr/XJf8Vdee6gUYRI52So1hHOtBXp2ZkpbUU4jEtXNO9csmL
 PruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071124; x=1789675924;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HW5dHu/luwrYtl1kcOiBVGsiXZR8UnfoA5Cn0Bb40EU=;
 b=Vr70Mg/EfGCeR7vpjgecTyLOTGhvrMHLPbe7yfSLEjvmKqepFnsOnJ5kOAy7dqggQ5
 qEMIRKRug4SawcYW32T0iasEmh7Pv1dcmmRqmcHw1Iju4/ySFcEWZAhQGgCSWBjKslMj
 dM0kWOLqGpHZGbdfiTwKXmKt9UGxcGIVNZ9WPfXS3bNHMdrYh4omC5x0GFI4cWnmdnPI
 T8TMdhNJBkpBR9tWs2Y11lx/TRbglitg2Gm5IM+Wko4kg9Aoi++0nORyhpTbT3zljlZB
 9TsW797uBtUSlMQA8y4rTKeSYT2jS+cCPEwXEnEVdNuZxZRZY1JSo6L+ep5gyDx30ve1
 VJPw==
X-Gm-Message-State: AFuF++mRz8Aep8/yOsfDagG4GNK7SH6iXf80/c1lwoHAl36FNrmGIfR0
 AU/IYSH2Xl3HVGzyUkhEwN2m3xpFkM2bL6jGsiv2pi/a+nNJikUTNgxF2Pc16+z/q2w4aRNWMOv
 qVmt/BzjwE3NbreUZuHQDaNHnwMM1vq/xRbGGohkk6E4+z61ZZmxS5N9ev2e+62Xy/D8z1jzeFG
 W5+GswgpC64ZfEXxpfZGD1AmxlgOyLY7OaLA==
X-Gm-Gg: AYBFou1Jqv9p+E05xtRjKDNE0o2PUvYcaz/7dNFrjU6qioE0lJA8emHYwke56thKsRm
 YzCi+9NhppIms8nl5H0JyPDmdRSws3LzsYFWcCqmdjJh9CyztUp96BSoABL9rXgtDFM5ecM7gYM
 pYhkqR8coLgKH3Uibup0GFKniC46a+WroJtGP3vg9G/AkuZzKolc1s8MhylcvST72aIbNRubh/4
 xLvaNPsGnagLmzWYSjioavfXMgR9gJ1uVAYY6oScGyCDpcu/ttuuld1zzUBkzjCotpINVFTgSMI
 4F2s/+d1RZtWq5MNnbVeeIWB6LmjPq46GYRmc0TKQUswQBu72wYcdUWbaJ0wTFS4YWLW209bmaP
 PwtJYTgY/CqT+n7lUz9zZrR4=
X-Received: by 2002:a05:600c:4f88:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49e6198cf7emr7106875e9.11.1789071123769; 
 Thu, 10 Sep 2026 13:12:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4f88:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49e6198cf7emr7106575e9.11.1789071123181; 
 Thu, 10 Sep 2026 13:12:03 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2985dsm162607925e9.6.2026.09.10.13.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Albert Esteve <aesteve@redhat.com>, Dorinda Bassey <dbassey@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 17/90] hw/display/vhost-user-media: add shared memory region BAR
Message-ID: <076c2922436da03ef55e767d4c5ba677c4c7739f.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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


