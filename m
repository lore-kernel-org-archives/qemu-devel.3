Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FD2CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBTSB-0005l1-T7; Tue, 29 Sep 2026 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTS6-0005jz-6D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:43 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xBTS4-0003lY-78
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:44:41 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc74520b20bso989419a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790671479; x=1791276279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPvkjh+FJiA8189c+U9dDH41UE3ppPuy9lNP+qAHayQ=;
 b=Z4DldHprkyDME+CnJ6n68oF61A8RMR+AQwQfwzB9UGIm8caSCsO8PJzLWeyEhP7dt0
 EqN9CJoTU1b9ObYiqInnnWX/+fyjWxfmMaJSGg7Uu/g2QZg1BVIm7G4sOXxInC+VqLSo
 5GSIh0bhiicAa0ui1jA4EKrLUFOhTsvbeeBRCX3AwSFKP5lJlDSCaD4Ti7uk+FjPn9Nn
 milwmFOy0MnKFMoJKDveqSE/Y8TCc6NFQOQzrbZnoR+9A8PeJag7fnHSxV23K0jfMYqE
 h0ptObo6qWWG6+fKDaSHTqG9HLY1M8Qcjmu+/VyovKrZIG8K4u+l5zk+h/9f3CnnFiQs
 ywzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790671479; x=1791276279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPvkjh+FJiA8189c+U9dDH41UE3ppPuy9lNP+qAHayQ=;
 b=Bp360XSNdXjjW2IfPXeYdQz25tGeCc76qKYicWfBy+gir6hRg+IGTQGcogld6RsA/n
 In0DxDAxWjhIPIxNBlWpc1IGsM7UB3ITGAzXmk24T/R0EzcB9H+75GYqWlz1Oo9xG5I4
 scpIq78lZ4KSpdMSy0pFiOgmzIAeoI9klmr72ErIeZLsi4zw+CeQnCl5DsxZPEO+W3a8
 DkWqLEOlDd1gRIm7T5XGfOVHLiQp8jxi5JfLprG8FsM8ti5qWqWu6rGWtLOy9AwG93gN
 KrysRUFq0AoYMdwcYacL7jG68gnwC3ngKXYwhbfeTN0N7DENbA6Xmf6LVpCqOb46DRW5
 PU0g==
X-Gm-Message-State: AFq9FYIK+ikBewFT576l/LBB+4WTM+R2On0RsnthQkwL6/CWVpulN3IA
 Di65a1PXV1TzN8SVNRty86y/W8PBvQpqrWmlMfCOaJbO5Q96dEPhsV+hLPUyi0nD
X-Gm-Gg: AYBFou0zpi0rR96cmIj94H5OSX/7zBCgnFCRPIoPWxb3BAkOgl0ji4bTaB2B550NyAs
 L2E33h5QwRSEepdD44xSGshDjwepjjQynJdnBjM69GOXzdYMEfnOmDlZt06ZjTv6IHNGmq492XV
 pgGKnjlXwIcAYXmW0R0IrqULdNWzd4Fj4Y7KKsYpkH7NRAqgX+BUuUmkCY2hw6PpaFH26sJljU2
 VQe64m1Qiq3O63lTRWdVb6Uhj4WMSNW83Sboy3c86inKCQ77i6UV4k7g0ME8Ky9+6jCX6THIJnW
 O/cVzhzLTjc0JTn88C0Xd8aGH0pbWG0EgBn5rTlbildBIVNo7Z+IZ2AOhegKZ42/s5xjuSev0Sw
 WnTC/IDyd9Bx5LTO139YrE0PkgWVh5ET639vvLMw9phWSmogqcpI5igQ7SxnFddOi/BLRH01vTq
 70wrGPSZQVJtwIrhFR6/CAT+NXlZSX58E3KOWlfnKuLd2GHEcepNkLGGIw1ctIagqu/Y0rnwrv2
 TbrfbpN7HPEsNOB/VNKr5enTOg=
X-Received: by 2002:a17:90a:e7cb:b0:3a0:f4ee:d2b2 with SMTP id
 98e67ed59e1d1-3a49c1a1183mr1065468a91.32.1790671478637; 
 Tue, 29 Sep 2026 01:44:38 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a497e942eesm5163120a91.4.2026.09.29.01.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:44:37 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V18 04/13] monitor: track IOThread users with QOM paths
Date: Tue, 29 Sep 2026 16:44:07 +0800
Message-ID: <20260929084416.1600199-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929084416.1600199-1-zhangckid@gmail.com>
References: <20260929084416.1600199-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=zhangckid@gmail.com; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Monitors that require an IOThread share the internal mon_iothread.
Account for each monitor explicitly in IOThread holder tracking, using
the monitor's canonical QOM path to distinguish holders.

Acquire the shared monitor IOThread AioContext once and store the
IOThread and canonical QOM path so the holder can be released after the
monitor has been removed from the QOM tree. Use the stored IOThread for
per-monitor checks and accesses after initialization, and reuse the
stored context for later operations.

Release the holder from monitor_finalize(), after resources associated
with the AioContext have been destroyed. This pairs the reference taken
in complete() with instance finalization and keeps the IOThread alive
throughout monitor teardown.

The internal mon_iothread remains hidden from query-iothreads, as before.
Management applications therefore cannot use it to determine which
monitors are using the IOThread. Nevertheless, track the monitor
holders so that they follow the same explicit holder and
IOThread reference lifecycle as other AioContext users.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor/monitor-internal.h |  7 +++++--
 monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
 monitor/qmp.c              | 14 +++++++-------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d..856948067b 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,6 +77,11 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
+
+    /* iothread context and holder identity */
+    IOThread *iothread;
+    char *qom_path;
+    AioContext *ctx;
 };
 
 struct MonitorQMPClass {
@@ -109,14 +114,12 @@ struct MonitorQMP {
 };
 
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
-extern IOThread *mon_iothread;
 extern Coroutine *qmp_dispatcher_co;
 extern bool qmp_dispatcher_co_shutdown;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-bool monitor_requires_iothread(const Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2654b81890..4e2b96b2e8 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -55,7 +55,7 @@ typedef struct {
 } MonitorQAPIEventConf;
 
 /* Shared monitor I/O thread */
-IOThread *mon_iothread;
+static IOThread *mon_iothread;
 
 /* Coroutine to dispatch the requests received from I/O thread */
 Coroutine *qmp_dispatcher_co;
@@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
     qemu_chr_fe_deinit(&mon->chr, false);
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->iothread) {
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->qom_path,
+        };
+
+        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
+    }
+    g_free(mon->qom_path);
 }
 
 static char *monitor_get_chardev_id(Object *obj, Error **errp)
@@ -164,7 +174,7 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return old_monitor;
 }
 
-bool monitor_requires_iothread(const Monitor *mon)
+static bool monitor_requires_iothread(const Monitor *mon)
 {
     MonitorClass *cls = MONITOR_GET_CLASS(mon);
     return cls->requires_iothread && cls->requires_iothread(mon);
@@ -188,8 +198,8 @@ void monitor_cancel_out_watch(Monitor *mon)
         GMainContext *ctx = NULL;
         GSource *src;
 
-        if (monitor_requires_iothread(mon)) {
-            ctx = iothread_get_g_main_context(mon_iothread);
+        if (mon->iothread) {
+            ctx = iothread_get_g_main_context(mon->iothread);
         }
         src = g_main_context_find_source_by_id(ctx, mon->out_watch);
         if (!src && ctx) {
@@ -516,12 +526,12 @@ void monitor_suspend(Monitor *mon)
 {
     qatomic_inc(&mon->suspend_cnt);
 
-    if (monitor_requires_iothread(mon)) {
+    if (mon->iothread) {
         /*
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -661,7 +671,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -680,11 +689,18 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             mon_iothread = iothread_create("mon_iothread", &error_abort);
         }
 
-        ctx = iothread_get_aio_context(mon_iothread);
+        mon->iothread = mon_iothread;
+        mon->qom_path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->qom_path,
+        };
+
+        mon->ctx = iothread_ref_and_get_aio_context(mon->iothread, &io_holder);
     } else {
-        ctx = qemu_get_aio_context();
+        mon->ctx = qemu_get_aio_context();
     }
-    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec0315775..e235302fb3 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -187,7 +187,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
     memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
     memset(mon->capab, 0, sizeof(mon->capab));
     mon->capab_offered[QMP_CAPABILITY_OOB] =
-        monitor_requires_iothread(MONITOR(mon));
+        MONITOR(mon)->iothread != NULL;
 }
 
 static void qmp_request_free(QMPRequest *req)
@@ -678,8 +678,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     MonitorQMP *mon = opaque;
     GMainContext *context;
 
-    assert(monitor_requires_iothread(MONITOR(mon)));
-    context = iothread_get_g_main_context(mon_iothread);
+    assert(MONITOR(mon)->iothread);
+    context = iothread_get_g_main_context(MONITOR(mon)->iothread);
     assert(context);
     qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
@@ -717,7 +717,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
-    if (monitor_requires_iothread(MONITOR(mon))) {
+    if (MONITOR(mon)->iothread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
@@ -734,7 +734,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -788,8 +788,8 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     }
 
     /* Synchronize with in-flight iothread callbacks. */
-    if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+    if (mon->iothread) {
+        aio_wait_bh_oneshot(mon->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.43.0


