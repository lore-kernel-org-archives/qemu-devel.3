Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA556E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQRs-000150-By; Sat, 27 Dec 2025 04:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRq-0000kJ-49
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQRl-0004QZ-9R
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIVwFjqTLfC18+H9AtLgQG96XLWQyMts/mwazionaPA=;
 b=bsrV6sFE5qNvRYdvmSWr6nr4PDnGHS17ePLnhwiwFidHx1mgFio90aA2Cs9gGMkdthgMrp
 /VT5RXRPUyqdy/0UG4FHK/zAinifc3Bv1Zd701TDFyAQF1ebS90NXGzh3IyBb46NmPDUm3
 tk31tvGZmJIZuzTI1Wbzf7qqyI0ORgg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-enrTY8cNPemk09euJcTXEQ-1; Sat, 27 Dec 2025 04:18:46 -0500
X-MC-Unique: enrTY8cNPemk09euJcTXEQ-1
X-Mimecast-MFC-AGG-ID: enrTY8cNPemk09euJcTXEQ_1766827125
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325cc15176so3153841f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827124; x=1767431924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIVwFjqTLfC18+H9AtLgQG96XLWQyMts/mwazionaPA=;
 b=iLT9eRAlFGF4aoF9TwiKuR9NLc2ttbukxog5RnAGovHhBRjN2T3m5vQLTKFxyGR3qN
 wuYpuOGsCo95oD/eRRm9qMWlwPEBe7oNcvq3DOj3RmUbE8NELHWoPhAhcZJw5UUBW+/E
 knsO8UQAPwp2XgS+Hdp4jD70izFkVWhad72EnFydUuklQIMXNzM6/cNTJ54ud6cUKJAG
 Ina4jKPBw/aHuPqqLehIZv+7VkQLOYfKWyYJVsLzsZ8loptSQTuKW73/c0Iy3DAhBSY9
 SsFIxA/4bB0iazkHpc8nwGSKLzymWKo9NZB3IdPMb8CmLTY+r5nkINrQQbM5Kcflgtwo
 1RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827124; x=1767431924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIVwFjqTLfC18+H9AtLgQG96XLWQyMts/mwazionaPA=;
 b=LOnhZL9m1MRjaMOj8g2WcseGwmBFsnb0Q9GdG2RKXb/J13Kc0PHmJRUlh2/f5oASDJ
 XAZ9k6vZ2kOZRB30uOyVAoW9kVX9PbehS74gRsN9/wd4I5HFKb4Z8TEhmFYs7B4V0IRJ
 u/5jp5yX+325SqFdD6FJoSBRkHP2A/VeTSPswTMUEYSK7jML86V9vIA0QhA11VTU8MJx
 iLqNsqGjR7B8XC9G70xEgD1xMBwQg3/rm22gCtDkr5uxKNnTnfAaQ5vL9KpM3oMuWNnJ
 zq0zJ/52bikJ4KmJbZHZ1x8YbdCt9pqGERKCgzjU5nOx8qoUfwIhXCK1T/O+6soB77jw
 sYHg==
X-Gm-Message-State: AOJu0Yy0Wr19GOiPNNjtlr/O2N4qft8845inn87Sejq4K5e82vfASKn9
 ha8KxgrLQ374oJz/KST6hxZCQCezpDxyDFJjlRzZdEFf4+vR86mwMqbtfNkJC4tM89zOhnwGnEf
 oRtDWTma+5aff0aOpt5HQ8QiKeYUAgvDG4bSxLBiYFmF3rwUnWUVAHb5iPZFli/Q/MEHApxeJPR
 8oxDnl5KWjOgD8THCXES1Z1qcG7yKAEwKDkyz2jKGC
X-Gm-Gg: AY/fxX5N7DkvZRT49Nu+86kHfXBnjy1yqH01XXlsIoK2yCpVdvIMicjku+9lxyiPRH2
 qeNIY7ddwRMylKibFd/tuD1aC+4O+eUZ+54g4+2beqL1hA6RanPPBVGRN0mwpHifqQ0J4QR/Xzz
 tX2KsvLVza9To393REBfoX6StYxSWd1b0CEGAXRs5fEKhVggHaV86k5Wou+VKLsRDTY+6uZeGRr
 VcS+8yvqO61b14SVG+pbcFcjdpTP2cYG17Gb09R1yJgKLIk2JAwKQkTj9kGNuoTiq038qFhC+oO
 wkxAajvjsiiR+5VRPnGvfeIIqnRjshRf8XLJqRM2atjbZol8czwo244kIPQF8ySXhAx+W5SmAkM
 z7AuWWCuN9ns/JXlHo5Kb6x8bzK9uo0FPbBerFGYt9P5pkAIqLFyidl7VWvF8wCRq8twr7igsMj
 ySg7qXcAo3S2qYk84=
X-Received: by 2002:a05:600c:3b2a:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47d1953bd8bmr292017835e9.1.1766827123884; 
 Sat, 27 Dec 2025 01:18:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/9gdwCW71KiHrIR54MMDYooyKuF/93UcGKhNW6c7qLMuA10WyrmjVTqKXv3Ur1LiQnXDGag==
X-Received: by 2002:a05:600c:3b2a:b0:477:7ab8:aba with SMTP id
 5b1f17b1804b1-47d1953bd8bmr292017515e9.1.1766827123325; 
 Sat, 27 Dec 2025 01:18:43 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a40a14sm209462795e9.2.2025.12.27.01.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:18:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 071/153] tracetool: add Rust DTrace/SystemTap SDT support
Date: Sat, 27 Dec 2025 10:14:58 +0100
Message-ID: <20251227091622.20725-72-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Link: https://lore.kernel.org/r/20251119205200.173170-5-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                     |  6 +++
 rust/trace/Cargo.toml               |  1 +
 rust/trace/meson.build              |  2 +-
 rust/trace/src/lib.rs               |  4 ++
 scripts/tracetool/__init__.py       |  1 +
 scripts/tracetool/backend/dtrace.py | 31 ++++++++++++++
 scripts/tracetool/format/rs.py      | 27 ++++++++++--
 tests/tracetool/dtrace.rs           | 64 +++++++++++++++++++++++++++++
 tests/tracetool/ftrace.rs           | 21 ++++++++++
 tests/tracetool/log.rs              | 21 ++++++++++
 tests/tracetool/simple.rs           | 21 ++++++++++
 tests/tracetool/syslog.rs           | 21 ++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 13 files changed, 216 insertions(+), 6 deletions(-)
 create mode 100644 tests/tracetool/dtrace.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index f520597f25d..42ae857fe53 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -230,6 +230,10 @@ dependencies = [
  "util",
 ]
 
+[[package]]
+name = "probe"
+version = "0.5.2"
+
 [[package]]
 name = "proc-macro-error"
 version = "1.0.4"
@@ -388,6 +392,7 @@ dependencies = [
  "migration",
  "qom",
  "system",
+ "trace",
  "util",
 ]
 
@@ -430,6 +435,7 @@ name = "trace"
 version = "0.1.0"
 dependencies = [
  "libc",
+ "probe",
 ]
 
 [[package]]
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
index fc81bce5803..11e27f8d286 100644
--- a/rust/trace/Cargo.toml
+++ b/rust/trace/Cargo.toml
@@ -14,6 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 libc = { workspace = true }
+probe = "0.5"
 
 [lints]
 workspace = true
diff --git a/rust/trace/meson.build b/rust/trace/meson.build
index 1b3498f7fc1..0071a49cf72 100644
--- a/rust/trace/meson.build
+++ b/rust/trace/meson.build
@@ -11,7 +11,7 @@ _trace_rs = static_library(
   'trace',             # Library name,
   lib_rs,
   trace_rs_targets,         # List of generated `.rs` custom targets
-  dependencies: [libc_rs],
+  dependencies: [libc_rs, probe_rs],
 )
 
 trace_rs = declare_dependency(link_with: _trace_rs)
diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
index e03bce43c47..c2abe430a52 100644
--- a/rust/trace/src/lib.rs
+++ b/rust/trace/src/lib.rs
@@ -6,6 +6,9 @@
 #[doc(hidden)]
 /// Re-exported item to avoid adding libc as a dependency everywhere.
 pub use libc::{syslog, LOG_INFO};
+#[doc(hidden)]
+/// Re-exported item to avoid adding probe as a dependency everywhere.
+pub use probe::probe;
 
 #[macro_export]
 /// Define the trace-points from the named directory (which should have slashes
@@ -21,6 +24,7 @@ macro_rules! include_trace {
         #[allow(
             clippy::ptr_as_ptr,
             clippy::cast_lossless,
+            clippy::nonminimal_bool,
             clippy::used_underscore_binding
         )]
         mod trace {
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 74062d21a7c..61ba6f1ba8c 100644
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
index b4af403025c..f0b58cc1585 100644
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
index 32ac4e59770..7d9af7edfee 100644
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
index 00000000000..3490fcb271a
--- /dev/null
+++ b/tests/tracetool/dtrace.rs
@@ -0,0 +1,64 @@
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
+    ::trace::probe!(qemu, test_blah, _context, _filename.as_ptr());
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
+    ::trace::probe!(qemu, test_wibble, _context, _value);
+}
+
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
index 07b9259cf29..34f66004902 100644
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
index c191895c8f8..770758611d1 100644
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
index 9ee39495e38..92f896ef178 100644
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
index 9d3675a0b57..378d03d34b2 100644
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
index 786083ad7fb..30006a99190 100755
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
2.52.0


