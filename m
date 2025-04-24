Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD6C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qDR-0005Z5-BE; Thu, 24 Apr 2025 02:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7qDP-0005Yk-Mb
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:37:44 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u7qDN-0007OW-Uy
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745476662; x=1777012662;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=052CSqqUsncSHlJwaSuZqbyQYDfJIFStG0WEIrI4/Yg=;
 b=bUs9GtS8jPYQ+V7+xdqEf1v4/khAQbjdwpK/2hULOpN3xNhAa+b0LqpO
 fFy2Sr0JAGWFw8iQ3LZZR7x1f1M+HwPv5hAIzWT0p+maC5xVlpeKZVFAe
 bylq+Bn7WlhKJ2y9v05BN7S37fV4xqxyEzwoDlM5MYyxP+XpZY/te/7DN
 1PHjfTSPz0e5LB/iRIj5mJmA8RFBtu55/tI/sjzEzSZ8B84V20fWHeeiu
 lHwxH9uOtHC9beeE/piDlTxNzhPlbZFbekOa25Ke3u1ucgYIwWXjTX/4m
 VHQN0WgvwkvLFXOtHZPDdvzh7tF43+rtYg4iWrwSaro30AWxr42aMvTmp w==;
X-CSE-ConnectionGUID: Xj4JKDKORdaOlMAUjiVEKw==
X-CSE-MsgGUID: 1MvteIXBT4ykzAOSDOzslw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58086045"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="58086045"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:37:39 -0700
X-CSE-ConnectionGUID: qZ1eD5mHTMappuG81xJ/2Q==
X-CSE-MsgGUID: xvGMOIaTTX+BEfzR6Tfacg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; d="scan'208";a="132831435"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2025 23:37:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, steven.sistare@oracle.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio: Register/unregister container for CPR only once for
 each container
Date: Thu, 24 Apr 2025 14:33:55 +0800
Message-Id: <20250424063355.3855174-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

vfio_cpr_register_container and vfio_cpr_unregister_container are container
scoped function. Calling them for each device attaching/detaching would
corrupt CPR reboot notifier list, i.e., when two VFIO devices are attached
to same container and have same notifier registered twice.

Fixes: d9fa4223b30a ("vfio: register container for cpr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
btw: untested as I have no env with two migration capable devices,
     appreciate if someone have env to help test, thanks

 hw/vfio/iommufd.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f24054a6a5..b2f72dc8c3 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -416,6 +416,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
     if (!QLIST_EMPTY(&bcontainer->device_list)) {
         return;
     }
+    vfio_cpr_unregister_container(bcontainer);
     vfio_listener_unregister(bcontainer);
     iommufd_backend_free_id(container->be, container->ioas_id);
     object_unref(container);
@@ -561,6 +562,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_listener_register;
     }
 
+    if (!vfio_cpr_register_container(bcontainer, errp)) {
+        goto err_listener_register;
+    }
+
     bcontainer->initialized = true;
 
 found_container:
@@ -570,13 +575,9 @@ found_container:
         goto err_listener_register;
     }
 
-    if (!vfio_cpr_register_container(bcontainer, errp)) {
-        goto err_listener_register;
-    }
-
     if (!vfio_device_hiod_create_and_realize(vbasedev,
                      TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO, errp)) {
-        goto err_hiod_realize;
+        goto err_listener_register;
     }
 
     /*
@@ -600,8 +601,6 @@ found_container:
                                    vbasedev->num_regions, vbasedev->flags);
     return true;
 
-err_hiod_realize:
-    vfio_cpr_unregister_container(bcontainer);
 err_listener_register:
     iommufd_cdev_ram_block_discard_disable(false);
 err_discard_disable:
@@ -632,7 +631,6 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
     }
 
     object_unref(vbasedev->hiod);
-    vfio_cpr_unregister_container(bcontainer);
     iommufd_cdev_detach_container(vbasedev, container);
     iommufd_cdev_container_destroy(container);
     vfio_address_space_put(space);
-- 
2.34.1


