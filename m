Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BBCC7EE2A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 06:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV2ie-00043v-4a; Fri, 27 Jun 2025 02:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uV2ib-00042w-CV
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 02:37:49 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uV2iR-0004JQ-0O
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 02:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751006259; x=1782542259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QWajAxQ6WbFSjERRP9f7w3D56c8UOqrg4mCWRJ3bApE=;
 b=XbWarh54S1o8TzGx+IM7K9likqC6Ts9IrYOBpzGK+O3G5UDzJ5ly/Twp
 9aUJJ5vyTogTwGTJDSNbdljK6z1FC4CSSuMLmu6/7UNwey4v9Ty6Kcxje
 V1NKYnR/tKpw85BFEV2VZFKV+STws3TiN4ALcriFSBB2SfMF8wBq/AR4H
 J0ZaG+8fTd0q8T0iyrzZjLvDVbqdFkHFX+s0tzvM7SV5o7GbEcL63qUlb
 sLw4XytRUEAPTAA0eGmH4MUUEA+GJh5q0/3tAdjemr6DkmB1moS0GitZr
 uiRZsv+lL0J4pDPHCiztvDxGo+9XOM4ETYkN/QI8OQIS9LaTNRPm6FkeP w==;
X-CSE-ConnectionGUID: FKMrKHPaRPCxWgv1Sb4Suw==
X-CSE-MsgGUID: 1YnYmMGtSpq6GDq6JB1NQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="40931463"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="40931463"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 23:37:30 -0700
X-CSE-ConnectionGUID: j4eZSO8DTkOf00NxTN+mXw==
X-CSE-MsgGUID: UsjDql2MR9eSs6r2d/a0oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; d="scan'208";a="153438113"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 23:37:28 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/2] vfio/container: Fix vfio_container_post_load()
Date: Fri, 27 Jun 2025 14:33:32 +0800
Message-Id: <20250627063332.5173-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250627063332.5173-1-zhenzhong.duan@intel.com>
References: <20250627063332.5173-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

When there are multiple VFIO containers, vioc->dma_map is restored
multiple times, this made only first container work and remaining
containers using vioc->dma_map restored by first container.

Fix it by save and restore vioc->dma_map locally. saved_dma_map in
VFIOContainerCPR becomes useless and is removed.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-cpr.h |  7 ++++---
 hw/vfio/cpr-legacy.c       | 23 +++++++++--------------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 8bf85b9f4e..dbb2a16b7a 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -16,14 +16,15 @@ struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 
+typedef int (*dma_map_fn)(const struct VFIOContainerBase *bcontainer,
+                          hwaddr iova, ram_addr_t size, void *vaddr,
+                          bool readonly, MemoryRegion *mr);
+
 typedef struct VFIOContainerCPR {
     Error *blocker;
     bool vaddr_unmapped;
     NotifierWithReturn transfer_notifier;
     MemoryListener remap_listener;
-    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
-                         hwaddr iova, ram_addr_t size,
-                         void *vaddr, bool readonly, MemoryRegion *mr);
 } VFIOContainerCPR;
 
 typedef struct VFIODeviceCPR {
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 0a5d1bd480..1216717546 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -99,20 +99,21 @@ static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
     VFIOContainerBase *bcontainer = &container->bcontainer;
-    VFIOGroup *group;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    dma_map_fn saved_dma_map = vioc->dma_map;
     Error *local_err = NULL;
 
+    /* During incoming CPR, divert calls to dma_map. */
+    vioc->dma_map = vfio_legacy_cpr_dma_map;
+
     if (!vfio_listener_register(bcontainer, &local_err)) {
         error_report_err(local_err);
         return -1;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    /* Restore original dma_map function */
+    vioc->dma_map = saved_dma_map;
 
-        /* Restore original dma_map function */
-        vioc->dma_map = container->cpr.saved_dma_map;
-    }
     return 0;
 }
 
@@ -148,6 +149,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
          */
 
         VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        dma_map_fn saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
 
         container->cpr.remap_listener = (MemoryListener) {
@@ -158,7 +160,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                  bcontainer->space->as);
         memory_listener_unregister(&container->cpr.remap_listener);
         container->cpr.vaddr_unmapped = false;
-        vioc->dma_map = container->cpr.saved_dma_map;
+        vioc->dma_map = saved_dma_map;
     }
     return 0;
 }
@@ -179,13 +181,6 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
-    /* During incoming CPR, divert calls to dma_map. */
-    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-    container->cpr.saved_dma_map = vioc->dma_map;
-    if (cpr_is_incoming()) {
-        vioc->dma_map = vfio_legacy_cpr_dma_map;
-    }
-
     migration_add_notifier_mode(&container->cpr.transfer_notifier,
                                 vfio_cpr_fail_notifier,
                                 MIG_MODE_CPR_TRANSFER);
-- 
2.34.1


