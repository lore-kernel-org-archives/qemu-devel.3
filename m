Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87257CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:45:49 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdBE-0000Sh-Fb; Fri, 21 Nov 2025 21:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMczc-0004CK-FW; Fri, 21 Nov 2025 21:04:52 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcyq-0001W0-PI; Fri, 21 Nov 2025 21:04:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4770E16C718;
 Fri, 21 Nov 2025 16:51:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9EA013219B4;
 Fri, 21 Nov 2025 16:52:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Junyao Zhao <junzhao@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 63/76] =?UTF-8?q?rbd:=20Run=20co=20BH=20CB=20in=20?=
 =?UTF-8?q?the=20coroutine=E2=80=99s=20AioContext?=
Date: Fri, 21 Nov 2025 16:51:41 +0300
Message-ID: <20251121135201.1114964-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

qemu_rbd_completion_cb() schedules the request completion code
(qemu_rbd_finish_bh()) to run in the BDS’s AioContext, assuming that
this is the same thread in which qemu_rbd_start_co() runs.

To explain, this is how both latter functions interact:

In qemu_rbd_start_co():

    while (!task.complete)
        qemu_coroutine_yield();

In qemu_rbd_finish_bh():

    task->complete = true;
    aio_co_wake(task->co); // task->co is qemu_rbd_start_co()

For this interaction to work reliably, both must run in the same thread
so that qemu_rbd_finish_bh() can only run once the coroutine yields.
Otherwise, finish_bh() may run before start_co() checks task.complete,
which will result in the latter seeing .complete as true immediately and
skipping the yield altogether, even though finish_bh() still wakes it.

With multiqueue, the BDS’s AioContext is not necessarily the thread
start_co() runs in, and so finish_bh() may be scheduled to run in a
different thread than start_co().  With the right timing, this will
cause the problems described above; waking a non-yielding coroutine is
not good, as can be reproduced by putting e.g. a usleep(100000) above
the while loop in start_co() (and using multiqueue), giving finish_bh()
a much better chance at exiting before start_co() can yield.

So instead of scheduling finish_bh() in the BDS’s AioContext, schedule
finish_bh() in task->co’s AioContext.

In addition, we can get rid of task.complete altogether because we will
get woken exactly once, when the task is indeed complete, no need to
check.

(We could go further and drop the BH, running aio_co_wake() directly in
qemu_rbd_completion_cb() because we are allowed to do that even if the
coroutine isn’t yet yielding and we’re in a different thread – but the
doc comment on qemu_rbd_completion_cb() says to be careful, so I decided
not to go so far here.)

Buglink: https://issues.redhat.com/browse/RHEL-67115
Reported-by: Junyao Zhao <junzhao@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-3-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 89d22536d1a1715083ef8118fe7e6e9239f900c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/rbd.c b/block/rbd.c
index 3611dc81cf..2a70b5a983 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -110,9 +110,7 @@ typedef struct BDRVRBDState {
 } BDRVRBDState;
 
 typedef struct RBDTask {
-    BlockDriverState *bs;
     Coroutine *co;
-    bool complete;
     int64_t ret;
 } RBDTask;
 
@@ -1309,7 +1307,6 @@ static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
 static void qemu_rbd_finish_bh(void *opaque)
 {
     RBDTask *task = opaque;
-    task->complete = true;
     aio_co_wake(task->co);
 }
 
@@ -1326,7 +1323,7 @@ static void qemu_rbd_completion_cb(rbd_completion_t c, RBDTask *task)
 {
     task->ret = rbd_aio_get_return_value(c);
     rbd_aio_release(c);
-    aio_bh_schedule_oneshot(bdrv_get_aio_context(task->bs),
+    aio_bh_schedule_oneshot(qemu_coroutine_get_aio_context(task->co),
                             qemu_rbd_finish_bh, task);
 }
 
@@ -1338,7 +1335,7 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
                                           RBDAIOCmd cmd)
 {
     BDRVRBDState *s = bs->opaque;
-    RBDTask task = { .bs = bs, .co = qemu_coroutine_self() };
+    RBDTask task = { .co = qemu_coroutine_self() };
     rbd_completion_t c;
     int r;
 
@@ -1401,9 +1398,8 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
         return r;
     }
 
-    while (!task.complete) {
-        qemu_coroutine_yield();
-    }
+    /* Expect exactly a single wake from qemu_rbd_finish_bh() */
+    qemu_coroutine_yield();
 
     if (task.ret < 0) {
         error_report("rbd request failed: cmd %d offset %" PRIu64 " bytes %"
-- 
2.47.3


