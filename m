Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38903E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIq-0002IU-Q9; Thu, 19 Dec 2024 11:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOb-0006F8-Qn
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOa-0008Ig-1E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5CE9shW3ftWbl1V1SBQeRNzap/cYi489BVwR842VWpQ=;
 b=RAuV5t8jrKb+CdzFcJ2QhSgHE8z2tOojpORD3sFEG0QVWfRUFpfc4/bDt5msqkCg3xPDEZ
 /zdAVxtjFhJXvduHC839ZebRklmX5lgo0vqCi52kqVFLgoNT0WUnuNOWCa5KKWkcIzW3G3
 dpOPm2QGlTXv3U32DqrCDPp+YGr5wdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-RoehPfcONdid58Ylk8sDRw-1; Thu, 19 Dec 2024 07:12:43 -0500
X-MC-Unique: RoehPfcONdid58Ylk8sDRw-1
X-Mimecast-MFC-AGG-ID: RoehPfcONdid58Ylk8sDRw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43623bf2a83so6110855e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610361; x=1735215161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CE9shW3ftWbl1V1SBQeRNzap/cYi489BVwR842VWpQ=;
 b=Z20wXL1gmDRFHs2mH1i0SuLoXmr2pljddTmZO3CgrDPYKRggvnrNmLusGnbRMNiVIx
 y10ZLqD6yLMdM1LFZ3KNTzkcjB3rpUuilHyAM6J1YvZg+TqLjGyzS+c6JiBZz46mK1iK
 ze5iXzZo88Vz+5J30yInP+L9isA85WUMNzPO1UTd5pG1v4NUx9vp6OsrsSWSHgetS3LY
 RVd3NsuHfFKfdkY8ofQWcM4jcLam7e9nFu9FPJ2Kzy3GyNCU7/51Q69cGYEHnL1w0wpV
 JfNx6s9WyTaMKKE+Go9XoJz8Lm9wDwIiicDOPQfxH0/VNw893cLDrN5f4xWK3yK5EzVp
 Iiqw==
X-Gm-Message-State: AOJu0YxAGThBvkVvwziKvFwRlc4qR9b939/SaoJLdlHt6Lknjsrg+jZp
 SbjADor3cfb+xODzq/r84+vIH7LfRiyoWi03YjG/lUhGnwm1m3oyMWmFiopDd4VHJxFlF9zm8DS
 kqVpcgosj3SSAuw4Ip/a6C4Tt17YG7+qDlWl+YGiYELyHFXRxbrDZ5t4jiTOudbo4vRwUyVLGYZ
 BNb/Y8jGsAF5fzqM+VDTH7YX8HDJHNb3wXnL2i
X-Gm-Gg: ASbGncts4/dWTEGCPoUs2MdLx6M2uTv6NH6XexrWDqyU6d17qHujJBdtERO72KvewxP
 VPAFYdJsX/pY9fNwWv2BTYXIZG6yF8NPE++oIl2ASW4cSVTHRs6NjUPqgcFvbDcB47XyCbk5/Rw
 thzjSqec7tbIQ0m5RmbjCqeuT4X4x9Kme+jGM3JGq1wKTVdVlKebWIdFf0L5uXq5j7dwYSQVi6Y
 VeEG/qRKdYesfFKo5JPaB/bDKnKIlMO0/1jGr4GWXDZlcS1daKaorAnFgSf
X-Received: by 2002:a05:600c:3ca1:b0:434:fd77:5436 with SMTP id
 5b1f17b1804b1-4365536f8eemr73738815e9.15.1734610360565; 
 Thu, 19 Dec 2024 04:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkPkv1lZx0+WC10VUGiiF9xcKhQWsT7rQcdcJRSaghwVuOXGOEhUoIP4n7wShv7b5j9hzDWQ==
X-Received: by 2002:a05:600c:3ca1:b0:434:fd77:5436 with SMTP id
 5b1f17b1804b1-4365536f8eemr73738435e9.15.1734610360083; 
 Thu, 19 Dec 2024 04:12:40 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661218f43sm16579525e9.19.2024.12.19.04.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 10/10] rust: qemu-api-macros: add automatic TryFrom/TryInto
 derivation
Date: Thu, 19 Dec 2024 13:12:16 +0100
Message-ID: <20241219121216.416905-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
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


