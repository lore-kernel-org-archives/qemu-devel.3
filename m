Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732F6D2E9C0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 08:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPwN-0004sk-S4; Mon, 11 Nov 2024 03:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPw9-0004qs-F0
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:17 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPw5-0003Ti-Ql
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314294; x=1762850294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LXWOq6Bk1Bmv3i8j1h5VzIBXKoVXbthWV9TjblXPuB4=;
 b=hHE/2RmWOUQWWNu2aYUbRDoBOKIXwlpHfY+flbLcW4+poGhCekSI1aob
 VXmsFZVgsw3J1wDoSxolAW+WIMlUxrIs+R/WinYH3gp/hcMMQmgJuYjJq
 APE3vXvwCq5WS9A2UCwYSgN7D46eMLnPyvIEZaefaa8/MeR6mdEG+KO2/
 S/f9E/aqhVLdPt67pO5HQgJScQRfcqkHK4q7ULfPraBZUENFujtbF4TCA
 Dd7OizX6ykoRtgf/jmvrfpuG8ZAa2bNjat5qoMdmlZVGMxi2xozCG0TYN
 +sBV3wk7rJnNeHUEHE97FSoDmqgmwV+oFlkGPL9593orbeWByRMbDRHjY g==;
X-CSE-ConnectionGUID: niulbAZISz2tkfX4iVXvcA==
X-CSE-MsgGUID: jRw0BXacT0WZdLaJimnXFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334337"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334337"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:12 -0800
X-CSE-ConnectionGUID: gyRak2sPSXStsQ1k/qoBPA==
X-CSE-MsgGUID: lKC/3EgTT9GOrY43B1bwww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608230"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:09 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v5 02/20] intel_iommu: Make pasid entry type check accurate
Date: Mon, 11 Nov 2024 16:34:39 +0800
Message-Id: <20241111083457.2090664-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
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

When guest configures Nested Translation(011b) or First-stage Translation only
(001b), type check passed unaccurately.

Fails the type check in those cases as their simulation isn't supported yet.

Fixes: fb43cf739e1 ("intel_iommu: scalable mode emulation")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 67dc99cfdf..10b8425a6c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -759,20 +759,16 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
                                      VTDPASIDEntry *pe)
 {
     switch (VTD_PE_GET_TYPE(pe)) {
-    case VTD_SM_PASID_ENTRY_FLT:
     case VTD_SM_PASID_ENTRY_SLT:
-    case VTD_SM_PASID_ENTRY_NESTED:
-        break;
+        return true;
     case VTD_SM_PASID_ENTRY_PT:
-        if (!x86_iommu->pt_supported) {
-            return false;
-        }
-        break;
+        return x86_iommu->pt_supported;
+    case VTD_SM_PASID_ENTRY_FLT:
+    case VTD_SM_PASID_ENTRY_NESTED:
     default:
         /* Unknown type */
         return false;
     }
-    return true;
 }
 
 static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
-- 
2.34.1


