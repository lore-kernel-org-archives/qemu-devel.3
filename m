Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44583CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7Fk-0004dP-RG; Thu, 23 Oct 2025 22:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fe-0004cP-5y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:09:58 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fc-0006Ox-MC
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761271796; x=1792807796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sWFP8vLQRxvAEHPHjVjl5GexzADnjgDNlD5EWccfP88=;
 b=N5SrT6PXx5b2vJ5iCtRVKbqpmqnO61kwFYWSxgvJ4/xCrpk0xHA7ZJFs
 Fk9x/IYvpos+5yqy4ViXG9GKb/+T0gG5WfHRzXCh5exXvzK/Kp9AR/Gqj
 /IBa5s4neninYFMVf0bzVWeB927vTtxBtzzBLmlSSe6+O4FN7dFBvii2+
 4UYeB/ascoUVs4RBy3HQsBeb/5WNgsqpjZ9z0zfLInxbF+Wsi6lJFiuvp
 1RQbRGMJLwB9oiLxhRIHlj33MEQJz2X52wZyHOWlA5rTUvZuMISBPa30g
 a5MViEECvJGRnSknaQV9AKohhe1FcAFi3nDXY7bT8qut/KGBF7jgK6Qmt Q==;
X-CSE-ConnectionGUID: kSvxJ6IXTNSYLrJbHOUcDQ==
X-CSE-MsgGUID: nC39orNkToq3SzLcuOl4XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62662146"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62662146"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:09:56 -0700
X-CSE-ConnectionGUID: CRteMhuxQHW8kcWrjCXKlg==
X-CSE-MsgGUID: MAwnCXCFQ2OUUvh3Y0crcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="189440761"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:09:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 3/8] vfio/container-legacy: rename vfio_dma_unmap_bitmap()
 to vfio_legacy_dma_unmap_get_dirty_bitmap()
Date: Thu, 23 Oct 2025 22:09:17 -0400
Message-ID: <20251024020922.13053-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024020922.13053-1-zhenzhong.duan@intel.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


