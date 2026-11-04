Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487AF6072660
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UmeVC4nT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhRg-0007C3-Fm; Wed, 04 Nov 2026 15:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRO-000702-7b
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRM-00067F-Aa
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793823515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlKbUaAjj04ta+A1/nUMfLg/CAVRg3igZyolJR7CeYY=;
 b=UmeVC4nT5QZjl/lu9RwMubgnoJNJFbfQFBifSfPpIBJpPrZlFzCbNEqPLsAoe0XJLW2NBP
 tvY5EasvrSkRGOx+xHnro35W38PHlRZrr94ndt6VWnGWf1wxCWEAUfHGn2O0AEpbDUjKzY
 C6sLH/x34GKCWOwViGNIaFLlnGBSqqU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-XdjpUXIEPBmDb0Z7Y61BCA-1; Wed,
 04 Nov 2026 15:18:30 -0500
X-MC-Unique: XdjpUXIEPBmDb0Z7Y61BCA-1
X-Mimecast-MFC-AGG-ID: XdjpUXIEPBmDb0Z7Y61BCA_1793823508
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC0C51955DD7; Wed,  4 Nov 2026 20:18:28 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CAFC195604C; Wed,  4 Nov 2026 20:18:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 14/25] trace: include probe name in Rust format strings
Date: Wed,  4 Nov 2026 15:17:50 -0500
Message-ID: <20261104201802.11556-15-stefanha@redhat.com>
In-Reply-To: <20261104201802.11556-1-stefanha@redhat.com>
References: <20261104201802.11556-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The C format strings all include the probe name as a prefix,
however, this was missed in the Rust generators for ftrace
and syslog.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-15-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool/backend/ftrace.py | 2 +-
 scripts/tracetool/backend/syslog.py | 2 +-
 tests/tracetool/all.rs              | 8 ++++----
 tests/tracetool/ftrace.rs           | 4 ++--
 tests/tracetool/syslog.rs           | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index e03698a2edf..ba2a0c83770 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -47,5 +47,5 @@ def generate_h_backend_dstate(event, group):
 def generate_rs(event, group):
     out('        let format_string = c"%(fmt)s";',
         '        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, %(args)s);}',
-        fmt=expand_format_string(event.fmt),
+        fmt=expand_format_string(event.fmt, event.name + " "),
         args=event.args.rust_call_varargs())
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 12b826593db..746efd35fb9 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -41,7 +41,7 @@ def generate_h(event, group):
 def generate_rs(event, group):
     out('        let format_string = c"%(fmt)s";',
         '        unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, %(args)s);}',
-        fmt=expand_format_string(event.fmt),
+        fmt=expand_format_string(event.fmt, event.name + " "),
         args=event.args.rust_call_varargs())
 
 def generate_h_backend_dstate(event, group):
diff --git a/tests/tracetool/all.rs b/tests/tracetool/all.rs
index c8c9d288366..14afd86281e 100644
--- a/tests/tracetool/all.rs
+++ b/tests/tracetool/all.rs
@@ -47,7 +47,7 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 {
     ::trace::probe!(qemu, test_blah, _context, _filename.as_ptr());
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
-        let format_string = c"Blah context=%p filename=%s";
+        let format_string = c"test_blah Blah context=%p filename=%s";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
         let format_string = c"test_blah Blah context=%p filename=%s\n";
         if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
@@ -55,7 +55,7 @@ pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
         }
         extern "C" { fn _simple_trace_test_blah(_context: *mut (), _filename: *const std::ffi::c_char); }
         unsafe { _simple_trace_test_blah(_context, _filename.as_ptr()); }
-        let format_string = c"Blah context=%p filename=%s";
+        let format_string = c"test_blah Blah context=%p filename=%s";
         unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
     }
 }
@@ -75,7 +75,7 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
 {
     ::trace::probe!(qemu, test_wibble, _context, _value);
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
-        let format_string = c"Wibble context=%p value=%d";
+        let format_string = c"test_wibble Wibble context=%p value=%d";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
         let format_string = c"test_wibble Wibble context=%p value=%d\n";
         if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
@@ -83,7 +83,7 @@ pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
         }
         extern "C" { fn _simple_trace_test_wibble(_context: *mut (), _value: std::ffi::c_int); }
         unsafe { _simple_trace_test_wibble(_context, _value); }
-        let format_string = c"Wibble context=%p value=%d";
+        let format_string = c"test_wibble Wibble context=%p value=%d";
         unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
     }
 }
diff --git a/tests/tracetool/ftrace.rs b/tests/tracetool/ftrace.rs
index ff0bcde4b8b..39959d3fdd1 100644
--- a/tests/tracetool/ftrace.rs
+++ b/tests/tracetool/ftrace.rs
@@ -36,7 +36,7 @@ pub fn trace_test_blah_enabled() -> bool
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 {
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
-        let format_string = c"Blah context=%p filename=%s";
+        let format_string = c"test_blah Blah context=%p filename=%s";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
     }
 }
@@ -54,7 +54,7 @@ pub fn trace_test_wibble_enabled() -> bool
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
 {
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
-        let format_string = c"Wibble context=%p value=%d";
+        let format_string = c"test_wibble Wibble context=%p value=%d";
         unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
     }
 }
diff --git a/tests/tracetool/syslog.rs b/tests/tracetool/syslog.rs
index 9688dac84a5..b90ad4be7f4 100644
--- a/tests/tracetool/syslog.rs
+++ b/tests/tracetool/syslog.rs
@@ -36,7 +36,7 @@ pub fn trace_test_blah_enabled() -> bool
 pub fn trace_test_blah(_context: *mut (), _filename: &std::ffi::CStr)
 {
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
-        let format_string = c"Blah context=%p filename=%s";
+        let format_string = c"test_blah Blah context=%p filename=%s";
         unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
     }
 }
@@ -54,7 +54,7 @@ pub fn trace_test_wibble_enabled() -> bool
 pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
 {
     if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
-        let format_string = c"Wibble context=%p value=%d";
+        let format_string = c"test_wibble Wibble context=%p value=%d";
         unsafe {::trace::syslog(::trace::LOG_INFO, format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
     }
 }
-- 
2.56.0


