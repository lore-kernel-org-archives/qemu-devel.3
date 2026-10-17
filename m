Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BF0CCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2V-0000Oe-FM; Sat, 17 Oct 2026 16:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1n-0006hG-7Y; Sat, 17 Oct 2026 16:29:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1i-00041E-FW; Sat, 17 Oct 2026 16:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268849; bh=lVz8zWps2N/zWKLDoW+1L3mbLfbs78tIwDnPGFwcXi8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NUj4rhEsStcYQqFDXdodR5tV3NwtIbP7VTDgZCvTRgA/anu5GiHV1FJfX3Bzei7Cr
 kXAxET2UW95nY8QfrHKTTNksUAvhnl8icoJeLURWq1q0ClQFtirMs7IYcBu7rmPl30
 jrrIeanLk80gcDozlIxhxJSTLjEBHgFhGqwhvSAbeSrdVxo7inTDu1l7jXixfygehm
 dhMYgu5BX0VZu5mmBNtqvtXUNHL+ZYwgqsPinGRX4IrgpQPAP8uaiQl0FnCDEPVaoX
 7fQ96Zm0MdDGH3B1lrOF8B2sjwaI5DxlmSMZO9+jC+0p4GTxz9ffl4y3gA1aEb1xJz
 CUudF0+h/5bZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D3CC81DE755;
 Sat, 17 Oct 2026 23:27:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4AF844342B;
 Sat, 17 Oct 2026 23:27:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 25/73] block/nbd: clear reply.cookie when the reply is
 rejected
Date: Sat, 17 Oct 2026 23:25:43 +0300
Message-ID: <20261017202638.728621-25-mjt@tls.msk.ru>
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
Message-ID: <20260820115228.587427-2-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 9998d225bb95c0baa17d51f760e46a51886ccfdf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


