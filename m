Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32182C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 06:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9fR5-00051N-2B; Wed, 22 May 2024 02:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQs-0004wn-PF
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:41 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s9fQp-0006eK-Su
 for qemu-devel@nongnu.org; Wed, 22 May 2024 02:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716359196; x=1747895196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vE8rkSdU6dEMAH+0MFwIrTelTaY4cA16PyXwyT6nphQ=;
 b=GuGori3ePDBledBnzEYGFsvLFmmohJX+SvI+Q81JpYnliwt7Uo0cL1jA
 mmQnlSjxUeJFTLLsPaZYuUIAtLZbgVUtFzPL5rySvCArNF1Hb1EoKfXss
 LHCUvHOGm/DHUY4TaQbHur+hYPiauDaYwMmXF1wcQWVvV3hCcLXBOYgYQ
 GfTY1zi91RNsnL23SxSxzr826av+iykuHLKE9ij1MV5E62yyjLWTFTA8N
 kFcnSwtPWobYslsnWcTX1s5ba8CHyNs81W40MUAXU6Tib2KLDDbmnniNm
 nKc7Go4jA2/ltVGfDBZXI3m+rFMZygNOdDnLw4TOeOtLDtrYWL9SZq3Ji A==;
X-CSE-ConnectionGUID: AYYMSbfVRWWOsoP7pYNkbg==
X-CSE-MsgGUID: +M0iWahSQPqLaufdirNYZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="37972551"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="37972551"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:35 -0700
X-CSE-ConnectionGUID: i3CxBjhBTG++xFsUmObw7Q==
X-CSE-MsgGUID: SlMmBEhAQ3qSTSd+BK7lFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33597804"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 23:26:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv2 09/17] intel_iommu: Flush stage-1 cache in iotlb
 invalidation
Date: Wed, 22 May 2024 14:23:05 +0800
Message-Id: <20240522062313.453317-10-zhenzhong.duan@intel.com>
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

According to spec, Page-Selective-within-Domain Invalidation (11b):

1. IOTLB entries caching second-stage mappings (PGTT=010b) or pass-through
(PGTT=100b) mappings associated with the specified domain-id and the
input-address range are invalidated.
2. IOTLB entries caching first-stage (PGTT=001b) or nested (PGTT=011b)
mapping associated with specified domain-id are invalidated.

So per spec definition the Page-Selective-within-Domain Invalidation
needs to flush first stage and nested cached IOTLB enties as well.

We don't support nested yet and pass-through mapping is never cached,
so what in iotlb cache are only first-stage and second-stage mappings.

Add a tag pgtt in VTDIOTLBEntry to mark PGTT type of the mapping and
invalidate entries based on PGTT type.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 011f374883..b0d5b5a5be 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -156,6 +156,7 @@ struct VTDIOTLBEntry {
     uint64_t pte;
     uint64_t mask;
     uint8_t access_flags;
+    uint8_t pgtt;
 };
 
 /* VT-d Source-ID Qualifier types */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0801112e2e..0078bad9d4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -287,9 +287,21 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
     VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
     uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
     uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
-    return (entry->domain_id == info->domain_id) &&
-            (((entry->gfn & info->mask) == gfn) ||
-             (entry->gfn == gfn_tlb));
+
+    if (entry->domain_id != info->domain_id) {
+        return false;
+    }
+
+    /*
+     * According to spec, IOTLB entries caching first-stage (PGTT=001b) or
+     * nested (PGTT=011b) mapping associated with specified domain-id are
+     * invalidated. Nested isn't supported yet, so only need to check 001b.
+     */
+    if (entry->pgtt == VTD_SM_PASID_ENTRY_FLT) {
+        return true;
+    }
+
+    return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
 }
 
 /* Reset all the gen of VTDAddressSpace to zero and set the gen of
@@ -382,6 +394,8 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     entry->access_flags = access_flags;
     entry->mask = vtd_slpt_level_page_mask(level);
     entry->pasid = pasid;
+    entry->pgtt = s->scalable_modern ? VTD_SM_PASID_ENTRY_FLT
+                                     : VTD_SM_PASID_ENTRY_SLT;
 
     key->gfn = gfn;
     key->sid = source_id;
-- 
2.34.1


