Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7DFCA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSZ-00067r-H1; Mon, 08 Sep 2025 06:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSX-00066e-8G
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSC-0005zg-RU
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sN1USyIDQg2wAS4HLaXWN+O8GKxfsw4+4kDOL0kc8Sg=;
 b=IEWeLxXeE8bskEJnLJ25nflxgLTE5wu1LWm80m1GFCa8TRVxdzYFG7DTOqGLjNnotdZT3M
 GmL/57KSiLJbu6KxPTGPE6ny13Svva6QN8FR+5EX7I7NqtoI/oIhXFnHvnz7a/OMDefFu3
 SsDobOFMmUTP+Zs6rO0LjG4vmtQ2f80=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-PDZta-tbNSSjUoWAwgVVLA-1; Mon, 08 Sep 2025 06:50:24 -0400
X-MC-Unique: PDZta-tbNSSjUoWAwgVVLA-1
X-Mimecast-MFC-AGG-ID: PDZta-tbNSSjUoWAwgVVLA_1757328623
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so29461115e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328622; x=1757933422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sN1USyIDQg2wAS4HLaXWN+O8GKxfsw4+4kDOL0kc8Sg=;
 b=ID10T29DIrEGwA+syR5BgiIbziRKUkyYTWxFvQTomjsaBvXMHqG+jDDdPgRkZPygjW
 XWnDbfQAhNEl08zbKdSbCgVLdR4kK0GOdyLLfMA+sHw8MxZ8DH/lbtgvjj+9YuGr/BXf
 CazjKV2q4AT1cxg/3HInJUEPudWTZzt5wz8vIaVL+s3KeGZkTLB8RqAStHT8oe/bSL0S
 xPI1RbFUBaOIkU0O+yAKr4zjnKn/N4rEXPlPwsiDiyDc40G3s/VKLrHTAe8DkqDmvN95
 CjMM1dMI/JNInGlv49/mR/1Be2hWWtIQ6BuAORJkZ+MjOd3rlJq/du7lKoclEdNO2Q4z
 Dorg==
X-Gm-Message-State: AOJu0YzbTDtZVVU32VnM3AMO9Z/ky/re+g43k627jO07wuKKxuZ/wyDc
 qLX9Cj39HO8V9zveQ6ngMaoyjlmfNdBwBfY4iIeQ5btYc6xKJHSFnYREfoSihMCZv1zOLUxmHGS
 ptfP6LwEva4IeTXEYlFjMIdAJlJN7P4JDMHOzqipii+Y1kUE1TIg02CyfgggKKhs4ffuPhMPq7k
 +fJbkxQOPoV9tdA3xppMbtrvxZsjeW7VB572pS2asj
X-Gm-Gg: ASbGncu/zO+pNoJXMA97c6YmZPMjA1HylXFyMRXSfKK5hvQ5sIUX0ejoP+JiMtJkvnE
 2xBUp3pbAo87m6Ks9KNOS8wtIX1dOheKPJKwLVCIYEAGMJ/nhh9pGgjPtoLVHhsUJLYLtqLSowA
 7qbUsTt0ejQxNWQ1huCuF9vJZzm2kGRIeJ0Isg0iSG7CNX+R7J1LxbA/JSovh0zBbTseLBQFoLf
 dws+nh+Vl7TgK6NztJ9lKi8QehSsJJCHB+K9LdEM6LJs90NIGwUUqrM6xgvT5a3YQ3jVA0c1Ufe
 gi7+kE38PIdzdrwc4zJDqWcvaPUgETPEbe8rG40mx73ooIywsdbiWXzeri2Lq+8qieqT3nT+1ZE
 zsWc0KTDibk2lUP8RXyqPWaKYteaZ2ecwyrTgu9ibLqw=
X-Received: by 2002:a05:600c:4e93:b0:45d:e0d8:a0aa with SMTP id
 5b1f17b1804b1-45de0d8a342mr70320825e9.17.1757328621424; 
 Mon, 08 Sep 2025 03:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH10HtqrIisJ6gUY/X2CHwCHtBSfb6ARFFm6aBFJ6NFULumDNUma3p3We7PmgZHu9cUrFRZjQ==
X-Received: by 2002:a05:600c:4e93:b0:45d:e0d8:a0aa with SMTP id
 5b1f17b1804b1-45de0d8a342mr70320195e9.17.1757328620663; 
 Mon, 08 Sep 2025 03:50:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e50e30asm440811325e9.24.2025.09.08.03.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH 06/33] rust: add qdev Device derive macro
Date: Mon,  8 Sep 2025 12:49:38 +0200
Message-ID: <20250908105005.2119297-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add derive macro for declaring qdev properties directly above the field
definitions. To do this, we split DeviceImpl::properties method on a
separate trait so we can implement only that part in the derive macro
expansion (we cannot partially implement the DeviceImpl trait).

Adding a `property` attribute above the field declaration will generate
a `qemu_api::bindings::Property` array member in the device's property
list.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20250711-rust-qdev-properties-v3-1-e198624416fb@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs  |  31 +-----
 rust/hw/timer/hpet/src/device.rs  |   6 +-
 rust/qemu-api-macros/src/lib.rs   | 152 +++++++++++++++++++++++++++++-
 rust/qemu-api-macros/src/tests.rs | 111 ++++++++++++++++++++++
 rust/qemu-api/src/qdev.rs         |  70 ++++++++++++--
 rust/qemu-api/tests/tests.rs      |  24 +----
 6 files changed, 336 insertions(+), 58 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ceb71dd99b6..37944635202 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,7 +9,6 @@
 };
 
 use qemu_api::{
-    bindings::{qdev_prop_bool, qdev_prop_chr},
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
@@ -17,7 +16,7 @@
     log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, Owned, ParentField, ParentInit},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -105,12 +104,13 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
     pub iomem: MemoryRegion,
     #[doc(alias = "chr")]
+    #[property(rename = "chardev")]
     pub char_backend: CharBackend,
     pub regs: BqlRefCell<PL011Registers>,
     /// QEMU interrupts
@@ -129,6 +129,7 @@ pub struct PL011State {
     #[doc(alias = "clk")]
     pub clock: Owned<Clock>,
     #[doc(alias = "migrate_clk")]
+    #[property(rename = "migrate-clk", default = true)]
     pub migrate_clock: bool,
 }
 
@@ -176,9 +177,6 @@ impl ObjectImpl for PL011State {
 }
 
 impl DeviceImpl for PL011State {
-    fn properties() -> &'static [Property] {
-        &PL011_PROPERTIES
-    }
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_PL011)
     }
@@ -690,7 +688,7 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
@@ -782,22 +780,3 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
     },
     ..Zeroable::ZERO
 };
-
-qemu_api::declare_properties! {
-    PL011_PROPERTIES,
-    qemu_api::define_property!(
-        c"chardev",
-        PL011State,
-        char_backend,
-        unsafe { &qdev_prop_chr },
-        CharBackend
-    ),
-    qemu_api::define_property!(
-        c"migrate-clk",
-        PL011State,
-        migrate_clock,
-        unsafe { &qdev_prop_bool },
-        bool,
-        default = true
-    ),
-}
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index acf7251029e..01d5a0dd70c 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -1031,11 +1031,15 @@ impl ObjectImpl for HPETState {
     ..Zeroable::ZERO
 };
 
-impl DeviceImpl for HPETState {
+// SAFETY: HPET_PROPERTIES is a valid Property array constructed with the
+// qemu_api::declare_properties macro.
+unsafe impl qemu_api::qdev::DevicePropertiesImpl for HPETState {
     fn properties() -> &'static [Property] {
         &HPET_PROPERTIES
     }
+}
 
+impl DeviceImpl for HPETState {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_HPET)
     }
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 959726efe6d..97b2c214b62 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,10 +3,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::quote;
+use quote::{quote, quote_spanned, ToTokens};
 use syn::{
-    parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
-    DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Variant,
+    parse::Parse, parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned,
+    token::Comma, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
+    Variant,
 };
 mod bits;
 use bits::BitsConstInternal;
@@ -152,6 +153,151 @@ pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::qemu_api::cell::Wrapper
     })
 }
 
+#[derive(Debug)]
+enum DevicePropertyName {
+    CStr(syn::LitCStr),
+    Str(syn::LitStr),
+}
+
+#[derive(Debug)]
+struct DeviceProperty {
+    rename: Option<DevicePropertyName>,
+    defval: Option<syn::Expr>,
+}
+
+impl Parse for DeviceProperty {
+    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
+        let _: syn::Token![#] = input.parse()?;
+        let bracketed;
+        _ = syn::bracketed!(bracketed in input);
+        let attribute = bracketed.parse::<syn::Ident>()?;
+        debug_assert_eq!(&attribute.to_string(), "property");
+        let mut retval = Self {
+            rename: None,
+            defval: None,
+        };
+        let content;
+        _ = syn::parenthesized!(content in bracketed);
+        while !content.is_empty() {
+            let value: syn::Ident = content.parse()?;
+            if value == "rename" {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.rename.is_some() {
+                    return Err(syn::Error::new(
+                        value.span(),
+                        "`rename` can only be used at most once",
+                    ));
+                }
+                if content.peek(syn::LitStr) {
+                    retval.rename = Some(DevicePropertyName::Str(content.parse::<syn::LitStr>()?));
+                } else {
+                    retval.rename =
+                        Some(DevicePropertyName::CStr(content.parse::<syn::LitCStr>()?));
+                }
+            } else if value == "default" {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.defval.is_some() {
+                    return Err(syn::Error::new(
+                        value.span(),
+                        "`default` can only be used at most once",
+                    ));
+                }
+                retval.defval = Some(content.parse()?);
+            } else {
+                return Err(syn::Error::new(
+                    value.span(),
+                    format!("unrecognized field `{value}`"),
+                ));
+            }
+
+            if !content.is_empty() {
+                let _: syn::Token![,] = content.parse()?;
+            }
+        }
+        Ok(retval)
+    }
+}
+
+#[proc_macro_derive(Device, attributes(property))]
+pub fn derive_device(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+
+    derive_device_or_error(input)
+        .unwrap_or_else(syn::Error::into_compile_error)
+        .into()
+}
+
+fn derive_device_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, Error> {
+    is_c_repr(&input, "#[derive(Device)]")?;
+    let properties: Vec<(syn::Field, DeviceProperty)> = get_fields(&input, "#[derive(Device)]")?
+        .iter()
+        .flat_map(|f| {
+            f.attrs
+                .iter()
+                .filter(|a| a.path().is_ident("property"))
+                .map(|a| Ok((f.clone(), syn::parse2(a.to_token_stream())?)))
+        })
+        .collect::<Result<Vec<_>, Error>>()?;
+    let name = &input.ident;
+    let mut properties_expanded = vec![];
+
+    for (field, prop) in properties {
+        let DeviceProperty { rename, defval } = prop;
+        let field_name = field.ident.unwrap();
+        macro_rules! str_to_c_str {
+            ($value:expr, $span:expr) => {{
+                let (value, span) = ($value, $span);
+                let cstr = std::ffi::CString::new(value.as_str()).map_err(|err| {
+                    Error::new(
+                        span,
+                        format!(
+                            "Property name `{value}` cannot be represented as a C string: {err}"
+                        ),
+                    )
+                })?;
+                let cstr_lit = syn::LitCStr::new(&cstr, span);
+                Ok(quote! { #cstr_lit })
+            }};
+        }
+
+        let prop_name = rename.map_or_else(
+            || str_to_c_str!(field_name.to_string(), field_name.span()),
+            |rename| -> Result<proc_macro2::TokenStream, Error> {
+                match rename {
+                    DevicePropertyName::CStr(cstr_lit) => Ok(quote! { #cstr_lit }),
+                    DevicePropertyName::Str(str_lit) => {
+                        str_to_c_str!(str_lit.value(), str_lit.span())
+                    }
+                }
+            },
+        )?;
+        let field_ty = field.ty.clone();
+        let qdev_prop = quote! { <#field_ty as ::qemu_api::qdev::QDevProp>::VALUE };
+        let set_default = defval.is_some();
+        let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
+        properties_expanded.push(quote! {
+            ::qemu_api::bindings::Property {
+                name: ::std::ffi::CStr::as_ptr(#prop_name),
+                info: #qdev_prop ,
+                offset: ::core::mem::offset_of!(#name, #field_name) as isize,
+                set_default: #set_default,
+                defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
+                ..::qemu_api::zeroable::Zeroable::ZERO
+            }
+        });
+    }
+
+    Ok(quote_spanned! {input.span() =>
+        unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for #name {
+            fn properties() -> &'static [::qemu_api::bindings::Property] {
+                static PROPERTIES: &[::qemu_api::bindings::Property] = &[#(#properties_expanded),*];
+
+                PROPERTIES
+            }
+        }
+    })
+}
+
 #[proc_macro_derive(Wrapper)]
 pub fn derive_opaque(input: TokenStream) -> TokenStream {
     let input = parse_macro_input!(input as DeriveInput);
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
index 6028cdbc4c3..aafffcdce91 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -36,6 +36,117 @@ macro_rules! derive_compile {
     }};
 }
 
+#[test]
+fn test_derive_device() {
+    // Check that repr(C) is used
+    derive_compile_fail!(
+        derive_device_or_error,
+        quote! {
+            #[derive(Device)]
+            struct Foo {
+                _unused: [u8; 0],
+            }
+        },
+        "#[repr(C)] required for #[derive(Device)]"
+    );
+    // Check that invalid/misspelled attributes raise an error
+    derive_compile_fail!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            struct DummyState {
+                #[property(defalt = true)]
+                migrate_clock: bool,
+            }
+        },
+        "unrecognized field `defalt`"
+    );
+    // Check that repeated attributes are not allowed:
+    derive_compile_fail!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            struct DummyState {
+                #[property(rename = "migrate-clk", rename = "migrate-clk", default = true)]
+                migrate_clock: bool,
+            }
+        },
+        "`rename` can only be used at most once"
+    );
+    derive_compile_fail!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            struct DummyState {
+                #[property(default = true, default = true)]
+                migrate_clock: bool,
+            }
+        },
+        "`default` can only be used at most once"
+    );
+    // Check that the field name is preserved when `rename` isn't used:
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(default = true)]
+                migrate_clock: bool,
+            }
+        },
+        quote! {
+            unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
+                fn properties() -> &'static [::qemu_api::bindings::Property] {
+                    static PROPERTIES: &[::qemu_api::bindings::Property] =
+                        &[::qemu_api::bindings::Property {
+                            name: ::std::ffi::CStr::as_ptr(c"migrate_clock"),
+                            info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
+                            offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
+                            set_default: true,
+                            defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                            ..::qemu_api::zeroable::Zeroable::ZERO
+                        }];
+                    PROPERTIES
+                }
+            }
+        }
+    );
+    // Check that `rename` value is used for the property name when used:
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(rename = "migrate-clk", default = true)]
+                migrate_clock: bool,
+            }
+        },
+        quote! {
+            unsafe impl ::qemu_api::qdev::DevicePropertiesImpl for DummyState {
+                fn properties() -> &'static [::qemu_api::bindings::Property] {
+                    static PROPERTIES: &[::qemu_api::bindings::Property] =
+                        &[::qemu_api::bindings::Property {
+                            name: ::std::ffi::CStr::as_ptr(c"migrate-clk"),
+                            info: <bool as ::qemu_api::qdev::QDevProp>::VALUE,
+                            offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
+                            set_default: true,
+                            defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                            ..::qemu_api::zeroable::Zeroable::ZERO
+                        }];
+                    PROPERTIES
+                }
+            }
+        }
+    );
+}
+
 #[test]
 fn test_derive_object() {
     derive_compile_fail!(
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 52d54a4494e..6a58a00e3fc 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -101,8 +101,67 @@ pub trait ResettablePhasesImpl {
     T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
 }
 
+/// Helper trait to return pointer to a [`bindings::PropertyInfo`] for a type.
+///
+/// This trait is used by [`qemu_api_macros::Device`] derive macro.
+///
+/// Base types that already have `qdev_prop_*` globals in the QEMU API should
+/// use those values as exported by the [`bindings`] module, instead of
+/// redefining them.
+///
+/// # Safety
+///
+/// This trait is marked as `unsafe` because currently having a `const` refer to
+/// an `extern static` as a reference instead of a raw pointer results in this
+/// compiler error:
+///
+/// ```text
+/// constructing invalid value: encountered reference to `extern` static in `const`
+/// ```
+///
+/// This is because the compiler generally might dereference a normal reference
+/// during const evaluation, but not in this case (if it did, it'd need to
+/// dereference the raw pointer so this would fail to compile).
+///
+/// It is the implementer's responsibility to provide a valid
+/// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
+pub unsafe trait QDevProp {
+    const VALUE: *const bindings::PropertyInfo;
+}
+
+/// Use [`bindings::qdev_prop_bool`] for `bool`.
+unsafe impl QDevProp for bool {
+    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_bool };
+}
+
+/// Use [`bindings::qdev_prop_uint64`] for `u64`.
+unsafe impl QDevProp for u64 {
+    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_uint64 };
+}
+
+/// Use [`bindings::qdev_prop_chr`] for [`crate::chardev::CharBackend`].
+unsafe impl QDevProp for crate::chardev::CharBackend {
+    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_chr };
+}
+
+/// Trait to define device properties.
+///
+/// # Safety
+///
+/// Caller is responsible for the validity of properties array.
+pub unsafe trait DevicePropertiesImpl {
+    /// An array providing the properties that the user can set on the
+    /// device.  Not a `const` because referencing statics in constants
+    /// is unstable until Rust 1.83.0.
+    fn properties() -> &'static [Property] {
+        &[]
+    }
+}
+
 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
+pub trait DeviceImpl:
+    ObjectImpl + ResettablePhasesImpl + DevicePropertiesImpl + IsA<DeviceState>
+{
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
@@ -111,13 +170,6 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
     /// with the function pointed to by `REALIZE`.
     const REALIZE: Option<fn(&Self) -> Result<()>> = None;
 
-    /// An array providing the properties that the user can set on the
-    /// device.  Not a `const` because referencing statics in constants
-    /// is unstable until Rust 1.83.0.
-    fn properties() -> &'static [Property] {
-        &[]
-    }
-
     /// A `VMStateDescription` providing the migration format for the device
     /// Not a `const` because referencing statics in constants is unstable
     /// until Rust 1.83.0.
@@ -175,7 +227,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             self.vmsd = vmsd;
         }
-        let prop = <T as DeviceImpl>::properties();
+        let prop = <T as DevicePropertiesImpl>::properties();
         if !prop.is_empty() {
             unsafe {
                 bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index a658a49fcfd..aff3eecd654 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -5,11 +5,10 @@
 use std::{ffi::CStr, ptr::addr_of};
 
 use qemu_api::{
-    bindings::{module_call_init, module_init_type, qdev_prop_bool},
+    bindings::{module_call_init, module_init_type},
     cell::{self, BqlCell},
-    declare_properties, define_property,
     prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
+    qdev::{DeviceImpl, DeviceState, ResettablePhasesImpl},
     qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
     vmstate::VMStateDescription,
@@ -26,9 +25,10 @@
 };
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
 pub struct DummyState {
     parent: ParentField<DeviceState>,
+    #[property(rename = "migrate-clk", default = true)]
     migrate_clock: bool,
 }
 
@@ -44,17 +44,6 @@ pub fn class_init<T: DeviceImpl>(self: &mut DummyClass) {
     }
 }
 
-declare_properties! {
-    DUMMY_PROPERTIES,
-        define_property!(
-            c"migrate-clk",
-            DummyState,
-            migrate_clock,
-            unsafe { &qdev_prop_bool },
-            bool
-        ),
-}
-
 unsafe impl ObjectType for DummyState {
     type Class = DummyClass;
     const TYPE_NAME: &'static CStr = c"dummy";
@@ -69,16 +58,13 @@ impl ObjectImpl for DummyState {
 impl ResettablePhasesImpl for DummyState {}
 
 impl DeviceImpl for DummyState {
-    fn properties() -> &'static [Property] {
-        &DUMMY_PROPERTIES
-    }
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE)
     }
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
 pub struct DummyChildState {
     parent: ParentField<DummyState>,
 }
-- 
2.51.0


