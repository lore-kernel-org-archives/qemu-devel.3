Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A5DC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dpB-0001zs-TK; Wed, 22 May 2024 00:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dp9-0001p8-L8
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:35 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dp7-0005wQ-Go
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353013; x=1747889013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r1ujOT9wnmzL4Jy0xbnj8LOr9Q4ivRZVm5w7T144XKg=;
 b=Bs+enfOPnGSJArIRggqiEGdLxeKLcmeMdvv49wWMd2v4/n+2dBjyKyn2
 nVBEXM8o4bOdcQnbu4oIY91XMaCN8x6TxnKsBTF8TyrNq7AJpzB3YyUYE
 szx0MCe1dyouOq1FxS4yQaP8MO2tO2oLBMad92ZHedSAA38yvgjlR+/Je
 ZjRPnJMw+bUXKzWxMmQ8bYWgxIAVHBNDVL0LdVA1mywVgJKqx79K2KdWX
 gCdx417OYbE2tx4SIpH4zT3TPD0kmrHi3RIyzciy9P3u6NAU5pA1SC9ou
 paClis4h67tj/x+bnx2/kKfVGQBgI7UxQYzOJMwhMM1BdfkQxT6lG8fUl Q==;
X-CSE-ConnectionGUID: nO8fOkpuRfy7b24YXrGWSA==
X-CSE-MsgGUID: 5CWtU9nmSFqeaVFyT1I+4w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994210"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994210"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:17 -0700
X-CSE-ConnectionGUID: 1Tf3vL9JQ4Kc2Y4/nZIUog==
X-CSE-MsgGUID: 8IjPgqwIQ8mvZp6ikIf7IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683795"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 17/20] vfio: Use g_autofree in all call site of
 vfio_get_region_info()
Date: Wed, 22 May 2024 12:40:12 +0800
Message-Id: <20240522044015.412951-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There are some exceptions when pointer to vfio_region_info is reused.
In that case, the pointed memory is freed manually.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/helpers.c |  7 ++-----
 hw/vfio/igd.c     |  5 ++---
 hw/vfio/pci.c     | 13 +++----------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 4b079dc383..27ea26aa48 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -343,7 +343,7 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
 int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
                       int index, const char *name)
 {
-    struct vfio_region_info *info;
+    g_autofree struct vfio_region_info *info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, index, &info);
@@ -376,8 +376,6 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
         }
     }
 
-    g_free(info);
-
     trace_vfio_region_setup(vbasedev->name, index, name,
                             region->flags, region->fd_offset, region->size);
     return 0;
@@ -594,14 +592,13 @@ int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
 
 bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
 {
-    struct vfio_region_info *info = NULL;
+    g_autofree struct vfio_region_info *info = NULL;
     bool ret = false;
 
     if (!vfio_get_region_info(vbasedev, region, &info)) {
         if (vfio_get_region_info_cap(info, cap_type)) {
             ret = true;
         }
-        g_free(info);
     }
 
     return ret;
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 402fc5ce1d..1e79202f2b 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -367,8 +367,8 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
 
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
-    struct vfio_region_info *rom = NULL, *opregion = NULL,
-                            *host = NULL, *lpc = NULL;
+    g_autofree struct vfio_region_info *rom = NULL;
+    struct vfio_region_info *opregion = NULL, *host = NULL, *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
@@ -609,7 +609,6 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
 
 out:
-    g_free(rom);
     g_free(opregion);
     g_free(host);
     g_free(lpc);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 35ad9b582f..74a79bdf61 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -879,7 +879,7 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
 
 static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
 {
-    struct vfio_region_info *reg_info;
+    g_autofree struct vfio_region_info *reg_info = NULL;
     uint64_t size;
     off_t off = 0;
     ssize_t bytes;
@@ -897,8 +897,6 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
     vdev->rom_size = size = reg_info->size;
     vdev->rom_offset = reg_info->offset;
 
-    g_free(reg_info);
-
     if (!vdev->rom_size) {
         vdev->rom_read_failed = true;
         error_report("vfio-pci: Cannot read device rom at "
@@ -2668,7 +2666,7 @@ static VFIODeviceOps vfio_pci_ops = {
 bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    struct vfio_region_info *reg_info;
+    g_autofree struct vfio_region_info *reg_info = NULL;
     int ret;
 
     ret = vfio_get_region_info(vbasedev, VFIO_PCI_VGA_REGION_INDEX, &reg_info);
@@ -2685,7 +2683,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
         error_setg(errp, "unexpected VGA info, flags 0x%lx, size 0x%lx",
                    (unsigned long)reg_info->flags,
                    (unsigned long)reg_info->size);
-        g_free(reg_info);
         return false;
     }
 
@@ -2694,8 +2691,6 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     vdev->vga->fd_offset = reg_info->offset;
     vdev->vga->fd = vdev->vbasedev.fd;
 
-    g_free(reg_info);
-
     vdev->vga->region[QEMU_PCI_VGA_MEM].offset = QEMU_PCI_VGA_MEM_BASE;
     vdev->vga->region[QEMU_PCI_VGA_MEM].nr = QEMU_PCI_VGA_MEM;
     QLIST_INIT(&vdev->vga->region[QEMU_PCI_VGA_MEM].quirks);
@@ -2736,7 +2731,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
-    struct vfio_region_info *reg_info;
+    g_autofree struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
     int i, ret = -1;
 
@@ -2790,8 +2785,6 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     }
     vdev->config_offset = reg_info->offset;
 
-    g_free(reg_info);
-
     if (vdev->features & VFIO_FEATURE_ENABLE_VGA) {
         if (!vfio_populate_vga(vdev, errp)) {
             error_append_hint(errp, "device does not support "
-- 
2.34.1


