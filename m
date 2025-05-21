Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2650C54ED0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 11:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHhTg-0005VM-H0; Wed, 21 May 2025 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTa-0005V4-Li
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:10 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHhTY-0006Qk-JH
 for qemu-devel@nongnu.org; Wed, 21 May 2025 07:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747826349; x=1779362349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JG8jbSr6cYp7BQFkRpLapXdKgkWUaQh8kaDvQ/qFiz4=;
 b=Q2mKnwqyWGU20PK0k6iw6g8as9OUEnEJZk4+kcePaKKJXF4k+/AdUdg/
 V9Ngw0unoscRCYghC2eZPesD37u9u3fb/+0Oczu5+rM+piZaGfbcObzji
 /5Kb4XkNFF+uoJ+7UHnpOlbOOzyyA0eD8Qc63QAy9cpOGBuXeveIqxTCg
 qkUVESwl5eZm5jBY+hqWKtZFd1LEElDGioyCy2GZYAyFf0JbHbALvR0fj
 GqP1jmn9F0+H544as/s1bIMt+gUe0MGmJGzj9cC4Tn9M2qWCYAVa5eGiU
 Obov3FsMkrFMp1nc1c6PAjU3YFG5wRm9bDIzZXw60xR8FsP+TNfSbKpE+ A==;
X-CSE-ConnectionGUID: jUZGpUBhQ+ugrADBPmWOCA==
X-CSE-MsgGUID: s/1eCiZcQY+VdUv/ShVimQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49894924"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49894924"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:05 -0700
X-CSE-ConnectionGUID: Nza/lW44Qx6B1kLHIp89zQ==
X-CSE-MsgGUID: DQ4ddnt+RFOB8pJpoQgWVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145158327"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 04:19:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv3 06/21] iommufd: Implement query of host VTD IOMMU's
 capability
Date: Wed, 21 May 2025 19:14:36 +0800
Message-Id: <20250521111452.3316354-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP|ERRATA] for IOMMUFD
backed host VTD IOMMU device.

Query on these capabilities is not supported for legacy backend because there
is no plan to support nesting with legacy backend backed host device.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h     |  1 +
 include/system/host_iommu_device.h |  7 ++++++
 backends/iommufd.c                 | 39 ++++++++++++++++++++++++++++--
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index e8b211e8b0..2cda744786 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -191,6 +191,7 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_NEST               (1ULL << 26)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 908bfe32c7..30da88789d 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -33,6 +33,10 @@ typedef union VendorCaps {
  *
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ *
+ * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
+ *               IOMMUFD this represents extracted content from data_uptr
+ *               buffer returned from IOMMU_GET_HW_INFO ioctl)
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
@@ -117,6 +121,9 @@ struct HostIOMMUDeviceClass {
  */
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
+#define HOST_IOMMU_DEVICE_CAP_NESTING           2
+#define HOST_IOMMU_DEVICE_CAP_FS1GP             3
+#define HOST_IOMMU_DEVICE_CAP_ERRATA            4
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index b114fb08e7..d91c1eb8b8 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -21,6 +21,7 @@
 #include "hw/vfio/vfio-device.h"
 #include <sys/ioctl.h>
 #include <linux/iommufd.h>
+#include "hw/i386/intel_iommu_internal.h"
 
 static void iommufd_backend_init(Object *obj)
 {
@@ -364,6 +365,41 @@ bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
     return idevc->detach_hwpt(idev, errp);
 }
 
+static int hiod_iommufd_get_vtd_cap(HostIOMMUDevice *hiod, int cap,
+                                    Error **errp)
+{
+    Vtd_Caps *caps = &hiod->caps.vendor_caps.vtd;
+
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_NESTING:
+        return !!(caps->ecap_reg & VTD_ECAP_NEST);
+    case HOST_IOMMU_DEVICE_CAP_FS1GP:
+        return !!(caps->cap_reg & VTD_CAP_FS1GP);
+    case HOST_IOMMU_DEVICE_CAP_ERRATA:
+        return caps->flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
+    default:
+        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
+        return -EINVAL;
+    }
+}
+
+static int hiod_iommufd_get_vendor_cap(HostIOMMUDevice *hiod, int cap,
+                                       Error **errp)
+{
+    enum iommu_hw_info_type type = hiod->caps.type;
+
+    switch (type) {
+    case IOMMU_HW_INFO_TYPE_INTEL_VTD:
+        return hiod_iommufd_get_vtd_cap(hiod, cap, errp);
+    case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
+    case IOMMU_HW_INFO_TYPE_NONE:
+        break;
+    }
+
+    error_setg(errp, "%s: unsupported capability type %x", hiod->name, type);
+    return -EINVAL;
+}
+
 static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
 {
     HostIOMMUDeviceCaps *caps = &hiod->caps;
@@ -374,8 +410,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
     case HOST_IOMMU_DEVICE_CAP_AW_BITS:
         return vfio_device_get_aw_bits(hiod->agent);
     default:
-        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
-        return -EINVAL;
+        return hiod_iommufd_get_vendor_cap(hiod, cap, errp);
     }
 }
 
-- 
2.34.1


