Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B50C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW5K-0004d2-Lt; Fri, 20 Jun 2025 03:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5F-0004cH-OO
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:47 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5D-0008IS-FN
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404164; x=1781940164;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2Ev68Lz7/J4aSiVBZBDspVfJE1fKcFe0BqnfXTcJRM8=;
 b=X4mGH3cnLcGvJTtDTUV/V+7Q9SaJfIKw2BgpjEnfweCDLCHbNmHGnqY5
 YIDbtzJ0PZbcTGwfQe/H7XGX4XKrqNCSwJGbv9X3mbGtiIvU2gZYQ7dcN
 BLTlosvfGf9QzsT+pGb/+tJVlcPrLagUnWWDi3oPviMg2QSVHDYLsYAzW
 BkUSav9WFqxEEGWPbCsE/8Jorru5UDxddZa4F0qtEMWt+TiVIoBYJLg3F
 OylBAfgyNPyvS9+1xyErvxBocZGdyuf4oapai3kPm6dM3p7iCijqx0wZt
 IQo+AcEJt3o8fh26jOilHVWHGcnB6WtaucXSpBdbXU7ims8TcTtYm6yH5 w==;
X-CSE-ConnectionGUID: 1ItElWT/TzW9EBdzzJNHqg==
X-CSE-MsgGUID: KwALiTsAQSWndkS+1DC22A==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532346"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532346"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:43 -0700
X-CSE-ConnectionGUID: BcyZWfRgTiKVumOsx3WIiA==
X-CSE-MsgGUID: zP0ezj+ESACqY8uZ6JICRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863122"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:22:38 -0700
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
Subject: [PATCH v2 07/19] intel_iommu: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Fri, 20 Jun 2025 15:18:01 +0800
Message-Id: <20250620071813.55571-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
is passed to host to construct nested page table. We need to check
compatibility of some critical IOMMU capabilities between vIOMMU and
host IOMMU to ensure guest stage-1 page table could be used by host.

For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
does not, then this IOMMUFD backed device should be failed.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 7aba259ef8..18bc22fc72 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_NEST               (1ULL << 26)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e90fd2f28f..1c79efc1cb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -40,6 +40,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -4355,6 +4356,33 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
+#ifdef CONFIG_IOMMUFD
+    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
+    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
+
+    /* Remaining checks are all stage-1 translation specific */
+    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
+        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
+        return false;
+    }
+
+    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "Incompatible host platform IOMMU type %d",
+                   caps->type);
+        return false;
+    }
+
+    if (!(vtd->ecap_reg & VTD_ECAP_NEST)) {
+        error_setg(errp, "Host IOMMU doesn't support nested translation");
+        return false;
+    }
+
+    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
+        error_setg(errp, "Stage-1 1GB huge page is unsupported by host IOMMU");
+        return false;
+    }
+#endif
+
     error_setg(errp, "host device is uncompatible with stage-1 translation");
     return false;
 }
-- 
2.34.1


