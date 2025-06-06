Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F617C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 10:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU00-0008FN-Ua; Fri, 06 Jun 2025 06:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTzy-0008Ew-Oo
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:30 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNTzw-0007bB-T2
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:08:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204509; x=1780740509;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=00ulHnX+eKrjlinzOFfSjfiSc0O3w1RoRaW+r7uKRUY=;
 b=Jy6jrSH62ctn6ciymyjoDyOD7LTAi+xTZ4HIQ724HI8RYV41bt+IqDpz
 OeHpLw/7zW8DYIm7GZcpmQR57bJV8REzRJmuqbOdl5vJ746G+TNRzt9yP
 /rej6Y1fHM9IzP0tD9lQPSiqiCWZ7s2f91jBBGPucz40e+0JFNvFx3rAE
 psQAVPNHNvtNb7BLkSsyAJocpfCyTglxVO4QA48C+dVK7+Bz+DtNfbzlo
 p7qyZpUccc6rCwzVY15kdRyKpo296VFieJdLPB7U56+q/sRbCT4rZhGY6
 P2HVQKJ7odS99mBaO95lqRR0zSYStLZBuMzXHzUlSSMxAlcnC7M04KaY5 g==;
X-CSE-ConnectionGUID: Nx6zYI8TQO6XDyQ3yi6Jrw==
X-CSE-MsgGUID: 8VmAJ3ZOQie8Kj30yfGngw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747196"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747196"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:26 -0700
X-CSE-ConnectionGUID: DRatuZK/QU6G5F3jqy93rA==
X-CSE-MsgGUID: mPp+9POqQRa//LHS3Y691A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759063"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:08:22 -0700
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
Subject: [PATCH v1 03/15] intel_iommu: Check for compatibility with IOMMUFD
 backed device when x-flts=on
Date: Fri,  6 Jun 2025 18:04:04 +0800
Message-Id: <20250606100416.346132-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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
does not, then this IOMMUFD backed device should be failed.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

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
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a2f3250724..c42ef83ddc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -39,6 +39,7 @@
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
 #include "trace.h"
+#include "system/iommufd.h"
 
 /* context entry operations */
 #define VTD_CE_GET_RID2PASID(ce) \
@@ -4361,6 +4362,33 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
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


