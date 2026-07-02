Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B36FC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJtX-00061A-1U; Thu, 02 Jul 2026 12:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtT-0005zF-4Q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wfJtR-0006Uq-7g
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 12:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783008240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OXNWMeRn1wJuMp4RgzRmMFD9tBlu+Af3jZH9Pqb6ewo=;
 b=FNTv6ZmONNTJ0MKAAKiyauuHKBRdoH0BMMFrsY14pmKRPq4kYQgHUDmVDjjZ2zo0ycb8He
 w3ZT7xJxY05h/TBmseaJ4S5g1dsxakIo6LzuszM6v0BJ+Vn2/VOw+8RyK1VEWzqVRHA6qo
 KkvpXtxWx0I+o8xBeZgb7uW6P5pO9nE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-OMVQIN2yMCmvfcW2zmSOkQ-1; Thu,
 02 Jul 2026 12:03:59 -0400
X-MC-Unique: OMVQIN2yMCmvfcW2zmSOkQ-1
X-Mimecast-MFC-AGG-ID: OMVQIN2yMCmvfcW2zmSOkQ_1783008237
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72B92183339B; Thu,  2 Jul 2026 16:03:57 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.186])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E0DA194510E; Thu,  2 Jul 2026 16:03:53 +0000 (UTC)
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
Subject: [PATCH v6 03/34] monitor: replace 'common' with 'parent_obj' in
 MonitorQMP
Date: Thu,  2 Jul 2026 17:03:06 +0100
Message-ID: <20260702160337.1910921-4-berrange@redhat.com>
In-Reply-To: <20260702160337.1910921-1-berrange@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The field name 'parent_obj' is standard practice for QOM structs
so align the QMP monitor.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/monitor-internal.h |  2 +-
 monitor/monitor.c          |  4 ++--
 monitor/qmp-cmds-control.c |  4 ++--
 monitor/qmp.c              | 40 +++++++++++++++++++-------------------
 4 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index eb301ea796..4da2b2a677 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -141,7 +141,7 @@ struct MonitorHMP {
 };
 
 typedef struct {
-    Monitor common;
+    Monitor parent_obj;
     JSONMessageParser parser;
     bool pretty;
     /*
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2a1b511ff4..0b7b464ebe 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -308,7 +308,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
             continue;
         }
 
-        qmp_mon = container_of(mon, MonitorQMP, common);
+        qmp_mon = container_of(mon, MonitorQMP, parent_obj);
         {
             QEMU_LOCK_GUARD(&mon->mon_lock);
             if (qmp_mon->commands == &qmp_cap_negotiation_commands) {
@@ -625,7 +625,7 @@ void monitor_data_destroy(Monitor *mon)
     g_free(mon->mon_cpu_path);
     qemu_chr_fe_deinit(&mon->chr, false);
     if (monitor_is_qmp(mon)) {
-        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, common));
+        monitor_data_destroy_qmp(container_of(mon, MonitorQMP, parent_obj));
     } else {
         readline_free(container_of(mon, MonitorHMP, parent_obj)->rs);
     }
diff --git a/monitor/qmp-cmds-control.c b/monitor/qmp-cmds-control.c
index 150ca9f5cb..af6a2a118b 100644
--- a/monitor/qmp-cmds-control.c
+++ b/monitor/qmp-cmds-control.c
@@ -76,7 +76,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
     MonitorQMP *mon;
 
     assert(monitor_is_qmp(cur_mon));
-    mon = container_of(cur_mon, MonitorQMP, common);
+    mon = container_of(cur_mon, MonitorQMP, parent_obj);
 
     if (mon->commands == &qmp_commands) {
         error_set(errp, ERROR_CLASS_COMMAND_NOT_FOUND,
@@ -126,7 +126,7 @@ CommandInfoList *qmp_query_commands(Error **errp)
     MonitorQMP *mon;
 
     assert(monitor_is_qmp(cur_mon));
-    mon = container_of(cur_mon, MonitorQMP, common);
+    mon = container_of(cur_mon, MonitorQMP, parent_obj);
 
     qmp_for_each_command(mon->commands, query_commands_cb, &list);
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 687019811f..27934206db 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -80,7 +80,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
 {
     memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
     memset(mon->capab, 0, sizeof(mon->capab));
-    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->common.use_io_thread;
+    mon->capab_offered[QMP_CAPABILITY_OOB] = mon->parent_obj.use_io_thread;
 }
 
 static void qmp_request_free(QMPRequest *req)
@@ -124,7 +124,7 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
          * when we get here while the monitor is suspended.  An
          * unfortunately timed CHR_EVENT_CLOSED can do the trick.
          */
-        monitor_resume(&mon->common);
+        monitor_resume(&mon->parent_obj);
     }
 
 }
@@ -139,7 +139,7 @@ void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
     trace_monitor_qmp_respond(mon, json->str);
 
     g_string_append_c(json, '\n');
-    monitor_puts(&mon->common, json->str);
+    monitor_puts(&mon->parent_obj, json->str);
 
     g_string_free(json, true);
 }
@@ -166,7 +166,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
     QDict *error;
 
     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
-                       &mon->common);
+                       &mon->parent_obj);
 
     if (mon->commands == &qmp_cap_negotiation_commands) {
         error = qdict_get_qdict(rsp, "error");
@@ -207,7 +207,7 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
             continue;
         }
 
-        qmp_mon = container_of(mon, MonitorQMP, common);
+        qmp_mon = container_of(mon, MonitorQMP, parent_obj);
         qemu_mutex_lock(&qmp_mon->qmp_queue_lock);
         req_obj = g_queue_pop_head(qmp_mon->qmp_requests);
         if (req_obj) {
@@ -302,7 +302,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         oob_enabled = qmp_oob_enabled(mon);
         if (oob_enabled
             && mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
-            monitor_resume(&mon->common);
+            monitor_resume(&mon->parent_obj);
         }
 
         /*
@@ -343,7 +343,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         }
 
         if (!oob_enabled) {
-            monitor_resume(&mon->common);
+            monitor_resume(&mon->parent_obj);
         }
 
         qmp_request_free(req_obj);
@@ -408,7 +408,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
          */
         if (!qmp_oob_enabled(mon) ||
             mon->qmp_requests->length == QMP_REQ_QUEUE_LEN_MAX - 1) {
-            monitor_suspend(&mon->common);
+            monitor_suspend(&mon->parent_obj);
         }
 
         /*
@@ -462,7 +462,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
 
     switch (event) {
     case CHR_EVENT_OPENED:
-        WITH_QEMU_LOCK_GUARD(&mon->common.mon_lock) {
+        WITH_QEMU_LOCK_GUARD(&mon->parent_obj.mon_lock) {
             mon->commands = &qmp_cap_negotiation_commands;
             monitor_qmp_caps_reset(mon);
         }
@@ -504,27 +504,27 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     MonitorQMP *mon = opaque;
     GMainContext *context;
 
-    assert(mon->common.use_io_thread);
+    assert(mon->parent_obj.use_io_thread);
     context = iothread_get_g_main_context(mon_iothread);
     assert(context);
-    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+    qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
-                             NULL, &mon->common, context, true);
-    monitor_list_append(&mon->common);
+                             NULL, &mon->parent_obj, context, true);
+    monitor_list_append(&mon->parent_obj);
 }
 
 void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
 {
     MonitorQMP *mon = g_new0(MonitorQMP, 1);
 
-    if (!qemu_chr_fe_init(&mon->common.chr, chr, errp)) {
+    if (!qemu_chr_fe_init(&mon->parent_obj.chr, chr, errp)) {
         g_free(mon);
         return;
     }
-    qemu_chr_fe_set_echo(&mon->common.chr, true);
+    qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    monitor_data_init(&mon->common, true, false,
+    monitor_data_init(&mon->parent_obj, true, false,
                       qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT));
 
     mon->pretty = pretty;
@@ -533,7 +533,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
     mon->qmp_requests = g_queue_new();
 
     json_message_parser_init(&mon->parser, handle_qmp_command, mon, NULL);
-    if (mon->common.use_io_thread) {
+    if (mon->parent_obj.use_io_thread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
@@ -553,9 +553,9 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+        qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
                                  monitor_qmp_read, monitor_qmp_event,
-                                 NULL, &mon->common, NULL, true);
-        monitor_list_append(&mon->common);
+                                 NULL, &mon->parent_obj, NULL, true);
+        monitor_list_append(&mon->parent_obj);
     }
 }
-- 
2.54.0


