Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D38DC5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1K2-00087q-AM; Thu, 20 Aug 2026 07:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1K0-00086m-9l
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1Jy-0005p0-9y
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso1229224f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787226753; x=1787831553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lJGFRZT4xBgbHoDeIFX0KDibwMy8Oj0WwFErBWi550o=;
 b=oj6kco/7STE/U3TOOQSnvXJp8K7OtlXApQispR7fkz4N4PXVfnBPigZ2WSkx3m61Xc
 vIH+5S55Koy9qrFZFE7Onrp2OCX6MKAARzYZWNLEblh/enbkrfY4VucSK6JsLw4JcmcH
 ZEPVBFi3MqsAEA7P8lIUEsqROBlwVsSfg9IPKW3D3w/NDUxpegfPUIGjcJGMHdYJ7w4q
 nzrrLVR6lJYvayrpajBRJBPpmmZvnjEXRt6UWTcOUzq4rFDzonWtijUvpIhIGdaw8m73
 NJtnSJ4eFuxNWJ8JOSvh9khlxkVitMhGD420/jQY6DGZiJYnJuZuvOlyv7n6CQ+hH7Tw
 nIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226753; x=1787831553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lJGFRZT4xBgbHoDeIFX0KDibwMy8Oj0WwFErBWi550o=;
 b=rwLmbaRMvsW+cTscxp7fR7VjwOszNin4cgjBSl0/JaVhvM8PUzCYl4ro/4NS7JgYTF
 V+OWPWdvydhdQjgJosLDDRbc3qprfyLAEKsfAw1DCaETG50dP/3wf/NljjQctQ2W6fRe
 mewPk/LjUnxwJ7PfARobeuG3rVQqHrSp1LTQBYYLahpcaeSflEs9lIVK+nPK+lFNlPUw
 YoPL2fwu5I/l8GcblEDyaL97RwubStZueDgMiIUYkdCd++4g3KLUAowJaMaUSnAgfeGu
 dsvLrZ82GjxO+Paewg2S3lbCV4xYpvn6gOiDQNkXagwFDNzzRwen0iIfQ4TE+2gxuj7P
 CMpA==
X-Gm-Message-State: AFuF++m3v7+KBDb9MxIKNiPj7A75m562LIHskMZWL4TtK2xeCylguRmq
 gdOlNc4TswjfQZ2TTda3mWvLe++5pioQ3UP15Je9hb1NdaAwejaHgW0MlRlrTvt5o+llM0FGT0M
 XTlYe
X-Gm-Gg: AR+sD11vYh+EUL6eJM95XCKOD+pkNTisLgLD4t2RmCZMJBjZW0dlHVRkPhtp0hA3dqr
 j6d6Loh4Dz4NxyO8pZtaLJWyONhJ+2Uy/cvhIa6eOKKcBgfV/sBsvn8d2v7J8na9CewszKtU8ey
 6NtyHQiQ0Qoh8V7+p/iPGs43tfLBEXl4dvsRNZ8fFPXHtxrdQ1DEYcrbWDkftjVAw9h8/Hr1s+m
 b5COAeNxAMyFvNfIym08qBtGAPQtLitUVrqgQQ6C1t0WNfYbYC9iLYVC4hri3b++M6I9GHADeBb
 d2kQRLaln9y4YorNoL0jRLT9P7dZlPuvmbzAn1qdGUemSPzWaiT7yZIpjOlL92SXttNpm2bRtsh
 X928dW5IjF689qaFbuK7r37ihtgJ7pP3BZJpzpGTzqeyFts1Tz8PAuyZE/dQxLFAQIpk0/7xmTP
 GqirUrEOV0b8yvHsA0Ha7Viy6vNjNAh/IyCOofSme0zbap0vOqFNnlLFEaQXrT2xVnv8tg
X-Received: by 2002:a05:6000:298e:20b0:482:b887:f033 with SMTP id
 ffacd0b85a97d-482b887f05dmr6991049f8f.16.1787226752888; 
 Thu, 20 Aug 2026 04:52:32 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm13069627f8f.0.2026.08.20.04.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:52:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 1/3] block/nbd: clear reply.cookie when the reply is
 rejected
Date: Thu, 20 Aug 2026 13:52:26 +0200
Message-ID: <20260820115228.587427-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820115228.587427-1-den@openvz.org>
References: <20260820115228.587427-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
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

nbd_receive_replies() reads a reply header into s->reply and, when the
header turns out to be unusable, reports a channel error and returns
without touching it. The cookie stays there until the request which
owns the reply clears it, and until then the waiters are explicitly
allowed to look at a cookie which is not theirs:

    if (s->reply.cookie != 0) {
        ind2 = COOKIE_TO_INDEX(s->reply.cookie);
        assert(!s->requests[ind2].receiving);

Two of the error paths leave a value chosen by the server behind: one
returns before the cookie is validated at all, the other returns
because that validation has failed. A waiter which picks such a cookie
up turns it into an index which is not in requests[] and accesses the
array out of bounds, at an offset the server controls.

The reply is of no use to anybody at this point, so clear the cookie
before the mutex is released and keep the invariant that a non-zero
s->reply.cookie is always an index of a live request.

Observing the stale cookie takes a second thread, which a multiqueue
configuration provides. Within one AioContext there is no yield point
between the failed read and the clearing done by the owner in
nbd_co_receive_one_chunk(), so nothing else of this node runs in
between. The parked waiters cannot see it either, as they are woken
only after the cookie has been cleared. What can get in is a request
entering nbd_receive_replies() afresh, one just sent or one back for
its next reply chunk, because that path takes the mutex without
looking at the state.

Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/nbd.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 5d231d5c4e..d9b776283f 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -466,20 +466,19 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
             error_setg(errp, "server dropped connection");
         }
         if (ret < 0) {
-            nbd_channel_error(s, ret);
-            return ret;
+            goto err;
         }
         if (nbd_reply_is_structured(&s->reply) &&
             s->info.mode < NBD_MODE_STRUCTURED) {
-            nbd_channel_error(s, -EINVAL);
+            ret = -EINVAL;
             error_setg(errp, "unexpected structured reply");
-            return -EINVAL;
+            goto err;
         }
         ind2 = COOKIE_TO_INDEX(s->reply.cookie);
         if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
-            nbd_channel_error(s, -EINVAL);
+            ret = -EINVAL;
             error_setg(errp, "unexpected cookie value");
-            return -EINVAL;
+            goto err;
         }
         if (s->reply.cookie == cookie) {
             /* We are done */
@@ -487,6 +486,13 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
         }
         nbd_recv_coroutine_wake_one(&s->requests[ind2]);
     }
+
+err:
+    /* Waiters look at this cookie, so do not leave a rejected one behind. */
+    s->reply.cookie = 0;
+    nbd_channel_error(s, ret);
+
+    return ret;
 }
 
 static int coroutine_fn GRAPH_RDLOCK
-- 
2.53.0


