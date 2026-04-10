Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF21F459EF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBEMm-0004BV-5I; Fri, 10 Apr 2026 12:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMS-00041c-PG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEMN-0006QO-LJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dyt0/iTo98cCfrgHgNq0Cv+2MCAtHHkp9DewmuMIsRU=;
 b=UlKEwHZDzAOSuTZl4ClTKzqLETBaWieoYyZWhJXu/c4tANpLpfZCCMWY0Kj+y3ricshWyf
 w1pqzEoguFNQpouE9CKSuFi209UikLNAaEbVGZN+zvamxHaUu5Vo9aPY6+RZI+/4t2A4W4
 Ame9qplnnl7p7p84lhu7DDJREkA3q0U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-0yd4hVrfMiqwAiWxTSJ2Tg-1; Fri,
 10 Apr 2026 12:05:29 -0400
X-MC-Unique: 0yd4hVrfMiqwAiWxTSJ2Tg-1
X-Mimecast-MFC-AGG-ID: 0yd4hVrfMiqwAiWxTSJ2Tg_1775837127
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB6A1955DB2; Fri, 10 Apr 2026 16:05:27 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 148B419560AB; Fri, 10 Apr 2026 16:05:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 06/17] monitor: move monitor_data_(init|destroy) into QOM
 init/finalize
Date: Fri, 10 Apr 2026 17:04:47 +0100
Message-ID: <20260410160458.3778874-7-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Start to take advantage of QOM, by using object init and finalize
methods to replace monitor_data_init and monitor_data_destroy.

A standalone helper is provided to enable the I/O thread for QMP
where appropriate for the chardev backend.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              |  4 ++--
 monitor/monitor-internal.h |  3 +--
 monitor/monitor.c          | 48 ++++++++++++++------------------------
 monitor/qmp-cmds.c         |  3 ---
 monitor/qmp.c              | 21 +++++++++--------
 5 files changed, 32 insertions(+), 47 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 72f8303662..833de0eee8 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -46,6 +46,8 @@ OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
 
 static void monitor_hmp_finalize(Object *obj)
 {
+    MonitorHMP *mon = MONITOR_HMP(obj);
+    readline_free(mon->rs);
 }
 
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
@@ -1539,8 +1541,6 @@ void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
         return;
     }
 
-    monitor_data_init(&mon->parent, false, false);
-
     mon->use_readline = use_readline;
     if (mon->use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 84117805b7..5bfe3b7325 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -182,8 +182,7 @@ extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread);
-void monitor_data_destroy(Monitor *mon);
+void monitor_iothread_init(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index f7e3708d2f..f6c90145f6 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -77,6 +77,12 @@ OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
 
 static void monitor_finalize(Object *obj)
 {
+    Monitor *mon = MONITOR(obj);
+
+    g_free(mon->mon_cpu_path);
+    qemu_chr_fe_deinit(&mon->chr, false);
+    g_string_free(mon->outbuf, true);
+    qemu_mutex_destroy(&mon->mon_lock);
 }
 
 static void monitor_class_init(ObjectClass *cls, const void *data)
@@ -85,6 +91,11 @@ static void monitor_class_init(ObjectClass *cls, const void *data)
 
 static void monitor_init(Object *obj)
 {
+    Monitor *mon = MONITOR(obj);
+
+    qemu_mutex_init(&mon->mon_lock);
+    mon->is_qmp = !!object_dynamic_cast(obj, TYPE_MONITOR_QMP);
+    mon->outbuf = g_string_new(NULL);
 }
 
 Monitor *monitor_cur(void)
@@ -616,38 +627,16 @@ void monitor_list_append(Monitor *mon)
     qemu_mutex_unlock(&monitor_lock);
 
     if (mon) {
-        monitor_data_destroy(mon);
         object_unref(mon);
     }
 }
 
-static void monitor_iothread_init(void)
-{
-    mon_iothread = iothread_create("mon_iothread", &error_abort);
-}
-
-void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread)
+void monitor_iothread_init(Monitor *mon)
 {
-    if (use_io_thread && !mon_iothread) {
-        monitor_iothread_init();
+    if (!mon_iothread) {
+        mon_iothread = iothread_create("mon_iothread", &error_abort);
     }
-    qemu_mutex_init(&mon->mon_lock);
-    mon->is_qmp = is_qmp;
-    mon->outbuf = g_string_new(NULL);
-    mon->use_io_thread = use_io_thread;
-}
-
-void monitor_data_destroy(Monitor *mon)
-{
-    g_free(mon->mon_cpu_path);
-    qemu_chr_fe_deinit(&mon->chr, false);
-    if (monitor_is_qmp(mon)) {
-        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, parent));
-    } else {
-        readline_free(container_of(mon, MonitorHMP, parent)->rs);
-    }
-    g_string_free(mon->outbuf, true);
-    qemu_mutex_destroy(&mon->mon_lock);
+    mon->use_io_thread = true;
 }
 
 void monitor_cleanup(void)
@@ -665,7 +654,7 @@ void monitor_cleanup(void)
      * Letting the iothread continue while shutting down the dispatcher
      * means that new requests may still be coming in. This is okay,
      * we'll just leave them in the queue without sending a response
-     * and monitor_data_destroy() will free them.
+     * and object finalization will free them.
      */
     WITH_QEMU_LOCK_GUARD(&monitor_lock) {
         qmp_dispatcher_co_shutdown = true;
@@ -679,8 +668,8 @@ void monitor_cleanup(void)
     /*
      * We need to explicitly stop the I/O thread (but not destroy it),
      * clean up the monitor resources, then destroy the I/O thread since
-     * we need to unregister from chardev below in
-     * monitor_data_destroy(), and chardev is not thread-safe yet
+     * we need to unregister from chardev below in object
+     * finalization, and chardev is not thread-safe yet
      */
     if (mon_iothread) {
         iothread_stop(mon_iothread);
@@ -695,7 +684,6 @@ void monitor_cleanup(void)
         /* Permit QAPI event emission from character frontend release */
         qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
-        monitor_data_destroy(mon);
         qemu_mutex_lock(&monitor_lock);
         object_unref(mon);
     }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index be2bd985b7..5be93eff4d 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,8 +168,6 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
-    monitor_data_init(&hmp->parent, false, false);
-
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp->parent, cpu_index);
         if (ret < 0) {
@@ -186,7 +184,6 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     }
 
 out:
-    monitor_data_destroy(&hmp->parent);
     object_unref(hmp);
     return output;
 }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index fe2aec9ce9..0de98b33fe 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -73,8 +73,16 @@ QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 
 OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
 
+static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
+
 static void monitor_qmp_finalize(Object *obj)
 {
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    json_message_parser_destroy(&mon->parser);
+    qemu_mutex_destroy(&mon->qmp_queue_lock);
+    monitor_qmp_cleanup_req_queue_locked(mon);
+    g_queue_free(mon->qmp_requests);
 }
 
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
@@ -505,14 +513,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
     }
 }
 
-void monitor_data_destroy_qmp(MonitorQMP *mon)
-{
-    json_message_parser_destroy(&mon->parser);
-    qemu_mutex_destroy(&mon->qmp_queue_lock);
-    monitor_qmp_cleanup_req_queue_locked(mon);
-    g_queue_free(mon->qmp_requests);
-}
-
 static void monitor_qmp_setup_handlers_bh(void *opaque)
 {
     MonitorQMP *mon = opaque;
@@ -538,8 +538,9 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
     qemu_chr_fe_set_echo(&mon->parent.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->parent, true,
-                      qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
+    if (qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
+        monitor_iothread_init(&mon->parent);
+    }
 
     mon->pretty = pretty;
 
-- 
2.53.0


