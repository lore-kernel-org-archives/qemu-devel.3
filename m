Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC52EA795B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnpnb-0005S1-4m; Wed, 04 Feb 2026 22:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnZ-0005Rq-NX
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:53 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vnpnY-0001wl-2o
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770261172; x=1801797172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D+X7iNrJYXSaI+YhjY4rQ3Twf5YAfMCtI7wjapx5LH0=;
 b=FH9d9HEYn/3WJp3ojNObtSNihvuDaZUSZrsvg9A1rWDYM3AgyzR0Cho3
 e+Ko84REgg0ZKbulBO9lqPZVge3a+gg+D0QRgNe/2V8KqaMftWhJ+KEXP
 fpX2ImqZ50Izpas79SlBZg1HiSoU1iq8SGUtKWWm4a2iGue8+VsBdUCwa
 twpSVOCErPbSUKWhdV29D/La5FopUqOd6cmrA+nrAcy10SYU1/ABnNqOh
 mF3qE5pMYUM3uoQ7tpAM6larTFwlcMPrrBE7O8600hpv/c1Fu08zlrYu7
 CNv+fTwFc8ZRbIRID3dgGv4IEE0FCdFqjylbLs2kzfoiJ3+SGS1MMHCqU g==;
X-CSE-ConnectionGUID: JY32vg8YRxadeM/xOI5qSA==
X-CSE-MsgGUID: GjIqNdxrT5iHb+yTbf/b7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96910498"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="96910498"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:51 -0800
X-CSE-ConnectionGUID: 17iKMqcKQduGKbq0c5OWew==
X-CSE-MsgGUID: ctalZLSDRIuYHGqoxf0Bjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; d="scan'208";a="209652065"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2026 19:12:47 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH 09/14] intel_iommu: Handle PASID entry removal for system
 reset
Date: Wed,  4 Feb 2026 22:11:27 -0500
Message-ID: <20260205031133.74357-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205031133.74357-1-zhenzhong.duan@intel.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
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

When system level reset, DMA translation is turned off, all PASID
entries become stale and should be deleted.

vtd_hiod list is never accessed without BQL, so no need to guard with
iommu lock.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_accel.h |  5 +++++
 hw/i386/intel_iommu.c       |  2 ++
 hw/i386/intel_iommu_accel.c | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index a77fd06fe0..914c690c26 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -28,6 +28,7 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
 void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
+void vtd_pasid_cache_reset_accel(IntelIOMMUState *s);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -62,6 +63,10 @@ static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
 {
 }
 
+static inline void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
+{
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 50569460ab..1d0f0bf68b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -391,6 +391,8 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_reset_context_cache_locked(s);
     vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
+
+    vtd_pasid_cache_reset_accel(s);
 }
 
 static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 2c17365a27..1d7dae87ec 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -493,6 +493,19 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     }
 }
 
+/* Fake a gloal pasid cache invalidation to remove all pasid cache entries */
+void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .type = VTD_INV_DESC_PASIDC_G_GLOBAL };
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter as_it;
+
+    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
+        vtd_pasid_cache_invalidate(vtd_hiod, &pc_info);
+    }
+}
+
 static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
                                           void *caps, uint32_t size)
 {
-- 
2.47.3


