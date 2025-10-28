Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798E6CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmew-0008Vc-Rb; Tue, 28 Oct 2025 12:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmek-0008Hx-CD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vDmeX-0003kt-HJ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 12:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761669268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTGB8gOhueJ3jKj4uM+Nweg0jGwZeEwR9/cdDjlApd8=;
 b=FHvxDRtvlwpLN0pbJnLAdnTZngEFcdQ+Va3vbP5sabguRswiwL/vlklZ7WjHiJ72AAdooZ
 gaXUJd9uoZhheb8Oth4LRYhqMMhDyifgDv5HKkjn/3DVCmApTBtSzbcVs20M0CadngiqR0
 kxWTAlGFp5Vw4dfX0H3eHybOmGq75mY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-pTywmqgvPRaMTwbN_sFc5g-1; Tue, 28 Oct 2025 12:34:20 -0400
X-MC-Unique: pTywmqgvPRaMTwbN_sFc5g-1
X-Mimecast-MFC-AGG-ID: pTywmqgvPRaMTwbN_sFc5g_1761669260
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4270a61ec48so5277389f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 09:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761669260; x=1762274060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTGB8gOhueJ3jKj4uM+Nweg0jGwZeEwR9/cdDjlApd8=;
 b=TC8gx12v3OulDqiP/NKsDyr5cTLkS0OwAcmKVUzJWCyN/lTcwRRVdOxw+MZnOj/p4R
 ZohkO8hbGT65XCc73yd7b+ligkw+GxMP7YPEfvjDCp+JKr2LwqMUvL3b8xbxcA6Z7g+H
 LKmBVP5aeQKm2RDMkHxem2J2rffaWlRVBLrz6+QZ8tXVjZh7n6MIajSqvQj/nvn6kRki
 2SHhtFDdlZ/bVdJmE2WJLG0x1YEWU+gohqXJTXqv3kaICbn7hsfXnpilZFpnFQG8mMBk
 WsH17jltV/YPCVWWe2JCDPsvP8CSg4pKOch8bEQXCE3F4RkVTLCduxiAyFYSvhS3Yv09
 I1Eg==
X-Gm-Message-State: AOJu0YxEYa1zNrvh2o7uXvM6EY8x4guPstphiw+3PxG1U/oeS7bX4zFq
 CTxWj2YZeZLEXQcWHmLT6Slmg5ojySP1yCizQ0zrbVXYHy8encCxG5MzQ4wZur02TDiDMgxMw81
 2L0DL6P9qXYoltPDBssZgX1UyeOXDjV0Gtn1YN9Jp/bPeO32/jiKddUjF
X-Gm-Gg: ASbGncvEXUFMSEyliPUXK0WrkbU/wmU0vTA9TxTs0mKajMke5WhnogOFiVIw5/I8TbF
 GVUNP+nPMhb1dSttHF27+K2ruswTULNV38bGAd5RvvgG07zS+xrj57OrPAWM5HCJ++CWFDK2/oS
 ZJwPU1yRuiJXrXGdXrdnLUcKSaWJlnf6TlMqNsHh+8a0pQacK8wEJJmnqkTfZEk6dRrJkB9Bryt
 mykAVFVso1IKyzhtoBS8V/CY1bQGdXZCkkBvy7oX3Ng7pWqNdBdDvV/VDycS1AKec1fb0oarSRL
 wFj2m28L5XyidYA0mgkqqSew5kNr9DEUKDhBv+6Jq0cDgaaNSC/UOOwBq2lQF8MEylLkXo4MRkn
 w4VXqHX94eFKcGfkp124HZI1O/LBjATzNcqZ5XeTs9GLDchAq5FSCqa89dQ==
X-Received: by 2002:a5d:5d0a:0:b0:427:813:6a52 with SMTP id
 ffacd0b85a97d-429a7e70961mr3572700f8f.41.1761669259619; 
 Tue, 28 Oct 2025 09:34:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgiPk4ivQXzTZpUOqP59lyKINIYmn+GCplZZI23RCIrh4aXGl9lu6VQxQU5tAs5CtKaL7ubA==
X-Received: by 2002:a5d:5d0a:0:b0:427:813:6a52 with SMTP id
 ffacd0b85a97d-429a7e70961mr3572667f8f.41.1761669259134; 
 Tue, 28 Oct 2025 09:34:19 -0700 (PDT)
Received: from localhost
 (p200300cfd7171feeff88afa910cb665f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fee:ff88:afa9:10cb:665f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b22sm20964879f8f.9.2025.10.28.09.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 09:34:16 -0700 (PDT)
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
Subject: [PATCH 10/16] qcow2: Fix cache_clean_timer
Date: Tue, 28 Oct 2025 17:33:36 +0100
Message-ID: <20251028163343.116249-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028163343.116249-1-hreitz@redhat.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The cache-cleaner runs as a timer CB in the BDS AioContext.  With
multiqueue, it can run concurrently to I/O requests, and because it does
not take any lock, this can break concurrent cache accesses, corrupting
the image.  While the chances of this happening are low, it can be
reproduced e.g. by modifying the code to schedule the timer CB every
5 ms (instead of at most once per second) and modifying the last (inner)
while loop of qcow2_cache_clean_unused() like so:

    while (i < c->size && can_clean_entry(c, i)) {
        for (int j = 0; j < 1000 && can_clean_entry(c, i); j++) {
            usleep(100);
        }
        c->entries[i].offset = 0;
        c->entries[i].lru_counter = 0;
        i++;
        to_clean++;
    }

i.e. making it wait on purpose for the point in time where the cache is
in use by something else.

The solution chosen for this in this patch is not the best solution, I
hope, but I admittedly can’t come up with anything strictly better.

We can protect from concurrent cache accesses either by taking the
existing s->lock, or we introduce a new (non-coroutine) mutex
specifically for cache accesses.  I would prefer to avoid the latter so
as not to introduce additional (very slight) overhead.

Using s->lock, which is a coroutine mutex, however means that we need to
take it in a coroutine, so the timer CB must enter such a coroutine.  As
a result, descheduling the timer is no longer a guarantee that the
cache-cleaner will not run, because it may now be yielding in
qemu_co_mutex_lock().

(Note even now this was only guaranteed for cache_clean_timer_del()
callers that run in the BDS (the timer’s) AioContext.  For callers
running in the main context, the problem may have already existed,
though maybe the BQL prevents timers from running in other contexts, I’m
not sure.)

Polling to await the timer to actually settle seems very complicated for
something that’s rather a minor problem, but I can’t come up with any
better solution that doesn’t again just overlook potential problems.

(One cleaner idea may be to have a generic way to have timers run
coroutines, and to await those when descheduling the timer.  But while
cleaner, it would also be more complicated, and I don’t think worth it
at this point.)

(Not Cc-ing qemu-stable, as the issue is quite unlikely to be hit, and
I’m not too fond of this solution.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.h |  1 +
 block/qcow2.c | 90 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..272d34def1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -347,6 +347,7 @@ typedef struct BDRVQcow2State {
     Qcow2Cache *refcount_block_cache;
     QEMUTimer *cache_clean_timer;
     unsigned cache_clean_interval;
+    bool cache_clean_running, cache_clean_polling;
 
     QLIST_HEAD(, QCowL2Meta) cluster_allocs;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 4aa9f9e068..ef851794c3 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -835,12 +835,38 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
     [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
 };
 
-static void cache_clean_timer_cb(void *opaque)
+static void coroutine_fn cache_clean_timer_co(void *opaque)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
+
+    qemu_co_mutex_lock(&s->lock);
+    if (!s->cache_clean_timer) {
+        /* cache_clean_timer_del() has been called, skip doing anything */
+        goto out;
+    }
     qcow2_cache_clean_unused(s->l2_table_cache);
     qcow2_cache_clean_unused(s->refcount_block_cache);
+
+out:
+    qemu_co_mutex_unlock(&s->lock);
+    qatomic_set(&s->cache_clean_running, false);
+    if (qatomic_xchg(&s->cache_clean_polling, false)) {
+        aio_wait_kick();
+    }
+}
+
+static void cache_clean_timer_cb(void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    BDRVQcow2State *s = bs->opaque;
+    Coroutine *co;
+
+    co = qemu_coroutine_create(cache_clean_timer_co, bs);
+    /* cleared in cache_clean_timer_co() */
+    qatomic_set(&s->cache_clean_running, true);
+    qemu_coroutine_enter(co);
+
     timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
               (int64_t) s->cache_clean_interval * 1000);
 }
@@ -867,6 +893,39 @@ static void cache_clean_timer_del(BlockDriverState *bs)
     }
 }
 
+/*
+ * Delete the cache clean timer and await any yet running instance.
+ * Must be called from the main or BDS AioContext, holding s->lock.
+ */
+static void coroutine_fn
+cache_clean_timer_locked_co_del_and_wait(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    IO_OR_GS_CODE();
+    cache_clean_timer_del(bs);
+    if (qatomic_read(&s->cache_clean_running)) {
+        qemu_co_mutex_unlock(&s->lock);
+        qatomic_set(&s->cache_clean_polling, true);
+        BDRV_POLL_WHILE(bs, qatomic_read(&s->cache_clean_running));
+        qemu_co_mutex_lock(&s->lock);
+    }
+}
+
+/*
+ * Delete the cache clean timer and await any yet running instance.
+ * Must be called from the main or BDS AioContext without s->lock held.
+ */
+static void cache_clean_timer_del_and_wait(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+    IO_OR_GS_CODE();
+    cache_clean_timer_del(bs);
+    if (qatomic_read(&s->cache_clean_running)) {
+        qatomic_set(&s->cache_clean_polling, true);
+        BDRV_POLL_WHILE(bs, qatomic_read(&s->cache_clean_running));
+    }
+}
+
 static void qcow2_detach_aio_context(BlockDriverState *bs)
 {
     cache_clean_timer_del(bs);
@@ -1214,12 +1273,20 @@ fail:
     return ret;
 }
 
+/* s_locked specifies whether s->lock is held or not */
 static void qcow2_update_options_commit(BlockDriverState *bs,
-                                        Qcow2ReopenState *r)
+                                        Qcow2ReopenState *r,
+                                        bool s_locked)
 {
     BDRVQcow2State *s = bs->opaque;
     int i;
 
+    if (s_locked) {
+        cache_clean_timer_locked_co_del_and_wait(bs);
+    } else {
+        cache_clean_timer_del_and_wait(bs);
+    }
+
     if (s->l2_table_cache) {
         qcow2_cache_destroy(s->l2_table_cache);
     }
@@ -1228,6 +1295,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
     }
     s->l2_table_cache = r->l2_table_cache;
     s->refcount_block_cache = r->refcount_block_cache;
+
+    s->cache_clean_interval = r->cache_clean_interval;
+    cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
+
     s->l2_slice_size = r->l2_slice_size;
 
     s->overlap_check = r->overlap_check;
@@ -1239,12 +1310,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
 
     s->discard_no_unref = r->discard_no_unref;
 
-    if (s->cache_clean_interval != r->cache_clean_interval) {
-        cache_clean_timer_del(bs);
-        s->cache_clean_interval = r->cache_clean_interval;
-        cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
-    }
-
     qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
     s->crypto_opts = r->crypto_opts;
 }
@@ -1261,6 +1326,7 @@ static void qcow2_update_options_abort(BlockDriverState *bs,
     qapi_free_QCryptoBlockOpenOptions(r->crypto_opts);
 }
 
+/* Called with s->lock held */
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_update_options(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
@@ -1270,7 +1336,7 @@ qcow2_update_options(BlockDriverState *bs, QDict *options, int flags,
 
     ret = qcow2_update_options_prepare(bs, &r, options, flags, errp);
     if (ret >= 0) {
-        qcow2_update_options_commit(bs, &r);
+        qcow2_update_options_commit(bs, &r, true);
     } else {
         qcow2_update_options_abort(bs, &r);
     }
@@ -1908,7 +1974,7 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_vfree(s->l1_table);
     /* else pre-write overlap checks in cache_destroy may crash */
     s->l1_table = NULL;
-    cache_clean_timer_del(bs);
+    cache_clean_timer_locked_co_del_and_wait(bs);
     if (s->l2_table_cache) {
         qcow2_cache_destroy(s->l2_table_cache);
     }
@@ -2048,7 +2114,7 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    qcow2_update_options_commit(state->bs, state->opaque);
+    qcow2_update_options_commit(state->bs, state->opaque, false);
     if (!s->data_file) {
         /*
          * If we don't have an external data file, s->data_file was cleared by
@@ -2805,7 +2871,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
         qcow2_inactivate(bs);
     }
 
-    cache_clean_timer_del(bs);
+    cache_clean_timer_del_and_wait(bs);
     qcow2_cache_destroy(s->l2_table_cache);
     qcow2_cache_destroy(s->refcount_block_cache);
 
-- 
2.51.0


