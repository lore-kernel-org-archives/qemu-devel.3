Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F90CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVC7-00005m-KW; Sat, 13 Jun 2026 16:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVC3-0008MM-SK; Sat, 13 Jun 2026 16:43:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVC1-0005bO-4R; Sat, 13 Jun 2026 16:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382966; bh=sfQCC5CgFR1Bz1gV5P/NZ8E4hv3um15ceX7Klvs2YNc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lJqZ6w8jlo1qJUZvmbbk2GHb/pq+HVuKUbxb2zcSwPDO80gstlqeRt5DgIOFMnwnu
 mgAvt998JJW0GuK4e6xg5JnGds0q6fMvlUPB5dCJtMpely2GoZQpXq4Rbf2irn9VHH
 XtDPL7e5UH+AZhZs8NUv3cqwb5WSxNeANt1ouxfjhAos1bNC+m7pVzbf68KzMapGl4
 LTIZlqPnVLx1Oy7vPynS/5yxNbHmU34O3wYJhr9Yo3jeOnAGcBlfWHDoVX/iWlR6OA
 TneDhmYFeLeRfslHa8HbA6+J6N8BzSkzD2qOq3mKRxQiNi/61zr2Op7AJx//OUqr6j
 9rMsmjUnEUmSQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB9DF1B6F27;
 Sat, 13 Jun 2026 23:36:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3E9923CE970;
 Sat, 13 Jun 2026 23:36:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 68/72] qed: Don't try to flush during incoming
 migration
Date: Sat, 13 Jun 2026 23:35:34 +0300
Message-ID: <20260613203542.1809153-68-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabiano Rosas <farosas@suse.de>

It's not possible to access the image file while there is an incoming
migration in progress, the QEMU process doesn't hold any locks to the
storage at this point so nodes are inactive. Attempting to flush leads
to an assert at bdrv_co_write_req_prepare():

   assert(!(bs->open_flags & BDRV_O_INACTIVE))

The issue is reproducible by running iotest 181 on a host under cpu
load. The migration must coincide with the header already containing
the QED_F_NEED_CHECK flag.

The sequence of events is as follows, with the respective call stacks
referenced below:

During block device init, bdrv_qed_attach_aio_context() starts the
'need_check' timer. The timer will not fire during incoming migration
as it uses QEMU_CLOCK_VIRTUAL (to avoid this very issue, as the code
comment indicates).                                                   (0)

However, there's still bdrv_qed_drain_begin() which uses the fact that
the timer is live to decide whether to start the
qed_need_check_timer_entry() directly.                                (1)

The qed_need_check_timer_entry() eventually calls into
qed_write_header() -> bdrv_co_pwrite() leading to the assert.         (2)

Skip creating the 'need_check' timer whenever the image is inactive.

The stacks:

(0) == issues timer_mod ==
 #6  in qed_start_need_check_timer       at ../block/qed.c:340
 #7  in bdrv_qed_attach_aio_context      at ../block/qed.c:373
 #8  in bdrv_qed_do_open                 at ../block/qed.c:556
 #9  in bdrv_qed_open_entry              at ../block/qed.c:582
 #10 in coroutine_trampoline             at ../util/coroutine-ucontext.c:175
 #0  in qemu_coroutine_switch<+120>      at ../util/coroutine-ucontext.c:321
 #1  in qemu_aio_coroutine_enter<+356>   at ../util/qemu-coroutine.c:293
 #2  in aio_co_enter<+179>               at ../util/async.c:710
 #3  in aio_co_wake<+53>                 at ../util/async.c:695
 #4  in thread_pool_co_cb<+47>           at ../util/thread-pool.c:283
 #5  in thread_pool_completion_bh<+241>  at ../util/thread-pool.c:202
 #6  in aio_bh_call<+109>                at ../util/async.c:173
 #7  in aio_bh_poll<+299>                at ../util/async.c:220
 #8  in aio_poll<+690>                   at ../util/aio-posix.c:745
 #9  in bdrv_qed_open<+392>              at ../block/qed.c:607
 #10 in bdrv_open_driver<+327>           at ../block.c:1678
 #11 in bdrv_open_common<+1619>          at ../block.c:2008
 #12 in bdrv_open_inherit<+2556>         at ../block.c:4191
 #13 in bdrv_open<+118>                  at ../block.c:4286
 #14 in blk_new_open<+199>               at ../block/block-backend.c:458
 #15 in blockdev_init<+2011>             at ../blockdev.c:612
 #16 in drive_new<+3008>                 at ../blockdev.c:1008
 #17 in drive_init_func<+51>             at ../system/vl.c:662
 #18 in qemu_opts_foreach<+227>          at ../util/qemu-option.c:1148
 #19 in configure_blockdev<+350>         at ../system/vl.c:721
 #20 in qemu_create_early_backends<+343> at ../system/vl.c:2076
 #21 in qemu_init<+12483>                at ../system/vl.c:3778
 #22 in main<+46>                        at ../system/main.c:71

(1) == sees timer_pending ==
 #6  in bdrv_qed_drain_begin             at ../block/qed.c:391
 #7  in bdrv_do_drained_begin            at ../block/io.c:366
 #8  in bdrv_do_drained_begin_quiesce    at ../block/io.c:386
 #9  in bdrv_child_cb_drained_begin      at ../block.c:1207
 #10 in bdrv_parent_drained_begin_single at ../block/io.c:133
 #11 in bdrv_parent_drained_begin        at ../block/io.c:64
 #12 in bdrv_do_drained_begin            at ../block/io.c:364
 #13 in bdrv_drained_begin               at ../block/io.c:393
 #14 in blk_drain                        at ../block/block-backend.c:2101
 #15 in blk_unref                        at ../block/block-backend.c:544
 #16 in bdrv_open_inherit                at ../block.c:4197
 #17 in bdrv_open                        at ../block.c:4286
 #18 in blk_new_open                     at ../block/block-backend.c:458
 #19 in blockdev_init                    at ../blockdev.c:612
 #20 in drive_new                        at ../blockdev.c:1008
 #21 in drive_init_func                  at ../system/vl.c:662
 #22 in qemu_opts_foreach                at ../util/qemu-option.c:1148
 #23 in configure_blockdev               at ../system/vl.c:721
 #24 in qemu_create_early_backends       at ../system/vl.c:2076
 #25 in qemu_init                        at ../system/vl.c:3778
 #26 in main                             at ../system/main.c:71

(2) == crashes ==
 #5  in __assert_fail (assertion="!(bs->open_flags & BDRV_O_INACTIVE)", file="../block/io.c", line=1977
 #6  in bdrv_co_write_req_prepare  at ../block/io.c:1977
 #7  in bdrv_aligned_pwritev       at ../block/io.c:2099
 #8  in bdrv_co_pwritev_part       at ../block/io.c:2316
 #9  in bdrv_co_pwritev            at ../block/io.c:2233
 #10 in bdrv_co_pwrite             at ../include/block/block_int-io.h:77
 #11 in qed_write_header           at ../block/qed.c:128
 #12 in qed_need_check_timer       at ../block/qed.c:305
 #13 in qed_need_check_timer_entry at ../block/qed.c:319

Note that this issue is not exactly the same as what's been reported
in Gitlab, but given how easily this reproduces, I imagine it has to
be happening in that setup as well.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3515
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20260603193813.2327596-1-farosas@suse.de>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 7e573b660fefdebd21cb755d0d34bb5942fd3af3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qed.c b/block/qed.c
index da23a83d62..0eccfa21c9 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -351,16 +351,22 @@ static void bdrv_qed_detach_aio_context(BlockDriverState *bs)
 {
     BDRVQEDState *s = bs->opaque;
 
-    qed_cancel_need_check_timer(s);
-    timer_free(s->need_check_timer);
-    s->need_check_timer = NULL;
+    if (s->need_check_timer) {
+        qed_cancel_need_check_timer(s);
+        timer_free(s->need_check_timer);
+        s->need_check_timer = NULL;
+    }
 }
 
-static void bdrv_qed_attach_aio_context(BlockDriverState *bs,
-                                        AioContext *new_context)
+static void GRAPH_RDLOCK bdrv_qed_attach_aio_context(BlockDriverState *bs,
+                                                     AioContext *new_context)
 {
     BDRVQEDState *s = bs->opaque;
 
+    if (bdrv_is_inactive(bs)) {
+        return;
+    }
+
     s->need_check_timer = aio_timer_new(new_context,
                                         QEMU_CLOCK_VIRTUAL, SCALE_NS,
                                         qed_need_check_timer_cb, s);
-- 
2.47.3


