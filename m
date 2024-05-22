Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87411C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9dpJ-0002Ug-Qu; Wed, 22 May 2024 00:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dpH-0002OT-7a
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:43 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9dpF-0005wI-Gw
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716353021; x=1747889021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0mVsJycZ0+yemdLDwZw/Xcikr0NANe2J64lu6LFt2V0=;
 b=fjIYF4AIRuQWsBJaCHP4M/KKGgKDx0lKEmLslCije84IdJYdyP2H9d/U
 adSZJcBquEZdr61nQ4fdIgaN+1QPUcbJ2x0gEffSRgYj7uIt8Aa7Yj/hu
 UewuTdQbgaSxlvl1zqhhI0z300g9mJPF767uwIWqpVsGSCPHAHt0gNAfV
 1WyQYckC94hkJYAaGJ14y6vf4s7zJawVq6el70z/Zwga4Y07+YEx0kAG/
 m8HC8rbY4a4HFRQx/AFLQnOftvGWlPUXhUQ2kd1Ka0vMMLMBCjmMJEL0i
 TwcnN8w67XTkHv7DfKf0km1NKfFxEy4GgdVsXEmh04EqocYF1e7Ua+GsL A==;
X-CSE-ConnectionGUID: hyWJHSw0SPemiSYeJly3Sw==
X-CSE-MsgGUID: GPPuHPhSQniYpj948HNlVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994214"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994214"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:20 -0700
X-CSE-ConnectionGUID: JyiFn6yCQAmC2Otk6+JDKQ==
X-CSE-MsgGUID: DUQHQf+fTsuOqtrTz5AEgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683803"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 18/20] vfio/igd: Use g_autofree in
 vfio_probe_igd_bar4_quirk()
Date: Wed, 22 May 2024 12:40:13 +0800
Message-Id: <20240522044015.412951-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522044015.412951-1-zhenzhong.duan@intel.com>
References: <20240522044015.412951-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

Pointer opregion, host and lpc are allocated and freed in
vfio_probe_igd_bar4_quirk(). Use g_autofree to automatically
free them.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/igd.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 1e79202f2b..d320d032a7 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -368,7 +368,9 @@ static const MemoryRegionOps vfio_igd_index_quirk = {
 void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 {
     g_autofree struct vfio_region_info *rom = NULL;
-    struct vfio_region_info *opregion = NULL, *host = NULL, *lpc = NULL;
+    g_autofree struct vfio_region_info *opregion = NULL;
+    g_autofree struct vfio_region_info *host = NULL;
+    g_autofree struct vfio_region_info *lpc = NULL;
     VFIOQuirk *quirk;
     VFIOIGDQuirk *igd;
     PCIDevice *lpc_bridge;
@@ -426,7 +428,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if ((ret || !rom->size) && !vdev->pdev.romfile) {
         error_report("IGD device %s has no ROM, legacy mode disabled",
                      vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /*
@@ -437,7 +439,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_report("IGD device %s hotplugged, ROM disabled, "
                      "legacy mode disabled", vdev->vbasedev.name);
         vdev->rom_read_failed = true;
-        goto out;
+        return;
     }
 
     /*
@@ -450,7 +452,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support OpRegion access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -459,7 +461,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support host bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     ret = vfio_get_dev_region_info(&vdev->vbasedev,
@@ -468,7 +470,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s does not support LPC bridge access,"
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
@@ -482,7 +484,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Create our LPC/ISA bridge */
@@ -490,7 +492,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to create LPC bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Stuff some host values into the VM PCI host bridge */
@@ -498,14 +500,14 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     if (ret) {
         error_report("IGD device %s failed to modify host bridge, "
                      "legacy mode disabled", vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Setup OpRegion access */
     if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
         error_append_hint(&err, "IGD legacy mode disabled\n");
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-        goto out;
+        return;
     }
 
     /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
@@ -607,9 +609,4 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     }
 
     trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, ggms_mb + gms_mb);
-
-out:
-    g_free(opregion);
-    g_free(host);
-    g_free(lpc);
 }
-- 
2.34.1


