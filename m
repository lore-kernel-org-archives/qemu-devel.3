Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E812CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3reD-00071L-3Y; Wed, 01 Oct 2025 03:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdr-0006c9-FA
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdf-000392-9h
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=413+vOnfaES0CQPN4grmMs4HnYk6QGiLR8HzsZgLBS4=;
 b=ScuCyflaXgtaSdRGADVnJSvFKWEcs0LVqTjbNp3K5eTV4Bza8JuIc8Xkyg+am3TYyrbP/s
 m90yhjpj37ieJcQ9uZSy1cgZam8XTGFvbTbz1BVrIDP31NEfnzfPHFuBql4J214DOvmRCZ
 kFnMNAYz5V0hJU676cfpsdYI27/9Ou4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-ayEOLn5oMY6HPmdA1yxbgA-1; Wed, 01 Oct 2025 03:52:31 -0400
X-MC-Unique: ayEOLn5oMY6HPmdA1yxbgA-1
X-Mimecast-MFC-AGG-ID: ayEOLn5oMY6HPmdA1yxbgA_1759305150
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3d525fb67eso273565166b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305150; x=1759909950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=413+vOnfaES0CQPN4grmMs4HnYk6QGiLR8HzsZgLBS4=;
 b=Cp2rbx3MtOEQFdupzXC/QvJCpRsEVN9i31ks9uol6NSDtMPomw5bV9haj4Z9taAJdy
 Qbs3nOpdDbhDATnJhxN/9IIB8fZEPXkO5QIh/23uExt38e5iuPSByABALLc2QH+GPEfi
 t0Pdd230HSTyfPNBownPPw1+dJFI+RQMFGYS2AdmeebOqOgM6hxeifMCCPEESpNTsv1Q
 4NHmDHEdnMgAaD3thGbKtKrysHwlrTgNqjQrN+DM9UEPVc8eh8BAQ0YbPLTAFJJWYBOt
 aP/AIsFYnwVfMZgISFe2hlEnJx8lzGnMbolbTCGdmw/kF/RuKhdMzK7qJZUzkUrYtfDT
 Hofw==
X-Gm-Message-State: AOJu0YyWVTd+Qeay8q3cOG+RCNjBgB38C0sg31Q4zb7MH2+o8TvTCfjq
 kV0mcIY7IFoamUQXDpHH71Wq0YdLbbDML/HfaWEz+upsrtnbmPpPGcm1G72NCpQd3508JvAHqnx
 CrxXGtsYHgl942eEW3QWiVzS1KmUpyFbSQsPOVxRcFypvgAKCSsoLcKPTrfgq2iaKoyH7ukUghr
 QV21MMbb1QRUwIplcWoWsTIL2cFaAlK4LHBYr51IQ0
X-Gm-Gg: ASbGnctIwCqii1hsfeGdvXh8VMaX+G4A5i/uyXlXVP0454uRTlw8ULqYgT+ShTfPhjV
 8ULYYcD0XkGa0WRw0x6f3HmfNEo9ytA5OiOkkjWrM37EWnmKYVj60JU1qtvxYQcdK7HM1s1Mi7D
 7BCM0+H5pbVfB7hHzEVtmJofk+kKAOzPMj+eI8QsFFdpb5gKI80aKDzZhz4R6jyVZmvdsPt4XJs
 DUNPvaFK2aou5nGq4eCCBR9t9bX9o1ZzGfc4kZGEMFp8KWeAWj4dkpX1+nVIAn7U36zUYn6QBP0
 G85TPeaOfLJ9mtZe1ZmJ84X5J3MvCr+suoAMP+GlHrWsBIBnAFRTOXOf3DNwGivMWl/c09HmUWX
 6cDZZoe6Z2c0wscNu/n+65lF73oe/Hp0Qa0KsNWvMUOc2IhqFDNI=
X-Received: by 2002:a17:907:94d1:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b46e4d7d8c1mr290095566b.13.1759305149332; 
 Wed, 01 Oct 2025 00:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE7al4NZekbePG42ze6+nxkWqfd1E3L97tY7EShR49PgLMUGG7rIwIIkmvUdHML2ifbfhmSA==
X-Received: by 2002:a17:907:94d1:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b46e4d7d8c1mr290090566b.13.1759305148502; 
 Wed, 01 Oct 2025 00:52:28 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3f7b67b883sm537940366b.79.2025.10.01.00.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
Date: Wed,  1 Oct 2025 09:52:07 +0200
Message-ID: <20251001075210.1042479-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a macro that recursively builds the "migrated" version
of a struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock                         |   1 +
 rust/migration/Cargo.toml               |   1 +
 rust/migration/meson.build              |   2 +-
 rust/migration/src/lib.rs               |   2 +
 rust/migration/src/migratable.rs        |  12 +-
 rust/qemu-macros/src/lib.rs             |  88 +++++++
 rust/qemu-macros/src/migration_state.rs | 296 ++++++++++++++++++++++++
 rust/qemu-macros/src/tests.rs           | 112 ++++++++-
 8 files changed, 509 insertions(+), 5 deletions(-)
 create mode 100644 rust/qemu-macros/src/migration_state.rs

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 008d6ca4d62..bf420dce2b8 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -140,6 +140,7 @@ version = "0.1.0"
 dependencies = [
  "bql",
  "common",
+ "qemu_macros",
  "util",
 ]
 
diff --git a/rust/migration/Cargo.toml b/rust/migration/Cargo.toml
index f4a86275152..8efce7a72cb 100644
--- a/rust/migration/Cargo.toml
+++ b/rust/migration/Cargo.toml
@@ -15,6 +15,7 @@ rust-version.workspace = true
 [dependencies]
 bql = { path = "../bql" }
 common = { path = "../common" }
+qemu_macros = { path = "../qemu-macros" }
 util = { path = "../util" }
 
 [lints]
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 1ba0ec21d72..362925e320f 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -39,7 +39,7 @@ _migration_rs = static_library(
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
index 46e533c16d1..ded6fe8f4a6 100644
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
@@ -309,13 +313,17 @@ fn restore_migrated_state(
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
index 3e21b67b471..c459f9bcb42 100644
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
 
@@ -405,3 +409,87 @@ pub fn bits_const_internal(ts: TokenStream) -> TokenStream {
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
index ac998d20e30..7516bc3d92a 100644
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
@@ -345,3 +345,111 @@ fn try_from(value: u8) -> Result<Self, u8> {
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


