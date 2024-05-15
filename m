Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49E3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vu-0002CK-4V; Wed, 15 May 2024 04:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vk-00027Y-2n
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:08 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vi-00077F-4h
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761446; x=1747297446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3F9TJNc91782pIR+urG++O32ZvDEvSmI38+CJJPu0Qc=;
 b=NS0mNBm+ymIUjRFyqxSGLc8RXfNYFvHy/1pKfmyE/+SZ+VfiobrxTDgX
 igVxSz0x4Usqaxh0Jarfl7Pn+RBs5H0aYEjVaZMoJNonOAb5kuCWqLM+j
 kHfqFi7Ao2aY/94NRIA4nI1KwMLHYVyqgP6iKqF2T5a/wxoDu4vmr06Ik
 Xny1LSuZssd/DBpiXko/1oOe+Xrt0Gx6Gh9YNb3LmfResvBBurxCKdBao
 8OeeUntXD29j4VJ1c9PckfLW+OsOCnI6T2jrNly9SyNzi6lieg8kxNWWy
 DtUmaT6UytZksDg+qOPoaQqWB/xBcCtgvtkGprnFRdOY7MimaHogM+o23 g==;
X-CSE-ConnectionGUID: ifXxBBxhSCyxcZY7+bnk6Q==
X-CSE-MsgGUID: OdL6Nf4uRVyYWxh0Z5Ih9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961554"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961554"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:05 -0700
X-CSE-ConnectionGUID: 9Kmycv1RQX+bGzppb813mQ==
X-CSE-MsgGUID: yzCV3LItQ8qLrq2Ta4D3mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396337"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 09/16] vfio/pci: Make vfio_pci_relocate_msix() and
 vfio_msix_early_setup() return a bool
Date: Wed, 15 May 2024 16:20:34 +0800
Message-Id: <20240515082041.556571-10-zhenzhong.duan@intel.com>
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

Since vfio_pci_relocate_msix() and vfio_msix_early_setup() takes
an 'Error **' argument, best practices suggest to return a bool.
See the qapi/error.h Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 12fb534d79..379cbad757 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1450,13 +1450,13 @@ static void vfio_pci_fixup_msix_region(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
 {
     int target_bar = -1;
     size_t msix_sz;
 
     if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
-        return;
+        return true;
     }
 
     /* The actual minimum size of MSI-X structures */
@@ -1479,7 +1479,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
         if (target_bar < 0) {
             error_setg(errp, "No automatic MSI-X relocation available for "
                        "device %04x:%04x", vdev->vendor_id, vdev->device_id);
-            return;
+            return false;
         }
     } else {
         target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
@@ -1489,7 +1489,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
     if (vdev->bars[target_bar].ioport) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "I/O port BAR", target_bar);
-        return;
+        return false;
     }
 
     /* Cannot use a BAR in the "shadow" of a 64-bit BAR */
@@ -1497,7 +1497,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
          target_bar > 0 && vdev->bars[target_bar - 1].mem64) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "consumed by 64-bit BAR %d", target_bar, target_bar - 1);
-        return;
+        return false;
     }
 
     /* 2GB max size for 32-bit BARs, cannot double if already > 1G */
@@ -1505,7 +1505,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
         !vdev->bars[target_bar].mem64) {
         error_setg(errp, "Invalid MSI-X relocation BAR %d, "
                    "no space to extend 32-bit BAR", target_bar);
-        return;
+        return false;
     }
 
     /*
@@ -1540,6 +1540,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
 
     trace_vfio_msix_relo(vdev->vbasedev.name,
                          vdev->msix->table_bar, vdev->msix->table_offset);
+    return true;
 }
 
 /*
@@ -1550,7 +1551,7 @@ static void vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  * need to first look for where the MSI-X table lives.  So we
  * unfortunately split MSI-X setup across two functions.
  */
-static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
+static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pos;
     uint16_t ctrl;
@@ -1562,25 +1563,25 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
-        return;
+        return true;
     }
 
     if (pread(fd, &ctrl, sizeof(ctrl),
               vdev->config_offset + pos + PCI_MSIX_FLAGS) != sizeof(ctrl)) {
         error_setg_errno(errp, errno, "failed to read PCI MSIX FLAGS");
-        return;
+        return false;
     }
 
     if (pread(fd, &table, sizeof(table),
               vdev->config_offset + pos + PCI_MSIX_TABLE) != sizeof(table)) {
         error_setg_errno(errp, errno, "failed to read PCI MSIX TABLE");
-        return;
+        return false;
     }
 
     if (pread(fd, &pba, sizeof(pba),
               vdev->config_offset + pos + PCI_MSIX_PBA) != sizeof(pba)) {
         error_setg_errno(errp, errno, "failed to read PCI MSIX PBA");
-        return;
+        return false;
     }
 
     ctrl = le16_to_cpu(ctrl);
@@ -1598,7 +1599,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
         g_free(msix);
-        return;
+        return false;
     }
 
     msix->noresize = !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE);
@@ -1630,7 +1631,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
             error_setg(errp, "hardware reports invalid configuration, "
                        "MSIX PBA outside of specified BAR");
             g_free(msix);
-            return;
+            return false;
         }
     }
 
@@ -1641,7 +1642,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
     vfio_pci_fixup_msix_region(vdev);
 
-    vfio_pci_relocate_msix(vdev, errp);
+    return vfio_pci_relocate_msix(vdev, errp);
 }
 
 static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
@@ -3130,8 +3131,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_prepare(vdev);
 
-    vfio_msix_early_setup(vdev, &err);
-    if (err) {
+    if (!vfio_msix_early_setup(vdev, &err)) {
         error_propagate(errp, err);
         goto error;
     }
-- 
2.34.1


