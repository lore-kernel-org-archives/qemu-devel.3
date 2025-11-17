Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD80CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvhY-0004Qy-EC; Mon, 17 Nov 2025 04:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhU-0004M3-3w
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:08 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKvhR-0006HR-HC
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372346; x=1794908346;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6BIkeyM/A63UPH07aQbdSm7FWI0Zl7Ec+RzhycyR2Co=;
 b=L+JB6lA0MLJ6ftt8LjxHtd3WvV4MVrAGS3WgDiI4m1fv9xqi5poIsawZ
 GbVqu5rIZ21MlYL4PHPqVjAzKgX+d+5NPu35Eh7yl92wVxKif9YB6S/lX
 DA9YWI2EwyZprBzc3noHLPJptdoCqJ8HUKiHRYcuH1m9Hwxzs1H6Vwfib
 ECg4RYWoz5us8GqNjM6FI44J8B35g9rgDRhkSYWsToeFGCzZZ4YgeWViF
 Bmdm73TdqaFaV0flM7eSRbOCBWokgjhUXVjVl6NPh45XEj/Jiobm2sXr2
 mOY1Qatp7bxnWhIU+k2eg5GoFyZRXoLqYL9xn9KroD6kqKxp/YEH8jFuN g==;
X-CSE-ConnectionGUID: hu9C9VPcQcK8vMvNOtKB2Q==
X-CSE-MsgGUID: OE/zVujkTSSQG+xGmVcjMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76045960"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76045960"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:05 -0800
X-CSE-ConnectionGUID: sWhGyP+iQWCE3Qm8DGmPpQ==
X-CSE-MsgGUID: 6AtfRjYcSUaXCSBs5YRZ2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070911"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:01 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 08/23] vfio/iommufd: Force creating nesting parent HWPT
Date: Mon, 17 Nov 2025 04:37:11 -0500
Message-ID: <20251117093729.1121324-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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
index a0b8fc2eb6..48d00c7bc4 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -267,6 +267,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainer *bcontainer,
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 920cdd12ee..71eb069eb6 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,6 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
+#include "hw/iommu.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -521,6 +522,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
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
index ba5c6b6586..63f8442865 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -404,6 +404,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
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


