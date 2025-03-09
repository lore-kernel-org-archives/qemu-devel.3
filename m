Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1AEC282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwZ-000801-Ol; Sun, 09 Mar 2025 06:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwY-0007zX-KN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwW-000407-OX
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zc9FIm4JAe4PY9QTV9e+w4Xx2pwitv+RMwdbYEMBz+Q=;
 b=BEKOmTILacvPv6P3EvNjPVQMHCAicSrTA+l7MbrurA3GJAc9ROmzGCxTLw25+RX+s449op
 sWQ5F/XS2J6+BFrby/IrBG99Hmyt3nx1ffOM8ysL1udYuRNBfYvivyEaLctmjapx4iya+N
 glCzFg7fBFMyMY0oeIqj40KZxqCftd0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-L3iNhFF8M6GnkN2pYuwSiw-1; Sun, 09 Mar 2025 06:31:34 -0400
X-MC-Unique: L3iNhFF8M6GnkN2pYuwSiw-1
X-Mimecast-MFC-AGG-ID: L3iNhFF8M6GnkN2pYuwSiw_1741516293
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3911232fd8bso1941461f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516291; x=1742121091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc9FIm4JAe4PY9QTV9e+w4Xx2pwitv+RMwdbYEMBz+Q=;
 b=DKSSxGsGY7swwtM/ZK/6LhC85Soz1m/FixZoJlSmc7GeM8HcuIT0MY0xjO2xBHIEmR
 ZvELrlDqpB0U8LK5sF+i+Yvazm2a8YuI251GzWymEd13yR/m8UlJbZ6QuuV1Aw6AuAIm
 ffBaAabkKNzpic2AUHPa+VwzXd0mchYnOzSk/evj6TGGxVb3ICeUVhhJ97PuY97/oVqn
 MVpcCQL57G2o+8l4FEG4dJg+xBEca9PUZqx+Fsc7IsDBliBuCfn981MIM2YTfb2gjWfk
 vie1MdM8IkaAGwQ2vQ/LLtbx2DnCLcu8bkpslURcR0AiIxGsg4FVxtjnD07unZsMC1KH
 a1JA==
X-Gm-Message-State: AOJu0YyGrL/l0LxZhUWB6olUiOFM4YZBkwqE4nLwxXWRmNnwezw6Ai8X
 gTUK8ZXc2WFBlNqKoRIDRQXgjppW5iZdmlCuWLmBz5O60vhex9ONOcnkvB994Cf/y7Ard2ZhNB1
 llaNMWs+p6lHwhjs0FmxdMGDOkHuhIeS6p4dBjgDkxLCf8yCqcnpmNiwPIc5lLG6HK5fToUdnXj
 L7aaQkZlQLyrb4dEqXr+shnY7dqnzq0UnuM9iJ+9A=
X-Gm-Gg: ASbGncsRdxq4jSOZeZ9pC/o+Ru6RjPjZBsfuGUVFGorq5/uMVqolDI4KMpNvk8NNZv8
 /u/Ep1mRQn2lKCu7ymTKnfRPbRGGLnpmPW/60XdWI+FHNs68xMJvPqdG2LSfb4fDXgN7e7FMe3R
 HGL9+88kj3GlTaGbTbQhT8lT8U8wNOG/ReDHCbZLwqUhlA2kwOv3KuEW0/IMM1p9nzZSy66QlMO
 y0RIfB6WW31H3Fu6UqLXT90QdTn3JVIYvyz3rztsJx6mloo+0ew4pJJqjmpWO0XcTO/fP33M6RE
 BaryBURYvV8W6Lldp5+rjg==
X-Received: by 2002:a05:6000:1844:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-39132dbb511mr7387771f8f.39.1741516291480; 
 Sun, 09 Mar 2025 03:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi3FSPUY5T8blrpgOA/ktkboI2JQ1UP6+t/U1Hataa2xqYXOylQGP1gmuBw86VfmOJN4yIyQ==
X-Received: by 2002:a05:6000:1844:b0:38f:4fa6:bb24 with SMTP id
 ffacd0b85a97d-39132dbb511mr7387752f8f.39.1741516291009; 
 Sun, 09 Mar 2025 03:31:31 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfdfdsm11812348f8f.34.2025.03.09.03.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/25] rust: qemu_api_macros: add Wrapper derive macro
Date: Sun,  9 Mar 2025 11:30:58 +0100
Message-ID: <20250309103120.1116448-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Add a derive macro that makes it easy to peel off all the layers of
specialness (UnsafeCell, MaybeUninit, etc.) and just get a pointer
to the wrapped type; and likewise add them back starting from a
*mut.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst             |  8 +--
 rust/qemu-api-macros/src/lib.rs | 90 ++++++++++++++++++++++++++++++++-
 rust/qemu-api/meson.build       |  7 +--
 rust/qemu-api/src/cell.rs       | 45 +++++++++++++++++
 4 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 784c3e40bdc..88bdec1eb28 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -315,11 +315,13 @@ a raw pointer, for use in calls to C functions.  It can be used for
 example as follows::
 
     #[repr(transparent)]
-    #[derive(Debug)]
+    #[derive(Debug, qemu_api_macros::Wrapper)]
     pub struct Object(Opaque<bindings::Object>);
 
-The bindings will then manually check for the big QEMU lock with
-assertions, which allows the wrapper to be declared thread-safe::
+where the special ``derive`` macro provides useful methods such as
+``from_raw``, ``as_ptr`, ``as_mut_ptr`` and ``raw_get``.  The bindings will
+then manually check for the big QEMU lock with assertions, which allows
+the wrapper to be declared thread-safe::
 
     unsafe impl Send for Object {}
     unsafe impl Sync for Object {}
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 7ec218202f4..eda0d46d122 100644
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
 
@@ -72,6 +114,52 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
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
+
+            pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
+                self.0.as_void_ptr()
+            }
+
+            pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
+                slot.cast()
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
index 2889abb868e..448638e8967 100644
--- a/rust/qemu-api/src/cell.rs
+++ b/rust/qemu-api/src/cell.rs
@@ -1030,3 +1030,48 @@ pub unsafe fn new() -> Self {
         }
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
+///
+/// # Methods
+///
+/// By convention, types that implement Wrapper also implement the following
+/// methods:
+///
+/// ```ignore
+/// pub const unsafe fn from_raw<'a>(value: *mut Self::Wrapped) -> &'a Self;
+/// pub const unsafe fn as_mut_ptr(&self) -> *mut Self::Wrapped;
+/// pub const unsafe fn as_ptr(&self) -> *const Self::Wrapped;
+/// pub const unsafe fn raw_get(slot: *mut Self) -> *const Self::Wrapped;
+/// ```
+///
+/// They are not defined here to allow them to be `const`.
+pub unsafe trait Wrapper {
+    type Wrapped;
+}
+
+unsafe impl<T> Wrapper for Opaque<T> {
+    type Wrapped = T;
+}
-- 
2.48.1


