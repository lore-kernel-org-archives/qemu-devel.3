Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD506CEE341
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 17:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLP6y-00006J-3z; Tue, 18 Nov 2025 12:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6w-0008W0-CW
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vLP6u-0004jq-Oy
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 12:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763485400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8meUzKvO6KX2QLIVnDxoDj1RumboLDFbRJuX950bDI=;
 b=VCH64tvBA1wj0xoqAXTeHepITuNcOpajD6DDZGzQVVWfsxPXs63c5oyAbnNIvYN/XPgDzb
 /8nZ/fmVdHlJBf15NT40SXVE9YL8rwsY6M/3cZbm3POkujWKTXHbjmUnFm8ErOmQlHsqqi
 XPryi3m5cJdGtqDUSzOS7B950ANvAPs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-DvkrLMPkPEWD-LnmcVL6sA-1; Tue,
 18 Nov 2025 12:03:16 -0500
X-MC-Unique: DvkrLMPkPEWD-LnmcVL6sA-1
X-Mimecast-MFC-AGG-ID: DvkrLMPkPEWD-LnmcVL6sA_1763485395
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97DFF1956069; Tue, 18 Nov 2025 17:03:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EC74300A88D; Tue, 18 Nov 2025 17:03:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 05/19] curl: Fix coroutine waking
Date: Tue, 18 Nov 2025 18:02:42 +0100
Message-ID: <20251118170256.272087-6-kwolf@redhat.com>
In-Reply-To: <20251118170256.272087-1-kwolf@redhat.com>
References: <20251118170256.272087-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 block/curl.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index d7d93d967f..4e77c93b46 100644
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
@@ -868,7 +882,7 @@ out_noclean:
     return -EINVAL;
 }
 
-static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
+static void coroutine_fn curl_do_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 {
     CURLState *state;
     int running;
@@ -880,10 +894,13 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
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
@@ -898,7 +915,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     if (curl_init_state(s, state) < 0) {
         curl_clean_state(state);
         acb->ret = -EIO;
-        goto out;
+        goto dont_yield;
     }
 
     acb->start = 0;
@@ -913,7 +930,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     if (state->buf_len && state->orig_buf == NULL) {
         curl_clean_state(state);
         acb->ret = -ENOMEM;
-        goto out;
+        goto dont_yield;
     }
     state->acb[0] = acb;
 
@@ -925,13 +942,16 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
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
 
@@ -947,10 +967,7 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
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
2.51.1


