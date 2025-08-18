Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB65CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 10:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unwje-0004Ch-A1; Mon, 18 Aug 2025 06:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unwjc-0004CS-JV
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1unwja-0002tC-Ta
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 06:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755511498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydA5+q4d6HWwx0EkrM5TjW/EQBVY8+I+lJ5UM8QCE3g=;
 b=TNLYJW5Vf0x2ccCj2swZKJIvORnIKr8C5CVG7uv6bMwCEXw29+PnQnmP0h+K0gvQeDcmoq
 HoKV/OviciBCP+KLEodfzfWwRd/vtDkYeibxa2xJNhWxur6usLJblgNVLA33eZp/+mLpP+
 s9jQVLWrKAECLuNf6aIoiAG2cRebZU0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-8-3RfKDmNB6Dz-ypzEKLOA-1; Mon,
 18 Aug 2025 06:04:53 -0400
X-MC-Unique: 8-3RfKDmNB6Dz-ypzEKLOA-1
X-Mimecast-MFC-AGG-ID: 8-3RfKDmNB6Dz-ypzEKLOA_1755511492
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E852180034A; Mon, 18 Aug 2025 10:04:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.45])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEEAE180047F; Mon, 18 Aug 2025 10:04:46 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, hi@alyssa.is,
 jasowang@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 dbassey@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, stefanha@redhat.com,
 stevensd@chromium.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, slp@redhat.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v7 8/8] vhost-user-device: Add shared memory BAR
Date: Mon, 18 Aug 2025 12:03:53 +0200
Message-ID: <20250818100353.1560655-9-aesteve@redhat.com>
In-Reply-To: <20250818100353.1560655-1-aesteve@redhat.com>
References: <20250818100353.1560655-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add shared memory BAR support to vhost-user-device-pci
to enable direct file mapping for VIRTIO Shared
Memory Regions.

The implementation creates a consolidated shared
memory BAR that contains all VIRTIO Shared
Memory Regions as subregions. Each region is
configured with its proper shmid, size, and
offset within the BAR. The number and size of
regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
message sent by vhost-user-base during realization
after virtio_init().

Specifiically, it uses BAR 3 to avoid conflicts, as
it is currently unused.

The shared memory BAR is only created when the
backend supports VHOST_USER_PROTOCOL_F_SHMEM and
has configured shared memory regions. This maintains
backward compatibility with backends that do not
support shared memory functionality.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 hw/virtio/vhost-user-base.c       | 49 +++++++++++++++++++++++++++++--
 hw/virtio/vhost-user-device-pci.c | 34 +++++++++++++++++++--
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index ff67a020b4..932f9b5596 100644
--- a/hw/virtio/vhost-user-base.c
+++ b/hw/virtio/vhost-user-base.c
@@ -16,6 +16,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "qemu/error-report.h"
+#include "migration/blocker.h"
 
 static void vub_start(VirtIODevice *vdev)
 {
@@ -276,7 +277,9 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostUserBase *vub = VHOST_USER_BASE(dev);
-    int ret;
+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
+    g_autofree char *name = NULL;
+    int i, ret, nregions;
 
     if (!vub->chardev.chr) {
         error_setg(errp, "vhost-user-base: missing chardev");
@@ -319,7 +322,7 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
 
     /* Allocate queues */
     vub->vqs = g_ptr_array_sized_new(vub->num_vqs);
-    for (int i = 0; i < vub->num_vqs; i++) {
+    for (i = 0; i < vub->num_vqs; i++) {
         g_ptr_array_add(vub->vqs,
                         virtio_add_queue(vdev, vub->vq_size,
                                          vub_handle_output));
@@ -333,11 +336,51 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
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
+            name = g_strdup_printf("vub-shm-%d", i);
+            memory_region_init(&virtio_new_shmem_region(vdev, i)->mr,
+                               OBJECT(vdev), name,
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
index f10bac874e..bac99e7c60 100644
--- a/hw/virtio/vhost-user-device-pci.c
+++ b/hw/virtio/vhost-user-device-pci.c
@@ -8,14 +8,18 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/vhost-user-base.h"
 #include "hw/virtio/virtio-pci.h"
 
+#define VIRTIO_DEVICE_PCI_SHMEM_BAR 3
+
 struct VHostUserDevicePCI {
     VirtIOPCIProxy parent_obj;
 
     VHostUserBase vub;
+    MemoryRegion shmembar;
 };
 
 #define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
@@ -25,10 +29,36 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST_USER_DEVICE_PCI)
 static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostUserDevicePCI *dev = VHOST_USER_DEVICE_PCI(vpci_dev);
-    DeviceState *vdev = DEVICE(&dev->vub);
+    DeviceState *dev_state = DEVICE(&dev->vub);
+    VirtIODevice *vdev = VIRTIO_DEVICE(dev_state);
+    VirtioSharedMemory *shmem, *next;
+    uint64_t offset = 0, shmem_size = 0;
 
     vpci_dev->nvectors = 1;
-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
+
+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
+        if (shmem->mr.size > UINT64_MAX - shmem_size) {
+            error_setg(errp, "Total shared memory required overflow");
+            return;
+        }
+        shmem_size = shmem_size + shmem->mr.size;
+    }
+    if (shmem_size) {
+        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
+                           "vhost-device-pci-shmembar", shmem_size);
+        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
+            memory_region_add_subregion(&dev->shmembar, offset, &shmem->mr);
+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
+                                   offset, shmem->mr.size, shmem->shmid);
+            offset = offset + shmem->mr.size;
+        }
+        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BAR,
+                        PCI_BASE_ADDRESS_SPACE_MEMORY |
+                        PCI_BASE_ADDRESS_MEM_PREFETCH |
+                        PCI_BASE_ADDRESS_MEM_TYPE_64,
+                        &dev->shmembar);
+    }
 }
 
 static void vhost_user_device_pci_class_init(ObjectClass *klass,
-- 
2.49.0


