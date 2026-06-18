Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5253ECD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 11:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waATE-0006Wk-Gh; Thu, 18 Jun 2026 06:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waAT2-0006TR-RD
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:59:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waAT0-00025T-M0
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781780365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nzVajuluyRlzC1DSJS8hgQNZ6gXOgkeOIGH/NAVPWgg=;
 b=jD/GqrfEsKAY0dv0K0bivVcq1ton7M7EzVi8rbUGVfe9TM8XFfDDSopf6Do+tEawiKhzRW
 K1obtaeIVSq3i6ui4OfFMAiOdqxQwieJoG/noE1qlHa2sydiIdN3eyHI32P5LJ2H07LiQo
 LqMazLH0JsrmbcmFCPwkTT12c7IujqQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-zcyxYBYFMuupdEzvYHighQ-1; Thu,
 18 Jun 2026 06:59:21 -0400
X-MC-Unique: zcyxYBYFMuupdEzvYHighQ-1
X-Mimecast-MFC-AGG-ID: zcyxYBYFMuupdEzvYHighQ_1781780360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5961956043; Thu, 18 Jun 2026 10:59:20 +0000 (UTC)
Received: from berrange.com (unknown [10.44.49.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC45B1956087; Thu, 18 Jun 2026 10:59:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Brauner <brauner@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 10/35] monitor: move monitor_data_(init|destroy) into QOM
 init/finalize
Date: Thu, 18 Jun 2026 11:58:11 +0100
Message-ID: <20260618105836.991609-11-berrange@redhat.com>
In-Reply-To: <20260618105836.991609-1-berrange@redhat.com>
References: <20260618105836.991609-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Start to take advantage of QOM, by using object init and finalize
methods to replace monitor_data_init and monitor_data_destroy.

A standalone helper is provided to enable the I/O thread for QMP
where appropriate for the chardev backend.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/hmp.c              |  6 +++--
 monitor/monitor-internal.h |  3 +--
 monitor/monitor.c          | 46 +++++++++++++-------------------------
 monitor/qmp-cmds.c         |  3 ---
 monitor/qmp.c              | 34 +++++++++++++++-------------
 5 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 516aa25d4c..2bb2333da5 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -48,6 +48,10 @@ OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
 
 static void monitor_hmp_finalize(Object *obj)
 {
+    MonitorHMP *mon = MONITOR_HMP(obj);
+    if (mon->rs) {
+        readline_free(mon->rs);
+    }
 }
 
 static bool monitor_hmp_get_readline(Object *obj, Error **errp)
@@ -1590,8 +1594,6 @@ void monitor_new_hmp(const char *chardev_id, bool use_readline, Error **errp)
         return;
     }
 
-    monitor_data_init(&mon->parent_obj, false, false);
-
     if (mon->use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d34f9be139..6a4c3b0f37 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -193,8 +193,7 @@ extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
 void monitor_complete(Monitor *mon, Error **errp);
-void monitor_data_init(Monitor *mon, bool is_qmp, bool use_io_thread);
-void monitor_data_destroy(Monitor *mon);
+void monitor_iothread_init(Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index e3e5623a4b..76df379a2c 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -80,6 +80,10 @@ static void monitor_finalize(Object *obj)
     Monitor *mon = MONITOR(obj);
 
     g_free(mon->chardev_id);
+    g_free(mon->mon_cpu_path);
+    qemu_chr_fe_deinit(&mon->chr, false);
+    g_string_free(mon->outbuf, true);
+    qemu_mutex_destroy(&mon->mon_lock);
 }
 
 static char *monitor_get_chardev_id(Object *obj, Error **errp)
@@ -106,6 +110,11 @@ static void monitor_class_init(ObjectClass *cls, const void *data)
 
 static void monitor_init(Object *obj)
 {
+    Monitor *mon = MONITOR(obj);
+
+    qemu_mutex_init(&mon->mon_lock);
+    mon->is_qmp = !!object_dynamic_cast(obj, TYPE_MONITOR_QMP);
+    mon->outbuf = g_string_new(NULL);
 }
 
 Monitor *monitor_cur(void)
@@ -637,38 +646,16 @@ void monitor_list_append(Monitor *mon)
     qemu_mutex_unlock(&monitor_lock);
 
     if (mon) {
-        monitor_data_destroy(mon);
         object_unparent(OBJECT(mon));
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
-        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, parent_obj));
-    } else {
-        readline_free(container_of(mon, MonitorHMP, parent_obj)->rs);
-    }
-    g_string_free(mon->outbuf, true);
-    qemu_mutex_destroy(&mon->mon_lock);
+    mon->use_io_thread = true;
 }
 
 void monitor_cleanup(void)
@@ -686,7 +673,7 @@ void monitor_cleanup(void)
      * Letting the iothread continue while shutting down the dispatcher
      * means that new requests may still be coming in. This is okay,
      * we'll just leave them in the queue without sending a response
-     * and monitor_data_destroy() will free them.
+     * and object finalization will free them.
      */
     WITH_QEMU_LOCK_GUARD(&monitor_lock) {
         qmp_dispatcher_co_shutdown = true;
@@ -700,8 +687,8 @@ void monitor_cleanup(void)
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
@@ -716,7 +703,6 @@ void monitor_cleanup(void)
         /* Permit QAPI event emission from character frontend release */
         qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
-        monitor_data_destroy(mon);
         qemu_mutex_lock(&monitor_lock);
         object_unparent(OBJECT(mon));
     }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0d9adad288..6cb0b587fb 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -168,8 +168,6 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     char *output = NULL;
     MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
-    monitor_data_init(&hmp->parent_obj, false, false);
-
     if (has_cpu_index) {
         int ret = monitor_set_cpu(&hmp->parent_obj, cpu_index);
         if (ret < 0) {
@@ -186,7 +184,6 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     }
 
 out:
-    monitor_data_destroy(&hmp->parent_obj);
     object_unref(hmp);
     return output;
 }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index e3318b57db..694d303215 100644
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
 
 static bool monitor_qmp_get_pretty(Object *obj, Error **errp)
@@ -98,8 +106,15 @@ static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
                                    monitor_qmp_set_pretty);
 }
 
+static void handle_qmp_command(void *opaque, QObject *req, Error *err);
 static void monitor_qmp_init(Object *obj)
 {
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    qemu_mutex_init(&mon->qmp_queue_lock);
+    mon->qmp_requests = g_queue_new();
+
+    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
 }
 
 static bool qmp_oob_enabled(MonitorQMP *mon)
@@ -522,14 +537,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
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
@@ -572,14 +579,11 @@ void monitor_new_qmp(const char *chardev_id, bool pretty, Error **errp)
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->parent_obj, true,
-                      qemu_chr_has_feature(mon->parent_obj.chr.chr,
-                                           QEMU_CHAR_FEATURE_GCONTEXT));
-
-    qemu_mutex_init(&mon->qmp_queue_lock);
-    mon->qmp_requests = g_queue_new();
+    if (qemu_chr_has_feature(mon->parent_obj.chr.chr,
+                             QEMU_CHAR_FEATURE_GCONTEXT)) {
+        monitor_iothread_init(&mon->parent_obj);
+    }
 
-    json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
     if (mon->parent_obj.use_io_thread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
-- 
2.54.0


