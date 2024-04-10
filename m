Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8379DCD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSLe-0006Kx-IJ; Wed, 10 Apr 2024 03:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKn-0005Gu-Ec; Wed, 10 Apr 2024 03:25:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKe-0004FC-EB; Wed, 10 Apr 2024 03:25:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E1845D68A;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0386EB02CB;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191727 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 27/87] mirror: Don't call job_pause_point() under graph
 lock
Date: Wed, 10 Apr 2024 10:22:00 +0300
Message-Id: <20240410072303.4191455-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Calling job_pause_point() while holding the graph reader lock
potentially results in a deadlock: bdrv_graph_wrlock() first drains
everything, including the mirror job, which pauses it. The job is only
unpaused at the end of the drain section, which is when the graph writer
lock has been successfully taken. However, if the job happens to be
paused at a pause point where it still holds the reader lock, the writer
lock can't be taken as long as the job is still paused.

Mark job_pause_point() as GRAPH_UNLOCKED and fix mirror accordingly.

Cc: qemu-stable@nongnu.org
Buglink: https://issues.redhat.com/browse/RHEL-28125
Fixes: 004915a96a7a ("block: Protect bs->backing with graph_lock")
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240313153000.33121-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit ae5a40e8581185654a667fbbf7e4adbc2a2a3e45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/mirror.c b/block/mirror.c
index cd9d3ad4a8..abbddb39e4 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -479,9 +479,9 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
     return bytes_handled;
 }
 
-static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob *s)
+static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob *s)
 {
-    BlockDriverState *source = s->mirror_top_bs->backing->bs;
+    BlockDriverState *source;
     MirrorOp *pseudo_op;
     int64_t offset;
     /* At least the first dirty chunk is mirrored in one iteration. */
@@ -489,6 +489,10 @@ static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob *s)
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
     int max_io_bytes = MAX(s->buf_size / MAX_IN_FLIGHT, MAX_IO_BYTES);
 
+    bdrv_graph_co_rdlock();
+    source = s->mirror_top_bs->backing->bs;
+    bdrv_graph_co_rdunlock();
+
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
     offset = bdrv_dirty_iter_next(s->dbi);
     if (offset < 0) {
@@ -1078,9 +1082,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
                 mirror_wait_for_free_in_flight_slot(s);
                 continue;
             } else if (cnt != 0) {
-                bdrv_graph_co_rdlock();
                 mirror_iteration(s);
-                bdrv_graph_co_rdunlock();
             }
         }
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index e502787dd8..b4bc2e174b 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -503,7 +503,7 @@ void job_enter(Job *job);
  *
  * Called with job_mutex *not* held.
  */
-void coroutine_fn job_pause_point(Job *job);
+void coroutine_fn GRAPH_UNLOCKED job_pause_point(Job *job);
 
 /**
  * @job: The job that calls the function.
-- 
2.39.2


