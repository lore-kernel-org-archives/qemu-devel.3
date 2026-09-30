Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BBFCA5FCD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW3-0007X5-1R; Wed, 30 Sep 2026 12:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVZ-0006SP-Oz
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:20 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVW-0003WL-8d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:17 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b017a3be3so801671f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787009; x=1791391809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ofn20N1FUg18TXR7Ved1Q66g4OfV1gHL7SrWzTzJ5Q=;
 b=icO7hAkq9X3E8p5LIjcUbItFq+dM6c9VDN9JA6EfQlw7arwerhIaZUqf9f6e1qgLKA
 jyLcxk1EgGfcWTaIR0iK+tzpUg7IrsFI+NlNtyxrNhdrJhztuY2FgSwUOViZHKS6y11M
 vIlOljOjXYveaDlLi6q5vrG/kKmlXO1qVCpF2ez9RFvD2Tzz4mj6nV9TLgaR6xiao6W2
 gr/sO8yofv8X+5p0znNM3riWlJSvtvbYU6ipU2eBNjRYVk5L/y0IGsIIWvqcrLktMsBH
 sa2KArB6OLRDKYUWUVyx2iaBjIbs6niJZczadyu/ZPYhMEBUtYtF2rqeFR9HxN14GAOd
 biBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787009; x=1791391809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ofn20N1FUg18TXR7Ved1Q66g4OfV1gHL7SrWzTzJ5Q=;
 b=ooL86KBJN9TL+f1hphGTUMQY6N3+BnC1wJukm+fU59z+BwkjFMQ+YPf0w/A017xXDy
 jcZGoi9oRkzMEaqQ7RGNe31kRg/NHVU/j0+D+hOrIyE3lhyO3o66wRlCX+ZSYwAlLSyB
 dBxqnSNextnSaPSUYtqF5ZIuY2uIDtJOg0RWFDxroxugfFunrJ6uzTNaYX5ixDaO3Ac1
 Gvp7L8pa34SRIyARKJ8pHwQJyuqwOUNHqLZfN86k+kXluVZnOOhAnKX2FgDuwsAPvmjd
 rrD4KpliwmnSOe8gDPQwf+zSnZQK/Iyycme0Ee0X2sh1Riob9DomKxB8YGJI/tDFhGkQ
 ZPMA==
X-Gm-Message-State: AFuF++lF05eEvaVVqncuvPLT1ObniMqQ7XA3xTZt1Iyae09/1wq2Vw/x
 atcZXwAcfw1XWcLxT3N6f/XtaR25C9fKEkSycxq7yuejI2DfRCYgh+Rz4mSZq4uu5VQRzfBKK8q
 qkITI
X-Gm-Gg: AYBFou2xLpWKLziGlDDr5eD/ohnm9pYW7NVVzQHG4haHqqkaDRGgKlfndZ5J4001jjS
 PKqg4mbHy60lbzy+9I08QvOZSc7Kp+6oX/bbQWD5n31T9dlmJ2MLDWb8datbnisNL4qicON5vNp
 e+TxpvB1UW/ESMicyn+N82OZCraCDIwxcl7QfH459LHcNP6rif4oppg/fb9D7cjiPT0eCeRPWsW
 qcaV+6WolUzFBv8cQ7mHqqxWlRgc4yCYx82mML2WYFWaY2Ym9esjNeRCg/8FzB0ovk2vByOEcPj
 0Oi7pGbn/8AIW5jcIcjOIyQI/WHSFJRloqmaKcsrf/nLAlWYaX487g33LNEZawVCL1tOqD5/aGK
 8PHzqMr4bxt/E1NLMkXdIFOoWrR6ybfZwuYJR/NkJdOW0E25vZI0kHwGklUnmKMUM5Oj139jeHQ
 ai/Bu31QgkG9Ppcjl5rvmIGQl1sCNNbuFfjzhdXHMyYA6+bw+9+MYpOPcVGo+MSY8lS5o=
X-Received: by 2002:a05:600c:4714:b0:49f:fe88:e7d1 with SMTP id
 5b1f17b1804b1-4a01affe8bdmr39096745e9.15.1790787009010; 
 Wed, 30 Sep 2026 09:50:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 04/13] block/preallocate: serialise the filter state
Date: Wed, 30 Sep 2026 18:49:50 +0200
Message-ID: <20260930165000.303236-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e; envelope-from=den@openvz.org;
 helo=mail-wr2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

The filter keeps the file length it has seen, the length it has
reserved and where the trailing zeroes start in plain fields, and
updates them with a read, a compare and a store. That was indivisible
while one node was driven by one AioContext. It is not any more:
virtio-blk with iothread-vq-mapping drives one node from several.

Two writers extending the file then both pass the compare, and the
smaller end lands last:

  writer A, [1G, 1G+64k)            writer B, [1G+64k, 1G+128k)
  --------------------------------  --------------------------------
  reads data_end 1G, 1G+64k > 1G
                                    reads data_end 1G, 1G+128k > 1G
                                    stores data_end = 1G+128k
  stores data_end = 1G+64k

Both writes are acknowledged, and data_end now sits below B's data.
Nothing raises it again except a later write ending beyond it, and
closing the image truncates the file to it, so B's data is cut off the
end. The last pair of extending writes before a shutdown is exactly
where this bites.

Take a mutex across handle_write() and preallocate_co_getlength(). The
remaining readers, apart from preallocate_co_truncate(), reach the
state from global state code with the node drained, where no request
is in flight.

Holding it cannot deadlock. A writer waiting for it has not reached
bs->file yet, so it owns nothing below the filter, and the only calls
made under it go to the child. preallocate_co_truncate() is left out
for that reason: growing the file waits for the requests in flight on
the child, and once the next patch issues the preallocation without
the mutex, one of those can be a preallocation that needs it back.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: qemu-stable@nongnu.org
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/preallocate.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 8cd98684f4..442cdb0176 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -76,6 +76,8 @@ typedef struct BDRVPreallocateState {
      * BLK_PERM_WRITE permissions on file child.
      */
 
+    CoMutex lock;
+
     /* Gives up the resize permission on children when parents don't need it */
     QEMUBH *drop_resize_bh;
 } BDRVPreallocateState;
@@ -155,6 +157,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
      * For this to work, mark them invalid.
      */
     preallocate_set_state(s, -EINVAL);
+    qemu_co_mutex_init(&s->lock);
     s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
@@ -324,8 +327,8 @@ static bool GRAPH_RDLOCK has_prealloc_perms(BlockDriverState *bs)
  * one bdrv_co_pwrite_zeroes() call.
  */
 static bool coroutine_fn GRAPH_RDLOCK
-handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
-             bool want_merge_zero)
+handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                    bool want_merge_zero)
 {
     BDRVPreallocateState *s = bs->opaque;
     int64_t end = offset + bytes;
@@ -404,6 +407,20 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return want_merge_zero;
 }
 
+static bool coroutine_fn GRAPH_RDLOCK
+handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
+             bool want_merge_zero)
+{
+    BDRVPreallocateState *s = bs->opaque;
+    bool ret;
+
+    qemu_co_mutex_lock(&s->lock);
+    ret = handle_write_locked(bs, offset, bytes, want_merge_zero);
+    qemu_co_mutex_unlock(&s->lock);
+
+    return ret;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 preallocate_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
                              int64_t bytes, BdrvRequestFlags flags)
@@ -506,8 +523,11 @@ preallocate_co_getlength(BlockDriverState *bs)
     int64_t ret;
     BDRVPreallocateState *s = bs->opaque;
 
+    qemu_co_mutex_lock(&s->lock);
     if (s->data_end >= 0) {
-        return s->data_end;
+        ret = s->data_end;
+        qemu_co_mutex_unlock(&s->lock);
+        return ret;
     }
 
     ret = bdrv_co_getlength(bs->file->bs);
@@ -515,6 +535,7 @@ preallocate_co_getlength(BlockDriverState *bs)
     if (has_prealloc_perms(bs)) {
         preallocate_set_state(s, ret);
     }
+    qemu_co_mutex_unlock(&s->lock);
 
     return ret;
 }
-- 
2.53.0


