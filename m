Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90971CCD193
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 02:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC7Fj-0004d8-6g; Thu, 23 Oct 2025 22:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fc-0004bo-8g
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:09:56 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vC7Fa-0006Ox-O6
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 22:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761271795; x=1792807795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=93oEgf+zdiZpD+biukGcjZo4Huny7L8LpmDi2MZ++qY=;
 b=j7M+pd18OnDp7TvFjoNftfYA+1IDrE6gcpOgtLDfqHP5UjooJWIHeYpf
 VvkiBR1BulSRbJe00GaeahLXY8Yu4CGrdS4knn281UvFZEX85uWVGUkTT
 ey0bayCGkxVyWBGgDweFRSkuKpGB4duTknrnAj12mkyR4162EozYB34+W
 FvOnG8WZQopN5fIWoueZonFdpbe3PR+u9hXyYVoBKMsMcXBW18hD4lDdj
 N85L2ZStl4wYPdg0aQuRc0AFroHu+IjraE6ysQ9WCvFhNivjT55p7SO4y
 p2Z795bi8hIFWoi034ydlMbWh0F+hdsvPEwdwOXsgJBxtjLM3jn6SPEWl Q==;
X-CSE-ConnectionGUID: 2CoMF3YeQRum2cfFKFueAA==
X-CSE-MsgGUID: hcUBVpYSQyuWIvZCXOB6OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62662143"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="62662143"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:09:52 -0700
X-CSE-ConnectionGUID: Q9jlzG/4Sa2OSRaaflcyfA==
X-CSE-MsgGUID: x/EZ7/rFTnCqMY7iRhbmCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="189440755"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 19:09:48 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
Date: Thu, 23 Oct 2025 22:09:16 -0400
Message-ID: <20251024020922.13053-3-zhenzhong.duan@intel.com>
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


