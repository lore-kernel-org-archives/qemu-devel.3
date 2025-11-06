Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0D6CCFA1A
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 04:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGrUX-0006c8-Ji; Wed, 05 Nov 2025 23:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUV-0006bg-Ao
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:20:55 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUT-0000oW-Oo
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762402853; x=1793938853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sWFP8vLQRxvAEHPHjVjl5GexzADnjgDNlD5EWccfP88=;
 b=Ek+lCvC1Pk+zHvPTB1/8RkexeWJGetT0c4/+Yhn4ds2AXX/CLTMDWyh7
 n4SXY3crMmD+e/zVaI8zXh4v/J3gCRiOwMLluNBSPtFcPS1/bKJApiHXQ
 gf2L98n1A7YaFuJuiFFKD9cdfvr3PUlh5HuV/2QwWwfj3O6woWZrnV+yK
 6JHI6yW6CBi3q9goY2JuBqih0lMYty5CEQACKFNhqoKeKsIBA3N3e54v7
 dtySy2QYk2zVV73CGr3e4t0Y3XH1J3es09LF7wmUv78jnLrD+0uV2Q/JC
 ND+TDrqs7Db2WEEYKGT/9wB3LnUvM8wlfQDB+aJrGoF93N6DcJI20Xs6k A==;
X-CSE-ConnectionGUID: AiJpYZoQR16ueVmWuRLhtg==
X-CSE-MsgGUID: +xeJmsJ3TvuSTbF9AGDw4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64412855"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="64412855"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:20:53 -0800
X-CSE-ConnectionGUID: ODLWnrJoQF6S2IcZvaZAlw==
X-CSE-MsgGUID: P6V6rs9fQAGyYRYHgbHaQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="186901232"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:20:49 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 3/9] vfio/container-legacy: rename vfio_dma_unmap_bitmap()
 to vfio_legacy_dma_unmap_get_dirty_bitmap()
Date: Wed,  5 Nov 2025 23:20:20 -0500
Message-ID: <20251106042027.856594-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106042027.856594-1-zhenzhong.duan@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 8e9639603e..b7e3b892b9 100644
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


