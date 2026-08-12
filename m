Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281ADC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6Cy-0005W3-CQ; Wed, 12 Aug 2026 06:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cw-0005UZ-N1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:14 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cu-0002iv-1a
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so86765166b.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786530550; x=1787135350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NdFZtNt0B5CspdIiAGT2omAyJ7es0F/gGiPbHDyfU2Y=;
 b=lsyVmgjOvBDL/VTniWHrA8gNUOpQHOREm5wh/gQxDgUQuzppTFlEKIT9j50Mgj+UxI
 LbDwDy+A+90qwfWeMseUv+VxQ0AgGBuNVf+jXcgTN4+jmOJMcoTd9G2EIvn81xsXcu6R
 lhIDe5wZRabLTKLE2ydx1jwlrC94HB+z80899B0bMZC1xorikE//yAKNPeDZkKT5YRY/
 13XdrGcXG+hDP52JBHyFea28QBU8ybWjvtSFc2wRmtoMsmVoqE+McW0kn7NMyp22ICns
 Y3KULEN386zd6KA1P9zSZvGhcBjkP9hmu3r58g9PTScdeJw4L3mS2D9BZybL/o3AWXaj
 V99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530550; x=1787135350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NdFZtNt0B5CspdIiAGT2omAyJ7es0F/gGiPbHDyfU2Y=;
 b=CnRuCMKxTODisNyn2ec1fmuSeZAwdPHcrUBzEYr/JOgfhf2lkMk9BiR2piw2DRjhZh
 ffHHl9TTvfm/s67epxJBzHRQ2tCdw1T16QjIoX1+Akxrx3Qodx5oldEC8zTx7J/ATqMX
 vrNvVT6UgpVhnPn6lk5rirV/aIZ6/SaYJY5kdgnGW4iF+GqgemLMUjzFHpYXPFJjrakv
 hl23iWoIdMWIHxXNPEzM6gXIk/EH5EWhGGs1hPQAgHG89rvRfF7qKwwYMG4ifZRfmhAz
 FzKClzZgfojYt/jYr+i2ocAcmUzpop5c1A+dPpGB87jdHkLSqtveXv+3sT5JOKkHxeoS
 U4Pg==
X-Gm-Message-State: AOJu0YwT8IJEGBgtw2rZNuN+LVVEY0gLPa4xuoQMswGJfc1seG4Uwq+E
 0lyODE42lDEhKVhUrKApWsvAFVveKWU1dwExBLmEiCQcsyu5rBCoG9K2egbzHYOOU3JeoH+kI97
 tX7PN
X-Gm-Gg: AR+sD13Iqr+JNXXzldBZv7p+zmWAOgmN4IruhnxrKWy4lWeJSXQHInWrcUFo2d+Ht6W
 XhNMiaIcfQqBfF9JlM8Vs4giT5RSVWPJLebs44i5KYZ4uW5mPyw2moZhjCqbmO/4WzarRDWmLTo
 YQnlL4jCLE52WSIwNAhnV6mHFjJY3fCKINQ7MprvAklK0G2+J5bGgSy01OcvOu9S+8eAMmlLYXg
 b0hT/ijtsA3Vy35pDDFlg9na6uix8sHuns5ohcfjyYXSj5sRHY3j/w03BJ9COM980hV7a6e7q1u
 75Hnfj+InsvxavYEz7iUqVm+toa69LnoLExexuOrY+dnCfxmAm0YVRnllIEA/bN4Fp+jiKM8DIs
 kwZ4/736WiQ77BCqFT8POO0mXLG7DOpkotMDdzfsAnmXSYd63rYPqAS2RLkC5yBL9gXNUfVyW4Q
 W8Ih3Cmwdn5dBEquSzX2oRFdPvxjynDcyFNWN6NHA714g7pt6BkM1fOJU6KA==
X-Received: by 2002:a17:907:1c0c:b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c20f2fa0de5mr179368466b.20.1786530550408; 
 Wed, 12 Aug 2026 03:29:10 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0ad270bsm70748466b.46.2026.08.12.03.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:29:10 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/3] block/nbd: clear reply.cookie when the reply is rejected
Date: Wed, 12 Aug 2026 12:29:04 +0200
Message-ID: <20260812102906.894063-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812102906.894063-1-den@openvz.org>
References: <20260812102906.894063-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=den@openvz.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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


