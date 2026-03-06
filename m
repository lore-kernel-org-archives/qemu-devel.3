Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFD3F513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 03:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyM7m-0004gJ-4u; Thu, 05 Mar 2026 22:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7j-0004ah-HV
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:45:11 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyM7g-00066q-Un
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 22:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772768709; x=1804304709;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GzTHKeCzkvGzGvmu2TSXymj1N9dxdmDs7odFcKcpL9U=;
 b=jWcLzDDS4LDadUG9zFBiAfEDAfq2km/g0/IO4RhQy0ns+tCYIRZ2QE1G
 nDQo3gmd0O8Uzn8Oh4u+CSxyVocauaxI2LMBS5bjpF+a1qW+3U69Ok1p3
 swB+2UvwUeajlWxlyrTM8676dFqCx9kN12Z3CA6rCw8pSTKbb7XhwvPLp
 ZXvwTOl7LPBkf0tnDxm1WsuwvsH0GqFmnaWRNoS1+p7fYLtYLodpMLzyx
 6+DhZibJZKJzGhXZoDD8eV2gqVxf0A0Rcdf0wtRZL0RK44DLK7x9VsMli
 YEuY1z9TvlUTQiJkCLU27PXilBbjqLnUXcL86biROWDzco6QmWCT+M8JJ A==;
X-CSE-ConnectionGUID: ay/uaaSYRI6Zb53aIkTYTw==
X-CSE-MsgGUID: esG7oj1+RRCLqmrrRTF0DQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="91448336"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="91448336"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:58 -0800
X-CSE-ConnectionGUID: 6BhxTXjSRyCt0nuiMANDew==
X-CSE-MsgGUID: ZkaiZ92zRki14IIvjXhZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="215613427"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 19:44:55 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Date: Thu,  5 Mar 2026 22:44:05 -0500
Message-ID: <20260306034409.184873-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306034409.184873-1-zhenzhong.duan@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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
index 1ae46d9250..3f1b1002b8 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -24,9 +24,9 @@ typedef struct VTDACCELPASIDCacheEntry {
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
index edd2b8f0cc..3ea5b92b34 100644
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
index d7c1ff6b74..acb1b1e238 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -231,9 +231,9 @@ static void vtd_flush_host_piotlb(VTDACCELPASIDCacheEntry *vtd_pce,
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


