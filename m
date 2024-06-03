Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7C9C27C4F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0xi-0006Po-T6; Mon, 03 Jun 2024 02:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xd-00069g-AT
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:26 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xY-0000xl-Ou
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395261; x=1748931261;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nyd3SwoK+cs9yuOOZ+aoWR7QGb+/QWyokm8AotAsE9k=;
 b=UejF9VCkRnKnEKO7ZrSCls+WcV7d/b/pDTFSHG2qlpHJp02Z+UD0v4A1
 eEJA6vlX9wetSvs1iIPBnbh/D+6xymPixRWoG05cV1uh1GgKdddIVDT81
 nnrMJYdrm/Nlg0nYZBZigr4Fog7XGo7co4JUCcVagYMo+Tsnv23+JpDsN
 eGCDxe5/aG4s0zfnRJUvdmNmzcEFqyeB97X8EWPeMHn+V0+lOmdIXWMA+
 E/gYL7JZqxgvOmZRj/giqZg0ShI2UU7Eeej3Bfjj8WiBnbV5oMlPmbzgL
 QoxN3mKPhRYEfwQuuoiLljXDZFst7zZMhMSTt6TwHam3V9lyx5E6HNZLf g==;
X-CSE-ConnectionGUID: W1VWog/LQFCIfDPdJ398BQ==
X-CSE-MsgGUID: v2Mz+jA+TciNUoEOxC6mQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277766"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:20 -0700
X-CSE-ConnectionGUID: dnT36AlqSeO4435cS38E/w==
X-CSE-MsgGUID: 7UCD2hSjR0emdJUVHLYebw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855976"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v6 16/19] vfio/pci: Pass HostIOMMUDevice to vIOMMU
Date: Mon,  3 Jun 2024 14:10:20 +0800
Message-Id: <20240603061023.269738-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
index 74a79bdf61..d8a76c1ee0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3121,10 +3121,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     vfio_bars_register(vdev);
 
-    if (!vfio_add_capabilities(vdev, errp)) {
+    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
+        error_prepend(errp, "Failed to set iommu_device: ");
         goto out_teardown;
     }
 
+    if (!vfio_add_capabilities(vdev, errp)) {
+        goto out_unset_idev;
+    }
+
     if (vdev->vga) {
         vfio_vga_quirk_setup(vdev);
     }
@@ -3141,7 +3146,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
             error_setg(errp,
                        "cannot support IGD OpRegion feature on hotplugged "
                        "device");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         ret = vfio_get_dev_region_info(vbasedev,
@@ -3150,11 +3155,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         if (ret) {
             error_setg_errno(errp, -ret,
                              "does not support requested IGD OpRegion feature");
-            goto out_teardown;
+            goto out_unset_idev;
         }
 
         if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
-            goto out_teardown;
+            goto out_unset_idev;
         }
     }
 
@@ -3238,6 +3243,8 @@ out_deregister:
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
+out_unset_idev:
+    pci_device_unset_iommu_device(pdev);
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
@@ -3266,6 +3273,7 @@ static void vfio_instance_finalize(Object *obj)
 static void vfio_exitfn(PCIDevice *pdev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
@@ -3280,7 +3288,8 @@ static void vfio_exitfn(PCIDevice *pdev)
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


