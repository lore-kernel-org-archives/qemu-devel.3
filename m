Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE82EC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 07:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSW61-00067X-0P; Fri, 20 Jun 2025 03:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5z-00064k-I1
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:31 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSW5t-0008IS-4L
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 03:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750404205; x=1781940205;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a+4DL6Kt9UrDBXTU7mc6IQmiznf4ZHMvJYuhZ/TpLLU=;
 b=BV6N3WA2p989KMFHLMv5/lJ6pHs88TEw+Nrd72toXDfJTg9T3INNvedh
 kQVSATPh+gRGYhVAC31jmms8NWQb3umMgcvlKYXbWf3baknSmCh/PrDpJ
 NsoP18PftQ+l15CaikSbJttj95OTOrSz8SsfgsaWFZhS4YW+GIe17aCxb
 g07hwEd8iPpOT9EFyYw4/ULyl3nd5wYSLRtbMmbprRwQSZHenm0sU/Kgh
 UX9m3RQdBbjuu++OTkhBcR3a+rpmiekv4RC06ll6LwTCln2viQHBxapi2
 5eF1hNiydjuCrfPStEpeP8Oz3PihKCtEFFv5NDIE+na9z9J5lov5ZtqbT w==;
X-CSE-ConnectionGUID: 8zaCfZhCSn+87WLicilW3Q==
X-CSE-MsgGUID: atFdRzimTn2XRt56ZRoFEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52532496"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52532496"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:24 -0700
X-CSE-ConnectionGUID: L6m/dZzCTUKWErHxeN4mYA==
X-CSE-MsgGUID: JsOj/RiPT+SGs4MD4DHwFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="181863262"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 00:23:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 15/19] intel_iommu: Replay pasid binds after context cache
 invalidation
Date: Fri, 20 Jun 2025 15:18:09 +0800
Message-Id: <20250620071813.55571-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620071813.55571-1-zhenzhong.duan@intel.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This replays guest pasid attachments after context cache invalidation.
This is a behavior to ensure safety. Actually, programmer should issue
pasid cache invalidation with proper granularity after issuing a context
cache invalidation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 51 ++++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 92a533db54..b3e4aa23f1 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -575,6 +575,7 @@ typedef enum VTDPCInvType {
     VTD_PASID_CACHE_FORCE_RESET = 0,
     /* pasid cache invalidation rely on guest PASID entry */
     VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
+    VTD_PASID_CACHE_DEVSI,      /* pasid cache device selective invalidation */
     VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
     VTD_PASID_CACHE_PASIDSI,    /* pasid cache pasid selective invalidation */
 } VTDPCInvType;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1c94a0033c..621b07aa02 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -92,6 +92,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
+static void vtd_pasid_cache_sync(IntelIOMMUState *s,
+                                 VTDPASIDCacheInfo *pc_info);
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  PCIBus *bus, uint16_t devfn);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -2437,6 +2441,8 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
 
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
+
     trace_vtd_inv_desc_cc_global();
     /* Protects context cache */
     vtd_iommu_lock(s);
@@ -2454,6 +2460,9 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+
+    pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
+    vtd_pasid_cache_sync(s, &pc_info);
 }
 
 #ifdef CONFIG_IOMMUFD
@@ -2696,6 +2705,21 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
              * happened.
              */
             vtd_address_space_sync(vtd_as);
+            /*
+             * Per spec, context flush should also followed with PASID
+             * cache and iotlb flush. Regards to a device selective
+             * context cache invalidation:
+             * if (emaulted_device)
+             *    invalidate pasid cache and pasid-based iotlb
+             * else if (assigned_device)
+             *    check if the device has been bound to any pasid
+             *    invoke pasid_unbind regards to each bound pasid
+             * Here, we have vtd_pasid_cache_devsi() to invalidate pasid
+             * caches, while for piotlb in QEMU, we don't have it yet, so
+             * no handling. For assigned device, host iommu driver would
+             * flush piotlb when a pasid unbind is pass down to it.
+             */
+             vtd_pasid_cache_devsi(s, vtd_as->bus, devfn);
         }
     }
 }
@@ -3447,6 +3471,11 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         /* Fall through */
     case VTD_PASID_CACHE_GLOBAL_INV:
         break;
+    case VTD_PASID_CACHE_DEVSI:
+        if (pc_info->bus != vtd_as->bus || pc_info->devfn != vtd_as->devfn) {
+            return false;
+        }
+        break;
     default:
         error_report("invalid pc_info->type");
         abort();
@@ -3640,6 +3669,11 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     case VTD_PASID_CACHE_GLOBAL_INV:
         /* loop all assigned devices */
         break;
+    case VTD_PASID_CACHE_DEVSI:
+        walk_info.bus = pc_info->bus;
+        walk_info.devfn = pc_info->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+        return;
     case VTD_PASID_CACHE_FORCE_RESET:
         /* For force reset, no need to go further replay */
         return;
@@ -3675,8 +3709,7 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
  * It includes updating the pasid cache in vIOMMU and updating the
  * pasid bindings per guest's latest pasid entry presence.
  */
-static void vtd_pasid_cache_sync(IntelIOMMUState *s,
-                                 VTDPASIDCacheInfo *pc_info)
+static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
 {
     if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
         return;
@@ -3737,6 +3770,20 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
     vtd_replay_guest_pasid_bindings(s, pc_info);
 }
 
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  PCIBus *bus, uint16_t devfn)
+{
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
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
2.34.1


