Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DABCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZGb-0002eq-Hg; Fri, 19 Sep 2025 07:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZGa-0002cy-87
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZGV-0001Hj-7Q
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OxxhJH7mYDJsMGbQFsPKda4XtCXRWWrT21EaMgXYJyA=;
 b=APs/0GNtV62/YPKDey3icLkgPDB+3A13dyAX9IDFjBG2a6zVtXDaJWHBB8gbJJRbVkBQmG
 tTQTDJs1ECuurAocY6HSqy0m7sPDjeqQwX1pSUNZKiiv3mDI9E09xL8hhuAad0k7FdVjFy
 nGJ7RXRJQWwrQTxzH4wP3ItPkIqjpnQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-x25rLqPHMjiujMqzaFkNKA-1; Fri,
 19 Sep 2025 07:26:53 -0400
X-MC-Unique: x25rLqPHMjiujMqzaFkNKA-1
X-Mimecast-MFC-AGG-ID: x25rLqPHMjiujMqzaFkNKA_1758281212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E203C19560A7; Fri, 19 Sep 2025 11:26:51 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19CC230002C5; Fri, 19 Sep 2025 11:26:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 15/16] tracetool/ftrace: add Rust support
Date: Fri, 19 Sep 2025 13:25:35 +0200
Message-ID: <20250919112536.141782-16-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/ftrace.py |  8 +++++-
 tests/tracetool/ftrace.rs           | 40 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 3 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/ftrace.rs

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 7ddd5d11a66..e03698a2edf 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,7 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import out, expand_format_string
 
 
 PUBLIC = True
@@ -43,3 +43,9 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
+
+def generate_rs(event, group):
+    out('        let format_string = c"%(fmt)s";',
+        '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
+        fmt=expand_format_string(event.fmt),
+        args=event.args.rust_call_varargs())
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
new file mode 100644
index 00000000000..7811056f673
--- /dev/null
+++ b/tests/tracetool/ftrace.rs
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// This file is @generated by tracetool, do not edit.
+
+#[allow(unused_imports)]
+use std::ffi::c_char;
+#[allow(unused_imports)]
+use util::bindings;
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
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
+        let format_string = c"Blah context=%p filename=%s";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index f58f3b795e7..3341fb18f90 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,7 +14,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"log", "simple"}:
+    if backend in {"ftrace", "log", "simple"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.51.0



