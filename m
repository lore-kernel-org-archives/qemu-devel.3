Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36842C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGh-0005uu-NE; Thu, 17 Jul 2025 05:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL1r-0002oS-Tq; Thu, 17 Jul 2025 05:35:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL1p-000267-ER; Thu, 17 Jul 2025 05:35:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 88FA0137CFC;
 Thu, 17 Jul 2025 12:34:05 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6BA5A2491F5;
 Thu, 17 Jul 2025 12:34:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Tingting Mao <timao@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 59/65] file-posix: Fix aio=threads performance
 regression after enablign FUA
Date: Thu, 17 Jul 2025 12:33:55 +0300
Message-ID: <20250717093412.728292-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

For aio=threads, we're currently not implementing REQ_FUA in any useful
way, but just do a separate raw_co_flush_to_disk() call. This changes
behaviour compared to the old state, which used bdrv_co_flush() with its
optimisations. As a quick fix, call bdrv_co_flush() again like before.
Eventually, we can use pwritev2() to make use of RWF_DSYNC if available,
but we'll still have to keep this code path as a fallback, so this fix
is required either way.

While the fix itself is a one-liner, some new graph locking annotations
are needed to convince TSA that the locking is correct.

Cc: qemu-stable@nongnu.org
Fixes: 984a32f17e8d ("file-posix: Support FUA writes")
Buglink: https://issues.redhat.com/browse/RHEL-96854
Reported-by: Tingting Mao <timao@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250625085019.27735-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d402da1360c2240e81f0e5fc80ddbfc6238e0da8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/file-posix.c b/block/file-posix.c
index 56d1972d15..796553bafd 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2484,9 +2484,9 @@ static inline bool raw_check_linux_aio(BDRVRawState *s)
 }
 #endif
 
-static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
-                                   uint64_t bytes, QEMUIOVector *qiov, int type,
-                                   int flags)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
+           QEMUIOVector *qiov, int type, int flags)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
@@ -2545,7 +2545,7 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr,
     ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
     if (ret == 0 && (flags & BDRV_REQ_FUA)) {
         /* TODO Use pwritev2() instead if it's available */
-        ret = raw_co_flush_to_disk(bs);
+        ret = bdrv_co_flush(bs);
     }
     goto out; /* Avoid the compiler err of unused label */
 
@@ -2580,16 +2580,16 @@ out:
     return ret;
 }
 
-static int coroutine_fn raw_co_preadv(BlockDriverState *bs, int64_t offset,
-                                      int64_t bytes, QEMUIOVector *qiov,
-                                      BdrvRequestFlags flags)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
+              QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_READ, flags);
 }
 
-static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
-                                       int64_t bytes, QEMUIOVector *qiov,
-                                       BdrvRequestFlags flags)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
+               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     return raw_co_prw(bs, &offset, bytes, qiov, QEMU_AIO_WRITE, flags);
 }
@@ -3525,10 +3525,11 @@ static int coroutine_fn raw_co_zone_mgmt(BlockDriverState *bs, BlockZoneOp op,
 #endif
 
 #if defined(CONFIG_BLKZONED)
-static int coroutine_fn raw_co_zone_append(BlockDriverState *bs,
-                                           int64_t *offset,
-                                           QEMUIOVector *qiov,
-                                           BdrvRequestFlags flags) {
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_zone_append(BlockDriverState *bs,
+                   int64_t *offset,
+                   QEMUIOVector *qiov,
+                   BdrvRequestFlags flags) {
     assert(flags == 0);
     int64_t zone_size_mask = bs->bl.zone_size - 1;
     int64_t iov_len = 0;
-- 
2.47.2


