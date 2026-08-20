Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A289C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx1K2-00088K-SL; Thu, 20 Aug 2026 07:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1K1-00087A-A4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx1Jz-0005pR-Fj
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:52:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so1123627f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787226754; x=1787831554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=st0WgwSEv4Yi/cZ0YrOYJwHq5izpY4g4nImWv1PkfRw=;
 b=VapBiy6yLxM24f+Ibh/qS+4KHY9LiPWCfAWzQRcIOmaPFBvSybB+LSGUqJ41EJlhek
 pf+9todxRm2pvpQCaIlSqmd/gfP0fEGCtNccoA7J3F4HZZGO9aCiyqo25Jzjv3QH4xjX
 duWuniuwERrCKypwMBvDfsohUWmJGug9TcgNOfMG1A85IftKD1m3PSt4FhRVCl+jlE4/
 1AUW8ILd+G+VxwsWfydG2l1B5W3Tum01cC0Bk/QXJJc6o/y42cH8E+mHHe/Lu93Y/svB
 3JscUQjauRWp/AHOg1D+Aa9LMreLAhYgZWTK5r0NMss98sG96P9U9caPf3h1yG7ZWgKG
 QVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787226754; x=1787831554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=st0WgwSEv4Yi/cZ0YrOYJwHq5izpY4g4nImWv1PkfRw=;
 b=PkODc99pnJxaeGsIniEmacYFdsYSqpH1esLygPzgZXSa2cigX9YdWtiraU1XH87cgy
 nHHmdeN+6ao56o3ENQqyJc5Bc7+wcHVWD0Z4QMMPahCzrjeCZKNSdCOD94tNZo5C3xFg
 jmiswm/4yVi79BvGDMTtwhIoH7H/e8qizUFM+Ht7DVMMtgtYF7oyNup1KktPb+NfPqC4
 747ZxynsPviJ5Zrb2k5V4IylhMHDUqz9NUVhdFPE3nJU0lyaLvBMWsu481CfRabIwmaE
 LWc78M9Wi0MPOn3pWQQ1bBoN5u6cufPeVpy8oUBnVh0Uvi0z5ljgrJZSBq8AgpJEKCEX
 xsKg==
X-Gm-Message-State: AOJu0YxbSaY9BKXFxOiAsh7kUpixEuP2uUmZ3Hn7fNnVhv6kB3dvGVMs
 53kiSwMVahHa59BUYrHfCn3g2QmcFU2JguEf71ctJudtWOSrKu8LSZR7zcBnTkXvIJWjAVRhmGt
 3ErPL
X-Gm-Gg: AR+sD10NLm6CxxXaYwFfqE10/w3DVo6NULAZXAILC0AVkLV+rO/sipf/xO43iKj0GPZ
 HMkL3kMTNrR8NrTKqB6pLNeFwGmFEGS8MyWKou09nZrOziVrvhjBdCIlQQAPSNP8jVdgNcIUmJB
 Sv33/SMrl9odL78wVMADAV/hE2gAWjGgGPxHFDghhGn8zNXWaj/i+VH6jHK2jc+cTSiLtj+fsae
 BbhLEBY+hZRLF1OwtbImpf/Jkos+k3c8it+paH1556GJLeUpzMtkuTiWvSbhaR0xTMQOwcYL6i0
 2zbS7xvCBq/M3DIMF3P1pci7ZhQ1+UIrUejiokpqkvoDts6Rdy4hApP9NaKA/9REOM54LErQb4c
 fz4+7pLg9LhqfM8FY61GjWVafGK7Brud5PgL8Dn2+ykrR5+gcjR9jqen5XvLTOsKn+wdDaqJSWA
 L9xOx1Nynx3pfuo+gQC//svLwVEdttaEMqKFhFAHMqssgNEkIdBPfTiJh26Q==
X-Received: by 2002:a05:600c:19c7:b0:495:7a04:b006 with SMTP id
 5b1f17b1804b1-499aa192422mr181214115e9.8.1787226754015; 
 Thu, 20 Aug 2026 04:52:34 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm13069627f8f.0.2026.08.20.04.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 04:52:33 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 2/3] block/nbd: never index requests[] with an unchecked
 cookie
Date: Thu, 20 Aug 2026 13:52:27 +0200
Message-ID: <20260820115228.587427-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820115228.587427-1-den@openvz.org>
References: <20260820115228.587427-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

From: Denis V. Lunev <den@openvz.org>

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
---
 block/nbd.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

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
2.53.0


