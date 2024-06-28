Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E9C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sND2v-0007E8-0Q; Fri, 28 Jun 2024 10:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sND2m-0007Cc-Bf
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1sND2f-00039B-4x
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719586652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIU+/MKeHKu2FXBeFupA7TBH7huRAp5sg/sRmWomYfg=;
 b=YoVNByAaqBgazMsAUz8pzuMdsPOsBT3uVpYH4OtjWQnbzS4UPEEtYBZ3dk7RpUeIgv9Uuu
 FxNdZENoJIqCvms+UNAjMocrPFCTXCpVHq70sj7Osd1KCvmD+gU5tSmDF+TztLAoUWwXQS
 /QRmL2V/2SddmwiXDhz29Pe3ZOdhimc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Yuu4rgIqPmeffH9Rh7YMcg-1; Fri,
 28 Jun 2024 10:57:31 -0400
X-MC-Unique: Yuu4rgIqPmeffH9Rh7YMcg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6117F194510D; Fri, 28 Jun 2024 14:57:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.224.245])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F54119560A3; Fri, 28 Jun 2024 14:57:27 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, david@redhat.com, slp@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [RFC PATCH v2 3/5] vhost-user-dev: Add cache BAR
Date: Fri, 28 Jun 2024 16:57:08 +0200
Message-ID: <20240628145710.1516121-4-aesteve@redhat.com>
In-Reply-To: <20240628145710.1516121-1-aesteve@redhat.com>
References: <20240628145710.1516121-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/virtio/vhost-user-base.c       | 39 +++++++++++++++++++++++++++++--
 hw/virtio/vhost-user-device-pci.c | 37 ++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index a83167191e..e47c568a55 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -268,7 +268,9 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
+    uint64_t memory_sizes[8];
+    void *cache_ptr;
+    int i, ret, nregions;
 
     if (!vub->chardev.chr) {
         error_setg(errp, "vhost-user-base: missing chardev");
@@ -311,7 +313,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 
     /* Allocate queues */
     vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
-    for (int i = 0; i < vub->num_vqs; i++) {
+    for (i = 0; i < vub->num_vqs; i++) {
         g_ptr_array_add(vub->vqs,
                         virtio_add_queue(vdev, vub->vq_size,
                                          vub_handle_output));
@@ -328,6 +330,39 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
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
+            if (!is_power_of_2(memory_sizes[i]) ||
+                memory_sizes[i] < qemu_real_host_page_size()) {
+                error_setg(errp, "Shared memory %d size must be a power of 2 "
+                                 "no smaller than the page size", i);
+                return;
+            }
+
+            cache_ptr = mmap(NULL, memory_sizes[i], PROT_READ,
+                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+            if (cache_ptr == MAP_FAILED) {
+                error_setg(errp, "Unable to mmap blank cache: %s",
+                           strerror(errno));
+                return;
+            }
+
+            virtio_new_shmem_region(vdev);
+            memory_region_init_ram_ptr(&vdev->shmem_list[i],
+                                    OBJECT(vdev), "vub-shm-" + i,
+                                    memory_sizes[i], cache_ptr);
+        }
+    }
+
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
 }
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index efaf55d3dd..314bacfb7a 100644
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
@@ -25,10 +29,37 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vub);
-
+    DeviceState *dev_state = DEVICE(&dev->vub);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    uint64_t offset = 0, cache_size = 0;
+    int i;
+    
     vpci_dev->nvectors = 1;
-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
+
+    for (i = 0; i < vdev->n_shmem_regions; i++) {
+        if (vdev->shmem_list[i].size > UINT64_MAX - cache_size) {
+            error_setg(errp, "Total shared memory required overflow");
+            return;
+        }
+        cache_size = cache_size + vdev->shmem_list[i].size;
+    }
+    if (cache_size) {
+        memory_region_init(&dev->cachebar, OBJECT(vpci_dev),
+                           "vhost-device-pci-cachebar", cache_size);
+        for (i = 0; i < vdev->n_shmem_regions; i++) {
+            memory_region_add_subregion(&dev->cachebar, offset,
+                                        &vdev->shmem_list[i]);
+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_CACHE_BAR,
+                                   offset, vdev->shmem_list[i].size, i);
+            offset = offset + vdev->shmem_list[i].size;
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


