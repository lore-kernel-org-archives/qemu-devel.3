Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320FACA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhWo-0007Mi-Ra; Mon, 05 Oct 2026 08:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVT-000658-UK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVR-0004jc-NK
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CRQXWrCYRaS3NChAlbFqukq9PzI6r/TPGsj/tz+JpZg=;
 b=jWfUwPLnrDVJnagVpIpnZ6/ZxjX35clV7Ym5ifj83p+oeRQTqkqMmc80NcQXYgkbeGr1Pe
 /TPBvDNNXwAjBbkEQk/gPDuRuJSBTEzhA/9mSPNOlJutWHto6LOn6Mpn49nj3kckCtK17i
 8x2AmJruj/HND2WFXbh8eJOi6ahmeYw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-MbTjujr9MySwusII7ZN0xQ-1; Mon,
 05 Oct 2026 08:09:17 -0400
X-MC-Unique: MbTjujr9MySwusII7ZN0xQ-1
X-Mimecast-MFC-AGG-ID: MbTjujr9MySwusII7ZN0xQ_1791202156
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BCDE18088B9; Mon,  5 Oct 2026 12:09:16 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EADF3001D2A; Mon,  5 Oct 2026 12:09:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 10/24] trace: add testing of 'nop' trace backend
Date: Mon,  5 Oct 2026 13:08:41 +0100
Message-ID: <20261005120855.421973-11-berrange@redhat.com>
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

This will be used to demonstrate that tracetool outputs the bare
minimum of code when tracing is disabled. Currently, as of this
initial commit of reference output, too much code is generated.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/tracetool/meson.build       |  1 +
 tests/tracetool/nop.c             | 36 ++++++++++++++++++++++
 tests/tracetool/nop.h             | 29 ++++++++++++++++++
 tests/tracetool/nop.rs            | 51 +++++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py |  2 +-
 5 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tests/tracetool/nop.c
 create mode 100644 tests/tracetool/nop.h
 create mode 100644 tests/tracetool/nop.rs

diff --git a/tests/tracetool/meson.build b/tests/tracetool/meson.build
index 09bbaaa86bf..f4f583e6224 100644
--- a/tests/tracetool/meson.build
+++ b/tests/tracetool/meson.build
@@ -5,6 +5,7 @@ test_env.set('PYTHONPATH', meson.project_source_root() / 'scripts')
 test_env.set('PYTHONIOENCODING', 'utf-8')
 
 backends = [
+    'nop',
     'dtrace',
     'ftrace',
     'log',
diff --git a/tests/tracetool/nop.c b/tests/tracetool/nop.c
new file mode 100644
index 00000000000..f83d06252ea
--- /dev/null
+++ b/tests/tracetool/nop.c
@@ -0,0 +1,36 @@
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
diff --git a/tests/tracetool/nop.h b/tests/tracetool/nop.h
new file mode 100644
index 00000000000..443f5e0cf6e
--- /dev/null
+++ b/tests/tracetool/nop.h
@@ -0,0 +1,29 @@
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
+
+#define TRACE_TEST_BLAH_BACKEND_DSTATE() ( \
+    false)
+
+static inline void trace_test_blah(void *context, const char *filename)
+{
+}
+
+#define TRACE_TEST_WIBBLE_BACKEND_DSTATE() ( \
+    false)
+
+static inline void trace_test_wibble(void *context, int value)
+{
+}
+#endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/tests/tracetool/nop.rs b/tests/tracetool/nop.rs
new file mode 100644
index 00000000000..5f007cecd04
--- /dev/null
+++ b/tests/tracetool/nop.rs
@@ -0,0 +1,51 @@
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
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah_enabled() -> bool
+{
+    false
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
+{
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    false
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+}
+
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 59e9ab3d6ef..74f315a4629 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,7 +14,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"dtrace", "ftrace", "log", "simple", "syslog"}:
+    if backend in {"nop", "dtrace", "ftrace", "log", "simple", "syslog"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.55.0


