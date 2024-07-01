Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D4AC3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIVN-00046Z-Fl; Mon, 01 Jul 2024 10:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVL-00045A-ER
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIVF-0005NO-P6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6tUQLMOUhCwh40f/djXK9f9MtwQXr/0BnjScvVQiDg=;
 b=BZP9CGBNzbz2UhvtSwaNrkKRnyxJuGzBHPd1LbXfC2ACOP7l9xzQtxgx7OAfiZXLOdbeM7
 eJKtgK+LaVypiu7sHRz4ahb6osFH+zMQ6UzmCWiik/X5oHItIjHBIQGwlxxNVVdSi1wPnB
 RURMK7MEp1lAgqmXPxcEu9lBXJBs94Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-pPjkiIKAOgKSLHsSNLI_5A-1; Mon, 01 Jul 2024 10:59:34 -0400
X-MC-Unique: pPjkiIKAOgKSLHsSNLI_5A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-36725ec0f7dso1789636f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845972; x=1720450772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6tUQLMOUhCwh40f/djXK9f9MtwQXr/0BnjScvVQiDg=;
 b=aF+tJXeLA/vCbGeePaSJ6jm9aqyJG32b+aL1DFTJWABcPA6p1bgSFX5TwhgpePiEJM
 ywYecaqmH4HDqIvzyUV/lgifoOWUlsBCi3yLCT9mSwMP2q2ey/1/tGPp+Ai/yJqBgw1G
 iMdrMHt1eR9fhKg9dTcMnlEyWjgTZz3sd/8/JUft2XxBeBZCes4Piafm2f78yzx9u4mQ
 MLRXZIwE4B/BVqvS4XjBjvYGg4aqH4wkMYyzxTwmxVq+ZCHvuKTcuyq9Gy2nEwf92jnq
 NF2VuXkQkY697ttSeUh1R7AxjZD+pFsf04yBj1PlX1jiwyxaF9aO902neQBnFRFDN3i6
 Y5hA==
X-Gm-Message-State: AOJu0Yw9hnKw2QeTTr7BLgWRpn1CpjB/HShhiHvLsfT5PTJdc7wXEDe0
 bcUxKx0FZZSh1ngOdG3I8q0dl2C0rIMRSDDuiFaZdYvtDhA0hYgW6QR/3mIbdZDXqagtb+2y13v
 WSyzEeWQFxeZx6u3xfRJtIvtuDopuMVUJN0xdSeLQAQNDZqmj9Z9nss01NME1ndLsi1MN5lDDlM
 OGAucJLWanXV86RL68E5g0QCSiGoU1A98lYebe
X-Received: by 2002:a05:6000:cc1:b0:35f:1f28:2ec9 with SMTP id
 ffacd0b85a97d-367757309b3mr4591235f8f.70.1719845972471; 
 Mon, 01 Jul 2024 07:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUs8iJiZlS9gIYM6LIQ8vGya0LH7I8sevS5ByHUq2hKrw+Xtip4wuC3ch865IK6PTZOxjwVQ==
X-Received: by 2002:a05:6000:cc1:b0:35f:1f28:2ec9 with SMTP id
 ffacd0b85a97d-367757309b3mr4591205f8f.70.1719845972000; 
 Mon, 01 Jul 2024 07:59:32 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1412sm10232820f8f.53.2024.07.01.07.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 12/14] rust: replace c"" literals with cstr crate
Date: Mon,  1 Jul 2024 16:58:44 +0200
Message-ID: <20240701145853.1394967-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Part of what's needed to work with Rust versions prior to 1.77.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu/Cargo.toml            |  3 +++
 qemu/qom-rust.txt          |  2 +-
 qemu/src/hw/core/device.rs |  4 +++-
 qemu/src/qom/object.rs     |  4 +++-
 qemu/src/util/error.rs     |  4 +++-
 qemu/src/util/foreign.rs   | 20 +++++++++++---------
 qemu/tests/main.rs         |  7 ++++---
 8 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/qemu/Cargo.toml b/qemu/Cargo.toml
index 1100725..a07a449 100644
--- a/qemu/Cargo.toml
+++ b/qemu/Cargo.toml
@@ -7,5 +7,8 @@ edition = "2021"
 const-default = { version = "~1", features = ["derive"] }
 libc = "^0"
 
+# pick older version in order to support Rust 1.63
+cstr = { version = "=0.2.10" }
+
 [dev-dependencies]
 matches = ">=0"
diff --git a/qemu/qom-rust.txt b/qemu/qom-rust.txt
index 1588445..ef4bd06 100644
--- a/qemu/qom-rust.txt
+++ b/qemu/qom-rust.txt
@@ -48,7 +48,7 @@ Bindings for C classes
 struct must implement ObjectType
 
     unsafe impl ObjectType for Object {
-        const TYPE: &'static CStr = c"object";
+        const TYPE: &'static CStr = cstr!("object");
     }
 
 struct must implement IsA<T> for all superclasses T
diff --git a/qemu/src/hw/core/device.rs b/qemu/src/hw/core/device.rs
index 294251e..4edf61d 100644
--- a/qemu/src/hw/core/device.rs
+++ b/qemu/src/hw/core/device.rs
@@ -17,12 +17,14 @@ use crate::qom_isa;
 
 use crate::Result;
 
+use cstr::cstr;
+
 use std::ffi::CStr;
 use std::ops::Deref;
 use std::ptr::null_mut;
 
 unsafe impl ObjectType for DeviceState {
-    const TYPE: &'static CStr = c"device";
+    const TYPE: &'static CStr = cstr!("device");
 }
 
 qom_isa!(DeviceState, Object);
diff --git a/qemu/src/qom/object.rs b/qemu/src/qom/object.rs
index 4e84e29..9f6c078 100644
--- a/qemu/src/qom/object.rs
+++ b/qemu/src/qom/object.rs
@@ -7,6 +7,8 @@ use std::ffi::CStr;
 use std::fmt;
 use std::ops::Deref;
 
+use cstr::cstr;
+
 use crate::bindings::object_get_typename;
 use crate::bindings::object_property_add_child;
 use crate::bindings::object_new;
@@ -42,7 +44,7 @@ pub unsafe trait ObjectType: Sized {
 }
 
 unsafe impl ObjectType for Object {
-    const TYPE: &'static CStr = c"object";
+    const TYPE: &'static CStr = cstr!("object");
 }
 
 // ------------------------------
diff --git a/qemu/src/util/error.rs b/qemu/src/util/error.rs
index e7e6f2e..79c3c81 100644
--- a/qemu/src/util/error.rs
+++ b/qemu/src/util/error.rs
@@ -7,6 +7,8 @@ use crate::bindings::error_free;
 use crate::bindings::error_get_pretty;
 use crate::bindings::error_setg_internal;
 
+use cstr::cstr;
+
 use std::ffi::CStr;
 use std::fmt::{self, Display};
 use std::ptr;
@@ -215,7 +217,7 @@ impl CloneToForeign for Error {
                 ptr::null_mut(), // FIXME
                 0,
                 ptr::null_mut(), // FIXME
-                c"%s".as_ptr(),
+                cstr!("%s").as_ptr(),
                 format!("{}", self),
             );
             OwnedPointer::new(x)
diff --git a/qemu/src/util/foreign.rs b/qemu/src/util/foreign.rs
index 464400a..7a663cc 100644
--- a/qemu/src/util/foreign.rs
+++ b/qemu/src/util/foreign.rs
@@ -167,7 +167,8 @@ pub trait FromForeign: CloneToForeign + Sized {
     ///
     /// ```
     /// # use qemu::FromForeign;
-    /// let p = c"Hello, world!".as_ptr();
+    /// # use cstr::cstr;
+    /// let p = cstr!("Hello, world!").as_ptr();
     /// let s = unsafe {
     ///     String::cloned_from_foreign(p as *const libc::c_char)
     /// };
@@ -476,6 +477,7 @@ mod tests {
     #![allow(clippy::shadow_unrelated)]
 
     use super::*;
+    use cstr::cstr;
     use matches::assert_matches;
     use std::ffi::c_void;
 
@@ -498,7 +500,7 @@ mod tests {
     #[test]
     fn test_cloned_from_foreign_string_cow() {
         let s = "Hello, world!".to_string();
-        let cstr = c"Hello, world!";
+        let cstr = cstr!("Hello, world!");
         let cloned = unsafe { Cow::cloned_from_foreign(cstr.as_ptr()) };
         assert_eq!(s, cloned);
     }
@@ -506,7 +508,7 @@ mod tests {
     #[test]
     fn test_cloned_from_foreign_string() {
         let s = "Hello, world!".to_string();
-        let cstr = c"Hello, world!";
+        let cstr = cstr!("Hello, world!");
         let cloned = unsafe { String::cloned_from_foreign(cstr.as_ptr()) };
         assert_eq!(s, cloned);
     }
@@ -570,7 +572,7 @@ mod tests {
     #[test]
     fn test_clone_to_foreign_str() {
         let s = "Hello, world!";
-        let p = c"Hello, world!".as_ptr();
+        let p = cstr!("Hello, world!").as_ptr();
         let cloned = s.clone_to_foreign();
         unsafe {
             let len = libc::strlen(cloned.as_ptr());
@@ -588,7 +590,7 @@ mod tests {
 
     #[test]
     fn test_clone_to_foreign_cstr() {
-        let s: &CStr = c"Hello, world!";
+        let s: &CStr = cstr!("Hello, world!");
         let cloned = s.clone_to_foreign();
         unsafe {
             let len = libc::strlen(cloned.as_ptr());
@@ -606,7 +608,7 @@ mod tests {
 
     #[test]
     fn test_clone_to_foreign_string_cow() {
-        let p = c"Hello, world!".as_ptr();
+        let p = cstr!("Hello, world!").as_ptr();
         for s in vec![
             Into::<Cow<str>>::into("Hello, world!"),
             Into::<Cow<str>>::into("Hello, world!".to_string())] {
@@ -663,7 +665,7 @@ mod tests {
     #[test]
     fn test_clone_to_foreign_string() {
         let s = "Hello, world!".to_string();
-        let cstr = c"Hello, world!";
+        let cstr = cstr!("Hello, world!");
         let cloned = s.clone_to_foreign();
         unsafe {
             let len = libc::strlen(cloned.as_ptr());
@@ -683,7 +685,7 @@ mod tests {
     fn test_option() {
         // An Option can be used to produce or convert NULL pointers
         let s = Some("Hello, world!".to_string());
-        let cstr = c"Hello, world!";
+        let cstr = cstr!("Hello, world!");
         unsafe {
             assert_eq!(Option::<String>::cloned_from_foreign(cstr.as_ptr()), s);
             assert_matches!(Option::<String>::cloned_from_foreign(ptr::null()), None);
@@ -695,7 +697,7 @@ mod tests {
     fn test_box() {
         // A box can be produced if the inner type has the capability.
         let s = Box::new("Hello, world!".to_string());
-        let cstr = c"Hello, world!";
+        let cstr = cstr!("Hello, world!");
         let cloned = unsafe { Box::<String>::cloned_from_foreign(cstr.as_ptr()) };
         assert_eq!(s, cloned);
 
diff --git a/qemu/tests/main.rs b/qemu/tests/main.rs
index e499c14..601e92b 100644
--- a/qemu/tests/main.rs
+++ b/qemu/tests/main.rs
@@ -1,4 +1,5 @@
 use const_default::ConstDefault;
+use cstr::cstr;
 
 use qemu::qom_define_type;
 use qemu::Object;
@@ -27,7 +28,7 @@ struct TestState {
 }
 
 qom_define_type!(
-    c"test-object",
+    cstr!("test-object"),
     TestObject,
     TestConf,
     ();
@@ -37,12 +38,12 @@ qom_define_type!(
 impl ObjectImpl for TestObject {}
 
 qdev_define_type!(
-    c"test-device",
+    cstr!("test-device"),
     TestDevice,
     TestConf,
     RefCell<TestState>;
     @extends DeviceState;
-    @properties [qdev_prop!(bool, c"foo", TestDevice, true, foo)]
+    @properties [qdev_prop!(bool, cstr!("foo"), TestDevice, true, foo)]
 );
 
 impl TestDevice {
-- 
2.45.2


