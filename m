Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D436DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLKM-0005ve-PK; Tue, 04 Nov 2025 13:00:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFR-0001Ld-Qc
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFP-00074F-Vi
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmefoS00iD0l2Q3juNsgx+lS0LSZfmBCRBRzku/u+p0=;
 b=VHjC2GO3QwQjTFsYJdRL5SS9+1Nme6WM4IHPB3Gn2iukE/NK/6xldc7JxMFEYxobIwxRUP
 O+97ENM7+Z4mL0eNCNL6ZjCi7UN4U+gBrSMBZnDFg2F5Z2XrFHU5MFl6YyMQyyJpFTwh/i
 ZhN/xVae4/pnlBq3zm+NKIkQg13SCBQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-ZVt-u9xPNlOZeWIa1AJ6GA-1; Tue,
 04 Nov 2025 12:55:05 -0500
X-MC-Unique: ZVt-u9xPNlOZeWIa1AJ6GA-1
X-Mimecast-MFC-AGG-ID: ZVt-u9xPNlOZeWIa1AJ6GA_1762278904
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 049971956096; Tue,  4 Nov 2025 17:55:04 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B57CE1800451; Tue,  4 Nov 2025 17:55:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 22/27] qcow2: put discards in discard queue when
 discard-no-unref is enabled
Date: Tue,  4 Nov 2025 18:54:10 +0100
Message-ID: <20251104175415.525388-23-kwolf@redhat.com>
In-Reply-To: <20251104175415.525388-1-kwolf@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jean-Louis Dupond <jean-louis@dupond.be>

When discard-no-unref is enabled, discards are not queued like it
should.
This was broken since discard-no-unref was added.

Add a helper function qcow2_discard_cluster which handles some common
checks and calls the queue_discards function if needed to add the
discard request to the queue.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
Message-ID: <20250513132628.1055549-3-jean-louis@dupond.be>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h          |  4 ++++
 block/qcow2-cluster.c  | 16 ++++++----------
 block/qcow2-refcount.c | 17 +++++++++++++++++
 3 files changed, 27 insertions(+), 10 deletions(-)

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
-- 
2.51.1


