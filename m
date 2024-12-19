Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5DAE7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJGx-0004jo-TM; Thu, 19 Dec 2024 11:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOGta-000732-Om
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOGtZ-0000yU-7k
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 08:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734616132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b8X5LSjSBtqJTtR/RvJgszEpGhBtRYXHObYm/N1R5ek=;
 b=aG+MX7sJGjy2PLwk63VYxTUf839apJ6Bj4pKkp6ROW4U5fHSD7mQzSvfsP3L0uE9jny+hb
 d8VDKCFE8ML4Vndc2qIQs7PmCPN0iaIz9EdAm6iHT+s7dR0VaFFkXaknBI1Bq1lNrIVbWh
 2fzJtKbnSb2C49IekDXczqC8Bov7sa8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-kVW0cuoENuSubvPDxTJf_Q-1; Thu, 19 Dec 2024 08:48:51 -0500
X-MC-Unique: kVW0cuoENuSubvPDxTJf_Q-1
X-Mimecast-MFC-AGG-ID: kVW0cuoENuSubvPDxTJf_Q
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361eb83f46so6741255e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 05:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734616129; x=1735220929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8X5LSjSBtqJTtR/RvJgszEpGhBtRYXHObYm/N1R5ek=;
 b=MRw/oPAImdR7WgFAa3/cChUMxKHVPwWnbJe0QKo5JljEo06QhUGGhgJoukThasB+AG
 HB+egiesCj92wVxXS9feLdQFPOHmzNWpNEyBiPDkarW784OPJ2ARWamor7pqKk1moT0X
 DkGdlKw1tQlVJtwPFtVp+JXeJLiMBnhojAQYIzOAcG33fqMtvL/Up8+Oi5VVhOuYsLjb
 I18AK+HGidufJKLThYK3mIKweUyVulfcsswYUuT32kIgcPzT9I1Uh2+uRw1xS6BjY0DH
 58NK+nYTZ9KAOaPeEM4D+5f/ruxZTZraezplhJoFpMowOxbQD++/a7gYDlTzNhcOrkAv
 3czA==
X-Gm-Message-State: AOJu0YzgdscVyG6Br6djQrGN7fHJFvc0l+qyTYW2wP1gjafV9XnZAgnP
 3lhyo7RwSlNR/D05/SXHvX+/ghYc/tAMjfZDuPJeDZMwEZgmGLFCqz8kn91DV576VTFHQM7Kpv8
 mb4/rgM2bXsfTPX/EPYejYuYPui/JOBvdw25V1ZjTvEs9OfFqXt+7pzfRa0lzJevzcfRVjkNmmR
 SMt6po7wiAeiFuPtnAWWkAf7QiPb5eykvYrn8n
X-Gm-Gg: ASbGncuNzAyl/r36UU98v24LmoWsbvYKFfD8+ZxBOB3yugehRE4Oe/4NiPYxO6yd8RT
 CkJIpwQ4PUrgKrkWfuJe7hOLYvxyBFlrEK+mPcDj+CDHg9B8/cDTS9jpu4vMo0NwP7OJzGwrjdC
 i0BjUaxdoGoQ2tSJ5+O5LOVQM7IPT1dxpYZx44CMZ9wCp6QvP38UKQXuTz9hy8Wiukv2SZObcXH
 Tq3piS9OFVxwjYUXckB074UVT7ksfqU64hHuL6ptHqvze75Xlu84CXkGVye
X-Received: by 2002:a05:6000:4a0e:b0:385:fc70:7eb with SMTP id
 ffacd0b85a97d-388e4d311e8mr6489673f8f.12.1734616129523; 
 Thu, 19 Dec 2024 05:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcZhSRX3qITHRvqYShHelgbBLPEdillmFV8HI1U4MBSWtynLsmMq7SRbYkADJ+k+52Rsv/ug==
X-Received: by 2002:a05:6000:4a0e:b0:385:fc70:7eb with SMTP id
 ffacd0b85a97d-388e4d311e8mr6489654f8f.12.1734616129109; 
 Thu, 19 Dec 2024 05:48:49 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c493sm18338905e9.28.2024.12.19.05.48.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 05:48:46 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/42] rust: tests: allow writing more than one test
Date: Thu, 19 Dec 2024 14:48:43 +0100
Message-ID: <20241219134843.443085-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219134843.443085-1-pbonzini@redhat.com>
References: <20241219134843.443085-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/tests.rs | 111 ++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 48 deletions(-)

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 68557fb85c7..dc0ed190192 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -6,7 +6,9 @@
 
 use qemu_api::{
     bindings::*,
-    c_str, declare_properties, define_property,
+    c_str,
+    cell::{self, BqlCell},
+    declare_properties, define_property,
     prelude::*,
     qdev::{DeviceImpl, DeviceState, Property},
     qom::ObjectImpl,
@@ -14,55 +16,68 @@
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
+    static ONCE: BqlCell<bool> = BqlCell::new(false);
+
+    cell::bql_start_test();
+    if !ONCE.get() {
+        unsafe {
+            module_call_init(module_init_type::MODULE_INIT_QOM);
+        }
+        ONCE.set(true);
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


