Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4561ECAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcWs-0001e0-VF; Mon, 08 Sep 2025 10:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWr-0001dD-8N
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uvcWY-0007A7-KN
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2W8YgrmAPyn8CoekyTrTRLxs16xNV/W78ERDsq7EZs0=;
 b=Fq5bdS+7/RRNEzligeXQOaakSG5jHyFWNoS8QO9wsSVRACyO8B7Qb1flyyOhXyeXBpdt8O
 fB1pJ7k+4OQe7UYY4SF4zz9Zrvs5EVQBRBVUMTkAko21tbjnfB9P/vky9RQfpHkIy+sp/A
 QKCFW0mGGWgzhk7F2k7zqOJ7VfwbtZg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443--aNKnQBLN9GuGmE8lGYSJQ-1; Mon,
 08 Sep 2025 10:07:08 -0400
X-MC-Unique: -aNKnQBLN9GuGmE8lGYSJQ-1
X-Mimecast-MFC-AGG-ID: -aNKnQBLN9GuGmE8lGYSJQ_1757340427
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6EC219560AD; Mon,  8 Sep 2025 14:07:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.148])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3DD4A300018D; Mon,  8 Sep 2025 14:07:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/8] tracetool: drop the probe "__nocheck__" wrapping
Date: Mon,  8 Sep 2025 10:06:50 -0400
Message-ID: <20250908140653.170707-7-stefanha@redhat.com>
In-Reply-To: <20250908140653.170707-1-stefanha@redhat.com>
References: <20250908140653.170707-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Every generated inline probe function is wrapped with a
trivial caller that has a hard-coded condition test:

  static inline void _nocheck__trace_test_wibble(void * context, int value)
  {
      tracepoint(qemu, test_wibble, context, value);
  }

  static inline void trace_test_wibble(void * context, int value)
  {
    if (true) {
        _nocheck__trace_test_wibble(context, value);
    }
  }

This was introduced for TCG probes back in

  864a2178: trace: [tcg] Do not generate TCG code to trace dynamically-disabled events

but is obsolete since

  126d4123 tracing: excise the tcg related from tracetool

This commit removes the wrapping such that we have

  static inline void trace_test_wibble(void * context, int value)
  {
      tracepoint(qemu, test_wibble, context, value);
  }

The default build of qemu-system-x86_64 on Fedora with the
'log' backend, has its size reduced by 1 MB

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20250819161053.464641-7-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/dtrace.h      | 18 ++----------------
 tests/tracetool/ftrace.h      | 20 +++-----------------
 tests/tracetool/log.h         | 20 +++-----------------
 tests/tracetool/simple.h      | 18 ++----------------
 tests/tracetool/syslog.h      | 20 +++-----------------
 tests/tracetool/ust.h         | 18 ++----------------
 scripts/tracetool/__init__.py |  1 -
 scripts/tracetool/format/h.py | 16 +---------------
 8 files changed, 16 insertions(+), 115 deletions(-)

diff --git a/tests/tracetool/dtrace.h b/tests/tracetool/dtrace.h
index c2e5110672..c8931a8d7b 100644
--- a/tests/tracetool/dtrace.h
+++ b/tests/tracetool/dtrace.h
@@ -29,31 +29,17 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
     QEMU_TEST_BLAH_ENABLED() || \
     false)
 
-static inline void _nocheck__trace_test_blah(void *context, const char *filename)
-{
-    QEMU_TEST_BLAH(context, filename);
-}
-
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (true) {
-        _nocheck__trace_test_blah(context, filename);
-    }
+    QEMU_TEST_BLAH(context, filename);
 }
 
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     QEMU_TEST_WIBBLE_ENABLED() || \
     false)
 
-static inline void _nocheck__trace_test_wibble(void *context, int value)
+static inline void trace_test_wibble(void *context, int value)
 {
     QEMU_TEST_WIBBLE(context, value);
 }
-
-static inline void trace_test_wibble(void *context, int value)
-{
-    if (true) {
-        _nocheck__trace_test_wibble(context, value);
-    }
-}
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index f1ff3b0a62..fe22ea0f09 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -19,7 +19,7 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     false)
 
-static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+static inline void trace_test_blah(void *context, const char *filename)
 {
     {
         char ftrace_buf[MAX_TRACE_STRLEN];
@@ -36,18 +36,11 @@ static inline void _nocheck__trace_test_blah(void *context, const char *filename
     }
 }
 
-static inline void trace_test_blah(void *context, const char *filename)
-{
-    if (true) {
-        _nocheck__trace_test_blah(context, filename);
-    }
-}
-
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     false)
 
-static inline void _nocheck__trace_test_wibble(void *context, int value)
+static inline void trace_test_wibble(void *context, int value)
 {
     {
         char ftrace_buf[MAX_TRACE_STRLEN];
@@ -57,17 +50,10 @@ static inline void _nocheck__trace_test_wibble(void *context, int value)
 #line 5 "trace-events"
             trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
                              "test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
-#line 61 "ftrace.h"
+#line 54 "ftrace.h"
             trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
             unused = write(trace_marker_fd, ftrace_buf, trlen);
         }
     }
 }
-
-static inline void trace_test_wibble(void *context, int value)
-{
-    if (true) {
-        _nocheck__trace_test_wibble(context, value);
-    }
-}
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
index 4293f1010e..edcc7f9d47 100644
--- a/tests/tracetool/log.h
+++ b/tests/tracetool/log.h
@@ -19,7 +19,7 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     false)
 
-static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+static inline void trace_test_blah(void *context, const char *filename)
 {
     if (trace_event_get_state(TRACE_TEST_BLAH) && qemu_loglevel_mask(LOG_TRACE)) {
 #line 4 "trace-events"
@@ -28,30 +28,16 @@ static inline void _nocheck__trace_test_blah(void *context, const char *filename
     }
 }
 
-static inline void trace_test_blah(void *context, const char *filename)
-{
-    if (true) {
-        _nocheck__trace_test_blah(context, filename);
-    }
-}
-
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     false)
 
-static inline void _nocheck__trace_test_wibble(void *context, int value)
+static inline void trace_test_wibble(void *context, int value)
 {
     if (trace_event_get_state(TRACE_TEST_WIBBLE) && qemu_loglevel_mask(LOG_TRACE)) {
 #line 5 "trace-events"
         qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
-#line 48 "log.h"
-    }
-}
-
-static inline void trace_test_wibble(void *context, int value)
-{
-    if (true) {
-        _nocheck__trace_test_wibble(context, value);
+#line 41 "log.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/simple.h b/tests/tracetool/simple.h
index 3c9de68c43..ec6fcb22c3 100644
--- a/tests/tracetool/simple.h
+++ b/tests/tracetool/simple.h
@@ -20,35 +20,21 @@ void _simple_trace_test_wibble(void *context, int value);
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     false)
 
-static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+static inline void trace_test_blah(void *context, const char *filename)
 {
     if (trace_event_get_state(TRACE_TEST_BLAH)) {
         _simple_trace_test_blah(context, filename);
     }
 }
 
-static inline void trace_test_blah(void *context, const char *filename)
-{
-    if (true) {
-        _nocheck__trace_test_blah(context, filename);
-    }
-}
-
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     false)
 
-static inline void _nocheck__trace_test_wibble(void *context, int value)
+static inline void trace_test_wibble(void *context, int value)
 {
     if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
         _simple_trace_test_wibble(context, value);
     }
 }
-
-static inline void trace_test_wibble(void *context, int value)
-{
-    if (true) {
-        _nocheck__trace_test_wibble(context, value);
-    }
-}
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/syslog.h b/tests/tracetool/syslog.h
index 498bbfb99e..ed4305554c 100644
--- a/tests/tracetool/syslog.h
+++ b/tests/tracetool/syslog.h
@@ -19,7 +19,7 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
     trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
     false)
 
-static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+static inline void trace_test_blah(void *context, const char *filename)
 {
     if (trace_event_get_state(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
@@ -28,30 +28,16 @@ static inline void _nocheck__trace_test_blah(void *context, const char *filename
     }
 }
 
-static inline void trace_test_blah(void *context, const char *filename)
-{
-    if (true) {
-        _nocheck__trace_test_blah(context, filename);
-    }
-}
-
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
     false)
 
-static inline void _nocheck__trace_test_wibble(void *context, int value)
+static inline void trace_test_wibble(void *context, int value)
 {
     if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
         syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
-#line 48 "syslog.h"
-    }
-}
-
-static inline void trace_test_wibble(void *context, int value)
-{
-    if (true) {
-        _nocheck__trace_test_wibble(context, value);
+#line 41 "syslog.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/ust.h b/tests/tracetool/ust.h
index 1184ddd870..b7acd0c39b 100644
--- a/tests/tracetool/ust.h
+++ b/tests/tracetool/ust.h
@@ -25,31 +25,17 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
     tracepoint_enabled(qemu, test_blah) || \
     false)
 
-static inline void _nocheck__trace_test_blah(void *context, const char *filename)
-{
-    tracepoint(qemu, test_blah, context, filename);
-}
-
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    if (true) {
-        _nocheck__trace_test_blah(context, filename);
-    }
+    tracepoint(qemu, test_blah, context, filename);
 }
 
 #define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
     tracepoint_enabled(qemu, test_wibble) || \
     false)
 
-static inline void _nocheck__trace_test_wibble(void *context, int value)
+static inline void trace_test_wibble(void *context, int value)
 {
     tracepoint(qemu, test_wibble, context, value);
 }
-
-static inline void trace_test_wibble(void *context, int value)
-{
-    if (true) {
-        _nocheck__trace_test_wibble(context, value);
-    }
-}
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 0f33758870..1d5238a084 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -338,7 +338,6 @@ def formats(self):
         return self._FMT.findall(self.fmt)
 
     QEMU_TRACE               = "trace_%(name)s"
-    QEMU_TRACE_NOCHECK       = "_nocheck__" + QEMU_TRACE
     QEMU_TRACE_TCG           = QEMU_TRACE + "_tcg"
     QEMU_DSTATE              = "_TRACE_%(NAME)s_DSTATE"
     QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index a00ae475f7..b42a8268a8 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -64,7 +64,7 @@ def generate(events, backend, group):
         out('',
             'static inline void %(api)s(%(args)s)',
             '{',
-            api=e.api(e.QEMU_TRACE_NOCHECK),
+            api=e.api(),
             args=e.args)
 
         if "disable" not in e.properties:
@@ -72,20 +72,6 @@ def generate(events, backend, group):
 
         out('}')
 
-        cond = "true"
-
-        out('',
-            'static inline void %(api)s(%(args)s)',
-            '{',
-            '    if (%(cond)s) {',
-            '        %(api_nocheck)s(%(names)s);',
-            '    }',
-            '}',
-            api=e.api(),
-            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
-            args=e.args,
-            names=", ".join(e.args.names()),
-            cond=cond)
 
     backend.generate_end(events, group)
 
-- 
2.51.0


