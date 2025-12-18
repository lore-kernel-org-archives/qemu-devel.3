Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5021D68BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7U6-0003M9-DN; Thu, 18 Dec 2025 01:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7U3-0003Li-L5
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:31 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vW7U1-000176-RU
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766039250; x=1797575250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LfyNeuhUqgjGJ24g/CHR2kKYmIwQdqe2lRcUCbGnYFY=;
 b=a164f+6iHiEWXZxc8t+h5teB96YTeLXQYYLkhg+0mtiQRffvTFZNVVPs
 JNGRMA0kN91eQOgrYFZp2iyTAEHaki4bx8tCORbM9U5LiezEE5n9rQYPT
 VoZq1/Fb/8k3RS3aUHadsSmHEHIqlYjYtxCs22yhQlgD91SpK8LkkH7FX
 y1rnw+HZn0dmaoKpdcSdc/jAR/Qs7OkYtKO20b8+3gMT6GiV5+NoY5FoU
 RNiHEd7+7cvRAfsd5/oVZH3ZVm7RBujgYQmOZlyxRBHfUJKRVp1MCfn4g
 EmHIPuC85Z6F3gUXcSCxFPe6j8j5AzliP9K+dZNeo8gbGe5C44bcjjW5K A==;
X-CSE-ConnectionGUID: SlWRCxEjS+6QH3IZb0KmgQ==
X-CSE-MsgGUID: CDh0CAKkSi+quGftjllx0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="68028517"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="68028517"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:27 -0800
X-CSE-ConnectionGUID: 7fxD/4gpRs26NYBg4nu2Aw==
X-CSE-MsgGUID: vnUEN+cCRSmCZZUxpxLSTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="203569860"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:27:24 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 3/9] vfio/container-legacy: rename vfio_dma_unmap_bitmap()
 to vfio_legacy_dma_unmap_get_dirty_bitmap()
Date: Thu, 18 Dec 2025 01:26:24 -0500
Message-ID: <20251218062643.624796-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251218062643.624796-1-zhenzhong.duan@intel.com>
References: <20251218062643.624796-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is to follow naming style in container-legacy.c to have low level functions
with vfio_legacy_ prefix.

No functional changes.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 hw/vfio/container-legacy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index 32c260b345..48bcbc0264 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -68,9 +68,10 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
     }
 }
 
-static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
-                                 hwaddr iova, uint64_t size,
-                                 IOMMUTLBEntry *iotlb)
+static int
+vfio_legacy_dma_unmap_get_dirty_bitmap(const VFIOLegacyContainer *container,
+                                       hwaddr iova, uint64_t size,
+                                       IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap *unmap;
@@ -141,7 +142,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
+            return vfio_legacy_dma_unmap_get_dirty_bitmap(container, iova, size,
+                                                          iotlb);
         }
 
         need_dirty_sync = true;
-- 
2.47.1


