Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD20E77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd6S-00089V-Op; Mon, 09 Dec 2024 07:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1l-00046a-Hi
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1j-0007YS-Lu
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mka10JX4kza0QaAC8JzE3v6aWvEpjz7koPP+g4YXhzE=;
 b=YUSbc07wLSbhs0L1cX0t0yZJBz9J6afuRpGAI76wK6IiqDxehpqNplPiNjlspAA5EHGTEY
 2sC0OtusaWOEcTrfchaWkxveRvPzUCPXssTRXxKqr8D5O6gJpws+f27Bg47WlmW5ezfi02
 yAgnbK6ftem2nCJ0eFh2n005ymGyeLw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-mzZ2WhFzPeC38bb16QUb2Q-1; Mon, 09 Dec 2024 07:38:13 -0500
X-MC-Unique: mzZ2WhFzPeC38bb16QUb2Q-1
X-Mimecast-MFC-AGG-ID: mzZ2WhFzPeC38bb16QUb2Q
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-386333ea577so759670f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747892; x=1734352692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mka10JX4kza0QaAC8JzE3v6aWvEpjz7koPP+g4YXhzE=;
 b=NfaZ1wLk+vK7MIUOiFgBK7Pu1mA/TzHmgIamILDzLqV4myRTAOF8GXxO/a+VxwV+F9
 M13+ejEv269JnO6IKk3Yo9a6UKF6VeAkyEFXuw6XB/fZAsdgSD5FvPTf9HRjZ2DvaCmS
 Gvl+98W8/9/mRRDUqz3v89vg2cJg3cTZ/ro8rO0Db+UhQ3XoguiKYUfrmXvXxImDG/j8
 DBFZCthCnW+zMeel45HkABD1/RYgII2qR0KEv/Qvm+l5qXbcqjtADd5MEY08ITUyTgSU
 E9OcUgHjzc8X+bFLntR2sdMo0a3nwVyk4Kn4XuUHK+Yxy5e6HLunKzDd3immehjYFuM1
 CBeQ==
X-Gm-Message-State: AOJu0YwwckCpVOV132g+pE8HJgz2QxpA2yidAg1L4lXCfxEnB28jPUZe
 BXE6nv3oNdbg/6cQ+4KC8CchIFMjKKLLGuYuavYfngBUFuGdU5mAuPBlfTt8YvYUVFS6VbJaMdc
 T29RS1aFCXKU2PTJ7a+4MvLRBbGmGGqxeCsZtGduB6nwjhOkBrpdtKBJzh13ADSkVIACnavxLCi
 fiECjDT76bgcd/9KRZ1eqamCcezMplo3wJt9ER
X-Gm-Gg: ASbGncuOV0VqyBNHuM6fgHR4W8cdSaYtAxTzyHVEqX0OPXSk+/B4l07XVPy6jAZ8Lwn
 IcT6AoJqLYmVkjwqWqoYjZu3aZ2qnIJATWnb3PZ935PCo+lkxVHrSrsN//Wiqtpt2hJTMs7pRKa
 x/sT51XiU7OAo6zLDuQmwh5HmliV+8kGS8fVip0wMxt1qO+I4x24AcEZLWOMDyeUSJH+VWLeikY
 Rel/GrwS+ZKFgqFOe1EDw3dmqxnhbROxTMkleHkIc8mUfrm393WFQ==
X-Received: by 2002:a5d:59a3:0:b0:386:4034:f9a0 with SMTP id
 ffacd0b85a97d-386453fbb7bmr127788f8f.52.1733747891660; 
 Mon, 09 Dec 2024 04:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOnitS1ndfRTSOAjmo4Aa07KZ1CsUCHy4hN4mqjX15w2pubCe4lwMeORYD14VyBTeSTiuEMg==
X-Received: by 2002:a5d:59a3:0:b0:386:4034:f9a0 with SMTP id
 ffacd0b85a97d-386453fbb7bmr127766f8f.52.1733747891207; 
 Mon, 09 Dec 2024 04:38:11 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3863157fb80sm8858577f8f.19.2024.12.09.04.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 21/26] rust: tests: allow writing more than one test
Date: Mon,  9 Dec 2024 13:37:12 +0100
Message-ID: <20241209123717.99077-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/tests.rs | 109 ++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 48 deletions(-)

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 68557fb85c7..18738a80008 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::ffi::CStr;
+use std::{cell::Cell, ffi::CStr, sync::Mutex};
 
 use qemu_api::{
     bindings::*,
@@ -14,55 +14,68 @@
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


