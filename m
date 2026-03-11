Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2970112583F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LAS-0005PA-0q; Wed, 11 Mar 2026 11:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L7j-00008P-8t; Wed, 11 Mar 2026 11:05:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L7c-0004Zp-8J; Wed, 11 Mar 2026 11:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241305; bh=IWzwU49V5a1A0MEg9tth+bQYl9/AuKMtjnmErL6ohqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BHvDwdqR/FbAMvohnpSMYGtY7UvVKnGd8xUPAENnuYmFdjF8Em6eFC2ejA9VNxp73
 HrzkruMTYL4T5BmSeimrzA73HD3Gm3X2R7pmF66bXPpaG63MWvgBguPh7zrQsmIFTo
 ql3xmST2+wX2Dr84N3cVOoOty+IdQ75QvfmB3WgeK+wEW1HzKb32Doo/LKE1jqXJOx
 NykhDtP304+sPdOe6rAl5vuuPXx5+13t3jbsYajXo6upSmRQ6LnU1MfCnm7lEYTVTo
 JKfnEwxavroVIe1fcvVgzjw85jazdTygGB0FBsN/eLsC+jsj4LC6PjU1sPF/mh9QHv
 jOHc+55stAhMw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C3C5F191E5F;
 Wed, 11 Mar 2026 18:01:45 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AF9DB37C2B1;
 Wed, 11 Mar 2026 18:02:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Guryanov <dmitry.guryanov@gmail.com>,
 Hanna Czenczek <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 33/44] block/throttle-groups: fix deadlock with
 iolimits and muliple iothreads
Date: Wed, 11 Mar 2026 18:02:05 +0300
Message-ID: <20260311150221.1084186-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Dmitry Guryanov <dmitry.guryanov@gmail.com>

Details: https://gitlab.com/qemu-project/qemu/-/issues/3144

The function schedule_next_request is called with tg->lock held and
it may call throttle_group_co_restart_queue, which takes
tgm->throttled_reqs_lock, qemu_co_mutex_lock may leave current
coroutine if other iothread has taken the lock. If the next
coroutine will call throttle_group_co_io_limits_intercept - it
will try to take the mutex tg->lock which will never be released.

Here is the backtrace of the iothread:
Thread 30 (Thread 0x7f8aad1fd6c0 (LWP 24240) "IO iothread2"):
 #0  futex_wait (futex_word=0x5611adb7d828, expected=2, private=0) at ../sysdeps/nptl/futex-internal.h:146
 #1  __GI___lll_lock_wait (futex=futex@entry=0x5611adb7d828, private=0) at lowlevellock.c:49
 #2  0x00007f8ab5a97501 in lll_mutex_lock_optimized (mutex=0x5611adb7d828) at pthread_mutex_lock.c:48
 #3  ___pthread_mutex_lock (mutex=0x5611adb7d828) at pthread_mutex_lock.c:93
 #4  0x00005611823f5482 in qemu_mutex_lock_impl (mutex=0x5611adb7d828, file=0x56118289daca "../block/throttle-groups.c", line=372) at ../util/qemu-thread-posix.c:94
 #5  0x00005611822b0b39 in throttle_group_co_io_limits_intercept (tgm=0x5611af1bb4d8, bytes=4096, direction=THROTTLE_READ) at ../block/throttle-groups.c:372
 #6  0x00005611822473b1 in blk_co_do_preadv_part (blk=0x5611af1bb490, offset=15972311040, bytes=4096, qiov=0x7f8aa4000f98, qiov_offset=0, flags=BDRV_REQ_REGISTERED_BUF) at ../block/block-backend.c:1354
 #7  0x0000561182247fa0 in blk_aio_read_entry (opaque=0x7f8aa4005910) at ../block/block-backend.c:1619
 #8  0x000056118241952e in coroutine_trampoline (i0=-1543497424, i1=32650) at ../util/coroutine-ucontext.c:175
 #9  0x00007f8ab5a56f70 in ?? () at ../sysdeps/unix/sysv/linux/x86_64/__start_context.S:66 from target:/lib64/libc.so.6
 #10 0x00007f8aad1ef190 in ?? ()
 #11 0x0000000000000000 in ?? ()

The lock is taken in line 386:
(gdb) p tg.lock
$1 = {lock = {__data = {__lock = 2, __count = 0, __owner = 24240, __nusers = 1, __kind = 0, __spins = 0, __elision = 0, __list = {__prev = 0x0, __next = 0x0}},
    __size = "\002\000\000\000\000\000\000\000\260^\000\000\001", '\000' <repeats 26 times>, __align = 2}, file = 0x56118289daca "../block/throttle-groups.c",
  line = 386, initialized = true}

The solution is to use tg->lock to protect both ThreadGroup fields and
ThrottleGroupMember.throttled_reqs. It doesn't seem to be possible
to use separate locks because we need to first manipulate ThrottleGroup
fields, then schedule next coroutine using throttled_reqs and after than
update token field from ThrottleGroup depending on the throttled_reqs
state.

Signed-off-by: Dmitry Guryanov <dmitry.guryanov@gmail.com>
Message-ID: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit d4816177654d59e26ce212c436513f01842eb410)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 32553b39e3..4385748bbf 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -295,19 +295,15 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
 /* Start the next pending I/O request for a ThrottleGroupMember. Return whether
  * any request was actually pending.
  *
+ * This assumes that tg->lock is held.
+ *
  * @tgm:       the current ThrottleGroupMember
  * @direction: the ThrottleDirection
  */
 static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
                                                          ThrottleDirection direction)
 {
-    bool ret;
-
-    qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
-    ret = qemu_co_queue_next(&tgm->throttled_reqs[direction]);
-    qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
-
-    return ret;
+    return qemu_co_queue_next(&tgm->throttled_reqs[direction]);
 }
 
 /* Look for the next pending I/O request and schedule it.
@@ -378,12 +374,8 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
     /* Wait if there's a timer set or queued requests of this type */
     if (must_wait || tgm->pending_reqs[direction]) {
         tgm->pending_reqs[direction]++;
-        qemu_mutex_unlock(&tg->lock);
-        qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
         qemu_co_queue_wait(&tgm->throttled_reqs[direction],
-                           &tgm->throttled_reqs_lock);
-        qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
-        qemu_mutex_lock(&tg->lock);
+                           &tg->lock);
         tgm->pending_reqs[direction]--;
     }
 
@@ -410,15 +402,15 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
     ThrottleDirection direction = data->direction;
     bool empty_queue;
 
+    qemu_mutex_lock(&tg->lock);
     empty_queue = !throttle_group_co_restart_queue(tgm, direction);
 
     /* If the request queue was empty then we have to take care of
      * scheduling the next one */
     if (empty_queue) {
-        qemu_mutex_lock(&tg->lock);
         schedule_next_request(tgm, direction);
-        qemu_mutex_unlock(&tg->lock);
     }
+    qemu_mutex_unlock(&tg->lock);
 
     g_free(data);
 
@@ -569,7 +561,6 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
                          read_timer_cb,
                          write_timer_cb,
                          tgm);
-    qemu_co_mutex_init(&tgm->throttled_reqs_lock);
 }
 
 /* Unregister a ThrottleGroupMember from its group, removing it from the list,
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index 2355e8d9de..7dfc81f7b5 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -35,8 +35,7 @@
 
 typedef struct ThrottleGroupMember {
     AioContext   *aio_context;
-    /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
-    CoMutex      throttled_reqs_lock;
+    /* Protected by ThrottleGroup.lock */
     CoQueue      throttled_reqs[THROTTLE_MAX];
 
     /* Nonzero if the I/O limits are currently being ignored; generally
-- 
2.47.3


