Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC4EC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uao-0006lf-BK; Wed, 23 Apr 2025 03:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uae-0006hL-Qn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:18 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uaa-0002ZR-SX
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745393533; x=1776929533;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u+2cGN1zU/fzkVglkVzbTSwTA1wbMtXgxYloe7qprfY=;
 b=eyj9D9OmHN7BkuKMu07kBoslBLrQGmGE9dujsK8eJMjiqbhR/3Qu9/m3
 sadFhB4uX6KskXQtDKaOu/5z6dMqwRADNXdu0w2I6Kbzt9fYWx3dSAOdH
 0ty4rDxna1VwoAXblNAj5cBsHaokfe94aXp8Y5aclCv6VFTwOmRtFFrMK
 e92RE7uptVpgr/1UYwBYpsjSVjX4mFE+ZSec+SfCW6oVkAwOxb7KFZSGg
 Pbk87wv+fKHFsQLT0+HiIj71DOtS2PQmH5C44Qs6VAGkfyrUySxG89mCS
 YVnG8ylqx983MZBmAqvYylwgz6cWBzfbPWLg+r+8Qv68CrRmmWmRAevJH A==;
X-CSE-ConnectionGUID: 3VzTu2smRdiyaMKJQ1Wy6w==
X-CSE-MsgGUID: sFM+s9fxQy20Ck3vzdqGJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57959256"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57959256"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:10 -0700
X-CSE-ConnectionGUID: WynLjN95Q/6Vq5lpW53SKw==
X-CSE-MsgGUID: SZZSqiYVTWSzUiJABjxiWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137025341"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:08 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/5] vfio/iommufd: Make a separate call to get IOMMU
 capabilities
Date: Wed, 23 Apr 2025 15:28:20 +0800
Message-Id: <20250423072824.3647952-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
References: <20250423072824.3647952-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

Currently we depend on .realize() calling iommufd_backend_get_device_info()
to get IOMMU capabilities and check for dirty page tracking support.

By make a extra separate call, this dependency is removed. This happens
only during device attach, it's not a hot path.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48db105422..2253778b3a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -287,7 +287,8 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
 {
     ERRP_GUARD();
     IOMMUFDBackend *iommufd = vbasedev->iommufd;
-    uint32_t flags = 0;
+    uint32_t type, flags = 0;
+    uint64_t hw_caps;
     VFIOIOASHwpt *hwpt;
     uint32_t hwpt_id;
     int ret;
@@ -324,7 +325,12 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
      * vfio_migration_realize() may decide to use VF dirty tracking
      * instead.
      */
-    if (vbasedev->hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
+    if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
+                                         &type, NULL, 0, &hw_caps, errp)) {
+        return false;
+    }
+
+    if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
         flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
     }
 
-- 
2.34.1


