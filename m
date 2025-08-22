Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00554CA0EFF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQsO-0005Sx-06; Fri, 22 Aug 2025 08:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrw-0004wW-JH
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQru-0002Rs-7E
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4sp5q9Ev0Q4evd/kMM89mk6qRydVkinYUvgIDfPHYY=;
 b=XyE/UStOTslT3rZob6AvL/30UjFfoMflYRJSW2INTvdGGdSgcgIIFZXUciptrxxGuQ1c/G
 V1NctAHR8QE6STDK+tUc2szfalMIE1CJZnGH/PIhagP7VGDyyYImMBNgppgZTTn2Wgd0fn
 P13p5k5umWRIENCM9jy6375jMLBvRJA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-h_vCn4dGNvCkHxwc3p8Bag-1; Fri, 22 Aug 2025 08:27:39 -0400
X-MC-Unique: h_vCn4dGNvCkHxwc3p8Bag-1
X-Mimecast-MFC-AGG-ID: h_vCn4dGNvCkHxwc3p8Bag_1755865659
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-afcb7377e95so166952966b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865658; x=1756470458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O4sp5q9Ev0Q4evd/kMM89mk6qRydVkinYUvgIDfPHYY=;
 b=VC8lvYAPTWjWsRsJyq4ue07zS8R3Qr2UlfhASJ8bCtIWkGnaix+QYsywBdSyiLYkR9
 4gHiqtYIOuA5UGwojEB1ChbzXIxlj7KqrhT4r+lQmadtViiXtKee50H5n8CSdg61YUuM
 Zv1yq63JqOnNW3OQX0fOOk6eYDXWJ2ucbJcYhGtiTBjxIXWBa5GMJYpxS+9Kq0iWMajs
 woCQbzmIpEKIXoUhTZr5OM8KeZleKn223O8Z3UlVM0u9xGPDCUaGxq4WiBpsqrOjG32r
 iNkTWwdFPJwNKCd7JjjJmaPl8JsAlvn33wotvOTRvs2v2xksg+2hs6lw1ghK+HggQXWg
 XnMg==
X-Gm-Message-State: AOJu0YwnNrkZs7bi6R4a7GZ+uY4WSL0oobsFXEQR/RfGg7BZT3omud5t
 1qwlYU3hgRAY1ru7fdOG1TyufwtzZDLYthks3Od9+yxu7U4gyAsImTYBC/6iKU1Da7IZ/FgXyx4
 knbhUmhQMtmt0uwexqzVftdWhHdsQdtA6Q+o1YegUgagaEy0AcKz3FJ62euEMXfgt/2YhmeVUv3
 p85UvNutK/9zYtImbeziWddoytLuM1nUwAHPWNNL0e
X-Gm-Gg: ASbGncsMKoSj8Jj6SZv+ih/30HRahegnzeJ8ZNMPRhXJXQTlpn72zJWiz63fo3RkgF5
 Xc4vN3W1zTsWgw5kBJ1Cgd8RVl6QT0kPzomJoc9VRrt4bcAz9ZaAel2e0NzWs/3Un3Gj0HwnoqF
 c1KCpg5J5f9xp9tdxi4aXh3poRNQzW4rx56DCqcZhkw1Yg2n7b5TreE109WDLeTz5+MsCjn3lC7
 ArhvFpIzTwzzzzbDG9OeOTqt0CALp54moBy28YC8T+6axMkU8Tc8+U0FS04I6Gh3h4/LQ+3t0fs
 EOZIUt81GksTJ1w1xBPmvARUP1jU/Q/ApNfXtH0w1igWZ0xVE5XBJdn+ayAteFESVXE8JnIXNL9
 aGzfGI7E8zuO4bnHEf3PqbpCSTb7lpBGGHKU4vlvy/g==
X-Received: by 2002:a17:906:d554:b0:af9:a1e4:1bbd with SMTP id
 a640c23a62f3a-afe295d1a16mr216720866b.34.1755865658183; 
 Fri, 22 Aug 2025 05:27:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN8vi075IqxIozgEUykOUjz+ayTNpv9gsDWhZth6BdyNxNPZXnrJuJMgmjfEQyUwZyHGH88A==
X-Received: by 2002:a17:906:d554:b0:af9:a1e4:1bbd with SMTP id
 a640c23a62f3a-afe295d1a16mr216717266b.34.1755865657620; 
 Fri, 22 Aug 2025 05:27:37 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afded3119e9sm591143766b.40.2025.08.22.05.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 14/14] tracetool/syslog: add Rust support
Date: Fri, 22 Aug 2025 14:26:55 +0200
Message-ID: <20250822122655.1353197-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tanish Desai <tanishdesai37@gmail.com>

The syslog backend needs the syslog function from libc and the LOG_INFO enum
value; they are re-exported as "::trace::syslog" and "::trace::LOG_INFO"
so that device crates do not all have to add the libc dependency, but
otherwise there is nothing special.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                     |  3 +++
 rust/trace/Cargo.toml               |  3 +++
 rust/trace/src/lib.rs               |  4 +++
 scripts/tracetool/backend/syslog.py |  7 ++++-
 tests/tracetool/syslog.rs           | 41 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 6 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/syslog.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 6ed838f863f..e5f10cb358a 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -168,6 +168,9 @@ dependencies = [
 [[package]]
 name = "trace"
 version = "0.1.0"
+dependencies = [
+ "libc",
+]
 
 [[package]]
 name = "unicode-ident"
diff --git a/rust/trace/Cargo.toml b/rust/trace/Cargo.toml
index 913010e9787..5f0f370e523 100644
--- a/rust/trace/Cargo.toml
+++ b/rust/trace/Cargo.toml
@@ -12,5 +12,8 @@ license.workspace = true
 repository.workspace = true
 rust-version.workspace = true
 
+[dependencies]
+libc = { workspace = true }
+
 [lints]
 workspace = true
diff --git a/rust/trace/src/lib.rs b/rust/trace/src/lib.rs
index 9b931ddf1de..966991432e3 100644
--- a/rust/trace/src/lib.rs
+++ b/rust/trace/src/lib.rs
@@ -1,6 +1,10 @@
 //! This crate provides macros that aid in using QEMU's tracepoint
 //! functionality.
 
+#[doc(hidden)]
+/// Re-exported items to avoid adding libc as a dependency everywhere.
+pub use libc::{syslog, LOG_INFO};
+
 #[macro_export]
 /// Define the trace-points from the named directory (which should have slashes
 /// replaced by underscore characters) as functions in a module called `trace`.
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 04ec85717a3..acaa56ba073 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -12,7 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import out, expand_format_string
 
 
 PUBLIC = True
@@ -38,6 +38,11 @@ def generate_h(event, group):
         fmt=event.fmt.rstrip("\n"),
         argnames=argnames)
 
+def generate_rs(event, group):
+    out('        let format_string = c"%(fmt)s";',
+        '        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, %(args)s);}',
+        fmt=expand_format_string(event.fmt),
+        args=event.args.rust_call_varargs())
 
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
diff --git a/tests/tracetool/syslog.rs b/tests/tracetool/syslog.rs
new file mode 100644
index 00000000000..33a8ae7c1aa
--- /dev/null
+++ b/tests/tracetool/syslog.rs
@@ -0,0 +1,41 @@
+// This file is autogenerated by tracetool, do not edit.
+
+#[allow(unused_imports)]
+use std::ffi::c_char;
+#[allow(unused_imports)]
+use qemu_api::bindings;
+
+#[inline(always)]
+fn trace_event_get_state_dynamic_by_id(_id: u16) -> bool {
+    unsafe { (trace_events_enabled_count != 0) && (_id != 0) }
+}
+
+extern "C" {
+    static mut trace_events_enabled_count: u32;
+}
+extern "C" {
+    static mut _TRACE_TEST_BLAH_DSTATE: u16;
+    static mut _TRACE_TEST_WIBBLE_DSTATE: u16;
+}
+const _TRACE_TEST_BLAH_ENABLED: bool = true;
+const _TRACE_TEST_WIBBLE_ENABLED: bool = true;
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
+        let format_string = c"Blah context=%p filename=%s";
+        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context, _filename.as_ptr());}
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context, _value);}
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index a91d635910a..d317e047891 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -13,7 +13,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"ftrace", "log", "simple"}:
+    if backend in {"ftrace", "log", "simple", "syslog"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.50.1


