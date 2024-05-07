Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29330C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZt-0003MR-FA; Tue, 07 May 2024 02:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZp-0003Ai-Nm; Tue, 07 May 2024 02:45:25 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZn-0005Ee-Q9; Tue, 07 May 2024 02:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064323; x=1746600323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rWCmMnV1q1IK9J8/rklP7DJaZKe+3/GfmS6fjHmvrBA=;
 b=JId9YO+/RPhknLbN823AyIwejXWl6x+E5C+laLOEMA2eeAuDrpihZpA2
 r5WRdZcUnYy7RU/dC4vRV0dxKnAdnIMlO6OpBR3Z8tVP2dIsq0d1WXu0q
 zPml6da38RD0z4kaFvf7j45GUB1+FTFmk5Izz45P8Mw37eivdRXJypxwC
 J5Jk5xM25zgCVPtcUOYJ96XNVCYGeEOtCuN20SOW+2IIiVkbth7Pmv42q
 ldAvcaBrEioUxhF8y9zIayZxYJOp0aNikOfAsvjyk56+0E0Gpyt4p19uw
 j/j4LV99Zs76oeDbSJj7uIHtNa948qDyT+r5uj8740SfEkIpoIStIpVFQ w==;
X-CSE-ConnectionGUID: J5tzOFWfRTyoSFEoVIrsMQ==
X-CSE-MsgGUID: 5RLh7t2aQR2WqIPK9+CZfg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240241"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240241"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:22 -0700
X-CSE-ConnectionGUID: vqfwdyJnR8iKgsyowHcRHw==
X-CSE-MsgGUID: yKzcCdkRQ6yK5DQh3X1Nyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407522"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v2 04/11] vfio: Make VFIOIOMMUClass::setup() return bool
Date: Tue,  7 May 2024 14:42:45 +0800
Message-Id: <20240507064252.457884-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h |  2 +-
 hw/vfio/container.c                   | 10 +++++-----
 hw/vfio/spapr.c                       | 12 +++++-------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index c839cfd9cb..68539e3bed 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -111,7 +111,7 @@ struct VFIOIOMMUClass {
     InterfaceClass parent_class;
 
     /* basic feature */
-    int (*setup)(VFIOContainerBase *bcontainer, Error **errp);
+    bool (*setup)(VFIOContainerBase *bcontainer, Error **errp);
     int (*dma_map)(const VFIOContainerBase *bcontainer,
                    hwaddr iova, ram_addr_t size,
                    void *vaddr, bool readonly);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index ea3b145913..85a8a369dc 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -505,7 +505,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
-static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
+static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
@@ -515,7 +515,7 @@ static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     ret = vfio_get_iommu_info(container, &info);
     if (ret) {
         error_setg_errno(errp, -ret, "Failed to get VFIO IOMMU info");
-        return ret;
+        return false;
     }
 
     if (info->flags & VFIO_IOMMU_INFO_PGSIZES) {
@@ -531,7 +531,7 @@ static int vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
     vfio_get_info_iova_range(info, bcontainer);
 
     vfio_get_iommu_info_migration(container, info);
-    return 0;
+    return true;
 }
 
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
@@ -633,8 +633,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     assert(bcontainer->ops->setup);
 
-    ret = bcontainer->ops->setup(bcontainer, errp);
-    if (ret) {
+    if (!bcontainer->ops->setup(bcontainer, errp)) {
+        ret = -EINVAL;
         goto enable_discards_exit;
     }
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 0d949bb728..148b257c9c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -458,8 +458,8 @@ static void vfio_spapr_container_release(VFIOContainerBase *bcontainer)
     }
 }
 
-static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
-                                      Error **errp)
+static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
+                                       Error **errp)
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
@@ -480,7 +480,7 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         ret = ioctl(fd, VFIO_IOMMU_ENABLE);
         if (ret) {
             error_setg_errno(errp, errno, "failed to enable container");
-            return -errno;
+            return false;
         }
     } else {
         scontainer->prereg_listener = vfio_prereg_listener;
@@ -488,7 +488,6 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         memory_listener_register(&scontainer->prereg_listener,
                                  &address_space_memory);
         if (bcontainer->error) {
-            ret = -1;
             error_propagate_prepend(errp, bcontainer->error,
                     "RAM memory listener initialization failed: ");
             goto listener_unregister_exit;
@@ -500,7 +499,6 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
     if (ret) {
         error_setg_errno(errp, errno,
                          "VFIO_IOMMU_SPAPR_TCE_GET_INFO failed");
-        ret = -errno;
         goto listener_unregister_exit;
     }
 
@@ -527,13 +525,13 @@ static int vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
                           0x1000);
     }
 
-    return 0;
+    return true;
 
 listener_unregister_exit:
     if (v2) {
         memory_listener_unregister(&scontainer->prereg_listener);
     }
-    return ret;
+    return false;
 }
 
 static void vfio_iommu_spapr_class_init(ObjectClass *klass, void *data)
-- 
2.34.1


