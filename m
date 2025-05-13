Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81068C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEpf1-0006Vw-NW; Tue, 13 May 2025 09:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpey-0006Uq-3p; Tue, 13 May 2025 09:27:04 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1uEpej-00073u-NK; Tue, 13 May 2025 09:27:02 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 9894A1520F81;
 Tue, 13 May 2025 15:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1747142803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKUlPURd0yKtXisyN/ucg5vGc32HVkh3h91cluIAy5U=;
 b=dpwdjC1kmqqOEJ4auM76kbG08lC57vGaECIpKV2vGfRLgCfPNxejito+DGmHsrlvqCesTe
 p2frapvner7tOTxnrpgP+GNf5bFngV27cpzaUY6QBV9H0JLx9XZlNNm4JYWKs+MXGH0R8x
 BX8Z2kSyiDhyShFsKl99+LXrfs3NVqE72gEWjXodTybMK7FWFS6QtFg9fjfXAXbddmLGtD
 rCAni9ZVctXtYkup3NLWqijFIUfzPljmV/9yRc/Lj0PXp2ZKhzcw/lcmjpYs4Hjyn2WEAD
 4Qt0Mb7XgBv3r94RbS+OKL/2QWFlD7WIG4QAj2EZ8Wef/qgKGl1nBlFeYjWKFg==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 2/2] qcow2: put discards in discard queue when
 discard-no-unref is enabled
Date: Tue, 13 May 2025 15:26:28 +0200
Message-ID: <20250513132628.1055549-3-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513132628.1055549-1-jean-louis@dupond.be>
References: <20250513132628.1055549-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 block/qcow2-refcount.c | 17 +++++++++++++++++
 block/qcow2.h          |  4 ++++
 3 files changed, 27 insertions(+), 10 deletions(-)

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
index 8fb210501c..6512cda407 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1205,6 +1205,23 @@ void qcow2_free_any_cluster(BlockDriverState *bs, uint64_t l2_entry,
     }
 }
 
+void qcow2_discard_cluster(BlockDriverState *bs, uint64_t offset,
+                           uint64_t length, QCow2ClusterType ctype,
+                           enum qcow2_discard_type dtype)
+{
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


