Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3A5C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEo-0007hS-5y; Mon, 13 May 2024 02:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEO-00079o-Qr; Mon, 13 May 2024 02:32:16 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003wZ-Io; Mon, 13 May 2024 02:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=0Jf2jPALHceBe2IkfT271nf146NNRsQrOmP4HbZZosc=; b=H10hXW+1w7od
 zHJNvbwjlHzulgjSaOy8cxWq6n9dU0FHkQCjhGRQnhs1ruT/9fxPibHfgIftbwyUkhbNPr399fB+A
 eqJBRNRjds6PLZEpaS7HN1v1REzXK/LeiH7OmmdO105WQmn3hHOD4v9u82yHT0tvUkvZO/Tfe12/a
 TaI8g7D/2J/kiNQ0GY51qxuUq+SuLWsiaF4vv9vSRc/v7/nsrwgBxzfRpDNVDXL9D5EW7aj93u1/8
 /VCFr+e4g4X4m91dnv/GyjzMM3yzbUSryWso687XZXfXS2xNF/jnT/UjHVSbE9+2mMQzFaSEeOcOL
 fwIfHH549HYp4WWQk3mSmw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-2C;
 Mon, 13 May 2024 08:31:56 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 03/11] qcow2: put discard requests in the common queue when
 discard-no-unref enabled
Date: Mon, 13 May 2024 09:31:55 +0300
Message-Id: <20240513063203.113911-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Normally discard requests are stored in the queue attached to BDRVQcow2State
to be processed later at once.  Currently discard-no-unref option handling
causes these requests to be processed straight away.  Let's fix that.

Note that when doing regular discards qcow2_free_any_cluster() would check
for the presence of external data files for us and redirect request to
underlying data_file.  Here we want to do the same but avoid refcount updates,
thus we perform the same checks.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 5f057ba2fd..7dff0bd5a1 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1893,6 +1893,28 @@ again:
     return 0;
 }
 
+/*
+ * Helper for adding a discard request to the queue without any refcount
+ * modifications.  If external data file is used redirects the request to
+ * the corresponding BdrvChild.
+ */
+static inline void
+discard_no_unref_any_file(BlockDriverState *bs, uint64_t offset,
+                          uint64_t length, QCow2ClusterType ctype,
+                          enum qcow2_discard_type dtype)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    if (s->discard_passthrough[dtype] &&
+        (ctype == QCOW2_CLUSTER_NORMAL || ctype == QCOW2_CLUSTER_ZERO_ALLOC)) {
+        if (has_data_file(bs)) {
+            bdrv_pdiscard(s->data_file, offset, length);
+        } else {
+            qcow2_queue_discard(bs, offset, length);
+        }
+    }
+}
+
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.e.
  * all clusters in the same L2 slice) and returns the number of discarded
@@ -1974,12 +1996,10 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
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
+            discard_no_unref_any_file(bs, old_l2_entry & L2E_OFFSET_MASK,
+                                      s->cluster_size, cluster_type, type);
         }
     }
 
@@ -2088,12 +2108,11 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
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
+                discard_no_unref_any_file(bs, old_l2_entry & L2E_OFFSET_MASK,
+                                          s->cluster_size, type,
+                                          QCOW2_DISCARD_REQUEST);
             }
         }
     }
-- 
2.39.3


