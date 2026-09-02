Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B975C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdf-0005o1-Tw; Wed, 02 Sep 2026 04:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdd-0005lP-ID; Wed, 02 Sep 2026 04:48:09 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdb-0007AK-Ah; Wed, 02 Sep 2026 04:48:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 108D880CAB;
 Wed, 02 Sep 2026 11:48:01 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-cVpGw13b; Wed, 02 Sep 2026 11:48:00 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338880;
 bh=7UOc3lB593G6YM8JLokUpJXT/bLzE/U+Gwzl1Qe/LpY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=BKjpiCdDVmyWEN91fVHBJYGJ0rRGoFVIvWN5KtVzFzQ2F97oC5D8uZCzXCztBdRdW
 OIc2o4hR9oLovcDZH+TdBFNBA9K4mY0He+qReJaTQaRtnd6AbbZk6+OQmhSHbm7b5C
 TGPT31fWIYE4BZ72SRJdcSI8BZuSqxlrCLlFmoUU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 1/8] block/nbd: clear reply.cookie when the reply is rejected
Date: Wed,  2 Sep 2026 11:47:47 +0300
Message-ID: <20260902084754.140103-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
---
 block/nbd.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 5d231d5c4e4..d9b776283f4 100644
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
2.43.0


