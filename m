Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB8AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCn-0004oB-7M; Mon, 24 Jun 2024 17:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCe-0004Vs-LB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCd-0006kK-0R
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I5Q9DDwwADFOIgEN65wvviElU7l4p2zecM8yB5Yl5I=;
 b=EfCBOSdNi9QaY6bXoamzK05AWV8U/+Gokj0D9p9l3bLRm8KjEM8NshitRBV9FaF6gCzCDP
 CsBsezMbXnNeaJdN4h34A7nNOCa9GjZ9B2YrB+ELJTmU1wMqmMdcjhM9CPcOjQr3uinicN
 vQDaBiHisy4g7wnmLsHKB5SKryGx5Bw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-pEjublzROTWxFpXS2uc3Bw-1; Mon,
 24 Jun 2024 17:26:16 -0400
X-MC-Unique: pEjublzROTWxFpXS2uc3Bw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FC661956086; Mon, 24 Jun 2024 21:26:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0342E1956051; Mon, 24 Jun 2024 21:26:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/42] vfio/common: Extract vIOMMU code from
 vfio_sync_dirty_bitmap()
Date: Mon, 24 Jun 2024 23:24:43 +0200
Message-ID: <20240624212456.350919-30-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Extract vIOMMU code from vfio_sync_dirty_bitmap() to a new function and
restructure the code.

This is done in preparation for optimizing vIOMMU device dirty page
tracking. No functional changes intended.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
[ clg: - Rebased on upstream
       - Fixed typo in commit log ]
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 63 +++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fe215918bdf66ddbe3c5db803e10ce1aa9756b90..f28641bad5cf4b71fcdc0a6c9d42b24c8d786248 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1302,37 +1302,50 @@ vfio_sync_ram_discard_listener_dirty_bitmap(VFIOContainerBase *bcontainer,
                                                 &vrdl);
 }
 
+static int vfio_sync_iommu_dirty_bitmap(VFIOContainerBase *bcontainer,
+                                        MemoryRegionSection *section)
+{
+    VFIOGuestIOMMU *giommu;
+    bool found = false;
+    Int128 llend;
+    vfio_giommu_dirty_notifier gdn;
+    int idx;
+
+    QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
+        if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
+            giommu->n.start == section->offset_within_region) {
+            found = true;
+            break;
+        }
+    }
+
+    if (!found) {
+        return 0;
+    }
+
+    gdn.giommu = giommu;
+    idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
+                                             MEMTXATTRS_UNSPECIFIED);
+
+    llend = int128_add(int128_make64(section->offset_within_region),
+                       section->size);
+    llend = int128_sub(llend, int128_one());
+
+    iommu_notifier_init(&gdn.n, vfio_iommu_map_dirty_notify, IOMMU_NOTIFIER_MAP,
+                        section->offset_within_region, int128_get64(llend),
+                        idx);
+    memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
+
+    return 0;
+}
+
 static int vfio_sync_dirty_bitmap(VFIOContainerBase *bcontainer,
                                   MemoryRegionSection *section, Error **errp)
 {
     ram_addr_t ram_addr;
 
     if (memory_region_is_iommu(section->mr)) {
-        VFIOGuestIOMMU *giommu;
-
-        QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
-            if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
-                giommu->n.start == section->offset_within_region) {
-                Int128 llend;
-                vfio_giommu_dirty_notifier gdn = { .giommu = giommu };
-                int idx = memory_region_iommu_attrs_to_index(giommu->iommu_mr,
-                                                       MEMTXATTRS_UNSPECIFIED);
-
-                llend = int128_add(int128_make64(section->offset_within_region),
-                                   section->size);
-                llend = int128_sub(llend, int128_one());
-
-                iommu_notifier_init(&gdn.n,
-                                    vfio_iommu_map_dirty_notify,
-                                    IOMMU_NOTIFIER_MAP,
-                                    section->offset_within_region,
-                                    int128_get64(llend),
-                                    idx);
-                memory_region_iommu_replay(giommu->iommu_mr, &gdn.n);
-                break;
-            }
-        }
-        return 0;
+        return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
     } else if (memory_region_has_ram_discard_manager(section->mr)) {
         int ret;
 
-- 
2.45.2


