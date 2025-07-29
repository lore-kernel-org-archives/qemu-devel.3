Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877CBC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 09:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggXn-0007Nv-Ga; Tue, 29 Jul 2025 05:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXT-0005qs-BK
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:30 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXR-0002ij-34
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780945; x=1785316945;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AXrmHYltQ+34KQEUFHllopSmBCHR1BuTVqiDdFY5CWw=;
 b=KCa09p4RxBmrvUBun9akdVWjAACYivSHfFykI2uISH4VSgRBMoSXCjmy
 IspQrSx9HwI1u44f+NaYNPtD7tNnbsDuObBVqKNkJbL3bBK0WXeS7FQQq
 gPv2oo1XUhNpoIlmY9YnMziK8rbTPOhqznHuzG29kjS+pW8eZDzo3zN4W
 6f+oezn1lDVdXDRG/jLOSPR+thj9RJeB2bpvpTOC/U/ibVzBb4nHMkoyZ
 2ApQ2Cbb1jqv7DWO7DD8G4Oydtrlt3XxQYvgjuzF6Ow4EmDtcDNdniTaw
 fHstr+htxMPUmIUVCOuasiYMx+0riIesUIICVThhwBwCuytXhrlLnGdnN g==;
X-CSE-ConnectionGUID: h61G+FmcSa+hMKvonYXz8g==
X-CSE-MsgGUID: FG7JusIqQtyrAd4pN39Mpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55982028"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55982028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:22:24 -0700
X-CSE-ConnectionGUID: 8OUcVe9ZSH2fv2UwEXwWiw==
X-CSE-MsgGUID: DWEdWEtNRsqzNiTWeiKQzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691485"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:22:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 19/20] Workaround for ERRATA_772415_SPR17
Date: Tue, 29 Jul 2025 05:20:41 -0400
Message-ID: <20250729092043.785836-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on stage-2 page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.
https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/

Also copied the SPR17 details from above link:
"Problem: When remapping hardware is configured by system software in
scalable mode as Nested (PGTT=011b) and with PWSNP field Set in the
PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
Access bit if enabled) in first-stage page-table entries even when
second-stage mappings indicate that corresponding first-stage page-table
is Read-Only.

Implication: Due to this erratum, pages mapped as Read-only in second-stage
page-tables may be modified by remapping hardware Access/Dirty bit updates.

Workaround: None identified. System software enabling nested translations
for a VM should ensure that there are no read-only pages in the
corresponding second-stage mappings."

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 61a548f13f..8156d81488 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -325,6 +325,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
+    struct iommu_hw_info_vtd vtd;
     uint32_t type, flags = 0;
     uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
@@ -372,10 +373,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, &vtd, sizeof(vtd), &hw_caps,
+                                         errp)) {
         return false;
     }
 
+    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
+        container->bcontainer.bypass_ro = true;
+    }
+
     if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
-- 
2.47.1


