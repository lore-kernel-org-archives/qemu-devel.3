Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50A7C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79w4-0002Ei-Ie; Wed, 15 May 2024 04:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79w3-0002E2-1C
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:27 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79w0-00078x-Ui
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761465; x=1747297465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T+eVqA9MCcvs1IE+2O2X5MUuXFs0um/6d7ZD8zXzByU=;
 b=OJk9lZAEmMxVMn4d+Cuw3wXVYNainaC0dey4saGb8mgQvSPkL3e/MXD0
 dD+l7MqStHpXNjYEk9DdEXU6iPLjIoEQ1RTH7IUwq7ghDmO1FG5Ix1jx/
 trbmGNi4wqxeWURFsXehARuF0Kpcp1VG3OscA5O05FyGQpw0u9yjgb85J
 8u9u+8fTTLgOeuAtFunAggY4B652QpbJvNE4oQdCY0cZpVMXrjY3kHjyX
 tT1YsApQXi0FtKpc3fXkKPL7/mogbSzubSpw/g63+As8WoYljFjykajFr
 J+dBGiUM5kHucoBDZDSAJRK6z3iLu7uD8rP4LYunMh1hPs1HbqHfTo51b A==;
X-CSE-ConnectionGUID: 88U/r/3sRAWLochPXIcUPA==
X-CSE-MsgGUID: X72/Xi+eRYiv8mfeyCySvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961565"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961565"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:14 -0700
X-CSE-ConnectionGUID: SahBJXL2Q5+LhBCdqlntKw==
X-CSE-MsgGUID: UriCO2PZTzmwogkvH1xOKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396369"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 13/16] vfio/pci: Make capability related functions return bool
Date: Wed, 15 May 2024 16:20:38 +0800
Message-Id: <20240515082041.556571-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

The functions operating on capability don't have a consistent return style.

Below functions are in bool-valued functions style:
vfio_msi_setup()
vfio_msix_setup()
vfio_add_std_cap()
vfio_add_capabilities()

Below two are integer-valued functions:
vfio_add_vendor_specific_cap()
vfio_setup_pcie_cap()

But the returned integer is only used for check succeed/failure.
Change them all to return bool so now all capability related
functions follow the coding standand in qapi/error.h to return
bool.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 77 ++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1922593253..ecfbb9619f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1339,7 +1339,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
     }
 }
 
-static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
+static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
     uint16_t ctrl;
     bool msi_64bit, msi_maskbit;
@@ -1349,7 +1349,7 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     if (pread(vdev->vbasedev.fd, &ctrl, sizeof(ctrl),
               vdev->config_offset + pos + PCI_CAP_FLAGS) != sizeof(ctrl)) {
         error_setg_errno(errp, errno, "failed reading MSI PCI_CAP_FLAGS");
-        return -errno;
+        return false;
     }
     ctrl = le16_to_cpu(ctrl);
 
@@ -1362,14 +1362,14 @@ static int vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     ret = msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit, &err);
     if (ret < 0) {
         if (ret == -ENOTSUP) {
-            return 0;
+            return true;
         }
         error_propagate_prepend(errp, err, "msi_init failed: ");
-        return ret;
+        return false;
     }
     vdev->msi_cap_size = 0xa + (msi_maskbit ? 0xa : 0) + (msi_64bit ? 0x4 : 0);
 
-    return 0;
+    return true;
 }
 
 static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
@@ -1644,7 +1644,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     return vfio_pci_relocate_msix(vdev, errp);
 }
 
-static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
+static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
     int ret;
     Error *err = NULL;
@@ -1660,11 +1660,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     if (ret < 0) {
         if (ret == -ENOTSUP) {
             warn_report_err(err);
-            return 0;
+            return true;
         }
 
         error_propagate(errp, err);
-        return ret;
+        return false;
     }
 
     /*
@@ -1698,7 +1698,7 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
         memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
     }
 
-    return 0;
+    return true;
 }
 
 static void vfio_teardown_msi(VFIOPCIDevice *vdev)
@@ -1977,8 +1977,8 @@ static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
     }
 }
 
-static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
-                               Error **errp)
+static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
+                                Error **errp)
 {
     uint16_t flags;
     uint8_t type;
@@ -1992,7 +1992,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
 
         error_setg(errp, "assignment of PCIe type 0x%x "
                    "devices is not currently supported", type);
-        return -EINVAL;
+        return false;
     }
 
     if (!pci_bus_is_express(pci_get_bus(&vdev->pdev))) {
@@ -2025,7 +2025,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
         }
 
         if (pci_bus_is_express(bus)) {
-            return 0;
+            return true;
         }
 
     } else if (pci_bus_is_root(pci_get_bus(&vdev->pdev))) {
@@ -2063,7 +2063,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
              * Legacy endpoints don't belong on the root complex.  Windows
              * seems to be happier with devices if we skip the capability.
              */
-            return 0;
+            return true;
         }
 
     } else {
@@ -2099,12 +2099,12 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
     pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
                              errp);
     if (pos < 0) {
-        return pos;
+        return false;
     }
 
     vdev->pdev.exp.exp_cap = pos;
 
-    return pos;
+    return true;
 }
 
 static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
@@ -2137,14 +2137,14 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
     }
 }
 
-static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
-                                        uint8_t size, Error **errp)
+static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
+                                         uint8_t size, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
     pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
     if (pos < 0) {
-        return pos;
+        return false;
     }
 
     /*
@@ -2156,15 +2156,15 @@ static int vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
         memset(pdev->cmask + pos + 3, 0, size - 3);
     }
 
-    return pos;
+    return true;
 }
 
-static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
+static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
     ERRP_GUARD();
     PCIDevice *pdev = &vdev->pdev;
     uint8_t cap_id, next, size;
-    int ret;
+    bool ret;
 
     cap_id = pdev->config[pos];
     next = pdev->config[pos + PCI_CAP_LIST_NEXT];
@@ -2185,9 +2185,8 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
      * will be changed as we unwind the stack.
      */
     if (next) {
-        ret = vfio_add_std_cap(vdev, next, errp);
-        if (ret) {
-            return ret;
+        if (!vfio_add_std_cap(vdev, next, errp)) {
+            return false;
         }
     } else {
         /* Begin the rebuild, use QEMU emulated list bits */
@@ -2197,7 +2196,7 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 
         ret = vfio_add_virt_caps(vdev, errp);
         if (ret) {
-            return ret;
+            return false;
         }
     }
 
@@ -2221,28 +2220,27 @@ static int vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
     case PCI_CAP_ID_PM:
         vfio_check_pm_reset(vdev, pos);
         vdev->pm_cap = pos;
-        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
+        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
         break;
     case PCI_CAP_ID_AF:
         vfio_check_af_flr(vdev, pos);
-        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
+        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
         break;
     case PCI_CAP_ID_VNDR:
         ret = vfio_add_vendor_specific_cap(vdev, pos, size, errp);
         break;
     default:
-        ret = pci_add_capability(pdev, cap_id, pos, size, errp);
+        ret = pci_add_capability(pdev, cap_id, pos, size, errp) >= 0;
         break;
     }
 
-    if (ret < 0) {
+    if (!ret) {
         error_prepend(errp,
                       "failed to add PCI capability 0x%x[0x%x]@0x%x: ",
                       cap_id, size, pos);
-        return ret;
     }
 
-    return 0;
+    return ret;
 }
 
 static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
@@ -2388,23 +2386,21 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     return;
 }
 
-static int vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
-    int ret;
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
-        return 0; /* Nothing to add */
+        return true; /* Nothing to add */
     }
 
-    ret = vfio_add_std_cap(vdev, pdev->config[PCI_CAPABILITY_LIST], errp);
-    if (ret) {
-        return ret;
+    if (!vfio_add_std_cap(vdev, pdev->config[PCI_CAPABILITY_LIST], errp)) {
+        return false;
     }
 
     vfio_add_ext_cap(vdev);
-    return 0;
+    return true;
 }
 
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
@@ -3136,8 +3132,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    ret = vfio_add_capabilities(vdev, errp);
-    if (ret) {
+    if (!vfio_add_capabilities(vdev, errp)) {
         goto out_teardown;
     }
 
-- 
2.34.1


