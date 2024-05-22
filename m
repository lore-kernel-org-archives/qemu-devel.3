Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A8C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dp9-0001mf-GL; Wed, 22 May 2024 00:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dp8-0001dR-1K
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:34 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dp6-0005wM-2x
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353012; x=1747889012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j8T6r/SqLsJM5T4vmX872z0GLXVctTuK/o6SD9aHsJc=;
 b=Z5dLPpvdI58oRV9VJUDvX1kmrX6AEsyLFGvrKr+jHqT1Td07dQD2piA5
 mwSnEl1TCF7bdmYfPbBSOdvlIMFyZ25pqjDwgUBjvoGTCb/+1eGHBNc3w
 hidp1kdzHm2snW+EbwWieabxSEzUS90i5RzKG0HlMITybYp2gNSQeZ/a5
 fk4TbyoalwpjSfVRhK6OBhbKaXqVtPafUD+amqKXrIHsVlCAWsuppDboZ
 mxas6EC5+wLW8b72Q29MlX/D6LHY/sWSH7Qcqt9d03M63OsazNVcBteYF
 dMNAD2pO4iA/Kye+TMWc45E0FNwFZ0W4zbZzYxTfZLZhmYOcAmimuQ4+D A==;
X-CSE-ConnectionGUID: dHT6AzqGRW6Lq74+PtihIw==
X-CSE-MsgGUID: qieofTKSTYaxEm8EGWaB9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994205"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994205"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:15 -0700
X-CSE-ConnectionGUID: 66uclaccSveWwTWAC9Ay8A==
X-CSE-MsgGUID: JyHvSufDRpCRD9hVPpXqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683788"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 16/20] vfio/pci-quirks: Make vfio_add_*_cap() return bool
Date: Wed, 22 May 2024 12:40:11 +0800
Message-Id: <20240522044015.412951-17-zhenzhong.duan@intel.com>
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Include below functions:
vfio_add_virt_caps()
vfio_add_nv_gpudirect_cap()
vfio_add_vmd_shadow_cap()

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |  2 +-
 hw/vfio/pci-quirks.c | 42 +++++++++++++++++++-----------------------
 hw/vfio/pci.c        |  3 +--
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index f158681072..bf67df2fbc 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -212,7 +212,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr);
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr);
 void vfio_setup_resetfn_quirk(VFIOPCIDevice *vdev);
-int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp);
 void vfio_quirk_reset(VFIOPCIDevice *vdev);
 VFIOQuirk *vfio_quirk_alloc(int nr_mem);
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index ca27917159..39dae72497 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1536,7 +1536,7 @@ static bool is_valid_std_cap_offset(uint8_t pos)
             pos <= (PCI_CFG_SPACE_SIZE - PCI_CAP_SIZEOF));
 }
 
-static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
     PCIDevice *pdev = &vdev->pdev;
@@ -1545,18 +1545,18 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     uint8_t tmp;
 
     if (vdev->nv_gpudirect_clique == 0xFF) {
-        return 0;
+        return true;
     }
 
     if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID)) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid device vendor");
-        return -EINVAL;
+        return false;
     }
 
     if (pci_get_byte(pdev->config + PCI_CLASS_DEVICE + 1) !=
         PCI_BASE_CLASS_DISPLAY) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: unsupported PCI class");
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -1572,7 +1572,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
                 vdev->config_offset + PCI_CAPABILITY_LIST);
     if (ret != 1 || !is_valid_std_cap_offset(tmp)) {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: error getting cap list");
-        return -EINVAL;
+        return false;
     }
 
     do {
@@ -1590,13 +1590,13 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
         pos = 0xD4;
     } else {
         error_setg(errp, "NVIDIA GPUDirect Clique ID: invalid config space");
-        return -EINVAL;
+        return false;
     }
 
     ret = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, 8, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add NVIDIA GPUDirect cap: ");
-        return ret;
+        return false;
     }
 
     memset(vdev->emulated_config_bits + pos, 0xFF, 8);
@@ -1608,7 +1608,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
     pci_set_byte(pdev->config + pos++, vdev->nv_gpudirect_clique << 3);
     pci_set_byte(pdev->config + pos, 0);
 
-    return 0;
+    return true;
 }
 
 /*
@@ -1629,7 +1629,7 @@ static int vfio_add_nv_gpudirect_cap(VFIOPCIDevice *vdev, Error **errp)
  */
 #define VMD_SHADOW_CAP_VER 1
 #define VMD_SHADOW_CAP_LEN 24
-static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
 {
     ERRP_GUARD();
     uint8_t membar_phys[16];
@@ -1639,7 +1639,7 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
           vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x467F) ||
           vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x4C3D) ||
           vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, 0x9A0B))) {
-        return 0;
+        return true;
     }
 
     ret = pread(vdev->vbasedev.fd, membar_phys, 16,
@@ -1647,14 +1647,14 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
     if (ret != 16) {
         error_report("VMD %s cannot read MEMBARs (%d)",
                      vdev->vbasedev.name, ret);
-        return -EFAULT;
+        return false;
     }
 
     ret = pci_add_capability(&vdev->pdev, PCI_CAP_ID_VNDR, pos,
                              VMD_SHADOW_CAP_LEN, errp);
     if (ret < 0) {
         error_prepend(errp, "Failed to add VMD MEMBAR Shadow cap: ");
-        return ret;
+        return false;
     }
 
     memset(vdev->emulated_config_bits + pos, 0xFF, VMD_SHADOW_CAP_LEN);
@@ -1664,22 +1664,18 @@ static int vfio_add_vmd_shadow_cap(VFIOPCIDevice *vdev, Error **errp)
     pci_set_long(vdev->pdev.config + pos, 0x53484457); /* SHDW */
     memcpy(vdev->pdev.config + pos + 4, membar_phys, 16);
 
-    return 0;
+    return true;
 }
 
-int vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_add_virt_caps(VFIOPCIDevice *vdev, Error **errp)
 {
-    int ret;
-
-    ret = vfio_add_nv_gpudirect_cap(vdev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_add_nv_gpudirect_cap(vdev, errp)) {
+        return false;
     }
 
-    ret = vfio_add_vmd_shadow_cap(vdev, errp);
-    if (ret) {
-        return ret;
+    if (!vfio_add_vmd_shadow_cap(vdev, errp)) {
+        return false;
     }
 
-    return 0;
+    return true;
 }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 76a3931dba..35ad9b582f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2194,8 +2194,7 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
         vdev->emulated_config_bits[PCI_CAPABILITY_LIST] = 0xff;
         vdev->emulated_config_bits[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
 
-        ret = vfio_add_virt_caps(vdev, errp);
-        if (ret) {
+        if (!vfio_add_virt_caps(vdev, errp)) {
             return false;
         }
     }
-- 
2.34.1


