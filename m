Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39636D68BDD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7UO-0003OX-6G; Thu, 18 Dec 2025 01:27:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7UJ-0003Ny-Am
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:47 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7UH-00019A-9R
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766039265; x=1797575265;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F94eQF5etGZnbJvv+YltI5zknPfG77G/Rv34Fp6qScQ=;
 b=eDnsPpkNnWelfNp4SQ+7pNn39RafWsXloPP6cZCSWUk/warJy2ICM8B2
 2edCQCqts+GVrurf6/nRxiBp+dYbnk1eHxHo1iCX/MrHSn3NQ9d+jWvqR
 M9GMc8H50V+7oRfJyMfkWSeEGyRr2A4X6GWxqWiAbJ7h78aQrRN09oUKq
 nOYe2/eNdq0o6TjNrqpHSe3rwOX/b6H3aVBZNF871C25j07P6oScRVSvK
 RjJskP5dWjIxFQGsPFeEgyUCp+0utkFAcu4QOAiPbvvtx/6Ej5GHBC32D
 6kv8ubE3hbu5kzFl7VnPg8Li+sDE9M0b4JZ7cRS2qL2zccmSWROFKlZfk g==;
X-CSE-ConnectionGUID: JLZklg7MTYyt+bt2wwUfUg==
X-CSE-MsgGUID: uq2ShDaqS7G31ZtZsP3vZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68028564"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="68028564"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:43 -0800
X-CSE-ConnectionGUID: K7FN/OOJTmWdLM5EN2wplw==
X-CSE-MsgGUID: LpbKp+Z8SAqmXx//Gw/3xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203569902"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:40 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 7/9] vfio/listener: Add missing dirty tracking in region_del
Date: Thu, 18 Dec 2025 01:26:28 -0500
Message-ID: <20251218062643.624796-8-zhenzhong.duan@intel.com>
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

If a VFIO device in guest switches from passthrough(PT) domain to block
domain, the whole memory address space is unmapped, but we passed a NULL
iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
dirty pages.

By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
set dirty bits correctly.

For IOMMU address space, we still send NULL iotlb because VFIO don't know
the actual mappings in guest. It's vIOMMU's responsibility to send actual
unmapping notifications, e.g., vtd_address_space_unmap_in_dirty_tracking().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/vfio/listener.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2109101158..35675e0ed7 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -713,14 +713,34 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     if (try_unmap) {
         bool unmap_all = false;
+        IOMMUTLBEntry entry = {}, *iotlb = NULL;
 
         if (int128_eq(llsize, int128_2_64())) {
             assert(!iova);
             unmap_all = true;
             llsize = int128_zero();
         }
+
+        /*
+         * Fake an IOTLB entry for identity mapping which is needed by dirty
+         * tracking when switch out of PT domain. In fact, in unmap_bitmap,
+         * only translated_addr field is used to set dirty bitmap.
+         *
+         * Note: When switch into PT domain from DMA domain, the whole IOMMU
+         * MR is deleted without iotlb, before that happen, we depend on
+         * vIOMMU to send unmap notification with accurate iotlb entry to
+         * VFIO. See vtd_address_space_unmap_in_dirty_tracking() for example,
+         * it is triggered during switching to block domain because vtd does
+         * not support direct switching from DMA to PT domain.
+         */
+        if (global_dirty_tracking && memory_region_is_ram(section->mr)) {
+            entry.iova = iova;
+            entry.translated_addr = iova;
+            iotlb = &entry;
+        }
+
         ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
-                                       NULL, unmap_all);
+                                       iotlb, unmap_all);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.47.1


