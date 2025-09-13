Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FEBCAC587
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLM4-00081a-7Q; Sat, 13 Sep 2025 04:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLe-0006Lv-4t
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLa-00053c-8V
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wpHg6YqRiBR1PtKo5xZZoZMNrYFH8NvU1cbHwz4R770=;
 b=Mg3djGngX27Rh3CwfNYhU3xZgWouRdTdmERLUdHqobw94VoscLCBXdRjrZSmG9YMZxxJQm
 DoE+ciItElNDO5vqyR/MvNZIk2jZ6yCGmq5SfPfM69cgbqMG/IVNZ4ngZHXsP22BJ8lZk3
 HTdrWl37MnK8SHaE1iYT8OQkxRu4QuY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-dwodwQLbMkqvpG52SdLW4Q-1; Sat, 13 Sep 2025 04:10:57 -0400
X-MC-Unique: dwodwQLbMkqvpG52SdLW4Q-1
X-Mimecast-MFC-AGG-ID: dwodwQLbMkqvpG52SdLW4Q_1757751057
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e5190bcba1so1790983f8f.2
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751056; x=1758355856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpHg6YqRiBR1PtKo5xZZoZMNrYFH8NvU1cbHwz4R770=;
 b=RcCOtCBA72B9HuWHnJZfGGBpG3xzghkyLmesXcy8aK6w4S/zZ3rpY1sTENuwJbYpKh
 hw5pK+sZtjOhfSwuZ9+IsT8zWvKWs1pFNgtWzRLQrqwgQgx7n/o1uhrk3klHW9B+ccw6
 HVL6NclRwL4rHSf8rPO23scPlzP60bu9gDjqhSBoUVjcbpX8pvOU9KaSLEEQ1rT033d/
 EOkVpdp1wBejynth9wYqohiNCdcwdgpJ2kdoJ1ER8Wsr/gIFjd92g+upVfcBUkqyNAF6
 joHA6JMvSvTmDBQo5IYsMkD5Z6x6/taMK9FittManPh0+X3lsKSmKizHELU0KCjB2ea1
 e3TA==
X-Gm-Message-State: AOJu0YxPBAbU0G5gzV/2zAbVku/bfynvdDS9hke2KwOa1HaaVC9XvYmd
 P+rN71mwBwuCCZKVnDIAvpzAGBU2Yq9IdzpOXv5yLt3XSMadrXqTUCfJ8dnzFo/9Pg7DT4sbGpA
 U7F+rTbIETa0LRJNxm2T46AUYteUemSIB49odGUV1faYR+/VQK5fLX+2YIXKRDbmz9OusO5WeOM
 jzOENdFPXfH2ym6sacLLAe6Ls+iopLIRjZ+paioQaD
X-Gm-Gg: ASbGncu0W5OEzLYgntEskDyFXCXjaveGNYF0coon6UukhkCKeQLlm+u0shNY9c2UQ/X
 tUcIHguoZ2BcdpqbL4UKLmFDlz7fUOGK9OCav8Y2sBlM5CZFWjFMB2YdGpplA5o2zUYbWxcyXQV
 dTQsCnLldHK/G7ydi/4evmq6Z42on98oP29WcWLQ7Zq88WpmQQ2ubXZOYDCGQJJPOqI0+Bd6iYN
 EzAmqRjoLyMXH1RzptFSGzSMMcSpo3Sjp7/m8IH9ysOZ9aW0eoB57OB1tWQ8IgBNKoKvKKXK4Gl
 TmwAVQHsqEZTxJIg8Vz3FcQAXKrThttXQJldO15ZCcCj99+6/xM+Hv/HdI75pRMxG+T5MuvPgGm
 c3etyyOXIAXcjEAQstcO0JZQA/0Y6ZGHx6f77dSwgqHc=
X-Received: by 2002:a05:6000:2289:b0:3e5:47a9:1c7a with SMTP id
 ffacd0b85a97d-3e765a157b7mr4992675f8f.62.1757751055703; 
 Sat, 13 Sep 2025 01:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWs0wSSxGAD3pl88yLEV7nFo7Yb95VY+lwx62kvJ7BCDruDMxtthSf8nSbI/2f+DQeRvHIyA==
X-Received: by 2002:a05:6000:2289:b0:3e5:47a9:1c7a with SMTP id
 ffacd0b85a97d-3e765a157b7mr4992644f8f.62.1757751055201; 
 Sat, 13 Sep 2025 01:10:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e774a3fb5bsm4862034f8f.58.2025.09.13.01.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:10:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/61] rust: use inline const expressions
Date: Sat, 13 Sep 2025 10:09:05 +0200
Message-ID: <20250913080943.11710-25-pbonzini@redhat.com>
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

They were stabilized in Rust 1.79.0.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250908105005.2119297-6-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst            |  9 +++------
 rust/qemu-api/src/callbacks.rs | 27 +--------------------------
 rust/qemu-api/src/chardev.rs   |  2 +-
 rust/qemu-api/src/qdev.rs      |  2 +-
 rust/qemu-api/src/timer.rs     |  2 +-
 rust/qemu-api/src/vmstate.rs   |  2 +-
 6 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index e0ee4a9837d..98e3a33a3ce 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -79,9 +79,6 @@ QEMU supports rustc version 1.83.0 and newer.  The following features
 from relatively new versions of Rust are not used for historical reasons;
 patches are welcome:
 
-* inline const expression (stable in 1.79.0), currently worked around with
-  associated constants in the ``FnCall`` trait.
-
 * associated constants are still explicitly marked ``'static`` (`changed in
   1.81.0`__)
 
@@ -97,9 +94,9 @@ patches are welcome:
   before QEMU can use them.  For now, there is special code in
   ``util/error.c`` to support non-NUL-terminated file names.
 
-* associated const equality would be nice to have for some users of
-  ``callbacks::FnCall``, but is still experimental.  ``ASSERT_IS_SOME``
-  replaces it.
+Associated const equality would be nice to have for some users of
+``callbacks::FnCall``, but is still experimental.  Const assertions
+are used instead.
 
 __ https://github.com/rust-lang/rust/pull/125258
 
diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
index 9642a16eb89..dbe2305f509 100644
--- a/rust/qemu-api/src/callbacks.rs
+++ b/rust/qemu-api/src/callbacks.rs
@@ -113,31 +113,6 @@
 /// This is always true for zero-capture closures and function pointers, as long
 /// as the code is able to name the function in the first place.
 pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
-    /// Referring to this internal constant asserts that the `Self` type is
-    /// zero-sized.  Can be replaced by an inline const expression in
-    /// Rust 1.79.0+.
-    const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
-
-    /// Referring to this constant asserts that the `Self` type is an actual
-    /// function type, which can be used to catch incorrect use of `()`
-    /// at compile time.
-    ///
-    /// # Examples
-    ///
-    /// ```compile_fail
-    /// # use qemu_api::callbacks::FnCall;
-    /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
-    ///     let _: () = F::ASSERT_IS_SOME;
-    ///     F::call((s,))
-    /// }
-    ///
-    /// let s: String = call_it((), "hello world"); // does not compile
-    /// ```
-    ///
-    /// Note that this can be more simply `const { assert!(F::IS_SOME) }` in
-    /// Rust 1.79.0 or newer.
-    const ASSERT_IS_SOME: () = { assert!(Self::IS_SOME) };
-
     /// `true` if `Self` is an actual function type and not `()`.
     ///
     /// # Examples
@@ -195,7 +170,7 @@ unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
 
             #[inline(always)]
             fn call(a: ($($args,)*)) -> R {
-                let _: () = Self::ASSERT_ZERO_SIZED;
+                const { assert!(mem::size_of::<Self>() == 0) };
 
                 // SAFETY: the safety of this method is the condition for implementing
                 // `FnCall`.  As to the `NonNull` idiom to create a zero-sized type,
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
index 6e0590d758e..cb27be52569 100644
--- a/rust/qemu-api/src/chardev.rs
+++ b/rust/qemu-api/src/chardev.rs
@@ -138,7 +138,7 @@ pub fn enable_handlers<
             F::call((owner, event))
         }
 
-        let _: () = CanReceiveFn::ASSERT_IS_SOME;
+        const { assert!(CanReceiveFn::IS_SOME) };
         let receive_cb: Option<unsafe extern "C" fn(*mut c_void, *const u8, c_int)> =
             if ReceiveFn::is_some() {
                 Some(rust_receive_cb::<T, ReceiveFn>)
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 36f02fb57db..52d54a4494e 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -373,7 +373,7 @@ fn do_init_gpio_in(
             }
         }
 
-        let _: () = F::ASSERT_IS_SOME;
+        const { assert!(F::IS_SOME) };
         unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
             opaque: *mut c_void,
             line: c_int,
diff --git a/rust/qemu-api/src/timer.rs b/rust/qemu-api/src/timer.rs
index 0daec62f926..1e639eaf221 100644
--- a/rust/qemu-api/src/timer.rs
+++ b/rust/qemu-api/src/timer.rs
@@ -56,7 +56,7 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
     ) where
         F: for<'a> FnCall<(&'a T,)>,
     {
-        let _: () = F::ASSERT_IS_SOME;
+        const { assert!(F::IS_SOME) };
 
         /// timer expiration callback
         unsafe extern "C" fn rust_timer_handler<T, F: for<'a> FnCall<(&'a T,)>>(
diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 812f390d780..8515e382135 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -457,7 +457,7 @@ macro_rules! vmstate_exist_fn {
         const fn test_cb_builder__<T, F: for<'a> $crate::callbacks::FnCall<(&'a T, u8), bool>>(
             _phantom: ::core::marker::PhantomData<F>,
         ) -> $crate::vmstate::VMSFieldExistCb {
-            let _: () = F::ASSERT_IS_SOME;
+            const { assert!(F::IS_SOME) };
             $crate::vmstate::rust_vms_test_field_exists::<T, F>
         }
 
-- 
2.51.0


