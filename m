Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55DDCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhXa-0008Va-L2; Mon, 05 Oct 2026 08:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVu-0006D1-En
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVs-0004qg-1p
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbh4MVd8V6a1mlB3u3ETQxSesMc5TOS+ODj2FgnzI+k=;
 b=ePGhXQchkEzEZDPvGoRxrz0MI4SnpC9ehWc0dfdrTl2Oab38Moj2S9cnfddvjz1cyTIYFU
 zZoSVnFJqpEey/iV7mlQpJBgnZdbTlkJZHro4B9vlI3Di08YXhQ+yJ+9gcJP7CQGbwrnZv
 8a1tzYrc+ALXn1wUtB73oM4rlP+fLqM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-UyRxjKZqOaSWyOv4FFOyuQ-1; Mon,
 05 Oct 2026 08:09:43 -0400
X-MC-Unique: UyRxjKZqOaSWyOv4FFOyuQ-1
X-Mimecast-MFC-AGG-ID: UyRxjKZqOaSWyOv4FFOyuQ_1791202182
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BB911800EFB; Mon,  5 Oct 2026 12:09:42 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B55193001D29; Mon,  5 Oct 2026 12:09:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 24/24] trace: remove 'trace_event_get_state' wrapper
Date: Mon,  5 Oct 2026 13:08:55 +0100
Message-ID: <20261005120855.421973-25-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
 scripts/tracetool/backend/__init__.py |  3 ++-
 scripts/tracetool/backend/log.py      |  2 +-
 scripts/tracetool/format/h.py         |  2 +-
 tests/tracetool/all.h                 |  8 ++++----
 tests/tracetool/ftrace.h              |  4 ++--
 tests/tracetool/log.h                 |  4 ++--
 tests/tracetool/simple.h              |  4 ++--
 tests/tracetool/syslog.h              |  4 ++--
 trace/control.h                       | 12 ------------
 9 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 72f549c77c4..2749c4e6315 100644
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
 
 
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 4a622dd4dcb..00a0dd9c9dc 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -28,7 +28,7 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    if (trace_event_get_state(%(event_id)s) &&',
+    out('    if (trace_event_get_state_dynamic_by_id(%(event_id)s) &&',
         '        qemu_loglevel_mask(LOG_TRACE)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
         '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index f719fe09397..ad4ce4414fe 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -66,7 +66,7 @@ def generate(events, backend, group):
 
         if backend.check_trace_event_get_state:
             event_id = 'TRACE_' + e.name.upper()
-            cond = "trace_event_get_state(%s)" % event_id
+            cond = "trace_event_get_state_dynamic_by_id(%s)" % event_id
             out('    if (%(cond)s) {',
                 cond=cond)
             backend.generate(e, group, check_trace_event_get_state=True)
diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
index 01971827e4b..d4c91cdd1a4 100644
--- a/tests/tracetool/all.h
+++ b/tests/tracetool/all.h
@@ -51,14 +51,14 @@ void _simple_trace_test_wibble(void *context, int value);
 static inline void trace_test_blah(void *context, const char *filename)
 {
     QEMU_TEST_BLAH(context, filename);
-    if (trace_event_get_state(TRACE_TEST_BLAH) &&
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) &&
         qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
             qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
 #line 59 "all.h"
     }
     tracepoint(qemu, test_blah, context, filename);
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
         ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
 #line 65 "all.h"
@@ -80,14 +80,14 @@ static inline void trace_test_blah(void *context, const char *filename)
 static inline void trace_test_wibble(void *context, int value)
 {
     QEMU_TEST_WIBBLE(context, value);
-    if (trace_event_get_state(TRACE_TEST_WIBBLE) &&
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) &&
         qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
             qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
 #line 88 "all.h"
     }
     tracepoint(qemu, test_wibble, context, value);
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
 #line 94 "all.h"
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
index 9afbe721a47..02bb1309e20 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -20,7 +20,7 @@ extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH) &&
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) &&
         qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
             qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
@@ -35,7 +35,7 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE) &&
+    if (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) &&
         qemu_loglevel_mask(LOG_TRACE)) {
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


