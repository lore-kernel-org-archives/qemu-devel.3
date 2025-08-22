Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6441ACA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQsK-0005EG-HB; Fri, 22 Aug 2025 08:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrt-0004w4-Ta
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrq-0002RX-QH
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLvY7T3qsFX5eHyIEjlzP7ZM0g6YBeoAiFTuVz2Nylg=;
 b=R2XDlxL4QthOucpSXPrNIDmPQ5tP53J+yxU+AQQI9qPD9JhmbhgRUEeGlAfIM4/BRFHB6X
 kF78PSTYLqwi7gNm9uiRT3WS/1QV+qgOHB2+e7PXJu5NkDih/AplfQZqACoX+uBc3z6F7G
 MSxmiyYcDKZbkyxidWZPKoIv7fo77Vo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Q3TWNpscMfGtRk8HYjB4Ag-1; Fri, 22 Aug 2025 08:27:36 -0400
X-MC-Unique: Q3TWNpscMfGtRk8HYjB4Ag-1
X-Mimecast-MFC-AGG-ID: Q3TWNpscMfGtRk8HYjB4Ag_1755865655
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b9edf41d07so987423f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865652; x=1756470452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GLvY7T3qsFX5eHyIEjlzP7ZM0g6YBeoAiFTuVz2Nylg=;
 b=fFgT+fzStz6QQXzec7AzTPBuUrsknh2K70HTusJ7VK+BcUtlY97HN7LVP+FxUJDyMB
 5Di+Hw+v/swuVMXITXOsjMVcj+RqcADBDesxX6taM97G42PwkcfMhKdOMYpLYPKP1qJ3
 cAKZBjKv6hAXeakn9x/3gvXgu0l+Kd75qw0fuZsodaBUTTHKfZ38/4EFZ6iLJgptRDqM
 rUoA8WEmFw/QwfrjyDnBmDdoBV+VRxPryBK+1PJD4cIjR9be1PfvQ4ffbL6i/9vDItSL
 lIeOJ7QnM2QA6ooilocubERqioqkP76V3yLDps5HUQ9x5nyn9f9vhbOJI0gFU+LoPDrq
 shFA==
X-Gm-Message-State: AOJu0Yz/AjERXeK1hS/q4+CuigmM17yxB+z0EXYUUxbp+graO+pvR0cx
 Kl44mFNxyrst/ym1DPU4NeqTGktAwgES3DH29W3Qy6o/llI8Sak2YLWfHAX3D4jL3ticbW7qnSo
 MW/kKQ5vvAuazX9mPfWO8GkUjTJQNAzrGOy+fYutl4rFp/jhxBgzSjWHHcFFVEwXGsRBiTXm/X4
 tF+PwtnndlUPoggydXbMjMRa7Qm3Nu3F9vtwesE0Qu
X-Gm-Gg: ASbGncuL9FRMUiKtkQXliLtvL76C1LwrZSs622FZzA+lZXauc0gC9k4mnCZZXhDeam+
 U5xWYIf/I9cTiLcvsMQMUYy+xMD6f9IonnMVsl4vN5zjgN8wyydsMlMOY3HKGG90hpWjWDrUl7F
 jPcZWyfT76i76j8WYVAGPSoVZ4xF0sooQaTZvxYt904t4vkqs5murRPplA9HyUPMK6KGK0nXtHb
 IWPJxLb/ASPCzMEqWq7jVzueUZ32nmhtzQXj24oNgjWldoT+locq+sJ8PeV30IyPA+RVvSzPtWq
 JFpOfjQZZlhi5JUJ6QcpkFJYK4YLvPdZAm30e/t5LMYRh+ey1XJV+b0hoXJm6O7LA32v2Wgd6bT
 6w/gFdT3e/IUiHU7EaVU1IKj+zN5Ztce18Sf0s3bCoA==
X-Received: by 2002:a5d:64ed:0:b0:3b9:16ac:4f8b with SMTP id
 ffacd0b85a97d-3c5dcc0da2bmr1812705f8f.50.1755865652374; 
 Fri, 22 Aug 2025 05:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFh48/j6UvcQ/doO9lHqH5jiYggnUSJqTOvXNNW4jAyr0YLknHh2qQX1MFV31IVzKZnUfjMLQ==
X-Received: by 2002:a5d:64ed:0:b0:3b9:16ac:4f8b with SMTP id
 ffacd0b85a97d-3c5dcc0da2bmr1812679f8f.50.1755865651795; 
 Fri, 22 Aug 2025 05:27:31 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077c56454sm15434073f8f.58.2025.08.22.05.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 13/14] tracetool/ftrace: add Rust support
Date: Fri, 22 Aug 2025 14:26:54 +0200
Message-ID: <20250822122655.1353197-14-pbonzini@redhat.com>
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
 rust/qemu-api/wrapper.h             |  1 +
 scripts/tracetool/backend/ftrace.py |  8 +++++-
 tests/tracetool/ftrace.rs           | 41 +++++++++++++++++++++++++++++
 tests/tracetool/tracetool-test.py   |  2 +-
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100644 tests/tracetool/ftrace.rs

diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 15a1b19847f..5227838292b 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -69,3 +69,4 @@ typedef enum memory_order {
 #include "qemu/timer.h"
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
+#include "trace/ftrace.h"
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 432f216ea2b..51d978f998f 100644
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
index 00000000000..950a89534af
--- /dev/null
+++ b/tests/tracetool/ftrace.rs
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
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context, _filename.as_ptr());}
+    }
+}
+
+#[inline(always)]
+#[allow(dead_code)]
+pub fn trace_test_wibble(_context: *mut (), _value: std::ffi::c_int)
+{
+    if trace_event_get_state_dynamic_by_id(unsafe { _TRACE_TEST_WIBBLE_DSTATE}) {
+        let format_string = c"Wibble context=%p value=%d";
+        unsafe {bindings::ftrace_write(format_string.as_ptr() as *const c_char, _context, _value);}
+    }
+}
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 5e5b16e2856..a91d635910a 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -13,7 +13,7 @@ def get_formats(backend):
         "c",
         "h",
     ]
-    if backend in {"log", "simple"}:
+    if backend in {"ftrace", "log", "simple"}:
         formats += ["rs"]
     if backend == "dtrace":
         formats += [
-- 
2.50.1


