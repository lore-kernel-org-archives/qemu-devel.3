Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96006CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrr-0004vi-JW; Fri, 22 Aug 2025 08:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrk-0004tn-UP
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQri-0002Qi-7V
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YQ8AYs0Fl55/1eCaYVbFMT4Peihtte4ZllR6oeuTDd8=;
 b=fAIBislIHt4NzqRcgthhYdaSDLTMro37cObww7GAG7cO/Nx/XRE7VOz5/b0AUpI1CW+Fsz
 zCUvXvQ+v6m2ZrVhEMKTtmEsm1xfAxWPWcEZgx/qf4ZbRUSIbaZStm2bzuO2+t2HilkyYw
 C81SV/7ALudUsjbWGm22TmTcjl5GXuc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Eoc3lh_5MJWFG_IlmNXgGA-1; Fri, 22 Aug 2025 08:27:26 -0400
X-MC-Unique: Eoc3lh_5MJWFG_IlmNXgGA-1
X-Mimecast-MFC-AGG-ID: Eoc3lh_5MJWFG_IlmNXgGA_1755865645
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so14231925e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865643; x=1756470443;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQ8AYs0Fl55/1eCaYVbFMT4Peihtte4ZllR6oeuTDd8=;
 b=SoPOtNsw9cCBOB+L7rdRd57cjna563dS47rmudJo8Un+Wzut0xMYqKGL55/e1LcVPr
 ys87ahWzE3zILR3RUQr6ftjaBvXFfHTtmCfGAbAQbbKXNvtU9FgTkmbHuu7POz90XO16
 C2M5bGuwOarmF2e6l1xMXHlbRfMLINuUblItAzKiefo8nre/pEEJIKyDVQwfIxDYGfaH
 Jz6J1JQjfIW/qaBHBJoTXzIwZcgN2XU/bqUv7sxSrlqDe/1chqgBQCqvvqMmizyyVlbJ
 b8r4NEn7jLb+zai+7hMFi5fwF8gp+WWV/aUyMzKjJVYcYP7M31OjKHXhAeaFipIqC0LK
 NYpw==
X-Gm-Message-State: AOJu0YzbmcyAf1GlSjvDBg5l/nGXRdRXvl/ZrDN2fhxyWR4jX4yvhdat
 oFyjtgXygWPHET55f4PZAPrMelmss3hR6UD7BmTPrRdDJductzPa836N/GzZ1+JxXZVWUnX1kMo
 JRZocNMFdcD4NS49lZ8TngnCyYsu+cYadlM+w/WWc+ZFIf0p2HUP7s7BvMBfqe4a/Afn7SwXEEw
 R9m+q81s0T9wzWnmv3uc+4PH9WgO3fgeIaoQMKMBNW
X-Gm-Gg: ASbGncsDRtItCGl5yjIiaXttDLo3z3yr7lYPfKPtZKgjJcxxsAuu/zfH/69QV0zmANv
 MGigieGEGF1N/H61uwg9YJ/uJ+30SARxFZKXqBX32IHMuXgU4kRyXNDki1MaZ2LmoOSy6oEUklk
 mhNYYKRVoQt8zhtMNlrYRoWgU/WSL4Gnw0GSZ8ajSuE7ueZPVgYnU/8cMzWBABvj3qpY5kaT50Y
 38ZWRcjvWYLAQ9boa1jW3Xej77duWBdCnYxCcq5W2GpYiVqRf7U56ApfRhEtjptu/4iG/1cxZYC
 IEiO9cNEqqrOx4i/BUpmk5t6Lz71DYYX4ZQ7WJPvhMYJFNVAAAlZvSG3Oo5hXIspqIPqctSEhp4
 UZh+3zulokM9QcpdCRcw+pyjcTU9xhlY+UZVjOe0SxQ==
X-Received: by 2002:a05:600c:4590:b0:459:dfde:3324 with SMTP id
 5b1f17b1804b1-45b517d2da6mr21265985e9.29.1755865643205; 
 Fri, 22 Aug 2025 05:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECy9Ss3B9WS7pFdKUWEp7JuYNsQQE8/2u4eSQDjWuq0mLAXriV23JMsaMfVA0WlXc4i0v1tQ==
X-Received: by 2002:a05:600c:4590:b0:459:dfde:3324 with SMTP id
 5b1f17b1804b1-45b517d2da6mr21265775e9.29.1755865642717; 
 Fri, 22 Aug 2025 05:27:22 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e83a50fsm37299025e9.2.2025.08.22.05.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 10/14] tracetool/simple: add Rust support
Date: Fri, 22 Aug 2025 14:26:51 +0200
Message-ID: <20250822122655.1353197-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/__init__.py       |  2 +-
 scripts/tracetool/backend/simple.py |  7 +++++
 tests/tracetool/simple.rs           | 41 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 ++
 4 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 tests/tracetool/simple.rs

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 0b8ec707332..7542757799e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -336,7 +336,7 @@ def rust_call_extern(self):
         def rust_cast(name, type_):
             if type_ == "const char *":
                 return f"_{name}.as_ptr()"
-            return "_{name}"
+            return f"_{name}"
 
         return ", ".join((rust_cast(name, type_) for type_, name in self._args))
 
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index a8afc977a20..7acbd6cc69d 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -98,3 +98,10 @@ def generate_c(event, group):
     out('    trace_record_finish(&rec);',
         '}',
         '')
+
+def generate_rs(event, group):
+    out('        extern "C" { fn _simple_%(api)s(%(rust_args)s); }',
+        '        unsafe { _simple_%(api)s(%(args)s); }',
+        api=event.api(),
+        rust_args=event.args.rust_decl_extern(),
+        args=event.args.rust_call_extern())
diff --git a/tests/tracetool/simple.rs b/tests/tracetool/simple.rs
new file mode 100644
index 00000000000..895096088dc
--- /dev/null
+++ b/tests/tracetool/simple.rs
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
+        extern "C" { fn _simple_trace_test_blah(_context: *mut (), _filename: *const std::ffi::c_char); }
+        unsafe { _simple_trace_test_blah(_context, _filename.as_ptr()); }
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        extern "C" { fn _simple_trace_test_wibble(_context: *mut (), _value: std::ffi::c_int); }
+        unsafe { _simple_trace_test_wibble(_context, _value); }
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index a420597fc48..ad7dd667288 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -13,6 +13,8 @@ def get_formats(backend):
         "c",
         "h",
     ]
+    if backend in {"simple"}:
+        formats += ["rs"]
     if backend == "dtrace":
         formats += [
             "d",
-- 
2.50.1


