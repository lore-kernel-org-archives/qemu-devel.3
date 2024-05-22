Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E34C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fQT-0004f4-Fq; Wed, 22 May 2024 02:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQI-0004V8-AA
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:02 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQF-0006eK-Oy
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359160; x=1747895160;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2sqa5xD65ChPp2kFgW+ttHAbtCvBnY8XoaP9JWX78tA=;
 b=nxLWephLT45/P/VRr5bD1wyT9v+/AFW2qktBJlsV4c1Olg4g/AKjjcgm
 2dvrOxs/XjZesNgOBLSb+fTAbR38oDv3O9SzV7AZiRaQ3jX2ZL96+CmCy
 0Qnkj3NHKGnI8lh0ego6GxgY1zHAXEDzcm5xVgoPleUWjbh//+3/hbEhE
 4cnvNkRScGgd5SBUhtW7Fq65XJTi+y2nI2f1/XGTux7bnG4bSiT1TWhYL
 WVVRpN7zV6n4ipT78hZkrkf3rtVudHiqUB/o83jTs7nCnGWh2MjjM0nm+
 nfHvTWs4klvudaMF/BlQwkHPmIy7nU1vL9zrjlmYZY5F+899z9DXGB0fb Q==;
X-CSE-ConnectionGUID: 6ddlfq9vQxugMnXQgIjCCQ==
X-CSE-MsgGUID: 5WQtO+qdSQ2OxNvwMnFHHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972450"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972450"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:25:59 -0700
X-CSE-ConnectionGUID: Zvoe2BO9RvWN3FmvHCS5fg==
X-CSE-MsgGUID: 6CwyhW0+TA2SXHhrqkpMoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597597"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:25:54 -0700
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
Subject: [PATCH rfcv2 02/17] intel_iommu: Make pasid entry type check accurate
Date: Wed, 22 May 2024 14:22:58 +0800
Message-Id: <20240522062313.453317-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522062313.453317-1-zhenzhong.duan@intel.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
---
 hw/i386/intel_iommu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d85aaf4bb8..348e3a441e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -742,20 +742,16 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
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


