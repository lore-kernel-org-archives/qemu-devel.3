Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECACC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4CG-0004ai-0w; Mon, 17 Feb 2025 11:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4CB-0004YD-6F
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1tk4C8-0007xy-Nt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739810526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubezkmUehuzQvAhFogyPP24DcAfnGVx9m7LdWtywJrs=;
 b=BXzdt2ShQaBwji82AwgwDfuzsD2fnnty39xtI2uBpMnznWc8DauI+NEJbIK6JNKBrzGDOe
 iRi/WiPMw+BRMkW1GaNRmiG3xkYM0ArFxoz3wZAjvgLyImdfI9Yrix0F3XG3ImED0D/dJE
 mjYTIgMVVn4wCmSNs8eFe6ln078iK68=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-5Dsiq_VsMKS9rJjEU_sZEA-1; Mon,
 17 Feb 2025 11:40:57 -0500
X-MC-Unique: 5Dsiq_VsMKS9rJjEU_sZEA-1
X-Mimecast-MFC-AGG-ID: 5Dsiq_VsMKS9rJjEU_sZEA_1739810457
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D664418EB2CE; Mon, 17 Feb 2025 16:40:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.252])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F4C11800352; Mon, 17 Feb 2025 16:40:51 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, stevensd@chromium.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com,
 david@redhat.com, hi@alyssa.is, mst@redhat.com, jasowang@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v4 7/9] vhost-user-devive: Add shmem BAR
Date: Mon, 17 Feb 2025 17:40:10 +0100
Message-ID: <20250217164012.246727-8-aesteve@redhat.com>
In-Reply-To: <20250217164012.246727-1-aesteve@redhat.com>
References: <20250217164012.246727-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add a shmem BAR block in the vhost-user-device,
which files can be directly mapped into.

The number, shmid, and size of the VIRTIO Shared
Memory subregions is retrieved through a
get_shmem_config message sent by the
vhost-user-base module on the realize step,
after virtio_init().

By default, if VHOST_USER_PROTOCOL_F_SHMEM
feature is not supported by the backend,
there is no cache.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++--
 hw/virtio/vhost-user-device-pci.c | 36 +++++++++++++++++++++--
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index 2bc3423326..8d4bca98a8 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -16,6 +16,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
+#include "migration/blocker.h"
 
 static void vub_start(VirtIODevice *vdev)
 {
@@ -271,7 +272,8 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
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
@@ -328,11 +330,50 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
                          VHOST_BACKEND_TYPE_USER, 0, errp);
 
     if (ret < 0) {
-        do_vhost_user_cleanup(vdev, vub);
+        goto err;
+    }
+
+    ret = vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhost_dev,
+                                                           &nregions,
+                                                           memory_sizes,
+                                                           errp);
+
+    if (ret < 0) {
+        goto err;
+    }
+
+    for (i = 0; i < nregions; i++) {
+        if (memory_sizes[i]) {
+            if (vub->vhost_dev.migration_blocker == NULL) {
+                error_setg(&vub->vhost_dev.migration_blocker,
+                       "Migration disabled: devices with VIRTIO Shared Memory "
+                       "Regions do not support migration yet.");
+                ret = migrate_add_blocker_normal(
+                    &vub->vhost_dev.migration_blocker,
+                    errp);
+
+                if (ret < 0) {
+                    goto err;
+                }
+            }
+
+            if (memory_sizes[i] % qemu_real_host_page_size() != 0) {
+                error_setg(errp, "Shared memory %d size must be a power of 2 "
+                                 "no smaller than the page size", i);
+                goto err;
+            }
+
+            memory_region_init(virtio_new_shmem_region(vdev)->mr,
+                               OBJECT(vdev), "vub-shm-" + i,
+                               memory_sizes[i]);
+        }
     }
 
     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL,
                              dev, NULL, true);
+    return;
+err:
+    do_vhost_user_cleanup(vdev, vub);
 }
 
 static void vub_device_unrealize(DeviceState *dev)
diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
index efaf55d3dd..f215cae925 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -8,14 +8,18 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
+#define VIRTIO_DEVICE_PCI_SHMEM_BAR 2
+
 struct VHostUserDevicePCI {
     VirtIOPCIProxy parent_obj;
 
     VHostUserBase vub;
+    MemoryRegion shmembar;
 };
 
 #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
@@ -25,10 +29,38 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vub);
+    DeviceState *dev_state = DEVICE(&dev->vub);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    MemoryRegion *mr;
+    uint64_t offset = 0, shmem_size = 0;
+    int i;
 
     vpci_dev->nvectors = 1;
-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
+
+    for (i = 0; i < vdev->n_shmem_regions; i++) {
+        mr = vdev->shmem_list[i].mr;
+        if (mr->size > UINT64_MAX - shmem_size) {
+            error_setg(errp, "Total shared memory required overflow");
+            return;
+        }
+        shmem_size = shmem_size + mr->size;
+    }
+    if (shmem_size) {
+        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
+                           "vhost-device-pci-shmembar", shmem_size);
+        for (i = 0; i < vdev->n_shmem_regions; i++) {
+            memory_region_add_subregion(&dev->shmembar, offset, mr);
+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
+                                   offset, mr->size, i);
+            offset = offset + mr->size;
+        }
+        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
+                        PCI_BASE_ADDRESS_SPACE_MEMORY |
+                        PCI_BASE_ADDRESS_MEM_PREFETCH |
+                        PCI_BASE_ADDRESS_MEM_TYPE_64,
+                        &dev->shmembar);
+    }
 }
 
 static void vhost_user_device_pci_class_init(ObjectClass *klass, void *data)
-- 
2.48.1


