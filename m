Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B2CC83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 20:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf2qs-0007JR-GT; Thu, 24 Jul 2025 16:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qZ-0006vZ-9g
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uf2qW-0007Vz-LS
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 16:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753390036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rbYs+8k6eVMUp1Wr8L7PFzngQ03/Wf+JnHjPQ19gOec=;
 b=SjHO0hku3IM7PgAev8ASI+2jI4Cs55o2b/x3rDQzulWlFoTIRi6y1m3LXnrsZTqnAYdqL0
 zubdTWl0IpvdgRHR6i/FeEFC8mLLmknbk6k5fBKVAqCBg/+nn6ldkdsEWI2Apjqa1Vbm39
 FBREwQ5bcPrZtqp+FaSitfIhX9VHxW8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-4DwYgUKeNzODL8yqGn8pVw-1; Thu,
 24 Jul 2025 16:47:09 -0400
X-MC-Unique: 4DwYgUKeNzODL8yqGn8pVw-1
X-Mimecast-MFC-AGG-ID: 4DwYgUKeNzODL8yqGn8pVw_1753390028
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97591956048; Thu, 24 Jul 2025 20:47:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.247])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB34D1956089; Thu, 24 Jul 2025 20:47:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Brian Song <hibriansong@gmail.com>,
 qemu-block@nongnu.org, Bernd Schubert <bschubert@ddn.com>,
 Kevin Wolf <kwolf@redhat.com>, h0lyalg0rithm@git.sr.ht,
 Fam Zheng <fam@euphon.net>
Subject: [RFC 1/3] iothread: create AioContext in iothread_run()
Date: Thu, 24 Jul 2025 16:47:00 -0400
Message-ID: <20250724204702.576637-2-stefanha@redhat.com>
In-Reply-To: <20250724204702.576637-1-stefanha@redhat.com>
References: <20250724204702.576637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index d95c17a645..ec4e798d5e 100644
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
index 8810376dce..c6547779d0 100644
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
2.50.1


