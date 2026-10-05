Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A72CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhWk-00077i-Ov; Mon, 05 Oct 2026 08:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVh-00066S-3V
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVc-0004kv-4T
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jPXVc57K+Lbd/G5TmukSHZO8fyBmnGj9LPR8dcyvJL4=;
 b=iFHrJ2dsfjJbq7z+zuMVGbtmvjxPpJNmGrKDqCha/gvfAkdJDZMgrQ1wa0gAs6wkoAGwhu
 lOVwFGjUkQBzrCJYfxH3cpDC+HUjq6eAanIh6uDk5Je1N2O9sUSOohzqNilbsRKfLubD6g
 iCU/vrbNjsQKjtmkO+x+KVkL38FMFkg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-KxrfhgDXMZuvL3V-C5kErA-1; Mon,
 05 Oct 2026 08:09:28 -0400
X-MC-Unique: KxrfhgDXMZuvL3V-C5kErA-1
X-Mimecast-MFC-AGG-ID: KxrfhgDXMZuvL3V-C5kErA_1791202167
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A9DD1829E13; Mon,  5 Oct 2026 12:09:27 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CFFDE3001D2C; Mon,  5 Oct 2026 12:09:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 16/24] trace: eliminate dupe
 trace_event_get_state_dynamic_by_id() calls
Date: Mon,  5 Oct 2026 13:08:47 +0100
Message-ID: <20261005120855.421973-17-berrange@redhat.com>
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

Each backend generates the same trace_event_get_state_dynamic_by_id()
call for the TRACE....DSTATE() macro body, so when multiple backends
are enabled, the same check is repeated:

 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     QEMU_TEST_WIBBLE_ENABLED() || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     tracepoint_enabled(qemu, test_wibble) || \
     false)

Expanding the use of the 'backend.check_trace_event_get_state'
attr in the C header generator removes the duplication, in the
same way that the Rust generator already does.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/backend/__init__.py |  4 ++--
 scripts/tracetool/backend/ftrace.py   |  4 ----
 scripts/tracetool/backend/log.py      |  4 ----
 scripts/tracetool/backend/simple.py   |  5 -----
 scripts/tracetool/backend/syslog.py   |  4 ----
 scripts/tracetool/format/h.py         |  8 +++++++-
 tests/tracetool/all.h                 | 22 ++++++++--------------
 7 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 9109a783c72..72f549c77c4 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -133,8 +133,8 @@ def generate_begin(self, events, group):
     def generate(self, event, group, check_trace_event_get_state=None):
         self._run_function("generate_%s", event, group, check_trace_event_get_state=check_trace_event_get_state)
 
-    def generate_backend_dstate(self, event, group):
-        self._run_function("generate_%s_backend_dstate", event, group)
+    def generate_backend_dstate(self, event, group, check_trace_event_get_state=None):
+        self._run_function("generate_%s_backend_dstate", event, group, check_trace_event_get_state=check_trace_event_get_state)
 
     def generate_end(self, events, group):
         self._run_function("generate_%s_end", events, group)
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index e304ef21999..94cffc45a9d 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -40,10 +40,6 @@ def generate_h(event, group):
         argnames=argnames)
 
 
-def generate_h_backend_dstate(event, group):
-    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
-        event_id="TRACE_" + event.name.upper())
-
 def generate_rs(event, group):
     out('        let format_string = c"%(fmt)s\\n";',
         '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 9e3e5046f5f..577ee158584 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -41,10 +41,6 @@ def generate_h(event, group):
         argnames=argnames)
 
 
-def generate_h_backend_dstate(event, group):
-    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
-        event_id="TRACE_" + event.name.upper())
-
 def generate_rs(event, group):
     out('        let format_string = c"%(fmt)s\\n";',
         '        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {',
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index e22683c7d2a..15f27e26bd5 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -42,11 +42,6 @@ def generate_h(event, group):
         args=", ".join(event.args.names()))
 
 
-def generate_h_backend_dstate(event, group):
-    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
-        event_id="TRACE_" + event.name.upper())
-
-
 def generate_c_begin(events, group):
     out('#include "trace/simple.h"',
         '')
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 746efd35fb9..ba269cb6a33 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -43,7 +43,3 @@ def generate_rs(event, group):
         '        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, %(args)s);}',
         fmt=expand_format_string(event.fmt, event.name + " "),
         args=event.args.rust_call_varargs())
-
-def generate_h_backend_dstate(event, group):
-    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
-        event_id="TRACE_" + event.name.upper())
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index 6ffb7256e31..5ad3a419f82 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -55,7 +55,13 @@ def generate(events, backend, group):
             api=e.api(e.QEMU_BACKEND_DSTATE))
 
         if "disable" not in e.properties:
-            backend.generate_backend_dstate(e, group)
+            backend.generate_backend_dstate(e, group, check_trace_event_get_state=False)
+
+            if backend.check_trace_event_get_state:
+                event_id = 'TRACE_' + e.name.upper()
+                out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
+                    event_id=event_id)
+                backend.generate_backend_dstate(e, group, check_trace_event_get_state=True)
 
         out('    false)')
 
diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
index 41fa4d0e8a2..5627c1d8930 100644
--- a/tests/tracetool/all.h
+++ b/tests/tracetool/all.h
@@ -44,11 +44,8 @@ void _simple_trace_test_wibble(void *context, int value);
 
 #define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
     QEMU_TEST_BLAH_ENABLED() || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     tracepoint_enabled(qemu, test_blah) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     false)
 
 static inline void trace_test_blah(void *context, const char *filename)
@@ -58,26 +55,23 @@ static inline void trace_test_blah(void *context, const char *filename)
     if (trace_event_get_state(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
         ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
-#line 62 "all.h"
+#line 59 "all.h"
         if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
             qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
-#line 66 "all.h"
+#line 63 "all.h"
         }
         _simple_trace_test_blah(context, filename);
 #line 4 "trace-events"
         syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
-#line 71 "all.h"
+#line 68 "all.h"
     }
 }
 
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     QEMU_TEST_WIBBLE_ENABLED() || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     tracepoint_enabled(qemu, test_wibble) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     false)
 
 static inline void trace_test_wibble(void *context, int value)
@@ -87,16 +81,16 @@ static inline void trace_test_wibble(void *context, int value)
     if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
-#line 91 "all.h"
+#line 85 "all.h"
         if (qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
             qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
-#line 95 "all.h"
+#line 89 "all.h"
         }
         _simple_trace_test_wibble(context, value);
 #line 5 "trace-events"
         syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
-#line 100 "all.h"
+#line 94 "all.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
-- 
2.55.0


