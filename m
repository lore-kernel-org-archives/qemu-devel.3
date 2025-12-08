Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA248D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 14:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSc6c-0003bK-QL; Mon, 08 Dec 2025 09:20:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.guryanov@gmail.com>)
 id 1vSX2E-0006eS-VJ
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 03:55:58 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmitry.guryanov@gmail.com>)
 id 1vSX2D-0006SA-22
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 03:55:58 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-37a3340391cso29916411fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 00:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765184154; x=1765788954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xYpdNK9V9NdphAkLyhPH0d+dGDBCogdp0MSQ37nPW0M=;
 b=Mww5xYf9LMvHjwB3Zfs36TZ2VBzkLIxaEH2eMq4cph98mK2zV0wlrc45sON1YFmqbu
 9lry2kGvdhtp0nXXQ8OUBw4fiqg8vZbSnjHBPc80/qC5d1OPnRukS9RtCDvhf/kp+im5
 +9XFwCn+lU41uC15ce/l3eolqU4bLWURNK1xZgeRL8R1HQNdG2+3EvrQqgi5LEaIR3tU
 t2pzw0EweDwPflcdvoW9qMTeX4loPnIOiioAEBgh1Egdl8cGWlDmXGP2nrfViLmioakR
 Gkea++QZ1oCOMaex76u9KB+/I0cyDg2dszo170RrobY22QYhNZJZQSGdBZKivLOMhEXN
 7ELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765184154; x=1765788954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYpdNK9V9NdphAkLyhPH0d+dGDBCogdp0MSQ37nPW0M=;
 b=u6YeSSHALwi2XQiiRmryRPgO75aAPpULQXgAAEo/Z7Cf3tOkjiQQpQrvHM2CkjmL8X
 VSsZQvFpSuqIW/tpylte8ttpPsuBf1t0dDv3A3UVFcgCU0mUYlCNogVouyrl0xpesSWt
 xqVo/iun8jy6WzZiiyc8wtfyzb/SOX4yTKHqhTt/NzytrVj55TBWA79iAT/pdnKHYj4l
 qZn9IC3JgxFoZ6s4+jtkL/zqYKnf212fPm8fMwZUxZtw3BtPdEuMtLzGOujeS04lrqSc
 TWIcYo1NcRIxV9LJN9g1df1zcYks+npWqS3firUoSxMg2c2MleJd8Wgijeka/Kj60UQV
 T+FA==
X-Gm-Message-State: AOJu0YzVuzrUmH7Ez7U5O2vHSLXgrRIbqGYrKnc6Qrs/MKhujZESP/Ly
 XhuV3RAvB2TD1tssccxChjHsE11YvYKrd10foX1EuhxsfcK0G/Uw0IMS
X-Gm-Gg: ASbGncuQspJ6xT8Jg03dBnlhKC1Rx0d6UYvha8FMlnQ1vWdf7x83b2b1iuEfii+v+3A
 5ZvUpVTBC6G4UNrLhHRp/TlZmW89UVGc1TdA7oqlpgacm0TXNH33Dt2Ua1bqbl8BCtwSLteV4oh
 UXh/y90YnMzRIy+3qXQef6qb4YjkdLPE+GbuGwnCOjtMdzWlCjFMEwW9nNQCYWtgv7jP9+9/6uR
 0AJ1MhF7poV2JTk+3ojnv6rOc8ubJcGg1rJtJBmbUggYyZpLvGSkLSzSnmBupqWT6mYj8fT3dcZ
 SJ0p58jqu4mjP6bI/ljGXPNkhxjAyix9qzS5yAI8S289DybQkbkbY5g5ot8uFZFoFotnLuXdpmC
 ++qpLeqEeF7fu7Dbzb4nHQMLm3xUu4ONcOz/UdHUJPAXCzgdxcDzFqBiH42EIbUrBCK9jcagGBq
 Um2P5v4mmJxOusUrQ4Ukcw
X-Google-Smtp-Source: AGHT+IG4BLaPztMSKK02eYq++M8ot9QiM72qr8rQRlADAb5ebN8Sl5pVxDvRbnlNE07paSDD7V6tUQ==
X-Received: by 2002:a05:651c:212a:b0:37b:9b58:dd04 with SMTP id
 38308e7fff4ca-37ed1f9e022mr19491991fa.7.1765184153462; 
 Mon, 08 Dec 2025 00:55:53 -0800 (PST)
Received: from fedora.vk.team ([5.181.62.126])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-597d7c1e39asm3989094e87.50.2025.12.08.00.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 00:55:53 -0800 (PST)
From: Dmitry Guryanov <dmitry.guryanov@gmail.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Guryanov <dmitry.guryanov@gmail.com>
Subject: [PATCH resend] block/throttle-groups: fix deadlock with iolimits and
 muliple iothreads
Date: Mon,  8 Dec 2025 11:55:28 +0300
Message-ID: <20251208085528.890098-1-dmitry.guryanov@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=dmitry.guryanov@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Dec 2025 09:20:46 -0500
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
---
 block/throttle-groups.c         | 21 ++++++---------------
 include/block/throttle-groups.h |  1 -
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 66fdce9a90..bb01e52516 100644
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
+    return qemu_co_queue_next(&tgm->throttled_reqs[direction]);;
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
index 2355e8d9de..374c7c0215 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -36,7 +36,6 @@
 typedef struct ThrottleGroupMember {
     AioContext   *aio_context;
     /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
-    CoMutex      throttled_reqs_lock;
     CoQueue      throttled_reqs[THROTTLE_MAX];
 
     /* Nonzero if the I/O limits are currently being ignored; generally
-- 
2.51.1


