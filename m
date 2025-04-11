Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66499C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BVs-0002v0-6z; Fri, 11 Apr 2025 06:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVh-0002fG-KN
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:21 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u3BVe-0005O8-F9
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744366878; x=1775902878;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/rp/9HOUYDxv/ff9Y/ZSJzLtkR8kKGoMvG5rWR7Fdcw=;
 b=K6+Gx6IQSV8Vi/EVSVjna+MnezfkbQj4JZ2mpZNgsjaXjFbK27jtgnzJ
 pts+Zw9s29ZxqKQAD4k6kSu9kwx29sJTqGbmMxhTRdpypB0tE9Y1AG1NH
 ZGJ6PIQpxyyomoTvKZsVX8vxAX/uMHck4iCLmTsn/pLIE6yxrcRkr/Tz3
 zSY8XeRUe0aW46yufkjDUKYOZzstGo+ToOxAqe8ZiK3U/P8uJKe5CfY7K
 FpmIPge/pGx+LWIIVXzD3yilgpCRLLLI1ERjJPyVc8Orh16etA/fyXpZI
 DqejYfML0LkSctJPlVcylLFKy1t/AGM7+EOTPzo3V667To+DQ3KqKqqtR w==;
X-CSE-ConnectionGUID: JB5IziwcRmi95T6R9LWQLg==
X-CSE-MsgGUID: /gc5jUWFQpOuaA2moWJGMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="49566809"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="49566809"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:56 -0700
X-CSE-ConnectionGUID: xyN5YfHySWCyq4ci6QA5ow==
X-CSE-MsgGUID: azB28qqXSkWJAsDymj72cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; d="scan'208";a="133917420"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Apr 2025 03:20:54 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 4/5] backends/iommufd: Drop hiod_iommufd_get_cap()
Date: Fri, 11 Apr 2025 18:17:06 +0800
Message-Id: <20250411101707.3460429-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

Because sub-class TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO has it's own
implementation of .get_cap(), hiod_iommufd_get_cap() isn't used
any more, drop it.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 backends/iommufd.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index 54fa3174d0..d2ecdc9c82 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -311,28 +311,6 @@ bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
     return true;
 }
 
-static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
-{
-    HostIOMMUDeviceCaps *caps = &hiod->caps;
-
-    switch (cap) {
-    case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
-        return caps->type;
-    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
-        return vfio_device_get_aw_bits(hiod->agent);
-    default:
-        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
-        return -EINVAL;
-    }
-}
-
-static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
-{
-    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
-
-    hioc->get_cap = hiod_iommufd_get_cap;
-};
-
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
@@ -349,7 +327,6 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_IOMMUFD,
         .parent = TYPE_HOST_IOMMU_DEVICE,
-        .class_init = hiod_iommufd_class_init,
         .abstract = true,
     }
 };
-- 
2.34.1


