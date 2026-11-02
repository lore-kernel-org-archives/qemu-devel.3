Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C5606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GoIU6v+L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNxIc-0002h0-EW; Mon, 02 Nov 2026 14:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHn-0001wT-3l
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHj-0008Dx-2k
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793646093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ozn+n7oejeYEU5bC9zbT0ZwSD6t+CLu8qMU+CoA5yo=;
 b=GoIU6v+Lp1pQmVHPMthg0EodsHnPN3Z86bV+dHJsnIN/PxQOda1qXH34Q8l5vFOe0SXzIT
 f47Ml3cuNcPImwMl3q3F0QW1li9/o05JBYbWiX29vaZdsfYiyhIpXXnrNj1A/30Cc6y010
 SrBjdnRcBAIQaSmnJcrS7AbtfZ6hjfc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-ZbEk_HoDOFGdSetIT6hdXg-1; Mon,
 02 Nov 2026 14:01:29 -0500
X-MC-Unique: ZbEk_HoDOFGdSetIT6hdXg-1
X-Mimecast-MFC-AGG-ID: ZbEk_HoDOFGdSetIT6hdXg_1793646087
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B4891802677; Mon,  2 Nov 2026 19:01:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3580D30001A2; Mon,  2 Nov 2026 19:01:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/25] trace: add test of generation with all backends enabled
Date: Mon,  2 Nov 2026 13:58:18 -0500
Message-ID: <20261102185831.1880189-13-stefanha@redhat.com>
In-Reply-To: <20261102185831.1880189-1-stefanha@redhat.com>
References: <20261102185831.1880189-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reveals potentially interesting patterns in the generated
code when multiple backends are present.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-13-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/all.h                | 102 +++++++++++++++++++++++++++
 tests/tracetool/all.c                |  65 +++++++++++++++++
 tests/tracetool/all.d                |  10 +++
 tests/tracetool/all.log-stap         |  15 ++++
 tests/tracetool/all.rs               |  90 +++++++++++++++++++++++
 tests/tracetool/all.simpletrace-stap |  16 +++++
 tests/tracetool/all.stap             |  14 ++++
 tests/tracetool/all.ust-events-c     |  14 ++++
 tests/tracetool/all.ust-events-h     |  56 +++++++++++++++
 tests/tracetool/meson.build          |   3 +-
 tests/tracetool/tracetool-test.py    |  12 ++--
 11 files changed, 392 insertions(+), 5 deletions(-)
 create mode 100644 tests/tracetool/all.h
 create mode 100644 tests/tracetool/all.c
 create mode 100644 tests/tracetool/all.d
 create mode 100644 tests/tracetool/all.log-stap
 create mode 100644 tests/tracetool/all.rs
 create mode 100644 tests/tracetool/all.simpletrace-stap
 create mode 100644 tests/tracetool/all.stap
 create mode 100644 tests/tracetool/all.ust-events-c
 create mode 100644 tests/tracetool/all.ust-events-h

diff --git a/tests/tracetool/all.h b/tests/tracetool/all.h
new file mode 100644
index 00000000000..41fa4d0e8a2
--- /dev/null
+++ b/tests/tracetool/all.h
@@ -0,0 +1,102 @@
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
+extern uint8_t _TRACE_TEST_BLAH_DSTATE;
+extern uint8_t _TRACE_TEST_WIBBLE_DSTATE;
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
+#include "trace/ftrace.h"
+
+#include "qemu/log-for-trace.h"
+
+void _simple_trace_test_blah(void *context, const char *filename);
+void _simple_trace_test_wibble(void *context, int value);
+
+#include <syslog.h>
+
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
+    QEMU_TEST_BLAH_ENABLED() || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_BLAH) || \
+    tracepoint_enabled(qemu, test_blah) || \
+    false)
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+    QEMU_TEST_BLAH(context, filename);
+    tracepoint(qemu, test_blah, context, filename);
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
+#line 4 "trace-events"
+        ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
+#line 62 "all.h"
+        if (qemu_loglevel_mask(LOG_TRACE)) {
+#line 4 "trace-events"
+            qemu_log("test_blah " "Blah context=%p filename=%s" "\n", context, filename);
+#line 66 "all.h"
+        }
+        _simple_trace_test_blah(context, filename);
+#line 4 "trace-events"
+        syslog(LOG_INFO, "test_blah " "Blah context=%p filename=%s" , context, filename);
+#line 71 "all.h"
+    }
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    QEMU_TEST_WIBBLE_ENABLED() || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    trace_event_get_state_dynamic_by_id(TRACE_TEST_WIBBLE) || \
+    tracepoint_enabled(qemu, test_wibble) || \
+    false)
+
+static inline void trace_test_wibble(void *context, int value)
+{
+    QEMU_TEST_WIBBLE(context, value);
+    tracepoint(qemu, test_wibble, context, value);
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+#line 5 "trace-events"
+        ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
+#line 91 "all.h"
+        if (qemu_loglevel_mask(LOG_TRACE)) {
+#line 5 "trace-events"
+            qemu_log("test_wibble " "Wibble context=%p value=%d" "\n", context, value);
+#line 95 "all.h"
+        }
+        _simple_trace_test_wibble(context, value);
+#line 5 "trace-events"
+        syslog(LOG_INFO, "test_wibble " "Wibble context=%p value=%d" , context, value);
+#line 100 "all.h"
+    }
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/all.c b/tests/tracetool/all.c
new file mode 100644
index 00000000000..820ddb575b0
--- /dev/null
+++ b/tests/tracetool/all.c
@@ -0,0 +1,65 @@
+/* This file is autogenerated by tracetool, do not edit. */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "trace-testsuite.h"
+
+uint8_t _TRACE_TEST_BLAH_DSTATE;
+uint8_t _TRACE_TEST_WIBBLE_DSTATE;
+TraceEvent _TRACE_TEST_BLAH_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
+    .id = 0,
+#endif
+    .name = "test_blah",
+    .sstate = TRACE_TEST_BLAH_ENABLED,
+    .dstate = &_TRACE_TEST_BLAH_DSTATE
+};
+TraceEvent _TRACE_TEST_WIBBLE_EVENT = {
+#ifdef CONFIG_TRACE_SIMPLE
+    .id = 0,
+#endif
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
diff --git a/tests/tracetool/all.d b/tests/tracetool/all.d
new file mode 100644
index 00000000000..5cc06f9f4f5
--- /dev/null
+++ b/tests/tracetool/all.d
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
diff --git a/tests/tracetool/all.log-stap b/tests/tracetool/all.log-stap
new file mode 100644
index 00000000000..092986e0b61
--- /dev/null
+++ b/tests/tracetool/all.log-stap
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
diff --git a/tests/tracetool/all.rs b/tests/tracetool/all.rs
new file mode 100644
index 00000000000..c8c9d288366
--- /dev/null
+++ b/tests/tracetool/all.rs
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// This file is @generated by tracetool, do not edit.
+
+#[allow(unused_imports)]
+use std::ffi::c_char;
+#[allow(unused_imports)]
+use util::bindings;
+
+#[allow(dead_code)]
+#[inline(always)]
+fn trace_event_state_is_enabled(dstate: u8) -> bool {
+    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
+}
+
+extern "C" {
+    #[allow(dead_code)]
+    static mut trace_events_enabled_count: u32;
+}
+extern "C" {
+    #[allow(dead_code)]
+    static mut _TRACE_TEST_BLAH_DSTATE: u8;
+    #[allow(dead_code)]
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u8;
+}
+
+use std::cell::UnsafeCell;
+
+extern "C" {
+    #[allow(dead_code)]
+    static qemu_test_blah_semaphore: UnsafeCell<u16>;
+    #[allow(dead_code)]
+    static qemu_test_wibble_semaphore: UnsafeCell<u16>;
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah_enabled() -> bool
+{
+    (unsafe {qemu_test_blah_semaphore.get().read_volatile()}) != 0 ||
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
+    false
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
+{
+    ::trace::probe!(qemu, test_blah, _context, _filename.as_ptr());
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
+        let format_string = c"Blah context=%p filename=%s";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+        let format_string = c"test_blah Blah context=%p filename=%s\n";
+        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
+            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+        }
+        extern "C" { fn _simple_trace_test_blah(_context: *mut (), _filename: *const std::ffi::c_char); }
+        unsafe { _simple_trace_test_blah(_context, _filename.as_ptr()); }
+        let format_string = c"Blah context=%p filename=%s";
+        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    (unsafe {qemu_test_wibble_semaphore.get().read_volatile()}) != 0 ||
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
+    false
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    ::trace::probe!(qemu, test_wibble, _context, _value);
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+        let format_string = c"test_wibble Wibble context=%p value=%d\n";
+        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
+            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+        }
+        extern "C" { fn _simple_trace_test_wibble(_context: *mut (), _value: std::ffi::c_int); }
+        unsafe { _simple_trace_test_wibble(_context, _value); }
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+    }
+}
+
diff --git a/tests/tracetool/all.simpletrace-stap b/tests/tracetool/all.simpletrace-stap
new file mode 100644
index 00000000000..d064e3e286a
--- /dev/null
+++ b/tests/tracetool/all.simpletrace-stap
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
diff --git a/tests/tracetool/all.stap b/tests/tracetool/all.stap
new file mode 100644
index 00000000000..9c5d8a527ce
--- /dev/null
+++ b/tests/tracetool/all.stap
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
diff --git a/tests/tracetool/all.ust-events-c b/tests/tracetool/all.ust-events-c
new file mode 100644
index 00000000000..db232240568
--- /dev/null
+++ b/tests/tracetool/all.ust-events-c
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
diff --git a/tests/tracetool/all.ust-events-h b/tests/tracetool/all.ust-events-h
new file mode 100644
index 00000000000..4621a995fc1
--- /dev/null
+++ b/tests/tracetool/all.ust-events-h
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
diff --git a/tests/tracetool/meson.build b/tests/tracetool/meson.build
index f4f583e6224..b024dc6e405 100644
--- a/tests/tracetool/meson.build
+++ b/tests/tracetool/meson.build
@@ -11,7 +11,8 @@ backends = [
     'log',
     'simple',
     'syslog',
-    'ust'
+    'ust',
+    'all'
 ]
 
 # The tracetool-test.py program has portability problems on Windows.
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 74f315a4629..2f6328e68c3 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,16 +14,16 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"nop", "dtrace", "ftrace", "log", "simple", "syslog"}:
+    if backend in {"nop", "dtrace", "ftrace", "log", "simple", "syslog", "all"}:
         formats += ["rs"]
-    if backend == "dtrace":
+    if backend in {"dtrace", "all"}:
         formats += [
             "d",
             "log-stap",
             "simpletrace-stap",
             "stap",
         ]
-    if backend == "ust":
+    if backend in {"ust", "all"}:
         formats += [
             "ust-events-c",
             "ust-events-h",
@@ -36,8 +36,12 @@ def test_tracetool_one(tracetool, backend, fmt, src_dir, build_dir):
     actual_file = Path(build_dir, rel_filename)
     expect_file = Path(src_dir, rel_filename)
 
+    backends = backend
+    if backends == "all":
+        backends = "dtrace,ftrace,log,simple,syslog,ust"
+
     args = [sys.executable, tracetool,
-            f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
+            f"--format={fmt}", f"--backends={backends}", "--group=testsuite"]
 
     if fmt.find("stap") != -1:
         args += ["--binary=qemu", "--probe-prefix=qemu"]
-- 
2.56.0


