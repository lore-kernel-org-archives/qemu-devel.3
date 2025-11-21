Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17E7CF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdSw-0006Tn-Tc; Fri, 21 Nov 2025 21:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdSm-0006Lm-8Q; Fri, 21 Nov 2025 21:35:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdRw-0000nG-8I; Fri, 21 Nov 2025 21:34:56 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D217F16C6DC;
 Fri, 21 Nov 2025 16:51:53 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 350AA321953;
 Fri, 21 Nov 2025 16:52:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 04/76] vfio: rename field to "num_initial_regions"
Date: Fri, 21 Nov 2025 16:50:42 +0300
Message-ID: <20251121135201.1114964-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Levon <john.levon@nutanix.com>

We set VFIODevice::num_regions at initialization time, and do not
otherwise refresh it. As it is valid in theory for a VFIO device to
later increase the number of supported regions, rename the field to
"num_initial_regions" to better reflect its semantics.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Link: https://lore.kernel.org/qemu-devel/20251014151227.2298892-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit aaca725884b57c9245528a0afb3f32e078543faf)
[ clg: Modified hw/core/sysbus-fdt.c and hw/vfio/platform.c ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index c339a27875..1e1966813f 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -236,15 +236,15 @@ static int add_calxeda_midway_xgmac_fdt_node(SysBusDevice *sbdev, void *opaque)
 
     qemu_fdt_setprop(fdt, nodename, "dma-coherent", "", 0);
 
-    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    reg_attr = g_new(uint32_t, vbasedev->num_initial_regions * 2);
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
         reg_attr[2 * i] = cpu_to_be32(mmio_base);
         reg_attr[2 * i + 1] = cpu_to_be32(
                                 memory_region_size(vdev->regions[i]->mem));
     }
     qemu_fdt_setprop(fdt, nodename, "reg", reg_attr,
-                     vbasedev->num_regions * 2 * sizeof(uint32_t));
+                     vbasedev->num_initial_regions * 2 * sizeof(uint32_t));
 
     irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
     for (i = 0; i < vbasedev->num_irqs; i++) {
@@ -330,7 +330,7 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
 
     g_free(dt_name);
 
-    if (vbasedev->num_regions != 5) {
+    if (vbasedev->num_initial_regions != 5) {
         error_report("%s Does the host dt node combine XGBE/PHY?", __func__);
         exit(1);
     }
@@ -374,15 +374,15 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
                            guest_clock_phandles[0],
                            guest_clock_phandles[1]);
 
-    reg_attr = g_new(uint32_t, vbasedev->num_regions * 2);
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    reg_attr = g_new(uint32_t, vbasedev->num_initial_regions * 2);
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, i);
         reg_attr[2 * i] = cpu_to_be32(mmio_base);
         reg_attr[2 * i + 1] = cpu_to_be32(
                                 memory_region_size(vdev->regions[i]->mem));
     }
     qemu_fdt_setprop(guest_fdt, nodename, "reg", reg_attr,
-                     vbasedev->num_regions * 2 * sizeof(uint32_t));
+                     vbasedev->num_initial_regions * 2 * sizeof(uint32_t));
 
     irq_attr = g_new(uint32_t, vbasedev->num_irqs * 3);
     for (i = 0; i < vbasedev->num_irqs; i++) {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 0609a7dc25..64ef35b320 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -134,7 +134,7 @@ static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
     VFIOUserFDs fds = { 0, 1, fd};
     int ret;
 
-    if (info->index > vbasedev->num_regions) {
+    if (info->index > vbasedev->num_initial_regions) {
         return -EINVAL;
     }
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9560b8d851..4d9588e7aa 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -484,9 +484,9 @@ static bool vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
      * We always expect at least the I/O region to be present. We also
      * may have a variable number of regions governed by capabilities.
      */
-    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
+    if (vdev->num_initial_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "vfio: too few regions (%u), expected at least %u",
-                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
+                   vdev->num_initial_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
         return false;
     }
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52a1996dc4..0b459c0f7c 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -257,7 +257,7 @@ int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
 {
     int i;
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         struct vfio_info_cap_header *hdr;
         struct vfio_region_info_cap_type *cap_type;
 
@@ -466,7 +466,7 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     int i;
 
     vbasedev->num_irqs = info->num_irqs;
-    vbasedev->num_regions = info->num_regions;
+    vbasedev->num_initial_regions = info->num_regions;
     vbasedev->flags = info->flags;
     vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
@@ -476,10 +476,10 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     vbasedev->reginfo = g_new0(struct vfio_region_info *,
-                               vbasedev->num_regions);
+                               vbasedev->num_initial_regions);
     if (vbasedev->use_region_fds) {
-        vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
-        for (i = 0; i < vbasedev->num_regions; i++) {
+        vbasedev->region_fds = g_new0(int, vbasedev->num_initial_regions);
+        for (i = 0; i < vbasedev->num_initial_regions; i++) {
             vbasedev->region_fds[i] = -1;
         }
     }
@@ -489,7 +489,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
 {
     int i;
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         g_free(vbasedev->reginfo[i]);
         if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
             close(vbasedev->region_fds[i]);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48c590b6a9..dbcd861b27 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -668,7 +668,8 @@ found_container:
     vfio_iommufd_cpr_register_device(vbasedev);
 
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
-                                   vbasedev->num_regions, vbasedev->flags);
+                                   vbasedev->num_initial_regions,
+                                   vbasedev->flags);
     return true;
 
 err_listener_register:
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 07257d0fa0..1e69055c7c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2930,9 +2930,9 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
+    if (vbasedev->num_initial_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "unexpected number of io regions %u",
-                   vbasedev->num_regions);
+                   vbasedev->num_initial_regions);
         return false;
     }
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 5c1795a26f..c9349ba7b7 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -148,7 +148,7 @@ static void vfio_mmap_set_enabled(VFIOPlatformDevice *vdev, bool enabled)
 {
     int i;
 
-    for (i = 0; i < vdev->vbasedev.num_regions; i++) {
+    for (i = 0; i < vdev->vbasedev.num_initial_regions; i++) {
         vfio_region_mmaps_set_enabled(vdev->regions[i], enabled);
     }
 }
@@ -453,9 +453,9 @@ static bool vfio_populate_device(VFIODevice *vbasedev, Error **errp)
         return false;
     }
 
-    vdev->regions = g_new0(VFIORegion *, vbasedev->num_regions);
+    vdev->regions = g_new0(VFIORegion *, vbasedev->num_initial_regions);
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         char *name = g_strdup_printf("VFIO %s region %d\n", vbasedev->name, i);
 
         vdev->regions[i] = g_new0(VFIORegion, 1);
@@ -499,7 +499,7 @@ irq_err:
         g_free(intp);
     }
 reg_error:
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         if (vdev->regions[i]) {
             vfio_region_finalize(vdev->regions[i]);
         }
@@ -608,7 +608,7 @@ static void vfio_platform_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    for (i = 0; i < vbasedev->num_regions; i++) {
+    for (i = 0; i < vbasedev->num_initial_regions; i++) {
         if (vfio_region_mmap(vdev->regions[i])) {
             warn_report("%s mmap unsupported, performance may be slow",
                         memory_region_name(vdev->regions[i]->mem));
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 6e4d5ccdac..10024730a1 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -74,7 +74,7 @@ typedef struct VFIODevice {
     VFIODeviceOps *ops;
     VFIODeviceIOOps *io_ops;
     unsigned int num_irqs;
-    unsigned int num_regions;
+    unsigned int num_initial_regions;
     unsigned int flags;
     VFIOMigration *migration;
     Error *migration_blocker;
-- 
2.47.3


