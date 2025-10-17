Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37853CCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9fkA-00016K-AU; Fri, 17 Oct 2025 04:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9fk0-00012P-DQ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:23:13 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9fjp-0001D4-Rj
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 04:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760689382; x=1792225382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NBblPV8qhfIQ8dLU33306XjgXORx0k+B5vU5yzS/DOQ=;
 b=Yi2YtWS0lwkxQ+m++l3lssDjHHvoh4OhFNlfeMiFIuQAuuliXfBIqMV2
 pMt1LFEFHkIbldBYaEmsUBzJxsva6BWg5U4asDejvM7VUsxS+hBWvY+ww
 +TmVTnsCAeIecORj66jf40lHS2kuNel+R+uKodimX+KMrsrmBdkYhoezn
 /+nfj0M/0/DFh1m8uqZ7w8zGN8cZYwcPk2DXKCNMidrBxo84J/IW6AMDD
 fg6l3EsQRDKqWiLDJmImeEXDbGHxrXWRaPIqnXLyfS/+VDJ7CJOVWQBRC
 2cxlkdSMiuruT2HjHcfWNRgw3eCDcnqrfTFa4szHEKsyQpCspBbsiXTTr A==;
X-CSE-ConnectionGUID: H7ygdN/VTNaW6d/7JdnQ8Q==
X-CSE-MsgGUID: HMaeP5JCS8S2t2HiIF1Tyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="61927396"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="61927396"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 01:22:52 -0700
X-CSE-ConnectionGUID: efCdwgt2RmS5kHnd495NCA==
X-CSE-MsgGUID: a+GNPBusSL2Gy5ZkS5P5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182484681"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2025 01:22:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
Date: Fri, 17 Oct 2025 04:22:27 -0400
Message-ID: <20251017082234.517827-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251017082234.517827-1-zhenzhong.duan@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
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

When a existing mapping is unmapped, there could already be dirty bits
which need to be recorded before unmap.

If query dirty bitmap fails, we still need to do unmapping or else there
is stale mapping and it's risky to guest.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
---
 hw/vfio/iommufd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 976c0a8814..404e6249ca 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -74,7 +74,13 @@ static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
-            /* TODO: query dirty bitmap before DMA unmap */
+            ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
+                                                    iotlb->translated_addr,
+                                                    &local_err);
+            if (ret) {
+                error_report_err(local_err);
+            }
+            /* Unmap stale mapping even if query dirty bitmap fails */
             return iommufd_backend_unmap_dma(be, ioas_id, iova, size);
         }
 
-- 
2.47.1


