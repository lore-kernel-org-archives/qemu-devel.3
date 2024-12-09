Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD114E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKd6X-0008CP-6a; Mon, 09 Dec 2024 07:43:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd22-0004Yy-HA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tKd1w-0007as-Cp
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733747906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6KMN/KKwz/drY0m0B/GAzuPFwO/9IuBICqSOgF3wlY=;
 b=KjystAASfB/h9av5tZ4PqlUtqDOIdjs5sFHfASFI6EqzOxY3DnpOoUOI4zQWk+o9JqSK8F
 3DD4IdZHVgO5yepdKJEyTTgnZOEvNjeQBRNG/k/Lv8wwPoa+U5M5FwRmOG9dgmh1MkJzgx
 VIm4k+fG7Bjbc8EDOy/oaoUCJgxHHYY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-5SkZ6bASP8uC9z-rmISFqw-1; Mon, 09 Dec 2024 07:38:25 -0500
X-MC-Unique: 5SkZ6bASP8uC9z-rmISFqw-1
X-Mimecast-MFC-AGG-ID: 5SkZ6bASP8uC9z-rmISFqw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862c67763dso1816110f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 04:38:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747903; x=1734352703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6KMN/KKwz/drY0m0B/GAzuPFwO/9IuBICqSOgF3wlY=;
 b=DoQNFmnxVkZyq84e06+Gp2s+cSEdkDSh16j4+S5nQyeE3FOe5atwpMrxtaf/7oqL00
 zN0htOhSB/qAeNW1e8SBrU7PyhKq9I71JUlIzR7YweZMu/emFgmbJnmoLv4MZ8yXBKOE
 FZQpwxOTBnwzQQW1r7vdQAc0w+zkcsneKL11xnYo6+SKf5GftJCny5gNndzUjLxY0/eM
 W6OGY8pxfRMX+OXe36OqKlKeJehX1mGJWmcFvpn7JuvODAbmrEE3Xd+TS190Q+OyRjZe
 JhVKidkVEMRzaf2ZtFTdj61ct0UQ5rDilyAUIuYIvobC2nCQug1RPwcQY/DHPMh3tVq5
 Un+Q==
X-Gm-Message-State: AOJu0YwW6TR622/DsIfJO/wGENb/Tfsii523q/iF25Effi29ctFqzAR3
 9f6/Z9RFrOFa3/pCnomJYNuJURaCgGWKUUlI+hOPmc2neTbLmlQW4g96eZzN1lpVbhBoLyk4C3u
 vbRj+rvGBHEW+Kk4CUnU/O7190/nqz1VdMzJaGT6on9i2kQvW7vRbapMWqxbXEmkXZA/RmRPiEO
 1xd7dIFb0TJLjHlQAL7z86cNFTCWozJnvZTvhe
X-Gm-Gg: ASbGnct+stPTvPYTKvNNqnW0QoCcXcn3gUTELjisBmA6Z9V9T6J4H4UcUZm/iMCed9u
 R54jebc4HRwIsvVI6HW03kTmnW6FBQxLwHgfYS4jRn5yFVW3R8J8j3wkcWIfh8z35OnpMzF/sae
 Qzvy+c2Ng+Rc33kWWFmi6Et/wzIAbg33/AGLY4mg1cdTanZ8Spz9ZQg6k2L6gYaKOQG5Ht7uGeR
 ENbnNnnEsVd55haykpvIUGpfRvdVL1tepFrbjid1ZRwpBFOym6uoA==
X-Received: by 2002:a05:6000:4715:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-3862b37f1fcmr9529702f8f.34.1733747903513; 
 Mon, 09 Dec 2024 04:38:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNIjYvCBUUw5SuI6EdubzMkYBb+V9p2OLC1S6N1gh//MaK5456gKjpwFzm1ivquRIqCgHGWg==
X-Received: by 2002:a05:6000:4715:b0:385:fb34:d585 with SMTP id
 ffacd0b85a97d-3862b37f1fcmr9529680f8f.34.1733747903085; 
 Mon, 09 Dec 2024 04:38:23 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f0d6a825sm71952995e9.20.2024.12.09.04.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 04:38:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: [PATCH 26/26] rust: callbacks: allow passing optional callbacks as ()
Date: Mon,  9 Dec 2024 13:37:17 +0100
Message-ID: <20241209123717.99077-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209123717.99077-1-pbonzini@redhat.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In some cases, callbacks are optional.  Using "Some(function)" and "None"
does not work well, because when someone writes "None" the compiler does
not know what to use for "F" in "Option<F>".

Therefore, adopt () to mean a "null" callback.  It is possible to enforce
that a callback is valid by adding a "let _: () = F::ASSERT_IS_SOME" before
the invocation of F::call.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/callbacks.rs | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/callbacks.rs
index 6401d807198..83c681d6478 100644
--- a/rust/qemu-api/src/callbacks.rs
+++ b/rust/qemu-api/src/callbacks.rs
@@ -76,6 +76,31 @@
 /// call_it(&move |_| String::from(x), "hello workd");
 /// ```
 ///
+/// `()` can be used to indicate "no function":
+///
+/// ```
+/// # use qemu_api::callbacks::FnCall;
+/// fn optional<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> Option<String> {
+///     if F::IS_SOME {
+///         Some(F::call((s,)))
+///     } else {
+///         None
+///     }
+/// }
+///
+/// assert!(optional(&(), "hello world").is_none());
+/// ```
+///
+/// Invoking `F::call` will then be a run-time error.
+///
+/// ```should_panic
+/// # use qemu_api::callbacks::FnCall;
+/// # fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+/// #     F::call((s,))
+/// # }
+/// let s: String = call_it(&(), "hello world"); // panics
+/// ```
+///
 /// # Safety
 ///
 /// Because `Self` is a zero-sized type, all instances of the type are
@@ -90,10 +115,70 @@ pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
     /// Rust 1.79.0+.
     const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
 
+    /// Referring to this constant asserts that the `Self` type is an actual
+    /// function type, which can be used to catch incorrect use of `()`
+    /// at  compile time.
+    ///
+    /// # Examples
+    ///
+    /// ```compile_fail
+    /// # use qemu_api::callbacks::FnCall;
+    /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+    ///     let _: () = F::ASSERT_IS_SOME;
+    ///     F::call((s,))
+    /// }
+    ///
+    /// let s: String = call_it((), "hello world"); // does not compile
+    /// ```
+    ///
+    /// Note that this use more simply `const { assert!(F::IS_SOME) }` in
+    /// Rust 1.79.0 or newer.
+    const ASSERT_IS_SOME: () = { assert!(Self::IS_SOME) };
+
+    /// `true` if `Self` is an actual function type and not `()`.
+    ///
+    /// # Examples
+    ///
+    /// You can use `IS_SOME` to catch this at compile time:
+    ///
+    /// ```compile_fail
+    /// # use qemu_api::callbacks::FnCall;
+    /// fn call_it<F: for<'a> FnCall<(&'a str,), String>>(_f: &F, s: &str) -> String {
+    ///     const { assert!(F::IS_SOME) }
+    ///     F::call((s,))
+    /// }
+    ///
+    /// let s: String = call_it((), "hello world"); // does not compile
+    /// ```
+    const IS_SOME: bool;
+
+    /// `false` if `Self` is an actual function type, `true` if it is `()`.
+    fn is_none() -> bool {
+        !Self::IS_SOME
+    }
+
+    /// `true` if `Self` is an actual function type, `false` if it is `()`.
+    fn is_some() -> bool {
+        Self::IS_SOME
+    }
+
     /// Call the function with the arguments in args.
     fn call(a: Args) -> R;
 }
 
+/// `()` acts as a "null" callback.  Using `()` and `function` is nicer
+/// than `None` and `Some(function)`, because the compiler is unable to
+/// infer the type of just `None`.  Therefore, the trait itself acts as the
+/// option type, with functions [`FnCall::is_some`] and [`FnCall::is_none`].
+unsafe impl<Args, R> FnCall<Args, R> for () {
+    const IS_SOME: bool = false;
+
+    /// Call the function with the arguments in args.
+    fn call(_a: Args) -> R {
+        panic!("callback not specified")
+    }
+}
+
 macro_rules! impl_call {
     ($($args:ident,)* ) => (
         // SAFETY: because each function is treated as a separate type,
@@ -103,6 +188,8 @@ unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
         where
             F: 'static + Sync + Sized + Fn($($args, )*) -> R,
         {
+            const IS_SOME: bool = true;
+
             #[inline(always)]
             fn call(a: ($($args,)*)) -> R {
                 let _: () = Self::ASSERT_ZERO_SIZED;
@@ -138,4 +225,14 @@ fn do_test_call<'a, F: FnCall<(&'a str,), String>>(_f: &F) -> String {
     fn test_call() {
         assert_eq!(do_test_call(&str::to_owned), "hello world")
     }
+
+    // The `_f` parameter is unused but it helps the compiler infer `F`.
+    fn do_test_is_some<'a, F: FnCall<(&'a str,), String>>(_f: &F) {
+        assert_eq!(F::is_some(), true);
+    }
+
+    #[test]
+    fn test_is_some() {
+        do_test_is_some(&str::to_owned);
+    }
 }
-- 
2.47.1


