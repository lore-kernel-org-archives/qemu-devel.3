Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26911D68BE2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7UH-0003Nr-EJ; Thu, 18 Dec 2025 01:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7UD-0003NN-RV
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:42 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7UC-000176-8f
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766039260; x=1797575260;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=70TY9FcSVSzvfgLc9xmiUg5o1saVK6Fm05MtLWcPp/Q=;
 b=PoFsqDndw8Ori6XkU1V3MbT87TKuwTwjh0XcpkgMVK0onzesj7FoGSoj
 7Wr0UaEtb6oTp4csW2ZH9UfVgrwW6VbmHRDhMGEXFRXvgtC4vsaYKGyrN
 b+Egy2V80WE5kegtbTNMF6DYa6Smb2eUs2c6X153X0837IkBAYvPLbKSX
 EWa/TEAH7HqF/ZaldX2BdMPn2TkDms/puWUDv6qBs7TiCYDZXJFtF3M5q
 1RHFIo6RHNxuEAdqqTHoLIlUpcHk79AAppFjOBiA9jEsx3M8VgXnicE4j
 tzzxx0IaRYUj1AaLfWdm6tyksjo2J1jXbQ6FVj5XqhGZWiqcTl40A0SaW Q==;
X-CSE-ConnectionGUID: ZvqHIlvvR/GZLcvNifWjBw==
X-CSE-MsgGUID: JSCzp98gRzCEUnoQq2SjEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68028552"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="68028552"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:39 -0800
X-CSE-ConnectionGUID: QvEc0k+dSvKhnQo4QYbF6Q==
X-CSE-MsgGUID: eV6gh4XVT+mob4bcVoTHYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203569898"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:36 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 6/9] intel_iommu: Fix unmap_bitmap failure with legacy VFIO
 backend
Date: Thu, 18 Dec 2025 01:26:27 -0500
Message-ID: <20251218062643.624796-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251218062643.624796-1-zhenzhong.duan@intel.com>
References: <20251218062643.624796-1-zhenzhong.duan@intel.com>
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

If a VFIO device in guest switches from IOMMU domain to block domain,
vtd_address_space_unmap() is called to unmap whole address space.

If that happens during migration, migration fails with legacy VFIO
backend as below:

Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))

Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
ioctl fails. Normally such large UNMAP notification come from IOVA range
rather than system memory.

Apart from that, vtd_address_space_unmap() sends UNMAP notification with
translated_addr = 0, because there is no valid translated_addr for unmapping
a whole iommu memory region. This breaks dirty tracking no matter which VFIO
backend is used.

Fix them all by iterating over DMAMap list to unmap each range with active
mapping when global_dirty_tracking is active. global_dirty_tracking is
protected by BQL, so it's safe to reference it directly. If it's not active,
unmapping the whole address space in one go is optimal.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7220a3d9f4..7c72fbaa52 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4764,6 +4764,43 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     return flags;
 }
 
+/*
+ * There is no valid translated_addr for unmapping a whole iommu memory region.
+ * When dirty tracking is enabled, we need it to set dirty bitmaps. Iterate
+ * over DMAMap list to unmap each range with active mapping and translated_addr
+ * value.
+ */
+static void vtd_address_space_unmap_in_dirty_tracking(VTDAddressSpace *as,
+                                                      IOMMUNotifier *n)
+{
+    const DMAMap *map;
+    const DMAMap target = {
+        .iova = n->start,
+        .size = n->end,
+    };
+    IOVATree *tree = as->iova_tree;
+
+    /*
+     * DMAMap is created during IOMMU page table sync, it's either 4KB or huge
+     * page size and always a power of 2 in size. So the range of DMAMap could
+     * be used for UNMAP notification directly.
+     */
+    while ((map = iova_tree_find(tree, &target))) {
+        IOMMUTLBEvent event;
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+        event.entry.iova = map->iova;
+        event.entry.addr_mask = map->size;
+        event.entry.target_as = &address_space_memory;
+        event.entry.perm = IOMMU_NONE;
+        /* This field is needed to set dirty bigmap */
+        event.entry.translated_addr = map->translated_addr;
+        memory_region_notify_iommu_one(n, &event);
+
+        iova_tree_remove(tree, *map);
+    }
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4773,6 +4810,11 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     IntelIOMMUState *s = as->iommu_state;
     DMAMap map;
 
+    if (global_dirty_tracking) {
+        vtd_address_space_unmap_in_dirty_tracking(as, n);
+        return;
+    }
+
     /*
      * Note: all the codes in this function has a assumption that IOVA
      * bits are no more than VTD_MGAW bits (which is restricted by
-- 
2.47.1


