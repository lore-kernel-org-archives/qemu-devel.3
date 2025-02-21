Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375F7C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 17:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlWRi-0007IO-Ro; Fri, 21 Feb 2025 12:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRd-0006xM-V8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlWRb-0001S4-U6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 12:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740157447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gNzmdewlktR1o4K/cScPLtSavMlzl0xOpm3FGIzKcy0=;
 b=Y7SABWXXW63K+9e2dCAg1OGOhUl7Kd/HivTifnZRQhPP8KJdoTR+IoZ6K7CM4J+q+ODzPd
 e5bwuRlDrlxJ4Hm588G01tsUpljzMjJN/xg4Xz6zpxvet+ttEpGT0n2BWbDZxNhJDI1/h3
 6DQ/C55OFbakHVhvOHpfKa1DSnVuhfk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-5VMpccZcNIOP1359bFSllg-1; Fri, 21 Feb 2025 12:04:05 -0500
X-MC-Unique: 5VMpccZcNIOP1359bFSllg-1
X-Mimecast-MFC-AGG-ID: 5VMpccZcNIOP1359bFSllg_1740157444
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f36f03312so1130563f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 09:04:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740157443; x=1740762243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gNzmdewlktR1o4K/cScPLtSavMlzl0xOpm3FGIzKcy0=;
 b=B30FVP+ATqku6LI89/L9BV56zV+NE/EauEeV/VmiXT5kQTQxZIwrVPOuWAV1Pm8x31
 fxqd5rZFaUnEIOQEGpGX2vK77YwANQ/s2rf8gSvk2rU0nASHcPXX1yFtxhmgq45afZLZ
 wTDZu4CL7Qo0U3/CvitwpOaz8aU39k8vWphVi4Pe7BTXc/+1qVLyKgoiXnWGQ0Jrm6+8
 WlTE1lUDuQ/u5LjTE19EjMW9MsGFRsbuWBD66TO34MT2VBhenVek5cn6FvAUMsVvjxSk
 57fP5madiztVxxlljbxR7xPBQAEYdREknNdF0gYYxQxSuTXIohd++8DoCg+yvaR61zyS
 6Swg==
X-Gm-Message-State: AOJu0YwQB/HAN+tfdAGuhTeaXtafsNMpBMvJwJHf1w9YcwfjFuqdDz9e
 RPyza9rZFTs4rI1fh0JIr6mqclbgbu9q4w+hhcznzDfpGudB6uwducTikDFbfPzzHoa6787kFmg
 m8fhRwb4oxaMzfp7/TETlZtFE7a+jvFqNOirS+7/P6pMxnhXwtiG19Iq8gwkk/J5/nXc9ewMMF4
 A/AZkoB3DzUNZEzsvQAR/HGfhymeTxW2vL4ijWIUg=
X-Gm-Gg: ASbGncvd76IoHwIagCpvFR05UttnVFSLtlICWMOT5lPBwUc+rY8Y/EtDfU13EW7D3Yz
 fhBc4E+JGOVA3CqkdWb8zVFihZiLyd1UN7G7/28kRXZjAV8H3+OkACzNa3mlxmltxD7+kL6kSWs
 5nsVcElxVUIHk+p4dLB8Np/0EPs/Zj0xJahbiUY1dd77EgqcuxSjoUYhwbA3wggzptf5YTSbHNm
 wLUKAyac9PNr+cc4V6C2N9ZcpnmYRKIxYupkE0AtRzc9UrLXLmaQLdxGSyMZfS7XpTfAA+STpFT
 lVZxYojr6MtJB5gCYcQ=
X-Received: by 2002:a05:6000:144a:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-38f6e7579e0mr2240550f8f.7.1740157441411; 
 Fri, 21 Feb 2025 09:04:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFIfNlkw2aTy/ScMYSgifoXhFGn8mMiTLNr3x9N+9gX7sv64GeERh/Ti9Kx0/Z/bQw7ou7CQ==
X-Received: by 2002:a05:6000:144a:b0:38d:e092:3ced with SMTP id
 ffacd0b85a97d-38f6e7579e0mr2240433f8f.7.1740157439353; 
 Fri, 21 Feb 2025 09:03:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.61.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8273sm23366483f8f.89.2025.02.21.09.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:03:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 07/15] rust: qemu_api_macros: add Wrapper derive macro
Date: Fri, 21 Feb 2025 18:03:34 +0100
Message-ID: <20250221170342.63591-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170342.63591-1-pbonzini@redhat.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add a derive macro that makes it easy to peel off all the layers of
specialness (UnsafeCell, MaybeUninit, etc.) and just get a pointer
to the wrapped type; and likewise add them back starting from a
*mut.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst             |  8 ++--
 rust/qemu-api-macros/src/lib.rs | 82 ++++++++++++++++++++++++++++++++-
 rust/qemu-api/meson.build       |  7 +--
 rust/qemu-api/src/cell.rs       | 31 +++++++++++++
 4 files changed, 119 insertions(+), 9 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 9a621648e72..db2b427ebd2 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -314,11 +314,13 @@ a raw pointer, for use in calls to C functions.  It can be used for
 example as follows::
 
     #[repr(transparent)]
-    #[derive(Debug)]
+    #[derive(Debug, qemu_api_macros::Wrapper)]
     pub struct Object(Opaque<bindings::Object>);
 
-The bindings will then manually check for the big QEMU lock with
-assertions, which allows the wrapper to be declared thread-safe::
+where the special ``derive`` macro provides useful methods such as
+``from_raw``, ``as_ptr`` and ``as_mut_ptr``.  The bindings will then
+manually check for the big QEMU lock with assertions, which allows
+the wrapper to be declared thread-safe::
 
     unsafe impl Send for Object {}
     unsafe impl Sync for Object {}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 7ec218202f4..781e5271562 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -6,7 +6,7 @@
 use quote::quote;
 use syn::{
     parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
-    DeriveInput, Field, Fields, Ident, Meta, Path, Token, Type, Variant, Visibility,
+    DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Type, Variant, Visibility,
 };
 
 mod utils;
@@ -33,6 +33,35 @@ fn get_fields<'a>(
     }
 }
 
+fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, MacroError> {
+    if let Data::Struct(s) = &input.data {
+        let unnamed = match &s.fields {
+            Fields::Unnamed(FieldsUnnamed {
+                unnamed: ref fields,
+                ..
+            }) => fields,
+            _ => {
+                return Err(MacroError::Message(
+                    format!("Tuple struct required for {}", msg),
+                    s.fields.span(),
+                ))
+            }
+        };
+        if unnamed.len() != 1 {
+            return Err(MacroError::Message(
+                format!("A single field is required for {}", msg),
+                s.fields.span(),
+            ));
+        }
+        Ok(&unnamed[0])
+    } else {
+        Err(MacroError::Message(
+            format!("Struct required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
+
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
     let expected = parse_quote! { #[repr(C)] };
 
@@ -46,6 +75,19 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
     }
 }
 
+fn is_transparent_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
+    let expected = parse_quote! { #[repr(transparent)] };
+
+    if input.attrs.iter().any(|attr| attr == &expected) {
+        Ok(())
+    } else {
+        Err(MacroError::Message(
+            format!("#[repr(transparent)] required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
+
 fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(Object)]")?;
 
@@ -72,6 +114,44 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
     TokenStream::from(expanded)
 }
 
+fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
+    is_transparent_repr(&input, "#[derive(Wrapper)]")?;
+
+    let name = &input.ident;
+    let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
+    let typ = &field.ty;
+
+    // TODO: how to add "::qemu_api"?  For now, this is only used in the
+    // qemu_api crate so it's not a problem.
+    Ok(quote! {
+        unsafe impl crate::cell::Wrapper for #name {
+            type Wrapped = <#typ as crate::cell::Wrapper>::Wrapped;
+        }
+        impl #name {
+            pub unsafe fn from_raw<'a>(ptr: *mut <Self as crate::cell::Wrapper>::Wrapped) -> &'a Self {
+                let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
+                unsafe { ptr.as_ref() }
+            }
+
+            pub const fn as_mut_ptr(&self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+                self.0.as_mut_ptr()
+            }
+
+            pub const fn as_ptr(&self) -> *const <Self as crate::cell::Wrapper>::Wrapped {
+                self.0.as_ptr()
+            }
+        }
+    })
+}
+
+#[proc_macro_derive(Wrapper)]
+pub fn derive_opaque(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_opaque_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
+}
+
 #[rustfmt::skip::macros(quote)]
 fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(offsets)]")?;
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index bcf1cf780f3..6e52c4bad74 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -42,16 +42,13 @@ _qemu_api_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   rust_args: _qemu_api_cfg,
-  dependencies: libc_dep,
+  dependencies: [libc_dep, qemu_api_macros],
 )
 
 rust.test('rust-qemu-api-tests', _qemu_api_rs,
           suite: ['unit', 'rust'])
 
-qemu_api = declare_dependency(
-  link_with: _qemu_api_rs,
-  dependencies: qemu_api_macros,
-)
+qemu_api = declare_dependency(link_with: _qemu_api_rs)
 
 # Rust executables do not support objects, so add an intermediate step.
 rust_qemu_api_objs = static_library(
diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
index 84b9eb07467..c39b9616969 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -1017,3 +1017,34 @@ pub fn new() -> Self {
         Self::default()
     }
 }
+
+/// Annotates [`Self`] as a transparent wrapper for another type.
+///
+/// Usually defined via the [`qemu_api_macros::Wrapper`] derive macro.
+///
+/// # Examples
+///
+/// ```
+/// # use std::mem::ManuallyDrop;
+/// # use qemu_api::cell::Wrapper;
+/// #[repr(transparent)]
+/// pub struct Example {
+///     inner: ManuallyDrop<String>,
+/// }
+///
+/// unsafe impl Wrapper for Example {
+///     type Wrapped = String;
+/// }
+/// ```
+///
+/// # Safety
+///
+/// `Self` must be a `#[repr(transparent)]` wrapper for the `Wrapped` type,
+/// whether directly or indirectly.
+pub unsafe trait Wrapper {
+    type Wrapped;
+}
+
+unsafe impl<T> Wrapper for Opaque<T> {
+    type Wrapped = T;
+}
-- 
2.48.1


