Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BD2CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yck-0002gu-GA; Wed, 15 Oct 2025 06:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8yci-0002gV-Va
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:20:49 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8ycZ-0007ZR-FS
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760523640; x=1792059640;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7BK/paDvLhMdN55GyoqCnZtFzh+Tklafy6+0V6lnSlg=;
 b=P6bcW+Hy1WSHI8ZOEZ4HAz4eTPpR2r5LI40AnjRHMC9KkP1yovaYvJ8c
 aPTo6BhR99nDnLvTZ7ZPfgvHvnf7JKXTwkxgSBTutX5vfs/DfM6BN51Nx
 +JA+xDjs97gMQVp4TFTPejoA5XN1TPC78F7m7qP2eZzowC6IU0Vce8q5l
 JNPt4z1HyDSnqaulDUq843emZ/4b6r3cS/jiaekDFtc0THEfryoukIdxR
 UhRLKoAGCMcJHwM88xiJYyyyKf2n60zPxMdQhrgzAiYsi+7dinA6+fpAO
 3jUUE1ZmEzyaPxYgJMUcPwUMqrIXGAOCeGBkrXX0ndhuM4SbA7UZWK+ym Q==;
X-CSE-ConnectionGUID: A9xdnr74QI+GnEbmF5vY9A==
X-CSE-MsgGUID: tC7M6SatQ32eU2S2zmwh6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66556795"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="66556795"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:20:27 -0700
X-CSE-ConnectionGUID: ZGcEMUVUR42u9AIIiJm3Ug==
X-CSE-MsgGUID: ZGEgbPLEQ4+hgEoyv5sX+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="182082692"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:20:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, yi.l.liu@intel.com,
 clement.mathieu--drif@eviden.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/3] intel_iommu: Reset pasid cache when system level reset
Date: Wed, 15 Oct 2025 06:20:01 -0400
Message-ID: <20251015102003.279239-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251015102003.279239-1-zhenzhong.duan@intel.com>
References: <20251015102003.279239-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
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

Reset pasid cache when system level reset, for PASID_0, its vtd_as is
allocated by PCI system and never removed, just mark pasid cache invalid.

As we already have vtd_pasid_cache_sync_locked() to handle pasid cache
invalidation, reuse it to do pasid cache invalidation at system reset
level.

Currently only IOMMUFD backed VFIO device caches pasid entry, so we don't
need to care about emulated device.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 18 ++++++++++++++++--
 hw/i386/trace-events           |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 80193ff28b..f6f2b7b8d5 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -618,6 +618,7 @@ typedef struct VTDPASIDCacheInfo {
     uint8_t type;
     uint16_t did;
     uint32_t pasid;
+    bool reset;
 } VTDPASIDCacheInfo;
 
 /* PASID Table Related Definitions */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 66f45f89cb..d656e9c256 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -86,6 +86,18 @@ struct vtd_iotlb_key {
 
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
 
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
@@ -381,6 +393,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
@@ -3083,11 +3096,12 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
     VTDPASIDEntry pe;
     uint16_t did;
 
-    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
+    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe) || pc_info->reset) {
         /*
          * No valid pasid entry in guest memory. e.g. pasid entry was modified
          * to be either all-zero or non-present. Either case means existing
-         * pasid cache should be invalidated.
+         * pasid cache should be invalidated. This also applies to system level
+         * reset where the whole guest memory is treated as zeroed.
          */
         pc_entry->valid = false;
         return;
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


