Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3976C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79vv-0002D4-3S; Wed, 15 May 2024 04:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vm-00027x-3K
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:11 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s79vk-00077f-BQ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715761448; x=1747297448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RbeV441iM22XR842XrI5xKUNjvxFueaKXj0QFB2gaYg=;
 b=CmunakbtPibqwtBvlubYyq2zjlMJgIzAdZCaGOQ0E9aGIYNFeV5PovUq
 hI+i2eKBvCJDqnfhj+QXPR1tiIWVObfBVWjzLLMKxmlI5STFtnM6Z0jWP
 Tm9t/YaOaMZTrxnXKtthTpU/PPZn+IFe+SI5cp81y+9pWpBnu+Y2CPttZ
 G2CcFszC6WM97lRRGHM+BBTsfMaaz2RVIpIkWXFdiw/EJA/UFDwE79oZ6
 /VBb7F1eWOsPhkyuvbV87odeUGc2G4UMw163/gO+ux8pKzZBzwjkGCDSx
 JoD3LOCkHRqevgDIhgD3xwdYkfI4PNqL5a/fK+g/HtVqd5pDJHJ/0GiJN w==;
X-CSE-ConnectionGUID: PtSqgykVTdqdgIwt48rnxw==
X-CSE-MsgGUID: Wu2mAkK1ToaPiQHL0lohHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11961557"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11961557"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:07 -0700
X-CSE-ConnectionGUID: v8vu6oSETlmQABlObGkGLA==
X-CSE-MsgGUID: 2YDYzfceS8W2YCaACdlurg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31396347"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:24:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 10/16] vfio/pci: Make vfio_populate_device() return a bool
Date: Wed, 15 May 2024 16:20:35 +0800
Message-Id: <20240515082041.556571-11-zhenzhong.duan@intel.com>
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

Since vfio_populate_device() takes an 'Error **' argument,
best practices suggest to return a bool. See the qapi/error.h
Rules section.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 379cbad757..c091d21adf 100644
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
@@ -3036,8 +3038,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    vfio_populate_device(vdev, &err);
-    if (err) {
+    if (!vfio_populate_device(vdev, &err)) {
         error_propagate(errp, err);
         goto error;
     }
-- 
2.34.1


