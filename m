Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B6CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDR0-0006GW-Pz; Fri, 24 Oct 2025 04:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQp-00068n-Hx
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:56 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDQn-0006Vx-Go
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295554; x=1792831554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G9NYNT/BTF1+pHfUhU7z1uUhIj/5SiXz+/P9BecLONY=;
 b=VbH51TJHJ1QNnBLeWDwe9nSS74Ki8o0+2f2BXAuCvbhJZmq4a2o6p+LN
 oWu9qXbowDORjflvvPXqmw5I2ufs61imHqgRQYDg0QfvRiBJxeefsFk1j
 ZF3e4W0E0DRRVUh4Ew2lci0BA02JlKh8nQadn7e5Ytg5hq1AJqOxurHlY
 jICID2XTa1WoUwXy1wXnEqBwiWDMc79MP3x71236SJsicymcWlhWTmbEE
 iHHnHZTSVVmVrdu9iUbnvuOOBcFbs+LbOT9LT51ax8vROm9jAKrsRAZkg
 72GzmQAwcts50JEyH6dY2rsygdJzuDGSaf84mpBHGa9wjxQAL2IB2lmm4 Q==;
X-CSE-ConnectionGUID: 54rd9rX2TzGMo1skoE31Qw==
X-CSE-MsgGUID: 3tcaSLqpSm2MNOzaaYngcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504897"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504897"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:43 -0700
X-CSE-ConnectionGUID: vJ5EwJMrQF6cdvJSE4pwXg==
X-CSE-MsgGUID: 1WoXB/qmRBeQ8INXgAhZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183986024"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:39 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
Date: Fri, 24 Oct 2025 04:43:41 -0400
Message-ID: <20251024084349.102322-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce host_iommu_extract_quirks() to help extracting the raw data and
return a bitmap in iommufd.c because it's the place defining
iommufd_backend_get_device_info().

The other choice is to put vendor data extracting code in vendor vIOMMU
emulation file, but that will make those files mixed with vIOMMU
emulation and host IOMMU extracting code, also need a new callback in
PCIIOMMUOps. So we choose a simpler way as above.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/hw/iommu.h                 |  5 +++++
 include/system/host_iommu_device.h | 15 +++++++++++++++
 backends/iommufd.c                 | 13 +++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/include/hw/iommu.h b/include/hw/iommu.h
index 9b8bb94fc2..6d61410703 100644
--- a/include/hw/iommu.h
+++ b/include/hw/iommu.h
@@ -22,4 +22,9 @@ enum viommu_flags {
     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
 };
 
+/* Host IOMMU quirks. Extracted from host IOMMU capabilities */
+enum host_iommu_quirks {
+    HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO = BIT_ULL(0),
+};
+
 #endif /* HW_IOMMU_H */
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index ab849a4a82..9ae7f4cc6d 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -39,6 +39,21 @@ typedef struct HostIOMMUDeviceCaps {
     uint64_t hw_caps;
     VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+
+/**
+ * host_iommu_extract_quirk: Extract host IOMMU quirks
+ *
+ * This function converts @type specific hardware information data
+ * into a standard bitmap format.
+ *
+ * @type: IOMMU Hardware Info Types
+ *
+ * @VendorCaps: IOMMU @type specific hardware information data
+ *
+ * Returns: bitmap with each representing a host IOMMU quirk defined in
+ * enum host_iommu_quirks
+ */
+uint64_t host_iommu_extract_quirks(uint32_t type, VendorCaps *caps);
 #endif
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 086bd67aea..61b991ec53 100644
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
@@ -411,6 +412,18 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return true;
 }
 
+uint64_t host_iommu_extract_quirks(uint32_t type, VendorCaps *caps)
+{
+    uint64_t quirks = 0;
+
+    if (type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
+        caps->vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        quirks |= HOST_IOMMU_QUIRK_NESTING_PARENT_BYPASS_RO;
+    }
+
+    return quirks;
+}
+
 bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       uint32_t data_type, uint32_t entry_len,
                                       uint32_t *entry_num, void *data,
-- 
2.47.1


