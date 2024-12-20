Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94108E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1W-0004UJ-5C; Fri, 20 Dec 2024 09:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1P-0004Sm-Bu
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1N-0006be-F4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CE9shW3ftWbl1V1SBQeRNzap/cYi489BVwR842VWpQ=;
 b=gH4r/2Fap2gBjHsSbLvfpTYC0/SGMBTRL5K+Pd+9xByr13Hit3MnRuNVBrnpU1hH9lt4SK
 AwIubgbAIWvEXtV/e+cjcftxVV8z20mRHo7JkPpej7KZpy7ZAmAZxkhhX5fkiwkauCLz6J
 ZgO36t9NgG9pfZq9IvtaNxa9AJ2xpmA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-YID_4nulNQywaQzAs_U7sw-1; Fri, 20 Dec 2024 09:30:26 -0500
X-MC-Unique: YID_4nulNQywaQzAs_U7sw-1
X-Mimecast-MFC-AGG-ID: YID_4nulNQywaQzAs_U7sw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so17082095e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705025; x=1735309825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CE9shW3ftWbl1V1SBQeRNzap/cYi489BVwR842VWpQ=;
 b=bBf8Ke4V8t0u7Wb6NR3eDFTkYXmqSeaSNB7/rNwN3a66U6oF2V/bGuDZPfQ0+y2K79
 3R8yrRynjOea5MDjT78Lt/CIXaPxmKZFRbp135zRTy+EXoYaYJNuFfY4aJvJo2PSog+r
 tdpXYMvGQbbcX5yGBWh+pifSZ3r/kYRonid9ICgq1e1pa23y3y7LrA1wFUzahzkfrRVe
 9uhPLU00wgiJYmFukkxrgJ5iXVcI3Ack9iSreiCh55SYhGpTc/2zKmYAC7XcvcvytGvi
 2z4necaUiuuKewMwJOoWIOTFq8wjmupjcIP0EnBWSRgqebZYZeoqdqqOqNes4Mpd8n11
 DZ3w==
X-Gm-Message-State: AOJu0YzJyew+UyQsDXtChZfym/cMElRJ/7qAjXKisjwFvEUqQiZumov3
 Jgt0+Y93l+AaR0KZjA8HEF7+fmQoPHLxC3KOYkIQCeLYqDNxcoKv/JTI19UBw/3YEHp0Ehx3A4P
 91YMrYgFa2vsAqgQBGJsKk8iblcZalCzSHmd6fDaXhPb6UfdgxZj2d7N6i9xExMrJGE2PQ/sGmK
 NifGqiFjaBsXdi1AV0kwe7umLWmP4JqDmPPw68
X-Gm-Gg: ASbGnctDBICZ5OQlxBln7PBs92CLTJhgfaVbUBbPpyrLwGtY8bRieO2I6e3Itx1oLm1
 C5tNXs4LdirckxnFmrlNj0Om75eqqUp1ba4VFcV/EVyRaCY+XJZszatn/q7HNNEsg0P1LE1N7bo
 I5BmHR+fxmzca4W4MheR6GKmnHWaRRGl3mcsKC5/9YUyTSxvXRrCkBUr540Xvx9p+/RzyqvM2ZZ
 db1mkRtDviWOIGDVR0xW1oIXP7kXE9DgZK4Ygn8vIYVFpZ+a2GriyhFI7tm
X-Received: by 2002:a05:600c:3b9a:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-436685470f8mr21997485e9.1.1734705024572; 
 Fri, 20 Dec 2024 06:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETpWXaWaw9US5iVVn857lDgNrX33bWnLjJZuYEEXU6N/4z+3xZlssf+uLvsNzyHsfsNXkd8w==
X-Received: by 2002:a05:600c:3b9a:b0:42c:bb10:7292 with SMTP id
 5b1f17b1804b1-436685470f8mr21997215e9.1.1734705024070; 
 Fri, 20 Dec 2024 06:30:24 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289995sm46912885e9.36.2024.12.20.06.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 11/12] rust: qemu-api-macros: add automatic TryFrom/TryInto
 derivation
Date: Fri, 20 Dec 2024 15:29:53 +0100
Message-ID: <20241220142955.652636-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is going to be fairly common. Using a custom procedural macro
provides better error messages and automatically finds the right
type.

Note that this is different from the same-named macro in the
derive_more crate.  That one provides conversion from e.g. tuples
to enums with tuple variants, not from integers to enums.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/lib.rs   | 28 +------------
 rust/qemu-api-macros/src/lib.rs | 74 ++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 29 deletions(-)

diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 69064d6929b..0a89d393e0f 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -45,7 +45,7 @@
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
-#[derive(Debug)]
+#[derive(Debug, qemu_api_macros::TryInto)]
 pub enum RegisterOffset {
     /// Data Register
     ///
@@ -102,32 +102,6 @@ pub enum RegisterOffset {
     //Reserved = 0x04C,
 }
 
-impl core::convert::TryFrom<u64> for RegisterOffset {
-    type Error = u64;
-
-    fn try_from(value: u64) -> Result<Self, Self::Error> {
-        macro_rules! case {
-            ($($discriminant:ident),*$(,)*) => {
-                /* check that matching on all macro arguments compiles, which means we are not
-                 * missing any enum value; if the type definition ever changes this will stop
-                 * compiling.
-                 */
-                const fn _assert_exhaustive(val: RegisterOffset) {
-                    match val {
-                        $(RegisterOffset::$discriminant => (),)*
-                    }
-                }
-
-                match value {
-                    $(x if x == Self::$discriminant as u64 => Ok(Self::$discriminant),)*
-                     _ => Err(value),
-                }
-            }
-        }
-        case! { DR, RSR, FR, FBRD, ILPR, IBRD, LCR_H, CR, FLS, IMSC, RIS, MIS, ICR, DMACR }
-    }
-}
-
 pub mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 539c48df298..7ec218202f4 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -5,8 +5,8 @@
 use proc_macro::TokenStream;
 use quote::quote;
 use syn::{
-    parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
-    Fields, Ident, Type, Visibility,
+    parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
+    DeriveInput, Field, Fields, Ident, Meta, Path, Token, Type, Variant, Visibility,
 };
 
 mod utils;
@@ -98,3 +98,73 @@ pub fn derive_offsets(input: TokenStream) -> TokenStream {
 
     TokenStream::from(expanded)
 }
+
+#[allow(non_snake_case)]
+fn get_repr_uN(input: &DeriveInput, msg: &str) -> Result<Path, MacroError> {
+    let repr = input.attrs.iter().find(|attr| attr.path().is_ident("repr"));
+    if let Some(repr) = repr {
+        let nested = repr.parse_args_with(Punctuated::<Meta, Token![,]>::parse_terminated)?;
+        for meta in nested {
+            match meta {
+                Meta::Path(path) if path.is_ident("u8") => return Ok(path),
+                Meta::Path(path) if path.is_ident("u16") => return Ok(path),
+                Meta::Path(path) if path.is_ident("u32") => return Ok(path),
+                Meta::Path(path) if path.is_ident("u64") => return Ok(path),
+                _ => {}
+            }
+        }
+    }
+
+    Err(MacroError::Message(
+        format!("#[repr(u8/u16/u32/u64) required for {}", msg),
+        input.ident.span(),
+    ))
+}
+
+fn get_variants(input: &DeriveInput) -> Result<&Punctuated<Variant, Comma>, MacroError> {
+    if let Data::Enum(e) = &input.data {
+        if let Some(v) = e.variants.iter().find(|v| v.fields != Fields::Unit) {
+            return Err(MacroError::Message(
+                "Cannot derive TryInto for enum with non-unit variants.".to_string(),
+                v.fields.span(),
+            ));
+        }
+        Ok(&e.variants)
+    } else {
+        Err(MacroError::Message(
+            "Cannot derive TryInto for union or struct.".to_string(),
+            input.ident.span(),
+        ))
+    }
+}
+
+#[rustfmt::skip::macros(quote)]
+fn derive_tryinto_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+    let repr = get_repr_uN(&input, "#[derive(TryInto)]")?;
+
+    let name = &input.ident;
+    let variants = get_variants(&input)?;
+    let discriminants: Vec<&Ident> = variants.iter().map(|f| &f.ident).collect();
+
+    Ok(quote! {
+        impl core::convert::TryFrom<#repr> for #name {
+            type Error = #repr;
+
+            fn try_from(value: #repr) -> Result<Self, Self::Error> {
+                #(const #discriminants: #repr = #name::#discriminants as #repr;)*;
+                match value {
+                    #(#discriminants => Ok(Self::#discriminants),)*
+                    _ => Err(value),
+                }
+            }
+        }
+    })
+}
+
+#[proc_macro_derive(TryInto)]
+pub fn derive_tryinto(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_tryinto_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
+}
-- 
2.47.1


