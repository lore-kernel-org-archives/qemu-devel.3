Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83212CD043D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 06:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd0LP-0004xR-3o; Tue, 06 Jan 2026 01:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0Kr-0004OD-Cs
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:32 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vd0Kp-0007KE-MU
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 01:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767680068; x=1799216068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ibw3PAmlfpDsRz5Ss+z5Y8MtT2uZd2EjIABvaRCChX0=;
 b=ZfJoQu4bm/Bi1ooAad1W9VQXOf7QgHTzjo6efOU1SEUr8upWslOJKYcF
 hJBpHmZDKjso3WNUR+6oZqUWRNhBvPvVmM4JL1PYROD/syj92wf77K20K
 5a5Yv/E/JB4wAlqvCIeHeRq1GOTZJ6YBVz6081KaIXFTEahETOkKo8kHD
 63WKQlBNmuG0hwGTBSzRSjyk1jcUVT7EONPdxc91CnlHKdL2ZHH0y5QAj
 RNWn06/sXwdtip8MI7mbCvw9o+2Z8X/3iA+W1kSH94EnXQk2tx4kCCogJ
 EPJBuysbLsNGFeBZzVbki9oyxw0EtV19O6qOi7Cu3JZwV/3M6z9OFCwBi A==;
X-CSE-ConnectionGUID: j9nB7xJnRF205eP/QJYhjQ==
X-CSE-MsgGUID: SVlfy4R5RrOA6y5rLMF0bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="69094073"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="69094073"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:27 -0800
X-CSE-ConnectionGUID: 5ZKjzEZtRoGBFjxwio3EyQ==
X-CSE-MsgGUID: QoZZwXnySMi8q3DoOh4qtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; d="scan'208";a="202588911"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jan 2026 22:14:23 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v10 16/19] intel_iommu: Replay pasid bindings after context
 cache invalidation
Date: Tue,  6 Jan 2026 01:12:58 -0500
Message-ID: <20260106061304.314546-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260106061304.314546-1-zhenzhong.duan@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
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

From: Yi Liu <yi.l.liu@intel.com>

This replays guest pasid bindings after context cache invalidation.
Actually, programmer should issue pasid cache invalidation with proper
granularity after issuing context cache invalidation.

We see old linux such as 6.7.0-rc2 not following the spec, it sends
pasid cache invalidation before context cache invalidation, then QEMU
depends on context cache invalidation to get pasid entry and setup
binding.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/trace-events  |  1 +
 2 files changed, 43 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3241af811c..08236b85ee 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -77,6 +77,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s);
+static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
+                                        gpointer user_data);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
 {
@@ -2322,6 +2324,37 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+    /*
+     * Same for pasid cache invalidation, per VT-d spec 6.5.2.1, a global
+     * context cache invalidation should be followed by global PASID cache
+     * invalidation. In order to work with guest not following spec,
+     * handle global PASID cache invalidation here.
+     */
+    vtd_replay_pasid_bindings_all(s);
+}
+
+static void vtd_pasid_cache_devsi(VTDAddressSpace *vtd_as)
+{
+    IntelIOMMUState *s = vtd_as->iommu_state;
+    PCIBus *bus = vtd_as->bus;
+    uint8_t devfn = vtd_as->devfn;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+        .pasid = vtd_as->pasid,
+    };
+    VTDPASIDCacheInfo pc_info;
+
+    if (!s->fsts || !s->root_scalable || !s->dmar_enabled) {
+        return;
+    }
+
+    trace_vtd_pasid_cache_devsi(pci_bus_num(bus),
+                                VTD_PCI_SLOT(devfn), VTD_PCI_FUNC(devfn));
+
+    /* We fake to be global invalidation just to bypass all checks */
+    pc_info.type = VTD_INV_DESC_PASIDC_G_GLOBAL;
+    vtd_pasid_cache_sync_locked(&key, vtd_as, &pc_info);
 }
 
 /* Do a context-cache device-selective invalidation.
@@ -2382,6 +2415,15 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
              * happened.
              */
             vtd_address_space_sync(vtd_as);
+            /*
+             * Per spec 6.5.2.1, context flush should be followed by PASID
+             * cache and iotlb flush. In order to work with a guest which does
+             * not follow spec and missed PASID cache flush, e.g., linux
+             * 6.7.0-rc2, we have vtd_pasid_cache_devsi() to invalidate PASID
+             * cache of passthrough device. Host iommu driver would flush
+             * piotlb when a pasid unbind is passed down to it.
+             */
+            vtd_pasid_cache_devsi(vtd_as);
         }
     }
 }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5a3ee1cf64..5fa5e93b68 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
 vtd_inv_desc_pasid_cache_gsi(void) ""
 vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
+vtd_pasid_cache_devsi(uint8_t bus, uint8_t dev, uint8_t fn) "Dev selective PC invalidation dev: %02"PRIx8":%02"PRIx8".%02"PRIx8
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.47.1


