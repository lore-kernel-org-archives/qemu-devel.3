Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167CBE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 14:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsi6T-000409-4m; Wed, 18 Feb 2026 09:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6N-0003xa-Uh
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsi6L-0007Az-53
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 09:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771423224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/pA3ScU7INhBgfTMYS0saB19ICuaNzZtxc63hZ50S8=;
 b=a/a4q55ulErPitGaXKbZ9JFvHiNknN0r91aNJu5c5/PhLeKN6QU99LQ4h7CqCub6Qg1CRT
 JTDZ79JkZBgwti5oLyjuCPHqJm5p2JbtpDpFP04DSDWmzCzeX6BoXF3WbA1o3lTIzr3rkP
 3V7YP/LkP4Pqz6SVYa48JUxd8FlZXvg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-mV5Gc6TKMnmk-hbVsFJ8mg-1; Wed,
 18 Feb 2026 09:00:15 -0500
X-MC-Unique: mV5Gc6TKMnmk-hbVsFJ8mg-1
X-Mimecast-MFC-AGG-ID: mV5Gc6TKMnmk-hbVsFJ8mg_1771423213
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB74E195FDE7; Wed, 18 Feb 2026 14:00:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6C4B1956095; Wed, 18 Feb 2026 14:00:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/5] hw/vfio: sort and validate sparse mmap regions by offset
Date: Wed, 18 Feb 2026 15:00:00 +0100
Message-ID: <20260218140003.1554502-3-clg@redhat.com>
In-Reply-To: <20260218140003.1554502-1-clg@redhat.com>
References: <20260218140003.1554502-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Ankit Agrawal <ankita@nvidia.com>

Sort sparse mmap regions by offset during region setup to ensure
predictable mapping order, avoid overlaps and a proper handling
of the gaps between sub-regions.

Add validation to detect overlapping sparse regions early during
setup before any mapping operations begin.

The sorting is performed on the subregions ranges during
vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
mapping code can rely on subregions being in ascending offset order.

This is preparatory work for alignment adjustments needed to support
hugepfnmap on systems where device memory (e.g., Grace-based systems)
may have non-power-of-2 sizes.

cc: Alex Williamson <alex@shazbot.org>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260217153010.408739-2-ankita@nvidia.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/region.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ab39d77574ccef0ca8d393435979db97bcbd882b..8fbc98918f5f7c76c5e2f99956b54b96d0908fd6 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops = {
     },
 };
 
+static int vfio_mmap_compare_offset(const void *a, const void *b)
+{
+    const VFIOMmap *mmap_a = a;
+    const VFIOMmap *mmap_b = b;
+
+    if (mmap_a->offset < mmap_b->offset) {
+        return -1;
+    } else if (mmap_a->offset > mmap_b->offset) {
+        return 1;
+    }
+    return 0;
+}
+
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                           struct vfio_region_info *info)
 {
@@ -182,6 +195,35 @@ static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
     region->nr_mmaps = j;
     region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
 
+    /*
+     * Sort sparse mmaps by offset to ensure proper handling of gaps
+     * and predictable mapping order in vfio_region_mmap().
+     */
+    if (region->nr_mmaps > 1) {
+        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),
+              vfio_mmap_compare_offset);
+
+        /*
+         * Validate that sparse regions don't overlap after sorting.
+         */
+        for (i = 1; i < region->nr_mmaps; i++) {
+            off_t prev_end = region->mmaps[i - 1].offset +
+                             region->mmaps[i - 1].size;
+            if (prev_end > region->mmaps[i].offset) {
+                error_report("%s: overlapping sparse mmap regions detected "
+                             "in region %d: [0x%"PRIx64"-0x%"PRIx64"] overlaps "
+                             "with [0x%"PRIx64"-0x%"PRIx64"]",
+                             __func__, region->nr, region->mmaps[i - 1].offset,
+                             prev_end - 1, region->mmaps[i].offset,
+                             region->mmaps[i].offset + region->mmaps[i].size - 1);
+                g_free(region->mmaps);
+                region->mmaps = NULL;
+                region->nr_mmaps = 0;
+                return -EINVAL;
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -213,11 +255,13 @@ int vfio_region_setup(Object *obj, VFIODevice *vbasedev, VFIORegion *region,
 
             ret = vfio_setup_region_sparse_mmaps(region, info);
 
-            if (ret) {
+            if (ret == -ENODEV) {
                 region->nr_mmaps = 1;
                 region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
                 region->mmaps[0].offset = 0;
                 region->mmaps[0].size = region->size;
+            } else if (ret) {
+                return ret;
             }
         }
     }
-- 
2.53.0


