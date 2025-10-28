Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B75CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeb-0008Ds-DT; Tue, 28 Oct 2025 12:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeI-00084b-G2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeB-0003Yv-9I
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLJdOJSUssWGwBsyDBm1U43bSPC0FcgCsDPLVbyx2Ps=;
 b=VOJjSVJA691hqW2p2jtpiXJSVHJYUmFIFE32k6w2EHYzx3P5J6rJ/3mk/co9GGLu8QT6nY
 DE0AS2kh/6kLqX2d7MRTRRvvpP0u2j2Pxxb0m7nWqzYgz51X+mhCbARy3NNYCF7WeqXuF1
 Tcb80BgB9YXWaW6tralmTtg7MKxrPZ8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-miq4GeeLN6KAAvW4-MPLcg-1; Tue, 28 Oct 2025 12:34:06 -0400
X-MC-Unique: miq4GeeLN6KAAvW4-MPLcg-1
X-Mimecast-MFC-AGG-ID: miq4GeeLN6KAAvW4-MPLcg_1761669245
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477171bbf51so6378845e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669245; x=1762274045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLJdOJSUssWGwBsyDBm1U43bSPC0FcgCsDPLVbyx2Ps=;
 b=ZASpx+7ouLcRA3fsbUjmDCNt+mVwVxIHuYBAwTMX21okKmr8FrSWl5/EXY4qmnPbAx
 jodWGpj35MEEsnBH45PsDoZkcAq4cSXgw0TMHe+snyTa6SFZyTO6qZlJrZNIExhrhdEI
 GNTYrv9IyLaWjPKqPfomaKWRdsQu9NJYlXqTtIM4m4+bTQ9IQw/4QcsJ5pP2FSsprEw6
 EYph1d7XhGLCWLIgpU4vn5fpC4oqm/HzxO0KOSKdJfhGcPQE9K6No6CVYxjTnpOTOIbA
 7z50L5h7p1UEIem+wo1DN6PMu00TYeZ7W0LPflc7Zrx7VvODndT64Sgbz7M4bVSPK317
 Mvew==
X-Gm-Message-State: AOJu0YwDeVUy4B6TgSxg83Yrvygh6aJSfO4yM/1sZbljazEUDU+2MxUR
 +lU6qR8TvzIc6oiBrv5gGxkeduvlq6xLJALtLRg4C4rs+Tn2KzagKuWPRiftFQDjR3MTOVM5qJW
 21foX9rigin2PLh3pxWblP0cFfJC8GLdS1S46lGwsVBcQdKuWkgzNO6G2
X-Gm-Gg: ASbGncs/66Adz269OM/8Vc4aTHvHA1Ns+fuii1rQJuDZUd0EpuWvhENwDroAF0vjRnF
 MfYBgEhyajaT1qJodUYOgiLYFrFN56P4SuW4kFSJsLZ00LSMixhLnkw6Cdy+DEph0e2xNB7+Xay
 plTLUUcZGgP+g+gGa9D2+c4RVhbSbZY2dMqzUYkSrLknvLEYFeSLoAwnxXrM4VAo/NEIVmcc5Zu
 vTPJdlSMQ2ofYVyyfCvLvDnaGeny1OxspC1XbC2svnvE+YQIY3eBfUe9/2swee+r5W9sjiyuYnV
 X/cYvb3HVoc3QICFbD8XfVPJ9lKUG4kembhqWfQuZCOcQMswiZvAOYKqXX5y0oqCfPiaWJhWRoc
 pXuPy+3aY1gJW9cIgazFugO2E3IoeVnArhj2uVrAX25x73BT0Z7eS8M8/EQ==
X-Received: by 2002:a05:600c:5197:b0:477:1be1:9afe with SMTP id
 5b1f17b1804b1-4771e180d92mr1010945e9.9.1761669244548; 
 Tue, 28 Oct 2025 09:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOcMewunCj8cVxj/IW7iuNFMakC0UnB92LOjFdg0o3aFT95YE1qnQx00MZztGgwfwdelYyNQ==
X-Received: by 2002:a05:600c:5197:b0:477:1be1:9afe with SMTP id
 5b1f17b1804b1-4771e180d92mr1010515e9.9.1761669243976; 
 Tue, 28 Oct 2025 09:34:03 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771843eabfsm23986055e9.2.2025.10.28.09.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:02 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH 05/16] curl: Fix coroutine waking
Date: Tue, 28 Oct 2025 17:33:31 +0100
Message-ID: <20251028163343.116249-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

If we wake a coroutine from a different context, we must ensure that it
will yield exactly once (now or later), awaiting that wake.

curl’s current .ret == -EINPROGRESS loop may lead to the coroutine not
yielding if the request finishes before the loop gets run.  To fix it,
drop the loop and just yield exactly once, unless the request is served
from the cache or failed before it was submitted – that last part makes
it a bit complicated, as the result of curl_find_buf() now needs to be a
tristate.

(Can be reproduced with multiqueue by adding a usleep(100000) before the
`while (acb.ret == -EINPROGRESS)` loop.)

Also, add a comment why aio_co_wake() is safe regardless of whether the
coroutine and curl_multi_check_completion() run in the same context.

Cc: qemu-stable@nongnu.org
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/curl.c | 55 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 68cf83ce55..65996a8866 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -124,6 +124,16 @@ typedef struct BDRVCURLState {
     char *proxypassword;
 } BDRVCURLState;
 
+/** Possible result states of curl_find_buf() */
+typedef enum {
+    /* No buffer found, need to create new request */
+    CURL_NO_BUF_FOUND,
+    /* Buffer found, request filled and done */
+    CURL_REQUEST_FILLED,
+    /* Ongoing request found, need to yield */
+    CURL_REQUEST_ONGOING,
+} CURLFindBufResult;
+
 static void curl_clean_state(CURLState *s);
 static void curl_multi_do(void *arg);
 
@@ -258,8 +268,8 @@ read_end:
 }
 
 /* Called with s->mutex held.  */
-static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
-                          CURLAIOCB *acb)
+static CURLFindBufResult curl_find_buf(BDRVCURLState *s, uint64_t start,
+                                       uint64_t len, CURLAIOCB *acb)
 {
     int i;
     uint64_t end = start + len;
@@ -289,7 +299,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
                 qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
             }
             acb->ret = 0;
-            return true;
+            return CURL_REQUEST_FILLED;
         }
 
         // Wait for unfinished chunks
@@ -307,13 +317,13 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
             for (j=0; j<CURL_NUM_ACB; j++) {
                 if (!state->acb[j]) {
                     state->acb[j] = acb;
-                    return true;
+                    return CURL_REQUEST_ONGOING;
                 }
             }
         }
     }
 
-    return false;
+    return CURL_NO_BUF_FOUND;
 }
 
 /* Called with s->mutex held.  */
@@ -378,6 +388,16 @@ static void curl_multi_check_completion(BDRVCURLState *s)
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
@@ -868,7 +888,8 @@ out_noclean:
     return -EINVAL;
 }
 
-static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
+/* Return whether a request was submitted that requires yielding */
+static bool coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 {
     CURLState *state;
     int running;
@@ -877,13 +898,15 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
 
     uint64_t start = acb->offset;
     uint64_t end;
+    CURLFindBufResult find_buf_res;
 
-    qemu_mutex_lock(&s->mutex);
+    QEMU_LOCK_GUARD(&s->mutex);
 
     // In case we have the requested data already (e.g. read-ahead),
     // we can just call the callback and be done.
-    if (curl_find_buf(s, start, acb->bytes, acb)) {
-        goto out;
+    find_buf_res = curl_find_buf(s, start, acb->bytes, acb);
+    if (find_buf_res != CURL_NO_BUF_FOUND) {
+        return find_buf_res == CURL_REQUEST_ONGOING;
     }
 
     // No cache found, so let's start a new request
@@ -898,7 +921,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     if (curl_init_state(s, state) < 0) {
         curl_clean_state(state);
         acb->ret = -EIO;
-        goto out;
+        return false;
     }
 
     acb->start = 0;
@@ -913,7 +936,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
     if (state->buf_len && state->orig_buf == NULL) {
         curl_clean_state(state);
         acb->ret = -ENOMEM;
-        goto out;
+        return false;
     }
     state->acb[0] = acb;
 
@@ -925,14 +948,12 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
         acb->ret = -EIO;
 
         curl_clean_state(state);
-        goto out;
+        return false;
     }
 
     /* Tell curl it needs to kick things off */
     curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
-
-out:
-    qemu_mutex_unlock(&s->mutex);
+    return true;
 }
 
 static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
@@ -941,14 +962,12 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
 {
     CURLAIOCB acb = {
         .co = qemu_coroutine_self(),
-        .ret = -EINPROGRESS,
         .qiov = qiov,
         .offset = offset,
         .bytes = bytes
     };
 
-    curl_setup_preadv(bs, &acb);
-    while (acb.ret == -EINPROGRESS) {
+    if (curl_setup_preadv(bs, &acb)) {
         qemu_coroutine_yield();
     }
     return acb.ret;
-- 
2.51.0


