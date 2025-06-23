Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FC6C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeNv-00061x-Ul; Mon, 23 Jun 2025 06:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNu-0005yO-J4
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:42 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNr-0000l4-Lj
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750674399; x=1782210399;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JV8/tKIjtQekCcqphu512/XnCCpL9Gbwuue5YmsnoZE=;
 b=H3fzKKp7uBV73YoWDHwWqX4TQVEDX157B1vm6CGa8PDIZbftgJI2UfZ+
 UO+wxrcdjVLQzbK+b6FxV9f8jINgHP0P6kpuf56DDW6RLmV2oqxrRXfpq
 qye1TtBIWm6ur4etUqYQb/xY7DpveN0aINPQfuQbzM3QCKQvOW3ISqTvv
 IsiwQmX8V/SMYjM60+Sn197YQ9GwLTzH5re3e4UCcqVqMKqYOl+JDie/5
 EQqV+ZLOzq3GhLMNOyPTazgX1NMUeoxlD4m8dJKhORycgOsJ6iDwQc6oK
 iQFdiKu9E0YOhmiFSouMISD7/yNek99XQ34bIG/9sdNMwsT9ys2QYoIvH A==;
X-CSE-ConnectionGUID: SDhFbfwURb2DwhYmdVunmA==
X-CSE-MsgGUID: 9koHa9vRRYyQLYdkURqGXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63565469"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63565469"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:37 -0700
X-CSE-ConnectionGUID: cUj+0b/yS2uJRtiaPt8Leg==
X-CSE-MsgGUID: AB91I+O7Rs6X46vTeja4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="182427963"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:35 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 4/4] vfio/container: Fix vfio_container_post_load()
Date: Mon, 23 Jun 2025 18:22:35 +0800
Message-Id: <20250623102235.94877-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623102235.94877-1-zhenzhong.duan@intel.com>
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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
 include/hw/vfio/vfio-cpr.h |  1 -
 hw/vfio/cpr-legacy.c       | 20 +++++++-------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index aef542e93c..71a1c1a70c 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -25,7 +25,6 @@ typedef struct VFIOContainerCPR {
     bool vaddr_unmapped;
     NotifierWithReturn transfer_notifier;
     MemoryListener remap_listener;
-    DMA_MAP_FUNC saved_dma_map;
 } VFIOContainerCPR;
 
 typedef struct VFIODeviceCPR {
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 100a8db74d..ff45a5128f 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -99,20 +99,21 @@ static int vfio_container_post_load(void *opaque, int version_id)
 {
     VFIOContainer *container = opaque;
     VFIOContainerBase *bcontainer = &container->bcontainer;
-    VFIOGroup *group;
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    DMA_MAP_FUNC saved_dma_map = vioc->dma_map;
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
 
@@ -180,13 +181,6 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
 
     vmstate_register(NULL, -1, &vfio_container_vmstate, container);
 
-    /* During incoming CPR, divert calls to dma_map. */
-    if (cpr_is_incoming()) {
-        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-        container->cpr.saved_dma_map = vioc->dma_map;
-        vioc->dma_map = vfio_legacy_cpr_dma_map;
-    }
-
     migration_add_notifier_mode(&container->cpr.transfer_notifier,
                                 vfio_cpr_fail_notifier,
                                 MIG_MODE_CPR_TRANSFER);
-- 
2.34.1


