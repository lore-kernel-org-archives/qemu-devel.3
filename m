Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDD6CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9s-0001fJ-Hd; Mon, 29 Sep 2025 11:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G9K-000176-Kz
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G90-0000dj-ID
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9GYQ8eEdZA3tbr0keGWSnhudVKZWc4SsvK01A1ENzrU=;
 b=cKvyFLiP85Wt3Yj02VqbNEjd83EIGIxSefK2re6F2G+JPqUPreC0MwxpXgvJjVO7uzgnuU
 ygRZt4bYqc6qhOx/VL4YKDLuSdKnDO/Km+OOrvl6wXx/esKwO4X62Xg2weQvtfEzZzvY93
 OrOj57TaXACzIcF1h44U4d2TOhR9BTU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ujVji9P7PheVY-z3EEF4IQ-1; Mon, 29 Sep 2025 11:50:19 -0400
X-MC-Unique: ujVji9P7PheVY-z3EEF4IQ-1
X-Mimecast-MFC-AGG-ID: ujVji9P7PheVY-z3EEF4IQ_1759161018
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so480206066b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161017; x=1759765817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GYQ8eEdZA3tbr0keGWSnhudVKZWc4SsvK01A1ENzrU=;
 b=D3oujhmZY9ffJRZ1NuKNISLnmFbOE5dErYo306sGi6O6Scw9So97LSJB07FBXMZ0Ry
 d3HHkYyvLyzlQxrqO6k46+qmy3z66Ri36XEas1Dcm6goGpvRWp5K0wPXup1L/7i6jv10
 rIyEYWis8Zix49KKfmVBv63IHJePu/YKZlUpF0a8kKt+ySYuA0icoZXHkUQg+qJV9Bb4
 iG0zOUBk/dJxvayTDG1sNPGedREHB6hv6va//sE3S5aL8bjLYbukHO7gLhOqZ1HtOIQ+
 J31a4u4cW9yxUrL+PTQpC2skiBHPy8izDdH4N0uX/5vXd2KForo4Vflq6pz9LKB/lntu
 vT2g==
X-Gm-Message-State: AOJu0Ywk9T7TbB1YIUH4aoifyCg/G+HXzfn2RwWmV7WgnaXTWXRYQEP4
 LYi5YRp3/01t+ypBk/UxqUa72kmEp+DH9r09Qsu7o7eEig0PpfGvHtajDURG2TlGlS2MntW3I8p
 bZwL+yOMSN9M3m2mT0vDFqLXTFIg9yH/24GYKokLt3TGdT5amQKk677FtwlyZtI4C4ED/BCcZmq
 XvNxJXGEhKgofi/s4s3hnMRtOrAJlh1TWy2+2VXaz+
X-Gm-Gg: ASbGncu98phGbG4LNAxhqBP73XnlmSqUasrV5llZ0uaLnSEspY+B36NFNI/Q8lAe2Xh
 kqzFgzFQFN1/hbobvMOWXCw2QUsjKekYoiDCE52u5mioq1EsDS0EsgyzhHUhWU1XyYPcvFVnXAl
 eoISAMwA7a4dJh48ZA3mvFAU1ooSeCUlH4GdQzeduKu/dd+Pr8gCLhcMbgM/nTzVS+NC+aAyewE
 cVUd4sLtwk4a/jMozCW/ZqAWeXHa4rqIPUwwOgYVAag66H8eptSALB2f7u1ACtFWoeq6+nqyP+V
 PW79lN/yYJyjExUoHIE9GjEezzJrLlBx37JC6gI1w+5ThyXgwlqW02I9kOmFpI7aQ+HcXqEeP7K
 bGdXCOY8k35H700Pv7f5hS1s3ctPicceSWcWBVzXFPiSe8A==
X-Received: by 2002:a17:907:9494:b0:b3f:8210:d058 with SMTP id
 a640c23a62f3a-b3f8210d6bamr324478666b.37.1759161017227; 
 Mon, 29 Sep 2025 08:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdYEjaCvSDFIaMxE5ywPrLH9+IhfvYIPh4smT+bhmTliwyzfQx5/GrMLOLd3rFiV+cGgZF2A==
X-Received: by 2002:a17:907:9494:b0:b3f:8210:d058 with SMTP id
 a640c23a62f3a-b3f8210d6bamr324475466b.37.1759161016708; 
 Mon, 29 Sep 2025 08:50:16 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b4054f0cae4sm122361666b.39.2025.09.29.08.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org
Subject: [PATCH 14/16] tracetool/log: add Rust support
Date: Mon, 29 Sep 2025 17:49:36 +0200
Message-ID: <20250929154938.594389-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Tanish Desai <tanishdesai37@gmail.com>

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/log.py  | 10 ++++++-
 tests/tracetool/log.rs            | 44 +++++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py |  2 +-
 3 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/log.rs

diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index d01d234289f..9e3e5046f5f 100644
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
index 00000000000..c191895c8f8
--- /dev/null
+++ b/tests/tracetool/log.rs
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// This file is @generated by tracetool, do not edit.
+
+#[allow(unused_imports)]
+use std::ffi::c_char;
+#[allow(unused_imports)]
+use util::bindings;
+
+#[inline(always)]
+fn trace_event_state_is_enabled(dstate: u16) -> bool {
+    (unsafe { trace_events_enabled_count }) != 0 && dstate != 0
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
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_BLAH_DSTATE}) {
+        let format_string = c"test_blah Blah context=%p filename=%s\n";
+        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
+            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _filename.as_ptr());}
+        }
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_state_is_enabled(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"test_wibble Wibble context=%p value=%d\n";
+        if (unsafe { bindings::qemu_loglevel } & bindings::LOG_TRACE) != 0 {
+            unsafe { bindings::qemu_log(format_string.as_ptr() as *const c_char, _context /* as *mut () */, _value /* as std::ffi::c_int */);}
+        }
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 3e37890476d..f58f3b795e7 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -14,7 +14,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"simple"}:
+    if backend in {"log", "simple"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.51.0


