Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A00C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 04:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfB98-00078q-Rh; Tue, 27 Feb 2024 23:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB97-0006uh-0s
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:02:17 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfB95-00010z-7X
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 23:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709092935; x=1740628935;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G5emsBpzDoR9ENpp9MsafbIOfAuXfNSRmkIdZdtH4dw=;
 b=M37t1odFgGFfNZq6l44aFfwSgG7WH7Vv0Tyc370pU9rsPog2kIaoDi6C
 FeVuNq8RbNYhsXFy5c7jxFCcH5ZhbecgrZXG+M5Vf0vZwjYCDocx270lf
 cYPQwAsPuL9cD0t76T2zf2tUG9D40IlTHdjIDqEhs/b9Yh/CQxW7SqQKl
 VHuRSfAqEB94cFGOvA2K0UpGoKXnEJpgjlPz3wHehsjsY9J4+W+gRVAZe
 +lTVzLT+vowwDgdjahoS5tzimvpTsVHMAMMpkRSx/AVWdIa0SFIj/VoaS
 w6UywNeGM8vu9ES+24YGXVqhMeWboCIIVHFn0w2fAhtBGAFgminiXPOTB g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3342521"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3342521"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; d="scan'208";a="11917371"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 20:01:46 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v1 10/11] vfio: Pass HostIOMMUDevice to vIOMMU
Date: Wed, 28 Feb 2024 11:58:59 +0800
Message-Id: <20240228035900.1085727-11-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Support both iommufd and legacy backend.

Originally-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6cc7de5d10..ed9f386fde 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3112,11 +3112,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    ret = vfio_add_capabilities(vdev, errp);
+    ret = pci_device_set_iommu_device(pdev, vbasedev->base_hdev, errp);
     if (ret) {
+        error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
 
+    ret = vfio_add_capabilities(vdev, errp);
+    if (ret) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
@@ -3133,7 +3139,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             error_setg(errp,
                        "cannot support IGD OpRegion feature on hotplugged "
                        "device");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_get_dev_region_info(vbasedev,
@@ -3142,13 +3148,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
 
@@ -3234,6 +3240,8 @@ out_deregister:
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
+out_unset_idev:
+    pci_device_unset_iommu_device(pdev);
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3263,6 +3271,7 @@ static void vfio_instance_finalize(Object *obj)
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3277,7 +3286,8 @@ static void vfio_exitfn(PCIDevice *pdev)
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


