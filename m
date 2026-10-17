Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E476CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2h-0001Hh-Sk; Sat, 17 Oct 2026 16:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1p-0006rL-5Z; Sat, 17 Oct 2026 16:29:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1n-00042J-AC; Sat, 17 Oct 2026 16:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268852; bh=9Qx3Fy74skyHOo6MXHmnmMoJ0echXzi6ce+mUeFoOTs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=spyynmcQlaqvhxhJ0fYQqV+JWQB25iNFyWM51/PeRImJS9S0GcGtiTqFcmBI8Q6Tc
 LevFqdHH6sOUcXHIJUcDekxMs9/VB/sxLOuI68EO5j3pOMuehmmTX+CDZbpclwbZeQ
 Q7E4Bx7IR4F89Fp8RCPzJAgjnf2C1ZCQ2YcE+FYqNE0iJkB8tjM5xSOFcx85beGggr
 seMsC33Qz7YvZhrSBgjhsAMDRAeAlo2wUbYyqd7T0zXCimOm2lxm2n21T3lN+IwEtd
 ZeNAzXpDfELENN1UwKK2uH/2LOPbtCrTzuJlOdu5fXW2A2krYxVsZdA7JtfAtNIG3m
 C9hejJ8q9JYpA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2732A1DE757;
 Sat, 17 Oct 2026 23:27:32 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1DB4B44342D;
 Sat, 17 Oct 2026 23:27:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 27/73] block/nbd: clear reply.cookie under
 receive_mutex
Date: Sat, 17 Oct 2026 23:25:45 +0300
Message-ID: <20261017202638.728621-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

s->reply is documented as protected by s->receive_mutex, but the cookie
is cleared without it once the owning request has consumed its chunk.
A waiter in nbd_receive_replies() inspects the very same field under
the mutex, and does so with two separate loads:

    if (s->reply.cookie != 0) {
        ind2 = COOKIE_TO_INDEX(s->reply.cookie);
        assert(!s->requests[ind2].receiving);

Nothing keeps those two loads consistent. If the owner clears the
cookie in between, the second one reads 0, COOKIE_TO_INDEX() turns it
into an index of -1, and s->requests[] is accessed out of bounds:

  Assertion `!s->requests[ind2].receiving' failed.

  (gdb) p cookie
  $1 = 8
  (gdb) p s->reply.cookie
  $2 = 0
  (gdb) p &((NBDClientRequest *)s->requests)[-1].receiving
  $3 = (_Bool *) 0x5555558416c0
  (gdb) p &s->in_flight
  $4 = (unsigned int *) 0x5555558416c0
  (gdb) p s->in_flight
  $5 = 8

The cookie we wait for is 8, yet reply.cookie reads 0 one line after it
was found non-zero, so the index is -1. requests[-1].receiving lands on
in_flight, which is non-zero while requests are outstanding, and that is
what the assertion trips over.

Hitting this requires two coroutines of one NBD node to run in
different threads, as there is no yield point between the two loads
for the owner to squeeze into. A multiqueue configuration provides
exactly that, with the virtqueues of one disk spread over several
iothreads. Note that a compiler is free to merge the two loads into
one, in which case the race is invisible, so builds with reduced
optimization are much more likely to trip over it.

Accessing s->reply without the mutex is fine for the coroutine that
owns the reply: a non-zero cookie makes the field private to it.
Releasing that ownership is not, as it races with the waiters which
are explicitly allowed to look at the cookie. Clear it under the
mutex, in the same critical section as the wakeup, and make
nbd_recv_coroutines_wake() caller-locked, as CoMutex is not
recursive. It has a single caller.

The added acquisition cannot block behind the header read in
nbd_receive_replies(), because that path is only reachable with
reply.cookie == 0 while we still own a non-zero cookie. Merging the
clear with the wakeup also keeps a newcomer from starting a header
read in between, which would stall this already completed request for
the duration of that read.

There is no cookie to own when we get here after an error, and then a
newcomer can indeed be inside that read. It does not hold us for long
either, as the channel has been shut down before the error was
reported, so the read it sits in returns right away.

Fixes: 4ddb5d2fde ("block/nbd: drop connection_co")
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260820115228.587427-4-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit cd3be3bd96c0e86f683c210a2c8f46b7da161807)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nbd.c b/block/nbd.c
index d0a7097034..e5e16722ba 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -161,11 +161,11 @@ static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
     return false;
 }
 
+/* Called with s->receive_mutex taken. */
 static void coroutine_fn nbd_recv_coroutines_wake(BDRVNBDState *s)
 {
     int i;
 
-    QEMU_LOCK_GUARD(&s->receive_mutex);
     for (i = 0; i < MAX_NBD_REQUESTS; i++) {
         if (nbd_recv_coroutine_wake_one(&s->requests[i])) {
             return;
@@ -974,9 +974,11 @@ static coroutine_fn int nbd_co_receive_one_chunk(
         /* For assert at loop start in nbd_connection_entry */
         *reply = s->reply;
     }
-    s->reply.cookie = 0;
 
-    nbd_recv_coroutines_wake(s);
+    WITH_QEMU_LOCK_GUARD(&s->receive_mutex) {
+        s->reply.cookie = 0;
+        nbd_recv_coroutines_wake(s);
+    }
 
     return ret;
 }
-- 
2.47.3


