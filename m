Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5473CCFA1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 04:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGrUU-0006be-5S; Wed, 05 Nov 2025 23:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUS-0006bG-B5
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:20:52 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUQ-0000oW-QC
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762402850; x=1793938850;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=93oEgf+zdiZpD+biukGcjZo4Huny7L8LpmDi2MZ++qY=;
 b=BhbK0WYIYm11OZnIZcGC2/lNvpjLdowHoJBjxzdVa+PRo5d53id01kvB
 3XWobfl+uaEsqGtQg/yfsQCat6KEdT8rO/z+vpmtxnyGEU3H4LH7F8rvO
 YIFafMRbnWvOQ6N7FqUmEVGcPFwPSM1hjsG7e9jnamxZjh3sqpItfCVRv
 QCUcJWlgmu4uu1vmr9glUDfka/zYo8eXL4zuHcjarDyH0ZKpL6PJsNJpe
 B7dxSD7Q3JUizOVEapdduDxtSkpf1mRdhblf+Lbk0Ho2mm+ElVammPOgk
 wu/bIhlYf07xLUh+BdbMziXgmmm8bY/Nm83OYSQGItgF6FopzvGLrs/QU Q==;
X-CSE-ConnectionGUID: 9xsFNbCbT5iOmTjIE+jCrQ==
X-CSE-MsgGUID: v7ThuxbnSuSbgOBIal+NPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64412854"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="64412854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:20:49 -0800
X-CSE-ConnectionGUID: ytz2ZX6LTTylw1RE7vdD8w==
X-CSE-MsgGUID: CWKSwFI5Rui4bcPbQnMYEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="186901227"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:20:45 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 2/9] vfio/iommufd: Query dirty bitmap before DMA unmap
Date: Wed,  5 Nov 2025 23:20:19 -0500
Message-ID: <20251106042027.856594-3-zhenzhong.duan@intel.com>
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

When an existing mapping is unmapped, there could already be dirty bits
which need to be recorded before unmap.

If query dirty bitmap fails, we still need to do unmapping or else there
is stale mapping and it's risky to guest.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 hw/vfio/iommufd.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 806ca6ef14..5f96a41246 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -65,7 +65,7 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     uint32_t ioas_id = container->ioas_id;
     bool need_dirty_sync = false;
     Error *local_err = NULL;
-    int ret;
+    int ret, unmap_ret;
 
     if (unmap_all) {
         size = UINT64_MAX;
@@ -74,8 +74,21 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            /* TODO: query dirty bitmap before DMA unmap */
-            return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                    iotlb->translated_addr,
+                                                    &local_err);
+            if (ret) {
+                error_report_err(local_err);
+            }
+            /* Unmap stale mapping even if query dirty bitmap fails */
+            unmap_ret = iommufd_backend_unmap_dma(be, ioas_id, iova, size);
+
+            /*
+             * If dirty tracking fails, return the failure to VFIO core to
+             * fail the migration, or else there will be dirty pages missed
+             * to be migrated.
+             */
+            return unmap_ret ? : ret;
         }
 
         need_dirty_sync = true;
-- 
2.47.1


