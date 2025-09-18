Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52D9CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAU3-00019M-K0; Thu, 18 Sep 2025 04:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATu-0000x8-1o
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzATr-0004kl-AS
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185947; x=1789721947;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f4AXeDQrDSC8Bwx0WZxeYxfnR0oD0dSoUF+iu1iKyuA=;
 b=feeTmIT/t2Ou6k1XcAXNo7Z6GLj1q8u1elzUxxBP2pD+Kp8jM/JE47t2
 EuDUhqWA1ss3OpHoAVTO5d+WFpba6+gM521ByDx6OsP9HGHPWXpo47IXN
 Q3O4UAoifH+KfgEBtfP8DSFgGEDjxBil2SQ3tEGHvxMgxdHB/wYWj4dGt
 /NpI0crfK3ot2+xp9Qfvv9HYFqBhfTQeOdd03M4NTOWPE3cCS57fW2blS
 f50iKLL5TsSCojiljRJbgvOYSXmO2P9JFUedq9aYdrtGxo9xqRJJaoofW
 6OarzQvFeB4vHjFqs7k4bV/8WV6V+hIRPkx8UYLjgJ492Y+9aGXabbLF6 w==;
X-CSE-ConnectionGUID: vtgTpkisSpCc+Sv/uJYJoQ==
X-CSE-MsgGUID: TC0CZwyhTaiuk1rbKl+oug==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109477"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109477"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:04 -0700
X-CSE-ConnectionGUID: u9qQ0tTBQGCxzc/l4Q6zfQ==
X-CSE-MsgGUID: v4HWSAE6QMWoZDdKJodHkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930362"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 08/22] vfio/iommufd: Force creating nesting parent HWPT
Date: Thu, 18 Sep 2025 04:57:47 -0400
Message-ID: <20250918085803.796942-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
---
 include/hw/vfio/vfio-device.h |  2 ++
 hw/vfio/device.c              | 12 ++++++++++++
 hw/vfio/iommufd.c             |  9 +++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index e7e6243e2d..a964091135 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -257,6 +257,8 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
 
 void vfio_device_unprepare(VFIODevice *vbasedev);
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
+
 int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
                                 struct vfio_region_info **info);
 int vfio_device_get_region_info_type(VFIODevice *vbasedev, uint32_t type,
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 08f12ac31f..620cc78b77 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -23,6 +23,7 @@
 
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/pci.h"
+#include "hw/iommu.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -504,6 +505,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
     vbasedev->bcontainer = NULL;
 }
 
+bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
+{
+    VFIOPCIDevice *vdev = vfio_pci_from_vfio_device(vbasedev);
+
+    if (vdev) {
+        return !!(pci_device_get_viommu_flags(&vdev->parent_obj) &
+                  VIOMMU_FLAG_WANT_NESTING_PARENT);
+    }
+    return false;
+}
+
 /*
  * Traditional ioctl() based io
  */
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 8c27222f75..f1684a39b7 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -379,6 +379,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
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


