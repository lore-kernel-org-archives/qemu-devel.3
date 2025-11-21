Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9A4CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:36:52 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd9n-0007Mz-VL; Fri, 21 Nov 2025 21:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd9O-000758-30; Fri, 21 Nov 2025 21:14:58 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMd8r-0005ge-6T; Fri, 21 Nov 2025 21:14:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F30F16C71A;
 Fri, 21 Nov 2025 16:51:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8C543219B6;
 Fri, 21 Nov 2025 16:52:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 65/76] curl: Fix coroutine waking
Date: Fri, 21 Nov 2025 16:51:43 +0300
Message-ID: <20251121135201.1114964-65-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Hanna Czenczek <hreitz@redhat.com>

If we wake a coroutine from a different context, we must ensure that it
will yield exactly once (now or later), awaiting that wake.

curl’s current .ret == -EINPROGRESS loop may lead to the coroutine not
yielding if the request finishes before the loop gets run.  To fix it,
we must drop the loop and yield exactly once, if we need to yield.

Finding out that latter part ("if we need to yield") makes it a bit
complicated: Requests may be served from a cache internal to the curl
block driver, or fail before being submitted.  In these cases, we must
not yield.  However, if we find a matching but still ongoing request in
the cache, we will have to await that, i.e. still yield.

To address this, move the yield inside of the respective functions:
- Inside of curl_find_buf() when awaiting ongoing concurrent requests,
- Inside of curl_setup_preadv() when having created a new request.

Rename curl_setup_preadv() to curl_do_preadv() to reflect this.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (acb.ret == -EINPROGRESS)` loop.)

Also, add a comment why aio_co_wake() is safe regardless of whether the
coroutine and curl_multi_check_completion() run in the same context.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251110154854.151484-6-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 53d5c7ffac7bd4e0d12174432ebb2b3e88614b15)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index cbfb847dc4..96498aac1d 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -258,8 +258,8 @@ read_end:
 }
 
 /* Called with s->mutex held.  */
-static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
-                          CURLAIOCB *acb)
+static bool coroutine_fn
+curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len, CURLAIOCB *acb)
 {
     int i;
     uint64_t end = start + len;
@@ -307,6 +307,10 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             for (j=0; j<CURL_NUM_ACB; j++) {
                 if (!state->acb[j]) {
                     state->acb[j] = acb;
+                    /* Await ongoing request */
+                    qemu_mutex_unlock(&s->mutex);
+                    qemu_coroutine_yield();
+                    qemu_mutex_lock(&s->mutex);
                     return true;
                 }
             }
@@ -378,6 +382,16 @@ static void curl_multi_check_completion(BDRVCURLState *s)
                 acb->ret = error ? -EIO : 0;
                 state->acb[i] = NULL;
                 qemu_mutex_unlock(&s->mutex);
+                /*
+                 * Current AioContext is the BDS context, which may or may not
+                 * be the request (coroutine) context.
+                 * - If it is, the coroutine must have yielded or the FD handler
+                 *   (curl_multi_do()/curl_multi_timeout_do()) could not have
+                 *   been called and we would not be here
+                 * - If it is not, it doesn't matter whether it has already
+                 *   yielded or not; it will be scheduled once it does yield
+                 * So aio_co_wake() is safe to call.
+                 */
                 aio_co_wake(acb->co);
                 qemu_mutex_lock(&s->mutex);
             }
@@ -879,7 +893,7 @@ out_noclean:
     return -EINVAL;
 }
 
-static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
+static void coroutine_fn curl_do_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 {
     CURLState *state;
     int running;
@@ -891,10 +905,13 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     qemu_mutex_lock(&s->mutex);
 
-    // In case we have the requested data already (e.g. read-ahead),
-    // we can just call the callback and be done.
+    /*
+     * In case we have the requested data already (e.g. read-ahead),
+     * we can just call the callback and be done.  This may have to
+     * await an ongoing request, in which case it itself will yield.
+     */
     if (curl_find_buf(s, start, acb->bytes, acb)) {
-        goto out;
+        goto dont_yield;
     }
 
     // No cache found, so let's start a new request
@@ -909,7 +926,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     if (curl_init_state(s, state) < 0) {
         curl_clean_state(state);
         acb->ret = -EIO;
-        goto out;
+        goto dont_yield;
     }
 
     acb->start = 0;
@@ -924,7 +941,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     if (state->buf_len && state->orig_buf == NULL) {
         curl_clean_state(state);
         acb->ret = -ENOMEM;
-        goto out;
+        goto dont_yield;
     }
     state->acb[0] = acb;
 
@@ -936,13 +953,16 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         acb->ret = -EIO;
 
         curl_clean_state(state);
-        goto out;
+        goto dont_yield;
     }
 
     /* Tell curl it needs to kick things off */
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
+    qemu_mutex_unlock(&s->mutex);
+    qemu_coroutine_yield();
+    return;
 
-out:
+dont_yield:
     qemu_mutex_unlock(&s->mutex);
 }
 
@@ -958,10 +978,7 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
         .bytes = bytes
     };
 
-    curl_setup_preadv(bs, &acb);
-    while (acb.ret == -EINPROGRESS) {
-        qemu_coroutine_yield();
-    }
+    curl_do_preadv(bs, &acb);
     return acb.ret;
 }
 
-- 
2.47.3


