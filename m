Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4838CAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzybY-0007M2-VC; Sat, 20 Sep 2025 10:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybU-0007Jq-6Y
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzybR-0005Sy-It
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758378616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYTQycbVXEUC503A1Xz7erE6PcHFAqKjXXmxKEfIz9U=;
 b=J5Hf28nMIW6FyyEmY+WPwy+q8QkLuTcZWBkY6Yu9WdcR3MfkpmLN5d9e0Abd8np3Bw9Qxt
 jFe/Pd5tePk7dh16kwFYQ+HUk+zJ9UCyAbwGkHy9pmEPiBcrDMH44w1MIS4/ik2cM4BPZu
 z4lArwyaaVMuD4HeCc1JZxuIHENIAks=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-q-Pg96MEPqOM3uVQS5LNXw-1; Sat, 20 Sep 2025 10:30:15 -0400
X-MC-Unique: q-Pg96MEPqOM3uVQS5LNXw-1
X-Mimecast-MFC-AGG-ID: q-Pg96MEPqOM3uVQS5LNXw_1758378614
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45f2a1660fcso28089165e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 07:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758378613; x=1758983413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYTQycbVXEUC503A1Xz7erE6PcHFAqKjXXmxKEfIz9U=;
 b=mhrdJ1vp8+k4SoeHr+OIsUC/+5SWwJvouPPYBWAi2EMv7xj4aYF33LiC17fYkoJqdc
 q54jJA9LtF/l3vqsqGWwlwT0uy9r7getPxo/x9s60SEKZJSl+loqkHKF/dGa2lJ9lgGI
 eP2k5t/b/24cwarGUAFgpqcZiOge31xJJF5+acdU7UJGYVZsM7oOUCErZwDm3ABmrRem
 TWQRP2DLfMgVYSL9Xt0FEcna0+OPv4vSu4/7u952qGOKJyUNhBCj0FrMesZXobVrDtxd
 RkMqzS58Rt8/A+z45FAJ6eaCYd0KsOIp8Yprwhji6MX2dL12JuAWT6pbD2xf4m1o2I8x
 WiSA==
X-Gm-Message-State: AOJu0Yy3w5hYfly5WWVbJ+rfyTuGbTJiy5ISQCrQlNoQ1eefEwtBi6L5
 6jvBSSBDf1wUu+Or+zffEnMJMVGEFd4ssNd1m46IgUq08FC2Px3Mv3ljy8mTXTu7/WMFE9CYDJr
 C1gOxENVkVNX5pS3Jb6i78p0zV4HvhjsboJa4ZqoVtqmClStbai2y9yRvfH8E0NV0S7GqoRd9GI
 u33Bju1kH0TewSaMjVy9qLDRbDBhm0BDNkbSRNMgfE
X-Gm-Gg: ASbGncslpT/uQ4ckfie5eocapZLYm9dg8EZtWJ+L75YSAdA8QpMztqvuzkzQHv+mQMj
 KLl+abcaxa+HSaK3qJCF41yMwf9RUD5/zqX86FsHc3iPXKSb8SRDjD5qoDerpdhzZz9mPxycHxS
 XSSVSsdLdXQt1+QTUGFzf3fQlmGLLuvXQA/b8GhqsUk2E3++LZ9jHqSrsBb5aYyg6xxGwCnDpeW
 PaYbenpylwoGr/5RBVjB2c+Hl4MxyYrlmErsMhz/bfOvDhJYb4UIZIoC20yE6VOPk1l0yjiBwy+
 saIuQOGzBjhcO+jQs4ybZ+sm96+J2xzohhy1mbr6Yro4RUa71MUG7x8RNoTWc166nXp/AzH3gp9
 NYoy4fvwxDE4WY9bi5+ayhm2DEVB9OrXbKGwF8PSfpiw=
X-Received: by 2002:a05:600c:68a:b0:467:f71c:292 with SMTP id
 5b1f17b1804b1-467f71c05fdmr32757285e9.19.1758378613383; 
 Sat, 20 Sep 2025 07:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Tj6bIW6EqkKDvcZOVWeSh2+w+8AyKQ1vH1KzGzUwSKgFNCFGHx51GYGoicvS5mZmrNfbCA==
X-Received: by 2002:a05:600c:68a:b0:467:f71c:292 with SMTP id
 5b1f17b1804b1-467f71c05fdmr32757015e9.19.1758378612573; 
 Sat, 20 Sep 2025 07:30:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-461eefee9f3sm167826885e9.1.2025.09.20.07.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:30:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, zhao1.liu@intel.com, manos.pitsidianakis@linaro.org
Subject: [PATCH 5/7] rust: qemu-macros: add ToMigrationState derive macro
Date: Sat, 20 Sep 2025 16:29:56 +0200
Message-ID: <20250920142958.181910-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920142958.181910-1-pbonzini@redhat.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a macro that recursively builds the "migrated" version
of a struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/meson.build              |   2 +-
 rust/migration/src/lib.rs               |   2 +
 rust/migration/src/migratable.rs        |  12 +-
 rust/qemu-macros/src/lib.rs             |  88 +++++++
 rust/qemu-macros/src/migration_state.rs | 296 ++++++++++++++++++++++++
 rust/qemu-macros/src/tests.rs           | 112 ++++++++-
 6 files changed, 507 insertions(+), 5 deletions(-)
 create mode 100644 rust/qemu-macros/src/migration_state.rs

diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index c258881790d..3843b364c69 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -38,7 +38,7 @@ _migration_rs = static_library(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
   link_with: [_util_rs, _bql_rs],
-  dependencies: [common_rs],
+  dependencies: [common_rs, qemu_macros],
 )
 
 migration_rs = declare_dependency(link_with: [_migration_rs],
diff --git a/rust/migration/src/lib.rs b/rust/migration/src/lib.rs
index efe9896b619..c9bdf0d4133 100644
--- a/rust/migration/src/lib.rs
+++ b/rust/migration/src/lib.rs
@@ -2,6 +2,8 @@
 
 pub mod bindings;
 
+pub use qemu_macros::ToMigrationState;
+
 pub mod migratable;
 pub use migratable::*;
 
diff --git a/rust/migration/src/migratable.rs b/rust/migration/src/migratable.rs
index d09eeb35f11..fa25317eea8 100644
--- a/rust/migration/src/migratable.rs
+++ b/rust/migration/src/migratable.rs
@@ -79,6 +79,10 @@
 /// # dev2.restore_migrated_state_mut(*mig, 1).unwrap();
 /// # assert_eq!(dev2, dev);
 /// ```
+///
+/// More commonly, the trait is derived through the
+/// [`derive(ToMigrationState)`](qemu_macros::ToMigrationState) procedural
+/// macro.
 pub trait ToMigrationState {
     /// The type used to represent the migrated state.
     type Migrated: Default + VMState;
@@ -305,13 +309,17 @@ fn restore_migrated_state(
 /// It manages the lifecycle of migration state and provides automatic
 /// conversion between runtime and migration representations.
 ///
-/// ```ignore
+/// ```
 /// # use std::sync::Mutex;
-/// # use migration::Migratable;
+/// # use migration::{Migratable, ToMigrationState, VMState, VMStateField};
 ///
+/// #[derive(ToMigrationState)]
 /// pub struct DeviceRegs {
 ///     status: u32,
 /// }
+/// # unsafe impl VMState for DeviceRegsMigration {
+/// #     const BASE: VMStateField = ::common::Zeroable::ZERO;
+/// # }
 ///
 /// pub struct SomeDevice {
 ///     // ...
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 7ab18061776..8151fb6d4e1 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -13,9 +13,13 @@
     Attribute, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
     Variant,
 };
+
 mod bits;
 use bits::BitsConstInternal;
 
+mod migration_state;
+use migration_state::MigrationStateDerive;
+
 #[cfg(test)]
 mod tests;
 
@@ -393,3 +397,87 @@ pub fn bits_const_internal(ts: TokenStream) -> TokenStream {
         .unwrap_or_else(syn::Error::into_compile_error)
         .into()
 }
+
+/// Derive macro for generating migration state structures and trait
+/// implementations.
+///
+/// This macro generates a migration state struct and implements the
+/// `ToMigrationState` trait for the annotated struct, enabling state
+/// serialization and restoration.  Note that defining a `VMStateDescription`
+/// for the migration state struct is left to the user.
+///
+/// # Container attributes
+///
+/// The following attributes can be applied to the struct:
+///
+/// - `#[migration_state(rename = CustomName)]` - Customizes the name of the
+///   generated migration struct. By default, the generated struct is named
+///   `{OriginalName}Migration`.
+///
+/// # Field attributes
+///
+/// The following attributes can be applied to individual fields:
+///
+/// - `#[migration_state(omit)]` - Excludes the field from the migration state
+///   entirely.
+///
+/// - `#[migration_state(into(Type))]` - Converts the field using `.into()`
+///   during both serialization and restoration.
+///
+/// - `#[migration_state(try_into(Type))]` - Converts the field using
+///   `.try_into()` during both serialization and restoration. Returns
+///   `InvalidError` on conversion failure.
+///
+/// - `#[migration_state(clone)]` - Clones the field value.
+///
+/// Fields without any attributes use `ToMigrationState` recursively; note that
+/// this is a simple copy for types that implement `Copy`.
+///
+/// # Attribute compatibility
+///
+/// - `omit` cannot be used with any other attributes
+/// - only one of `into(Type)`, `try_into(Type)` can be used, but they can be
+///   coupled with `clone`.
+///
+/// # Examples
+///
+/// Basic usage:
+/// ```ignore
+/// #[derive(ToMigrationState)]
+/// struct MyStruct {
+///     field1: u32,
+///     field2: Timer,
+/// }
+/// ```
+///
+/// With attributes:
+/// ```ignore
+/// #[derive(ToMigrationState)]
+/// #[migration_state(rename = CustomMigration)]
+/// struct MyStruct {
+///     #[migration_state(omit)]
+///     runtime_field: u32,
+///
+///     #[migration_state(clone)]
+///     shared_data: String,
+///
+///     #[migration_state(into(Cow<'static, str>), clone)]
+///     converted_field: String,
+///
+///     #[migration_state(try_into(i8))]
+///     fallible_field: u32,
+///
+///     // Default: use ToMigrationState trait recursively
+///     nested_field: NestedStruct,
+///
+///     // Primitive types have a default implementation of ToMigrationState
+///     simple_field: u32,
+/// }
+/// ```
+#[proc_macro_derive(ToMigrationState, attributes(migration_state))]
+pub fn derive_to_migration_state(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    MigrationStateDerive::expand(input)
+        .unwrap_or_else(syn::Error::into_compile_error)
+        .into()
+}
diff --git a/rust/qemu-macros/src/migration_state.rs b/rust/qemu-macros/src/migration_state.rs
new file mode 100644
index 00000000000..89feae1e767
--- /dev/null
+++ b/rust/qemu-macros/src/migration_state.rs
@@ -0,0 +1,296 @@
+use std::borrow::Cow;
+
+use proc_macro2::TokenStream;
+use quote::{format_ident, quote, ToTokens};
+use syn::{spanned::Spanned, DeriveInput, Error, Field, Ident, Result, Type};
+
+use crate::get_fields;
+
+#[derive(Debug, Default)]
+enum ConversionMode {
+    #[default]
+    None,
+    Omit,
+    Into(Type),
+    TryInto(Type),
+    ToMigrationState,
+}
+
+impl ConversionMode {
+    fn target_type(&self, original_type: &Type) -> TokenStream {
+        match self {
+            ConversionMode::Into(ty) | ConversionMode::TryInto(ty) => ty.to_token_stream(),
+            ConversionMode::ToMigrationState => {
+                quote! { <#original_type as ToMigrationState>::Migrated }
+            }
+            _ => original_type.to_token_stream(),
+        }
+    }
+}
+
+#[derive(Debug, Default)]
+struct ContainerAttrs {
+    rename: Option<Ident>,
+}
+
+impl ContainerAttrs {
+    fn parse_from(&mut self, attrs: &[syn::Attribute]) -> Result<()> {
+        use attrs::{set, with, Attrs};
+        Attrs::new()
+            .once("rename", with::eq(set::parse(&mut self.rename)))
+            .parse_attrs("migration_state", attrs)?;
+        Ok(())
+    }
+
+    fn parse(attrs: &[syn::Attribute]) -> Result<Self> {
+        let mut container_attrs = Self::default();
+        container_attrs.parse_from(attrs)?;
+        Ok(container_attrs)
+    }
+}
+
+#[derive(Debug, Default)]
+struct FieldAttrs {
+    conversion: ConversionMode,
+    clone: bool,
+}
+
+impl FieldAttrs {
+    fn parse_from(&mut self, attrs: &[syn::Attribute]) -> Result<()> {
+        let mut omit_flag = false;
+        let mut into_type: Option<Type> = None;
+        let mut try_into_type: Option<Type> = None;
+
+        use attrs::{set, with, Attrs};
+        Attrs::new()
+            .once("omit", set::flag(&mut omit_flag))
+            .once("into", with::paren(set::parse(&mut into_type)))
+            .once("try_into", with::paren(set::parse(&mut try_into_type)))
+            .once("clone", set::flag(&mut self.clone))
+            .parse_attrs("migration_state", attrs)?;
+
+        self.conversion = match (omit_flag, into_type, try_into_type, self.clone) {
+            // Valid combinations of attributes first...
+            (true, None, None, false) => ConversionMode::Omit,
+            (false, Some(ty), None, _) => ConversionMode::Into(ty),
+            (false, None, Some(ty), _) => ConversionMode::TryInto(ty),
+            (false, None, None, true) => ConversionMode::None, // clone without conversion
+            (false, None, None, false) => ConversionMode::ToMigrationState, // default behavior
+
+            // ... then the error cases
+            (true, _, _, _) => {
+                return Err(Error::new(
+                    attrs[0].span(),
+                    "ToMigrationState: omit cannot be used with other attributes",
+                ));
+            }
+            (_, Some(_), Some(_), _) => {
+                return Err(Error::new(
+                    attrs[0].span(),
+                    "ToMigrationState: into and try_into attributes cannot be used together",
+                ));
+            }
+        };
+
+        Ok(())
+    }
+
+    fn parse(attrs: &[syn::Attribute]) -> Result<Self> {
+        let mut field_attrs = Self::default();
+        field_attrs.parse_from(attrs)?;
+        Ok(field_attrs)
+    }
+}
+
+#[derive(Debug)]
+struct MigrationStateField {
+    name: Ident,
+    original_type: Type,
+    attrs: FieldAttrs,
+}
+
+impl MigrationStateField {
+    fn maybe_clone(&self, mut value: TokenStream) -> TokenStream {
+        if self.attrs.clone {
+            value = quote! { #value.clone() };
+        }
+        value
+    }
+
+    fn generate_migration_state_field(&self) -> TokenStream {
+        let name = &self.name;
+        let field_type = self.attrs.conversion.target_type(&self.original_type);
+
+        quote! {
+            pub #name: #field_type,
+        }
+    }
+
+    fn generate_snapshot_field(&self) -> TokenStream {
+        let name = &self.name;
+        let value = self.maybe_clone(quote! { self.#name });
+
+        match &self.attrs.conversion {
+            ConversionMode::Omit => {
+                unreachable!("Omitted fields are filtered out during processing")
+            }
+            ConversionMode::None => quote! {
+                target.#name = #value;
+            },
+            ConversionMode::Into(_) => quote! {
+                target.#name = #value.into();
+            },
+            ConversionMode::TryInto(_) => quote! {
+                target.#name = #value.try_into().map_err(|_| migration::InvalidError)?;
+            },
+            ConversionMode::ToMigrationState => quote! {
+                self.#name.snapshot_migration_state(&mut target.#name)?;
+            },
+        }
+    }
+
+    fn generate_restore_field(&self) -> TokenStream {
+        let name = &self.name;
+
+        match &self.attrs.conversion {
+            ConversionMode::Omit => {
+                unreachable!("Omitted fields are filtered out during processing")
+            }
+            ConversionMode::None => quote! {
+                self.#name = #name;
+            },
+            ConversionMode::Into(_) => quote! {
+                self.#name = #name.into();
+            },
+            ConversionMode::TryInto(_) => quote! {
+                self.#name = #name.try_into().map_err(|_| migration::InvalidError)?;
+            },
+            ConversionMode::ToMigrationState => quote! {
+                self.#name.restore_migrated_state_mut(#name, version_id)?;
+            },
+        }
+    }
+}
+
+#[derive(Debug)]
+pub struct MigrationStateDerive {
+    input: DeriveInput,
+    fields: Vec<MigrationStateField>,
+    container_attrs: ContainerAttrs,
+}
+
+impl MigrationStateDerive {
+    fn parse(input: DeriveInput) -> Result<Self> {
+        let container_attrs = ContainerAttrs::parse(&input.attrs)?;
+        let fields = get_fields(&input, "ToMigrationState")?;
+        let fields = Self::process_fields(fields)?;
+
+        Ok(Self {
+            input,
+            fields,
+            container_attrs,
+        })
+    }
+
+    fn process_fields(
+        fields: &syn::punctuated::Punctuated<Field, syn::token::Comma>,
+    ) -> Result<Vec<MigrationStateField>> {
+        let processed = fields
+            .iter()
+            .map(|field| {
+                let attrs = FieldAttrs::parse(&field.attrs)?;
+                Ok((field, attrs))
+            })
+            .collect::<Result<Vec<_>>>()?
+            .into_iter()
+            .filter(|(_, attrs)| !matches!(attrs.conversion, ConversionMode::Omit))
+            .map(|(field, attrs)| MigrationStateField {
+                name: field.ident.as_ref().unwrap().clone(),
+                original_type: field.ty.clone(),
+                attrs,
+            })
+            .collect();
+
+        Ok(processed)
+    }
+
+    fn migration_state_name(&self) -> Cow<'_, Ident> {
+        match &self.container_attrs.rename {
+            Some(rename) => Cow::Borrowed(rename),
+            None => Cow::Owned(format_ident!("{}Migration", &self.input.ident)),
+        }
+    }
+
+    fn generate_migration_state_struct(&self) -> TokenStream {
+        let name = self.migration_state_name();
+        let fields = self
+            .fields
+            .iter()
+            .map(MigrationStateField::generate_migration_state_field);
+
+        quote! {
+            #[derive(Default)]
+            pub struct #name {
+                #(#fields)*
+            }
+        }
+    }
+
+    fn generate_snapshot_migration_state(&self) -> TokenStream {
+        let fields = self
+            .fields
+            .iter()
+            .map(MigrationStateField::generate_snapshot_field);
+
+        quote! {
+            fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), migration::InvalidError> {
+                #(#fields)*
+                Ok(())
+            }
+        }
+    }
+
+    fn generate_restore_migrated_state(&self) -> TokenStream {
+        let names: Vec<_> = self.fields.iter().map(|f| &f.name).collect();
+        let fields = self
+            .fields
+            .iter()
+            .map(MigrationStateField::generate_restore_field);
+
+        quote! {
+            fn restore_migrated_state_mut(&mut self, source: Self::Migrated, version_id: u8) -> Result<(), migration::InvalidError> {
+                let Self::Migrated { #(#names),* } = source;
+                #(#fields)*
+                Ok(())
+            }
+        }
+    }
+
+    fn generate(&self) -> TokenStream {
+        let struct_name = &self.input.ident;
+        let generics = &self.input.generics;
+
+        let (impl_generics, ty_generics, where_clause) = generics.split_for_impl();
+        let name = self.migration_state_name();
+        let migration_state_struct = self.generate_migration_state_struct();
+        let snapshot_impl = self.generate_snapshot_migration_state();
+        let restore_impl = self.generate_restore_migrated_state();
+
+        quote! {
+            #migration_state_struct
+
+            impl #impl_generics ToMigrationState for #struct_name #ty_generics #where_clause {
+                type Migrated = #name;
+
+                #snapshot_impl
+
+                #restore_impl
+            }
+        }
+    }
+
+    pub fn expand(input: DeriveInput) -> Result<TokenStream> {
+        let tokens = Self::parse(input)?.generate();
+        Ok(tokens)
+    }
+}
diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index 00a106612fc..1ce43aa568e 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -7,7 +7,7 @@
 use super::*;
 
 macro_rules! derive_compile_fail {
-    ($derive_fn:ident, $input:expr, $($error_msg:expr),+ $(,)?) => {{
+    ($derive_fn:path, $input:expr, $($error_msg:expr),+ $(,)?) => {{
         let input: proc_macro2::TokenStream = $input;
         let error_msg = &[$( quote! { ::core::compile_error! { $error_msg } } ),*];
         let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, syn::Error> =
@@ -24,7 +24,7 @@ macro_rules! derive_compile_fail {
 }
 
 macro_rules! derive_compile {
-    ($derive_fn:ident, $input:expr, $($expected:tt)*) => {{
+    ($derive_fn:path, $input:expr, $($expected:tt)*) => {{
         let input: proc_macro2::TokenStream = $input;
         let expected: proc_macro2::TokenStream = $($expected)*;
         let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, syn::Error> =
@@ -244,3 +244,111 @@ fn try_from(value: u8) -> Result<Self, u8> {
         }
     );
 }
+
+#[test]
+fn test_derive_to_migration_state() {
+    derive_compile_fail!(
+        MigrationStateDerive::expand,
+        quote! {
+            struct MyStruct {
+                #[migration_state(omit, clone)]
+                bad: u32,
+            }
+        },
+        "ToMigrationState: omit cannot be used with other attributes"
+    );
+    derive_compile_fail!(
+        MigrationStateDerive::expand,
+        quote! {
+            struct MyStruct {
+                #[migration_state(into)]
+                bad: u32,
+            }
+        },
+        "unexpected end of input, expected parentheses"
+    );
+    derive_compile_fail!(
+        MigrationStateDerive::expand,
+        quote! {
+            struct MyStruct {
+                #[migration_state(into(String), try_into(String))]
+                bad: &'static str,
+            }
+        },
+        "ToMigrationState: into and try_into attributes cannot be used together"
+    );
+    derive_compile!(
+        MigrationStateDerive::expand,
+        quote! {
+            #[migration_state(rename = CustomMigration)]
+            struct MyStruct {
+                #[migration_state(omit)]
+                runtime_field: u32,
+
+                #[migration_state(clone)]
+                shared_data: String,
+
+                #[migration_state(into(Cow<'static, str>), clone)]
+                converted_field: String,
+
+                #[migration_state(try_into(i8))]
+                fallible_field: u32,
+
+                nested_field: NestedStruct,
+                simple_field: u32,
+            }
+        },
+        quote! {
+            #[derive(Default)]
+            pub struct CustomMigration {
+                pub shared_data: String,
+                pub converted_field: Cow<'static, str>,
+                pub fallible_field: i8,
+                pub nested_field: <NestedStruct as ToMigrationState>::Migrated,
+                pub simple_field: <u32 as ToMigrationState>::Migrated,
+            }
+            impl ToMigrationState for MyStruct {
+                type Migrated = CustomMigration;
+                fn snapshot_migration_state(
+                    &self,
+                    target: &mut Self::Migrated
+                ) -> Result<(), migration::InvalidError> {
+                    target.shared_data = self.shared_data.clone();
+                    target.converted_field = self.converted_field.clone().into();
+                    target.fallible_field = self
+                        .fallible_field
+                        .try_into()
+                        .map_err(|_| migration::InvalidError)?;
+                    self.nested_field
+                        .snapshot_migration_state(&mut target.nested_field)?;
+                    self.simple_field
+                        .snapshot_migration_state(&mut target.simple_field)?;
+                    Ok(())
+                }
+                fn restore_migrated_state_mut(
+                    &mut self,
+                    source: Self::Migrated,
+                    version_id: u8
+                ) -> Result<(), migration::InvalidError> {
+                    let Self::Migrated {
+                        shared_data,
+                        converted_field,
+                        fallible_field,
+                        nested_field,
+                        simple_field
+                    } = source;
+                    self.shared_data = shared_data;
+                    self.converted_field = converted_field.into();
+                    self.fallible_field = fallible_field
+                        .try_into()
+                        .map_err(|_| migration::InvalidError)?;
+                    self.nested_field
+                        .restore_migrated_state_mut(nested_field, version_id)?;
+                    self.simple_field
+                        .restore_migrated_state_mut(simple_field, version_id)?;
+                    Ok(())
+                }
+            }
+        }
+    );
+}
-- 
2.51.0


