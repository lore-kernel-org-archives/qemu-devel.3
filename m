Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2203CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJQ3-0000nD-V9; Wed, 10 Sep 2025 07:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uwJQ0-0000mX-HU
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1uwJPx-0001h6-2i
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757505315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EV38TEjNyp5jDyAaZO+zz46tsIIZHTAxtiHGBnFQTsg=;
 b=eVJz8ZOJ1ElpjsIhJ+mzkdKbv5LZlRoWsAXUPCrudV76LoQ2BhICJzIQE/7azQPprUMoEV
 K8Fi9tis6HWADFjiUVm78ppfmGWn7vIMzVmy6XFd3mYdQ2halRzOgKFMYUayyNed/vzIsg
 ZfjXRZJ9KicX+SCNl4aIi4icBrw3xlA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-J2c29AW_M2q8obK6oCxG3Q-1; Wed,
 10 Sep 2025 07:55:11 -0400
X-MC-Unique: J2c29AW_M2q8obK6oCxG3Q-1
X-Mimecast-MFC-AGG-ID: J2c29AW_M2q8obK6oCxG3Q_1757505310
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7210A1956089; Wed, 10 Sep 2025 11:55:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 981541800446; Wed, 10 Sep 2025 11:55:05 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stevensd@chromium.org, dbassey@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 mst@redhat.com, slp@redhat.com, hi@alyssa.is, stefanha@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, david@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v8 7/7] vhost-user-device: Add shared memory BAR
Date: Wed, 10 Sep 2025 13:54:20 +0200
Message-ID: <20250910115420.1012191-8-aesteve@redhat.com>
In-Reply-To: <20250910115420.1012191-1-aesteve@redhat.com>
References: <20250910115420.1012191-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/virtio/vhost-user-base.c       | 47 +++++++++++++++++++++++++++++--
 hw/virtio/vhost-user-device-pci.c | 34 ++++++++++++++++++++--
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
index ff67a020b4..82f49500e4 100644
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
+    int i, ret, nregions, regions_processed = 0;
 
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
@@ -333,11 +336,49 @@ static void vub_device_realize(DeviceState *dev, Error **errp)
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
+    for (i = 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < nregions; i++) {
+        if (memory_sizes[i]) {
+            regions_processed++;
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
+            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
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


