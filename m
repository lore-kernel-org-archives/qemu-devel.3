Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8F1CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxVw-0006ww-Sd; Wed, 30 Sep 2026 12:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVb-0006We-I5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:20 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVW-0003Wy-9N
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:19 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af9f88c95so612503f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787011; x=1791391811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AjHnUyfHfzBiYJqLm+EofS6tYDgNmwYtxj0MnNrLJWY=;
 b=ITS71i+3uTuC9k8U1P7kwL1KKmUiRCkdlcLEOembaostH74BWknUANhfOIcOwpb+QP
 +UzqMEYhQap3KPXwpHGp+MCcjNL8FThPTbJNviCZHjT9o3hMybWfoEXAqfJUSnyMBbu5
 dkJdGfhMqkFtQk/puS/Mx6lD2bneIBbZq5SReRG4iAn9D0YD8P0PyV5adY8WQtm+F5D+
 4mZ/GEGFwCUrm2D5ZzcOogpdu5ZYPTmfZNSAI+S3oV+SHIir4oy6bQz10QTObCYWGkgK
 q4JTBg8TuJorpssNCN0LK+irlBt/3NCHqR6VOe3z1v6EEBaLY8seAE2MmQu3sfcY/LjS
 sOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787011; x=1791391811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AjHnUyfHfzBiYJqLm+EofS6tYDgNmwYtxj0MnNrLJWY=;
 b=eW8O0tcZUyOHoZUgjyjtqZOFcLIU2wlS+DPkMo6j5XdLrlvVDOjb6+65lRnNayRVJe
 NVFA2BGqKOzImJ5b/trRXAZ7+t+WSQZTPuQcKp3BbYYmrNGA8tReRbATrRdVTAqii/C5
 S3bWhe71fttYMg524lqMM8ebUq+CoLYatBSaLwukJYZui1F5ru4svCqnrjER2dXm1T2k
 acrdiGMgtEr/y6S3rVg3VlbMV21n+jYtYlbh103YNr5DbUHRRh1pwNiQ5w3N43QK/zRT
 khqOk7JszYpfU/+inu72bHmnMMmvuKm72flkcI5cFMirmSEPQmJuC64mRVW+gwaQK5jT
 f2mw==
X-Gm-Message-State: AFuF++nZ8eBKVLB5UnHyPBNWkvlC6mBm9QetZTEuC3i/WqPwhT0iCZ9T
 dznyMoTiWI8COxy5DZOJIhUn/cuzodTekCnwtCTHi26l3FraMtpFX7R+wRk0Vl9iJlL9wA7vyDH
 Cm/rf
X-Gm-Gg: AYBFou3Mh/A77Mk9aEtl7XdPaHHozvACrAwsO6DeY4GjmNredqqjVOSNAl2o30KfuZt
 jD1AwjEDc4U2CW+Ue7qQdqOQgedJQ9vOjP3ZTd8POUVvHdqyp5z4lQ9NepUwfUgT1vC+dVSOfYG
 wnUXfiFFCqkisBtLmav8e/B90s8i9Ows4neKaM/WPqlk2auoieohOlO6rVwhc5nhSqtmiX2PP6g
 d+wHdIsCWzlB4dADUg0byDXPNqBvLOjXBwG4DMUu5RhPd8M2cV96Dp4fHF53L65UMUrZy/GMSzo
 V8sXQfOzVBd+CjoENArkHjqQwwExlafQbVA0jH0w+dju07OhyHhj86SUR6SkDwfcmIo9NA89Ake
 p9gnrfweiwuhMLNYKWJzqgUbm6Mmn0Pe8YYaX+rZRtpJ7x2C8ikE/V6bh9bxPyZOM/IA2m1y4S4
 PP21Q00v/5b9hr/QSf/SjLn/v4eyNxwmihDQ6CQY4PhPPh9YfNPOCrRQFELdPA6pZIKT3g
X-Received: by 2002:a05:600c:a318:b0:49f:ffa2:1c72 with SMTP id
 5b1f17b1804b1-4a01eb0b951mr3802335e9.11.1790787010874; 
 Wed, 30 Sep 2026 09:50:10 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:09 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 05/13] block/preallocate: hold back writes into a
 preallocation in flight
Date: Wed, 30 Sep 2026 18:49:51 +0200
Message-ID: <20260930165000.303236-6-den@openvz.org>
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

The previous patch holds the mutex across all of handle_write(),
including the preallocating write zeroes. That is correct and far too
coarse: the fallocate takes as long as it takes, and every writer that
extends the file waits for it.

Reserve the range instead of holding the lock over it. file_end moves
to the end of the preallocated range before the request is issued, so
a writer arriving while it is in flight works from a length that
already covers the range being zeroed.

That leaves it going straight into the range, and BDRV_REQ_SERIALISING
cannot stop it. Serialisation orders a request against the ones in
bs->tracked_requests, and the zeroing request is not there yet: the
filter runs above bdrv_co_pwritev_part(), which is what tracks it.
Whatever the filter lets through in that window is unordered by
construction, so the filter has to hold it back itself.

safe_end trails file_end, standing at the lowest start of a
preallocation in flight and reaching file_end once none is left. A
write above it waits on a queue and re-reads the state when the
preallocations drain. A write zeroes merged into a preallocation
starts it below file_end, so safe_end has to move down as well as up.

Below safe_end nothing can be zeroed any more, so those writes do not
queue, and below zero_start there is nothing to record either, so
those take no mutex at all. The stores are qatomic_set() because that
path reads them without it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: qemu-stable@nongnu.org
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/preallocate.c | 95 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 442cdb0176..128f1da014 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -32,6 +32,7 @@
 #include "qemu/units.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
+#include "qemu/atomic.h"
 
 
 typedef struct PreallocateOpts {
@@ -76,6 +77,21 @@ typedef struct BDRVPreallocateState {
      * BLK_PERM_WRITE permissions on file child.
      */
 
+    /*
+     * @file_end is reserved as soon as a preallocation is decided on, so
+     * that the next one starts above it. @safe_end is the lowest start of
+     * a preallocation in flight, or @file_end when there is none: nothing
+     * below it can still be zeroed, so a write ending below it does not
+     * queue.
+     */
+    int64_t safe_end;
+    int prealloc_in_flight;
+    CoQueue prealloc_waiters;
+
+    /*
+     * Nothing done while this is held may wait for a request that has already
+     * passed the filter: that request can need it back.
+     */
     CoMutex lock;
 
     /* Gives up the resize permission on children when parents don't need it */
@@ -106,9 +122,17 @@ static QemuOptsList runtime_opts = {
     },
 };
 
+static void preallocate_set_file_end(BDRVPreallocateState *s, int64_t v)
+{
+    s->file_end = v;
+    qatomic_set(&s->safe_end, v);
+}
+
 static void preallocate_set_state(BDRVPreallocateState *s, int64_t v)
 {
-    s->file_end = s->zero_start = s->data_end = v;
+    preallocate_set_file_end(s, v);
+    qatomic_set(&s->data_end, v);
+    qatomic_set(&s->zero_start, v);
 }
 
 static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
@@ -158,6 +182,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
      */
     preallocate_set_state(s, -EINVAL);
     qemu_co_mutex_init(&s->lock);
+    qemu_co_queue_init(&s->prealloc_waiters);
     s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
@@ -188,7 +213,7 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
     int ret;
 
     if (s->file_end < 0) {
-        s->file_end = bdrv_getlength(bs->file->bs);
+        preallocate_set_file_end(s, bdrv_getlength(bs->file->bs));
         if (s->file_end < 0) {
             error_setg_errno(errp, -s->file_end, "Failed to get file length");
             return s->file_end;
@@ -200,10 +225,10 @@ preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
                             NULL);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Failed to drop preallocation");
-            s->file_end = ret;
+            preallocate_set_file_end(s, ret);
             return ret;
         }
-        s->file_end = s->data_end;
+        preallocate_set_file_end(s, s->data_end);
     }
 
     return 0;
@@ -345,18 +370,21 @@ handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
     }
 
     if (s->data_end < 0) {
-        s->data_end = bdrv_co_getlength(bs->file->bs);
-        if (s->data_end < 0) {
+        int64_t len = bdrv_co_getlength(bs->file->bs);
+
+        if (len < 0) {
+            s->data_end = len;
             return false;
         }
+        qatomic_set(&s->data_end, len);
 
         if (s->file_end < 0) {
-            s->file_end = s->data_end;
+            preallocate_set_file_end(s, len);
         }
     }
 
     if (!want_merge_zero && s->zero_start >= 0 && end > s->zero_start) {
-        s->zero_start = end;
+        qatomic_set(&s->zero_start, end);
     }
 
     if (end <= s->data_end) {
@@ -365,13 +393,13 @@ handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
     /* We have valid s->data_end, and request writes beyond it. */
 
-    s->data_end = end;
+    qatomic_set(&s->data_end, end);
     if (s->zero_start < 0 || !want_merge_zero) {
-        s->zero_start = end;
+        qatomic_set(&s->zero_start, end);
     }
 
     if (s->file_end < 0) {
-        s->file_end = bdrv_co_getlength(bs->file->bs);
+        preallocate_set_file_end(s, bdrv_co_getlength(bs->file->bs));
         if (s->file_end < 0) {
             return false;
         }
@@ -395,16 +423,27 @@ handle_write_locked(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
     want_merge_zero = want_merge_zero && (prealloc_start <= offset);
 
+    /* Reserve the range; safe_end keeps writers out of it until it is zero. */
+    s->file_end = prealloc_end;
+    if (s->prealloc_in_flight++ == 0 || prealloc_start < s->safe_end) {
+        qatomic_set(&s->safe_end, prealloc_start);
+    }
+    qemu_co_mutex_unlock(&s->lock);
+
     ret = bdrv_co_pwrite_zeroes(
             bs->file, prealloc_start, prealloc_end - prealloc_start,
             BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
+
+    qemu_co_mutex_lock(&s->lock);
     if (ret < 0) {
         s->file_end = ret;
-        return false;
     }
+    if (--s->prealloc_in_flight == 0) {
+        qatomic_set(&s->safe_end, s->file_end);
+    }
+    qemu_co_queue_restart_all(&s->prealloc_waiters);
 
-    s->file_end = prealloc_end;
-    return want_merge_zero;
+    return ret < 0 ? false : want_merge_zero;
 }
 
 static bool coroutine_fn GRAPH_RDLOCK
@@ -412,9 +451,22 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
              bool want_merge_zero)
 {
     BDRVPreallocateState *s = bs->opaque;
+    int64_t zero_start = qatomic_read(&s->zero_start);
+    int64_t end = offset + bytes;
     bool ret;
 
+    /*
+     * Below zero_start there is nothing to record: data_end covers it, and
+     * only a write zeroes that already covers it can preallocate over it.
+     */
+    if (zero_start >= 0 && end <= zero_start) {
+        return false;
+    }
+
     qemu_co_mutex_lock(&s->lock);
+    while (s->prealloc_in_flight && (s->safe_end < 0 || end > s->safe_end)) {
+        qemu_co_queue_wait(&s->prealloc_waiters, &s->lock);
+    }
     ret = handle_write_locked(bs, offset, bytes, want_merge_zero);
     qemu_co_mutex_unlock(&s->lock);
 
@@ -456,7 +508,7 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
 
     if (s->data_end >= 0 && offset > s->data_end) {
         if (s->file_end < 0) {
-            s->file_end = bdrv_co_getlength(bs->file->bs);
+            preallocate_set_file_end(s, bdrv_co_getlength(bs->file->bs));
             if (s->file_end < 0) {
                 error_setg(errp, "failed to get file length");
                 return s->file_end;
@@ -471,7 +523,7 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
              * Otherwise just proceed to preallocate missing part.
              */
             if (offset <= s->file_end) {
-                s->data_end = offset;
+                qatomic_set(&s->data_end, offset);
                 return 0;
             }
         } else {
@@ -488,16 +540,16 @@ preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
                 ret = bdrv_co_truncate(bs->file, s->data_end, true,
                                        PREALLOC_MODE_OFF, 0, errp);
                 if (ret < 0) {
-                    s->file_end = ret;
+                    preallocate_set_file_end(s, ret);
                     error_prepend(errp, "preallocate-filter: failed to drop "
                                   "write-zero preallocation: ");
                     return ret;
                 }
-                s->file_end = s->data_end;
+                preallocate_set_file_end(s, s->data_end);
             }
         }
 
-        s->data_end = offset;
+        qatomic_set(&s->data_end, offset);
     }
 
     ret = bdrv_co_truncate(bs->file, offset, exact, prealloc, flags, errp);
@@ -522,6 +574,11 @@ preallocate_co_getlength(BlockDriverState *bs)
 {
     int64_t ret;
     BDRVPreallocateState *s = bs->opaque;
+    int64_t data_end = qatomic_read(&s->data_end);
+
+    if (data_end >= 0) {
+        return data_end;
+    }
 
     qemu_co_mutex_lock(&s->lock);
     if (s->data_end >= 0) {
-- 
2.53.0


