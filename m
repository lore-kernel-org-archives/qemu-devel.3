Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17426EFD207
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvA1s-0000Gp-3X; Wed, 25 Feb 2026 03:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1q-0000G7-8F
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vvA1o-0001mM-Eu
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772007231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQS3Y5nMTKw5gDI6HAbJElvI3dA9SdUjFn0c8BGqiT4=;
 b=YjWVrfAeHWfJIsPnor3BZza6hIgM/A9lZHCAIULCzoA8uQb18XC44OuCFO51d1pWIc4kH/
 0pLpfcGVynHp49vCnRtUXS1ySgEYM6vBYkofiMLUQXkAxC7ZbvZP2c/7RefK8v3BBvBx+O
 K9+NGYFJ3IjNTd8x0KQjpV8LM7FFgE8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-dtAGnXt3NmeR-MLCzSwpzg-1; Wed,
 25 Feb 2026 03:13:46 -0500
X-MC-Unique: dtAGnXt3NmeR-MLCzSwpzg-1
X-Mimecast-MFC-AGG-ID: dtAGnXt3NmeR-MLCzSwpzg_1772007225
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19BE219560B7; Wed, 25 Feb 2026 08:13:45 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D43761800465; Wed, 25 Feb 2026 08:13:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 1/4] iothread: create AioContext in iothread_run()
Date: Wed, 25 Feb 2026 16:13:33 +0800
Message-ID: <20260225081336.1639325-2-stefanha@redhat.com>
In-Reply-To: <20260225081336.1639325-1-stefanha@redhat.com>
References: <20260225081336.1639325-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The IOThread's AioContext is currently created in iothread_init() where
it's easy to propagate errors before spawning the thread that runs
iothread_run(). However, this means that aio_context_new() is called
from the main loop thread rather than from the IOThread.

In order to use Linux io_uring's IORING_SETUP_SINGLE_ISSUER feature in
the next commit, only one thread can use the io_uring context and
therefore iothread.c must call aio_context_new() from iothread_run()
instead of iothread_init().

Extract the iothread_run() arguments into an IOThreadRunArgs struct
where an Error *error field can be used to report back initialization
errors. This works pretty well thanks to the init_done_sem semaphore
that is already used by iothread_init() to wait for iothread_run() to
initialize.

Move iothread_run() further down for proximity with iothread_init() and
to avoid adding a function prototype for
iothread_set_aio_context_params().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/system/iothread.h |   1 -
 iothread.c                | 140 +++++++++++++++++++++-----------------
 2 files changed, 78 insertions(+), 63 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..9c70c7fa0b 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -29,7 +29,6 @@ struct IOThread {
     bool run_gcontext;          /* whether we should run gcontext */
     GMainContext *worker_context;
     GMainLoop *main_loop;
-    QemuSemaphore init_done_sem; /* is thread init done? */
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
diff --git a/iothread.c b/iothread.c
index caf68e0764..6e79c02d02 100644
--- a/iothread.c
+++ b/iothread.c
@@ -36,46 +36,6 @@
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
 #endif
 
-static void *iothread_run(void *opaque)
-{
-    IOThread *iothread = opaque;
-
-    rcu_register_thread();
-    /*
-     * g_main_context_push_thread_default() must be called before anything
-     * in this new thread uses glib.
-     */
-    g_main_context_push_thread_default(iothread->worker_context);
-    qemu_set_current_aio_context(iothread->ctx);
-    iothread->thread_id = qemu_get_thread_id();
-    qemu_sem_post(&iothread->init_done_sem);
-
-    while (iothread->running) {
-        /*
-         * Note: from functional-wise the g_main_loop_run() below can
-         * already cover the aio_poll() events, but we can't run the
-         * main loop unconditionally because explicit aio_poll() here
-         * is faster than g_main_loop_run() when we do not need the
-         * gcontext at all (e.g., pure block layer iothreads).  In
-         * other words, when we want to run the gcontext with the
-         * iothread we need to pay some performance for functionality.
-         */
-        aio_poll(iothread->ctx, true);
-
-        /*
-         * We must check the running state again in case it was
-         * changed in previous aio_poll()
-         */
-        if (iothread->running && qatomic_read(&iothread->run_gcontext)) {
-            g_main_loop_run(iothread->main_loop);
-        }
-    }
-
-    g_main_context_pop_thread_default(iothread->worker_context);
-    rcu_unregister_thread();
-    return NULL;
-}
-
 /* Runs in iothread_run() thread */
 static void iothread_stop_bh(void *opaque)
 {
@@ -104,7 +64,6 @@ static void iothread_instance_init(Object *obj)
 
     iothread->poll_max_ns = IOTHREAD_POLL_MAX_NS_DEFAULT;
     iothread->thread_id = -1;
-    qemu_sem_init(&iothread->init_done_sem, 0);
     /* By default, we don't run gcontext */
     qatomic_set(&iothread->run_gcontext, 0);
 }
@@ -135,7 +94,6 @@ static void iothread_instance_finalize(Object *obj)
         g_main_loop_unref(iothread->main_loop);
         iothread->main_loop = NULL;
     }
-    qemu_sem_destroy(&iothread->init_done_sem);
 }
 
 static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
@@ -176,47 +134,105 @@ static void iothread_set_aio_context_params(EventLoopBase *base, Error **errp)
                                        base->thread_pool_max, errp);
 }
 
+typedef struct {
+    IOThread *iothread;
+    const char *thread_name;
+    QemuSemaphore init_done_sem; /* is thread init done? */
+    Error *error; /* filled in before init_done_sem is posted */
+} IOThreadRunArgs;
 
-static void iothread_init(EventLoopBase *base, Error **errp)
+static void *iothread_run(void *opaque)
 {
-    Error *local_error = NULL;
-    IOThread *iothread = IOTHREAD(base);
-    g_autofree char *thread_name = NULL;
+    IOThreadRunArgs *args = opaque;
+    IOThread *iothread = args->iothread;
 
-    iothread->stopping = false;
-    iothread->running = true;
-    iothread->ctx = aio_context_new(errp);
+    rcu_register_thread();
+
+    iothread->ctx = aio_context_new(&args->error);
     if (!iothread->ctx) {
-        return;
+        goto out;
     }
 
-    thread_name = g_strdup_printf("IO %s",
-                        object_get_canonical_path_component(OBJECT(base)));
+    iothread_set_aio_context_params(EVENT_LOOP_BASE(iothread), &args->error);
+    if (args->error) {
+        aio_context_unref(iothread->ctx);
+        iothread->ctx = NULL;
+        goto out;
+    }
 
     /*
      * Init one GMainContext for the iothread unconditionally, even if
      * it's not used
      */
-    iothread_init_gcontext(iothread, thread_name);
+    iothread_init_gcontext(iothread, args->thread_name);
 
-    iothread_set_aio_context_params(base, &local_error);
-    if (local_error) {
-        error_propagate(errp, local_error);
-        aio_context_unref(iothread->ctx);
-        iothread->ctx = NULL;
-        return;
+    /*
+     * g_main_context_push_thread_default() must be called before anything
+     * in this new thread uses glib.
+     */
+    g_main_context_push_thread_default(iothread->worker_context);
+    qemu_set_current_aio_context(iothread->ctx);
+
+    iothread->stopping = false;
+    iothread->running = true;
+
+    iothread->thread_id = qemu_get_thread_id();
+    qemu_sem_post(&args->init_done_sem);
+
+    while (iothread->running) {
+        /*
+         * Note: from functional-wise the g_main_loop_run() below can
+         * already cover the aio_poll() events, but we can't run the
+         * main loop unconditionally because explicit aio_poll() here
+         * is faster than g_main_loop_run() when we do not need the
+         * gcontext at all (e.g., pure block layer iothreads).  In
+         * other words, when we want to run the gcontext with the
+         * iothread we need to pay some performance for functionality.
+         */
+        aio_poll(iothread->ctx, true);
+
+        /*
+         * We must check the running state again in case it was
+         * changed in previous aio_poll()
+         */
+        if (iothread->running && qatomic_read(&iothread->run_gcontext)) {
+            g_main_loop_run(iothread->main_loop);
+        }
     }
 
+    g_main_context_pop_thread_default(iothread->worker_context);
+out:
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void iothread_init(EventLoopBase *base, Error **errp)
+{
+    IOThread *iothread = IOTHREAD(base);
+    g_autofree char *thread_name = NULL;
+    IOThreadRunArgs args = {
+        .iothread = iothread,
+    };
+
+    qemu_sem_init(&args.init_done_sem, 0);
+
+    thread_name = g_strdup_printf("IO %s",
+                        object_get_canonical_path_component(OBJECT(base)));
+    args.thread_name = thread_name;
+
     /* This assumes we are called from a thread with useful CPU affinity for us
      * to inherit.
      */
-    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE);
+    qemu_thread_create(&iothread->thread, thread_name, iothread_run, &args,
+                       QEMU_THREAD_JOINABLE);
 
     /* Wait for initialization to complete */
     while (iothread->thread_id == -1) {
-        qemu_sem_wait(&iothread->init_done_sem);
+        qemu_sem_wait(&args.init_done_sem);
     }
+
+    qemu_sem_destroy(&args.init_done_sem);
+    error_propagate(errp, args.error);
 }
 
 typedef struct {
-- 
2.53.0


