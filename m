Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B53CAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLLq-0006UL-1G; Sat, 13 Sep 2025 04:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLW-00063Y-Rf
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLU-000530-Ok
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6HNlQI5AiN279T+74BTEF8oyAoPxNzfUhPnWZT1q4I=;
 b=KzWuw9MA+ZL0zahzKTV1QKxoleqJ0+Xxwrx7uI+5ZbE2A4Z8E9dDttQTU/hV0T0mdwMLkZ
 hO99FbXgFkDk8MVGaHKmy38RkvkbpFDe2oOoYweEDyc3oRXuv5rbTmvxV4D/RI1qjmmMl3
 7CWV+4wO2j/98XBVEqG60onjtF9DuU4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-JRsJk89kO5KTi3RCrKEcyA-1; Sat, 13 Sep 2025 04:10:54 -0400
X-MC-Unique: JRsJk89kO5KTi3RCrKEcyA-1
X-Mimecast-MFC-AGG-ID: JRsJk89kO5KTi3RCrKEcyA_1757751053
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e4a8e6df10so1737308f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751052; x=1758355852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6HNlQI5AiN279T+74BTEF8oyAoPxNzfUhPnWZT1q4I=;
 b=dzJJkuiRvOoayyG2LB6fipJoiLo4MMI0EOg0l8rBM/qtBHjZJXMctm9C4dOKhNaR9R
 sPLKHz++hiy2kgceMMjgPXZgwVYqyDiu3WZ6TKzA7TCYHqTEhnNIrJNJTUhDX82pOmzT
 OV989mYrjdNhWwctJt933nQvFWvNkp79iJhc7Mdg48xc+/pVYxwsYl8oDRsOCXq0OT2O
 HcPg272oKv6vTkaT15BJs+CxMSv1E5+EFl+HzMOcuOHgHG9YcvfJCMuBndPH9lqQX4DK
 zjO7sYyr1Ag/whST4ZKkITo5IY7ZvYL9GyK915UnECHt0ZVa8ZvoI6qrpNGwvsJF07ym
 c9DQ==
X-Gm-Message-State: AOJu0Yyl9BX2sOuS93EtF3JE1keXk5tJdysmWcWjepBGC2xFautXBGJu
 DRcJDAVbf4CZLJO+1/uvtt+ujGOTvNF3uP9jWgv35TrLJUsJo5jLz+eTt1i/audvFUMUqacyi8T
 U0s0ofQXxUMC5PTPqFihod7YmLIHKhnJIiOcqqR6KanaaPtKFqmdJgCp8Smol5TZ5oDU/aHQffd
 rVQk5yHX7Y3z6xihhrKcwP/Wy39KxmnsI40pYR8jL/
X-Gm-Gg: ASbGncuwwTHPj1DC0eWswPIX7LCK9MnuQlUC/iOAFsJ46dFl7y+bDiDMkqkbM9WxgDT
 YkTVC7fvRCpSriNbm5HP5NECfWmE/mdn1NgoEIw8oQvlBEARCquFXIyvzItyjMFyZSEYqz9yaqR
 w7FT3nz27r8tDXT3MkZTMjsA9I61Iuq07zv+x70HdwX46i7rA3jmTQuz8gwU1CRO0NWdS5H6L2/
 Mx+MhMjUGeQRipPZPw05RyBxn2A+13km2UUiThaFq04s8gFLGSTrjhM9cdN5Y74OpOlqYZMKwVm
 6nypeHLaNwkaF5IFEBTl4dXCNcLSdhWZk4GhiefnncsJVLVDOS+2uHhaFxKn/Y2KLxNdVnKlD0O
 xx41Sfvc7ojwEnMOUY/JKZ6SCut/dRAkv/dy4/2JNS3o=
X-Received: by 2002:a05:6000:186a:b0:3e7:44f9:131f with SMTP id
 ffacd0b85a97d-3e76578138dmr5229416f8f.1.1757751051736; 
 Sat, 13 Sep 2025 01:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGajTSr9MN2qO8SWZw4w3/iUMWI4rK8/oSHgOy1tN3aiOyTSdJPB6TYwj8zhP0iGw6iX44Z4g==
X-Received: by 2002:a05:6000:186a:b0:3e7:44f9:131f with SMTP id
 ffacd0b85a97d-3e76578138dmr5229384f8f.1.1757751051201; 
 Sat, 13 Sep 2025 01:10:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0157619fsm93000915e9.7.2025.09.13.01.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 23/61] rust: add missing const markers for MSRV==1.83.0
Date: Sat, 13 Sep 2025 10:09:04 +0200
Message-ID: <20250913080943.11710-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Rust 1.83 allows more functions to be marked const.
Fix clippy with bumped minimum supported Rust version.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-5-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bits/src/lib.rs            | 6 +++---
 rust/qemu-api/src/assertions.rs | 4 ++--
 rust/qemu-api/src/cell.rs       | 6 ++----
 rust/qemu-api/src/qom.rs        | 6 +++---
 rust/qemu-api/src/timer.rs      | 2 +-
 rust/qemu-api/src/uninit.rs     | 6 +++---
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/rust/bits/src/lib.rs b/rust/bits/src/lib.rs
index d485d6bd110..e9d15ad0cb5 100644
--- a/rust/bits/src/lib.rs
+++ b/rust/bits/src/lib.rs
@@ -165,19 +165,19 @@ pub const fn into_bits(self) -> $type {
 
             #[allow(dead_code)]
             #[inline(always)]
-            pub fn set(&mut self, rhs: Self) {
+            pub const fn set(&mut self, rhs: Self) {
                 self.0 |= rhs.0;
             }
 
             #[allow(dead_code)]
             #[inline(always)]
-            pub fn clear(&mut self, rhs: Self) {
+            pub const fn clear(&mut self, rhs: Self) {
                 self.0 &= !rhs.0;
             }
 
             #[allow(dead_code)]
             #[inline(always)]
-            pub fn toggle(&mut self, rhs: Self) {
+            pub const fn toggle(&mut self, rhs: Self) {
                 self.0 ^= rhs.0;
             }
 
diff --git a/rust/qemu-api/src/assertions.rs b/rust/qemu-api/src/assertions.rs
index a2d38c877df..e74fa3ef826 100644
--- a/rust/qemu-api/src/assertions.rs
+++ b/rust/qemu-api/src/assertions.rs
@@ -81,8 +81,8 @@ macro_rules! assert_field_type {
     (@internal $param_name:ident, $ti:ty, $t:ty, $($field:tt)*) => {
         const _: () = {
             #[allow(unused)]
-            fn assert_field_type($param_name: &$t) {
-                fn types_must_be_equal<T, U>(_: &T)
+            const fn assert_field_type($param_name: &$t) {
+                const fn types_must_be_equal<T, U>(_: &T)
                 where
                     T: $crate::assertions::EqType<Itself = U>,
                 {
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 27063b049d5..148a13e3f56 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -980,8 +980,7 @@ pub unsafe fn from_raw<'a>(ptr: *mut T) -> &'a Self {
     /// but the functions containing the dereference are usually safe.  The
     /// value returned from `uninit()` must be initialized and pinned before
     /// calling them.
-    #[allow(clippy::missing_const_for_fn)]
-    pub unsafe fn uninit() -> Self {
+    pub const unsafe fn uninit() -> Self {
         Self {
             value: UnsafeCell::new(MaybeUninit::uninit()),
             _pin: PhantomPinned,
@@ -997,8 +996,7 @@ pub unsafe fn uninit() -> Self {
     /// but the functions containing the dereference are usually safe.  The
     /// value returned from `uninit()` must be pinned (and possibly initialized)
     /// before calling them.
-    #[allow(clippy::missing_const_for_fn)]
-    pub unsafe fn zeroed() -> Self {
+    pub const unsafe fn zeroed() -> Self {
         Self {
             value: UnsafeCell::new(MaybeUninit::zeroed()),
             _pin: PhantomPinned,
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index e20ee014cb1..014ffb1fd88 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -307,7 +307,7 @@ impl<T: ObjectType> ParentInit<'_, T> {
     /// Fields beyond `Object` could be uninitialized and it's your
     /// responsibility to avoid that they're used when the pointer is
     /// dereferenced, either directly or through a cast.
-    pub fn as_object_mut_ptr(&self) -> *mut bindings::Object {
+    pub const fn as_object_mut_ptr(&self) -> *mut bindings::Object {
         self.as_object_ptr().cast_mut()
     }
 
@@ -318,7 +318,7 @@ pub fn as_object_mut_ptr(&self) -> *mut bindings::Object {
     /// Fields beyond `Object` could be uninitialized and it's your
     /// responsibility to avoid that they're used when the pointer is
     /// dereferenced, either directly or through a cast.
-    pub fn as_object_ptr(&self) -> *const bindings::Object {
+    pub const fn as_object_ptr(&self) -> *const bindings::Object {
         self.0.as_ptr().cast()
     }
 }
@@ -336,7 +336,7 @@ impl<'a, T: ObjectImpl> ParentInit<'a, T> {
     /// However, while the fields of the resulting reference are initialized,
     /// calls might use uninitialized fields of the subclass.  It is your
     /// responsibility to avoid this.
-    pub unsafe fn upcast<U: ObjectType>(&self) -> &'a U
+    pub const unsafe fn upcast<U: ObjectType>(&self) -> &'a U
     where
         T::ParentType: IsA<U>,
     {
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 0a2d111d490..0daec62f926 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -39,7 +39,7 @@ impl Timer {
     ///
     /// The timer must be initialized before it is armed with
     /// [`modify`](Self::modify).
-    pub unsafe fn new() -> Self {
+    pub const unsafe fn new() -> Self {
         // SAFETY: requirements relayed to callers of Timer::new
         Self(unsafe { Opaque::zeroed() })
     }
diff --git a/rust/qemu-api/src/uninit.rs b/rust/qemu-api/src/uninit.rs
index 04123b4ae99..b0a829729dd 100644
--- a/rust/qemu-api/src/uninit.rs
+++ b/rust/qemu-api/src/uninit.rs
@@ -12,7 +12,7 @@ pub struct MaybeUninitField<'a, T, U> {
 
 impl<'a, T, U> MaybeUninitField<'a, T, U> {
     #[doc(hidden)]
-    pub fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
+    pub const fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
         MaybeUninitField { parent, child }
     }
 
@@ -21,7 +21,7 @@ pub fn new(parent: &'a mut MaybeUninit<T>, child: *mut U) -> Self {
     /// Because the `MaybeUninitField` remembers the containing object,
     /// it is possible to use it in foreign APIs that initialize the
     /// child.
-    pub fn parent(f: &Self) -> *const T {
+    pub const fn parent(f: &Self) -> *const T {
         f.parent.as_ptr()
     }
 
@@ -30,7 +30,7 @@ pub fn parent(f: &Self) -> *const T {
     /// Because the `MaybeUninitField` remembers the containing object,
     /// it is possible to use it in foreign APIs that initialize the
     /// child.
-    pub fn parent_mut(f: &mut Self) -> *mut T {
+    pub const fn parent_mut(f: &mut Self) -> *mut T {
         f.parent.as_mut_ptr()
     }
 }
-- 
2.51.0


