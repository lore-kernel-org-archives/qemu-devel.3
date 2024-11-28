Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5155FD70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQU-00072l-KK; Thu, 28 Nov 2024 13:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQN-0006zY-Na; Thu, 28 Nov 2024 13:39:35 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060I-G1; Thu, 28 Nov 2024 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=xrg7ndqG9+Oki7uB+Q6dALsj7L6NNtOivee5Srln6YM=; b=Mn4PwxBUan3S
 WSefy3p3bE6Iu2r3m3V3McF0ol02uqTk6FyiO/T/YTwj50vWtxHMfcgaju/18Xqm7SzZ7YMsU/ks2
 V1VfF9nUQXhx4BLu6dBg4d9ht/22rdq6PVwd/73MLoIJx/YxoZknOZcsEHhC3BCixWFDRqIEsLhrR
 eUa8ByeS+Ab2zG5qGX0V9PEDnzaOZ1v9LqTek6ETAdXlOgECoB5aFK0vgVt0kQ6xYOvvj/MGeG1wK
 /FdYZNpf5pNs89a9pTm5n5SYBpkxeXzrLqkcEbix78jK46/IQa+7vn4O+7ipiYkzMx0tIZBhzg3Io
 +qTtMiihwcA00x89wWWWeA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPo-00E2DN-2s;
 Thu, 28 Nov 2024 19:39:10 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 4/6] preallocate: remove bottom half from preallocate filter
Date: Thu, 28 Nov 2024 19:25:51 +0100
Message-ID: <20241128183911.837699-5-den@openvz.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128183911.837699-1-den@openvz.org>
References: <20241128183911.837699-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

IO operations like truncate inside preallocate_set_perm() looks like
insane complexity which should not seen in the reality.

Preallocate filter lifecycle is very close to the lifecycle of CBT.
This is well handled inside QCOW2 driver. The approach should be the
same inside preallocation filter. It should be enough to be handled
inside preallocate_reopen_prepare() and preallocate_inactivate().

There is no more need to have preallocate_set_perm() and
preallocate_child_perm() perms.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/preallocate.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 65c1ff5d78..c448258c42 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -75,13 +75,9 @@ typedef struct BDRVPreallocateState {
      * be invalid (< 0) when we don't have both exclusive BLK_PERM_RESIZE and
      * BLK_PERM_WRITE permissions on file child.
      */
-
-    /* Gives up the resize permission on children when parents don't need it */
-    QEMUBH *drop_resize_bh;
 } BDRVPreallocateState;
 
 static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
-static void preallocate_drop_resize_bh(void *opaque);
 
 #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
 #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
@@ -150,7 +146,6 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
      * For this to work, mark them invalid.
      */
     s->file_end = s->zero_start = s->data_end = -EINVAL;
-    s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
@@ -200,14 +195,9 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
 
 static void preallocate_close(BlockDriverState *bs)
 {
-    BDRVPreallocateState *s = bs->opaque;
-
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    qemu_bh_cancel(s->drop_resize_bh);
-    qemu_bh_delete(s->drop_resize_bh);
-
     preallocate_truncate_to_real_size(bs, NULL);
 }
 
@@ -528,34 +518,6 @@ preallocate_drop_resize(BlockDriverState *bs, Error **errp)
     return 0;
 }
 
-static void preallocate_drop_resize_bh(void *opaque)
-{
-    GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
-
-    /*
-     * In case of errors, we'll simply keep the exclusive lock on the image
-     * indefinitely.
-     */
-    preallocate_drop_resize(opaque, NULL);
-}
-
-static void GRAPH_RDLOCK
-preallocate_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
-{
-    BDRVPreallocateState *s = bs->opaque;
-
-    if (can_write_resize(perm)) {
-        qemu_bh_cancel(s->drop_resize_bh);
-        if (s->data_end < 0) {
-            s->data_end = s->file_end = s->zero_start =
-                bs->file->bs->total_sectors * BDRV_SECTOR_SIZE;
-        }
-    } else {
-        qemu_bh_schedule(s->drop_resize_bh);
-    }
-}
-
 static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     BdrvChildRole role, BlockReopenQueue *reopen_queue,
     uint64_t perm, uint64_t shared, uint64_t *nperm, uint64_t *nshared)
@@ -604,7 +566,6 @@ static BlockDriver bdrv_preallocate_filter = {
     .bdrv_co_flush = preallocate_co_flush,
     .bdrv_co_truncate = preallocate_co_truncate,
 
-    .bdrv_set_perm = preallocate_set_perm,
     .bdrv_child_perm = preallocate_child_perm,
 
     .bdrv_inactivate = preallocate_inactivate,
-- 
2.45.2


