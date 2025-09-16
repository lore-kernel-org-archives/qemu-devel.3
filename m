Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C858CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZq4-0007sn-U6; Tue, 16 Sep 2025 13:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyZpz-0007q2-MD
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyZpv-0008Gx-I3
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758045086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ToYy+I0drb37mOkAPubxZPgKoQ7fOReDgdX3MLgLgE=;
 b=Tx55bMo6H22eH4pvEOYaIrOAw33fS6mNUlsPa6mnksAWBi1jzwm/qlzClQ1f7P0pLyjWe0
 KPetE9Suw29F9L/kh3RgxLs78hKTYTzy/Qf7GBk796wfKxGATE0a8dRLYIOKTPAIwp9VbG
 SRC/0ONNnSnI0TuvkfrHWvLiGkKsuRE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-9ntMluI_NUmeTfJpJgMsyA-1; Tue,
 16 Sep 2025 13:51:22 -0400
X-MC-Unique: 9ntMluI_NUmeTfJpJgMsyA-1
X-Mimecast-MFC-AGG-ID: 9ntMluI_NUmeTfJpJgMsyA_1758045081
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5D0319560B5; Tue, 16 Sep 2025 17:51:21 +0000 (UTC)
Received: from localhost (unknown [10.2.17.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2494F18003FC; Tue, 16 Sep 2025 17:51:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 5/8] tracetool: add test suite for tracetool with reference
 output
Date: Tue, 16 Sep 2025 13:51:05 -0400
Message-ID: <20250916175108.139627-6-stefanha@redhat.com>
In-Reply-To: <20250916175108.139627-1-stefanha@redhat.com>
References: <20250916175108.139627-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When reviewing tracetool patches it is often very unclear what the
expected output will be for the generated backends. Compounding
this is that a default build will only enable the 'log' trace
backend, so developers won't see generated code for other backends
without making a special effort. Some backends are also platform
specific, so can't be enabled in QEMU builds, even though tracetool
could generate the code.

To address this, introduce a test suite for tracetool which is
conceptually similar to the qapi-schema test. It is a simple
python program that runs tracetool and compares the actual output
to historical reference output kept in git. The test directly
emits TAP format logs for ease of integration with meson.

This can be run with

  make check-tracetool

to make it easier for developers changing generated output, the
sample expected content can be auto-recreated

  QEMU_TEST_REGENERATE=1 make check-tracetool

and the changes reviewed and added to the commit. This will also
assist reviewers interpreting the change.

Developers are reminded of this in the test output on failure:

  $ make check-tracetool
  1/6 qemu:tracetool / dtrace        OK              0.14s
  2/6 qemu:tracetool / ftrace        FAIL            0.06s   exit status 1
  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
  1..2
  ok 1 - ftrace.c
  #
  not ok 1 - ftrace.h (set QEMU_TEST_REGENERATE=1 to recreate reference output if tracetool generator was intentionally changed)
  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――

  3/6 qemu:tracetool / log           OK              0.06s
  4/6 qemu:tracetool / simple        OK              0.06s
  5/6 qemu:tracetool / syslog        OK              0.06s
  6/6 qemu:tracetool / ust           OK              0.11s

  Summary of Failures:

  2/6 qemu:tracetool / ftrace FAIL            0.06s   exit status 1

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20250916081638.764020-6-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                             |   1 +
 docs/devel/testing/main.rst             |  28 +++++++
 tests/Makefile.include                  |   1 +
 tests/tracetool/dtrace.h                |  59 +++++++++++++
 tests/tracetool/ftrace.h                |  73 ++++++++++++++++
 tests/tracetool/log.h                   |  57 +++++++++++++
 tests/tracetool/simple.h                |  54 ++++++++++++
 tests/tracetool/syslog.h                |  57 +++++++++++++
 tests/tracetool/ust.h                   |  55 +++++++++++++
 tests/tracetool/dtrace.c                |  32 ++++++++
 tests/tracetool/ftrace.c                |  32 ++++++++
 tests/tracetool/log.c                   |  32 ++++++++
 tests/tracetool/simple.c                |  61 ++++++++++++++
 tests/tracetool/syslog.c                |  32 ++++++++
 tests/tracetool/ust.c                   |  32 ++++++++
 tests/meson.build                       |   1 +
 tests/tracetool/dtrace.d                |  10 +++
 tests/tracetool/dtrace.log-stap         |  15 ++++
 tests/tracetool/dtrace.simpletrace-stap |  16 ++++
 tests/tracetool/dtrace.stap             |  14 ++++
 tests/tracetool/meson.build             |  28 +++++++
 tests/tracetool/trace-events            |   5 ++
 tests/tracetool/tracetool-test.py       | 105 ++++++++++++++++++++++++
 tests/tracetool/ust.ust-events-c        |  14 ++++
 tests/tracetool/ust.ust-events-h        |  56 +++++++++++++
 25 files changed, 870 insertions(+)
 create mode 100644 tests/tracetool/dtrace.h
 create mode 100644 tests/tracetool/ftrace.h
 create mode 100644 tests/tracetool/log.h
 create mode 100644 tests/tracetool/simple.h
 create mode 100644 tests/tracetool/syslog.h
 create mode 100644 tests/tracetool/ust.h
 create mode 100644 tests/tracetool/dtrace.c
 create mode 100644 tests/tracetool/ftrace.c
 create mode 100644 tests/tracetool/log.c
 create mode 100644 tests/tracetool/simple.c
 create mode 100644 tests/tracetool/syslog.c
 create mode 100644 tests/tracetool/ust.c
 create mode 100644 tests/tracetool/dtrace.d
 create mode 100644 tests/tracetool/dtrace.log-stap
 create mode 100644 tests/tracetool/dtrace.simpletrace-stap
 create mode 100644 tests/tracetool/dtrace.stap
 create mode 100644 tests/tracetool/meson.build
 create mode 100644 tests/tracetool/trace-events
 create mode 100755 tests/tracetool/tracetool-test.py
 create mode 100644 tests/tracetool/ust.ust-events-c
 create mode 100644 tests/tracetool/ust.ust-events-h

diff --git a/MAINTAINERS b/MAINTAINERS
index fb045388b9..f8cd513d8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3562,6 +3562,7 @@ F: scripts/tracetool/
 F: scripts/qemu-trace-stap*
 F: docs/tools/qemu-trace-stap.rst
 F: docs/devel/tracing.rst
+F: tests/tracetool/
 T: git https://github.com/stefanha/qemu.git tracing
 
 Simpletrace
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 2b5cb0c148..11f05c0006 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -178,6 +178,34 @@ parser (either fixing a bug or extending/modifying the syntax). To do this:
 
   ``qapi-schema += foo.json``
 
+.. _tracetool-tests:
+
+Tracetool tests
+~~~~~~~~~~~~~~~
+
+The tracetool tests validate the generated source files used for defining
+probes for various tracing backends and source formats. The test operates
+by running the tracetool program against a sample trace-events file, and
+comparing the generated output against known good reference output. The
+tests can be run with:
+
+.. code::
+
+  make check-tracetool
+
+The reference output is stored in files under tests/tracetool, and when
+the tracetool backend/format output is intentionally changed, the reference
+files need to be updated. This can be automated by setting the
+QEMU_TEST_REGENERATE=1 environment variable:
+
+.. code::
+
+   QEMU_TEST_REGENERATE=1 make check-tracetool
+
+The resulting changes must be reviewed by the author to ensure they match
+the intended results, before adding the updated reference output to the
+same commit that alters the generator code.
+
 check-block
 ~~~~~~~~~~~
 
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 23fb722d42..3538c0c740 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -13,6 +13,7 @@ check-help:
 	@echo " $(MAKE) check-functional-TARGET  Run functional tests for a given target"
 	@echo " $(MAKE) check-unit               Run qobject tests"
 	@echo " $(MAKE) check-qapi-schema        Run QAPI schema tests"
+	@echo " $(MAKE) check-tracetool          Run tracetool generator tests"
 	@echo " $(MAKE) check-block              Run block tests"
 ifneq ($(filter $(all-check-targets), check-softfloat),)
 	@echo " $(MAKE) check-tcg                Run TCG tests"
diff --git a/tests/tracetool/dtrace.h b/tests/tracetool/dtrace.h
new file mode 100644
index 0000000000..c2e5110672
--- /dev/null
+++ b/tests/tracetool/dtrace.h
@@ -0,0 +1,59 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
+#define TRACE_TESTSUITE_GENERATED_TRACERS_H
+
+#include "trace/control.h"
+
+extern TraceEvent _TRACE_TEST_BLAH_EVENT;
+extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
+extern uint16_t _TRACE_TEST_BLAH_DSTATE;
+extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+#define TRACE_TEST_BLAH_ENABLED 1
+#define TRACE_TEST_WIBBLE_ENABLED 1
+#ifndef SDT_USE_VARIADIC
+#define SDT_USE_VARIADIC 1
+#endif
+#include "trace-dtrace-testsuite.h"
+
+#undef SDT_USE_VARIADIC
+#ifndef QEMU_TEST_BLAH_ENABLED
+#define QEMU_TEST_BLAH_ENABLED() true
+#endif
+#ifndef QEMU_TEST_WIBBLE_ENABLED
+#define QEMU_TEST_WIBBLE_ENABLED() true
+#endif
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    QEMU_TEST_BLAH_ENABLED() || \
+    false)
+
+static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+{
+    QEMU_TEST_BLAH(context, filename);
+}
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    if (true) {
+        _nocheck__trace_test_blah(context, filename);
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    QEMU_TEST_WIBBLE_ENABLED() || \
+    false)
+
+static inline void _nocheck__trace_test_wibble(void *context, int value)
+{
+    QEMU_TEST_WIBBLE(context, value);
+}
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    if (true) {
+        _nocheck__trace_test_wibble(context, value);
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
new file mode 100644
index 0000000000..f1ff3b0a62
--- /dev/null
+++ b/tests/tracetool/ftrace.h
@@ -0,0 +1,73 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
+#define TRACE_TESTSUITE_GENERATED_TRACERS_H
+
+#include "trace/control.h"
+
+extern TraceEvent _TRACE_TEST_BLAH_EVENT;
+extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
+extern uint16_t _TRACE_TEST_BLAH_DSTATE;
+extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+#define TRACE_TEST_BLAH_ENABLED 1
+#define TRACE_TEST_WIBBLE_ENABLED 1
+#include "trace/ftrace.h"
+
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    false)
+
+static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+{
+    {
+        char ftrace_buf[MAX_TRACE_STRLEN];
+        int unused __attribute__ ((unused));
+        int trlen;
+        if (trace_event_get_state(TRACE_TEST_BLAH)) {
+#line 4 "trace-events"
+            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
+                             "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
+#line 33 "ftrace.h"
+            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
+            unused = write(trace_marker_fd, ftrace_buf, trlen);
+        }
+    }
+}
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    if (true) {
+        _nocheck__trace_test_blah(context, filename);
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    false)
+
+static inline void _nocheck__trace_test_wibble(void *context, int value)
+{
+    {
+        char ftrace_buf[MAX_TRACE_STRLEN];
+        int unused __attribute__ ((unused));
+        int trlen;
+        if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+#line 5 "trace-events"
+            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
+                             "test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
+#line 61 "ftrace.h"
+            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
+            unused = write(trace_marker_fd, ftrace_buf, trlen);
+        }
+    }
+}
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    if (true) {
+        _nocheck__trace_test_wibble(context, value);
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/log.h b/tests/tracetool/log.h
new file mode 100644
index 0000000000..4293f1010e
--- /dev/null
+++ b/tests/tracetool/log.h
@@ -0,0 +1,57 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
+#define TRACE_TESTSUITE_GENERATED_TRACERS_H
+
+#include "trace/control.h"
+
+extern TraceEvent _TRACE_TEST_BLAH_EVENT;
+extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
+extern uint16_t _TRACE_TEST_BLAH_DSTATE;
+extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+#define TRACE_TEST_BLAH_ENABLED 1
+#define TRACE_TEST_WIBBLE_ENABLED 1
+#include "qemu/log-for-trace.h"
+
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    false)
+
+static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+{
+    if (trace_event_get_state(TRACE_TEST_BLAH) && qemu_loglevel_mask(LOG_TRACE)) {
+#line 4 "trace-events"
+        qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
+#line 28 "log.h"
+    }
+}
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    if (true) {
+        _nocheck__trace_test_blah(context, filename);
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    false)
+
+static inline void _nocheck__trace_test_wibble(void *context, int value)
+{
+    if (trace_event_get_state(TRACE_TEST_WIBBLE) && qemu_loglevel_mask(LOG_TRACE)) {
+#line 5 "trace-events"
+        qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
+#line 48 "log.h"
+    }
+}
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    if (true) {
+        _nocheck__trace_test_wibble(context, value);
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/simple.h b/tests/tracetool/simple.h
new file mode 100644
index 0000000000..3c9de68c43
--- /dev/null
+++ b/tests/tracetool/simple.h
@@ -0,0 +1,54 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
+#define TRACE_TESTSUITE_GENERATED_TRACERS_H
+
+#include "trace/control.h"
+
+extern TraceEvent _TRACE_TEST_BLAH_EVENT;
+extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
+extern uint16_t _TRACE_TEST_BLAH_DSTATE;
+extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+#define TRACE_TEST_BLAH_ENABLED 1
+#define TRACE_TEST_WIBBLE_ENABLED 1
+void _simple_trace_test_blah(void *context, const char *filename);
+void _simple_trace_test_wibble(void *context, int value);
+
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    false)
+
+static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+{
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+        _simple_trace_test_blah(context, filename);
+    }
+}
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    if (true) {
+        _nocheck__trace_test_blah(context, filename);
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    false)
+
+static inline void _nocheck__trace_test_wibble(void *context, int value)
+{
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+        _simple_trace_test_wibble(context, value);
+    }
+}
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    if (true) {
+        _nocheck__trace_test_wibble(context, value);
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/syslog.h b/tests/tracetool/syslog.h
new file mode 100644
index 0000000000..498bbfb99e
--- /dev/null
+++ b/tests/tracetool/syslog.h
@@ -0,0 +1,57 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
+#define TRACE_TESTSUITE_GENERATED_TRACERS_H
+
+#include "trace/control.h"
+
+extern TraceEvent _TRACE_TEST_BLAH_EVENT;
+extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
+extern uint16_t _TRACE_TEST_BLAH_DSTATE;
+extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+#define TRACE_TEST_BLAH_ENABLED 1
+#define TRACE_TEST_WIBBLE_ENABLED 1
+#include <syslog.h>
+
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    false)
+
+static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+{
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+#line 4 "trace-events"
+        syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
+#line 28 "syslog.h"
+    }
+}
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    if (true) {
+        _nocheck__trace_test_blah(context, filename);
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    false)
+
+static inline void _nocheck__trace_test_wibble(void *context, int value)
+{
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+#line 5 "trace-events"
+        syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
+#line 48 "syslog.h"
+    }
+}
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    if (true) {
+        _nocheck__trace_test_wibble(context, value);
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/ust.h b/tests/tracetool/ust.h
new file mode 100644
index 0000000000..1184ddd870
--- /dev/null
+++ b/tests/tracetool/ust.h
@@ -0,0 +1,55 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TRACE_TESTSUITE_GENERATED_TRACERS_H
+#define TRACE_TESTSUITE_GENERATED_TRACERS_H
+
+#include "trace/control.h"
+
+extern TraceEvent _TRACE_TEST_BLAH_EVENT;
+extern TraceEvent _TRACE_TEST_WIBBLE_EVENT;
+extern uint16_t _TRACE_TEST_BLAH_DSTATE;
+extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+#define TRACE_TEST_BLAH_ENABLED 1
+#define TRACE_TEST_WIBBLE_ENABLED 1
+#include <lttng/tracepoint.h>
+#include "trace-ust-testsuite.h"
+
+/* tracepoint_enabled() was introduced in LTTng UST 2.7 */
+#ifndef tracepoint_enabled
+#define tracepoint_enabled(a, b) true
+#endif
+
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    tracepoint_enabled(qemu, test_blah) || \
+    false)
+
+static inline void _nocheck__trace_test_blah(void *context, const char *filename)
+{
+    tracepoint(qemu, test_blah, context, filename);
+}
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    if (true) {
+        _nocheck__trace_test_blah(context, filename);
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    tracepoint_enabled(qemu, test_wibble) || \
+    false)
+
+static inline void _nocheck__trace_test_wibble(void *context, int value)
+{
+    tracepoint(qemu, test_wibble, context, value);
+}
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    if (true) {
+        _nocheck__trace_test_wibble(context, value);
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/dtrace.c b/tests/tracetool/dtrace.c
new file mode 100644
index 0000000000..9f862fa14d
--- /dev/null
+++ b/tests/tracetool/dtrace.c
@@ -0,0 +1,32 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint16_t _TRACE_TEST_BLAH_DSTATE;
+uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+    .id = 0,
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+    .id = 0,
+    .name = "test_wibble",
+    .sstate = TRACE_TEST_WIBBLE_ENABLED,
+    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
+};
+TraceEvent *testsuite_trace_events[] = {
+    &_TRACE_TEST_BLAH_EVENT,
+    &_TRACE_TEST_WIBBLE_EVENT,
+  NULL,
+};
+
+static void trace_testsuite_register_events(void)
+{
+    trace_event_register_group(testsuite_trace_events);
+}
+trace_init(trace_testsuite_register_events)
diff --git a/tests/tracetool/ftrace.c b/tests/tracetool/ftrace.c
new file mode 100644
index 0000000000..9f862fa14d
--- /dev/null
+++ b/tests/tracetool/ftrace.c
@@ -0,0 +1,32 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint16_t _TRACE_TEST_BLAH_DSTATE;
+uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+    .id = 0,
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+    .id = 0,
+    .name = "test_wibble",
+    .sstate = TRACE_TEST_WIBBLE_ENABLED,
+    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
+};
+TraceEvent *testsuite_trace_events[] = {
+    &_TRACE_TEST_BLAH_EVENT,
+    &_TRACE_TEST_WIBBLE_EVENT,
+  NULL,
+};
+
+static void trace_testsuite_register_events(void)
+{
+    trace_event_register_group(testsuite_trace_events);
+}
+trace_init(trace_testsuite_register_events)
diff --git a/tests/tracetool/log.c b/tests/tracetool/log.c
new file mode 100644
index 0000000000..9f862fa14d
--- /dev/null
+++ b/tests/tracetool/log.c
@@ -0,0 +1,32 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint16_t _TRACE_TEST_BLAH_DSTATE;
+uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+    .id = 0,
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+    .id = 0,
+    .name = "test_wibble",
+    .sstate = TRACE_TEST_WIBBLE_ENABLED,
+    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
+};
+TraceEvent *testsuite_trace_events[] = {
+    &_TRACE_TEST_BLAH_EVENT,
+    &_TRACE_TEST_WIBBLE_EVENT,
+  NULL,
+};
+
+static void trace_testsuite_register_events(void)
+{
+    trace_event_register_group(testsuite_trace_events);
+}
+trace_init(trace_testsuite_register_events)
diff --git a/tests/tracetool/simple.c b/tests/tracetool/simple.c
new file mode 100644
index 0000000000..0484177481
--- /dev/null
+++ b/tests/tracetool/simple.c
@@ -0,0 +1,61 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint16_t _TRACE_TEST_BLAH_DSTATE;
+uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+    .id = 0,
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+    .id = 0,
+    .name = "test_wibble",
+    .sstate = TRACE_TEST_WIBBLE_ENABLED,
+    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
+};
+TraceEvent *testsuite_trace_events[] = {
+    &_TRACE_TEST_BLAH_EVENT,
+    &_TRACE_TEST_WIBBLE_EVENT,
+  NULL,
+};
+
+static void trace_testsuite_register_events(void)
+{
+    trace_event_register_group(testsuite_trace_events);
+}
+trace_init(trace_testsuite_register_events)
+#include "qemu/osdep.h"
+#include "trace/control.h"
+#include "trace/simple.h"
+
+void _simple_trace_test_blah(void *context, const char *filename)
+{
+    TraceBufferRecord rec;
+    size_t argfilename_len = filename ? MIN(strlen(filename), MAX_TRACE_STRLEN) : 0;
+
+    if (trace_record_start(&rec, _TRACE_TEST_BLAH_EVENT.id, 8 + 4 + argfilename_len)) {
+        return; /* Trace Buffer Full, Event Dropped ! */
+    }
+    trace_record_write_u64(&rec, (uintptr_t)(uint64_t *)context);
+    trace_record_write_str(&rec, filename, argfilename_len);
+    trace_record_finish(&rec);
+}
+
+void _simple_trace_test_wibble(void *context, int value)
+{
+    TraceBufferRecord rec;
+
+    if (trace_record_start(&rec, _TRACE_TEST_WIBBLE_EVENT.id, 8 + 8)) {
+        return; /* Trace Buffer Full, Event Dropped ! */
+    }
+    trace_record_write_u64(&rec, (uintptr_t)(uint64_t *)context);
+    trace_record_write_u64(&rec, (uint64_t)value);
+    trace_record_finish(&rec);
+}
+
diff --git a/tests/tracetool/syslog.c b/tests/tracetool/syslog.c
new file mode 100644
index 0000000000..9f862fa14d
--- /dev/null
+++ b/tests/tracetool/syslog.c
@@ -0,0 +1,32 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint16_t _TRACE_TEST_BLAH_DSTATE;
+uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+    .id = 0,
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+    .id = 0,
+    .name = "test_wibble",
+    .sstate = TRACE_TEST_WIBBLE_ENABLED,
+    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
+};
+TraceEvent *testsuite_trace_events[] = {
+    &_TRACE_TEST_BLAH_EVENT,
+    &_TRACE_TEST_WIBBLE_EVENT,
+  NULL,
+};
+
+static void trace_testsuite_register_events(void)
+{
+    trace_event_register_group(testsuite_trace_events);
+}
+trace_init(trace_testsuite_register_events)
diff --git a/tests/tracetool/ust.c b/tests/tracetool/ust.c
new file mode 100644
index 0000000000..9f862fa14d
--- /dev/null
+++ b/tests/tracetool/ust.c
@@ -0,0 +1,32 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint16_t _TRACE_TEST_BLAH_DSTATE;
+uint16_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+    .id = 0,
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+    .id = 0,
+    .name = "test_wibble",
+    .sstate = TRACE_TEST_WIBBLE_ENABLED,
+    .dstate = &_TRACE_TEST_WIBBLE_DSTATE
+};
+TraceEvent *testsuite_trace_events[] = {
+    &_TRACE_TEST_BLAH_EVENT,
+    &_TRACE_TEST_WIBBLE_EVENT,
+  NULL,
+};
+
+static void trace_testsuite_register_events(void)
+{
+    trace_event_register_group(testsuite_trace_events);
+}
+trace_init(trace_testsuite_register_events)
diff --git a/tests/meson.build b/tests/meson.build
index c59619220f..cbe7916241 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -88,3 +88,4 @@ subdir('qapi-schema')
 subdir('qtest')
 subdir('migration-stress')
 subdir('functional')
+subdir('tracetool')
diff --git a/tests/tracetool/dtrace.d b/tests/tracetool/dtrace.d
new file mode 100644
index 0000000000..5cc06f9f4f
--- /dev/null
+++ b/tests/tracetool/dtrace.d
@@ -0,0 +1,10 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+provider qemu {
+
+probe test_blah(void * context,const char * filename);
+
+probe test_wibble(void * context,int value);
+
+};
diff --git a/tests/tracetool/dtrace.log-stap b/tests/tracetool/dtrace.log-stap
new file mode 100644
index 0000000000..092986e0b6
--- /dev/null
+++ b/tests/tracetool/dtrace.log-stap
@@ -0,0 +1,15 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+probe qemu.log.test_blah = qemu.test_blah ?
+{
+    try {
+        argfilename_str = filename ? user_string_n(filename, 512) : "<null>"
+    } catch {}
+    printf("%d@%d test_blah Blah context=%p filename=%s\n", pid(), gettimeofday_ns(), context, argfilename_str)
+}
+probe qemu.log.test_wibble = qemu.test_wibble ?
+{
+    printf("%d@%d test_wibble Wibble context=%p value=%d\n", pid(), gettimeofday_ns(), context, value)
+}
+
diff --git a/tests/tracetool/dtrace.simpletrace-stap b/tests/tracetool/dtrace.simpletrace-stap
new file mode 100644
index 0000000000..d064e3e286
--- /dev/null
+++ b/tests/tracetool/dtrace.simpletrace-stap
@@ -0,0 +1,16 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+probe qemu.simpletrace.test_blah = qemu.test_blah ?
+{
+    try {
+        argfilename_str = filename ? user_string_n(filename, 512) : "<null>"
+    } catch {}
+    argfilename_len = strlen(argfilename_str)
+    printf("%8b%8b%8b%4b%4b%8b%4b%.*s", 1, 0, gettimeofday_ns(), 24 + 8 + 4 + argfilename_len, pid(), context, argfilename_len, argfilename_len, argfilename_str)
+}
+probe qemu.simpletrace.test_wibble = qemu.test_wibble ?
+{
+    printf("%8b%8b%8b%4b%4b%8b%8b", 1, 1, gettimeofday_ns(), 24 + 8 + 8, pid(), context, value)
+}
+
diff --git a/tests/tracetool/dtrace.stap b/tests/tracetool/dtrace.stap
new file mode 100644
index 0000000000..9c5d8a527c
--- /dev/null
+++ b/tests/tracetool/dtrace.stap
@@ -0,0 +1,14 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+probe qemu.test_blah = process("qemu").mark("test_blah")
+{
+  context = $arg1;
+  filename = $arg2;
+}
+probe qemu.test_wibble = process("qemu").mark("test_wibble")
+{
+  context = $arg1;
+  value = $arg2;
+}
+
diff --git a/tests/tracetool/meson.build b/tests/tracetool/meson.build
new file mode 100644
index 0000000000..09bbaaa86b
--- /dev/null
+++ b/tests/tracetool/meson.build
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_env = environment()
+test_env.set('PYTHONPATH', meson.project_source_root() / 'scripts')
+test_env.set('PYTHONIOENCODING', 'utf-8')
+
+backends = [
+    'dtrace',
+    'ftrace',
+    'log',
+    'simple',
+    'syslog',
+    'ust'
+]
+
+# The tracetool-test.py program has portability problems on Windows.
+if host_machine.system() != 'windows'
+    foreach backend: backends
+        test(backend,
+             python,
+             args: [meson.current_source_dir() / 'tracetool-test.py',
+                    meson.project_source_root() / 'scripts' / 'tracetool.py',
+                    backend,
+                    meson.current_source_dir(),
+                    meson.current_build_dir()],
+             suite: ['tracetool'])
+    endforeach
+endif
diff --git a/tests/tracetool/trace-events b/tests/tracetool/trace-events
new file mode 100644
index 0000000000..72cf4d6f70
--- /dev/null
+++ b/tests/tracetool/trace-events
@@ -0,0 +1,5 @@
+# See docs/devel/tracing.rst for syntax documentation.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_blah(void *context, const char *filename) "Blah context=%p filename=%s"
+test_wibble(void *context, int value) "Wibble context=%p value=%d"
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
new file mode 100755
index 0000000000..a420597fc4
--- /dev/null
+++ b/tests/tracetool/tracetool-test.py
@@ -0,0 +1,105 @@
+#!/usr/bin/python3
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from pathlib import Path
+from shutil import copyfile
+from subprocess import check_call
+import sys
+
+
+def get_formats(backend):
+    formats = [
+        "c",
+        "h",
+    ]
+    if backend == "dtrace":
+        formats += [
+            "d",
+            "log-stap",
+            "simpletrace-stap",
+            "stap",
+        ]
+    if backend == "ust":
+        formats += [
+            "ust-events-c",
+            "ust-events-h",
+        ]
+    return formats
+
+
+def test_tracetool_one(tracetool, backend, fmt, src_dir, build_dir):
+    rel_filename = backend + "." + fmt
+    actual_file = Path(build_dir, rel_filename)
+    expect_file = Path(src_dir, rel_filename)
+
+    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
+
+    if fmt.find("stap") != -1:
+        args += ["--binary=qemu", "--probe-prefix=qemu"]
+
+    # Use relative files for both, as these filenames end
+    # up in '#line' statements in the output
+    args += ["trace-events", rel_filename]
+
+    try:
+        check_call(args, cwd=build_dir)
+        actual = actual_file.read_text()
+    finally:
+        actual_file.unlink()
+
+    if os.getenv("QEMU_TEST_REGENERATE", False):
+        print(f"# regenerate {expect_file}")
+        expect_file.write_text(actual)
+
+    expect = expect_file.read_text()
+
+    assert expect == actual
+
+
+def test_tracetool(tracetool, backend, source_dir, build_dir):
+    fail = False
+    scenarios = len(get_formats(backend))
+
+    print(f"1..{scenarios}")
+
+    src_events = Path(source_dir, "trace-events")
+    build_events = Path(build_dir, "trace-events")
+
+    try:
+        # We need a stable relative filename under build dir
+        # for the '#line' statements, so copy over the input
+        copyfile(src_events, build_events)
+
+        num = 1
+        for fmt in get_formats(backend):
+            status = "not ok"
+            hint = ""
+            try:
+                test_tracetool_one(tracetool, backend, fmt, source_dir, build_dir)
+                status = "ok"
+            except Exception as e:
+                print(f"# {e}")
+                fail = True
+                hint = (
+                    " (set QEMU_TEST_REGENERATE=1 to recreate reference "
+                    + "output if tracetool generator was intentionally changed)"
+                )
+            finally:
+                print(f"{status} {num} - {backend}.{fmt}{hint}")
+    finally:
+        build_events.unlink()
+
+    return fail
+
+
+if __name__ == "__main__":
+    if len(sys.argv) != 5:
+        argv0 = sys.argv[0]
+        print("syntax: {argv0} TRACE-TOOL BACKEND SRC-DIR BUILD-DIR", file=sys.stderr)
+        sys.exit(1)
+
+    fail = test_tracetool(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
+    if fail:
+        sys.exit(1)
+    sys.exit(0)
diff --git a/tests/tracetool/ust.ust-events-c b/tests/tracetool/ust.ust-events-c
new file mode 100644
index 0000000000..db23224056
--- /dev/null
+++ b/tests/tracetool/ust.ust-events-c
@@ -0,0 +1,14 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#define TRACEPOINT_DEFINE
+#define TRACEPOINT_CREATE_PROBES
+
+/* If gcc version 4.7 or older is used, LTTng ust gives a warning when compiling with
+   -Wredundant-decls.
+ */
+#pragma GCC diagnostic ignored "-Wredundant-decls"
+
+#include "trace-ust-all.h"
diff --git a/tests/tracetool/ust.ust-events-h b/tests/tracetool/ust.ust-events-h
new file mode 100644
index 0000000000..4621a995fc
--- /dev/null
+++ b/tests/tracetool/ust.ust-events-h
@@ -0,0 +1,56 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER qemu
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "./trace-ust.h"
+
+#if !defined (TRACE_TESTSUITE_GENERATED_UST_H) || \
+     defined(TRACEPOINT_HEADER_MULTI_READ)
+#define TRACE_TESTSUITE_GENERATED_UST_H
+
+#include <lttng/tracepoint.h>
+
+/*
+ * LTTng ust 2.0 does not allow you to use TP_ARGS(void) for tracepoints
+ * requiring no arguments. We define these macros introduced in more recent * versions of LTTng ust as a workaround
+ */
+#ifndef _TP_EXPROTO1
+#define _TP_EXPROTO1(a)               void
+#endif
+#ifndef _TP_EXDATA_PROTO1
+#define _TP_EXDATA_PROTO1(a)          void *__tp_data
+#endif
+#ifndef _TP_EXDATA_VAR1
+#define _TP_EXDATA_VAR1(a)            __tp_data
+#endif
+#ifndef _TP_EXVAR1
+#define _TP_EXVAR1(a)
+#endif
+
+TRACEPOINT_EVENT(
+   qemu,
+   test_blah,
+   TP_ARGS(void *, context, const char *, filename),
+   TP_FIELDS(
+       ctf_integer_hex(void *, context, context)
+       ctf_string(filename, filename)
+   )
+)
+
+TRACEPOINT_EVENT(
+   qemu,
+   test_wibble,
+   TP_ARGS(void *, context, int, value),
+   TP_FIELDS(
+       ctf_integer_hex(void *, context, context)
+       ctf_integer(int, value, value)
+   )
+)
+
+#endif /* TRACE_TESTSUITE_GENERATED_UST_H */
+
+/* This part must be outside ifdef protection */
+#include <lttng/tracepoint-event.h>
-- 
2.51.0


