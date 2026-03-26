Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FBC106F30E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5glM-0002ov-H1; Thu, 26 Mar 2026 05:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glL-0002oX-9U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:23 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glJ-0003yp-Kz
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516342; x=1806052342;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HUGKn7zuePTaNcnhazSWoRRNo81EyyhRMZgq6FzoUsQ=;
 b=ONwUMZc38nUDalsyx7kM6dXkvEtcIwugJ0S5AlCeb8MOTixfWj/6iumc
 FCE8KE7fmqrijJglQmbEQ+nSVG9zCnVXbVJ+lacR+ZI984242MyGY10Er
 OteOD1xdrzQZ10qykuP7TXHR4Lppi4sRAwMmXkN3tuJvGCzLEqPlBoWDN
 utUqxGN5cCkKl2sLA6sTgoZJilfi/zACndjYyujylVQ2Hlw8MngZecPVS
 opkG52mNYYqTveOPCKTkNjCGiTM4aq5ODQqo/KrPexGuSzFsiXAlSmSmh
 dgrqcvCHr5nH/upg/A8Tr5m2LbUpTXb3Hfx+mAssy7z+YwX/oohx4doFJ g==;
X-CSE-ConnectionGUID: CbvI6cnnQyq/ZW8XKvqrQA==
X-CSE-MsgGUID: qs+AUmEaQka7T6EGqCkFbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531382"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531382"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:21 -0700
X-CSE-ConnectionGUID: AzWLaEtVQ4WQHlWObkGsLw==
X-CSE-MsgGUID: AKhs4bNRQuuux6I4xi3iXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368603"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 10/14] intel_iommu_accel: Handle PASID entry removal for
 system reset
Date: Thu, 26 Mar 2026 05:11:24 -0400
Message-ID: <20260326091130.321483-11-zhenzhong.duan@intel.com>
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
index c5981a23bf..1fb7ca0af6 100644
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
index 451ede7530..b022f3cb9e 100644
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
index 1e27c0feb8..e9e67eb1a0 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -511,6 +511,19 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
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


