Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C3EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuR-0002zo-Kq; Mon, 29 Apr 2024 02:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuP-0002u7-DW
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:41 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuK-0007m1-6W
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373676; x=1745909676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=brdfmfoa2727Rep2O7aimUC9ZxCZnVThwz+OaTXE4tU=;
 b=FAE2hsLtdRW63QrN9yoc0KD+Xgo6hfkukBl+yUcIgzJ/uFFpzbB+ey8s
 tykj4juAAQSmvVxp/dmDcD2I8w4UiA6LYBeR8DCrxZsM1xyZIbeMXV5xr
 TUgliq90pRJNQMomUH3bKNrsYyG0LJ+g4cERJem4Tmrunc843gJNtzhW8
 kLQ8DhKNLEfLE02LFvwO8DUcp0Mb+/6wt56lP5XmCu+H5nOyck3oM9M18
 /npfLW2ndep8WAIzF1bo8XZiWb3sTU+L1JtnSpDCEQzepGB26LMU24gQk
 iIOhGbaAtqtvlAqYqFlaymC8IoejpaK662fp8QhIK6sMTyFyU0hCUsXtK g==;
X-CSE-ConnectionGUID: qc0zYV1lQ9SxrKRS8/anDw==
X-CSE-MsgGUID: 0Itr44RrSH2TNpCJ03mQpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560758"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:25 -0700
X-CSE-ConnectionGUID: bYBDfOCzQ86ncoa7i/9Gdw==
X-CSE-MsgGUID: Ul9rC7HuRTONcJKpRsI7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488357"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v3 16/19] vfio/pci: Pass HostIOMMUDevice to vIOMMU
Date: Mon, 29 Apr 2024 14:50:43 +0800
Message-Id: <20240429065046.3688701-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
 hw/vfio/pci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 64780d1b79..224501a86e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3111,11 +3111,17 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    ret = vfio_add_capabilities(vdev, errp);
+    ret = pci_device_set_iommu_device(pdev, vbasedev->hiod, errp);
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
@@ -3132,7 +3138,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             error_setg(errp,
                        "cannot support IGD OpRegion feature on hotplugged "
                        "device");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_get_dev_region_info(vbasedev,
@@ -3141,13 +3147,13 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
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
 
@@ -3233,6 +3239,8 @@ out_deregister:
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
+out_unset_idev:
+    pci_device_unset_iommu_device(pdev);
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3261,6 +3269,7 @@ static void vfio_instance_finalize(Object *obj)
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3275,7 +3284,8 @@ static void vfio_exitfn(PCIDevice *pdev)
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


