Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB189C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEo-0007iV-CC; Mon, 13 May 2024 02:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEO-000799-51; Mon, 13 May 2024 02:32:16 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003wY-N0; Mon, 13 May 2024 02:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=cX31PH9jtDeIuw0XEzjsMlgVyqFrOzL4wkS6kSgnYr8=; b=Pdc2PB/pWR/g
 MyVEAYLuocbuhkIMKii/M9GgacX80f7c/wJ0YPY1+xoIlKH4rm9kT1wzIMRsT5xEjOv1sIa1/xdb/
 9bpNhUOfJq1TZmMOxJPR33jkT9QauOmWGvuHkZbDFAmbUvgHOxv3EMy1jWssPsoDhilDDef3VXP8e
 TLDemKwyFHrEU/koJXF/B03I4r5atvZZjy1KFUe76xUbO9YA41uylzj5tBoFAwedxN0/dHWmeqxTo
 9J+zzQr0ToLGjA0h7ap4Zs/vBjtsjU2Lfm2+JPV6bWz85p8z5ujQo5D2F3m59a1WmPEWn/qE4H872
 l6ufpY8aOce9K0jNVMNbMg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-2f;
 Mon, 13 May 2024 08:31:56 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 07/11] qcow2: add get_sc_range_info() helper for working
 with subcluster ranges
Date: Mon, 13 May 2024 09:31:59 +0300
Message-Id: <20240513063203.113911-8-andrey.drobyshev@virtuozzo.com>
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

This helper simply obtains the l2 table parameters of the cluster which
contains the given subclusters range.  Right now this info is being
obtained and used by zero_l2_subclusters().  As we're about to introduce
the subclusters discard operation, this helper would let us avoid code
duplication.

Also introduce struct SubClusterRangeInfo, which would contain all the
needed params.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 140 ++++++++++++++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 32 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 7dff0bd5a1..475f167035 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1915,6 +1915,103 @@ discard_no_unref_any_file(BlockDriverState *bs, uint64_t offset,
     }
 }
 
+/*
+ * Structure containing info about the subclusters range within one cluster.
+ *
+ * Since @l2_slice is a strong reference to the l2 table slice containing
+ * the corresponding l2 entry, it must be explicitly released by
+ * qcow2_cache_put().  Thus the user must either declare it with g_auto()
+ * (in which case sc_range_info_cleanup() is called automatically) or do
+ * the cleanup themselves.
+ */
+typedef struct SubClusterRangeInfo {
+    uint64_t *l2_slice;
+    int l2_index;
+    uint64_t l2_entry;
+    uint64_t l2_bitmap;
+    QCow2ClusterType ctype;
+    Qcow2Cache *l2_table_cache;
+} SubClusterRangeInfo;
+
+static void sc_range_info_cleanup(SubClusterRangeInfo *scri)
+{
+    if (scri->l2_table_cache && scri->l2_slice) {
+        qcow2_cache_put(scri->l2_table_cache, (void **) &scri->l2_slice);
+    }
+}
+
+G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(SubClusterRangeInfo, sc_range_info_cleanup);
+
+/*
+ * For a given @offset and @nb_subclusters, fill out the SubClusterRangeInfo
+ * structure describing the subclusters range and referred to by @scri.
+ * Only the subclusters which can be independently discarded/zeroized
+ * (i.e. not compressed or invalid) are considered to be valid here.
+ *
+ * The subclusters range is denoted by @offset and @nb_subclusters and must
+ * not cross the cluster boundary.  @offset must be aligned to the subcluster
+ * size.
+ *
+ * Return: 0 if the SubClusterRangeInfo is successfully filled out and the
+ * subclusters within the given range might be discarded/zeroized;
+ * -EINVAL if any of the subclusters within the range is invalid;
+ * -ENOTSUP if the range is contained within a compressed cluster.
+ */
+static int GRAPH_RDLOCK
+get_sc_range_info(BlockDriverState *bs, uint64_t offset,
+                  unsigned nb_subclusters, SubClusterRangeInfo *scri)
+{
+    BDRVQcow2State *s = bs->opaque;
+    int ret, sc_cleared, sc_index = offset_to_sc_index(s, offset);
+    QCow2SubclusterType sctype;
+
+    /* Here we only work with the subclusters within single cluster. */
+    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
+    assert(sc_index + nb_subclusters <= s->subclusters_per_cluster);
+    assert(offset_into_subcluster(s, offset) == 0);
+
+    scri->l2_table_cache = s->l2_table_cache;
+
+    ret = get_cluster_table(bs, offset, &scri->l2_slice, &scri->l2_index);
+    if (ret < 0) {
+        goto cleanup;
+    }
+
+    scri->l2_entry = get_l2_entry(s, scri->l2_slice, scri->l2_index);
+    scri->l2_bitmap = get_l2_bitmap(s, scri->l2_slice, scri->l2_index);
+    scri->ctype = qcow2_get_cluster_type(bs, scri->l2_entry);
+
+    sc_cleared = 0;
+    do {
+        ret = qcow2_get_subcluster_range_type(
+            bs, scri->l2_entry, scri->l2_bitmap, sc_index + sc_cleared,
+            &sctype);
+        if (ret < 0) {
+            goto cleanup;
+        }
+
+        switch (sctype) {
+        case QCOW2_SUBCLUSTER_COMPRESSED:
+            /* We cannot partially zeroize/discard compressed clusters. */
+            ret = -ENOTSUP;
+            goto cleanup;
+        case QCOW2_SUBCLUSTER_INVALID:
+            ret = -EINVAL;
+            goto cleanup;
+        default:
+            break;
+        }
+
+        sc_cleared += ret;
+    } while (sc_cleared < nb_subclusters);
+
+    return 0;
+
+cleanup:
+    sc_range_info_cleanup(scri);
+    return ret;
+}
+
 /*
  * This discards as many clusters of nb_clusters as possible at once (i.e.
  * all clusters in the same L2 slice) and returns the number of discarded
@@ -2127,46 +2224,25 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
                     unsigned nb_subclusters)
 {
     BDRVQcow2State *s = bs->opaque;
-    uint64_t *l2_slice;
-    uint64_t old_l2_bitmap, l2_bitmap;
-    int l2_index, ret, sc = offset_to_sc_index(s, offset);
-
-    /* For full clusters use zero_in_l2_slice() instead */
-    assert(nb_subclusters > 0 && nb_subclusters < s->subclusters_per_cluster);
-    assert(sc + nb_subclusters <= s->subclusters_per_cluster);
-    assert(offset_into_subcluster(s, offset) == 0);
+    uint64_t new_l2_bitmap;
+    int ret, sc = offset_to_sc_index(s, offset);
+    g_auto(SubClusterRangeInfo) scri = { 0 };
 
-    ret = get_cluster_table(bs, offset, &l2_slice, &l2_index);
+    ret = get_sc_range_info(bs, offset, nb_subclusters, &scri);
     if (ret < 0) {
         return ret;
     }
 
-    switch (qcow2_get_cluster_type(bs, get_l2_entry(s, l2_slice, l2_index))) {
-    case QCOW2_CLUSTER_COMPRESSED:
-        ret = -ENOTSUP; /* We cannot partially zeroize compressed clusters */
-        goto out;
-    case QCOW2_CLUSTER_NORMAL:
-    case QCOW2_CLUSTER_UNALLOCATED:
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    old_l2_bitmap = l2_bitmap = get_l2_bitmap(s, l2_slice, l2_index);
-
-    l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
-    l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap = scri.l2_bitmap;
+    new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
+    new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
 
-    if (old_l2_bitmap != l2_bitmap) {
-        set_l2_bitmap(s, l2_slice, l2_index, l2_bitmap);
-        qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
+    if (new_l2_bitmap != scri.l2_bitmap) {
+        set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
+        qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
     }
 
-    ret = 0;
-out:
-    qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
-
-    return ret;
+    return 0;
 }
 
 int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
-- 
2.39.3


