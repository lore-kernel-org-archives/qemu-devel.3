Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB0CCC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJXE-0004Pr-BC; Thu, 15 Oct 2026 07:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJXA-0004Fc-T4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJX8-0004A1-VU
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=291beaW8H/SmRMZ3rzIXf8UTtlKNS0ohfqrHvHqrY8g=;
 b=NkzfNFIwBad/UGH53NVMATxVJdFmXgkH2FjASdDuoDurYkCgMY1qbMs5Fm1PQ3R8pbFL7F
 wBwk1yUE07JoXwEjAjWG6O6SPCWB6vsKq2uNR6RX/EfHmjPJPqo0wIrTmBdjhxO+2EjXJV
 azmsyrQI4zDIB2e69vEqhyPzmDo789w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-NZCPBX9FP7CpWN3oXL3PMA-1; Thu,
 15 Oct 2026 11:21:59 +0000
X-MC-Unique: NZCPBX9FP7CpWN3oXL3PMA-1
X-Mimecast-MFC-AGG-ID: NZCPBX9FP7CpWN3oXL3PMA_1792063317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0BEE1955F70; Thu, 15 Oct 2026 11:21:57 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3064A1800257; Thu, 15 Oct 2026 11:21:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 17/21] monitor: capture monitor commands and events in data
 recorder
Date: Thu, 15 Oct 2026 12:20:40 +0100
Message-ID: <20261015112044.1999748-18-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

QMP monitor commands which change system state (ie not query-XXX
commands) are relevant to the data recorder, as they reflect what
has been done to QEMU at runtime by the mgmt application.

QMP monitor events are relevant to the data recorder, as they
reflect a combination of what has been done to QEMU at runtime by
the mgmt application, as well as changes triggered by the guest OS.

QMP error responses are relevant either to reveal mistakes in mgmt
apps, or to reveal problems in QEMU. If the associated QMP command
was not already recorded, it will be recorded for any error
response to provide context to the failure.

QMP normal responses are skipped since the data can be volumous
and thus result in poor signal/noise ratio.

The QMP commands are never captured to a string buffer as input
is streamed into the JSON parser and the result is spat out as
a QObject. Thus, the commands need to be formatted back into JSON
string format for the data recorder. This is a mild but acceptable
performance overhead, in the overall context of handling a QMP
command.

The QMP events are captured immediately before they are written
back on the wire where already in string format.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/qmp.c | 67 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index ccb39a48d4c..659ad23d832 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -34,6 +34,7 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 #include "qom/object_interfaces.h"
+#include "qemu/tldr.h"
 #include "trace.h"
 
 /*
@@ -80,7 +81,8 @@ static MonitorQMP *qmp_dispatcher_current_mon;
 OBJECT_DEFINE_TYPE(MonitorQMP, monitor_qmp, MONITOR_QMP, MONITOR);
 
 static void monitor_qmp_cleanup_req_queue_locked(MonitorQMP *mon);
-static void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
+static void qmp_send_response(MonitorQMP *mon, const QDict *rsp,
+                              const QObject *ctx);
 
 static void monitor_qmp_finalize(Object *obj)
 {
@@ -169,7 +171,7 @@ static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict)
         }
     }
 
-    qmp_send_response(qmp, qdict);
+    qmp_send_response(qmp, qdict, NULL);
 }
 
 static bool monitor_qmp_requires_iothread(const Monitor *mon)
@@ -243,7 +245,8 @@ static void monitor_qmp_cleanup_queue_and_resume(MonitorQMP *mon)
 
 }
 
-static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
+static void qmp_send_response(MonitorQMP *mon, const QDict *rsp,
+                              const QObject *ctx)
 {
     const QObject *data = QOBJECT(rsp);
     GString *json;
@@ -252,6 +255,30 @@ static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
     assert(json != NULL);
     trace_monitor_qmp_respond(mon, json->str);
 
+    /*
+     * Errors are always useful to record. We recorded the
+     * command in the caller in many cases, but if not, then
+     * 'ctx' will be non-NULL and we should record it now
+     * for context.
+     */
+    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_COMMAND) &&
+        qdict_haskey(rsp, "error")) {
+        if (ctx) {
+            g_autoptr(GString) ctxstr = qobject_to_json(ctx);
+            qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_COMMAND, ctxstr->str);
+        }
+        qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_COMMAND, json->str);
+    }
+
+    /*
+     * Capture events, since they represent changes
+     * in state or behaviour
+     */
+    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_EVENT) &&
+        qdict_haskey(rsp, "event")) {
+        qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_EVENT, json->str);
+    }
+
     g_string_append_c(json, '\n');
     monitor_puts(&mon->parent_obj, json->str);
 
@@ -263,10 +290,10 @@ static void qmp_send_response(MonitorQMP *mon, const QDict *rsp)
  * Null @rsp can only happen for commands with QCO_NO_SUCCESS_RESP.
  * Nothing is emitted then.
  */
-static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
+static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp, QObject *ctx)
 {
     if (rsp) {
-        qmp_send_response(mon, rsp);
+        qmp_send_response(mon, rsp, ctx);
     }
 }
 
@@ -276,9 +303,33 @@ static void monitor_qmp_respond(MonitorQMP *mon, QDict *rsp)
  */
 static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
 {
+    QObject *ctx = req;
     QDict *rsp;
     QDict *error;
 
+    /*
+     * Capture commands which are liable to change state,
+     * i.e. exclude purely information query comamnds
+     */
+    if (qtldr_msg_enabled(QTLDR_MSG_BUCKET_TYPE_COMMAND)) {
+        QDict *cmd = qobject_to(QDict, req);
+        if (cmd != NULL) {
+            const char *cmdname = qdict_get_try_str(cmd, "execute")
+                ?: qdict_get_try_str(cmd, "exec-oob");
+            if (cmdname != NULL &&
+                !g_str_has_prefix(cmdname, "query-") &&
+                !g_str_has_prefix(cmdname, "qom-list")) {
+                g_autoptr(GString) cmdstr = qobject_to_json(req);
+                qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_COMMAND, cmdstr->str);
+                /*
+                 * Prevent recording cmd twice if the later response
+                 * is an error
+                 */
+                ctx = NULL;
+            }
+        }
+    }
+
     rsp = qmp_dispatch(mon->commands, req, qmp_oob_enabled(mon),
                        &mon->parent_obj);
 
@@ -294,7 +345,7 @@ static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
         }
     }
 
-    monitor_qmp_respond(mon, rsp);
+    monitor_qmp_respond(mon, rsp, ctx);
     qobject_unref(rsp);
 }
 
@@ -455,7 +506,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
             trace_monitor_qmp_err_in_band(error_get_pretty(req_obj->err));
             rsp = qmp_error_response(req_obj->err);
             req_obj->err = NULL;
-            monitor_qmp_respond(mon, rsp);
+            monitor_qmp_respond(mon, rsp, NULL);
             qobject_unref(rsp);
         }
 
@@ -623,7 +674,7 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
             monitor_qmp_caps_reset(mon);
         }
         data = qmp_greeting(mon);
-        qmp_send_response(mon, data);
+        qmp_send_response(mon, data, NULL);
         qobject_unref(data);
         break;
     case CHR_EVENT_CLOSED:
-- 
2.56.0


