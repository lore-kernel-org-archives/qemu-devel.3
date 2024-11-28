Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8DBD70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQa-00074Z-FJ; Thu, 28 Nov 2024 13:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQN-0006zV-MZ; Thu, 28 Nov 2024 13:39:35 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060N-Jo; Thu, 28 Nov 2024 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=fk8PGJQHc/q4BIWFO0ftad01xvv3zgbb9jJTTEfmY/w=; b=Pw9ExQjRBGPv
 Kn1P/KK5HdgCpMk+Nwp3alqJL3iFBYXqfwv8B/qLQZR9GSBYI1aGLcas2aKtv5YGSXlmqnqt4xjv/
 RAnXcZsN9dD8/dSl/s/T/Qg5cFZOmwEZwDRS22fmdDQywssVhpD/q7PUX0XEXxismcg+zfhIbUUpb
 KJI8oSaUDnAWkq+PsUe01jDozvkK8OieKLD6SDVO6OHspyjLRqwIH5iIjVjcXBO5sYHrvp6jVuCVP
 EK03ij9UO4VJoLc4np80e5OMkLph7XDzOgNzDCMG5BXRF4aCNi3h/ErtDO2g9ECohWzSrFV4FuN+A
 kauMtxXGAKlzRSxOITf08w==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPp-00E2DN-0c;
 Thu, 28 Nov 2024 19:39:10 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 5/6] preallocate: simplify preallocate_drop_resize
Date: Thu, 28 Nov 2024 19:25:52 +0100
Message-ID: <20241128183911.837699-6-den@openvz.org>
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

Once permission change process is normalized, there is no need to have
permission update inside preallocate_drop_resize() and
preallocate_truncate_to_real_size() could be merged into the caller.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 block/preallocate.c | 36 ++----------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index c448258c42..886b1311f2 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -77,8 +77,6 @@ typedef struct BDRVPreallocateState {
      */
 } BDRVPreallocateState;
 
-static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
-
 #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
 #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
 static QemuOptsList runtime_opts = {
@@ -169,7 +167,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
 }
 
 static int GRAPH_RDLOCK
-preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
+preallocate_drop_resize(BlockDriverState *bs, Error **errp)
 {
     BDRVPreallocateState *s = bs->opaque;
     int ret;
@@ -198,7 +196,7 @@ static void preallocate_close(BlockDriverState *bs)
     GLOBAL_STATE_CODE();
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    preallocate_truncate_to_real_size(bs, NULL);
+    preallocate_drop_resize(bs, NULL);
 }
 
 
@@ -488,36 +486,6 @@ preallocate_co_getlength(BlockDriverState *bs)
     return bdrv_co_getlength(bs->file->bs);
 }
 
-static int GRAPH_RDLOCK
-preallocate_drop_resize(BlockDriverState *bs, Error **errp)
-{
-    BDRVPreallocateState *s = bs->opaque;
-    int ret;
-
-    if (s->data_end < 0) {
-        return 0;
-    }
-
-    /*
-     * Before switching children to be read-only, truncate them to remove
-     * the preallocation and let them have the real size.
-     */
-    ret = preallocate_truncate_to_real_size(bs, errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    /*
-     * We'll drop our permissions and will allow other users to take write and
-     * resize permissions (see preallocate_child_perm). Anyone will be able to
-     * change the child, so mark all states invalid. We'll regain control if a
-     * parent requests write access again.
-     */
-    bdrv_child_refresh_perms(bs, bs->file, NULL);
-
-    return 0;
-}
-
 static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     BdrvChildRole role, BlockReopenQueue *reopen_queue,
     uint64_t perm, uint64_t shared, uint64_t *nperm, uint64_t *nshared)
-- 
2.45.2


