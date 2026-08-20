Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA30C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1K3-000896-Vp; Thu, 20 Aug 2026 07:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1K2-000883-Kt
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1K0-0005pz-Uz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so1318165f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787226755; x=1787831555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GPlAeeOjoY4SZFtVFtu8z+mQmq26G3t8GLazxFHp+fg=;
 b=n6mEE4D9YMhlAkAcqgPvRHEy+SdJ661YuLiM9Cp5/Ly5UOBIMqwRDjfT8iYp7Nznr9
 RUU067Hoxdo7+ckvrNCZenmgUVg+mOIfb3sUBzyPdtzeWIm6aynDO/Vp1UcO3FgJbs9q
 M3hGjlXkeb5nST3JYO0XUCF/cUpRsOhSYPN9laBxpSkp4rx0ttod+3J6yKz+hwXmUefw
 ZgO8FV0ZZ4Qxu4POSR74YTglhOkfRbVrvvX2PSH1zN61ouOIYuHo8KGZsenMeiNPCLDj
 m/uta16V3xn1bizyRlYyIoSkn0bIzsj26m2ium2uM4b0lUfARxkcAmtyOKR4Cug3aVqx
 okpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226755; x=1787831555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GPlAeeOjoY4SZFtVFtu8z+mQmq26G3t8GLazxFHp+fg=;
 b=qBjhn0QBnn2HP2gLmzaywotc+SbStvrY2+YJjBfT0EQXL7fcoJD96tBZqF1zMofPlm
 wd3dp6RDxZ+RJlKQ7i0Uf7ucaIZo5ORQnlpTu1cUu3Cmt2FCfz663GriMP03N9Ca/NBs
 rOeKypBpHVvvFBuJfYkBXsKq53pIjZlt8iFNkSJ8S6ZLR17mDbRDbpmW8GyFa7Yr/EWj
 pttkb67w8Ou1E+4sj5EfmAVF9Rl2HhbV7RPesivFSNPdXKa67UpXx8xw/vCwVhCdgRxL
 oK+YUYRqHXZ0u+qcTqesGvuw+fbnxXsySxTP+6U42B4h1yfHVYXgJRx2n6zYG+WrB4MR
 3efA==
X-Gm-Message-State: AFuF++kwYGWo5FaCPf/bIRsbBgleiFg3Xw9/iHXs+SIL7CARwrlvZ0Qf
 cEeCVyQlV7k0ixEV3I6HarrCjUpO7sq5M0dIwrVoLUnhEM1eoK1Rz2+Wu3vQZsFfAENmNtpdcRa
 G/RwG
X-Gm-Gg: AR+sD11JEr8X7YdBL0WMhSIFcOX7qAg6WHAZwSDZAgCmN11VUKFZckQnSUuszF93eEZ
 g8B1YMc6N8z9saHNiZWPkWalsqBXoMVwtGcpLyv/NVOY0dgl9L9vmpcEB/JjzkvgsVu5b/G6wD4
 TkWKsd9J1XYToZNVrUUty9nx94YXdp+Aa9T7bDqN22phUj94lIpOEcGxf1eZthZWoKUimJk1IsS
 E5yUof8s30mJHpL/iBCuG5xMhn8jNgwIW56UNvJg06s1z6kaOEzh/xPU6xPSLZTLKykgu8U+dib
 mdtnPhk1rPQkSm22rw6Ux0bw2eu/bwcOOJ+veI/xaECiX/nO/WYWeZP/tI4uDFOUgd5Oq13IC9c
 DZVGCmZcpD2+04OhD5J5eyA6MqwUb6JRwckW4d/gk3fzcm+X48GELISNLaSKe1p5UGgWGlrx6Fq
 JLT9OfWjaNBe66CCS+O2GArDZb7WSiUD2ttXWL0OF8/iB/BTxhjixB8is81A==
X-Received: by 2002:a05:6000:1884:b0:47f:9662:85fe with SMTP id
 ffacd0b85a97d-482b1fe8a3dmr19862231f8f.16.1787226755218; 
 Thu, 20 Aug 2026 04:52:35 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm13069627f8f.0.2026.08.20.04.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:52:34 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 3/3] block/nbd: clear reply.cookie under receive_mutex
Date: Thu, 20 Aug 2026 13:52:28 +0200
Message-ID: <20260820115228.587427-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820115228.587427-1-den@openvz.org>
References: <20260820115228.587427-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=den@openvz.org; helo=mail-wr1-x433.google.com
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

From: Denis V. Lunev <den@openvz.org>

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
---
 block/nbd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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
2.53.0


