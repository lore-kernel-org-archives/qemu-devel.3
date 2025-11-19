Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C30CF58F8
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 20:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLpA5-0007yg-B4; Wed, 19 Nov 2025 15:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLpA4-0007xw-B0
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:52:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLpA2-00025O-1L
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763585537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=inJHY2mpT+t2Kxjje60f2B/u2frM4y4WcLTs+HH+0ts=;
 b=YO7qNFmuRarzj0kdNLBfyn/+VFzSsIJK8LidhlinddPXbKSFovTI3Xg0WgIwdKchhYrdYo
 butUl5wKdJYpmVeLkCXF2deILq5XnRrLmVp3X4Mbo1hVyDtaxZj28buUlulL6uvdLXvNhN
 ZwKq8tGzu4KhzR78MtxpS3fE9wvkkfM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-S6oWsReUPuCHqRRSu_RpWg-1; Wed,
 19 Nov 2025 15:52:12 -0500
X-MC-Unique: S6oWsReUPuCHqRRSu_RpWg-1
X-Mimecast-MFC-AGG-ID: S6oWsReUPuCHqRRSu_RpWg_1763585531
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54F851801233; Wed, 19 Nov 2025 20:52:11 +0000 (UTC)
Received: from localhost (unknown [10.2.16.175])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57E3230001A4; Wed, 19 Nov 2025 20:52:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Stone <jistone@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 4/4] tracetool: add Rust DTrace/SystemTap SDT support
Date: Wed, 19 Nov 2025 15:52:00 -0500
Message-ID: <20251119205200.173170-5-stefanha@redhat.com>
In-Reply-To: <20251119205200.173170-1-stefanha@redhat.com>
References: <20251119205200.173170-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Implement DTrace/SystemTap SDT by emitting the following:
- The probe crate's probe!() macro is used to emit a DTrace/SystemTap
  SDT probe.
- Every trace event gets a corresponding trace_<name>_enabled() -> bool
  generated function that Rust code can use to avoid expensive
  computation when a trace event is disabled. This API works for other
  trace backends too.

`#[allow(dead_code)]` additions are necessary for QEMU's dstate in
generated trace-<dir>.rs files since they are unused by the dtrace
backend. `./configure --enable-trace-backends=` can enable multiple
backends, so keep it simple and just silence the warning instead of
trying to detect the condition when generating the dstate code can be
skipped.

The tracetool tests are updated. Take a look at
tests/tracetool/dtrace.rs to see what the new generated code looks like.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 rust/Cargo.lock                     |  6 +++
 rust/trace/Cargo.toml               |  1 +
 rust/trace/meson.build              |  2 +-
 rust/trace/src/lib.rs               |  4 ++
 scripts/tracetool/__init__.py       |  1 +
 scripts/tracetool/backend/dtrace.py | 31 ++++++++++++++
 scripts/tracetool/format/rs.py      | 27 ++++++++++--
 tests/tracetool/dtrace.rs           | 65 +++++++++++++++++++++++++++++
 tests/tracetool/ftrace.rs           | 21 ++++++++++
 tests/tracetool/log.rs              | 21 ++++++++++
 tests/tracetool/simple.rs           | 21 ++++++++++
 tests/tracetool/syslog.rs           | 21 ++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 13 files changed, 217 insertions(+), 6 deletions(-)
 create mode 100644 tests/tracetool/dtrace.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 0c1df625df..5bd768cb0d 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -144,6 +144,7 @@ dependencies = [
  "migration",
  "qom",
  "system",
+ "trace",
  "util",
 ]
 
@@ -229,6 +230,10 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "probe"
+version = "0.5.2"
+
 [[package]]
 name = "proc-macro-error"
 version = "1.0.4"
@@ -429,6 +434,7 @@ name = "trace"
 version = "0.1.0"
 dependencies = [
  "libc",
+ "probe",
 ]
 
 [[package]]
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
index fc81bce580..11e27f8d28 100644
--- a/rust/trace/Cargo.toml
+++ b/rust/trace/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 libc = { workspace = true }
+probe = "0.5"
 
 [lints]
 workspace = true
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
index adca57e550..cf6b0355a8 100644
--- a/rust/trace/meson.build
+++ b/rust/trace/meson.build
@@ -12,7 +12,7 @@ _trace_rs = static_library(
   lib_rs,
   trace_rs_targets,         # List of generated `.rs` custom targets
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  dependencies: [libc_rs],
+  dependencies: [libc_rs, probe_rs],
   rust_abi: 'rust',
 )
 
diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
index e03bce43c4..49331f07c6 100644
--- a/rust/trace/src/lib.rs
+++ b/rust/trace/src/lib.rs
@@ -7,6 +7,10 @@
 /// Re-exported item to avoid adding libc as a dependency everywhere.
 pub use libc::{syslog, LOG_INFO};
 
+#[doc(hidden)]
+/// Re-exported item to avoid adding probe as a dependency everywhere.
+pub use probe::probe;
+
 #[macro_export]
 /// Define the trace-points from the named directory (which should have slashes
 /// replaced by underscore characters) as functions in a module called `trace`.
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 74062d21a7..61ba6f1ba8 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -461,6 +461,7 @@ def formats(self):
 
     QEMU_TRACE               = "trace_%(name)s"
     QEMU_TRACE_TCG           = QEMU_TRACE + "_tcg"
+    QEMU_RUST_DSTATE         = "trace_%(name)s_enabled"
     QEMU_DSTATE              = "_TRACE_%(NAME)s_DSTATE"
     QEMU_BACKEND_DSTATE      = "TRACE_%(NAME)s_BACKEND_DSTATE"
     QEMU_EVENT               = "_TRACE_%(NAME)s_EVENT"
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index b4af403025..f0b58cc158 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -70,3 +70,34 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    QEMU_%(uppername)s_ENABLED() || \\',
         uppername=event.name.upper())
+
+
+def generate_rs_begin(events, group):
+    out('use std::cell::UnsafeCell;',
+        '',
+        'extern "C" {')
+    # These are the Rust declarations of the .probes section semaphores
+    # generated by dtrace(1) in its .o file output.
+    for e in events:
+        if 'disable' in e.properties:
+            continue
+        out('    #[allow(dead_code)]',
+            f'    static qemu_{e.name}_semaphore: UnsafeCell<u16>;')
+    out('}',
+        '')
+
+
+def generate_rs(event, group):
+    args = event.args.rust_call_extern()
+    if args:
+        args = ', ' + args
+
+    out(f'    ::trace::probe!(qemu, {event.name}{args});')
+
+
+def generate_rs_backend_dstate(event, group):
+    # Rust does not have access to the <provider>_<name>_ENABLED() macro from
+    # the dtrace(1) generated .h file. Use the matching semaphore declarations
+    # generated by generate_rs_begin() instead.
+    out('    (unsafe {qemu_%(n)s_semaphore.get().read_volatile()}) != 0 ||',
+        n=event.name)
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
index 32ac4e5977..7d9af7edfe 100644
--- a/scripts/tracetool/format/rs.py
+++ b/scripts/tracetool/format/rs.py
@@ -24,25 +24,43 @@ def generate(events, backend, group):
         '#[allow(unused_imports)]',
         'use util::bindings;',
         '',
+        '#[allow(dead_code)]',
         '#[inline(always)]',
         'fn trace_event_state_is_enabled(dstate: u16) -> bool {',
         '    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0',
         '}',
         '',
         'extern "C" {',
+        '    #[allow(dead_code)]',
         '    static mut trace_events_enabled_count: u32;',
         '}',)
 
     out('extern "C" {')
 
     for e in events:
-        out('    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
-    out('}')
+        out('    #[allow(dead_code)]',
+            '    static mut %s: u16;' % e.api(e.QEMU_DSTATE))
+    out('}',
+        '')
 
     backend.generate_begin(events, group)
 
     for e in events:
-        out('',
+        out('#[inline(always)]',
+            '#[allow(dead_code)]',
+            'pub fn %(api)s() -> bool',
+            '{',
+            api=e.api(e.QEMU_RUST_DSTATE))
+
+        if "disable" not in e.properties:
+            backend.generate_backend_dstate(e, group)
+            if backend.check_trace_event_get_state:
+                out('    trace_event_state_is_enabled(unsafe { _%(event_id)s_DSTATE}) ||',
+                    event_id = 'TRACE_' + e.name.upper())
+
+        out('    false',
+            '}',
+            '',
             '#[inline(always)]',
             '#[allow(dead_code)]',
             'pub fn %(api)s(%(args)s)',
@@ -59,6 +77,7 @@ def generate(events, backend, group):
                     api=e.api())
                 backend.generate(e, group, check_trace_event_get_state=True)
                 out('    }')
-        out('}')
+        out('}',
+            '')
 
     backend.generate_end(events, group)
diff --git a/tests/tracetool/dtrace.rs b/tests/tracetool/dtrace.rs
new file mode 100644
index 0000000000..233c2ef159
--- /dev/null
+++ b/tests/tracetool/dtrace.rs
@@ -0,0 +1,65 @@
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
+fn trace_event_state_is_enabled(dstate: u16) -> bool {
+    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
+}
+
+extern "C" {
+    #[allow(dead_code)]
+    static mut trace_events_enabled_count: u32;
+}
+extern "C" {
+    #[allow(dead_code)]
+    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    #[allow(dead_code)]
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+}
+
+use probe::probe;
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
+    false
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
+{
+    probe!(qemu, test_blah, _context, _filename.as_ptr());
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    (unsafe {qemu_test_wibble_semaphore.get().read_volatile()}) != 0 ||
+    false
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    probe!(qemu, test_wibble, _context, _value);
+}
+
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
index 07b9259cf2..34f6600490 100644
--- a/tests/tracetool/ftrace.rs
+++ b/tests/tracetool/ftrace.rs
@@ -6,19 +6,31 @@
 #[allow(unused_imports)]
 use util::bindings;
 
+#[allow(dead_code)]
 #[inline(always)]
 fn trace_event_state_is_enabled(dstate: u16) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
 extern "C" {
+    #[allow(dead_code)]
     static mut trace_events_enabled_count: u32;
 }
 extern "C" {
+    #[allow(dead_code)]
     static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    #[allow(dead_code)]
     static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
@@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
     }
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
@@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
     }
 }
+
diff --git a/tests/tracetool/log.rs b/tests/tracetool/log.rs
index c191895c8f..770758611d 100644
--- a/tests/tracetool/log.rs
+++ b/tests/tracetool/log.rs
@@ -6,19 +6,31 @@
 #[allow(unused_imports)]
 use util::bindings;
 
+#[allow(dead_code)]
 #[inline(always)]
 fn trace_event_state_is_enabled(dstate: u16) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
 extern "C" {
+    #[allow(dead_code)]
     static mut trace_events_enabled_count: u32;
 }
 extern "C" {
+    #[allow(dead_code)]
     static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    #[allow(dead_code)]
     static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
@@ -31,6 +43,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
     }
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
@@ -42,3 +62,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
         }
     }
 }
+
diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
index 9ee39495e3..92f896ef17 100644
--- a/tests/tracetool/simple.rs
+++ b/tests/tracetool/simple.rs
@@ -6,19 +6,31 @@
 #[allow(unused_imports)]
 use util::bindings;
 
+#[allow(dead_code)]
 #[inline(always)]
 fn trace_event_state_is_enabled(dstate: u16) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
 extern "C" {
+    #[allow(dead_code)]
     static mut trace_events_enabled_count: u32;
 }
 extern "C" {
+    #[allow(dead_code)]
     static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    #[allow(dead_code)]
     static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
@@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
     }
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
@@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
         unsafe { _simple_trace_test_wibble(_context, _value); }
     }
 }
+
diff --git a/tests/tracetool/syslog.rs b/tests/tracetool/syslog.rs
index 9d3675a0b5..378d03d34b 100644
--- a/tests/tracetool/syslog.rs
+++ b/tests/tracetool/syslog.rs
@@ -6,19 +6,31 @@
 #[allow(unused_imports)]
 use util::bindings;
 
+#[allow(dead_code)]
 #[inline(always)]
 fn trace_event_state_is_enabled(dstate: u16) -> bool {
     (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
 }
 
 extern "C" {
+    #[allow(dead_code)]
     static mut trace_events_enabled_count: u32;
 }
 extern "C" {
+    #[allow(dead_code)]
     static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    #[allow(dead_code)]
     static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
@@ -29,6 +41,14 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
     }
 }
 
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble_enabled() -> bool
+{
+    trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) ||
+    false
+}
+
 #[inline(always)]
 #[allow(dead_code)]
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
@@ -38,3 +58,4 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
         unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
     }
 }
+
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 786083ad7f..30006a9919 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,7 +14,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"ftrace", "log", "simple", "syslog"}:
+    if backend in {"dtrace", "ftrace", "log", "simple", "syslog"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.51.1


