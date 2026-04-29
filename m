Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBFCFF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:06:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC6S-00070N-IG; Wed, 29 Apr 2026 17:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5K-0006Il-4j
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5H-0003TX-U2
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQG0qN6rFQpchqEjkKkpkK6wYq5eQ1JvZPMXVcU8sd0=;
 b=JlTKN5FnD31WpRQ7kxWu9h7d6WDLZSKkqdKA7cPa3rTzPh1/WHntycHSxkYDr7hR1xcTxx
 wkOWOBoO88Hxbih/nMaJpmdKNtBpIfJlunrQLiK9yigr6rcNHfKGkeX5ImotgewiW8Ys9J
 vZqD8WKKE2OWPziPt9lgGbIHLxrL+iU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-blbw-yUNOneR9_FZY0jX-w-1; Wed,
 29 Apr 2026 17:04:37 -0400
X-MC-Unique: blbw-yUNOneR9_FZY0jX-w-1
X-Mimecast-MFC-AGG-ID: blbw-yUNOneR9_FZY0jX-w_1777496676
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C9921956095
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:04:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41438300019F; Wed, 29 Apr 2026 21:04:34 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:47 +0400
Subject: [PATCH v3 14/26] ui/vnc: make the worker thread per-VncDisplay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-14-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=6513;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XCDp9S7HaL4bLvRrQfhchRC/cgPquwTPMALLwTkY/1Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMP0Sg7vWQoEo0cWOvJtxIFY1cyJY8gVql1
 BItB7/gZb2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5WkrD/4pyTQhgKTK/q5u2m/HYnH7/mbTqz5Dih3S4FfLbOKhRuwK7yrVPULAJpYjX8gSYoml+72
 G9FsQN8hX9Ctw/brPbTmVZsfxOOSyL5xMxzyEMvmNwOo0pIS5OYnLpe88mzEDu8O4eqDzY1AVkJ
 CyMianmfUFhmp2vPJodB2TqrLaTc7M5C1TxlYR8X7fv2G+QCFRHcBMYLYcG/bp067NefkvrzdZI
 KrAHGzn+wsf2hRxcmAMZs1wvt4/yGyj0FHv4mK3kqT/IqArZ4uVEuEhXd+Z5MTF+JKEMRdKXiNl
 0HAxImgN6F8XDwrYV6KFI4LPhzhu1oWgeOdiVVPBOHK1NwBgtXH3JYcw9QnLh0Uks1TLm6r7D/H
 rF53OUwyVoFy0MZtRnN+Rvkw1LBtsAfUFeuicu9PmapHEoO/j7gdIbrW67sdTKjuy1Qw073JziC
 wM5BmyYdDi5ixxKhOPz92j+0SIiGf4cXtvrxQ3dyP+WcAvorNGM5Yr5t2RyoIuPtk696swqHxvO
 lr/ndM13sygc6nPuGSqzDO8wdwJRAvx9sztvoWBgl32i/uWPzYRDEKLVXCZ+khUMwBnmxy/1l2e
 VklNKY3ou6Rpf8GrbBdFw3WkyZ1L1JJCDWwvRY5SjlZEgzD2lAVXzVkSooCfllvWgijvwNIgPb5
 Ju8J/h07pXRIAtg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The VNC encoding worker thread was using a single global queue shared
across all VNC displays, with no way to stop it. This made it impossible
to properly clean up resources when a VncDisplay is freed.

Move the VncJobQueue from a file-scoped global to a per-VncDisplay
member, so each display owns its worker thread and queue. Add
vnc_stop_worker_thread() to perform an orderly shutdown: signal the
thread to exit, join it, and destroy the queue. The thread is now
created as QEMU_THREAD_JOINABLE instead of QEMU_THREAD_DETACHED.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.h |  3 ++-
 ui/vnc.h      |  2 ++
 ui/vnc-jobs.c | 62 ++++++++++++++++++++++++++++++++++++++---------------------
 ui/vnc.c      |  3 ++-
 4 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/ui/vnc-jobs.h b/ui/vnc-jobs.h
index 59f66bcc353..e5ab55c1da6 100644
--- a/ui/vnc-jobs.h
+++ b/ui/vnc-jobs.h
@@ -37,7 +37,8 @@ void vnc_job_push(VncJob *job);
 void vnc_jobs_join(VncState *vs);
 
 void vnc_jobs_consume_buffer(VncState *vs);
-void vnc_start_worker_thread(void);
+void vnc_start_worker_thread(VncDisplay *vd);
+void vnc_stop_worker_thread(VncDisplay *vd);
 
 /* Locks */
 static inline int vnc_trylock_display(VncDisplay *vd)
diff --git a/ui/vnc.h b/ui/vnc.h
index 472a55f7b5f..780fd39469f 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -62,6 +62,7 @@
 
 typedef struct VncState VncState;
 typedef struct VncJob VncJob;
+typedef struct VncJobQueue VncJobQueue;
 typedef struct VncRect VncRect;
 typedef struct VncRectEntry VncRectEntry;
 
@@ -158,6 +159,7 @@ struct VncDisplay
     int ledstate;
     QKbdState *kbd;
     QemuMutex mutex;
+    VncJobQueue *queue;
 
     int cursor_msize;
     uint8_t *cursor_mask;
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 5b17ef54091..90b68bf4cb9 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -29,8 +29,6 @@
 #include "qemu/osdep.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
-#include "qemu/sockets.h"
-#include "qemu/main-loop.h"
 #include "trace.h"
 
 /*
@@ -56,17 +54,10 @@ struct VncJobQueue {
     QemuCond cond;
     QemuMutex mutex;
     QemuThread thread;
+    bool exit;
     QTAILQ_HEAD(, VncJob) jobs;
 };
 
-typedef struct VncJobQueue VncJobQueue;
-
-/*
- * We use a single global queue, but most of the functions are
- * already reentrant, so we can easily add more than one encoding thread
- */
-static VncJobQueue *queue;
-
 static void vnc_lock_queue(VncJobQueue *queue)
 {
     qemu_mutex_lock(&queue->mutex);
@@ -125,12 +116,15 @@ static void vnc_job_free(VncJob *job)
  */
 void vnc_job_push(VncJob *job)
 {
+    VncJobQueue *queue = job->vs->vd->queue;
+
     assert(!QTAILQ_IN_USE(job, next));
 
     if (QLIST_EMPTY(&job->rectangles)) {
         vnc_job_free(job);
     } else {
         vnc_lock_queue(queue);
+        assert(!queue->exit);
         QTAILQ_INSERT_TAIL(&queue->jobs, job, next);
         qemu_cond_broadcast(&queue->cond);
         vnc_unlock_queue(queue);
@@ -139,6 +133,7 @@ void vnc_job_push(VncJob *job)
 
 static bool vnc_has_job_locked(VncState *vs)
 {
+    VncJobQueue *queue = vs->vd->queue;
     VncJob *job;
 
     QTAILQ_FOREACH(job, &queue->jobs, next) {
@@ -151,6 +146,8 @@ static bool vnc_has_job_locked(VncState *vs)
 
 void vnc_jobs_join(VncState *vs)
 {
+    VncJobQueue *queue = vs->vd->queue;
+
     vnc_lock_queue(queue);
     while (vnc_has_job_locked(vs)) {
         qemu_cond_wait(&queue->cond, &queue->mutex);
@@ -252,9 +249,13 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
     int saved_offset;
 
     vnc_lock_queue(queue);
-    while (QTAILQ_EMPTY(&queue->jobs)) {
+    while (QTAILQ_EMPTY(&queue->jobs) && !queue->exit) {
         qemu_cond_wait(&queue->cond, &queue->mutex);
     }
+    if (queue->exit) {
+        vnc_unlock_queue(queue);
+        return 1;
+    }
     job = QTAILQ_FIRST(&queue->jobs);
     vnc_unlock_queue(queue);
 
@@ -340,7 +341,7 @@ disconnected:
     return 0;
 }
 
-static VncJobQueue *vnc_queue_init(void)
+static VncJobQueue *vnc_queue_new(void)
 {
     VncJobQueue *queue = g_new0(VncJobQueue, 1);
 
@@ -350,29 +351,46 @@ static VncJobQueue *vnc_queue_init(void)
     return queue;
 }
 
+static void vnc_queue_free(VncJobQueue *queue)
+{
+    qemu_cond_destroy(&queue->cond);
+    qemu_mutex_destroy(&queue->mutex);
+    g_free(queue);
+}
+
 static void *vnc_worker_thread(void *arg)
 {
     VncJobQueue *queue = arg;
 
     while (!vnc_worker_thread_loop(queue)) ;
-    g_assert_not_reached();
+
     return NULL;
 }
 
-static bool vnc_worker_thread_running(void)
+void vnc_start_worker_thread(VncDisplay *vd)
 {
-    return queue; /* Check global queue */
+    assert(vd->queue == NULL);
+
+    vd->queue = vnc_queue_new();
+    qemu_thread_create(&vd->queue->thread, "vnc_worker", vnc_worker_thread, vd->queue,
+                       QEMU_THREAD_JOINABLE);
 }
 
-void vnc_start_worker_thread(void)
+void vnc_stop_worker_thread(VncDisplay *vd)
 {
-    VncJobQueue *q;
+    VncJobQueue *queue = vd->queue;
 
-    if (vnc_worker_thread_running())
+    if (!queue) {
         return;
+    }
+
+    /* all VNC clients must have finished before we can stop the worker thread */
+    vnc_lock_queue(queue);
+    assert(QTAILQ_EMPTY(&queue->jobs));
+    queue->exit = true;
+    qemu_cond_broadcast(&queue->cond);
+    vnc_unlock_queue(queue);
 
-    q = vnc_queue_init();
-    qemu_thread_create(&q->thread, "vnc_worker", vnc_worker_thread, q,
-                       QEMU_THREAD_DETACHED);
-    queue = q; /* Set global queue */
+    qemu_thread_join(&queue->thread);
+    g_clear_pointer(&vd->queue, vnc_queue_free);
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index c87d1f61a0a..3a908670ab9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3457,7 +3457,7 @@ void vnc_display_init(const char *id, Error **errp)
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
     vd->connections_limit = 32;
 
-    vnc_start_worker_thread();
+    vnc_start_worker_thread(vd);
 
     register_displaychangelistener(&vd->dcl);
     vd->kbd = qkbd_state_init(vd->dcl.con);
@@ -3513,6 +3513,7 @@ static void vnc_display_free(VncDisplay *vd)
 
     assert(QTAILQ_EMPTY(&vd->clients));
 
+    vnc_stop_worker_thread(vd);
     vnc_display_close(vd);
     unregister_displaychangelistener(&vd->dcl);
     qkbd_state_free(vd->kbd);

-- 
2.54.0


