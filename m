Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EBCCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCZxB-0004AL-Ui; Fri, 02 Oct 2026 05:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZx9-00043V-LJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:53:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCZx7-00011G-Lk
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 05:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790934796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX5n9PcJWESBHcmE5HSyA40KTRWhZ/9cdxqeLnCla0c=;
 b=Keyiq1yVZCOqwGbsbIkWASv5M1czgdKSONy7HdMdDYDYEgye2dHjBemS3oVTinWnFk5YxT
 DIbcRjdGcQvmDpi8bxBUmMa74SOdxesgGJS9WlesI+Q+hvVIhTlJI8qyCr7HXdL8PGgXTa
 3DASf/3gFeKVgYst+XL0b3MmleSoNrE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-CBU8DXMGNu-HcLJ6dgpc7w-1; Fri,
 02 Oct 2026 05:53:13 -0400
X-MC-Unique: CBU8DXMGNu-HcLJ6dgpc7w-1
X-Mimecast-MFC-AGG-ID: CBU8DXMGNu-HcLJ6dgpc7w_1790934792
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3985195607F; Fri,  2 Oct 2026 09:53:12 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33B9E180049F; Fri,  2 Oct 2026 09:53:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 20/20] trace: remove 'trace_event_get_state' wrapper
Date: Fri,  2 Oct 2026 10:52:32 +0100
Message-ID: <20261002095232.3605567-21-berrange@redhat.com>
In-Reply-To: <20261002095232.3605567-1-berrange@redhat.com>
References: <20261002095232.3605567-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

The 'trace_event_get_state' macro is a wrapper around the
'trace_event_get_state_dynamic_by_id' macro, which is a direct
check of the _TRACE_...._DSTATE global variable.

The only code that should be using this is the generated trace
probes, but the name looks rather appealing causing it to be
mistakenly used in other places, instead of the recommended
'trace_event_get_state_dynamic_backends'.

Removing the 'trace_event_get_state' macro reduces the potential
for confusion.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 monitor/qmp.c                         |  4 ++--
 scripts/tracetool/backend/__init__.py |  3 ++-
 scripts/tracetool/format/h.py         |  2 +-
 tests/tracetool/all.h                 |  4 ++--
 tests/tracetool/ftrace.h              |  4 ++--
 tests/tracetool/log.h                 |  4 ++--
 tests/tracetool/simple.h              |  4 ++--
 tests/tracetool/syslog.h              |  4 ++--
 trace/control.h                       | 12 ------------
 9 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/monitor/qmp.c b/monitor/qmp.c
index aec03157750..b5cc3ee1973 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -439,7 +439,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
 
         /* Process request */
         if (req_obj->req) {
-            if (trace_event_get_state(TRACE_MONITOR_QMP_CMD_IN_BAND)) {
+            if (trace_event_get_state_backends(TRACE_MONITOR_QMP_CMD_IN_BAND)) {
                 QDict *qdict = qobject_to(QDict, req_obj->req);
                 QObject *id = qdict ? qdict_get(qdict, "id") : NULL;
                 GString *id_json;
@@ -495,7 +495,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 
     if (qdict && qmp_is_oob(qdict)) {
         /* OOB commands are executed immediately */
-        if (trace_event_get_state(TRACE_MONITOR_QMP_CMD_OUT_OF_BAND)) {
+        if (trace_event_get_state_backends(TRACE_MONITOR_QMP_CMD_OUT_OF_BAND)) {
             QObject *id = qdict_get(qdict, "id");
             GString *id_json;
 
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 9109a783c72..12bb91f5347 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -26,7 +26,8 @@
                             considered "public".
 CHECK_TRACE_EVENT_GET_STATE If exists and is set to 'True', the backend-specific
                             code inside the tracepoint is emitted within an
-                            ``if trace_event_get_state()`` conditional.
+                            ``if trace_event_get_state_dynamic_by_id()``
+                            conditional.
 =========================== ====================================================
 
 
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index af1482f6238..822740a3140 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -60,7 +60,7 @@ def generate(events, backend, group):
 
         if backend.check_trace_event_get_state:
             event_id = 'TRACE_' + e.name.upper()
-            cond = "trace_event_get_state(%s)" % event_id
+            cond = "trace_event_get_state_dynamic_by_id(%s)" % event_id
             out('    if (%(cond)s) {',
                 cond=cond)
             backend.generate(e, group, check_trace_event_get_state=True)
diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
index 6eed86edb4d..513f59d6ffb 100644
--- a/tests/tracetool/all.h
+++ b/tests/tracetool/all.h
@@ -54,7 +54,7 @@ static inline void trace_test_blah(void *context, const char *filename)
 {
     QEMU_TEST_BLAH(context, filename);
     tracepoint(qemu, test_blah, context, filename);
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
         ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
 #line 60 "all.h"
@@ -84,7 +84,7 @@ static inline void trace_test_wibble(void *context, int value)
 {
     QEMU_TEST_WIBBLE(context, value);
     tracepoint(qemu, test_wibble, context, value);
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
 #line 89 "all.h"
diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index 4eba6b4d599..b55ee08bbfe 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -19,7 +19,7 @@ extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
         ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
 #line 26 "ftrace.h"
@@ -32,7 +32,7 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
 #line 39 "ftrace.h"
diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index cf37ed3ce26..973b72ff87f 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -20,7 +20,7 @@ extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH)) {
         if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
             qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
@@ -36,7 +36,7 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE)) {
         if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
             qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
diff --git a/tests/tracetool/simple.h b/tests/tracetool/simple.h
index 9b066364b0a..0b9e7cba35c 100644
--- a/tests/tracetool/simple.h
+++ b/tests/tracetool/simple.h
@@ -20,7 +20,7 @@ void _simple_trace_test_wibble(void *context, int value);
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH)) {
         _simple_trace_test_blah(context, filename);
     }
 }
@@ -31,7 +31,7 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE)) {
         _simple_trace_test_wibble(context, value);
     }
 }
diff --git a/tests/tracetool/syslog.h b/tests/tracetool/syslog.h
index 6a9304489f6..173b35dcf69 100644
--- a/tests/tracetool/syslog.h
+++ b/tests/tracetool/syslog.h
@@ -19,7 +19,7 @@ extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
         syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
 #line 26 "syslog.h"
@@ -32,7 +32,7 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
 #line 39 "syslog.h"
diff --git a/trace/control.h b/trace/control.h
index 80eb2bd14e6..0bcb34a6393 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -97,18 +97,6 @@ static uint32_t trace_event_get_id(TraceEvent *ev);
  */
 static const char * trace_event_get_name(TraceEvent *ev);
 
-/**
- * trace_event_get_state:
- * @id: Event identifier name.
- *
- * Get the tracing state of an event, both static and the QEMU dynamic state.
- *
- * If the event has the disabled property, the check will have no performance
- * impact.
- */
-#define trace_event_get_state(id)                       \
-    (trace_event_get_state_dynamic_by_id(id))
-
 /**
  * trace_event_get_state_backends:
  * @id: Event identifier name.
-- 
2.55.0


