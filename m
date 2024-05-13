Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EECC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEP-00079y-3o; Mon, 13 May 2024 02:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEL-00075N-8H; Mon, 13 May 2024 02:32:13 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003wb-M9; Mon, 13 May 2024 02:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=oPxzXi4hUhHjLonu4tB66NolHJvGgEnJxgj0ggWpcq0=; b=wZpFCyTuSl4s
 piCBdLSmbwied4LZymhUgnA/ulB/Zei/28KtJjMwjXXyzhTl//JhWMowgAHJlnsBP1JiQwh/N1984
 V5gUhm6GNXllvcqwgMa4WqEtyfyFxss1sp19PKyYngI6xzH1lQ5smof6ns0tlXLMHnDkryLE+vWOP
 NPVwxDg/bM3whsUOp0pKaW3j5RWEEtA43bU8+ZSj9sW5+iSX+OAugy2SZ/sjLHz1wBxfCNC10IUrP
 XoQHuV9wj4CmFEwvBgIsE5qL895u/2oWTyOTfZn3/VOC+QtuGb9l55FSPKRng3xPlwGCQAidOB3Iq
 cf1kMAJuM6bhrd+6NK5Bjw==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-2r;
 Mon, 13 May 2024 08:31:57 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 08/11] qcow2: zeroize the entire cluster when there're no
 non-zero subclusters
Date: Mon, 13 May 2024 09:32:00 +0300
Message-Id: <20240513063203.113911-9-andrey.drobyshev@virtuozzo.com>
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

When zeroizing the last non-zero subclusters within single cluster, it
makes sense to go zeroize the entire cluster and go down zero_in_l2_slice()
path right away.  That way we'd also update the corresponding refcount
table.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2-cluster.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 475f167035..8d39e2f960 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2221,7 +2221,7 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
 
 static int coroutine_fn GRAPH_RDLOCK
 zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
-                    unsigned nb_subclusters)
+                    unsigned nb_subclusters, int flags)
 {
     BDRVQcow2State *s = bs->opaque;
     uint64_t new_l2_bitmap;
@@ -2237,6 +2237,16 @@ zero_l2_subclusters(BlockDriverState *bs, uint64_t offset,
     new_l2_bitmap |=  QCOW_OFLAG_SUB_ZERO_RANGE(sc, sc + nb_subclusters);
     new_l2_bitmap &= ~QCOW_OFLAG_SUB_ALLOC_RANGE(sc, sc + nb_subclusters);
 
+    /*
+     * If there're no non-zero subclusters left, we might as well zeroize
+     * the entire cluster.  That way we'd also update the refcount table.
+     */
+    if ((new_l2_bitmap & QCOW_L2_BITMAP_ALL_ZEROES) ==
+        QCOW_L2_BITMAP_ALL_ZEROES) {
+        return zero_in_l2_slice(bs, QEMU_ALIGN_DOWN(offset, s->cluster_size),
+                                1, flags);
+    }
+
     if (new_l2_bitmap != scri.l2_bitmap) {
         set_l2_bitmap(s, scri.l2_slice, scri.l2_index, new_l2_bitmap);
         qcow2_cache_entry_mark_dirty(s->l2_table_cache, scri.l2_slice);
@@ -2293,7 +2303,7 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
 
     if (head) {
         ret = zero_l2_subclusters(bs, offset - head,
-                                  size_to_subclusters(s, head));
+                                  size_to_subclusters(s, head), flags);
         if (ret < 0) {
             goto fail;
         }
@@ -2314,7 +2324,8 @@ int coroutine_fn qcow2_subcluster_zeroize(BlockDriverState *bs, uint64_t offset,
     }
 
     if (tail) {
-        ret = zero_l2_subclusters(bs, end_offset, size_to_subclusters(s, tail));
+        ret = zero_l2_subclusters(bs, end_offset,
+                                  size_to_subclusters(s, tail), flags);
         if (ret < 0) {
             goto fail;
         }
-- 
2.39.3


