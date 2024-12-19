Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A5AE77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 09:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tODED-0007p0-8l; Thu, 19 Dec 2024 04:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tODEB-0007op-SN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:53:55 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tODE9-00063y-Rm
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 04:53:55 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so707265a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 01:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734602031; x=1735206831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFfTaV5Kh0kifjTmwNZn7DxAiv8scTOj/bxUG58PHRU=;
 b=d+ER1JnwOfb+7NrUIllgYSnxMtqLtkidy2JqYEyBkAGZ26IhobuUVUST3+lMzJ0vks
 wd80XKS+WNObKXiHaLDCOxFJrUw+pEn4z9S3WAGbvAw042ed7+6+JsziEdWCUwhXybyx
 WXyTZBpCr13UQzlefUJB9kVhfwWGgtF70A4guHNQ5mW5ZXSxpNDLlwn+raIl5dS3OfZ0
 7PzOQZhJQfG40m/ZsF13pHQj8P3OkRW4qq3NU43sHjmRzfwRJ+53A+cVwDg1MRS0rT/5
 wsV0uVj8MF8AzVXpSx1l1So9odapauEXR/XQj0AzQ4NQPyCQNUmMhqD+rvR2ZQ8TE4/o
 TOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734602031; x=1735206831;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XFfTaV5Kh0kifjTmwNZn7DxAiv8scTOj/bxUG58PHRU=;
 b=civ2A6QptNpy/qSfIrzVdAqsnrplaa4QTN0pIUTYBg8oNnhhN/bPebBB2wSKCcOQ5V
 xOZlv+Kkzit2G4AiuBDbdcNtMndyB0vPDRGythyZAh7uu9C9XwE/Sj4vTaRnCrTvZzz9
 wK17qymqrmVQnIPZn8/2/cmpgW6g0ttjeI0P+0PEixb9FzrTbmQ1iNdk/zweus3JkVNk
 02jv8aPsGEvsmJLkHUNHXEQrKuxNCVM0TO9JXHekJb3V/gb74+La47XRwnYqIKs+OtMt
 NGQ/XPP1rC52//U4zfjuNkp8276TfTnefMdkuRtrK8KUfsMq5SVUi4/2JZ7gfxqq2bbA
 Ks2w==
X-Gm-Message-State: AOJu0Yw8FHJB7vRsM10P1FXCA2GpTnHoCaa0HbTN5hDH5jQHXB+X90oJ
 sIgqhFCpCTr1Oqr1NkDwC0dESvdLnwB3IKllfhkQxLpShYJZM1xUKy2D2g==
X-Gm-Gg: ASbGncupLaqFyZyiZ44NFqYvzIft1xsf8f/jy4/axEVIAflsh8Kr3c4Mr3JSHpadF52
 BobkhNEvkKbidRt17MhlLsV+FHLT1H2HNuf/pSOkrFY4MjY/ivUdGSpFcCEA15LYLWpUrNklgl2
 khMF/CDguQyUhKzrWJ5vqTO+C6KNoiI3LPOwp4TtiasooFfWD81m+YOLgJeFMmgimyFK3+8Rb9E
 3OEe6To8CeVFy6AyQY5I1bgBrgJu0BwZUyhClvJzQZBN7RVBTmsBPxOQONlSHLyrVFW3HzxvC+u
 hE+PWcXSmELaV+MKag5gqkP8zBhlJ1k=
X-Google-Smtp-Source: AGHT+IGeF4foTLi6Ke1TEd3LJ32Njp//LITptEp6K3+Uk95k0jSg8G7mMNBGefzo1IQYJyd3eHYTaQ==
X-Received: by 2002:a05:6402:2790:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5d7ee3c857emr5916701a12.8.1734602030378; 
 Thu, 19 Dec 2024 01:53:50 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-191-068-081.77.191.pool.telefonica.de.
 [77.191.68.81]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80679f128sm472720a12.44.2024.12.19.01.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 01:53:49 -0800 (PST)
Date: Thu, 19 Dec 2024 09:53:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PULL 12/40] rust: build integration test for the qemu_api crate
In-Reply-To: <20241104172721.180255-13-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
 <20241104172721.180255-13-pbonzini@redhat.com>
Message-ID: <A90FCF2F-C8D9-49B7-A881-B0F849AC11A0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 4=2E November 2024 17:26:51 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>Adjust the integration test to compile with a subset of QEMU object
>files, and make it actually create an object of the class it defines=2E
>
>Follow the Rust filesystem conventions, where tests go in tests/ if
>they use the library in the same way any other code would=2E
>
>Reviewed-by: Junjie Mao <junjie=2Emao@hotmail=2Ecom>
>Reviewed-by: Kevin Wolf <kwolf@redhat=2Ecom>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> meson=2Ebuild                  | 10 ++++-
> rust/qemu-api/meson=2Ebuild    | 26 ++++++++++--
> rust/qemu-api/src/lib=2Ers     |  3 --
> rust/qemu-api/src/tests=2Ers   | 49 ----------------------
> rust/qemu-api/tests/tests=2Ers | 78 ++++++++++++++++++++++++++++++++++++
> 5 files changed, 110 insertions(+), 56 deletions(-)
> delete mode 100644 rust/qemu-api/src/tests=2Ers
> create mode 100644 rust/qemu-api/tests/tests=2Ers

When `--enable-modules` is passed to configure, this patch results in nume=
rous undefined symbols=2E

Best regards,
Bernhard

>
>diff --git a/meson=2Ebuild b/meson=2Ebuild
>index 34328f7394c=2E=2Ed360120b233 100644
>--- a/meson=2Ebuild
>+++ b/meson=2Ebuild
>@@ -3340,7 +3340,15 @@ if have_rust and have_system
>=20
>   # Prohibit code that is forbidden in Rust 2024
>   rustc_args +=3D ['-D', 'unsafe_op_in_unsafe_fn']
>-  add_project_arguments(rustc_args, native: false, language: 'rust')
>+
>+  # Apart from procedural macros, our Rust executables will often link
>+  # with C code, so include all the libraries that C code needs=2E  This
>+  # is safe; https://github=2Ecom/rust-lang/rust/pull/54675 says that
>+  # passing -nodefaultlibs to the linker "was more ideological to
>+  # start with than anything"=2E
>+  add_project_arguments(rustc_args + ['-C', 'default-linker-libraries'],
>+      native: false, language: 'rust')
>+
>   add_project_arguments(rustc_args, native: true, language: 'rust')
> endif
>=20
>diff --git a/rust/qemu-api/meson=2Ebuild b/rust/qemu-api/meson=2Ebuild
>index 42ea815fa5a=2E=2E1fc36078027 100644
>--- a/rust/qemu-api/meson=2Ebuild
>+++ b/rust/qemu-api/meson=2Ebuild
>@@ -14,11 +14,31 @@ _qemu_api_rs =3D static_library(
>     '--cfg', 'MESON',
>     # '--cfg', 'feature=3D"allocator"',
>   ],
>-  dependencies: [
>-    qemu_api_macros,
>-  ],
> )
>=20
> qemu_api =3D declare_dependency(
>   link_with: _qemu_api_rs,
>+  dependencies: qemu_api_macros,
> )
>+
>+# Rust executables do not support objects, so add an intermediate step=
=2E
>+rust_qemu_api_objs =3D static_library(
>+    'rust_qemu_api_objs',
>+    objects: [libqom=2Eextract_all_objects(recursive: false),
>+              libhwcore=2Eextract_all_objects(recursive: false)])
>+
>+test('rust-qemu-api-integration',
>+    executable(
>+        'rust-qemu-api-integration',
>+        'tests/tests=2Ers',
>+        override_options: ['rust_std=3D2021', 'build=2Erust_std=3D2021']=
,
>+        rust_args: ['--test'],
>+        install: false,
>+        dependencies: [qemu_api, qemu_api_macros],
>+        link_whole: [rust_qemu_api_objs, libqemuutil]),
>+    args: [
>+        '--test',
>+        '--format', 'pretty',
>+    ],
>+    protocol: 'rust',
>+    suite: ['unit', 'rust'])
>diff --git a/rust/qemu-api/src/lib=2Ers b/rust/qemu-api/src/lib=2Ers
>index e72fb4b4bb1=2E=2E6bc68076aae 100644
>--- a/rust/qemu-api/src/lib=2Ers
>+++ b/rust/qemu-api/src/lib=2Ers
>@@ -30,9 +30,6 @@ unsafe impl Sync for bindings::VMStateDescription {}
> pub mod definitions;
> pub mod device_class;
>=20
>-#[cfg(test)]
>-mod tests;
>-
> use std::alloc::{GlobalAlloc, Layout};
>=20
> #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
>diff --git a/rust/qemu-api/src/tests=2Ers b/rust/qemu-api/src/tests=2Ers
>deleted file mode 100644
>index df54edbd4e2=2E=2E00000000000
>--- a/rust/qemu-api/src/tests=2Ers
>+++ /dev/null
>@@ -1,49 +0,0 @@
>-// Copyright 2024, Linaro Limited
>-// Author(s): Manos Pitsidianakis <manos=2Epitsidianakis@linaro=2Eorg>
>-// SPDX-License-Identifier: GPL-2=2E0-or-later
>-
>-use crate::{
>-    bindings::*, declare_properties, define_property, device_class_init,=
 vm_state_description,
>-};
>-
>-#[test]
>-fn test_device_decl_macros() {
>-    // Test that macros can compile=2E
>-    vm_state_description! {
>-        VMSTATE,
>-        name: c"name",
>-        unmigratable: true,
>-    }
>-
>-    #[repr(C)]
>-    pub struct DummyState {
>-        pub char_backend: CharBackend,
>-        pub migrate_clock: bool,
>-    }
>-
>-    declare_properties! {
>-        DUMMY_PROPERTIES,
>-            define_property!(
>-                c"chardev",
>-                DummyState,
>-                char_backend,
>-                unsafe { &qdev_prop_chr },
>-                CharBackend
>-            ),
>-            define_property!(
>-                c"migrate-clk",
>-                DummyState,
>-                migrate_clock,
>-                unsafe { &qdev_prop_bool },
>-                bool
>-            ),
>-    }
>-
>-    device_class_init! {
>-        dummy_class_init,
>-        props =3D> DUMMY_PROPERTIES,
>-        realize_fn =3D> None,
>-        reset_fn =3D> None,
>-        vmsd =3D> VMSTATE,
>-    }
>-}
>diff --git a/rust/qemu-api/tests/tests=2Ers b/rust/qemu-api/tests/tests=
=2Ers
>new file mode 100644
>index 00000000000=2E=2Eaa1e0568c69
>--- /dev/null
>+++ b/rust/qemu-api/tests/tests=2Ers
>@@ -0,0 +1,78 @@
>+// Copyright 2024, Linaro Limited
>+// Author(s): Manos Pitsidianakis <manos=2Epitsidianakis@linaro=2Eorg>
>+// SPDX-License-Identifier: GPL-2=2E0-or-later
>+
>+use core::ffi::CStr;
>+
>+use qemu_api::{
>+    bindings::*,
>+    declare_properties, define_property,
>+    definitions::{Class, ObjectImpl},
>+    device_class_init, vm_state_description,
>+};
>+
>+#[test]
>+fn test_device_decl_macros() {
>+    // Test that macros can compile=2E
>+    vm_state_description! {
>+        VMSTATE,
>+        name: c"name",
>+        unmigratable: true,
>+    }
>+
>+    #[repr(C)]
>+    #[derive(qemu_api_macros::Object)]
>+    pub struct DummyState {
>+        pub _parent: DeviceState,
>+        pub migrate_clock: bool,
>+    }
>+
>+    #[repr(C)]
>+    pub struct DummyClass {
>+        pub _parent: DeviceClass,
>+    }
>+
>+    declare_properties! {
>+        DUMMY_PROPERTIES,
>+            define_property!(
>+                c"migrate-clk",
>+                DummyState,
>+                migrate_clock,
>+                unsafe { &qdev_prop_bool },
>+                bool
>+            ),
>+    }
>+
>+    device_class_init! {
>+        dummy_class_init,
>+        props =3D> DUMMY_PROPERTIES,
>+        realize_fn =3D> None,
>+        legacy_reset_fn =3D> None,
>+        vmsd =3D> VMSTATE,
>+    }
>+
>+    impl ObjectImpl for DummyState {
>+        type Class =3D DummyClass;
>+        const TYPE_INFO: qemu_api::bindings::TypeInfo =3D qemu_api::type=
_info! { Self };
>+        const TYPE_NAME: &'static CStr =3D c"dummy";
>+        const PARENT_TYPE_NAME: Option<&'static CStr> =3D Some(TYPE_DEVI=
CE);
>+        const ABSTRACT: bool =3D false;
>+        const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Objec=
t)> =3D None;
>+        const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut =
Object)> =3D None;
>+        const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut O=
bject)> =3D None;
>+    }
>+
>+    impl Class for DummyClass {
>+        const CLASS_INIT: Option<
>+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut cor=
e::ffi::c_void),
>+        > =3D Some(dummy_class_init);
>+        const CLASS_BASE_INIT: Option<
>+            unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut cor=
e::ffi::c_void),
>+        > =3D None;
>+    }
>+
>+    unsafe {
>+        module_call_init(module_init_type::MODULE_INIT_QOM);
>+        object_unref(object_new(DummyState::TYPE_NAME=2Eas_ptr()) as *mu=
t _);
>+    }
>+}

