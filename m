Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCBCAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUs-000443-DT; Thu, 18 Sep 2025 05:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUp-0003vk-6X
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:07 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUj-0004rh-8v
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758186001; x=1789722001;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P9+nzVOhX790y/qc4xR49BXWixXcP2jO+tGhon21nMI=;
 b=VE3kvfaLKit+5mGlK0n5wFu9TCgX4mmUHX4u4tu1yVeprAnVfNxAIg7H
 Gof8oGQQFTx3GwbTpy8ZJP++Xxsbi/Y8xWEeBK+NhjnD1J2Bkd93wdTEj
 lYRgbPT9QfUQ7CqOpiLHEzXe7sOzF5p7wItswHfqEmmeWveyHc3l80XWW
 j0spJLmVyzn8urj7Hk6yp3NfkpG8ek2wglLqXXRW0X0rSRQ5fH8/cgMse
 H6fLf8cLCUvEGNP8nlfdFiS6+LcZnCLgIBb2viP2l0I5XYLldvLk9BqFD
 Zh0J45a2Rsc/nOiGx5RRLALiAsZFz2K4K9RiBzL0ntN47GGZISC84C10d Q==;
X-CSE-ConnectionGUID: tmojZfV+R0uQVw6rYyUFfg==
X-CSE-MsgGUID: Oj8Wm+tPRWuslLDJF2x99g==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109572"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109572"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:45 -0700
X-CSE-ConnectionGUID: r0CFHSsaQ1yefIJz3pYRzQ==
X-CSE-MsgGUID: +Zz+DO4lR1yiDhEbbUezyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930566"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Date: Thu, 18 Sep 2025 04:57:57 -0400
Message-ID: <20250918085803.796942-19-zhenzhong.duan@intel.com>
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
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In VFIO core, we call iommufd_backend_get_device_info() to return vendor
specific hardware information data, but it's not good to extract this raw
data in VFIO core.

Introduce host_iommu_extract_vendor_caps() to help extracting the raw
data and return a bitmap in iommufd.c because it's the place defining
iommufd_backend_get_device_info().

The other choice is to put vendor data extracting code in vendor vIOMMU
emulation file, but that will make those files mixed with vIOMMU
emulation and host IOMMU extracting code, also need a new callback in
PCIIOMMUOps. So we choose a simpler way as above.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/iommu.h                 |  5 +++++
 include/system/host_iommu_device.h | 16 ++++++++++++++++
 backends/iommufd.c                 | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/hw/iommu.h b/include/hw/iommu.h
index 65d652950a..9b343e64b0 100644
--- a/include/hw/iommu.h
+++ b/include/hw/iommu.h
@@ -16,4 +16,9 @@ enum {
      VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
 };
 
+enum {
+    /* Nesting parent HWPT shouldn't have readonly mapping, due to errata */
+     IOMMU_HW_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
+};
+
 #endif /* HW_IOMMU_H */
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..41c9159605 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -39,6 +39,22 @@ typedef struct HostIOMMUDeviceCaps {
     uint64_t hw_caps;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+
+/**
+ * host_iommu_extract_vendor_caps: Extract vendor capabilities
+ *
+ * This function converts @type specific hardware information data
+ * into a standard bitmap format.
+ *
+ * @type: IOMMU Hardware Info Types
+ *
+ * @VendorCaps: IOMMU @type specific hardware information data
+ *
+ * Returns: 64bit bitmap with each bit represents a capability of host
+ * IOMMU that we want to expose. See IOMMU_HW_* in include/hw/iommu.h
+ * for all possible capabilities currently exposed.
+ */
+uint64_t host_iommu_extract_vendor_caps(uint32_t type, VendorCaps *caps);
 #endif
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2a33c7ab0b..0bb1ed40d3 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -19,6 +19,7 @@
 #include "migration/cpr.h"
 #include "monitor/monitor.h"
 #include "trace.h"
+#include "hw/iommu.h"
 #include "hw/vfio/vfio-device.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
@@ -410,6 +411,18 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return true;
 }
 
+uint64_t host_iommu_extract_vendor_caps(uint32_t type, VendorCaps *caps)
+{
+    uint64_t vendor_caps = 0;
+
+    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
+        caps->vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        vendor_caps |= IOMMU_HW_NESTING_PARENT_BYPASS_RO;
+    }
+
+    return vendor_caps;
+}
+
 bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       uint32_t data_type, uint32_t entry_len,
                                       uint32_t *entry_num, void *data,
-- 
2.47.1


