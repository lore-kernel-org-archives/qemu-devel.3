Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C2CEED60D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 14:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solD6-0001MK-UX; Thu, 12 Sep 2024 10:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solD5-0001IU-T5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1solD3-0000IA-Qc
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 10:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726152853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCIUDDzY8Nmpe0C6EnAPszeGwSqsgVRES6S6Gvetf6Y=;
 b=NecqnzenQLSkjdlwpXkfBKVQHQZ7TgdjUWAQGSZH2koZZt+0aN8u425FqaY9XFAHfzhSUG
 rN6nyYUUiOaPmptyAJY6SgwpjswuXttuKrvSDUJOdLApI+lS75VvhrXgs9QRvF6QSV+aol
 FF8S+A0nce1mnVMEV/RauaMuTtxAE68=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-yeLnVzR6M16vjycexhv8EA-1; Thu,
 12 Sep 2024 10:54:12 -0400
X-MC-Unique: yeLnVzR6M16vjycexhv8EA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 389A5196CE1D; Thu, 12 Sep 2024 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.195])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A03019560A3; Thu, 12 Sep 2024 14:54:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 hi@alyssa.is, mst@redhat.com, david@redhat.com, jasowang@redhat.com,
 stefanha@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 stevensd@chromium.org, Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v3 4/5] vhost-user-dev: Add cache BAR
Date: Thu, 12 Sep 2024 16:53:34 +0200
Message-ID: <20240912145335.129447-5-aesteve@redhat.com>
In-Reply-To: <20240912145335.129447-1-aesteve@redhat.com>
References: <20240912145335.129447-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a cache BAR in the vhost-user-device
into which files can be directly mapped.

The number, shmid, and size of the VIRTIO Shared
Memory subregions is retrieved through a get_shmem_config
message sent by the vhost-user-base module
on the realize step, after virtio_init().

By default, if VHOST_USER_PROTOCOL_F_SHMEM
feature is not supported by the backend,
there is no cache.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user-base.c       | 37 +++++++++++++++++++++++++++--
 hw/virtio/vhost-user-device-pci.c | 39 ++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 2bc3423326..f2597d021a 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -271,7 +271,9 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
+    uint64_t memory_sizes[8];
+    void *cache_ptr;
+    int i, ret, nregions;
 
     if (!vub->chardev.chr) {
         error_setg(errp, "vhost-user-base: missing chardev");
@@ -314,7 +316,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 
     /* Allocate queues */
     vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
-    for (int i = 0; i < vub->num_vqs; i++) {
+    for (i = 0; i < vub->num_vqs; i++) {
         g_ptr_array_add(vub->vqs,
                         virtio_add_queue(vdev, vub->vq_size,
                                          vub_handle_output));
@@ -331,6 +333,37 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
         do_vhost_user_cleanup(vdev, vub);
     }
 
+    ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
+                                                           &nregions,
+                                                           memory_sizes,
+                                                           errp);
+
+    if (ret < 0) {
+        do_vhost_user_cleanup(vdev, vub);
+    }
+
+    for (i = 0; i < nregions; i++) {
+        if (memory_sizes[i]) {
+            if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
+                error_setg(errp, "Shared memory %d size must be a power of 2 "
+                                 "no smaller than the page size", i);
+                return;
+            }
+
+            cache_ptr = mmap(NULL, memory_sizes[i], PROT_NONE,
+                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+            if (cache_ptr == MAP_FAILED) {
+                error_setg_errno(errp, errno, "Unable to mmap blank cache");
+                return;
+            }
+
+            virtio_new_shmem_region(vdev);
+            memory_region_init_ram_ptr(vdev->shmem_list[i].mr,
+                                       OBJECT(vdev), "vub-shm-" + i,
+                                       memory_sizes[i], cache_ptr);
+        }
+    }
+
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
 }
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index efaf55d3dd..abf4e90c21 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -8,14 +8,18 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
+#define VIRTIO_DEVICE_PCI_CACHE_BAR 2
+
 struct VHostUserDevicePCI {
     VirtIOPCIProxy parent_obj;
 
     VHostUserBase vub;
+    MemoryRegion cachebar;
 };
 
 #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
@@ -25,10 +29,39 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vub);
-
+    DeviceState *dev_state = DEVICE(&dev->vub);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    MemoryRegion *mr;
+    uint64_t offset = 0, cache_size = 0;
+    int i;
+    
     vpci_dev->nvectors = 1;
-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
+
+    for (i = 0; i < vdev->n_shmem_regions; i++) {
+        mr = vdev->shmem_list[i].mr;
+        if (mr->size > UINT64_MAX - cache_size) {
+            error_setg(errp, "Total shared memory required overflow");
+            return;
+        }
+        cache_size = cache_size + mr->size;
+    }
+    if (cache_size) {
+        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
+                           "vhost-device-pci-cachebar", cache_size);
+        for (i = 0; i < vdev->n_shmem_regions; i++) {
+            mr = vdev->shmem_list[i].mr;
+            memory_region_add_subregion(&dev->cachebar, offset, mr);
+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,
+                                   offset, mr->size, i);
+            offset = offset + mr->size;
+        }
+        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,
+                        PCI_BASE_ADDRESS_SPACE_MEMORY |
+                        PCI_BASE_ADDRESS_MEM_PREFETCH |
+                        PCI_BASE_ADDRESS_MEM_TYPE_64,
+                        &dev->cachebar);
+    }
 }
 
 static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
-- 
2.45.2


