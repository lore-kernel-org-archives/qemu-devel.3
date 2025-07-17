Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E026BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 06:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIOa-0001Vh-6K; Thu, 17 Jul 2025 02:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5z-0008Ph-Kf
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ucI5w-00087r-Bi
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 02:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752733670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N4iEr+cNk1mlij6jwBXafMWcLDkNKM8oNL/AuVmjjjM=;
 b=XKXH8e2FDwxi0qxYxWis2pH/UbCpT13IrcvwJbyfqEgp8QDA25VWJBYI/yK4SusDrLf1Y3
 /zm69IMuUokjf9de4KJGr5ypeU43B+Qcv1AtAVHcXa94BGQ85blXbOti/wPUIu3Xn88VH9
 cWs3nbTOSrVFvddVWNLuNYlXzGjvtRM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-CspR9uoKMzqSLShGsAk2Nw-1; Thu, 17 Jul 2025 02:27:43 -0400
X-MC-Unique: CspR9uoKMzqSLShGsAk2Nw-1
X-Mimecast-MFC-AGG-ID: CspR9uoKMzqSLShGsAk2Nw_1752733662
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-456106b7c4aso7182965e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 23:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752733661; x=1753338461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4iEr+cNk1mlij6jwBXafMWcLDkNKM8oNL/AuVmjjjM=;
 b=X0/o1qIr56rjsg1J53ra8cxrIUNuGBd+OKcvc3flVtyJ8T4iSlUpf4Du2ufnKTc4Lk
 W/y3AK5NC5Fwh8CeFFRdjfV79SsMkrglCi9LQRII7dwuqkwvdjBdbMSuQ+muwt8lcZGy
 xeSTBgHM+BTN2+gwOnPM1NmDPx9c1zT+B9MbeJF7ENxePguJLnuYJaHjdqEc4T1+wY8l
 ZYsig9Rp1Lw031C7XyuTKPUmbVd02CcHMEleYihXUmdvnkIYZ7bLMjKJgM2MvuHX3IWT
 ndeewxBDwNBAFc/KW5OHWGpzmpbxk9r65wrAceBL5grAknN7PIWy+vlkcF7XumPeJWkb
 01bA==
X-Gm-Message-State: AOJu0YyT9D8fRFnq7sXdfHDGK63qyGjeseVUSE26k9xjF+763Ci/tw89
 11ahYfo8VY3eCm9HqwE+42MY1V9SKBRavbRURoVxV+bmJEybdD5onGdXhvd4FSpaCbZCM/ozIQu
 TQ9rWTvro2RqmuI/FzVRsKZPtBosvCBGBRFnJfz2AfOcRFuepiC0/3GlKN+tZP+KHTo0qE52g+o
 XYeTXXXOxk6op9x3WFh0cKFUp8xwyRVKDnOJDZEq5L
X-Gm-Gg: ASbGnctDd0EY1+atF9tf5J1CxftziJslNv2NJS3I/9KZcpzgV2oTl71B7gMj6cZ8dfj
 1OB0zyfG5aU8zqLUsU/XrcBs+WoCf03MUpu1HoE6HL0T3Ayw0MpYfmor7vlMW1EMxoBsETxxOLW
 TvmUU4h8GeMGbh5HEqz6iMw8rZBW1QzGGFJsBVOZfn0HabRXahllj8UQYI7dzyCdaubFJgKWjA1
 X8jt1TYlItCsMS6KLKcR5WXyUAWCpRKCAoOWntoeGhKMUm64LpX8LdWicVtxq/f5i+M6Y7jrtsZ
 ct+3hJeFuIfNrDlBi/53VUi6MjKFMaNzNzHQOmpdzzA=
X-Received: by 2002:a05:600c:6745:b0:456:f22:ca49 with SMTP id
 5b1f17b1804b1-4563449a16emr18017365e9.0.1752733661132; 
 Wed, 16 Jul 2025 23:27:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1XdPhCgnraxxi8qxxo8/12t8LAf8ivJMssB9G7xv1uNYfE0QS9/J0i1fsnRF4wH1Wmzq28g==
X-Received: by 2002:a05:600c:6745:b0:456:f22:ca49 with SMTP id
 5b1f17b1804b1-4563449a16emr18017075e9.0.1752733660617; 
 Wed, 16 Jul 2025 23:27:40 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e818525sm40539465e9.16.2025.07.16.23.27.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 23:27:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	manos.pitsidianakis@linaro.org
Subject: [PATCH 4/4] qemu-api-macros: switch #[property] parsing to use
 combinators
Date: Thu, 17 Jul 2025 08:27:27 +0200
Message-ID: <20250717062727.305466-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717062727.305466-1-pbonzini@redhat.com>
References: <20250717062727.305466-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

attrs is a simple crate that provides parser combinators for
attribute arguments.  Use it instead of a handwritten parser,
and adjust tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs   | 84 +++++++++++--------------------
 rust/qemu-api-macros/src/tests.rs |  8 +--
 2 files changed, 35 insertions(+), 57 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index a0a8d758bcc..b3d44da9300 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,11 +3,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::{quote, quote_spanned, ToTokens};
+use quote::{quote, quote_spanned};
 use syn::{
-    parse::Parse, parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned,
-    token::Comma, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
-    Variant,
+    parse::Parse, parse::ParseStream, parse_macro_input, parse_quote, punctuated::Punctuated,
+    spanned::Spanned, token::Comma, Attribute, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed,
+    Ident, Meta, Path, Token, Variant,
 };
 mod bits;
 use bits::BitsConstInternal;
@@ -153,61 +153,37 @@ enum DevicePropertyName {
     Str(syn::LitStr),
 }
 
-#[derive(Debug)]
+impl Parse for DevicePropertyName {
+    fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
+        let lo = input.lookahead1();
+        if lo.peek(syn::LitStr) {
+            Ok(Self::Str(input.parse()?))
+        } else if lo.peek(syn::LitCStr) {
+            Ok(Self::CStr(input.parse()?))
+        } else {
+            Err(lo.error())
+        }
+    }
+}
+
+#[derive(Default, Debug)]
 struct DeviceProperty {
     rename: Option<DevicePropertyName>,
     defval: Option<syn::Expr>,
 }
 
-impl Parse for DeviceProperty {
-    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
-        let _: syn::Token![#] = input.parse()?;
-        let bracketed;
-        _ = syn::bracketed!(bracketed in input);
-        let attribute = bracketed.parse::<syn::Ident>()?;
-        debug_assert_eq!(&attribute.to_string(), "property");
-        let mut retval = Self {
-            rename: None,
-            defval: None,
-        };
-        let content;
-        _ = syn::parenthesized!(content in bracketed);
-        while !content.is_empty() {
-            let value: syn::Ident = content.parse()?;
-            if value == "rename" {
-                let _: syn::Token![=] = content.parse()?;
-                if retval.rename.is_some() {
-                    return Err(syn::Error::new(
-                        value.span(),
-                        "`rename` can only be used at most once",
-                    ));
-                }
-                if content.peek(syn::LitStr) {
-                    retval.rename = Some(DevicePropertyName::Str(content.parse::<syn::LitStr>()?));
-                } else {
-                    retval.rename =
-                        Some(DevicePropertyName::CStr(content.parse::<syn::LitCStr>()?));
-                }
-            } else if value == "default" {
-                let _: syn::Token![=] = content.parse()?;
-                if retval.defval.is_some() {
-                    return Err(syn::Error::new(
-                        value.span(),
-                        "`default` can only be used at most once",
-                    ));
-                }
-                retval.defval = Some(content.parse()?);
-            } else {
-                return Err(syn::Error::new(
-                    value.span(),
-                    format!("unrecognized field `{value}`"),
-                ));
-            }
+impl DeviceProperty {
+    fn parse_from(&mut self, a: &Attribute) -> syn::Result<()> {
+        use attrs::{set, with, Attrs};
+        let mut parser = Attrs::new();
+        parser.once("rename", with::eq(set::parse(&mut self.rename)));
+        parser.once("default", with::eq(set::parse(&mut self.defval)));
+        a.parse_args_with(&mut parser)
+    }
 
-            if !content.is_empty() {
-                let _: syn::Token![,] = content.parse()?;
-            }
-        }
+    fn parse(a: &Attribute) -> syn::Result<Self> {
+        let mut retval = Self::default();
+        retval.parse_from(a)?;
         Ok(retval)
     }
 }
@@ -229,7 +205,7 @@ fn derive_device_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
             f.attrs
                 .iter()
                 .filter(|a| a.path().is_ident("property"))
-                .map(|a| Ok((f.clone(), syn::parse2(a.to_token_stream())?)))
+                .map(|a| Ok((f.clone(), DeviceProperty::parse(&a)?)))
         })
         .collect::<Result<Vec<_>, Error>>()?;
     let name = &input.ident;
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 0e5a5728908..3c056652666 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -60,7 +60,7 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "unrecognized field `defalt`"
+        "Expected one of `default` or `rename`"
     );
     // Check that repeated attributes are not allowed:
     derive_compile_fail!(
@@ -73,7 +73,8 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "`rename` can only be used at most once"
+        "Duplicate argument",
+        "Already used here",
     );
     derive_compile_fail!(
         derive_device_or_error,
@@ -85,7 +86,8 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "`default` can only be used at most once"
+        "Duplicate argument",
+        "Already used here",
     );
     // Check that the field name is preserved when `rename` isn't used:
     derive_compile!(
-- 
2.50.1


