Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B2AC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 04:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9doh-0001UB-EB; Wed, 22 May 2024 00:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doe-0001TL-Ny
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:04 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9doc-0005uB-0a
 for qemu-devel@nongnu.org; Wed, 22 May 2024 00:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716352982; x=1747888982;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4vnQ/6Kcq+OwTuoUc/ihEvaXOo4aI1an8bbYY1k+F7A=;
 b=d30gYit/2ER9/GKgzjYehpRCPE5bD9SejDeL/hdsotdqkLQpe+3oYOZb
 14qpcrQEOwLIk1wduWGXS+vtoje7vvhSmHW2ungwO2Vw1iMFf4OlXtIUO
 n0VwuAfQF2X3nrT1iKvIsEWKONRWUj4dvrGmDrhOfXy7t4seFpFDRhail
 WghR/71dPmo1EyBjSQYQvHSPaZoC/GOkhKtyotqJ6aXAHFDLw//PENxM3
 fuMpWdIAgEKkUMj/KDQwOAent1kt5R089rwQRn8k1qvU0NynKokenLpd9
 /+WPCDfzr+a+7Jc5GNV9vEUvjCXfurR5QDmFdj1uQaXVHG+NEC6a4nqed A==;
X-CSE-ConnectionGUID: OpC4ehdjSmykOtyASaa/eQ==
X-CSE-MsgGUID: xvS3SV5RTNCp42Gx93JAmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23994151"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="23994151"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:02 -0700
X-CSE-ConnectionGUID: yFEdXlSfRCKdVJcLx7kaxQ==
X-CSE-MsgGUID: yVQ+vkj6TCG+qC4belZ88Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33683732"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 21:43:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 10/20] vfio/pci: Make vfio_populate_device() return a bool
Date: Wed, 22 May 2024 12:40:05 +0800
Message-Id: <20240522044015.412951-11-zhenzhong.duan@intel.com>
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

Since vfio_populate_device() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

By this chance, pass errp directly to vfio_populate_device() to
avoid calling error_propagate().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fb5fd0c9f..46d3c61859 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2740,7 +2740,7 @@ int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return 0;
 }
 
-static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info;
@@ -2750,18 +2750,18 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     /* Sanity check device */
     if (!(vbasedev->flags & VFIO_DEVICE_FLAGS_PCI)) {
         error_setg(errp, "this isn't a PCI device");
-        return;
+        return false;
     }
 
     if (vbasedev->num_regions < VFIO_PCI_CONFIG_REGION_INDEX + 1) {
         error_setg(errp, "unexpected number of io regions %u",
                    vbasedev->num_regions);
-        return;
+        return false;
     }
 
     if (vbasedev->num_irqs < VFIO_PCI_MSIX_IRQ_INDEX + 1) {
         error_setg(errp, "unexpected number of irqs %u", vbasedev->num_irqs);
-        return;
+        return false;
     }
 
     for (i = VFIO_PCI_BAR0_REGION_INDEX; i < VFIO_PCI_ROM_REGION_INDEX; i++) {
@@ -2773,7 +2773,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
         if (ret) {
             error_setg_errno(errp, -ret, "failed to get region %d info", i);
-            return;
+            return false;
         }
 
         QLIST_INIT(&vdev->bars[i].quirks);
@@ -2783,7 +2783,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
                                VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
     if (ret) {
         error_setg_errno(errp, -ret, "failed to get config info");
-        return;
+        return false;
     }
 
     trace_vfio_populate_device_config(vdev->vbasedev.name,
@@ -2804,7 +2804,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         if (ret) {
             error_append_hint(errp, "device does not support "
                               "requested feature x-vga\n");
-            return;
+            return false;
         }
     }
 
@@ -2821,6 +2821,8 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
                     "Could not enable error recovery for the device",
                     vbasedev->name);
     }
+
+    return true;
 }
 
 static void vfio_pci_put_device(VFIOPCIDevice *vdev)
@@ -2977,7 +2979,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     char *subsys;
-    Error *err = NULL;
     int i, ret;
     bool is_mdev;
     char uuid[UUID_STR_LEN];
@@ -3036,9 +3037,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    vfio_populate_device(vdev, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!vfio_populate_device(vdev, errp)) {
         goto error;
     }
 
-- 
2.34.1


