Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4047106F30E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5glU-0002qR-M2; Thu, 26 Mar 2026 05:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glS-0002pc-DZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:30 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glQ-0003yp-RA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516349; x=1806052349;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tnftdlkpoH30eEumfqQOcuwlVOaGBFj8IO2veHSBS/8=;
 b=do1b7vf0TbseMErHerqtioEyHZdngjl31vplcLhStzrZTxYHDEHDGZmO
 VWZYj5KWnzOJHDonpMwa/eH86XQprhli1PMBgxu1NSKwQjmPXZS6cYya+
 c5DlXA3Y6pw/g9z0nxiCP+a8xEGfb+gs/1rFfqnrq2v/9AdxhVDJhUAP4
 dqnFpA5PoFLpZvCyls3ZlnEUMvNpU7WvUWE3BWxnepQ+HOAMCPNT1jJHt
 5HaSXWfuZVyFUARGmPImJYdHTfjGL1MtkPKhGs+Kd+2QCTv88yt5SA/lL
 rGt3HSBKMk1YtFo4AatemCz+klOXLTNr3jYHUf2wvf7hjR/doEnMtzFJF A==;
X-CSE-ConnectionGUID: HJg0RV0FScGhJaXKvjAnNg==
X-CSE-MsgGUID: 8pMiXrOtQAKtbFzlPp3aLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531395"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:28 -0700
X-CSE-ConnectionGUID: LIMLcM28SRyijIPux5dZmQ==
X-CSE-MsgGUID: 0tyhCUuWQm2ws5ekpLf69A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368609"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 12/14] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Date: Thu, 26 Mar 2026 05:11:26 -0400
Message-ID: <20260326091130.321483-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to support PASID, we have switched from looping vtd_as to vtd_hiod,
vtd_hiod represents host passthrough device and never deferenced without BQL.
So we don't need extra iommu lock to protect it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h | 14 +++++++-------
 hw/i386/intel_iommu.c       |  7 ++++---
 hw/i386/intel_iommu_accel.c |  6 +++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index c72856a8ff..45a12e0292 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -24,9 +24,9 @@ typedef struct VTDAccelPASIDCacheEntry {
 bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
                           Error **errp);
 VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
-void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
-                                      uint32_t pasid, hwaddr addr,
-                                      uint64_t npages, bool ih);
+void vtd_flush_host_piotlb_all_accel(IntelIOMMUState *s, uint16_t domain_id,
+                                     uint32_t pasid, hwaddr addr,
+                                     uint64_t npages, bool ih);
 void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
 void vtd_pasid_cache_reset_accel(IntelIOMMUState *s);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
@@ -51,10 +51,10 @@ static inline bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as,
     return true;
 }
 
-static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
-                                                    uint16_t domain_id,
-                                                    uint32_t pasid, hwaddr addr,
-                                                    uint64_t npages, bool ih)
+static inline void vtd_flush_host_piotlb_all_accel(IntelIOMMUState *s,
+                                                   uint16_t domain_id,
+                                                   uint32_t pasid, hwaddr addr,
+                                                   uint64_t npages, bool ih)
 {
 }
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f53642a611..5d0184fa0d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3011,11 +3011,11 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     info.domain_id = domain_id;
     info.pasid = pasid;
 
+    vtd_flush_host_piotlb_all_accel(s, domain_id, pasid, 0, (uint64_t)-1,
+                                     false);
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
                                 &info);
-    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1,
-                                     false);
     vtd_iommu_unlock(s);
 
     QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
@@ -3045,10 +3045,11 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     info.addr = addr;
     info.mask = ~((1 << am) - 1);
 
+    vtd_flush_host_piotlb_all_accel(s, domain_id, pasid, addr, 1 << am, ih);
+
     vtd_iommu_lock(s);
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
-    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
     vtd_iommu_unlock(s);
 
     vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 26543489fb..2fd26690b9 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -231,9 +231,9 @@ static void vtd_flush_host_piotlb(VTDAccelPASIDCacheEntry *vtd_pce,
     }
 }
 
-void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
-                                      uint32_t pasid, hwaddr addr,
-                                      uint64_t npages, bool ih)
+void vtd_flush_host_piotlb_all_accel(IntelIOMMUState *s, uint16_t domain_id,
+                                     uint32_t pasid, hwaddr addr,
+                                     uint64_t npages, bool ih)
 {
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
-- 
2.47.3


