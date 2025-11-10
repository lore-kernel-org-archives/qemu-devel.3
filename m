Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91DBCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU92-0006De-S8; Mon, 10 Nov 2025 10:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8y-0006BR-7y
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8w-0000tL-G2
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wxwKLzXpm3vmJbzNMJpbBjWRq2Q+OhytwkFNiKUpHaw=;
 b=RTPhOOvxlwM7NXf8gwvAuX7Tr3CGUpjaXVLLar2T9rCTo5f70Qyi3L2zxHeT8/zA5zkBn7
 UCWNxmRXQzzwIQnUs7IsgGHPl1/tnztHx60p+eVITJJTbE4bCwMy/WoT8x/aEX7WO00uaw
 mOQGo7RpWKvidNn4kwu+QQyyiWuvAAc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-PFxd7MicP9CXMfFeEhp-bA-1; Mon, 10 Nov 2025 10:49:20 -0500
X-MC-Unique: PFxd7MicP9CXMfFeEhp-bA-1
X-Mimecast-MFC-AGG-ID: PFxd7MicP9CXMfFeEhp-bA_1762789759
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so20623705e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789759; x=1763394559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wxwKLzXpm3vmJbzNMJpbBjWRq2Q+OhytwkFNiKUpHaw=;
 b=tUK9+AbIMK+33avj5D7ProsdH4M+jPYVhsqfOFIF9kq/Zv56EM2D+5Infkh8RixTyM
 4dE4tV/1eGuTGA83uxH8jeQjtKM6jK+Cjrx6yloT1mhkG+0SaO2IWX4j9wtJLPvQUBNK
 HMrXpF+Pa2bdrzDAiBrNVIQH6Qd+hFgGnQR4sHu5Jn94MBqssDrUwlucEP1Trv5cM5GN
 +EpFUzN3avyKPWru3NgAavreDpiKD0eoBqg5Rn4KmEykGAdO7vDApJts71/tTLc4Y0uP
 4KEf2h0GURLagMj+qUFezrN2sWRCJIjzN37Z6O+mQc+EyKZk4mOaGDVm71jf61brXZgu
 1tkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789759; x=1763394559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wxwKLzXpm3vmJbzNMJpbBjWRq2Q+OhytwkFNiKUpHaw=;
 b=vsDqmhGl/9zHFHJleVDN244qx6KSkwPyRK2cGnE3DPVk1HV+/PBGIkm1w28Xi2fqe/
 0338mbUPMqvZu47M6m3jJe3wd/wGtqv4oxpi2TlE0k5zQKehSh36baTA4gE6oMN9lQUQ
 5DkAF4GsQLbdQqBFNk6O7muLj+8NhhYacsqK96ZyAMwbw63KQOuKNfeHTZRiQT8nlL60
 a//IXOBd5a5k0h35WwDQHjPjSN+NpPc9Fq4XeNvbQc3pqE9edU1yXl1xIgxGcoryMWDp
 T25iJkRyOcil6bXIcADnvQ5QfFA7IgIccr8zWq5Uv8LC5/+RIbIYxM84Hw/RUm+iL+H2
 STZQ==
X-Gm-Message-State: AOJu0YwwFQSb2LYaFzA3VaplKmJAS3WACfbxd2tTL+mWcI8XRyzH5EhC
 F8jqIlAxW8CItLE2exK2e85vtkFl5BuPoMVBBDVJIhBWimeUm9gpqyRpPf+PCey6E+efdq9OFZ1
 g9BIl7gcoqcOkA1wBh9hQR5hiaHstSJ8gkq6L0crpJPRiH1lFSEWQY234
X-Gm-Gg: ASbGncvzx62QpILXzvc+F/vqhAEDzVg54a3SQtVwni6oxcsRUlhQAqAkCjeocU7N8Jh
 xR/hWFY/QaN9mTfq1djSeoCGPgrfLPZ8NVLNI+ccgmmi35o4YitmmzuKM5YAHeeZJcL94YbeBK6
 3ci9/BlCgfPHh4L46T3oBTnidgc/cnf+06aMNpiLEl/OR5GNmrZAhJ/OdASQNLxn05btNEaWiL3
 sNmhG0otS/zth0nD9F3d4l3ca1foi7onk9wgr+wJaWj4GhjcKJPC6JUyDL0w0w1kEETmQbhT7TF
 QSnmBx3LUujEkjbySuO2+qPlZ3S3mpas72gKOLLjdKtQ9FUN07QEJ00W0TnLir4eKquOlkNxunI
 /WmuDNH7G8Ggnpb/pfUAtYhE/Qok227GHoyYPS8CckW1zG8hVoN+1SjNGig==
X-Received: by 2002:a05:600c:4703:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-4777322f0e3mr87220305e9.12.1762789758965; 
 Mon, 10 Nov 2025 07:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF689iDM4PvzzXgsH/nmIo02Qh0O8uRKKxTgU61rDIIto4ydx+wr4RISoawl9G02o+2y2Tj/Q==
X-Received: by 2002:a05:600c:4703:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-4777322f0e3mr87220005e9.12.1762789758510; 
 Mon, 10 Nov 2025 07:49:18 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47761c2fe2asm270310165e9.5.2025.11.10.07.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:17 -0800 (PST)
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
Subject: [PATCH v2 05/19] curl: Fix coroutine waking
Date: Mon, 10 Nov 2025 16:48:40 +0100
Message-ID: <20251110154854.151484-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


