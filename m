Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5790ACCF2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB2b-0000uW-Rd; Sat, 17 Oct 2026 16:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1l-0006f3-BK; Sat, 17 Oct 2026 16:29:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB1i-00041p-EZ; Sat, 17 Oct 2026 16:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268850; bh=ssXstQFJQqCeotDgKaZFU6wQkt7iat7NMhOe6v/S63g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jzAK7p+lqh/G9r4QojsN8aETjUYvn6WN8MbINaJJ6dCYexXsx3yRnYpdqBrScoPG6
 VnVXaPbTro2uog1/e9NBj0p20tKpYW1pk05cHzFTC+cHmkxyCl9aufhr+ANuey/WOA
 vD5i7t65HHC0do/sixmGl5f+0dZgAa+E2LWbGsbpk1UuBwqbuY/NW5oQHgq1vtl9TW
 5qx3TU8cpOhxdgq7xv62ybr7ZA5Q58x3PsXP0fN0ZGndPpht9IxGE5IadS97099Iby
 zdqmBJQPdzxKd+D3bkgol5faaTTt2uEJDHYjqcAGWSPnp5uV0K5qtrRJ63MsHAtj5f
 lajbZPqiSUONw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA5EE1DE756;
 Sat, 17 Oct 2026 23:27:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1071B44342C;
 Sat, 17 Oct 2026 23:27:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 26/73] block/nbd: never index requests[] with an
 unchecked cookie
Date: Sat, 17 Oct 2026 23:25:44 +0300
Message-ID: <20261017202638.728621-26-mjt@tls.msk.ru>
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

Cookies are converted into indices of s->requests[] in several places
and the result is used right away, without any check:

    int i = COOKIE_TO_INDEX(cookie);
    ...
    return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,

COOKIE_TO_INDEX() subtracts one, so a zero cookie becomes an index of
-1 and the access lands in front of the array. This is undefined and,
depending on the type of the index and on what the compiler has put
there, it can as well pass silently: at the site above i is signed, so
even a plain i < MAX_NBD_REQUESTS check would happily let -1 through.

Route every conversion through a helper which hands out the slot only
for a cookie in range and owned by a request in flight, so that the
check can not be forgotten again. The helper reports through an Error,
as the one cookie which is not ours to trust, the one taken from the
wire in nbd_receive_replies(), is a protocol error rather than an
internal inconsistency and has to stay a channel error. Every other
cookie is one we have issued and still own, so a bad value there is a
bug in this file, which is what &error_abort spells out.

The cookie of the reply in flight goes through the helper as well. It
is not an unchecked value either: it has passed the check on the wire
path, or it has been cleared by the previous commit.

Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260820115228.587427-3-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit 75b0a993dacbd5f8579e8f8c228f9bae80541e42)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/nbd.c b/block/nbd.c
index d9b776283f..d0a7097034 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -136,6 +136,19 @@ static void nbd_clear_bdrvstate(BlockDriverState *bs)
     s->x_dirty_bitmap = NULL;
 }
 
+static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie,
+                                               Error **errp)
+{
+    uint64_t ind = COOKIE_TO_INDEX(cookie);
+
+    if (ind >= MAX_NBD_REQUESTS || !s->requests[ind].coroutine) {
+        error_setg(errp, "unexpected cookie value");
+        return NULL;
+    }
+
+    return &s->requests[ind];
+}
+
 /* Called with s->receive_mutex taken.  */
 static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
 {
@@ -422,7 +435,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
                                             Error **errp)
 {
     int ret;
-    uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
+    NBDClientRequest *req = nbd_request_by_cookie(s, cookie, &error_abort);
+    NBDClientRequest *owner;
     QEMU_LOCK_GUARD(&s->receive_mutex);
 
     while (true) {
@@ -437,10 +451,10 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              * woken by whoever set s->reply.cookie (or never wait in this
              * yield). So, we should not wake it here.
              */
-            ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-            assert(!s->requests[ind2].receiving);
+            owner = nbd_request_by_cookie(s, s->reply.cookie, &error_abort);
+            assert(!owner->receiving);
 
-            s->requests[ind].receiving = true;
+            req->receiving = true;
             qemu_co_mutex_unlock(&s->receive_mutex);
 
             qemu_coroutine_yield();
@@ -454,7 +468,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              */
 
             qemu_co_mutex_lock(&s->receive_mutex);
-            assert(!s->requests[ind].receiving);
+            assert(!req->receiving);
             continue;
         }
 
@@ -474,17 +488,16 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
             error_setg(errp, "unexpected structured reply");
             goto err;
         }
-        ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-        if (ind2 >= MAX_NBD_REQUESTS || !s->requests[ind2].coroutine) {
+        owner = nbd_request_by_cookie(s, s->reply.cookie, errp);
+        if (!owner) {
             ret = -EINVAL;
-            error_setg(errp, "unexpected cookie value");
             goto err;
         }
         if (s->reply.cookie == cookie) {
             /* We are done */
             return 0;
         }
-        nbd_recv_coroutine_wake_one(&s->requests[ind2]);
+        nbd_recv_coroutine_wake_one(owner);
     }
 
 err:
@@ -861,7 +874,6 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 {
     ERRP_GUARD();
     int ret;
-    int i = COOKIE_TO_INDEX(cookie);
     void *local_payload = NULL;
     NBDStructuredReplyChunk *chunk;
 
@@ -919,8 +931,9 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
             return -EINVAL;
         }
 
-        return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
-                                                  qiov, errp);
+        return nbd_co_receive_offset_data_payload(
+                s, nbd_request_by_cookie(s, cookie, &error_abort)->offset,
+                qiov, errp);
     }
 
     if (nbd_reply_type_is_error(chunk->type)) {
@@ -1067,7 +1080,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
 
 break_loop:
     qemu_mutex_lock(&s->requests_lock);
-    s->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
+    nbd_request_by_cookie(s, cookie, &error_abort)->coroutine = NULL;
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_mutex_unlock(&s->requests_lock);
-- 
2.47.3


