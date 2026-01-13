Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4117D29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfaqu-00032F-1Y; Tue, 13 Jan 2026 04:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaqm-0002lf-Tu
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfaql-0003SF-6B
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IDUPh26zh3fiGzx4uMZcMc1MoB7a7foGKvF9yAoVct8=;
 b=V7ZeNwu55g01PfB5wJ9zx/YVekhXVeku6rzUq+5eh8cIjvfT9GvK1A9I/CHcWlDeR3fJb4
 c30+cc7sss73U8whJSXVPWUgc8S7fUPh21A13Du17KwepPlu/5kCyC7DMhtXzKqcfD0lWa
 3cpGN/75l/atp2qso2iCk9Mfi5aGkoU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-XtCmZbIMO2ary7GXuBLq6A-1; Tue,
 13 Jan 2026 04:38:03 -0500
X-MC-Unique: XtCmZbIMO2ary7GXuBLq6A-1
X-Mimecast-MFC-AGG-ID: XtCmZbIMO2ary7GXuBLq6A_1768297082
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FA1B19560BB; Tue, 13 Jan 2026 09:38:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B18F930001A2; Tue, 13 Jan 2026 09:37:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Rohith S R <rohith.s.r@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/41] intel_iommu: Fix unmap_bitmap failure with legacy VFIO
 backend
Date: Tue, 13 Jan 2026 10:36:23 +0100
Message-ID: <20260113093637.1549214-28-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

If a VFIO device in guest switches from IOMMU domain to block domain,
vtd_address_space_unmap() is called to unmap whole address space.

If that happens during migration, migration fails with legacy VFIO
backend as below:

Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))

Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
ioctl fails. Normally such large UNMAP notification come from IOVA range
rather than system memory.

Apart from that, vtd_address_space_unmap() sends UNMAP notification with
translated_addr = 0, because there is no valid translated_addr for unmapping
a whole iommu memory region. This breaks dirty tracking no matter which VFIO
backend is used.

Fix them all by iterating over DMAMap list to unmap each range with active
mapping when global_dirty_tracking is active. global_dirty_tracking is
protected by BQL, so it's safe to reference it directly. If it's not active,
unmapping the whole address space in one go is optimal.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
Link: https://lore.kernel.org/qemu-devel/20251218062643.624796-7-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f971cdd14c78fd80df26c0f67d4abc8cfb35645d..bb21ae1743d2bf0dc91c4fc18026f449a290814b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4764,6 +4764,43 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     return flags;
 }
 
+/*
+ * There is no valid translated_addr for unmapping a whole iommu memory region.
+ * When dirty tracking is enabled, we need it to set dirty bitmaps. Iterate
+ * over DMAMap list to unmap each range with active mapping and translated_addr
+ * value.
+ */
+static void vtd_address_space_unmap_in_dirty_tracking(VTDAddressSpace *as,
+                                                      IOMMUNotifier *n)
+{
+    const DMAMap *map;
+    const DMAMap target = {
+        .iova = n->start,
+        .size = n->end,
+    };
+    IOVATree *tree = as->iova_tree;
+
+    /*
+     * DMAMap is created during IOMMU page table sync, it's either 4KB or huge
+     * page size and always a power of 2 in size. So the range of DMAMap could
+     * be used for UNMAP notification directly.
+     */
+    while ((map = iova_tree_find(tree, &target))) {
+        IOMMUTLBEvent event;
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+        event.entry.iova = map->iova;
+        event.entry.addr_mask = map->size;
+        event.entry.target_as = &address_space_memory;
+        event.entry.perm = IOMMU_NONE;
+        /* This field is needed to set dirty bigmap */
+        event.entry.translated_addr = map->translated_addr;
+        memory_region_notify_iommu_one(n, &event);
+
+        iova_tree_remove(tree, *map);
+    }
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4773,6 +4810,11 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     IntelIOMMUState *s = as->iommu_state;
     DMAMap map;
 
+    if (global_dirty_tracking) {
+        vtd_address_space_unmap_in_dirty_tracking(as, n);
+        return;
+    }
+
     /*
      * Note: all the codes in this function has a assumption that IOVA
      * bits are no more than VTD_MGAW bits (which is restricted by
-- 
2.52.0


