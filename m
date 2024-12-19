Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5C2E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByY-0005ua-Bv; Thu, 19 Dec 2024 03:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByW-0005mW-PH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByU-0005ER-K4
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xXzIAGpMzwTX5L3Xd5O8YYQJQmvdCw1SJPAzF30pYo=;
 b=ck7R0nX6fQ42uqslUjt5YfOXx1Q1LAZzCbQcbItpROiLcdsqKXwhDEvlRwwe6efPAkd922
 p3THqhH+x2Mm+c1cIqqT/E/M+zdw8tEhnrhYrzd2xWYLbTVLAjik8ZCGj76/OfoxG2ibt6
 CFrJDLa85oi/XStW82Jecrtbcq+2oWI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-uH0nzUK8M8K5PoCZXLFsxw-1; Thu, 19 Dec 2024 03:33:35 -0500
X-MC-Unique: uH0nzUK8M8K5PoCZXLFsxw-1
X-Mimecast-MFC-AGG-ID: uH0nzUK8M8K5PoCZXLFsxw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3862be3bfc9so348917f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597213; x=1735202013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+xXzIAGpMzwTX5L3Xd5O8YYQJQmvdCw1SJPAzF30pYo=;
 b=iCLC10IoJwgJQxtJuu4QoL1qEDe/MuW+8hdi/2baYQbzhdYwJFJuABTkuTba6rpYza
 sVvbe2JfFU+lyETFJJINqODC116oSSC/uhmZLMwdtkSH5ItZelQbEDUxgYUraRE9/xP2
 Yv23WlDrQBBqO/p7G9Wnga/Pz+/kMzvtVs85uSo4MN/5iqesfIpletymzv8bTGB+pFLe
 cnE4k8moapYgDhZocWt5V0C3p1IYjv4+FrDHwXQ4f8BWsOikZsZCmuEeiN9lxgHQdoSe
 TqEcZbWqpGQNreakOTHbqmXqZeHHy+U1jten5fszFuWVal36BiRBkGIXqDiuV/a6HyH6
 jeug==
X-Gm-Message-State: AOJu0Yyx77qMzkMRiAm7KSUQUx0+8mgwymjHX71EQWVxpbPaH5fB3+x3
 9dEq1JCi+d3/376aPkmt51OlyVdFnnHGm+kF7jQH7Hc04WswDth+b6iOeNFKfL6ZUB8FvDv/v6W
 hn/UeySggYONtcMWqytKQi3PGXqfDhqbz+BJulOUKgp1Itb3tAXFg+HvVq4+z8qUHqsFQX/eArC
 QTZ7DZ2HdcUP8bK6cVFZEFyljWV3lojdelXYDY
X-Gm-Gg: ASbGncs4c8m6ODstYUMo2/BNZPFJyDE0CBnde9vlKtBSdJjQ097DqEPT5VppU4NTGKa
 T0qeXK3mwe3Tp7uRjbD9cs6JqUq3tmKyjaOvBnpm5itF6tN6Q+Huo2laib8ey68a4vyFpU/jMc0
 9/Sfhg85olHAixiDYat1+XgKWk0eBxHRfAHhz4h9llS2vvRgFT1bJi5n19O2We/ZlcTAA9a3lMz
 STmR+Foq936xTlXVPMLmvXU/zjfk4kcLAFOnyqScKtRQAFzSST9ILFyex8v
X-Received: by 2002:a5d:47cf:0:b0:385:d852:29ed with SMTP id
 ffacd0b85a97d-388e4d8e083mr5137242f8f.36.1734597213038; 
 Thu, 19 Dec 2024 00:33:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHapKmpVr0C+lCqozoqQNf3FxXQeibCMK1ky1BND1hEDI9XpgIToHEEj/Ar2Q0WqoLriYZmuw==
X-Received: by 2002:a5d:47cf:0:b0:385:d852:29ed with SMTP id
 ffacd0b85a97d-388e4d8e083mr5137209f8f.36.1734597212541; 
 Thu, 19 Dec 2024 00:33:32 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008bcsm11157875e9.16.2024.12.19.00.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 29/41] rust: tests: allow writing more than one test
Date: Thu, 19 Dec 2024 09:32:16 +0100
Message-ID: <20241219083228.363430-30-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/tests.rs | 115 ++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 48 deletions(-)

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 68557fb85c7..953cb15975b 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ffi::CStr;
+use std::{cell::Cell, ffi::CStr, sync::Mutex};
 
 use qemu_api::{
     bindings::*,
@@ -14,55 +14,74 @@
     zeroable::Zeroable,
 };
 
+// Test that macros can compile.
+pub static VMSTATE: VMStateDescription = VMStateDescription {
+    name: c_str!("name").as_ptr(),
+    unmigratable: true,
+    ..Zeroable::ZERO
+};
+
+#[derive(qemu_api_macros::offsets)]
+#[repr(C)]
+#[derive(qemu_api_macros::Object)]
+pub struct DummyState {
+    parent: DeviceState,
+    migrate_clock: bool,
+}
+
+declare_properties! {
+    DUMMY_PROPERTIES,
+        define_property!(
+            c_str!("migrate-clk"),
+            DummyState,
+            migrate_clock,
+            unsafe { &qdev_prop_bool },
+            bool
+        ),
+}
+
+unsafe impl ObjectType for DummyState {
+    type Class = <DeviceState as ObjectType>::Class;
+    const TYPE_NAME: &'static CStr = c_str!("dummy");
+}
+
+impl ObjectImpl for DummyState {
+    type ParentType = DeviceState;
+    const ABSTRACT: bool = false;
+}
+
+impl DeviceImpl for DummyState {
+    fn properties() -> &'static [Property] {
+        &DUMMY_PROPERTIES
+    }
+    fn vmsd() -> Option<&'static VMStateDescription> {
+        Some(&VMSTATE)
+    }
+}
+
+fn init_qom() {
+    // Tests can run in parallel; currently they do not need the
+    // Big QEMU Lock, so use an independent mutex (LazyLock is
+    // not available until Rust 1.80.0) to serialize calls to
+    // `type_register()`.  If the tests start needing the BQL,
+    // bql_lock()/bql_unlock() can be wrapped in a similar way
+    // to `Mutex<>` and this can be changed to use a BqlCell.
+    static ONCE: Mutex<Cell<bool>> = Mutex::new(Cell::new(false));
+
+    let g = ONCE.lock().unwrap();
+    if !g.get() {
+        unsafe {
+            module_call_init(module_init_type::MODULE_INIT_QOM);
+        }
+        g.set(true);
+    }
+}
+
 #[test]
-fn test_device_decl_macros() {
-    // Test that macros can compile.
-    pub static VMSTATE: VMStateDescription = VMStateDescription {
-        name: c_str!("name").as_ptr(),
-        unmigratable: true,
-        ..Zeroable::ZERO
-    };
-
-    #[derive(qemu_api_macros::offsets)]
-    #[repr(C)]
-    #[derive(qemu_api_macros::Object)]
-    pub struct DummyState {
-        pub _parent: DeviceState,
-        pub migrate_clock: bool,
-    }
-
-    declare_properties! {
-        DUMMY_PROPERTIES,
-            define_property!(
-                c_str!("migrate-clk"),
-                DummyState,
-                migrate_clock,
-                unsafe { &qdev_prop_bool },
-                bool
-            ),
-    }
-
-    unsafe impl ObjectType for DummyState {
-        type Class = <DeviceState as ObjectType>::Class;
-        const TYPE_NAME: &'static CStr = c_str!("dummy");
-    }
-
-    impl ObjectImpl for DummyState {
-        type ParentType = DeviceState;
-        const ABSTRACT: bool = false;
-    }
-
-    impl DeviceImpl for DummyState {
-        fn properties() -> &'static [Property] {
-            &DUMMY_PROPERTIES
-        }
-        fn vmsd() -> Option<&'static VMStateDescription> {
-            Some(&VMSTATE)
-        }
-    }
-
+/// Create and immediately drop an instance.
+fn test_object_new() {
+    init_qom();
     unsafe {
-        module_call_init(module_init_type::MODULE_INIT_QOM);
         object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
     }
 }
-- 
2.47.1


