Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4592BCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILbW-0005Xh-7Q; Thu, 30 Apr 2026 03:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILbI-0005Ia-IQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:23 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wILbF-0008SS-Hu
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777533257; x=1809069257;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5AAIh0/fe9VJgDFi4pd/VBv+Ip1yHHhCwUyOn7gO+jc=;
 b=K//NQ6BTOTcG7jVd1wvIB4NMiKVm/3vAcNnHfISSg/h87CrClF3KgH5r
 SdI73Gc1h6R7eSAjjalD1DmCaPtpZ7oIt74KEuNnvI2UqQsDHNs27kIOh
 t81bSKpWOuu1UzfB4HvNmlnFhgSy9W++eIOWKiX9cJu8iL7kcQ9wo+wwH
 K2JpvDUBhwyHnNTkxC9r5zS73k8t2REQrfNfk2M2ugHLTw/H/XiyaFCmo
 rLZ7E19AEga+pN3Vpy58RbbP/3EeKaAhqqNYhQpzxTB7v+flbVhHYhQ/7
 jjF00KCv5jJFeKDSZ6iVstX6e9hCowSXjCV/dqvqzvYSYapIjnFEuxMnx A==;
X-CSE-ConnectionGUID: trQBpopaSVSx98LQPKpXog==
X-CSE-MsgGUID: HNw7IuS2Qx2OQ/kejyF8TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="81051663"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="81051663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:14:16 -0700
X-CSE-ConnectionGUID: 3Fi9CFuVQK+gRu1qrd8oKQ==
X-CSE-MsgGUID: 0CsgCAa/RDOg3sodWSTLyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="234771573"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 00:14:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 12/15] intel_iommu_accel: Handle PASID entry removal for
 system reset
Date: Thu, 30 Apr 2026 03:13:08 -0400
Message-ID: <20260430071315.354333-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430071315.354333-1-zhenzhong.duan@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
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
index fa145af021..f4a61188c7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -420,6 +420,8 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_reset_context_cache_locked(s);
     vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
+
+    vtd_accel_pasid_cache_reset(s);
 }
 
 static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index 457fdcba62..4abe1d228d 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -516,6 +516,19 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
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


