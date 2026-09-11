Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FEDC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4yAZ-0006MT-By; Fri, 11 Sep 2026 06:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAX-0006L1-Qq
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:41 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x4yAV-0007G5-Rd
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 06:07:41 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-39675172593so742676a91.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789121258; x=1789726058; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JoV/L3vaZSj9f3RbohvwlCdSIoQZKn965jasW56Se3c=;
 b=glJcR6fS/2LB5UOaJOXm2oSmY1DR2onKbu79QT5lcydm5DHl4e0m/6KUnfz+WC5CG/
 53ZGzx0QEx530Pmx1Li/EdVoVu39qIOXu5AAQcj8XV1OWfcUf6pWjgDEzyrWjErB2ly/
 0n/rzwXQP2DmVsCw20QNjNuUiLQQ4n8KD0lyoW4O+CsLnFyb7tyXMQkz88q8JUUTl2Tc
 p6MmVDIqbnf5bBTcFFI3xVfjbVA9bQcPhVcWMhq/REmLPPrw/xZbj1tlKpZOboapknTk
 CGtnFHLoLeTdBZGl6Bw1Ee5w8EDC56CcFVZsMLg10xmpgGRQ0hyhlXsskIbyh56OTaTm
 qYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789121258; x=1789726058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JoV/L3vaZSj9f3RbohvwlCdSIoQZKn965jasW56Se3c=;
 b=qpDWDjIMTcvxjFzRYqzzaT2AFSmn9xnNeOyvTOpKMF3sSBALuMfn8cBCKjtZ7qaFvS
 vg9eE1KxxjmL+bTLBPDlUUHj4QmEGZqKjC/SGEBiKwOfgVIs30HZYayDByi5bC4FVDZb
 hxyx5GU2H3+Blg7qiEWuWEWMjEZU1/3FTgjRccqaAZtJ2k6uUbLht9LRTLvw3U+XAF21
 SnGezoG4w5xpJ7Hl/lVwpoWt4Dj7eisf6l/0c8fOXY4Vq7EemdPayx3qmux9RHsmXj5e
 u5xBfGgst570MblLAB4zRyxF1cIr2win2Hzlx9Fp8CVE0Sm/SPv3V2VqjjqwI8k4K63C
 v8vA==
X-Gm-Message-State: AFuF++kd0fuU5KfPEHVTwWyW9kyRvnQsl4MnnLYUD8n3XbxAlEGDB+6O
 b7AKF2n1gsP6ddeMLJsl//HKPcnFQB93xK9nh8GVI0535/3a7n05TqQijnAhbj1T0TE=
X-Gm-Gg: AYBFou26SMyA250I/MWd6PwiZ3TkIrqSysJ9OGwwRQP7mU8ARXMAH2+MpQ6zL9A6GQU
 yoneQJZbyn+tlFE6gAdFf3pSzse/IN8ZbqdovG+J4/xWvIsyHdBnmWGR7X5WGJmlQyd3rnPDbOG
 vA/Y3M8kAZh7a30yzLJv44Bi2GRLtXTm3HkKdbh5HSUn0zWZXKt05RdfXi2q4Y7NXe65ZWKSxNi
 MVOvwYR14gTWGf61woq67N708ZUvhSpoZnIuE1KmMLX8DvIJ+r19e98jUD9l+CHNRdbeTI7jqKK
 04MG7C5qWQ9HFZGqjVvkPPi4p+voXcvFeprR1oTF6mDI8pSafpLqB3YD+JbYM9/sznJenpOUUB8
 02ggbJhmuFXFtdxNZyqq+Y5NSaLOwPFP6y/jKKJVgGid2Uzc/fBXBtrbRQuE6dYo4SOlT5K+1zQ
 BAfoCNNPuO+UARb0Hns1krK5yToMsJSIREsDTWOiJzKjbKBp8s7Qf4B/7r7PY3jL64SHr0/Thki
 3o4dW4cNkz+WNCVA8i0LetPahI=
X-Received: by 2002:a17:90b:1648:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-39d9bec50b9mr5560376a91.10.1789121257478; 
 Fri, 11 Sep 2026 03:07:37 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d951d6b08sm4514800a91.8.2026.09.11.03.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:07:36 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V16 04/13] monitor: track IOThread users with QOM paths
Date: Fri, 11 Sep 2026 18:07:00 +0800
Message-ID: <20260911100709.726366-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911100709.726366-1-zhangckid@gmail.com>
References: <20260911100709.726366-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1031.google.com
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
---
 monitor/monitor-internal.h |  7 +++++--
 monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
 monitor/qmp.c              | 14 +++++++-------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d..020afdaebf 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,6 +77,11 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
+
+    /* iothread context and holder identity */
+    IOThread *iothread;
+    char *iothread_qom_path;
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
index 2654b81890..a80d8dbf45 100644
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
+            .u.qom_object.qom_path = mon->iothread_qom_path,
+        };
+
+        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
+    }
+    g_free(mon->iothread_qom_path);
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
+        mon->iothread_qom_path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->iothread_qom_path,
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


