Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DC0C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tqG-00018y-35; Mon, 06 May 2024 04:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3tpn-0000VB-2p; Mon, 06 May 2024 04:36:31 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3tpi-0000Ru-Qc; Mon, 06 May 2024 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714984587; x=1746520587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JA1zr7bDXQakmtRQdt8u/JTSoR2mM9qwyOaMt0dbu3o=;
 b=hagTO/ovCJP7esgtC+BOnHMow7RcRWEATZ+f7giJJAdnPkLGe+e84Hyl
 Z6+rqeHRvEm9DV7Z50+q301DVj5feh6lL6HDK5KbQILHidlc1IaU3/9Fe
 7+mMBG0U03/civhs8PbJ2HoZKlWTrAVO0wmKClQiBfgP5GIOpGqQPjOYh
 WfarKtoFPAFPuFJVpbo3v8P+S58Oo0iOchlytxTCzQbQIW9KTAqlfEYUi
 E/bi/4xxUY1T9kqIOKyxHaw1zEBO2ORqTpwIX0J26U9Ns/RqZWPWjzTks
 68OfxA44Hi1M2D6R5yIaBDZ+Yqew4Emy8B/pLjQUPUTdVJA8NhcridR26 Q==;
X-CSE-ConnectionGUID: dqK4wf3pTECd9XJjwjIWNQ==
X-CSE-MsgGUID: bWNajaGmRu+YyBACK8I7kw==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10647853"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="10647853"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:36:23 -0700
X-CSE-ConnectionGUID: zEdQ0UA0RMCKDjA6+53rNA==
X-CSE-MsgGUID: lgP9a8TxQYSFmLXUZy97pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28606576"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 01:36:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH 2/3] vfio: Make VFIOIOMMUClass::setup() return bool
Date: Mon,  6 May 2024 16:33:51 +0800
Message-Id: <20240506083352.4037226-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
References: <20240506083352.4037226-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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


