Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D866C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7AJj-0007aS-83; Wed, 15 May 2024 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7AJg-0007Lq-8A
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:48:52 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s7AJd-0003uo-AA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 04:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715762929; x=1747298929;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KDxv+dBO3SG077TMC+Biinv0oixhCPXOyWdnTVtAwRs=;
 b=HxZne39YlW5DzyL/OaOHqE4UzfmWRkfMiVznI3Yab/a4jfsVWiUB0JUW
 kUqgtOVaKsN4pkeP70RPMP5wI0LP5f0pZaXnev5L/6KVwRAHs6/wVs78V
 AjFgJCYVEY7dZsmGPsAPPU+Ci3YXuS/VMDCOWj9RrnodDiQOSEsEa6ppE
 JtWSiLFHTIWwTn1uEqecWWYi6KMEoTeBkkzruVoFKxQkgMe+r/lGfGJvQ
 Jcl3tNX1PQYyM2Gu+vpzX//txwoIncsINV9d4fk6sy3UJ1zyJrqHrbZWz
 V4/ajwPlgVNA6aNnPKI877MUfIWYx09kIwuf4JqFzy1Xcr5ZJ2TD0Fq4a A==;
X-CSE-ConnectionGUID: n41abcoDQoaZVdtzGulr/A==
X-CSE-MsgGUID: vxcF9B78TVi6O248jx0gPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11535096"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="11535096"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:48:47 -0700
X-CSE-ConnectionGUID: xQ2x0Bs9QHy1lz1CUxKVPQ==
X-CSE-MsgGUID: V2WVeeGtSOuLe7J9APbI2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; d="scan'208";a="31012952"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 01:48:44 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH] intel_iommu: Make pasid entry type check accurate
Date: Wed, 15 May 2024 16:46:20 +0800
Message-Id: <20240515084620.636016-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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
index cc8e59674e..990cfa87f2 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -734,20 +734,16 @@ static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
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


