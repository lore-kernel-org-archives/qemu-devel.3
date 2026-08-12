Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9927AC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6Cz-0005WK-9z; Wed, 12 Aug 2026 06:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cx-0005V3-EO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:15 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu6Cv-0002j6-CZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:29:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so113887566b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786530551; x=1787135351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NtTCK5Dii6LDoNzyyQ9y0Yku0qPmidmnjmWHD+vYK6o=;
 b=HKPRnZzFrrv0WvbXFB6GG6aF/Okq8uorqxifYW8vReQjjwgsCxHnNu8Kn/ZQFWbp01
 FDqcwcFyV/6bTUdKLTlQbmdCwxQrQlzHhV2xWkUuO8seMnofEhWOpWWHoiXZCWFQBRx/
 HlEDxEyhSWY08qfsvQzDb/FV6RYjxvnL5KZM1p8hRV0V/BmVugyAD/4Q+7bsMorNwM89
 v84Fthte4ZuQf2Hqu9Lso8n4U84HUHvPEdk+MfKFkbRb2Mc/nxTnCt6j1hWh9ihT6hK+
 B5BOX0ITsRD1a3eeIlgQ9avtMOn6N643DMegRLNCJ/G3/lNoOo4PAeEfJhsBLh3vHRwq
 9GTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530551; x=1787135351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NtTCK5Dii6LDoNzyyQ9y0Yku0qPmidmnjmWHD+vYK6o=;
 b=SHmDxQG7GA+AIKsJFKTKmQpg9hFbzf8B+M6MjUlYVovPdEjXepBYMPftGJvSRGytqK
 ZVDCoQsW5QMjin/XtIdP8LGEh27WK8fHUguRzzOpdzD/Hv6N771NmB6kKfn4BHmeX/xF
 bWCQJyqUJPwIjdyTYxvh63JPkVqfm2k0GhBdcuQgSLeRahdfaLvgNrNsKW6531H35F05
 2nMsmOR1TEPLV8VTNaIiY++OATbdAK62knCreU7JNwNrLx4sFqotnUxcw/j721fIP+Gc
 zV/nQt+UACrtAo5+0EG3h950MwMkhjca8GozY6N64lqijY5XF04C2JxqMTZKrPExGJs9
 O/WQ==
X-Gm-Message-State: AOJu0YwPrY5yHPTseKgdTDnPrT2fywLP5UZ5+jzFJ8Q9euZgmzUM+o8T
 HnJUcXdYyeB+EO9fx7TxYa+rGbllB44l+iMf6laO2nLzpnCA+Qf+HMALLuIBt06G0QpqoXqkSkJ
 GO8bh
X-Gm-Gg: AR+sD12l5piVyRzDvKPg1NwYqFwjT9fvc1DYi1AiuIDTlXXhXMU57ZzrKyIm6OntFV/
 qgoGy9XM35O9Vq9ROXuNqyj3ov08x/nHDAnf8V+Bjlzrj06sbopP2IyjdfMEJCml9Xw/1vbk0+o
 ywQyiGjxjCTDl0ywoc+vTy961yXMIo4/pCFJLYvMmhfWRpo05W4FpYx+Ypn7pbMvWscGpbDJZu/
 6z/63erFNG1SNoEGqOSMZw/5L28g3Afvn6fEmXdwvTVR8IjTQchpQdO24mhjobxSiZNbz0WrQvD
 vhmkaweCgBaB6xP5xkinw6AkLD+elV+j0+MsFz2bo6YvYop5P4JSaYPeerjdSMnDLnT/+SsvsGK
 ss48/s4TyOkWz2bOcTdP3OQZFjFrGtd5xyWHfCFaTFdnRbSwcDvHk4NTSeWQHnyErWCmcT3bxhc
 IadLS5DPC5HETr6Ak+aCjo0KJHZZI/hXOGfNiIyy+TRoMZNK0hUAa6qq0XVg==
X-Received: by 2002:a17:907:d1d:b0:c1f:97f3:7225 with SMTP id
 a640c23a62f3a-c20f2e3c984mr189342966b.6.1786530551485; 
 Wed, 12 Aug 2026 03:29:11 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0ad270bsm70748466b.46.2026.08.12.03.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:29:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/3] block/nbd: never index requests[] with an unchecked cookie
Date: Wed, 12 Aug 2026 12:29:05 +0200
Message-ID: <20260812102906.894063-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812102906.894063-1-den@openvz.org>
References: <20260812102906.894063-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=den@openvz.org; helo=mail-ej1-x62b.google.com
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

The only cookie which is checked today is the one taken from the wire,
in nbd_receive_replies(), where an invalid value is a protocol error
rather than an internal inconsistency and thus has to stay a channel
error. Route every other conversion through a helper which asserts the
range before it returns the slot, so that the check can not be
forgotten again.

The cookie of the reply in flight goes through the helper as well. It
is not an unchecked value: it has either passed the check above, or it
has been cleared by the previous commit, so a stale index there is an
internal inconsistency too.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/nbd.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d9b776283f..21f0f9d40d 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -136,6 +136,16 @@ static void nbd_clear_bdrvstate(BlockDriverState *bs)
     s->x_dirty_bitmap = NULL;
 }
 
+/* Not for cookies coming from the wire, those are checked separately. */
+static NBDClientRequest *nbd_request_by_cookie(BDRVNBDState *s, uint64_t cookie)
+{
+    uint64_t ind = COOKIE_TO_INDEX(cookie);
+
+    assert(ind < MAX_NBD_REQUESTS);
+
+    return &s->requests[ind];
+}
+
 /* Called with s->receive_mutex taken.  */
 static bool coroutine_fn nbd_recv_coroutine_wake_one(NBDClientRequest *req)
 {
@@ -422,7 +432,8 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
                                             Error **errp)
 {
     int ret;
-    uint64_t ind = COOKIE_TO_INDEX(cookie), ind2;
+    NBDClientRequest *req = nbd_request_by_cookie(s, cookie);
+    uint64_t ind2;
     QEMU_LOCK_GUARD(&s->receive_mutex);
 
     while (true) {
@@ -437,10 +448,9 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              * woken by whoever set s->reply.cookie (or never wait in this
              * yield). So, we should not wake it here.
              */
-            ind2 = COOKIE_TO_INDEX(s->reply.cookie);
-            assert(!s->requests[ind2].receiving);
+            assert(!nbd_request_by_cookie(s, s->reply.cookie)->receiving);
 
-            s->requests[ind].receiving = true;
+            req->receiving = true;
             qemu_co_mutex_unlock(&s->receive_mutex);
 
             qemu_coroutine_yield();
@@ -454,7 +464,7 @@ static coroutine_fn int nbd_receive_replies(BDRVNBDState *s, uint64_t cookie,
              */
 
             qemu_co_mutex_lock(&s->receive_mutex);
-            assert(!s->requests[ind].receiving);
+            assert(!req->receiving);
             continue;
         }
 
@@ -861,7 +871,6 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
 {
     ERRP_GUARD();
     int ret;
-    int i = COOKIE_TO_INDEX(cookie);
     void *local_payload = NULL;
     NBDStructuredReplyChunk *chunk;
 
@@ -919,8 +928,8 @@ static coroutine_fn int nbd_co_do_receive_one_chunk(
             return -EINVAL;
         }
 
-        return nbd_co_receive_offset_data_payload(s, s->requests[i].offset,
-                                                  qiov, errp);
+        return nbd_co_receive_offset_data_payload(
+                s, nbd_request_by_cookie(s, cookie)->offset, qiov, errp);
     }
 
     if (nbd_reply_type_is_error(chunk->type)) {
@@ -1067,7 +1076,7 @@ static bool coroutine_fn nbd_reply_chunk_iter_receive(BDRVNBDState *s,
 
 break_loop:
     qemu_mutex_lock(&s->requests_lock);
-    s->requests[COOKIE_TO_INDEX(cookie)].coroutine = NULL;
+    nbd_request_by_cookie(s, cookie)->coroutine = NULL;
     s->in_flight--;
     qemu_co_queue_next(&s->free_sema);
     qemu_mutex_unlock(&s->requests_lock);
-- 
2.53.0


