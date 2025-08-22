Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64455CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLTM-0007zV-1h; Fri, 22 Aug 2025 02:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTK-0007ya-9m
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:58 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTI-0000lZ-1N
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844916; x=1787380916;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JE7nwL5OsxUQdPfDzwLdaqc7O9sf7StnsOE5x6dWgxI=;
 b=W+WsAgnnaucidqE5OE7Y7pH1NJMAwB6imKfxtc1oxysFIAuG8owIVBcq
 GBPMk/XIc3wcDU8vRoDELovvnYVZMx2TRtfFmpzDOg29Sm99FL9m6L3H0
 bwU+Rzw+bZh22ZJedpr3tQ+B8gzkza/cit1F2GDYiM+qZtPX/ytgDPhEr
 TsDfCn9B9Ao6A+HKGwAFWCcymjH6XtHi5bsjp8IQGdQTkvQZLE/+KodK9
 590oldwOQ8tatIhK8Vzo3nREgtbZfwuWbVWEqVBMnCTmnlGd9D43qvmhA
 e3OyNSvdu0NjZIXLclmX5YtGuY611bKiGGpspwKaaCU+h39yqKcPJUS2t Q==;
X-CSE-ConnectionGUID: B8URwJuxQ4aiHYuiiRzLNw==
X-CSE-MsgGUID: gHZj26QrQ6qo1uciz/+voQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851887"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851887"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:55 -0700
X-CSE-ConnectionGUID: X2cOLmZqSkSiRBGrMXVgjw==
X-CSE-MsgGUID: YzGo5ychRv6mgY+VFByNaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168244946"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:41:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 08/21] intel_iommu: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Fri, 22 Aug 2025 02:40:46 -0400
Message-ID: <20250822064101.123526-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
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

When vIOMMU is configured x-flts=on in scalable mode, stage-1 page table
is passed to host to construct nested page table. We need to check
compatibility of some critical IOMMU capabilities between vIOMMU and
host IOMMU to ensure guest stage-1 page table could be used by host.

For instance, vIOMMU supports stage-1 1GB huge page mapping, but host
does not, then this IOMMUFD backed device should fail.

Even of the checks pass, for now we willingly reject the association
because all the bits are not there yet.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index c7046eb4e2..f7510861d1 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -192,6 +192,7 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_NEST               (1ULL << 26)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
 #define VTD_ECAP_PASID              (1ULL << 40)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 512ca4fdc5..da355bda79 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -40,6 +40,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -4366,7 +4367,34 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
         return true;
     }
 
-    error_setg(errp, "host device is uncompatible with stage-1 translation");
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
+    error_setg(errp, "host IOMMU is incompatible with stage-1 translation");
     return false;
 }
 
-- 
2.47.1


