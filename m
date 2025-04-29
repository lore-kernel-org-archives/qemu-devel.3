Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BB5C3ABA9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 10:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9iFw-0000a4-N2; Tue, 29 Apr 2025 06:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u9iFk-0000Pp-BV; Tue, 29 Apr 2025 06:31:53 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u9iFh-0007QD-8S; Tue, 29 Apr 2025 06:31:52 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id D63B71520F5A;
 Tue, 29 Apr 2025 12:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1745922699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVp86qViDU7DDwyQQT2b4pbEQjMTBw9671dYZtNMZ+E=;
 b=c3knlpaqoyXpmOzLLWheMRQyB2m2yedq7VCrRlXmV9TzBotLh9834HhkcXHMMz7Qc0BrAp
 xYxVvwxBQGuwPKm+fvWs+2glT84iuCdvzSA7ocSRNB+jCd38xzu11S5IMDZiX5lv7uZ4m8
 tpVKLU6GRA631BU7niXZMo+3ph1QG4MS+G8kDdkWU6bOn4xblMwMtDhwHecx2wL9cCDJYw
 H/ngIDWsv/ftYCWvwf0ZA3YAtKnped1H48RwxNqueehvoUBnLtt8gHmWl6ALDtSQy9Ezvp
 NdBceixHGS+r2Sah0YaaQBLYDKpm7BxQIaSmDKUXLwnsmFxabgu62mmw+vzcDg==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 2/2] qcow2: put discards in discard queue when
 discard-no-unref is enabled
Date: Tue, 29 Apr 2025 12:31:10 +0200
Message-ID: <20250429103110.761910-3-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429103110.761910-1-jean-louis@dupond.be>
References: <20250429103110.761910-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When discard-no-unref is enabled, discards are not queued like it
should.
This was broken since discard-no-unref was added.

Add some helper function qcow2_discard_cluster which handles some common
checks and calls the queue_discards function if needed to add the
discard request to the queue.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2-cluster.c  | 16 ++++++----------
 block/qcow2-refcount.c | 19 ++++++++++++++++++-
 block/qcow2.h          |  4 ++++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ce8c0076b3..c655bf6df4 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1978,12 +1978,10 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
         if (!keep_reference) {
             /* Then decrease the refcount */
             qcow2_free_any_cluster(bs, old_l2_entry, type);
-        } else if (s->discard_passthrough[type] &&
-                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
-                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
+        } else {
             /* If we keep the reference, pass on the discard still */
-            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
-                          s->cluster_size);
+            qcow2_discard_cluster(bs, old_l2_entry & L2E_OFFSET_MASK,
+                                  s->cluster_size, cluster_type, type);
         }
     }
 
@@ -2092,12 +2090,10 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             if (!keep_reference) {
                 /* Then decrease the refcount */
                 qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
-            } else if (s->discard_passthrough[QCOW2_DISCARD_REQUEST] &&
-                       (type == QCOW2_CLUSTER_NORMAL ||
-                        type == QCOW2_CLUSTER_ZERO_ALLOC)) {
+            } else {
                 /* If we keep the reference, pass on the discard still */
-                bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
-                            s->cluster_size);
+                qcow2_discard_cluster(bs, old_l2_entry & L2E_OFFSET_MASK,
+                            s->cluster_size, type, QCOW2_DISCARD_REQUEST);
             }
         }
     }
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index d796018970..e1f830504d 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1205,6 +1205,23 @@ void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
     }
 }
 
+void qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
+                           uint64_t length, QCow2ClusterType ctype,
+                           enum qcow2_discard_type dtype) {
+
+    BDRVQcow2State *s = bs->opaque;
+
+    if (s->discard_passthrough[dtype] &&
+        (ctype == QCOW2_CLUSTER_NORMAL ||
+         ctype == QCOW2_CLUSTER_ZERO_ALLOC)) {
+        if (has_data_file(bs)) {
+            bdrv_pdiscard(s->data_file, offset, length);
+        } else {
+            queue_discard(bs, offset, length);
+        }
+    }
+}
+
 int qcow2_write_caches(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
@@ -3619,7 +3636,7 @@ qcow2_discard_refcount_block(BlockDriverState *bs, uint64_t discard_block_offs)
         /* discard refblock from the cache if refblock is cached */
         qcow2_cache_discard(s->refcount_block_cache, refblock);
     }
-    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
+    queue_discard(bs, discard_block_offs, s->cluster_size);
 
     return 0;
 }
diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..547bb2b814 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -880,6 +880,10 @@ void GRAPH_RDLOCK qcow2_free_clusters(BlockDriverState *bs,
 void GRAPH_RDLOCK
 qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
                        enum qcow2_discard_type type);
+void GRAPH_RDLOCK
+qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
+                      uint64_t length, QCow2ClusterType ctype,
+                      enum qcow2_discard_type dtype);
 
 int GRAPH_RDLOCK
 qcow2_update_snapshot_refcount(BlockDriverState *bs, int64_t l1_table_offset,
-- 
2.49.0


