Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5BDC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 09:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4dHY-0001Qd-WC; Wed, 08 May 2024 05:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHW-000179-61
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:08:10 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4dHU-0005k5-8K
 for qemu-devel@nongnu.org; Wed, 08 May 2024 05:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715159289; x=1746695289;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=18k6nX8RYXDryuQzqVzfMOPDDLkMyXMbOqZziraopNQ=;
 b=BCtRkZrDTqV68bqOCbtfBtglW1LSBv7UmA1PqXveQKsbWtfVtQ3PqYV3
 +h85kda1u6TKsFUW34riyur4D6QmgHmEWFNpSmWOBnMg/NY9G4oCBvrCv
 B6gejMi5ErPzHrND3X5V0FshlyYVIPZEyF8AzS6V1f2cPopGtg69UWMsY
 K2yYtGILVJIkImrClF2tFNptQApfRNsfa9wu0p8jGNBMH9fvQJjsvLECw
 sK+ptGAe2xgnfk5FvzBQNgHJimEpa59G76VBomwIlCFv5PgCvSeffb0qR
 Nax3yI8rsivG9yIQ8XlWBzKJyAtSO/tlla9g67+0O0tI8lQasEIltrxla g==;
X-CSE-ConnectionGUID: StfrwCfYSxKNbymy0B3GSQ==
X-CSE-MsgGUID: NBbRaMLyTHaVeWay97jdEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11161085"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="11161085"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:08:07 -0700
X-CSE-ConnectionGUID: HF51NBo4Q0u1jcjep99Ddw==
X-CSE-MsgGUID: 98kbx5F1QTqZn3K6Vyiy5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="29226713"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2024 02:08:03 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v5 16/19] vfio/pci: Pass HostIOMMUDevice to vIOMMU
Date: Wed,  8 May 2024 17:03:51 +0800
Message-Id: <20240508090354.1815561-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

With HostIOMMUDevice passed, vIOMMU can check compatibility with host
IOMMU, call into IOMMUFD specific methods, etc.

Originally-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d3beb15514..7205702f7f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3109,9 +3109,14 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
+    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+        error_prepend(errp, "Failed to set iommu_device: ");
+        goto out_teardown;
+    }
+
     ret = vfio_add_capabilities(vdev, errp);
     if (ret) {
-        goto out_teardown;
+        goto out_unset_idev;
     }
 
     if (vdev->vga) {
@@ -3130,7 +3135,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             error_setg(errp,
                        "cannot support IGD OpRegion feature on hotplugged "
                        "device");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_get_dev_region_info(vbasedev,
@@ -3139,13 +3144,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         if (ret) {
             error_setg_errno(errp, -ret,
                              "does not support requested IGD OpRegion feature");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_pci_igd_opregion_init(vdev, opregion, errp);
         g_free(opregion);
         if (ret) {
-            goto out_teardown;
+            goto out_unset_idev;
         }
     }
 
@@ -3231,6 +3236,8 @@ out_deregister:
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
+out_unset_idev:
+    pci_device_unset_iommu_device(pdev);
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3259,6 +3266,7 @@ static void vfio_instance_finalize(Object *obj)
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3273,7 +3281,8 @@ static void vfio_exitfn(PCIDevice *pdev)
     vfio_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
-    vfio_migration_exit(&vdev->vbasedev);
+    vfio_migration_exit(vbasedev);
+    pci_device_unset_iommu_device(pdev);
 }
 
 static void vfio_pci_reset(DeviceState *dev)
-- 
2.34.1


