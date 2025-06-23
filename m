Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4528BC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeNv-00060J-0v; Mon, 23 Jun 2025 06:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNr-0005xa-Fu
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:39 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTeNp-0000l4-FV
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750674397; x=1782210397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yr+7s6bCyo7u5kYfwpM0Ju13ecCPRGK8h7Rg4MDQSfo=;
 b=Svv0LQcoKQDqOsyT+Pi+w0EfZH81wbiZpftqDLxO9nGrpI+AasxtESjt
 ifkDOWjMZet9j+6P0wLPjw8IfHUdcWu40GGcsl5mwuCGpy44TSgO3vNY1
 e5TWO/G9n+6JQsWc44gGXzKK8syldhrg8GIrkZS4qlmE9tQIyxj5FS5BE
 2qhnlLpIpTmuOO0t2zFx36UGdvjig3Rpe4isw/Ko8htlJZyLBalGHz914
 vz5q0EzS5KEbj1zgebg+OZed7RkgQTsKu9DZZdW2iJBKYk8hyXOSjoKjJ
 FaZ6coruPjRqwZyCfmvvXzHeaRtcp4APpTpHMuumolSRqS/rnYveM5Ve3 Q==;
X-CSE-ConnectionGUID: s4N7/rkAS7Cjj87Ho+ChBQ==
X-CSE-MsgGUID: vRKklP2kSHaPmeMw1HpfCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="63565466"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="63565466"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:35 -0700
X-CSE-ConnectionGUID: WO350kWCQ4iXP3VsYRCxKg==
X-CSE-MsgGUID: KPKd2TP6TjWhrK3WTDys4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="182427954"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:26:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/4] vfio/container: Fix potential SIGSEGV when recover from
 unmap-all-vaddr failure
Date: Mon, 23 Jun 2025 18:22:34 +0800
Message-Id: <20250623102235.94877-4-zhenzhong.duan@intel.com>
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

cpr.saved_dma_map isn't initialized in source qemu which lead to vioc->dma_map
assigned a NULL value, this will trigger SIGSEGV.

Fix it by save and restore vioc->dma_map locally.

Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-cpr.h | 8 +++++---
 hw/vfio/cpr-legacy.c       | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 8bf85b9f4e..aef542e93c 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -16,14 +16,16 @@ struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
 
+typedef int (*DMA_MAP_FUNC)(const struct VFIOContainerBase *bcontainer,
+                            hwaddr iova, ram_addr_t size, void *vaddr,
+                            bool readonly, MemoryRegion *mr);
+
 typedef struct VFIOContainerCPR {
     Error *blocker;
     bool vaddr_unmapped;
     NotifierWithReturn transfer_notifier;
     MemoryListener remap_listener;
-    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
-                         hwaddr iova, ram_addr_t size,
-                         void *vaddr, bool readonly, MemoryRegion *mr);
+    DMA_MAP_FUNC saved_dma_map;
 } VFIOContainerCPR;
 
 typedef struct VFIODeviceCPR {
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index a84c3247b7..100a8db74d 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -148,6 +148,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
          */
 
         VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+        DMA_MAP_FUNC saved_dma_map = vioc->dma_map;
         vioc->dma_map = vfio_legacy_cpr_dma_map;
 
         container->cpr.remap_listener = (MemoryListener) {
@@ -158,7 +159,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
                                  bcontainer->space->as);
         memory_listener_unregister(&container->cpr.remap_listener);
         container->cpr.vaddr_unmapped = false;
-        vioc->dma_map = container->cpr.saved_dma_map;
+        vioc->dma_map = saved_dma_map;
     }
     return 0;
 }
-- 
2.34.1


