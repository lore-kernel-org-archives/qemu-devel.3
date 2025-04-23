Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43014C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uam-0006lZ-EO; Wed, 23 Apr 2025 03:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uag-0006iP-6s
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:18 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7Uad-0002Zo-2V
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745393535; x=1776929535;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vlFuPxsR6uS+fFiMpn/jKofj1bN5I++7yqnDWf8SOZY=;
 b=ktLazdBxvuneTY68dpMajfq03QNeR+wx60J4O4igbTX5GF8FBF3C7VG7
 /Dtnokn1LN3mJshTCOJ+aRKYKUMsLWg4/i4Yo1Oo0WtdyzHYB8xAt7Odf
 NF9stxkPUJDFrllfemKDMxoMpsFrXUnSPW8sT0wT5m2aMTJkL87moAZ+a
 ZHB4JBBMZh7XyJ3q4WAGyrFPYRB7BA+MhbjO7OCZYTu6LUgjSREaqxcYh
 TAzkmJN8CEezMEbUkZ0gKVDDY5yuOWXav/fVqhhBvqwwVNxDxPIiEFtQ5
 M1m2kVg5C2xVcNGA8rYf9NkyOSCl9kTTeazRp7k7P0BuhD4ivr4cZGPlM w==;
X-CSE-ConnectionGUID: tRSnw8O3QaWl6py5/YjtWQ==
X-CSE-MsgGUID: yZHA9dJzRYeqXglPY5F+QA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57959260"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="57959260"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:13 -0700
X-CSE-ConnectionGUID: f0EasS5qQTWMvzhA1zutwg==
X-CSE-MsgGUID: OVXgAzh3TuiVnZvzQL2BfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; d="scan'208";a="137025358"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 00:32:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Donald Dutile <ddutile@redhat.com>
Subject: [PATCH v2 2/5] vfio/iommufd: Move realize() after attachment
Date: Wed, 23 Apr 2025 15:28:21 +0800
Message-Id: <20250423072824.3647952-3-zhenzhong.duan@intel.com>
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

Previously device attaching depends on realize() getting host IOMMU
capabilities to check dirty tracking support.

Now we have a separate call to ioctl(IOMMU_GET_HW_INFO) to get host
IOMMU capabilities and check that for dirty tracking support, there
is no dependency any more, move realize() call after attachment
succeed.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Suggested-by: Donald Dutile <ddutile@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 2253778b3a..f273dc8712 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -500,17 +500,6 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
 
     space = vfio_address_space_get(as);
 
-    /*
-     * The HostIOMMUDevice data from legacy backend is static and doesn't need
-     * any information from the (type1-iommu) backend to be initialized. In
-     * contrast however, the IOMMUFD HostIOMMUDevice data requires the iommufd
-     * FD to be connected and having a devid to be able to successfully call
-     * iommufd_backend_get_device_info().
-     */
-    if (!vfio_device_hiod_realize(vbasedev, errp)) {
-        goto err_alloc_ioas;
-    }
-
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(bcontainer, &space->containers, next) {
         container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
@@ -585,6 +574,10 @@ found_container:
         goto err_listener_register;
     }
 
+    if (!vfio_device_hiod_realize(vbasedev, errp)) {
+        goto err_hiod_realize;
+    }
+
     /*
      * TODO: examine RAM_BLOCK_DISCARD stuff, should we do group level
      * for discarding incompatibility check as well?
@@ -606,6 +599,8 @@ found_container:
                                    vbasedev->num_regions, vbasedev->flags);
     return true;
 
+err_hiod_realize:
+    vfio_cpr_unregister_container(bcontainer);
 err_listener_register:
     iommufd_cdev_ram_block_discard_disable(false);
 err_discard_disable:
-- 
2.34.1


