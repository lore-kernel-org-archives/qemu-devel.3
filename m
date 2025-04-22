Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D32C369D3
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7G6r-0000cX-S5; Tue, 22 Apr 2025 12:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5q-0007QL-7w
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u7G5m-00052x-UN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745337806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYxE5Iom4cYPmWCPed3uZasWdQb666DaqynlcNJY7Ag=;
 b=ZWzWzEUz27VJwhOREbGleWEfyoEdEgmp0ekEzyFf6H7E5/k3hycMMpRUXopxgk046Rnn0g
 HzmxbBbm31dV5azc251aAh2+8MHk1nPiOgalLDN09AWnFGlN++eMfdhk9hW1JL3f9jLvUh
 GBLuC+zW2C/apOmfkYzGiwIf+of322w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-XRr6Pi0VM6-RsT5YOUiQCg-1; Tue,
 22 Apr 2025 12:03:21 -0400
X-MC-Unique: XRr6Pi0VM6-RsT5YOUiQCg-1
X-Mimecast-MFC-AGG-ID: XRr6Pi0VM6-RsT5YOUiQCg_1745337800
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76106180098E; Tue, 22 Apr 2025 16:03:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.105])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2E8A18001DD; Tue, 22 Apr 2025 16:03:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 14/37] vfio: Move VFIOAddressSpace helpers into
 container-base.c
Date: Tue, 22 Apr 2025 18:02:01 +0200
Message-ID: <20250422160224.199714-15-clg@redhat.com>
In-Reply-To: <20250422160224.199714-1-clg@redhat.com>
References: <20250422160224.199714-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/qemu-devel/20250326075122.1299361-15-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  5 ---
 include/hw/vfio/vfio-container-base.h |  6 ++++
 hw/ppc/spapr_pci_vfio.c               |  5 ++-
 hw/vfio/common.c                      | 47 -------------------------
 hw/vfio/container-base.c              | 50 +++++++++++++++++++++++++++
 hw/vfio/container.c                   |  6 ++--
 hw/vfio/iommufd.c                     |  6 ++--
 7 files changed, 64 insertions(+), 61 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index e23626856e6ff96939a4660f059833f166aa88e9..b2d4ff68650b205dca42ef00c7dfc7f2505b7e51 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -120,11 +120,6 @@ struct VFIODeviceOps {
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
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 4cff9943ab4861a25d07b5ebd1200509ebfab12d..b33231b94013e0b535b77887109a97f9128f1c15 100644
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
@@ -163,4 +168,5 @@ struct VFIOIOMMUClass {
                        MemoryRegionSection *section);
     void (*release)(VFIOContainerBase *bcontainer);
 };
+
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
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
index 33f7191c7fec76bb3f46b96e25dc1872808ccc8c..a8cece570a6092103a5cf573b5343e1d8817bde7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -48,8 +48,6 @@
 
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
-static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
-    QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
 #ifdef CONFIG_KVM
 /*
@@ -1393,51 +1391,6 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
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
index 749a3fd29dd6fc9143f14edf7e4ac6238315fcce..2c2d8329e3cf0f21386cb0896dd366c8d0ccdb60 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -14,6 +14,56 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "hw/vfio/vfio-common.h" /* vfio_reset_handler */
+#include "system/reset.h"
+
+static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
+    QLIST_HEAD_INITIALIZER(vfio_address_spaces);
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
index 7196c4080125674ec58b1ebf02dad84b4387c355..a520d40afc00d79ae8617fd3c40433e228583b5a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -486,7 +486,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_connect_bind;
     }
 
-    space = vfio_get_address_space(as);
+    space = vfio_address_space_get(as);
 
     /*
      * The HostIOMMUDevice data from legacy backend is static and doesn't need
@@ -606,7 +606,7 @@ err_discard_disable:
 err_attach_container:
     iommufd_cdev_container_destroy(container);
 err_alloc_ioas:
-    vfio_put_address_space(space);
+    vfio_address_space_put(space);
     iommufd_cdev_unbind_and_disconnect(vbasedev);
 err_connect_bind:
     close(vbasedev->fd);
@@ -631,7 +631,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
-    vfio_put_address_space(space);
+    vfio_address_space_put(space);
 
     iommufd_cdev_unbind_and_disconnect(vbasedev);
     close(vbasedev->fd);
-- 
2.49.0


