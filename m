Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5A4C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6D0-0005XU-S9; Wed, 12 Aug 2026 06:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cy-0005W6-P0
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:16 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cw-0002jZ-Ov
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:16 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso131251266b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786530553; x=1787135353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fA9IQDUBY9wYqV4KUbqbPe1RIFw+DaKwtNPF7u/KkP4=;
 b=nKRqyUEDWSY91GK2Jeclzj3pjTgURORQwQVyXBJHH52e+KPTxPE8SsxlK6Z0YtcahK
 nRQ5Appeqk8okAYDVAvlTN4oGhsN/Y3CKls20T8lzg+wGyQEWiLpAtGCUVpnSm5aSOP3
 Gm8BWU/T2GHu+wHaUUIGOKB/OJgU+DN6T1CrUGRe+1ZdpPKQKcQARCZEajvNrW5f8KuL
 B4uC2g15UPC+SBsB253HXJlpP5M6X7uyEWXdWlJxPpLBhJdVDi0+u1lvQ2a/UDVc5sQG
 +1qPNs1LgeqaQ191iu2E3kYSXA/T7Kv0D/l9iyrxyNtaiek9mS6uU1fb1GfqVizGqPhZ
 9cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530553; x=1787135353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fA9IQDUBY9wYqV4KUbqbPe1RIFw+DaKwtNPF7u/KkP4=;
 b=MLbADiz8R04LR/xICjn1Eo/SBtACiqWfFpr2OiqIOjKElZy7amUfnYfhM2Yw9QjK0+
 fT1NYsqH5xyPL1NmMZ7N8Zr0NSScjBQwTXYkJREsHkj2UMv4uKfAj/YXDUUVC6jMPJvu
 +ySGmkkMMAIbW9TPXQa8PAXHGM4dbqgsEqe71qmmVp5OJP03VlkR9LceYA88GtrDZMXb
 sHLUL7gHRXljEJxHA6FBHq/57ivdVNvl3wyfTT6vdikhenJHqjg0EOXbMDjFiZ8vmf7N
 +giMOEeW0N37XCidgYjISOnleoDHcS2G6akeoLu9gI5bOXmCs8sXKdnCDtDdlcDrWGtS
 NIfw==
X-Gm-Message-State: AOJu0YwGwrH+r6rcgkc6o8cWcTNcYCpQ06g4PKJ70gY5vRfS+61Scab4
 PFjk2DRA1vPnQLEjEZn3bOu/Uey/KG+sIm1vYMhjnJv+mtrRZhs4SzmX0wD7wcOyNLMsx5Mg7Hi
 48x3o
X-Gm-Gg: AR+sD13V7iIfWpnP29qLyhZqP2+2R4txA43LIINaUj98d6M1Q46m0PqraW1pxDVI1ba
 cgjq6LThYErUIBADFpYPXJWuSE13UYqHb6R8mc4U6qkoWXDlAgknoo5TEq/xRN4IshjXSQ99QNp
 UIQMLa6epZbQX3rEI+Jr0NvAvTb1YPUL4FBtlWq+thRZG4nyJeCMvx3x/Ke8xw+aW/TkICSWcbA
 2J4lUpfVNGPiIa3J3NZYroqzF3AyZ1eWzlow0LCNrFwT94PIDZnLzm/pa0jJfrErGlppSS6OPIw
 3l3011rDbUX3iPhU0GdDjjjDj0EBpuWSAZuN5yxXYal5GPkdQ8vP3fpCPHYdf7fP0aeLLFe7Ph7
 8cvXQZ3Of9WqtS600TdptdUFc38Mn9pTNpZsx7d9PyZh9ETMasyfPSFyLfcvqKoKRFYNo2O0Myr
 68tPXMrzaXoMrLJr+C+a4l4ILnPHmSDsk+Z5xIOROYakGKVd0HJoMgvs+Khw==
X-Received: by 2002:a17:906:7954:b0:c1f:c061:569a with SMTP id
 a640c23a62f3a-c20f2e4f67amr154679866b.7.1786530552874; 
 Wed, 12 Aug 2026 03:29:12 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0ad270bsm70748466b.46.2026.08.12.03.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:29:12 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/3] block/nbd: clear reply.cookie under receive_mutex
Date: Wed, 12 Aug 2026 12:29:06 +0200
Message-ID: <20260812102906.894063-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812102906.894063-1-den@openvz.org>
References: <20260812102906.894063-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=den@openvz.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/nbd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 21f0f9d40d..1659008784 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -158,11 +158,11 @@ static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
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
@@ -970,9 +970,11 @@ static coroutine_fn int nbd_co_receive_one_chunk(
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
2.53.0


