Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F2DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 06:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK9xl-0007s6-5C; Wed, 28 May 2025 02:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xj-0007l2-Ac
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:27 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uK9xh-0000mi-Dl
 for qemu-devel@nongnu.org; Wed, 28 May 2025 02:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748412506; x=1779948506;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EMu1zSa7gFaBrB77RJllTGDdUmWEDp2pS9KkWV27FTQ=;
 b=P50qQF0NkquH+xVeKmmRkFAxs9VOqjogyMDucaKXCjqUfhJynBIx75jD
 kVvRzIMomRa/5sMIrvTUN+9mGz+GKpmFbr7WqJrlhBPYjWQfiZ+Q8ueLi
 RE0ASzPqAg6hUORPpm3CqCSAFmFYYlgjagL9RPEtIzaN22f7I2/UFjBQo
 PeOwCdoJx/IdVvDJY4y8y3RS4J3Td0RxB58sadCF7cfcbi4GtSRKPmlBX
 AfIvR3JsqYdegnGVXhiMFk/UHskj33KNdQDVtIiQyBwfu5vgv4NLeBZVq
 99N5LWrqESLgrqAuBPhziv44akF8YwdDCGJwKL+I27cB5B3iyR3sxsju8 A==;
X-CSE-ConnectionGUID: YvzxScoJShmKYy1tHL+qqA==
X-CSE-MsgGUID: F84mIBQMQvehtWUzWp/EMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="60679009"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="60679009"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:08:25 -0700
X-CSE-ConnectionGUID: fCbggq8uQnW0KaMk4ZocEw==
X-CSE-MsgGUID: 1hiGeCTCTEuVGmmiMhmCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="143165183"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 23:08:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 6/6] iommufd: Implement query of host VTD IOMMU's capability
Date: Wed, 28 May 2025 14:04:09 +0800
Message-Id: <20250528060409.3710008-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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
index 10fccc10be..c2770cb469 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -29,6 +29,10 @@ typedef union VendorCaps {
  *
  * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this represents
  *           the @out_capabilities value returned from IOMMU_GET_HW_INFO ioctl)
+ *
+ * @vendor_caps: host platform IOMMU vendor specific capabilities (e.g. on
+ *               IOMMUFD this represents raw vendor data from data_uptr
+ *               buffer returned from IOMMU_GET_HW_INFO ioctl)
  */
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
@@ -116,6 +120,9 @@ struct HostIOMMUDeviceClass {
  */
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE        0
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
+#define HOST_IOMMU_DEVICE_CAP_NESTING           2
+#define HOST_IOMMU_DEVICE_CAP_FS1GP             3
+#define HOST_IOMMU_DEVICE_CAP_ERRATA            4
 
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index b114fb08e7..63209659f3 100644
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
+    struct iommu_hw_info_vtd *caps = &hiod->caps.vendor_caps.vtd;
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


