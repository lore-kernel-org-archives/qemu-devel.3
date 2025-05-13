Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67709C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeYk-0002Go-Q8; Mon, 12 May 2025 21:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYi-0002Ey-8J; Mon, 12 May 2025 21:35:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYg-00021Z-6k; Mon, 12 May 2025 21:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=t1AoeW5+yWy2YGfiL3VknobGzbBoiHSM2roimpSm4Xc=; b=FEhJgPZGgukQ
 aiUOT9l8c0zq61uLDwXRtl9hLV9N3DbJUjrsmvBvsApfN/5uH3iL7etV3cQN+SNAXTO79NrpVh4vP
 buUMblYHQ5Q6V4h29HS5GHgQiNVGc27MDNPsdu+IS1QSK5oNxmX7PQRZpP/nQ7N9h1P2m3xhJYFMh
 B3J4lzy8zDOBeewsDb75+JQa8FDBKa9BYgiB44gYEJPcgHgLydm6q1VJ27PSqR8HahsWq6jSRgt4C
 x4vJwKtPQ+RajpHMCFjrMDRN5MlJwxeoUSrggjN1KcfngrIcer84+MYzZT/jMtOBxQij48Q2Djvtc
 JWAHFojyFavTWkCY9W38pQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeUf-00DboQ-18; Tue, 13 May 2025 03:35:38 +0200
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 4/4] block/copy-before-write: report partial block status to
 snapshot
Date: Tue, 13 May 2025 03:32:38 +0200
Message-ID: <20250513013238.1213539-5-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

until the non-accessible area

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block/copy-before-write.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 5f5b3e7515..81d7f40b13 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -207,10 +207,11 @@ static int coroutine_fn GRAPH_RDLOCK cbw_co_flush(BlockDriverState *bs)
  */
 static BlockReq * coroutine_fn GRAPH_RDLOCK
 cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                       int64_t *pnum, BdrvChild **file)
+                       int64_t *pnum, BdrvChild **file, bool query)
 {
     BDRVCopyBeforeWriteState *s = bs->opaque;
     BlockReq *req = g_new(BlockReq, 1);
+    int64_t next_dirty;
     bool done;
 
     QEMU_LOCK_GUARD(&s->lock);
@@ -220,9 +221,13 @@ cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes) != -1) {
-        g_free(req);
-        return NULL;
+    next_dirty = bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes);
+    if (next_dirty != -1) {
+        if (!query || next_dirty == offset) {
+            g_free(req);
+            return NULL;
+        }
+        bytes = offset + bytes - next_dirty;
     }
 
     done = bdrv_dirty_bitmap_status(s->done_bitmap, offset, bytes, pnum);
@@ -270,7 +275,8 @@ cbw_co_preadv_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes,
     while (bytes) {
         int64_t cur_bytes;
 
-        req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &file);
+        req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &file,
+                                     false);
         if (!req) {
             return -EACCES;
         }
@@ -302,7 +308,7 @@ cbw_co_snapshot_block_status(BlockDriverState *bs,
     int64_t cur_bytes;
     BdrvChild *child;
 
-    req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &child);
+    req = cbw_snapshot_read_lock(bs, offset, bytes, &cur_bytes, &child, true);
     if (!req) {
         return -EACCES;
     }
-- 
2.43.0


