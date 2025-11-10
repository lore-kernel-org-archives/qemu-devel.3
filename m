Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49FBCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU9p-0007wN-0g; Mon, 10 Nov 2025 10:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9K-00072Q-3N
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU9H-00011m-B6
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axvsIn5J5PmuBysJYDENSvNzEyMwBuBNOcFRZTNar0U=;
 b=czHVgJeRtQlvbAlibzIa/c0JfLj8uVPt+H4jZUwChkyVsaDzC8s6iFPlmlZKGWVc1/e0MA
 TgxQZrNuIX4ek/Gx4SJuRihwyCyefOlvm/BaU+2H9UnI+EffSUJbmX9UJ2hGc947w/1UYV
 2z5caYh897KWT9JDidZzna/Ke5wC+S4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-P6pAiWKIM1GOff_F7YgaFQ-1; Mon, 10 Nov 2025 10:49:41 -0500
X-MC-Unique: P6pAiWKIM1GOff_F7YgaFQ-1
X-Mimecast-MFC-AGG-ID: P6pAiWKIM1GOff_F7YgaFQ_1762789780
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106720618so22001085e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789780; x=1763394580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axvsIn5J5PmuBysJYDENSvNzEyMwBuBNOcFRZTNar0U=;
 b=bRoQdFAFBE7KrJYAsoagfccTZrY+ZrmJkfRKzyIvIyRa1olsNggu34kYDz9Usf1HXR
 Mz3deInBGZNc8Tiu0RgyFvcubJ8H3dRjmSrLDRC3kaJF1TYaGZ951X8fmszMi3JNuqvv
 CK0xo9dO2t5DHBucAPheZBSAi9unLDM6FMcZFi6kR98qi/iMS0PWtEgMfiQUc3iNfkjC
 V1kP9X5Y9soLi9sITWzgvv8oJwnWaZtuoOkIHEqwXoCpim+48AxejPDXF3bwZ7S9JLKX
 Gqeq+ZQZd3h6OLi6Bxoil5fLpzJt2hbwXbmKLuWxcJbhRb6IZ24jPiIuaWVoFgZSE8YS
 Yn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789780; x=1763394580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axvsIn5J5PmuBysJYDENSvNzEyMwBuBNOcFRZTNar0U=;
 b=HKQ6ev6ttddMAKDn3NECNpL4Ew4ZSovEZISe9Qac9loQevRTW1vFDWRITRY64CE8Qr
 np1E22mb+NT+hElWi4UhOHfTE5UbgOiX39racRr6NID9awBn6ofxGiJKtOGUmNJhtYcM
 1Z+qkx8QfmzttK4E1Z4z8696PhV3DDHVv8fMaC4DefC8YWIdRh+UHhH3YMhMKXYDiXI4
 Z8muGZGDhn6DD6JEk9jTTMvZoyesZPd+e1zrMF0mWvwT+ITPgkP9sUsDNoZNMRTIqnwQ
 RsFhT/TQfYgo/OSNXL0vW79cbYW8zeR6lCDyHS8vOX6mNOrZUO7h2L+9DQXjcYRlCb5+
 gfxg==
X-Gm-Message-State: AOJu0Yx6Sfil8fXJcSYl7QSuwiWB7xZgS+4J8MPWksmhnTk31xFDHaa0
 Nmjtcly3zTntQT5UbVdNI1Og3xHYt8NzhWvmfqrJVvYeUVzCLl7XFOknL/dgVqGgWmv5tZ/aJOM
 9Fc6WMEnRQYjiaUYXA5wZ6xJ4NHsSDcfPx4S0592N5eZwRJcMv1CqjhRL
X-Gm-Gg: ASbGnctZXH5/lMxk2vp7FvELJe+Z+ksqvY89/HSzGmJsiIwsZYk53BRw32yssjEIEH3
 thmkdd1x8CQBwhhYM6WM4U6ujT9+3QiW3E2oF8oP37gWfVIhVD+GfohDwCzidsdxAtSfPHA7Gop
 YlaFN0+zZCmLjGk743SNxfrumeGj0xQ+luTc6ErAASmIjrQPTY8tNCvONyc3PaBHiGQkWidhB//
 f2+U/lYQvXe/cBnrz/1nbY94soDKs3LY2q38jxkPqPDZbFbP97CVuObURLudCIxZZhxaVrg/L/R
 VHhJkOW2uuWdbRscBNFSlCtCv8BC1JECMZf/HKl98jF7eDPUQh6L2+EJlKSZzXAYHky0dTj6Y5J
 JpzX81XW75b60MddnKf8E1Ai3PR6H0wHrKhbd25J2DNbmye8xuGUWrHX4fQ==
X-Received: by 2002:a05:600c:4f94:b0:475:df09:c253 with SMTP id
 5b1f17b1804b1-47773288f90mr77531635e9.38.1762789779623; 
 Mon, 10 Nov 2025 07:49:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFNahU8Mvbp+x6DKJNBFfhMNOHPkt0zXulSom/UII9P+NJcDSlTZli0bz/maN/jVD9kYOsaw==
X-Received: by 2002:a05:600c:4f94:b0:475:df09:c253 with SMTP id
 5b1f17b1804b1-47773288f90mr77531315e9.38.1762789779190; 
 Mon, 10 Nov 2025 07:49:39 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e7a6desm110558515e9.8.2025.11.10.07.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:37 -0800 (PST)
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
Subject: [PATCH v2 12/19] qcow2: Fix cache_clean_timer
Date: Mon, 10 Nov 2025 16:48:47 +0100
Message-ID: <20251110154854.151484-13-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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
take it in a coroutine, so the timer must run in a coroutine.  We can
transform it from the current timer CB style into a coroutine that
sleeps for the set interval.  As a result, however, we can no longer
just deschedule the timer to instantly guarantee it won’t run anymore,
but have to await the coroutine’s exit.

(Note even before this patch there were places that may not have been so
guaranteed after all: Anything calling cache_clean_timer_del() from the
QEMU main AioContext could have been running concurrently to an existing
timer CB invocation.)

Polling to await the timer to actually settle seems very complicated for
something that’s rather a minor problem, but I can’t come up with any
better solution that doesn’t again just overlook potential problems.

(Not Cc-ing qemu-stable, as the issue is quite unlikely to be hit, and
I’m not too fond of this solution.)

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/qcow2.h |   5 +-
 block/qcow2.c | 143 ++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 118 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..3e38bccd87 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -345,8 +345,11 @@ typedef struct BDRVQcow2State {
 
     Qcow2Cache *l2_table_cache;
     Qcow2Cache *refcount_block_cache;
-    QEMUTimer *cache_clean_timer;
+    /* Non-NULL while the timer is running */
+    Coroutine *cache_clean_timer_co;
     unsigned cache_clean_interval;
+    QemuCoSleep cache_clean_timer_wake;
+    CoQueue cache_clean_timer_exit;
 
     QLIST_HEAD(, QCowL2Meta) cluster_allocs;
 
diff --git a/block/qcow2.c b/block/qcow2.c
index d6e38926c8..ecff3bed0e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -835,41 +835,113 @@ static const char *overlap_bool_option_names[QCOW2_OL_MAX_BITNR] = {
     [QCOW2_OL_BITMAP_DIRECTORY_BITNR] = QCOW2_OPT_OVERLAP_BITMAP_DIRECTORY,
 };
 
-static void cache_clean_timer_cb(void *opaque)
+static void coroutine_fn cache_clean_timer(void *opaque)
 {
-    BlockDriverState *bs = opaque;
-    BDRVQcow2State *s = bs->opaque;
-    qcow2_cache_clean_unused(s->l2_table_cache);
-    qcow2_cache_clean_unused(s->refcount_block_cache);
-    timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-              (int64_t) s->cache_clean_interval * 1000);
+    BDRVQcow2State *s = opaque;
+    uint64_t wait_ns;
+
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
+    }
+
+    while (wait_ns > 0) {
+        qemu_co_sleep_ns_wakeable(&s->cache_clean_timer_wake,
+                                  QEMU_CLOCK_VIRTUAL, wait_ns);
+
+        WITH_QEMU_LOCK_GUARD(&s->lock) {
+            if (s->cache_clean_interval > 0) {
+                qcow2_cache_clean_unused(s->l2_table_cache);
+                qcow2_cache_clean_unused(s->refcount_block_cache);
+            }
+
+            wait_ns = s->cache_clean_interval * NANOSECONDS_PER_SECOND;
+        }
+    }
+
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        s->cache_clean_timer_co = NULL;
+        qemu_co_queue_restart_all(&s->cache_clean_timer_exit);
+    }
 }
 
 static void cache_clean_timer_init(BlockDriverState *bs, AioContext *context)
 {
     BDRVQcow2State *s = bs->opaque;
     if (s->cache_clean_interval > 0) {
-        s->cache_clean_timer =
-            aio_timer_new_with_attrs(context, QEMU_CLOCK_VIRTUAL,
-                                     SCALE_MS, QEMU_TIMER_ATTR_EXTERNAL,
-                                     cache_clean_timer_cb, bs);
-        timer_mod(s->cache_clean_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
-                  (int64_t) s->cache_clean_interval * 1000);
+        assert(!s->cache_clean_timer_co);
+        s->cache_clean_timer_co = qemu_coroutine_create(cache_clean_timer, s);
+        aio_co_enter(context, s->cache_clean_timer_co);
+    }
+}
+
+/**
+ * Delete the cache clean timer and await any yet running instance.
+ * Called holding s->lock.
+ */
+static void coroutine_fn
+cache_clean_timer_co_locked_del_and_wait(BlockDriverState *bs)
+{
+    BDRVQcow2State *s = bs->opaque;
+
+    if (s->cache_clean_timer_co) {
+        s->cache_clean_interval = 0;
+        qemu_co_sleep_wake(&s->cache_clean_timer_wake);
+        qemu_co_queue_wait(&s->cache_clean_timer_exit, &s->lock);
     }
 }
 
-static void cache_clean_timer_del(BlockDriverState *bs)
+/**
+ * Same as cache_clean_timer_co_locked_del_and_wait(), but takes s->lock.
+ */
+static void coroutine_fn
+cache_clean_timer_co_del_and_wait(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
-    if (s->cache_clean_timer) {
-        timer_free(s->cache_clean_timer);
-        s->cache_clean_timer = NULL;
+
+    WITH_QEMU_LOCK_GUARD(&s->lock) {
+        cache_clean_timer_co_locked_del_and_wait(bs);
+    }
+}
+
+struct CacheCleanTimerDelAndWaitCoParams {
+    BlockDriverState *bs;
+    bool done;
+};
+
+static void coroutine_fn cache_clean_timer_del_and_wait_co_entry(void *opaque)
+{
+    struct CacheCleanTimerDelAndWaitCoParams *p = opaque;
+
+    cache_clean_timer_co_del_and_wait(p->bs);
+    p->done = true;
+    aio_wait_kick();
+}
+
+/**
+ * Delete the cache clean timer and await any yet running instance.
+ * Must be called from the main or BDS AioContext without s->lock held.
+ */
+static void coroutine_mixed_fn
+cache_clean_timer_del_and_wait(BlockDriverState *bs)
+{
+    IO_OR_GS_CODE();
+
+    if (qemu_in_coroutine()) {
+        cache_clean_timer_co_del_and_wait(bs);
+    } else {
+        struct CacheCleanTimerDelAndWaitCoParams p = { .bs = bs };
+        Coroutine *co;
+
+        co = qemu_coroutine_create(cache_clean_timer_del_and_wait_co_entry, &p);
+        qemu_coroutine_enter(co);
+
+        BDRV_POLL_WHILE(bs, !p.done);
     }
 }
 
 static void qcow2_detach_aio_context(BlockDriverState *bs)
 {
-    cache_clean_timer_del(bs);
+    cache_clean_timer_del_and_wait(bs);
 }
 
 static void qcow2_attach_aio_context(BlockDriverState *bs,
@@ -1214,12 +1286,24 @@ fail:
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
 
+    /*
+     * We need to stop the cache-clean-timer before destroying the metadata
+     * table caches
+     */
+    if (s_locked) {
+        cache_clean_timer_co_locked_del_and_wait(bs);
+    } else {
+        cache_clean_timer_del_and_wait(bs);
+    }
+
     if (s->l2_table_cache) {
         qcow2_cache_destroy(s->l2_table_cache);
     }
@@ -1228,6 +1312,10 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
     }
     s->l2_table_cache = r->l2_table_cache;
     s->refcount_block_cache = r->refcount_block_cache;
+
+    s->cache_clean_interval = r->cache_clean_interval;
+    cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
+
     s->l2_slice_size = r->l2_slice_size;
 
     s->overlap_check = r->overlap_check;
@@ -1239,12 +1327,6 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
 
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
@@ -1261,6 +1343,7 @@ static void qcow2_update_options_abort(BlockDriverState *bs,
     qapi_free_QCryptoBlockOpenOptions(r->crypto_opts);
 }
 
+/* Called with s->lock held */
 static int coroutine_fn GRAPH_RDLOCK
 qcow2_update_options(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
@@ -1270,7 +1353,7 @@ qcow2_update_options(BlockDriverState *bs, QDict *options, int flags,
 
     ret = qcow2_update_options_prepare(bs, &r, options, flags, errp);
     if (ret >= 0) {
-        qcow2_update_options_commit(bs, &r);
+        qcow2_update_options_commit(bs, &r, true);
     } else {
         qcow2_update_options_abort(bs, &r);
     }
@@ -1908,7 +1991,7 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_vfree(s->l1_table);
     /* else pre-write overlap checks in cache_destroy may crash */
     s->l1_table = NULL;
-    cache_clean_timer_del(bs);
+    cache_clean_timer_co_locked_del_and_wait(bs);
     if (s->l2_table_cache) {
         qcow2_cache_destroy(s->l2_table_cache);
     }
@@ -1963,6 +2046,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* Initialise locks */
     qemu_co_mutex_init(&s->lock);
+    qemu_co_queue_init(&s->cache_clean_timer_exit);
 
     assert(!qemu_in_coroutine());
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
@@ -2048,7 +2132,7 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
-    qcow2_update_options_commit(state->bs, state->opaque);
+    qcow2_update_options_commit(state->bs, state->opaque, false);
     if (!s->data_file) {
         /*
          * If we don't have an external data file, s->data_file was cleared by
@@ -2805,7 +2889,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
         qcow2_inactivate(bs);
     }
 
-    cache_clean_timer_del(bs);
+    cache_clean_timer_del_and_wait(bs);
     qcow2_cache_destroy(s->l2_table_cache);
     qcow2_cache_destroy(s->refcount_block_cache);
 
@@ -2875,6 +2959,7 @@ qcow2_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     s->data_file = data_file;
     /* Re-initialize objects initialized in qcow2_open() */
     qemu_co_mutex_init(&s->lock);
+    qemu_co_queue_init(&s->cache_clean_timer_exit);
 
     options = qdict_clone_shallow(bs->options);
 
-- 
2.51.1


