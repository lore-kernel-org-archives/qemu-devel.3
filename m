Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D65CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQsL-0005Gl-6i; Fri, 22 Aug 2025 08:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQru-0004w5-0p
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrm-0002RJ-Si
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/7mtm3oVuWK0/bAEbRoJQJxidr1NimhpHH+OXpqbtw=;
 b=DUfc8IlhaX0oh7pWDSM15ARUkscxURB9oRLDqe87DWajXC1xMpMLgilX3Vmk81dnQkRubU
 qRFVrFCYboqrIFk1SfApHd9WCagV+ivvNQX1J2k73bXZOcK4CZ3XyfGDlWIb53gTh37lUm
 ejzMC7qHV5hGYh96K4plmQafJ7NMQSY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-FYAAfaYGO6akvBM-1Tr4Vw-1; Fri, 22 Aug 2025 08:27:31 -0400
X-MC-Unique: FYAAfaYGO6akvBM-1Tr4Vw-1
X-Mimecast-MFC-AGG-ID: FYAAfaYGO6akvBM-1Tr4Vw_1755865650
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45a1b0cfbafso11902215e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865650; x=1756470450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/7mtm3oVuWK0/bAEbRoJQJxidr1NimhpHH+OXpqbtw=;
 b=JW1nWMEQmXtBhMYm/+0sRQC8s8jVHFh8ffaV5ViKQZnqRQexCPtXWBB+UhCRSy5q9d
 otNh8xZluAGvrufU1Xbj0xP77W/X3i6rjXAB8ORCtEtYfnraz3KDBJksdW2tybGT7i5m
 3gYAjOf9p30GqnwEBDf/L2xTJfndn7kUAa8dRfdIllSRUNAnC0Q5PxHcPNlgHo63ypzx
 2FSIBds4Jth8Y/42O4UJ3rsPGMPoqvQmgT1W18yqhGdaVEh751XkUWUmglTBiK/pR3T2
 ZuOUKkhULfGICju6FiQdTVgR7T8TPsPWiKGQb8vwMbaZelggbZX7DNTVguM3cvlRTwhK
 Kqwg==
X-Gm-Message-State: AOJu0YyTsXikfZ/uiyNVV7EFNA3HyDWW/NIHu+dMgHEDwBBTmEKolxyc
 g3ojyxw/fZEKjxjfPsExb+zt7Pqp9mJ6QI3HPgLoSXEc05Nj6etF5DsLS7PDJvBwuiDb/unFf2x
 Z8mAOGiPQX+Q0hHncGPgUsES8qv+mlE8f2vfPRlST33OO1ZGOaec0cVdyk3PvsEWBHiZNoXv3FI
 SoOjIq2H6qwjSxNxXrYNQMKEETEkfnvvfmYJshN1po
X-Gm-Gg: ASbGnctWU83BW4aT8z3qqNfgWUSEIlR4KGnT1yRK+ZW1HAumRVHgAcSTSRHc3fWD1tS
 LgBGrCXh85trlH36kR3JZurEDDJKl5sZsdNAUVWRQbd8T0cse0n7sbmdnEuaLJSTin5uU2BixXS
 KoYnuqSwn/LnecJrcURCvy9FXuGjNzL+dMTA0FV5EtdIIqpjYT1zeq8ju+ymPuD8a+9G4m3Rh7a
 7nf+Y9i0r+FXd85+QUZyowDzHcL+1j9mfbsktwadP9N5osI4muo4+8EkbDjhiuH/5PsATkx6pLO
 Z0zulVjWbw3NnCZjDw0tLlu9lvYWe2r1k5ZEUP4oPLSc0SrKt1wFaD3tgCioDILkvzMmAvYrWPW
 f1eFVjSIyMH5OKsKSKL5dzW13uihvA8SqmAvITfRsWQ==
X-Received: by 2002:a05:600c:4715:b0:456:1923:7549 with SMTP id
 5b1f17b1804b1-45b517d294dmr21278825e9.26.1755865649890; 
 Fri, 22 Aug 2025 05:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU7A19ydCpL2O+lkkgt0SsGbTeiqI/mzkK+rzUtkhPUYTGPWIN/7e+Jq90QazMrP+E5hPGwA==
X-Received: by 2002:a05:600c:4715:b0:456:1923:7549 with SMTP id
 5b1f17b1804b1-45b517d294dmr21278555e9.26.1755865649351; 
 Fri, 22 Aug 2025 05:27:29 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c61843c8fcsm2150715f8f.22.2025.08.22.05.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 12/14] tracetool/log: add Rust support
Date: Fri, 22 Aug 2025 14:26:53 +0200
Message-ID: <20250822122655.1353197-13-pbonzini@redhat.com>
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

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/log.py  | 10 ++++++-
 tests/tracetool/log.rs            | 45 +++++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py |  2 +-
 3 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/log.rs

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 2aa180f4b47..c167f30cf2c 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -12,7 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
+from tracetool import out, expand_format_string
 
 
 PUBLIC = True
@@ -44,3 +44,11 @@ def generate_h(event, group):
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
         event_id="TRACE_" + event.name.upper())
+
+def generate_rs(event, group):
+    out('        let format_string = c"%(fmt)s\\n";',
+        '        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {',
+        '            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, %(args)s);}',
+        '        }',
+        fmt=expand_format_string(event.fmt, event.name + " "),
+        args=event.args.rust_call_varargs())
diff --git a/tests/tracetool/log.rs b/tests/tracetool/log.rs
new file mode 100644
index 00000000000..fc95adafa46
--- /dev/null
+++ b/tests/tracetool/log.rs
@@ -0,0 +1,45 @@
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
+        let format_string = c"test_blah Blah context=%p filename=%s\n";
+        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
+            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context, _filename.as_ptr());}
+        }
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"test_wibble Wibble context=%p value=%d\n";
+        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
+            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context, _value);}
+        }
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index ad7dd667288..5e5b16e2856 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -13,7 +13,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"simple"}:
+    if backend in {"log", "simple"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.50.1


