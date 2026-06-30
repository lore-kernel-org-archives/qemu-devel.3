Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E9CC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWYx-0003XT-UZ; Tue, 30 Jun 2026 07:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWYr-0003VD-6I
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1weWYp-0005eY-IS
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782818606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAgskVNcOFIUtP/RrQaHagFgGhUfOdFnNQlOrd7k3bg=;
 b=dw17452VJEUwY4trC6L+yNq3CKTuoFy0v0ZONTk15YDZf2q+0GJJayyvrchQq9+k1z5e3e
 5guYsKtGSPB+qsUZOrlji8BdxzvYsL5/MQ5DBOcJO9rH2iesziumHTeuSPZ20ra7FmACj5
 5fQW1yAGj9zX9EQUzV97Tg0cAExKbZY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-qX_9pg8SPjaN62cHn8CAAw-1; Tue,
 30 Jun 2026 07:23:22 -0400
X-MC-Unique: qX_9pg8SPjaN62cHn8CAAw-1
X-Mimecast-MFC-AGG-ID: qX_9pg8SPjaN62cHn8CAAw_1782818601
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6B3C1955F7C; Tue, 30 Jun 2026 11:23:21 +0000 (UTC)
Received: from fedora (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90F85180065F; Tue, 30 Jun 2026 11:23:19 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH 3/3] hw/display/vhost-user-media: add shared memory cache BAR
Date: Tue, 30 Jun 2026 13:23:10 +0200
Message-ID: <20260630112310.552606-4-aesteve@redhat.com>
In-Reply-To: <20260630112310.552606-1-aesteve@redhat.com>
References: <20260630112310.552606-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Register a 4 GiB shared memory PCI BAR (BAR 2) so the guest driver
can use it as a DMA cache for video buffers. The memory region is
allocated on device realize and exposed to the guest through a VirtIO
shared memory capability (shmem ID 0).

The host must be started with a memfd-backed memory object covering
at least the shared region size, e.g.:

    -object memory-backend-memfd,id=mem,size=4G,share=on \
    -numa node,memdev=mem

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/display/vhost-user-media-pci.c | 28 ++++++++++++++++++++++++++++
 hw/display/vhost-user-media.c     |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/hw/display/vhost-user-media-pci.c b/hw/display/vhost-user-media-pci.c
index ad9e3900a4..838a9da71d 100644
--- a/hw/display/vhost-user-media-pci.c
+++ b/hw/display/vhost-user-media-pci.c
@@ -12,12 +12,18 @@
 #include "hw/virtio/vhost-user-media.h"
 #include "hw/virtio/virtio-pci.h"
 
+/* BAR 2 is used for the shared memory cache region exposed to the guest */
+#define VIRTIO_MEDIA_PCI_CACHE_BAR 2
+
+#define VIRTIO_MEDIA_PCI_SHMCAP_ID_CACHE 0
+
 #define TYPE_VHOST_USER_MEDIA_PCI "vhost-user-media-pci-base"
 OBJECT_DECLARE_SIMPLE_TYPE(VHostUserMEDIAPCI, VHOST_USER_MEDIA_PCI)
 
 struct VHostUserMEDIAPCI {
     VirtIOPCIProxy parent_obj;
     VHostUserMEDIA vdev;
+    MemoryRegion cachebar;
 };
 
 static const Property vumedia_pci_properties[] = {
@@ -31,12 +37,34 @@ static void vumedia_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserMEDIAPCI *dev = VHOST_USER_MEDIA_PCI(vpci_dev);
     DeviceState *dev_state = DEVICE(&dev->vdev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    VirtioSharedMemory *shmem;
+    uint64_t cache_size;
 
     if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
         vpci_dev->nvectors = 1;
     }
 
     qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
+    if (*errp) {
+        return;
+    }
+
+    shmem = QSIMPLEQ_LAST(&vdev->shmem_list, VirtioSharedMemory, entry);
+    cache_size = memory_region_size(&shmem->mr);
+
+    memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
+                       "vhost-media-pci-cachebar", cache_size);
+    memory_region_add_subregion(&dev->cachebar, 0, &shmem->mr);
+    virtio_pci_add_shm_cap(vpci_dev, VIRTIO_MEDIA_PCI_CACHE_BAR, 0,
+                            cache_size, VIRTIO_MEDIA_PCI_SHMCAP_ID_CACHE);
+
+    /* After 'realized' so the memory region exists */
+    pci_register_bar(&vpci_dev->pci_dev, VIRTIO_MEDIA_PCI_CACHE_BAR,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                     PCI_BASE_ADDRESS_MEM_PREFETCH |
+                     PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &dev->cachebar);
 }
 
 static void vumedia_pci_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/display/vhost-user-media.c b/hw/display/vhost-user-media.c
index 5c627437e7..bbb64ea4d3 100644
--- a/hw/display/vhost-user-media.c
+++ b/hw/display/vhost-user-media.c
@@ -20,6 +20,8 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-media.h"
 
+#define CACHE_SIZE (1ull << 32)
+
 static const int feature_bits[] = {
     VIRTIO_F_RING_RESET,
     VHOST_INVALID_FEATURE_BIT
@@ -288,6 +290,8 @@ static void vhost_user_media_device_realize(DeviceState *dev, Error **errp)
 
     virtio_init(vdev, VIRTIO_ID_MEDIA, sizeof(struct virtio_media_config));
 
+    virtio_new_shmem_region(vdev, 0, CACHE_SIZE);
+
     /* one command queue and one event queue */
     media->vhost_dev.nvqs = 2;
     media->vhost_dev.vqs = g_new0(struct vhost_virtqueue,
-- 
2.54.0


