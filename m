Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE0DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 06:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upLUC-0000ge-N8; Fri, 22 Aug 2025 02:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLU8-0000Ry-Hi
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:48 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1upLTz-0000nA-Df
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 02:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755844959; x=1787380959;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R/ULxv/UtpGeLbXYBtcgxCGmuswd03BDnnhqDFNvkBo=;
 b=eOjNnL6NIsfEHEYFvrEd5hDiHUVetXxFdYnoofP5vctobCO6lNe5a9qs
 /MnJT+Hwb4Td+M+ma1KZalm5bEeI6E/AcjPOSUsRoxjjl/SyC+tpWVuGb
 yNFw/mjhz8TfchV9mTCe5rbWRdvJPD+6OqYoVMjrgCA/JYFb2DAIy/OHp
 14D9MgdQYffBxx1j7Zi5+scsb2LIHlyKjpX6BZg8c4vEZcoe972IHdsok
 YKghEnmNzm4Zu742myJ2inkst6VRMb8GaPtNy8O6JILwHu0yY+MFbVTtv
 y63qEey6YTtE7ee3bxZRyDCriNCj9h+jNnd4qay/SDevoyeBZElP/3pUH Q==;
X-CSE-ConnectionGUID: CVgdAnhDT9KDYYVit+Pv0Q==
X-CSE-MsgGUID: 17Ga26mrQA6IuQD+IyyuVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="68851961"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="68851961"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:28 -0700
X-CSE-ConnectionGUID: pmph73UrTyKZCDeHRNEMAw==
X-CSE-MsgGUID: tjkQLvGWTiiaSmhi5yA64g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; d="scan'208";a="168245050"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 23:42:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after context
 cache invalidation
Date: Fri, 22 Aug 2025 02:40:54 -0400
Message-ID: <20250822064101.123526-17-zhenzhong.duan@intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

This replays guest pasid bindings after context cache invalidation.
This is a behavior to ensure safety. Actually, programmer should issue
pasid cache invalidation with proper granularity after issuing a context
cache invalidation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 42 ++++++++++++++++++++++++++++++++++
 hw/i386/trace-events           |  1 +
 3 files changed, 45 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 61e35dbdc0..8af1004888 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -584,6 +584,8 @@ typedef enum VTDPCInvType {
 
     /* Reset all PASID cache entries, used in system level reset */
     VTD_PASID_CACHE_FORCE_RESET = 0x10,
+    /* Invalidate all PASID entries in a device */
+    VTD_PASID_CACHE_DEVSI,
 } VTDPCInvType;
 
 typedef struct VTDPASIDCacheInfo {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a10ee8eb4f..6c0e502d1c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -91,6 +91,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
+static void vtd_pasid_cache_sync(IntelIOMMUState *s,
+                                 VTDPASIDCacheInfo *pc_info);
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  PCIBus *bus, uint16_t devfn);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -2442,6 +2446,8 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
 
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
+    VTDPASIDCacheInfo pc_info;
+
     trace_vtd_inv_desc_cc_global();
     /* Protects context cache */
     vtd_iommu_lock(s);
@@ -2459,6 +2465,9 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+
+    pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
+    vtd_pasid_cache_sync(s, &pc_info);
 }
 
 #ifdef CONFIG_IOMMUFD
@@ -2691,6 +2700,15 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
              * happened.
              */
             vtd_address_space_sync(vtd_as);
+            /*
+             * Per spec, context flush should also be followed with PASID
+             * cache and iotlb flush. In order to work with a guest which
+             * doesn't follow spec and missed PASID cache flush, we have
+             * vtd_pasid_cache_devsi() to invalidate PASID caches of the
+             * passthrough device. Host iommu driver would flush piotlb
+             * when a pasid unbind is pass down to it.
+             */
+             vtd_pasid_cache_devsi(s, vtd_as->bus, devfn);
         }
     }
 }
@@ -3422,6 +3440,11 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
         break;
     case VTD_PASID_CACHE_FORCE_RESET:
         goto remove;
+    case VTD_PASID_CACHE_DEVSI:
+        if (pc_info->bus != vtd_as->bus || pc_info->devfn != vtd_as->devfn) {
+            return false;
+        }
+        break;
     default:
         error_setg(&error_fatal, "invalid pc_info->type for flush");
     }
@@ -3635,6 +3658,11 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     case VTD_PASID_CACHE_FORCE_RESET:
         /* For force reset, no need to go further replay */
         return;
+    case VTD_PASID_CACHE_DEVSI:
+        walk_info.bus = pc_info->bus;
+        walk_info.devfn = pc_info->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+        return;
     default:
         error_setg(&error_fatal, "invalid pc_info->type for replay");
     }
@@ -3683,6 +3711,20 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
     vtd_replay_guest_pasid_bindings(s, pc_info);
 }
 
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  PCIBus *bus, uint16_t devfn)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_devsi(devfn);
+
+    pc_info.type = VTD_PASID_CACHE_DEVSI;
+    pc_info.bus = bus;
+    pc_info.devfn = devfn;
+
+    vtd_pasid_cache_sync(s, &pc_info);
+}
+
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
                                    VTDInvDesc *inv_desc)
 {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 1c31b9a873..830b11f68b 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
+vtd_pasid_cache_devsi(uint16_t devfn) "Dev selective PC invalidation dev: 0x%"PRIx16
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.47.1


