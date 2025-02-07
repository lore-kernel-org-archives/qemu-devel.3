Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF5C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQ1-0007TB-1r; Fri, 07 Feb 2025 05:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPk-0007Lm-HU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLPi-000432-RC
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ejM9LdULLid2GnKlRXBOXJbddnv2FpH9YLwLU6Alx7U=;
 b=FMdhJVpqP2Nt1LFQRyOyWkk/z4YZBVCA10zQV80uMRGGAh0H1G+Okfj41e1b+DPFPWAC73
 M7076ikbMXv7jgmfhNHE7homMtr3IIMb4CzYp7i9wMWImbZofBocPicQlk+k+3xeNJLvdc
 ZYkaxBQTlLPh8k6h0e6+ThEMHlfxrPw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-n-B2sFemNlSJqUQxXMqJRQ-1; Fri, 07 Feb 2025 05:16:44 -0500
X-MC-Unique: n-B2sFemNlSJqUQxXMqJRQ-1
X-Mimecast-MFC-AGG-ID: n-B2sFemNlSJqUQxXMqJRQ
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab397fff5a3so213356566b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923401; x=1739528201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejM9LdULLid2GnKlRXBOXJbddnv2FpH9YLwLU6Alx7U=;
 b=Kig8VCHtPqT7qGF8fhPIcDnqmUfZJs1q3xz610oLcVghD9UBF7Bec6t68zM2chp47a
 TDvmNHazgj/AFls7QUwpCIgk3a8K1e+XRPbK0k4AnPf/3dpSilEgo2tqnNqsgXhBAAgQ
 2pw3xWsXe0oviFdVrgJ0pHVDQc/+QfmMa+cfPUICNdYMVxtvCf+fyQ5jhpXvjb8USvb1
 vsTfU2kGmWcdrxgO07YWwLVP58n4QqilQG2EPW2h9NWkgRF/jAlmO2dXb8n7RF+/6C+B
 8pC8yjGnfuYctQZCd9+O+9ceAqrJyZslGCTHYeeV6hpPSZKM7LwvRgujN6Cq6JKRLb3p
 f4aw==
X-Gm-Message-State: AOJu0YylYvh7Ggmb6TS2rTpLIF5u+t+4x21O5xxBwsFYUQFD0DYArJA9
 ulCPsh9gKdOusuI6jDgjo5A+/0hd1g8K27/vG2bBq8WsyWFT+gyWhZSO0XGGQWHDlsm5Ww7+x3J
 aSsB7gYjN8aL8IvRzjf8YLj+V6S8OPE2b+QhwhQHMkIpTX00A3J6Okohh9E+vlHElOOnPeo6Jnf
 8wvu8ylmxoggBW6AZwvdasXeAKzkSHvcc8rsKqO9g=
X-Gm-Gg: ASbGncsIOfy/FTS1uMxkaIWE2Q4dvLdlFonJQNaNLZ7Lw9EwipMmJskhnRUVTjgKZnl
 WbtyNxgkTmFZG/cm/N/2V5iV6oeInEbBws59+pcz4wCTTV7p4NNJcFXuJ2mRf7/xo+JuNb+bMFi
 192TwPSr8PmYhAg/ZEgl7OSR9jHqMmhqX3TtDYLY4+nLicD2YLVT6NS5pF19DFXhMKzNYnVZm1B
 A68REQs6y6bGiSBNepbMwncCRacxQHvgdhNYKR0x1j4Ik8hzyaF18RiEwUSJB+LD1IugzfA4BX0
 9Bw47w==
X-Received: by 2002:a17:907:9484:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-ab789ace50cmr220063666b.8.1738923401347; 
 Fri, 07 Feb 2025 02:16:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYFvkx7kxL5wQX/I6eTUg9VtwNiAsz7cQrnkIWtbX2vjwB7yapZwzOC5xnpFw7o24m1v/ngw==
X-Received: by 2002:a17:907:9484:b0:ab2:f6e5:3f1 with SMTP id
 a640c23a62f3a-ab789ace50cmr220060566b.8.1738923400879; 
 Fri, 07 Feb 2025 02:16:40 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f49361sm240505766b.33.2025.02.07.02.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 03/12] rust: callbacks: allow passing optional callbacks as ()
Date: Fri,  7 Feb 2025 11:16:14 +0100
Message-ID: <20250207101623.2443552-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 314f9dce962..9642a16eb89 100644
--- a/rust/qemu-api/src/callbacks.rs
+++ b/rust/qemu-api/src/callbacks.rs
@@ -79,6 +79,31 @@
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
@@ -93,10 +118,70 @@ pub unsafe trait FnCall<Args, R = ()>: 'static + Sync + Sized {
     /// Rust 1.79.0+.
     const ASSERT_ZERO_SIZED: () = { assert!(mem::size_of::<Self>() == 0) };
 
+    /// Referring to this constant asserts that the `Self` type is an actual
+    /// function type, which can be used to catch incorrect use of `()`
+    /// at compile time.
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
+    /// Note that this can be more simply `const { assert!(F::IS_SOME) }` in
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
@@ -106,6 +191,8 @@ unsafe impl<F, $($args,)* R> FnCall<($($args,)*), R> for F
         where
             F: 'static + Sync + Sized + Fn($($args, )*) -> R,
         {
+            const IS_SOME: bool = true;
+
             #[inline(always)]
             fn call(a: ($($args,)*)) -> R {
                 let _: () = Self::ASSERT_ZERO_SIZED;
@@ -141,4 +228,14 @@ fn do_test_call<'a, F: FnCall<(&'a str,), String>>(_f: &F) -> String {
     fn test_call() {
         assert_eq!(do_test_call(&str::to_owned), "hello world")
     }
+
+    // The `_f` parameter is unused but it helps the compiler infer `F`.
+    fn do_test_is_some<'a, F: FnCall<(&'a str,), String>>(_f: &F) {
+        assert!(F::is_some());
+    }
+
+    #[test]
+    fn test_is_some() {
+        do_test_is_some(&str::to_owned);
+    }
 }
-- 
2.48.1


