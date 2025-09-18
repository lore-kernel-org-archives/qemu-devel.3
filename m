Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF84CCAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAUP-000255-Di; Thu, 18 Sep 2025 04:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUC-0001La-Rf
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:32 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAU8-0004kz-LY
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758185964; x=1789721964;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TZ/XrRR3DKUlpIzh8dBEtMUg4bYv8S7lSa4qI7C8fnw=;
 b=Uz1P+6d8eb8EWA2NNiGqmJJjKDMGFZe2ITqOQj98Ayg7T1SjDvwVBQEO
 N3Q7brapOO/FH7xsC+sVAmgEymqeGQmfHFb18PUK4ewT4FrswhB5W/hML
 pjvRsAUmZgOlpIi/reg6N0BfzSdxBC5Wypnl3vFj6asyVxk6Hrh81WhfM
 WV0Zf5R7JyIYSx8efe/aInRaJF73PPS1c/UnwrYZzSxeT6vOyzLuStEyh
 nidABKHRWZzITqmyGHHscUbTbw/+7tHZX3WZObaFgggIq0QZko2pVh2Y9
 nR+rbA99eM5onk6F/uR2Ivg2R0xjGdpNOAFhlYNA8ToDSwnBVuDa5TxPe w==;
X-CSE-ConnectionGUID: Fy18S3pzR4WEsZx4HOYDBw==
X-CSE-MsgGUID: OvGyqdqvSQeidTcgVW6v6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109530"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:23 -0700
X-CSE-ConnectionGUID: 8wPEaro/TSWBz5oM8Gb5kg==
X-CSE-MsgGUID: 3dnRDlFSSxeUscqQNxSYYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930412"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 13/22] intel_iommu: Reset pasid cache when system level
 reset
Date: Thu, 18 Sep 2025 04:57:52 -0400
Message-ID: <20250918085803.796942-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
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

Reset pasid cache when system level reset, for RID_PASID, its vtd_as is
allocated by PCI system and never removed, just mark pasid cache invalid.

As we already have vtd_pasid_cache_sync_locked() to handle pasid cache
invalidation, reuse it to do pasid cache invalidation at system reset
level.

Currently only IOMMUFD backed VFIO device caches pasid entry, so we don't
need to care about emulated device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 15 ++++++++++++++-
 hw/i386/trace-events  |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 24061f6dc6..a6638e13be 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -85,6 +85,18 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
+                                        gpointer user_data);
+
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .reset = true };
+
+    trace_vtd_pasid_cache_reset();
+    g_hash_table_foreach(s->vtd_address_spaces,
+                         vtd_pasid_cache_sync_locked, &pc_info);
+}
+
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -390,6 +402,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
@@ -3115,7 +3128,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     /* non-RID_PASID isn't supported yet */
     assert(vtd_as->pasid == PCI_NO_PASID);
 
-    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+    if (pc_info->reset || vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
         /*
          * No valid pasid entry in guest memory. e.g. pasid entry was modified
          * to be either all-zero or non-present. Either case means existing
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 298addb24d..b704f4f90c 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_inv_desc_pasid_cache_gsi(void) ""
 vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
-- 
2.47.1


