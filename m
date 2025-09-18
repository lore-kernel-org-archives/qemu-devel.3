Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2778DCAC59F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAV2-0004Xf-3k; Thu, 18 Sep 2025 05:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUy-0004On-MR
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:17 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uzAUn-0004kz-7G
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758186005; x=1789722005;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8LVkAItgk/Sc7pz7pxLa9UekS4TJEpBNLS4OC1thLEE=;
 b=GFsfTgaRs+of+Ml+hc+3awsRbfITYzk5GLQRMJ6S2N/uEeg/WDcrF4kl
 uLFyfsUqC3y2/vW1l8mxyCpImylS4ZzNUJQXgpU+rcw9Us+Zp6nf8nobt
 TbUfD07VJKW/NZfc0hHVHZgKFzK7SzwOE431DKN8rwE1MRLvP7/sLj4bF
 0pXSiztl7ECmelrwJl7SAUPI4CZlBNbqwLtyTX9fwHXOYj7bq9tB87yx+
 2L1dXU9rfEXOJVTfrozget+KrhJN2yq3fqEB95OYyc53htbSy8b3A5Am2
 VrtGOU9nDtFzKP+/kDQYpi9mBRiIfc8NLLuw4nhuCj8XShe6TL30ytVbZ A==;
X-CSE-ConnectionGUID: 8NV/2z99Ru+d3wm57BsYdw==
X-CSE-MsgGUID: rBTyEmQ9SpmOhH0VOWFFSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="78109600"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="78109600"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:52 -0700
X-CSE-ConnectionGUID: j1pStgd7RGKE/+by1K9VoQ==
X-CSE-MsgGUID: FonvCMUJRXKJXY7vm0zF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; d="scan'208";a="175930602"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2025 01:59:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 20/22] Workaround for ERRATA_772415_SPR17
Date: Thu, 18 Sep 2025 04:57:59 -0400
Message-ID: <20250918085803.796942-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250918085803.796942-1-zhenzhong.duan@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on second stage page table could still be written.

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
 hw/vfio/iommufd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f1684a39b7..5d25ce6f97 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -15,6 +15,7 @@
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
+#include "hw/iommu.h"
 #include "hw/vfio/vfio-device.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -326,6 +327,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
     uint32_t type, flags = 0;
     uint64_t hw_caps;
+    VendorCaps caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
     int ret;
@@ -371,7 +373,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * instead.
      */
     if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
-                                         &type, NULL, 0, &hw_caps, errp)) {
+                                         &type, &caps, sizeof(caps), &hw_caps,
+                                         errp)) {
         return false;
     }
 
@@ -386,6 +389,11 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      */
     if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
         flags |= IOMMU_HWPT_ALLOC_NEST_PARENT;
+
+        if (host_iommu_extract_vendor_caps(type, &caps) &
+            IOMMU_HW_NESTING_PARENT_BYPASS_RO) {
+            container->bcontainer.bypass_ro = true;
+        }
     }
 
     if (cpr_is_incoming()) {
-- 
2.47.1


