Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229BEC27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCM6r-00015d-F2; Wed, 29 May 2024 12:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6n-00013e-1N
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:01 -0400
Received: from ssh.movementarian.org ([139.162.205.133] helo=movementarian.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <movement@movementarian.org>)
 id 1sCM6l-0006KY-45
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:25:00 -0400
Received: from movement by movementarian.org with local (Exim 4.95)
 (envelope-from <movement@movementarian.org>) id 1sCM6i-006COn-W9;
 Wed, 29 May 2024 17:24:56 +0100
From: John Levon <levon@movementarian.org>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jag.raman@oracle.com,
 thanos.makatos@nutanix.com, John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH 06/26] vfio: add region cache
Date: Wed, 29 May 2024 17:22:59 +0100
Message-Id: <20240529162319.1476680-7-levon@movementarian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529162319.1476680-1-levon@movementarian.org>
References: <20240529162319.1476680-1-levon@movementarian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.162.205.133;
 envelope-from=movement@movementarian.org; helo=movementarian.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Jagannathan Raman <jag.raman@oracle.com>

cache VFIO_DEVICE_GET_REGION_INFO results to reduce
memory alloc/free cycles and as prep work for vfio-user

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/ccw.c                 |  5 -----
 hw/vfio/common.c              | 12 ++++++++++++
 hw/vfio/container.c           | 10 ++++++++++
 hw/vfio/helpers.c             | 21 ++++++++++++++++-----
 hw/vfio/igd.c                 |  8 ++++----
 hw/vfio/pci.c                 |  8 ++++----
 include/hw/vfio/vfio-common.h |  1 +
 7 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 2600e62e37..315449c1b1 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -510,7 +510,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
-    g_free(info);
 
     /* check for the optional async command region */
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -523,7 +522,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->async_cmd_region_offset = info->offset;
         vcdev->async_cmd_region = g_malloc0(info->size);
-        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -536,7 +534,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->schib_region_offset = info->offset;
         vcdev->schib_region = g_malloc(info->size);
-        g_free(info);
     }
 
     ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
@@ -550,7 +547,6 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         }
         vcdev->crw_region_offset = info->offset;
         vcdev->crw_region = g_malloc(info->size);
-        g_free(info);
     }
 
     return true;
@@ -560,7 +556,6 @@ out_err:
     g_free(vcdev->schib_region);
     g_free(vcdev->async_cmd_region);
     g_free(vcdev->io_region);
-    g_free(info);
     return false;
 }
 
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 81f4c88f2d..1a71c3be05 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1542,6 +1542,16 @@ retry:
     return info;
 }
 
+static void vfio_get_all_regions(VFIODevice *vbasedev)
+{
+    struct vfio_region_info *info;
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        vfio_get_region_info(vbasedev, i, &info);
+    }
+}
+
 void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
                          VFIOGroup *group, struct vfio_device_info *info)
 {
@@ -1559,6 +1569,8 @@ void vfio_prepare_device(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     }
 
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
+
+    vfio_get_all_regions(vbasedev);
 }
 
 bool vfio_attach_device_by_iommu_type(const char *iommu_type, char *name,
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 1bbcbaa874..6c70f95f04 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -891,6 +891,16 @@ static bool vfio_get_device(VFIOGroup *group, const char *name,
 
 static void vfio_put_base_device(VFIODevice *vbasedev)
 {
+    if (vbasedev->regions != NULL) {
+        int i;
+
+        for (i = 0; i < vbasedev->num_regions; i++) {
+            g_free(vbasedev->regions[i]);
+        }
+        g_free(vbasedev->regions);
+        vbasedev->regions = NULL;
+    }
+
     if (!vbasedev->group) {
         return;
     }
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 27ea26aa48..cdc7eb5bd5 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -343,7 +343,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, index, &info);
@@ -533,6 +533,17 @@ int vfio_get_region_info(VFIODevice *vbasedev, int index,
 {
     size_t argsz = sizeof(struct vfio_region_info);
 
+    /* create region cache */
+    if (vbasedev->regions == NULL) {
+        vbasedev->regions = g_new0(struct vfio_region_info *,
+                                   vbasedev->num_regions);
+    }
+    /* check cache */
+    if (vbasedev->regions[index] != NULL) {
+        *info = vbasedev->regions[index];
+        return 0;
+    }
+
     *info = g_malloc0(argsz);
 
     (*info)->index = index;
@@ -552,6 +563,9 @@ retry:
         goto retry;
     }
 
+    /* fill cache */
+    vbasedev->regions[index] = *info;
+
     return 0;
 }
 
@@ -570,7 +584,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
         hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
         if (!hdr) {
-            g_free(*info);
             continue;
         }
 
@@ -582,8 +595,6 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
         if (cap_type->type == type && cap_type->subtype == subtype) {
             return 0;
         }
-
-        g_free(*info);
     }
 
     *info = NULL;
@@ -592,7 +603,7 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    g_autofree struct vfio_region_info *info = NULL;
+    struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_get_region_info(vbasedev, region, &info)) {
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index d320d032a7..34d8a41dd3 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -367,10 +367,10 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    g_autofree struct vfio_region_info *rom = NULL;
-    g_autofree struct vfio_region_info *opregion = NULL;
-    g_autofree struct vfio_region_info *host = NULL;
-    g_autofree struct vfio_region_info *lpc = NULL;
+    struct vfio_region_info *rom = NULL;
+    struct vfio_region_info *opregion = NULL;
+    struct vfio_region_info *host = NULL;
+    struct vfio_region_info *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 74a79bdf61..470fb3502a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -2666,7 +2666,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2731,7 +2731,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    g_autofree struct vfio_region_info *reg_info = NULL;
+    struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
     int i, ret = -1;
 
@@ -3135,7 +3135,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     if (!vdev->igd_opregion &&
         vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
-        g_autofree struct vfio_region_info *opregion = NULL;
+        struct vfio_region_info *opregion = NULL;
 
         if (vdev->pdev.qdev.hotplugged) {
             error_setg(errp,
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ee022c9cbd..2428c7d80c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -128,6 +128,7 @@ typedef struct VFIODevice {
     bool dirty_tracking;
     int devid;
     IOMMUFDBackend *iommufd;
+    struct vfio_region_info **regions;
 } VFIODevice;
 
 struct VFIODeviceOps {
-- 
2.34.1


