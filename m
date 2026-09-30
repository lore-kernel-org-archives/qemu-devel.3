Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EB6CA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxW7-0007pn-J4; Wed, 30 Sep 2026 12:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVc-0006Xh-HR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:22 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBxVW-0003XI-Iu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:50:19 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d822dso41602195e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790787013; x=1791391813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MDB6UCDP9ACMXLxVZ73TiOCWYZoH42ANfONkVN56IH0=;
 b=ccQfoTKAqlP3KPkhj75CCYF+kbLu79p6ro2ECmEKs1551skSN+aHRjec8WlOjJvJvn
 qHoLOYSNvbFc3W1/TW4TglwBttqtwYUoTPjnSEBxcd1oM3bKsdqXKtBoM0ZiUqS6Y1an
 6xsDVsBTy8W1p1aLRc5dqpMZBuN9wFH1QfTTfye+rZeC6hwnJe+lZIM7HzgXu4lpuaTj
 2sUnMHH8kt2ssk9uoxD+HiWUdBnPZ7uwEExoDV7Qqan6yYnanYigNBppb9EYTSPvaDHQ
 g3yo9LvQ78i9xkU8nFniRxuTj7egPlS6ps9reY3RfB6pFXwY6AYozFvYdRvUM+i6jMFL
 57DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787013; x=1791391813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MDB6UCDP9ACMXLxVZ73TiOCWYZoH42ANfONkVN56IH0=;
 b=0HrlNfyD2A+8xnxOQoSS1hLb33ZykAKLC9bN5yo2uFAx+3VhUwmLMYcU6ZRAJcn6Le
 NIupq2K1DUGOXTdZ09/UhWVmZ14NJftvk5FHYDPcGQBsAnE+lLQY0oesZGOy3elyswoZ
 P42VIDPJBQjaYXQthZ0GzzPdb9HkeZUdxTEgJYXz359gs2sYwuSvuqv1PSf2hsq98RUZ
 fD+uZXAm1mxsOFO89l9F+Kkf16rSOVVIb1WrOk+BKdkTk8LBBvDyU5uQjfdN3ZIDlAlj
 NKVttClxQ4U6mOjTKB319m7Pj6qk4frQLWyyZVydIgffcnTOKgafWigCyfDJ9vaaVXL/
 wMEQ==
X-Gm-Message-State: AFuF++ki0eLguhqRhKtiQ8taH68UCcazm9WhFFTuBe0afGyXifMsIbIL
 4WX4GAaZ2r2ZKfDdHprpqK8HgdA3WpSkC+Bd/YQkP3oA685e0vhARmrBsllvWXFDWibO0KyiI/S
 tUi99
X-Gm-Gg: AYBFou3Kumvm0B/C7X5scpX7BVHnRJ8Sdm1mA3Ju24NJhCkSCVADNL58Xw41FTFkVcq
 Kymf1EJkxHvlWgbW9tJ0L1q8+ta1kk9rEgxmLp45ZaCmnwMnRQg+wK266F4qhOJyVhAm21+66rO
 eEvg717xjaZPdiuEuOpGU9JbMggCG3WY3wIdWfBCvMjF9KZRQVgqDTardHZHGXySq8321RNL9c2
 AszRPcoCsk+mBoQB26CGLg9P8+x/Uq3dsYeSOQuLJoLGSp3XvWgYZh7MHAZuyVppdZz+Q//puMD
 Fv61qJyAeHrHY1FHLKZYjVdZ5/4g51/f5Ps6wA06rAgQux7ABus1cLITMv2ckQ2ygWQf3a1cfAG
 7cz3jAkUAPGUBKAui6rTAyC3vpOt3OZj1I1sYFQI9yCcoH2bLv5mXbtPeJVfaFGazZu4C9BTKN3
 2zKrOyD7mwlTiWAH9TCIPEyBVcPimm4m5WWh2O49DBrbrVKsbRw0tp4EY2DOVMzKGxomq0X11bk
 XFCug==
X-Received: by 2002:a05:600c:8b88:b0:4a0:62d:4424 with SMTP id
 5b1f17b1804b1-4a01addebd5mr31620675e9.8.1790787013015; 
 Wed, 30 Sep 2026 09:50:13 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:c6b8:98e2:93f0:2de6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eb71d57sm4144535e9.9.2026.09.30.09.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:50:12 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 07/13] tests/unit: prefix the iothread test helper
Date: Wed, 30 Sep 2026 18:49:53 +0200
Message-ID: <20260930165000.303236-8-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930165000.303236-1-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

tests/unit/iothread.c defines a struct IOThread and an
iothread_get_aio_context() under the same names as the IOThread QOM
object in iothread.c, so nothing that links the real object can use
the helper. Prefix the helper and its type with test_ and Test.

This is preparation for building the QOM object into the block layer.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/unit/iothread.c             | 28 +++++++++++++--------------
 tests/unit/iothread.h             |  8 ++++----
 tests/unit/test-aio-multithread.c |  8 ++++----
 tests/unit/test-bdrv-drain.c      | 32 +++++++++++++++----------------
 tests/unit/test-block-iothread.c  | 28 +++++++++++++--------------
 5 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/tests/unit/iothread.c b/tests/unit/iothread.c
index a363bf8f70..ff05ae8b11 100644
--- a/tests/unit/iothread.c
+++ b/tests/unit/iothread.c
@@ -19,7 +19,7 @@
 #include "qemu/rcu.h"
 #include "iothread.h"
 
-struct IOThread {
+struct TestIOThread {
     AioContext *ctx;
     GMainContext *worker_context;
     GMainLoop *main_loop;
@@ -30,20 +30,20 @@ struct IOThread {
     bool stopping;
 };
 
-static void iothread_init_gcontext(IOThread *iothread)
+static void test_iothread_init_gcontext(TestIOThread *iothread)
 {
     GSource *source;
 
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    source = aio_get_g_source(test_iothread_get_aio_context(iothread));
     g_source_attach(source, iothread->worker_context);
     g_source_unref(source);
     iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
 }
 
-static void *iothread_run(void *opaque)
+static void *test_iothread_run(void *opaque)
 {
-    IOThread *iothread = opaque;
+    TestIOThread *iothread = opaque;
 
     rcu_register_thread();
 
@@ -56,7 +56,7 @@ static void *iothread_run(void *opaque)
      * of glib the g_source_ref()/unref() functions are not threadsafe
      * on sources without a context.
      */
-    iothread_init_gcontext(iothread);
+    test_iothread_init_gcontext(iothread);
 
     /*
      * g_main_context_push_thread_default() must be called before anything
@@ -76,16 +76,16 @@ static void *iothread_run(void *opaque)
     return NULL;
 }
 
-static void iothread_stop_bh(void *opaque)
+static void test_iothread_stop_bh(void *opaque)
 {
-    IOThread *iothread = opaque;
+    TestIOThread *iothread = opaque;
 
     iothread->stopping = true;
 }
 
-void iothread_join(IOThread *iothread)
+void test_iothread_join(TestIOThread *iothread)
 {
-    aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
+    aio_bh_schedule_oneshot(iothread->ctx, test_iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
     g_main_context_unref(iothread->worker_context);
     g_main_loop_unref(iothread->main_loop);
@@ -95,13 +95,13 @@ void iothread_join(IOThread *iothread)
     g_free(iothread);
 }
 
-IOThread *iothread_new(void)
+TestIOThread *test_iothread_new(void)
 {
-    IOThread *iothread = g_new0(IOThread, 1);
+    TestIOThread *iothread = g_new0(TestIOThread, 1);
 
     qemu_mutex_init(&iothread->init_done_lock);
     qemu_cond_init(&iothread->init_done_cond);
-    qemu_thread_create(&iothread->thread, NULL, iothread_run,
+    qemu_thread_create(&iothread->thread, NULL, test_iothread_run,
                        iothread, QEMU_THREAD_JOINABLE);
 
     /* Wait for initialization to complete */
@@ -114,7 +114,7 @@ IOThread *iothread_new(void)
     return iothread;
 }
 
-AioContext *iothread_get_aio_context(IOThread *iothread)
+AioContext *test_iothread_get_aio_context(TestIOThread *iothread)
 {
     return iothread->ctx;
 }
diff --git a/tests/unit/iothread.h b/tests/unit/iothread.h
index eb4d0c77f8..8475170eaa 100644
--- a/tests/unit/iothread.h
+++ b/tests/unit/iothread.h
@@ -16,10 +16,10 @@
 #include "qemu/aio.h"
 #include "qemu/thread.h"
 
-typedef struct IOThread IOThread;
+typedef struct TestIOThread TestIOThread;
 
-IOThread *iothread_new(void);
-void iothread_join(IOThread *iothread);
-AioContext *iothread_get_aio_context(IOThread *iothread);
+TestIOThread *test_iothread_new(void);
+void test_iothread_join(TestIOThread *iothread);
+AioContext *test_iothread_get_aio_context(TestIOThread *iothread);
 
 #endif
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 9179cdc6a3..d07376455b 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -21,7 +21,7 @@
 
 #define NUM_CONTEXTS 5
 
-static IOThread *threads[NUM_CONTEXTS];
+static TestIOThread *threads[NUM_CONTEXTS];
 static AioContext *ctx[NUM_CONTEXTS];
 static __thread int id = -1;
 
@@ -68,8 +68,8 @@ static void create_aio_contexts(void)
     int i;
 
     for (i = 0; i < NUM_CONTEXTS; i++) {
-        threads[i] = iothread_new();
-        ctx[i] = iothread_get_aio_context(threads[i]);
+        threads[i] = test_iothread_new();
+        ctx[i] = test_iothread_get_aio_context(threads[i]);
     }
 
     qemu_event_init(&done_event, false);
@@ -88,7 +88,7 @@ static void join_aio_contexts(void)
         aio_context_ref(ctx[i]);
     }
     for (i = 0; i < NUM_CONTEXTS; i++) {
-        iothread_join(threads[i]);
+        test_iothread_join(threads[i]);
     }
     for (i = 0; i < NUM_CONTEXTS; i++) {
         aio_context_unref(ctx[i]);
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 43b0ba8648..a852874f74 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -535,10 +535,10 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
     int aio_ret;
     struct test_iothread_data data;
 
-    IOThread *a = iothread_new();
-    IOThread *b = iothread_new();
-    AioContext *ctx_a = iothread_get_aio_context(a);
-    AioContext *ctx_b = iothread_get_aio_context(b);
+    TestIOThread *a = test_iothread_new();
+    TestIOThread *b = test_iothread_new();
+    AioContext *ctx_a = test_iothread_get_aio_context(a);
+    AioContext *ctx_b = test_iothread_get_aio_context(b);
 
     QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
 
@@ -614,8 +614,8 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
     blk_unref(blk);
 
 out:
-    iothread_join(a);
-    iothread_join(b);
+    test_iothread_join(a);
+    test_iothread_join(b);
 }
 
 static void test_iothread_drain_all(void)
@@ -727,7 +727,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     BlockDriverState *src, *src_backing, *src_overlay, *target, *drain_bs;
     BlockJob *job;
     TestBlockJob *tjob;
-    IOThread *iothread = NULL;
+    TestIOThread *iothread = NULL;
     int ret = -1;
 
     src = bdrv_new_open_driver(&bdrv_test, "source", BDRV_O_RDWR,
@@ -761,8 +761,8 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     if (use_iothread) {
         AioContext *ctx;
 
-        iothread = iothread_new();
-        ctx = iothread_get_aio_context(iothread);
+        iothread = test_iothread_new();
+        ctx = test_iothread_get_aio_context(iothread);
         blk_set_aio_context(blk_src, ctx, &error_abort);
     }
 
@@ -893,7 +893,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     bdrv_unref(target);
 
     if (iothread) {
-        iothread_join(iothread);
+        test_iothread_join(iothread);
     }
 }
 
@@ -1396,10 +1396,10 @@ static void test_append_to_drained(void)
 static void test_set_aio_context(void)
 {
     BlockDriverState *bs;
-    IOThread *a = iothread_new();
-    IOThread *b = iothread_new();
-    AioContext *ctx_a = iothread_get_aio_context(a);
-    AioContext *ctx_b = iothread_get_aio_context(b);
+    TestIOThread *a = test_iothread_new();
+    TestIOThread *b = test_iothread_new();
+    AioContext *ctx_a = test_iothread_get_aio_context(a);
+    AioContext *ctx_b = test_iothread_get_aio_context(b);
 
     bs = bdrv_new_open_driver(&bdrv_test, "test-node", BDRV_O_RDWR,
                               &error_abort);
@@ -1410,8 +1410,8 @@ static void test_set_aio_context(void)
     bdrv_try_change_aio_context(bs, qemu_get_aio_context(), NULL, &error_abort);
 
     bdrv_unref(bs);
-    iothread_join(a);
-    iothread_join(b);
+    test_iothread_join(a);
+    test_iothread_join(b);
 }
 
 
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 5273ff235a..5a150adfe8 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -465,8 +465,8 @@ const SyncOpTest sync_op_tests[] = {
 static void test_sync_op(const void *opaque)
 {
     const SyncOpTest *t = opaque;
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     BlockBackend *blk;
     BlockDriverState *bs;
     BdrvChild *c;
@@ -548,8 +548,8 @@ BlockJobDriver test_job_driver = {
 
 static void test_attach_blockjob(void)
 {
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     BlockBackend *blk;
     BlockDriverState *bs;
     TestBlockJob *tjob;
@@ -611,8 +611,8 @@ static void test_attach_blockjob(void)
  */
 static void test_propagate_basic(void)
 {
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_verify;
@@ -675,8 +675,8 @@ static void test_propagate_basic(void)
  */
 static void test_propagate_diamond(void)
 {
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     AioContext *main_ctx;
     BlockBackend *blk;
     BlockDriverState *bs_a, *bs_b, *bs_c, *bs_verify;
@@ -740,8 +740,8 @@ static void test_propagate_diamond(void)
 
 static void test_propagate_mirror(void)
 {
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     AioContext *main_ctx = qemu_get_aio_context();
     BlockDriverState *src, *target, *filter;
     BlockBackend *blk;
@@ -811,8 +811,8 @@ static void test_propagate_mirror(void)
 
 static void test_attach_second_node(void)
 {
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     AioContext *main_ctx = qemu_get_aio_context();
     BlockBackend *blk;
     BlockDriverState *bs, *filter;
@@ -844,8 +844,8 @@ static void test_attach_second_node(void)
 
 static void test_attach_preserve_blk_ctx(void)
 {
-    IOThread *iothread = iothread_new();
-    AioContext *ctx = iothread_get_aio_context(iothread);
+    TestIOThread *iothread = test_iothread_new();
+    AioContext *ctx = test_iothread_get_aio_context(iothread);
     BlockBackend *blk;
     BlockDriverState *bs;
 
-- 
2.53.0


