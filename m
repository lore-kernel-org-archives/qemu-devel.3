Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5455ECD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 05:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS78K-0006ZZ-Ka; Wed, 27 May 2026 01:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS786-0006MD-Ta
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:34 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS783-000149-Cf
 for qemu-devel@nongnu.org; Wed, 27 May 2026 01:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779860912; x=1811396912;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C4u+uBwWAupSfDTRKK4iBvwLz6UNfYE99LaLA9Y01AU=;
 b=HH7i2JSm3bQqjWLIvRy5GIRQeDVXHBXG3QgYhyUwPBlhg9MQ5fp3MFeL
 XaGxL5CZJdiXTihVohzCiJonzO1ADGUgSGHKnuzO8npSKyUHJflKPSn4Z
 CY6Xti3zCDlNrF2ib6g1DU4GPMuXO/GrfFKca5MtBvjeEnlAuotxXWqoP
 rdysLGc/512OcBQGsT1nm7n19BMNHOZ7oLxdTbTv0L8MaO3hESVcdOwCF
 YhN0SPlLBm4gxaetoR353vbhXlbQVU3fzTnWXc6WJRbjM2OFYEfiES1/r
 lL+FLKkH9VUuAXgpFqti6CnexI4bNpqidZGt9Sxf0Ol6uzWhQ8BS6rhlY A==;
X-CSE-ConnectionGUID: 4SCyShLKR+2SgrIe7ndaag==
X-CSE-MsgGUID: t66h/h7bQ9GswPY0zm7qrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90988184"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90988184"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:31 -0700
X-CSE-ConnectionGUID: yk1z4rVyTsGVNhC0cC3Rxg==
X-CSE-MsgGUID: nkeopYZPT+WAk1LdYQVxTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="241086857"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 22:48:27 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 14/17] intel_iommu_accel: Handle PASID entry removal for
 system reset
Date: Wed, 27 May 2026 01:46:52 -0400
Message-ID: <20260527054658.1021096-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
References: <20260527054658.1021096-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
---
 hw/i386/intel_iommu_accel.h |  5 +++++
 hw/i386/intel_iommu.c       |  2 ++
 hw/i386/intel_iommu_accel.c | 13 +++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
index c9b1823745..a2226b28b6 100644
--- a/hw/i386/intel_iommu_accel.h
+++ b/hw/i386/intel_iommu_accel.h
@@ -28,6 +28,7 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
                                       uint32_t pasid, hwaddr addr,
                                       uint64_t npages, bool ih);
 void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
+void vtd_accel_pasid_cache_reset(IntelIOMMUState *s);
 void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
 #else
 static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
@@ -62,6 +63,10 @@ static inline void vtd_accel_pasid_cache_sync(IntelIOMMUState *s,
 {
 }
 
+static inline void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
+{
+}
+
 static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
 {
 }
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94a6a740f1..c6e69c47b3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -391,6 +391,8 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_reset_context_cache_locked(s);
     vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
+
+    vtd_accel_pasid_cache_reset(s);
 }
 
 static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index f5fc6327b6..a445d6276e 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -486,6 +486,19 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     }
 }
 
+/* Fake a global pasid cache invalidation to remove all pasid cache entries */
+void vtd_accel_pasid_cache_reset(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .type = VTD_INV_DESC_PASIDC_G_GLOBAL };
+    VTDHostIOMMUDevice *vtd_hiod;
+    GHashTableIter hiod_it;
+
+    g_hash_table_iter_init(&hiod_it, s->vtd_host_iommu_dev);
+    while (g_hash_table_iter_next(&hiod_it, NULL, (void **)&vtd_hiod)) {
+        vtd_accel_pasid_cache_invalidate(vtd_hiod, &pc_info);
+    }
+}
+
 static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
                                           void *caps, uint32_t size)
 {
-- 
2.47.3


