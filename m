Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46276607041C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N2h7B11F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhRi-0007E4-MH; Wed, 04 Nov 2026 15:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRW-000731-8l
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRU-00069T-10
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793823523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qET1C5bDfM2VhuVuw7XPqzaGlvXdrrKHqoGPXvja8g8=;
 b=N2h7B11F4RKWDyXjyHccLudYbubVTwn73+aGG/xHA70/jsoHjwBvbIojiXI+QT+wk/8GRp
 e+oUi0MHA3czkX6WcBGMYqGLtgdImlpu5YOHyTDatGShKQTNtjfeIpFP9Q2M/Awr6Rx8w9
 18t8CGLfPSN9AK0XTnG37iApI8c66ak=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-lZ5o66JzNnSHg7pQePNiqg-1; Wed,
 04 Nov 2026 15:18:39 -0500
X-MC-Unique: lZ5o66JzNnSHg7pQePNiqg-1
X-Mimecast-MFC-AGG-ID: lZ5o66JzNnSHg7pQePNiqg_1793823517
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87E481955E9C; Wed,  4 Nov 2026 20:18:37 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C718D301D916; Wed,  4 Nov 2026 20:18:36 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 20/25] trace: include qemu_loglevel_mask(LOG_TRACE) in guard
Date: Wed,  4 Nov 2026 15:17:56 -0500
Message-ID: <20261104201802.11556-21-stefanha@redhat.com>
In-Reply-To: <20261104201802.11556-1-stefanha@redhat.com>
References: <20261104201802.11556-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

If emitting a trace event requires computation for the parameters
passed to the probe, the callers should guard that computation
with trace_event_by_state_backends(), which is a macro expanding
to a check of the "TRACE_...._DSTATE()" expression. For the
log backend this should include a check for LOG_TRACE being
present in the configured log level.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/tracetool/all.h            | 34 +++++++++++++++++++-------------
 tests/tracetool/log.h            | 20 +++++++++----------
 scripts/tracetool/backend/log.py | 24 +++++++++++++++++-----
 tests/tracetool/all.rs           | 16 +++++++++++----
 tests/tracetool/log.rs           |  6 ++++--
 5 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
index 5627c1d8930..0ae2598eb1d 100644
--- a/tests/tracetool/all.h
+++ b/tests/tracetool/all.h
@@ -44,6 +44,8 @@ void _simple_trace_test_wibble(void *context, int value);
 
 #define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
     QEMU_TEST_BLAH_ENABLED() || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     tracepoint_enabled(qemu, test_blah) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     false)
@@ -51,25 +53,28 @@ void _simple_trace_test_wibble(void *context, int value);
 static inline void trace_test_blah(void *context, const char *filename)
 {
     QEMU_TEST_BLAH(context, filename);
+    if (trace_event_get_state(TRACE_TEST_BLAH) &&
+        qemu_loglevel_mask(LOG_TRACE)) {
+#line 4 "trace-events"
+            qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
+#line 61 "all.h"
+    }
     tracepoint(qemu, test_blah, context, filename);
     if (trace_event_get_state(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
         ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
-#line 59 "all.h"
-        if (qemu_loglevel_mask(LOG_TRACE)) {
-#line 4 "trace-events"
-            qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
-#line 63 "all.h"
-        }
+#line 67 "all.h"
         _simple_trace_test_blah(context, filename);
 #line 4 "trace-events"
         syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
-#line 68 "all.h"
+#line 71 "all.h"
     }
 }
 
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     QEMU_TEST_WIBBLE_ENABLED() || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     tracepoint_enabled(qemu, test_wibble) || \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     false)
@@ -77,20 +82,21 @@ static inline void trace_test_blah(void *context, const char *filename)
 static inline void trace_test_wibble(void *context, int value)
 {
     QEMU_TEST_WIBBLE(context, value);
+    if (trace_event_get_state(TRACE_TEST_WIBBLE) &&
+        qemu_loglevel_mask(LOG_TRACE)) {
+#line 5 "trace-events"
+            qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
+#line 90 "all.h"
+    }
     tracepoint(qemu, test_wibble, context, value);
     if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
-#line 85 "all.h"
-        if (qemu_loglevel_mask(LOG_TRACE)) {
-#line 5 "trace-events"
-            qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
-#line 89 "all.h"
-        }
+#line 96 "all.h"
         _simple_trace_test_wibble(context, value);
 #line 5 "trace-events"
         syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
-#line 94 "all.h"
+#line 100 "all.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index ff510d54908..9957a854c00 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -16,32 +16,32 @@ extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
 
 
 #define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     false)
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (trace_event_get_state(TRACE_TEST_BLAH)) {
-        if (qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state(TRACE_TEST_BLAH) &&
+        qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
             qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
-#line 29 "log.h"
-        }
+#line 30 "log.h"
     }
 }
 
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
-    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    (trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) && \
+     qemu_loglevel_mask(LOG_TRACE)) || \
     false)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
-        if (qemu_loglevel_mask(LOG_TRACE)) {
+    if (trace_event_get_state(TRACE_TEST_WIBBLE) &&
+        qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
             qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
-#line 44 "log.h"
-        }
+#line 45 "log.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 577ee158584..0e7909efe8b 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -16,7 +16,6 @@
 
 
 PUBLIC = True
-CHECK_TRACE_EVENT_GET_STATE = True
 
 
 def generate_h_begin(events, group):
@@ -29,11 +28,13 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('        if (qemu_loglevel_mask(LOG_TRACE)) {',
+    out('    if (trace_event_get_state(%(event_id)s) &&',
+        '        qemu_loglevel_mask(LOG_TRACE)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
         '            qemu_log("%(name)s " %(fmt)s "\\n"%(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '        }',
+        '    }',
+        event_id="TRACE_" + event.name.upper(),
         event_lineno=event.lineno,
         event_filename=event.filename,
         name=event.name,
@@ -41,10 +42,23 @@ def generate_h(event, group):
         argnames=argnames)
 
 
+def generate_h_backend_dstate(event, group):
+    out('    (trace_event_get_state_dynamic_by_id(%(event_id)s) && \\',
+        '     qemu_loglevel_mask(LOG_TRACE)) || \\',
+        event_id="TRACE_" + event.name.upper())
+
 def generate_rs(event, group):
-    out('        let format_string = c"%(fmt)s\\n";',
+    out('    if trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) {',
+        '        let format_string = c"%(fmt)s\\n";',
         '        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {',
         '            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, %(args)s);}',
         '        }',
+        '    }',
         fmt=expand_format_string(event.fmt, event.name + " "),
-        args=event.args.rust_call_varargs())
+        args=event.args.rust_call_varargs(),
+        event_id="TRACE_" + event.name.upper())
+
+def generate_rs_backend_dstate(event, group):
+    out('    ((unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 &&',
+        '     trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE})) ||',
+        event_id="TRACE_" + event.name.upper())
diff --git a/tests/tracetool/all.rs b/tests/tracetool/all.rs
index f48bdf4aab5..eb94d5c62a5 100644
--- a/tests/tracetool/all.rs
+++ b/tests/tracetool/all.rs
@@ -37,6 +37,8 @@ fn trace_event_state_is_enabled(dstate: u8) -> bool {
 pub fn trace_test_blah_enabled() -> bool
 {
     (unsafe {qemu_test_blah_semaphore.get().read_volatile()}) != 0 ||
+    ((unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 &&
+     trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE})) ||
     trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
     false
 }
@@ -47,12 +49,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 {
     ::trace::probe!(qemu, test_blah, _context, _filename.as_ptr());
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
-        let format_string = c"test_blah Blah context=%p filename=%s\n";
-        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
         let format_string = c"test_blah Blah context=%p filename=%s\n";
         if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
             unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
         }
+    }
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
+        let format_string = c"test_blah Blah context=%p filename=%s\n";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
         extern "C" { fn _simple_trace_test_blah(_context: *mut (), _filename: *const std::ffi::c_char); }
         unsafe { _simple_trace_test_blah(_context, _filename.as_ptr()); }
         let format_string = c"test_blah Blah context=%p filename=%s";
@@ -65,6 +69,8 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 pub fn trace_test_wibble_enabled() -> bool
 {
     (unsafe {qemu_test_wibble_semaphore.get().read_volatile()}) != 0 ||
+    ((unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 &&
+     trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE})) ||
     trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
     false
 }
@@ -75,12 +81,14 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
 {
     ::trace::probe!(qemu, test_wibble, _context, _value);
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
-        let format_string = c"test_wibble Wibble context=%p value=%d\n";
-        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
         let format_string = c"test_wibble Wibble context=%p value=%d\n";
         if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
             unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
         }
+    }
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"test_wibble Wibble context=%p value=%d\n";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
         extern "C" { fn _simple_trace_test_wibble(_context: *mut (), _value: std::ffi::c_int); }
         unsafe { _simple_trace_test_wibble(_context, _value); }
         let format_string = c"test_wibble Wibble context=%p value=%d";
diff --git a/tests/tracetool/log.rs b/tests/tracetool/log.rs
index 0f052bb2c9c..17597209b7c 100644
--- a/tests/tracetool/log.rs
+++ b/tests/tracetool/log.rs
@@ -27,7 +27,8 @@ fn trace_event_state_is_enabled(dstate: u8) -> bool {
 #[allow(dead_code)]
 pub fn trace_test_blah_enabled() -> bool
 {
-    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
+    ((unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 &&
+     trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE})) ||
     false
 }
 
@@ -47,7 +48,8 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 #[allow(dead_code)]
 pub fn trace_test_wibble_enabled() -> bool
 {
-    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
+    ((unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 &&
+     trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE})) ||
     false
 }
 
-- 
2.56.0


