Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6FDD59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2Qx-00083L-0F; Mon, 15 Dec 2025 01:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2Qv-000835-DI
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:51:49 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2Qt-0000u9-EC
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781508; x=1797317508;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/UKc8gFWpDNMwE+c/sx7DfhfQm/FgyBSEYrB8dOna6g=;
 b=j97E0a3+w4ait8jEiybLo/RJCedkKk3MzvshVZ8toHTT3tqseChv4k/B
 mcoDr6atelaVflkjBOBDOZVClpiPCr+s1k5mt/3N+FyK8sY+/RxyT940c
 KxYw2DuRra4x+bvYfpT9etAFDhcmBVnulkE9/m04/x+msuw5FT2xYRzGc
 lA9DaTqo8Hz9DgboOuKdjFDzlOyKRuLCc7yR5aYaM+bGU3tWl/BZ7NzT5
 QhOCcvmcMV0AIE+tg5pInGsHoZcLDiqn/lPj5UnpXD6yx0wOOPKa7AITK
 3/9Qgm4I5+cbEkEQ69bQldz4n41mlz9FpdER7FM5IRUroDWhIEXHTjVKk Q==;
X-CSE-ConnectionGUID: eiwDFOwyRmeIY2h5TdCkVw==
X-CSE-MsgGUID: 2v88DGt7R4OcdtORLGfw9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71304996"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71304996"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:51:47 -0800
X-CSE-ConnectionGUID: lCgeFzLrRj6keqwA/h/nfg==
X-CSE-MsgGUID: JX3GQc4ZSlW2bFGAbwXcvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408786"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:51:43 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 08/19] vfio/iommufd: Force creating nesting parent HWPT
Date: Mon, 15 Dec 2025 01:50:32 -0500
Message-ID: <20251215065046.86991-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Call pci_device_get_viommu_flags() to get if vIOMMU supports
VIOMMU_FLAG_WANT_NESTING_PARENT.

If yes, create a nesting parent HWPT and add it to the container's hwpt_list,
letting this parent HWPT cover the entire second stage mappings (GPA=>HPA).

This allows a VFIO passthrough device to directly attach to this default HWPT
and then to use the system address space and its listener.

Introduce a vfio_device_get_viommu_flags_want_nesting() helper to facilitate
this implementation.

It is safe to do so because a vIOMMU will be able to fail in set_iommu_device()
call, if something else related to the VFIO device or vIOMMU isn't compatible.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 12 ++++++++++++
 hw/vfio/iommufd.c             |  9 +++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 0fe6c60ba2..0bc877ff62 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 76869828fc..eff5aab207 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,6 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
+#include "hw/iommu.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -515,6 +516,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
+                  VIOMMU_FLAG_WANT_NESTING_PARENT);
+    }
+    return false;
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index bb5775aa71..ca8a6b7029 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -361,6 +361,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
+    /*
+     * If vIOMMU requests VFIO's cooperation to create nesting parent HWPT,
+     * force to create it so that it could be reused by vIOMMU to create
+     * nested HWPT.
+     */
+    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
+        flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+    }
+
     if (cpr_is_incoming()) {
         hwpt_id = vbasedev->cpr.hwpt_id;
         goto skip_alloc;
-- 
2.47.1


