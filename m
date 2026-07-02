Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D38DC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJuJ-0007un-L3; Thu, 02 Jul 2026 12:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJuH-0007lb-Qi
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJuF-0006gS-21
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTcuinrrPqO/zt6gPbHnUHx0zb2ffjTowY7qbgdkslE=;
 b=U28MJW8FjSaghOBIJskw6eOCvtTuTZS9dbdak5WMDcpCIVHI23FAOZ0g7K9fZO9i5YXKm/
 nWbzf+Jzz9fMYsSxG+fmLaTbPI+Q3TESaAftwxam9dTMkkeZvHZ4Ey6C0snfryfCpA+CRG
 e9tRWD+9FbmoGbT14A6SBN8Sum6FSzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-a-3-F2IUMvuaNbQ5b1RnOw-1; Thu,
 02 Jul 2026 12:04:47 -0400
X-MC-Unique: a-3-F2IUMvuaNbQ5b1RnOw-1
X-Mimecast-MFC-AGG-ID: a-3-F2IUMvuaNbQ5b1RnOw_1783008284
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2D291944AA9; Thu,  2 Jul 2026 16:04:44 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 296A4194510E; Thu,  2 Jul 2026 16:04:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>
Subject: [PATCH v6 14/34] monitor: use class method for I/O thread request
Date: Thu,  2 Jul 2026 17:03:17 +0100
Message-ID: <20260702160337.1910921-15-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Introducing a virtual "requires_iothread" method allows the code to
automatically initialize the I/O thread during object completion.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor-internal.h | 14 +++++++++-----
 monitor/monitor.c          | 22 ++++++++++++----------
 monitor/qmp.c              | 20 +++++++++++---------
 3 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 592f146331..efd21b8912 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -121,6 +121,12 @@ struct MonitorClass {
      * the monitor to accept further client input
      */
     void (*accept_input)(Monitor *mon);
+
+    /*
+     * If non-NULL and returns true, then an I/O thread
+     * is required for processing the monitor
+     */
+    bool (*requires_iothread)(const Monitor *mon);
 };
 
 struct Monitor {
@@ -129,7 +135,6 @@ struct Monitor {
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool is_qmp;
-    bool use_io_thread;
 
     char *mon_cpu_path;
     QTAILQ_ENTRY(Monitor) entry;
@@ -159,9 +164,8 @@ struct MonitorHMP {
     bool use_readline;
     /*
      * State used only in the thread "owning" the monitor.
-     * If @use_io_thread, this is @mon_iothread. (This does not actually happen
-     * in the current state of the code.)
-     * Else, it's the main thread.
+     * This is currently always the main thread, since
+     * HMP does not allow use of the I/O thread at this time.
      * These members can be safely accessed without locks.
      */
     ReadLineState *rs;
@@ -210,7 +214,7 @@ extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
 void monitor_complete(Monitor *mon, Error **errp);
-void monitor_iothread_init(Monitor *mon);
+bool monitor_requires_iothread(const Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 6e63e7a5c7..1b2bdcf68f 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -162,6 +162,12 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
 
+bool monitor_requires_iothread(const Monitor *mon)
+{
+    MonitorClass *cls = MONITOR_GET_CLASS(mon);
+    return cls->requires_iothread && cls->requires_iothread(mon);
+}
+
 /**
  * Is @mon is using readline?
  * Note: not all HMP monitors use readline, e.g., gdbserver has a
@@ -563,7 +569,7 @@ int monitor_suspend(Monitor *mon)
 
     qatomic_inc(&mon->suspend_cnt);
 
-    if (mon->use_io_thread) {
+    if (monitor_requires_iothread(mon)) {
         /*
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
@@ -596,7 +602,7 @@ void monitor_resume(Monitor *mon)
     if (qatomic_dec_fetch(&mon->suspend_cnt) == 0) {
         AioContext *ctx;
 
-        if (mon->use_io_thread) {
+        if (monitor_requires_iothread(mon)) {
             ctx = iothread_get_aio_context(mon_iothread);
         } else {
             ctx = qemu_get_aio_context();
@@ -634,14 +640,6 @@ void monitor_list_append(Monitor *mon)
     }
 }
 
-void monitor_iothread_init(Monitor *mon)
-{
-    if (!mon_iothread) {
-        mon_iothread = iothread_create("mon_iothread", &error_abort);
-    }
-    mon->use_io_thread = true;
-}
-
 void monitor_cleanup(void)
 {
     /*
@@ -743,6 +741,10 @@ void monitor_complete(Monitor *mon, Error **errp)
             return;
         }
     }
+
+    if (monitor_requires_iothread(mon) && !mon_iothread) {
+        mon_iothread = iothread_create("mon_iothread", &error_abort);
+    }
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index d732fff9a3..8bbe25d8de 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -100,6 +100,7 @@ static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
 }
 
 static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
+static bool monitor_qmp_requires_iothread(const Monitor *mon);
 
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
@@ -110,6 +111,7 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
                                    monitor_qmp_set_pretty);
 
     moncls->emit_event = monitor_qmp_emit_event;
+    moncls->requires_iothread = monitor_qmp_requires_iothread;
 }
 
 static void handle_qmp_command(void *opaque, QObject *req, Error *err);
@@ -136,6 +138,11 @@ static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict)
     qmp_send_response(qmp, qdict);
 }
 
+static bool monitor_qmp_requires_iothread(const Monitor *mon)
+{
+    return qemu_chr_has_feature(mon->chr.chr,
+                                QEMU_CHAR_FEATURE_GCONTEXT);
+}
 
 static bool qmp_oob_enabled(MonitorQMP *mon)
 {
@@ -146,7 +153,8 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
 {
     memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
     memset(mon->capab, 0, sizeof(mon->capab));
-    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->parent_obj.use_io_thread;
+    mon->capab_offered[QMP_CAPABILITY_OOB] =
+        monitor_requires_iothread(MONITOR(mon));
 }
 
 static void qmp_request_free(QMPRequest *req)
@@ -562,7 +570,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     MonitorQMP *mon = opaque;
     GMainContext *context;
 
-    assert(mon->parent_obj.use_io_thread);
+    assert(monitor_requires_iothread(MONITOR(mon)));
     context = iothread_get_g_main_context(mon_iothread);
     assert(context);
     qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
@@ -598,13 +606,7 @@ void monitor_new_qmp(const char *id, const char *chardev_id,
 
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
-    /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    if (qemu_chr_has_feature(mon->parent_obj.chr.chr,
-                             QEMU_CHAR_FEATURE_GCONTEXT)) {
-        monitor_iothread_init(&mon->parent_obj);
-    }
-
-    if (mon->parent_obj.use_io_thread) {
+    if (monitor_requires_iothread(MONITOR(mon))) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
-- 
2.54.0


