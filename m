Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAE7CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdDI-000191-3J; Mon, 08 Jun 2026 12:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdDH-00018d-6T
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdDE-0007US-Nn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780937552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kFatSLeHNba9Z+OqDy1gPE5uw+z+yLfNr64dou9P3L8=;
 b=hkQu55Ah0HGOTiUssOPYfT1s4RyxL5828ClUCulPsYwfGIYuHv1UEOndSQY8T3vGxPmRK8
 qBLoVCD7zNYqBqYs8TbkZJFW9L1r3LEV9CMmK3RyI/89om1p4NdKGO95wKO6yF7yYvBNMb
 3jN7wIZWZhLmgidaICBjbgj3RC+c6Ww=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-JlSEW41cMrOyhz5X9K09YA-1; Mon,
 08 Jun 2026 12:52:28 -0400
X-MC-Unique: JlSEW41cMrOyhz5X9K09YA-1
X-Mimecast-MFC-AGG-ID: JlSEW41cMrOyhz5X9K09YA_1780937547
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3600B180064A; Mon,  8 Jun 2026 16:52:27 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.50.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA63619540CD; Mon,  8 Jun 2026 16:52:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 8/8] qed: Don't try to flush during incoming migration
Date: Mon,  8 Jun 2026 18:52:07 +0200
Message-ID: <20260608165207.307488-9-kwolf@redhat.com>
In-Reply-To: <20260608165207.307488-1-kwolf@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/qed.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/qed.c b/block/qed.c
index da23a83d623..0eccfa21c98 100644
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
2.54.0


