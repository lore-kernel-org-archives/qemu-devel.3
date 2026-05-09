Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ABACD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlHr-0005m0-Sz; Sat, 09 May 2026 13:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlHb-0005Mx-14
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlHZ-0005DY-An
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8ObG7/YpUW5QUS6BKgeVhaMUcZQOUTbu2MDi+0Jl8Y=;
 b=R8SNkeacjN81rwkNY6W6WIrgSZLzmgRjBG7EI75PMyl1G5ZXBKGIaiYLOeZAe/X6RbfGhd
 IlsswhsYCh9IJ373+6rxUEep9uYZtyxhgVLcElBX+stqeKhScqhrp1YfUxthkFpXw8aIQE
 f0KegHq3OX2yjHkoYJzUClilTB9MkCs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570--UEMNL_CNAuI1inci88f_w-1; Sat,
 09 May 2026 13:16:02 -0400
X-MC-Unique: -UEMNL_CNAuI1inci88f_w-1
X-Mimecast-MFC-AGG-ID: -UEMNL_CNAuI1inci88f_w_1778346961
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78D13180034C; Sat,  9 May 2026 17:16:01 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2181F1955D84; Sat,  9 May 2026 17:15:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 20/33] ui/vnc: make the worker thread per-VncDisplay
Date: Sat,  9 May 2026 21:13:41 +0400
Message-ID: <20260509171356.1157879-21-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The VNC encoding worker thread was using a single global queue shared
across all VNC displays, with no way to stop it. This made it impossible
to properly clean up resources when a VncDisplay is freed.

Move the VncJobQueue from a file-scoped global to a per-VncDisplay
member, so each display owns its worker thread and queue. Add
vnc_stop_worker_thread() to perform an orderly shutdown: signal the
thread to exit, join it, and destroy the queue. The thread is now
created as QEMU_THREAD_JOINABLE instead of QEMU_THREAD_DETACHED.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.h |  3 ++-
 ui/vnc.h      |  2 ++
 ui/vnc-jobs.c | 62 +++++++++++++++++++++++++++++++++------------------
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


