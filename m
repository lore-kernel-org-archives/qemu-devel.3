Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C756CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 09:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuTfd-0004Zy-Kj; Tue, 18 Mar 2025 05:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfa-0004Vh-UE
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tuTfY-0002Ki-FB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 05:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742291731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THOOhiMCwdgXfOjofZiQjPq9jBb+/q7r05O1Jbl3SHw=;
 b=BpqtzbePwHsGwmzSGWISGRFJYLwCgjABGR2woabA2PSyivDOaFyfNDjFC/YiQ+PPro155Z
 Xk2fkWavWJ4G2bVuqlYLbgRFC3p4bsMI52tD3p9jJfujeHLRGGda79nNcbgH9rRqSDKiUe
 QVml3ELdA2f7N6rdMBbuJCDIBfjuN4E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-KOonRQQ7OMq668OaJn5b1Q-1; Tue,
 18 Mar 2025 05:55:27 -0400
X-MC-Unique: KOonRQQ7OMq668OaJn5b1Q-1
X-Mimecast-MFC-AGG-ID: KOonRQQ7OMq668OaJn5b1Q_1742291726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7632F18001F7; Tue, 18 Mar 2025 09:55:26 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5873318001EF; Tue, 18 Mar 2025 09:55:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 13/32] vfio: Move VFIOAddressSpace helpers into
 container-base.c
Date: Tue, 18 Mar 2025 10:53:56 +0100
Message-ID: <20250318095415.670319-14-clg@redhat.com>
In-Reply-To: <20250318095415.670319-1-clg@redhat.com>
References: <20250318095415.670319-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

VFIOAddressSpace is a common object used by VFIOContainerBase which is
declared in "hw/vfio/vfio-container-base.h". Move the VFIOAddressSpace
related services into "container-base.c".

While at it, rename :

  vfio_get_address_space -> vfio_address_space_get
  vfio_put_address_space -> vfio_address_space_put

to better reflect the namespace these routines belong to.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  6 ---
 include/hw/vfio/vfio-container-base.h |  5 ++
 hw/ppc/spapr_pci_vfio.c               |  5 +-
 hw/vfio/common.c                      | 66 -------------------------
 hw/vfio/container-base.c              | 69 +++++++++++++++++++++++++++
 hw/vfio/container.c                   |  6 +--
 hw/vfio/iommufd.c                     |  6 +--
 hw/vfio/trace-events                  |  4 +-
 8 files changed, 85 insertions(+), 82 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e23626856e6ff96939a4660f059833f166aa88e9..2ea7f9c6f6e7e752699954ac236cac0bbe834b39 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -120,18 +120,12 @@ struct VFIODeviceOps {
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO \
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
-VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
-void vfio_put_address_space(VFIOAddressSpace *space);
-void vfio_address_space_insert(VFIOAddressSpace *space,
-                               VFIOContainerBase *bcontainer);
-
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
 bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
                             int action, int fd, Error **errp);
 
-void vfio_reset_handler(void *opaque);
 struct vfio_device_info *vfio_get_device_info(int fd);
 bool vfio_device_is_mdev(VFIODevice *vbasedev);
 bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab4861a25d07b5ebd1200509ebfab12d..27668879f5ca77e558a2bda9548c8e60afefe794 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -71,6 +71,11 @@ typedef struct VFIORamDiscardListener {
     QLIST_ENTRY(VFIORamDiscardListener) next;
 } VFIORamDiscardListener;
 
+VFIOAddressSpace *vfio_address_space_get(AddressSpace *as);
+void vfio_address_space_put(VFIOAddressSpace *space);
+void vfio_address_space_insert(VFIOAddressSpace *space,
+                               VFIOContainerBase *bcontainer);
+
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
                            void *vaddr, bool readonly);
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 1722a5bfa3983d42baac558f22410e36eed375f5..e318d0d912f3e90d1289e4bc2195bf68418e5206 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -24,7 +24,6 @@
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio-container.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
@@ -86,7 +85,7 @@ static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
 
 static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
 {
-    VFIOAddressSpace *space = vfio_get_address_space(as);
+    VFIOAddressSpace *space = vfio_address_space_get(as);
     VFIOContainerBase *bcontainer = NULL;
 
     if (QLIST_EMPTY(&space->containers)) {
@@ -106,7 +105,7 @@ static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
     }
 
 out:
-    vfio_put_address_space(space);
+    vfio_address_space_put(space);
     return container_of(bcontainer, VFIOContainer, bcontainer);
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 0e3746eddd1c08e98bf57a59d542e158487d346e..08e2494d7c4a9858657724730b2829290fb3f197 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -36,7 +36,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/range.h"
 #include "system/kvm.h"
-#include "system/reset.h"
 #include "system/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -48,8 +47,6 @@
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
-static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
-    QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
 #ifdef CONFIG_KVM
 /*
@@ -1304,24 +1301,6 @@ const MemoryListener vfio_memory_listener = {
     .log_sync = vfio_listener_log_sync,
 };
 
-void vfio_reset_handler(void *opaque)
-{
-    VFIODevice *vbasedev;
-
-    trace_vfio_reset_handler();
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized) {
-            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
-        }
-    }
-
-    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
-        if (vbasedev->dev->realized && vbasedev->needs_reset) {
-            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
-        }
-    }
-}
-
 int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
@@ -1380,51 +1359,6 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
     return 0;
 }
 
-VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
-{
-    VFIOAddressSpace *space;
-
-    QLIST_FOREACH(space, &vfio_address_spaces, list) {
-        if (space->as == as) {
-            return space;
-        }
-    }
-
-    /* No suitable VFIOAddressSpace, create a new one */
-    space = g_malloc0(sizeof(*space));
-    space->as = as;
-    QLIST_INIT(&space->containers);
-
-    if (QLIST_EMPTY(&vfio_address_spaces)) {
-        qemu_register_reset(vfio_reset_handler, NULL);
-    }
-
-    QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
-
-    return space;
-}
-
-void vfio_put_address_space(VFIOAddressSpace *space)
-{
-    if (!QLIST_EMPTY(&space->containers)) {
-        return;
-    }
-
-    QLIST_REMOVE(space, list);
-    g_free(space);
-
-    if (QLIST_EMPTY(&vfio_address_spaces)) {
-        qemu_unregister_reset(vfio_reset_handler, NULL);
-    }
-}
-
-void vfio_address_space_insert(VFIOAddressSpace *space,
-                               VFIOContainerBase *bcontainer)
-{
-    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
-    bcontainer->space = space;
-}
-
 struct vfio_device_info *vfio_get_device_info(int fd)
 {
     struct vfio_device_info *info;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 749a3fd29dd6fc9143f14edf7e4ac6238315fcce..83e83ab9e67de8b004dfaf0067e4c466a6c88451 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -13,7 +13,76 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "system/reset.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-common.h" /* for vfio_device_list */
+#include "trace.h"
+
+static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
+    QLIST_HEAD_INITIALIZER(vfio_address_spaces);
+
+static void vfio_reset_handler(void *opaque)
+{
+    VFIODevice *vbasedev;
+
+    trace_vfio_reset_handler();
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->dev->realized) {
+            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
+        }
+    }
+
+    QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
+        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
+        }
+    }
+}
+
+VFIOAddressSpace *vfio_address_space_get(AddressSpace *as)
+{
+    VFIOAddressSpace *space;
+
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        if (space->as == as) {
+            return space;
+        }
+    }
+
+    /* No suitable VFIOAddressSpace, create a new one */
+    space = g_malloc0(sizeof(*space));
+    space->as = as;
+    QLIST_INIT(&space->containers);
+
+    if (QLIST_EMPTY(&vfio_address_spaces)) {
+        qemu_register_reset(vfio_reset_handler, NULL);
+    }
+
+    QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
+
+    return space;
+}
+
+void vfio_address_space_put(VFIOAddressSpace *space)
+{
+    if (!QLIST_EMPTY(&space->containers)) {
+        return;
+    }
+
+    QLIST_REMOVE(space, list);
+    g_free(space);
+
+    if (QLIST_EMPTY(&vfio_address_spaces)) {
+        qemu_unregister_reset(vfio_reset_handler, NULL);
+    }
+}
+
+void vfio_address_space_insert(VFIOAddressSpace *space,
+                               VFIOContainerBase *bcontainer)
+{
+    QLIST_INSERT_HEAD(&space->containers, bcontainer, next);
+    bcontainer->space = space;
+}
 
 int vfio_container_dma_map(VFIOContainerBase *bcontainer,
                            hwaddr iova, ram_addr_t size,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 8badeb98ec052ad1fa7b5d45bb1733b1184bc6fb..9b86e24a4072e579bcdc2c060ce42608ee44ee2e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -546,7 +546,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     VFIOAddressSpace *space;
     VFIOIOMMUClass *vioc;
 
-    space = vfio_get_address_space(as);
+    space = vfio_address_space_get(as);
 
     /*
      * VFIO is currently incompatible with discarding of RAM insofar as the
@@ -675,7 +675,7 @@ close_fd_exit:
     close(fd);
 
 put_space_exit:
-    vfio_put_address_space(space);
+    vfio_address_space_put(space);
 
     return false;
 }
@@ -714,7 +714,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         close(container->fd);
         object_unref(container);
 
-        vfio_put_address_space(space);
+        vfio_address_space_put(space);
     }
 }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index a219b6453037e2d4e0d12800ea25678885af98f8..a170f5c71218db8c9b2f00b1a45ee900b6b21346 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -487,7 +487,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_connect_bind;
     }
 
-    space = vfio_get_address_space(as);
+    space = vfio_address_space_get(as);
 
     /*
      * The HostIOMMUDevice data from legacy backend is static and doesn't need
@@ -607,7 +607,7 @@ err_discard_disable:
 err_attach_container:
     iommufd_cdev_container_destroy(container);
 err_alloc_ioas:
-    vfio_put_address_space(space);
+    vfio_address_space_put(space);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
 err_connect_bind:
     close(vbasedev->fd);
@@ -632,7 +632,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
-    vfio_put_address_space(space);
+    vfio_address_space_put(space);
 
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 81f4130100c48012c15b5b4858446149a7eaf5b6..c3691c1a172c31c5b10bfd6967c32fd32b65d0f7 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -109,7 +109,6 @@ vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
-vfio_reset_handler(void) ""
 
 # region.c
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
@@ -194,3 +193,6 @@ iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
 iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
+
+# container-base.c
+vfio_reset_handler(void) ""
-- 
2.48.1


