Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E323CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79w3-0002EA-Db; Wed, 15 May 2024 04:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79w1-0002Dq-H8
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:25 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vy-00078z-QK
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761462; x=1747297462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QdLjTGnHcXqx8H4sHtwILLStf345rO73jW1Xhafi9Wk=;
 b=Qy3z7LNjl1uBgpX6qlfiGKkKNehrrEcsHrUK/O60ZO52DiT7/ogAAGgu
 xIIPNCR3y3MVKcDDkIMDSipHXq552B4qPfWMYzPFYYsAviJk0PsP7YP8G
 fCp0jTvJwalTE5cvQhAnNOFM4wyXPhCjEtKGLjDZ3Eae9RNgh5nsk6ALX
 Do43RSzghx2WW3NFHkEOqo/WHndxiZbhblnNSeNo0DOAlsZstJ+N9cVxG
 y62CiR+YVFhfzFWcZjthulHra8mWm5hIez907fYxkGq6aetGPwfnwpTuJ
 3+iP+yk7dTg9Pdd/uxMob16qT9Q3Tdme3g/cvgHHrrZDNXWES4pybyrY0 Q==;
X-CSE-ConnectionGUID: vi7XEmmuR/mlTOyuhn1MVg==
X-CSE-MsgGUID: OOluqSSVTXW8nSR+LshDmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961563"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961563"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:12 -0700
X-CSE-ConnectionGUID: SWyJeqBbSrO+P3maszc4Yw==
X-CSE-MsgGUID: y+svfSVkQvygJ9MFglwRrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396364"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 12/16] vfio/pci: Make vfio_populate_vga() return bool
Date: Wed, 15 May 2024 16:20:37 +0800
Message-Id: <20240515082041.556571-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515082041.556571-1-zhenzhong.duan@intel.com>
References: <20240515082041.556571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is to follow the coding standand in qapi/error.h to return bool
for bool-valued functions.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.h |  2 +-
 hw/vfio/igd.c |  2 +-
 hw/vfio/pci.c | 11 +++++------
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a5ac9efd4b..7914f019d5 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -225,7 +225,7 @@ bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
 
-int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
                                struct vfio_region_info *info,
diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index b31ee79c60..ffe57c5954 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -478,7 +478,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
      * try to enable it.  Probably shouldn't be using legacy mode without VGA,
      * but also no point in us enabling VGA if disabled in hardware.
      */
-    if (!(gmch & 0x2) && !vdev->vga && vfio_populate_vga(vdev, &err)) {
+    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
         error_report("IGD device %s failed to enable VGA access, "
                      "legacy mode disabled", vdev->vbasedev.name);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e2ca4507f8..1922593253 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2670,7 +2670,7 @@ static VFIODeviceOps vfio_pci_ops = {
     .vfio_load_config = vfio_pci_load_config,
 };
 
-int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info;
@@ -2681,7 +2681,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
         error_setg_errno(errp, -ret,
                          "failed getting region info for VGA region index %d",
                          VFIO_PCI_VGA_REGION_INDEX);
-        return ret;
+        return false;
     }
 
     if (!(reg_info->flags & VFIO_REGION_INFO_FLAG_READ) ||
@@ -2691,7 +2691,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                    (unsigned long)reg_info->flags,
                    (unsigned long)reg_info->size);
         g_free(reg_info);
-        return -EINVAL;
+        return false;
     }
 
     vdev->vga = g_new0(VFIOVGA, 1);
@@ -2735,7 +2735,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
                      &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
                      &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
 
-    return 0;
+    return true;
 }
 
 static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
@@ -2798,8 +2798,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     g_free(reg_info);
 
     if (vdev->features & VFIO_FEATURE_ENABLE_VGA) {
-        ret = vfio_populate_vga(vdev, errp);
-        if (ret) {
+        if (!vfio_populate_vga(vdev, errp)) {
             error_append_hint(errp, "device does not support "
                               "requested feature x-vga\n");
             return false;
-- 
2.34.1


