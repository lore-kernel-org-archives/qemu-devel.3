Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F2FE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByk-0006mj-TO; Thu, 19 Dec 2024 03:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByg-0006X1-8J
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBya-0005FB-04
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0DmIjvH8PGHsDKbo/jlvryd2McqZ2wVPERdSF97HVM=;
 b=SuDGtt8Q12KTK7vUX0i9KqUokxokSX3+UWV67TJKPOrCqobWXK20Xa1GzSi06inOMuxL8J
 4xd3DwwChhJqyehMrQMFPqU3orWSi62idC3UL99SUjboNCHn8EU5E6sOzuwh9HLwkDoLIJ
 Fk1t+YdrDAnbJMsVGV8SO0dCWMWO2Os=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-KQm1mt0nOIeYRAL4xGzAxw-1; Thu, 19 Dec 2024 03:33:41 -0500
X-MC-Unique: KQm1mt0nOIeYRAL4xGzAxw-1
X-Mimecast-MFC-AGG-ID: KQm1mt0nOIeYRAL4xGzAxw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43619b135bcso2940315e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597218; x=1735202018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G0DmIjvH8PGHsDKbo/jlvryd2McqZ2wVPERdSF97HVM=;
 b=el+FDxI71biWB6Dp15sUi35A+UJ7wucHo7XnHOFNdtKTxRxcSmfa49aAbZVIhyfFJ4
 iSaVPz1fNRfGDzGTfCoH5Go18S+cGGCtFf3Y9As5ssq8lG/aOSLRIODcmre6ffML2tZP
 QniOY0KbmrC38EUEWRyb1+AJHcuXo7MMQb5sXjscke2QR9HZ0pvW45QofRo/FcGoJ3a6
 RS7aaWc61UcfNVp++6HZAPEsnBm739yj1Ie+TtC8CaEEofGtC2p05tYyeJPPVlzi53Xw
 ZQ3nBKewfFasvBdZL/bFW+t4V6K6cgva1fJGOrNyExx5LqDSgbXi2m8OGew3s7GrcNPm
 e85w==
X-Gm-Message-State: AOJu0Yw2eq4BZ14IKy2JgaNnFADaKrlWpajrAOdqxrirzrls5iIi9B4x
 vDS3Q9jb3Xjles00khKVt5Lp1fdmtI3PMGy6vszr17xH3QFXhnchSPoafV/NM1pUXINLAIFLtDX
 jK5cebhdUTYDLrcW2IoV6lNhh0bnGaoTfugzN8No9lsuqEn0i0S4xMRlVQTfKzPxCY22JvdpsWC
 WbamAVeNSQmaawuAukxxjR7FzR+yr8YJP3+YyC
X-Gm-Gg: ASbGncsysGEICSEWlrJsYyVpQ1yx1WjhCHMpbljc57SEz1v1aJbqJNUTnnqTJU+hW6L
 LqmcEJrEm+j1fPUyI0QOrvTERilhYeHIaGuAcnVESM2oqsjbN4Q5sNcigLdzX49XbJ4TLufF8yr
 d5ivgW6/7rhDlR7Mbe9qYkpqbM584pYhpCFlQVmJVDmKpQ3Rf1WErjqOef8nwsdGpVDEm7V4TdR
 B3Lxr958GwAX3fZ9HVEWpIIHgrSvN2lSgHfLE+8x70L9D7ZL88Y6RrIlYkE
X-Received: by 2002:a05:600c:4f92:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4365536f5f6mr56976165e9.17.1734597218045; 
 Thu, 19 Dec 2024 00:33:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk6APoaMosiqZ+Y16u4ivz/C53JaiMHSnjZYz1DEpsgZhu5IksThkYqnLaMYqpoHsnjSTMCA==
X-Received: by 2002:a05:600c:4f92:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4365536f5f6mr56975795e9.17.1734597217569; 
 Thu, 19 Dec 2024 00:33:37 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea4a7sm11194365e9.3.2024.12.19.00.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 32/41] rust: qemu-api: add a module to wrap functions and
 zero-sized closures
Date: Thu, 19 Dec 2024 09:32:19 +0100
Message-ID: <20241219083228.363430-33-pbonzini@redhat.com>
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

One recurring issue when writing Rust bindings is how to convert a Rust
function ("fn" or "impl Fn") to a C function, and how to pass around
"self" to a C function that only takes a void*.

An easy solution would be to store on the heap a pair consisting of
a pointer to the Rust function and the pointer to "self", but it is
possible to do better.  If an "Fn" has zero size (that is, if it is a
zero-capture closures or a function pointer---which in turn includes all
methods), it is possible to build a generic Rust function that calls it
even if you only have the type; you don't need either the pointer to the
function itself (because the address of the code is part of the type)
or any closure data (because it has size zero).

Introduce a wrapper that provides the functionality of calling the
function given only its type.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build      |   1 +
 rust/qemu-api/src/callbacks.rs | 144 +++++++++++++++++++++++++++++++++
 rust/qemu-api/src/lib.rs       |   1 +
 3 files changed, 146 insertions(+)
 create mode 100644 rust/qemu-api/src/callbacks.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 7ff408ad68e..8c82c5e96c2 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -17,6 +17,7 @@ _qemu_api_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/bitops.rs',
+      'src/callbacks.rs',
       'src/cell.rs',
       'src/c_str.rs',
       'src/irq.rs',
diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
new file mode 100644
index 00000000000..314f9dce962
--- /dev/null
+++ b/rust/qemu-api/src/callbacks.rs
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: MIT
+
+//! Utility functions to deal with callbacks from C to Rust.
+
+use std::{mem, ptr::NonNull};
+
+/// Trait for functions (types implementing [`Fn`]) that can be used as
+/// callbacks. These include both zero-capture closures and function pointers.
+///
+/// In Rust, calling a function through the `Fn` trait normally requires a
+/// `self` parameter, even though for zero-sized functions (including function
+/// pointers) the type itself contains all necessary information to call the
+/// function. This trait provides a `call` function that doesn't require `self`,
+/// allowing zero-sized functions to be called using only their type.
+///
+/// This enables zero-sized functions to be passed entirely through generic
+/// parameters and resolved at compile-time. A typical use is a function
+/// receiving an unused parameter of generic type `F` and calling it via
+/// `F::call` or passing it to another function via `func::<F>`.
+///
+/// QEMU uses this trick to create wrappers to C callbacks.  The wrappers
+/// are needed to convert an opaque `*mut c_void` into a Rust reference,
+/// but they only have a single opaque that they can use.  The `FnCall`
+/// trait makes it possible to use that opaque for `self` or any other
+/// reference:
+///
+/// ```ignore
+/// // The compiler creates a new `rust_bh_cb` wrapper for each function
+/// // passed to `qemu_bh_schedule_oneshot` below.
+/// unsafe extern "C" fn rust_bh_cb<T, F: for<'a> FnCall<(&'a T,)>>(
+///     opaque: *mut c_void,
+/// ) {
+///     // SAFETY: the opaque was passed as a reference to `T`.
+///     F::call((unsafe { &*(opaque.cast::<T>()) }, ))
+/// }
+///
+/// // The `_f` parameter is unused but it helps the compiler build the appropriate `F`.
+/// // Using a reference allows usage in const context.
+/// fn qemu_bh_schedule_oneshot<T, F: for<'a> FnCall<(&'a T,)>>(_f: &F, opaque: &T) {
+///     let cb: unsafe extern "C" fn(*mut c_void) = rust_bh_cb::<T, F>;
+///     unsafe {
+///         bindings::qemu_bh_schedule_oneshot(cb, opaque as *const T as *const c_void as *mut c_void)
+///     }
+/// }
+/// ```
+///
+/// Each wrapper is a separate instance of `rust_bh_cb` and is therefore
+/// compiled to a separate function ("monomorphization").  If you wanted
+/// to pass `self` as the opaque value, the generic parameters would be
+/// `rust_bh_cb::<Self, F>`.
+///
+/// `Args` is a tuple type whose types are the arguments of the function,
+/// while `R` is the returned type.
+///
+/// # Examples
+///
+/// ```
+/// # use qemu_api::callbacks::FnCall;
+/// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+///     F::call((s,))
+/// }
+///
+/// let s: String = call_it(&str::to_owned, "hello world");
+/// assert_eq!(s, "hello world");
+/// ```
+///
+/// Note that the compiler will produce a different version of `call_it` for
+/// each function that is passed to it.  Therefore the argument is not really
+/// used, except to decide what is `F` and what `F::call` does.
+///
+/// Attempting to pass a non-zero-sized closure causes a compile-time failure:
+///
+/// ```compile_fail
+/// # use qemu_api::callbacks::FnCall;
+/// # fn call_it<'a, F: FnCall<(&'a str,), String>>(_f: &F, s: &'a str) -> String {
+/// #     F::call((s,))
+/// # }
+/// let x: &'static str = "goodbye world";
+/// call_it(&move |_| String::from(x), "hello workd");
+/// ```
+///
+/// # Safety
+///
+/// Because `Self` is a zero-sized type, all instances of the type are
+/// equivalent. However, in addition to this, `Self` must have no invariants
+/// that could be violated by creating a reference to it.
+///
+/// This is always true for zero-capture closures and function pointers, as long
+/// as the code is able to name the function in the first place.
+pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
+    /// Referring to this internal constant asserts that the `Self` type is
+    /// zero-sized.  Can be replaced by an inline const expression in
+    /// Rust 1.79.0+.
+    const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
+
+    /// Call the function with the arguments in args.
+    fn call(a: Args) -> R;
+}
+
+macro_rules! impl_call {
+    ($($args:ident,)* ) => (
+        // SAFETY: because each function is treated as a separate type,
+        // accessing `FnCall` is only possible in code that would be
+        // allowed to call the function.
+        unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
+        where
+            F: 'static + Sync + Sized + Fn($($args, )*) -> R,
+        {
+            #[inline(always)]
+            fn call(a: ($($args,)*)) -> R {
+                let _: () = Self::ASSERT_ZERO_SIZED;
+
+                // SAFETY: the safety of this method is the condition for implementing
+                // `FnCall`.  As to the `NonNull` idiom to create a zero-sized type,
+                // see https://github.com/rust-lang/libs-team/issues/292.
+                let f: &'static F = unsafe { &*NonNull::<Self>::dangling().as_ptr() };
+                let ($($args,)*) = a;
+                f($($args,)*)
+            }
+        }
+    )
+}
+
+impl_call!(_1, _2, _3, _4, _5,);
+impl_call!(_1, _2, _3, _4,);
+impl_call!(_1, _2, _3,);
+impl_call!(_1, _2,);
+impl_call!(_1,);
+impl_call!();
+
+#[cfg(test)]
+mod tests {
+    use super::*;
+
+    // The `_f` parameter is unused but it helps the compiler infer `F`.
+    fn do_test_call<'a, F: FnCall<(&'a str,), String>>(_f: &F) -> String {
+        F::call(("hello world",))
+    }
+
+    #[test]
+    fn test_call() {
+        assert_eq!(do_test_call(&str::to_owned), "hello world")
+    }
+}
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 124bece0449..4b43e02c0f9 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -14,6 +14,7 @@
 
 pub mod bitops;
 pub mod c_str;
+pub mod callbacks;
 pub mod cell;
 pub mod irq;
 pub mod module;
-- 
2.47.1


