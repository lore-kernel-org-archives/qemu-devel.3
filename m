Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197ABCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLTi-00087F-8J; Fri, 22 Aug 2025 02:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTf-00086a-Sh
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:19 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTd-0000ms-OX
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844938; x=1787380938;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TjcSiYOFGErYkuxb0F+W0qo6CJQ3SHvdw/xJfxSWw98=;
 b=iD3iJ5jkaIt7fSwZ5qsQ6hnk4AjqOlttQJ4dG8HCod7rp8R9pH0DgiVr
 WJCnJfVcGYByv6cI2rHdTgMEMFwdK7ETa6j3OkwnFLleJ4v8cth/QTXNs
 ks8ndWmBjlSokqP7vm5mXuZoPzF1iLa9NbzlHGEXN+nahpcr+bh2cRakU
 1WyJBnDETRC7kiuRE1KWrvizCqXExDm7W5WeIbcbJRKbqjGPkC30AM+sC
 dBfL8LPJyPS1d3FNEnLyTzfyr8jTjilE7gvC29ZkBi01tTRIpe4u6CIW+
 j88vjqnIMc4PzsHKJcdVUfrAL7ORf02QcL33IivjZM9kSrClzgg/1DiYY A==;
X-CSE-ConnectionGUID: /jEegJDhSwqGEymf3PzPhg==
X-CSE-MsgGUID: 5HuzbMUETj6hBLlf5WHnfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851940"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851940"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:16 -0700
X-CSE-ConnectionGUID: xd8bp4wJSweM5w25WxofWw==
X-CSE-MsgGUID: D7bfccMFQDa4QnouymoD1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168245020"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v5 13/21] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Date: Fri, 22 Aug 2025 02:40:51 -0400
Message-ID: <20250822064101.123526-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250822064101.123526-1-zhenzhong.duan@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
underlying pasid entry is still valid, it drops all the pasid caches.

FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
only used internally in system level reset.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  9 +++++++++
 hw/i386/intel_iommu.c          | 25 +++++++++++++++++++++++++
 hw/i386/trace-events           |  1 +
 3 files changed, 35 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index fb2a919e87..c510b09d1a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -569,6 +569,15 @@ typedef enum VTDPCInvType {
     VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
     VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
     VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
+
+    /*
+     * Internally used PASID cache invalidation type starts here,
+     * 0x10 is large enough as invalidation type in pc_inv_desc
+     * is 2bits in size.
+     */
+
+    /* Reset all PASID cache entries, used in system level reset */
+    VTD_PASID_CACHE_FORCE_RESET = 0x10,
 } VTDPCInvType;
 
 typedef struct VTDPASIDCacheInfo {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7d2c9feae7..af384ce7f0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,6 +87,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
+
 static void vtd_panic_require_caching_mode(void)
 {
     error_report("We need to set caching-mode=on for intel-iommu to enable "
@@ -391,6 +393,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
@@ -3183,6 +3186,8 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
         /* fall through */
     case VTD_PASID_CACHE_GLOBAL_INV:
         break;
+    case VTD_PASID_CACHE_FORCE_RESET:
+        goto remove;
     default:
         error_setg(&error_fatal, "invalid pc_info->type for flush");
     }
@@ -3225,6 +3230,23 @@ remove:
     return true;
 }
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_reset();
+
+    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
+
+    /*
+     * Reset pasid cache is a big hammer, so use g_hash_table_foreach_remove
+     * which will free all vtd_as instances except those created for PCI
+     * sub-system.
+     */
+    g_hash_table_foreach_remove(s->vtd_address_spaces,
+                                vtd_flush_pasid_locked, &pc_info);
+}
+
 /*
  * This function walks over PASID range within [start, end) in a single
  * PASID table for entries matching @info type/did, then retrieve/create
@@ -3363,6 +3385,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     case VTD_PASID_CACHE_GLOBAL_INV:
         /* loop all assigned devices */
         break;
+    case VTD_PASID_CACHE_FORCE_RESET:
+        /* For force reset, no need to go further replay */
+        return;
     default:
         error_setg(&error_fatal, "invalid pc_info->type for replay");
     }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ae5bbfcdc0..c8a936eb46 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
-- 
2.47.1


