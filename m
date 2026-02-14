Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF16EF99F6
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 03:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr6YD-0005E6-LQ; Fri, 13 Feb 2026 22:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6YB-0005DU-EM
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:31 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vr6Y9-0008J1-SE
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 22:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771040550; x=1802576550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ehaQvOENXTS0OCP62OfUZHfSY2q/JCq+zdIl3/5eVMQ=;
 b=b6Ivixykmc2X6xm1aEIKBkcmqgu3Jc1R+tJyOqOWs3XModejT5wzjBSu
 pW/Ac4zGrO92ytjQUTzHI6fdKn/pW+bcvsShQLKQglUBStmQgy9Nue520
 S5kvENEHS+a4sGxTY8xWiP3A19qpuQ8wyFftpZ+FOgLKBhXZa5uFMnz2R
 u9y5JIrRWqFW891mhsd2DyDTbmJEbzbI51kBZGEBQUGMlMfSo5Qv9e4Sw
 3xRxuWw7iwWD6Hg4yeMLEcBiZojCFjDM1xVPadV6O8xJl/yE/2TZA++lK
 kvCoezufSsVKNky6QKko+SNpwCNgkrEv3cGjRqCOwj9iuPygnIII6iC3N w==;
X-CSE-ConnectionGUID: rNAhwzYDRUGKpUv3Z4ABCw==
X-CSE-MsgGUID: qfd133uLTCGVVWF3EgW3Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="83666871"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="83666871"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:42:29 -0800
X-CSE-ConnectionGUID: woshjByVTa2ZvaDFepDi2w==
X-CSE-MsgGUID: 4PYcl7veTP+ycpW9F6M9Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212933119"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 19:42:25 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFCv2 PATCH 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Date: Fri, 13 Feb 2026 22:41:31 -0500
Message-ID: <20260214034135.220413-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260214034135.220413-1-zhenzhong.duan@intel.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
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
index a8d760eb51..6483cb3d85 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2994,11 +2994,11 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
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
@@ -3028,10 +3028,11 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
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


