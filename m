Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57B606D82E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HjWg2agX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNxIt-0003Wh-DX; Mon, 02 Nov 2026 14:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHs-0001zU-Jr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHn-0008F1-6f
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793646098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVLiXlgRnVDt9HN6YEs055+fC583nu5lD1opbfo202g=;
 b=HjWg2agXno5IwpDIqKUjEuG3FMV/ZiMVgKzB/1EwWXhc72T3s8mO6IuSXHn7eOHJ6DHQzW
 JEmFL1dNmj71Ej2XuhvX0AdQXoH1AIRWmYe6yu3Qlsx2aIjiE9XebLoBSWHQgeSziUluy2
 7j4nTB9o1h0QY94danBHKomjfQwHBRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-gu_EAvXwPOuA7EdNu_4fvg-1; Mon,
 02 Nov 2026 14:01:34 -0500
X-MC-Unique: gu_EAvXwPOuA7EdNu_4fvg-1
X-Mimecast-MFC-AGG-ID: gu_EAvXwPOuA7EdNu_4fvg_1793646093
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E07231802178; Mon,  2 Nov 2026 19:01:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8CD3230000E3; Mon,  2 Nov 2026 19:01:32 +0000 (UTC)
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
Subject: [PULL 10/25] trace: add testing of 'nop' trace backend
Date: Mon,  2 Nov 2026 13:58:16 -0500
Message-ID: <20261102185831.1880189-11-stefanha@redhat.com>
In-Reply-To: <20261102185831.1880189-1-stefanha@redhat.com>
References: <20261102185831.1880189-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This will be used to demonstrate that tracetool outputs the bare
minimum of code when tracing is disabled. Currently, as of this
initial commit of reference output, too much code is generated.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-11-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/nop.h             | 29 ++++++++++++++++++
 tests/tracetool/nop.c             | 36 ++++++++++++++++++++++
 tests/tracetool/meson.build       |  1 +
 tests/tracetool/nop.rs            | 51 +++++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py |  2 +-
 5 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tests/tracetool/nop.h
 create mode 100644 tests/tracetool/nop.c
 create mode 100644 tests/tracetool/nop.rs

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
2.56.0


