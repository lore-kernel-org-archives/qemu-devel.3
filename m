Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EAAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH1k-00023Z-JU; Mon, 14 Jul 2025 07:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGz2-0000ao-7R
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGyz-0001W7-Uw
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDS1zp/SwwPVp8w2l7aZW0s5Crk2/t5eywReYfE5geg=;
 b=eBAghy4xe+ImXs2QN+t4KaIQYy4Si6YasB9tUw8iDl+sbRqjAoTEEiVwwgzrS7FNPAkExr
 s/SJdjK03fSAignLw9Xqn0V80csRavegmLQofxeiO4ZHDALvoOjTQxm4gppjPcU//V3Xjl
 eFFU4U3Y/zkS74QSngEwXHPFtel9RM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-SGLeucC_Ol-S6dHzfOXDCQ-1; Mon, 14 Jul 2025 07:04:24 -0400
X-MC-Unique: SGLeucC_Ol-S6dHzfOXDCQ-1
X-Mimecast-MFC-AGG-ID: SGLeucC_Ol-S6dHzfOXDCQ_1752491063
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-454dee17a91so31527355e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491062; x=1753095862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDS1zp/SwwPVp8w2l7aZW0s5Crk2/t5eywReYfE5geg=;
 b=dgQ8c36EA8Gyx0kwC5mvV+Oe3vERIEUmnbidcdnnuM+KlOD1clOKTjOEk1KiqK5iRp
 ro8bSsljKIb3L43jFEIGC4JivEyYPRvnRLbcQoPQAz1RYMpCjveev0iLSHsJSeDHJYid
 TpmTmUGf+JBbIC7iDx++1UYLfTiLOHBoskzdgGhM9/0Iq0z3AXIKx95HokZxUuaL03J4
 I+voWdCzZdplP3+bGEQ7Bwf+DR6JCd6dQVlBd7emLhzXLrtsCFx+isd3ptMKHKOzjktk
 ivkc3XNj8AJAKox0Qu1byEckAGPVWYp5c+dLB3wXF1jPMxelzEYXGb+CBIxTjJEY/fwS
 Gh+g==
X-Gm-Message-State: AOJu0Yy0sVVVM2MMjvvqYgNZbTDK06vnkSBneQMusEgeU2eRt0l55G3+
 49Odpw+TSM2CRsPnwldeMjLqd4CIARhBzigaIlPGLzFT1EvS0eF6JOE5tsP8YuSI5Rfg7Phfh8J
 /A4DMuYd8UNZ7hBQZrAAWWYErcOFStSJiaRyLzoGmiJ2fHBZYRCcJQKDjdSugnSqhkX1XW/SPE3
 Iuq2ylJ8NQDaVcxyuexexdAYli2ZEjIpXmEcyI/A4E
X-Gm-Gg: ASbGncuNvt7KprQIYOsQDsIDbePENbGQ+HwMOAkQ11KZ8uxs7aZuNj8vb+UNnSE1NrB
 hMyo2PIBu+X0WzfEYtvHsbZ4DYknNjbLQaDrrSx2Ewr3aYex0j13oDi9CnXPvd8Th5GdFZHXnFz
 ff7CAyxICN1cIIAysZpPDoTUzFwrjD6IebU1vruoo0X0eItSuHjaK4LdXkVOLnUVSErwuy9LsFH
 0QZBdmSOXeNwfidNVNdci5dH5aa/eFYfK+8rHQZNIRNNPG6lzYmZcepX0YN9Ive8NZb34xyd0MO
 yiY9sVqv59tbgmg/9SbvIJDASdW0nbSjGqZ/JvKzBkE=
X-Received: by 2002:a05:600c:3595:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-454ec15e5c5mr111456565e9.11.1752491062410; 
 Mon, 14 Jul 2025 04:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtWbRwlvJqz7wRRBBOV5YBvPuCuEhlSNW7ZU7HRTaB6UIJUfAL9CUMrnkI0nPLPMtb0jw9Rg==
X-Received: by 2002:a05:600c:3595:b0:442:f8e7:25ef with SMTP id
 5b1f17b1804b1-454ec15e5c5mr111456145e9.11.1752491061592; 
 Mon, 14 Jul 2025 04:04:21 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45610a39cacsm53519445e9.38.2025.07.14.04.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 05/77] rust/qemu-api-macros: add unit tests
Date: Mon, 14 Jul 2025 13:02:54 +0200
Message-ID: <20250714110406.117772-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add unit tests to check Derive macro output for expected error messages,
or for expected correct codegen output.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250704-rust_add_derive_macro_unit_tests-v1-2-ebd47fa7f78f@linaro.org
[Remove usage of MacroError. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/meson.build  |   3 +
 rust/qemu-api-macros/src/lib.rs   |   3 +
 rust/qemu-api-macros/src/tests.rs | 137 ++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 rust/qemu-api-macros/src/tests.rs

diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 8610ce1c844..2152bcb99b3 100644
--- a/rust/qemu-api-macros/meson.build
+++ b/rust/qemu-api-macros/meson.build
@@ -17,3 +17,6 @@ _qemu_api_macros_rs = rust.proc_macro(
 qemu_api_macros = declare_dependency(
   link_with: _qemu_api_macros_rs,
 )
+
+rust.test('rust-qemu-api-macros-tests', _qemu_api_macros_rs,
+          suite: ['unit', 'rust'])
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 5bbf8c6127a..b525d89c09e 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -11,6 +11,9 @@
 mod bits;
 use bits::BitsConstInternal;
 
+#[cfg(test)]
+mod tests;
+
 fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
diff --git a/rust/qemu-api-macros/src/tests.rs b/rust/qemu-api-macros/src/tests.rs
new file mode 100644
index 00000000000..d6dcd62fcf6
--- /dev/null
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -0,0 +1,137 @@
+// Copyright 2025, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use quote::quote;
+
+use super::*;
+
+macro_rules! derive_compile_fail {
+    ($derive_fn:ident, $input:expr, $error_msg:expr) => {{
+        let input: proc_macro2::TokenStream = $input;
+        let error_msg: &str = $error_msg;
+        let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, syn::Error> =
+            $derive_fn;
+
+        let input: syn::DeriveInput = syn::parse2(input).unwrap();
+        let result = derive_fn(input);
+        let err = result.unwrap_err().into_compile_error();
+        assert_eq!(
+            err.to_string(),
+            quote! { ::core::compile_error! { #error_msg } }.to_string()
+        );
+    }};
+}
+
+macro_rules! derive_compile {
+    ($derive_fn:ident, $input:expr, $($expected:tt)*) => {{
+        let input: proc_macro2::TokenStream = $input;
+        let expected: proc_macro2::TokenStream = $($expected)*;
+        let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, syn::Error> =
+            $derive_fn;
+
+        let input: syn::DeriveInput = syn::parse2(input).unwrap();
+        let result = derive_fn(input).unwrap();
+        assert_eq!(result.to_string(), expected.to_string());
+    }};
+}
+
+#[test]
+fn test_derive_object() {
+    derive_compile_fail!(
+        derive_object_or_error,
+        quote! {
+            #[derive(Object)]
+            struct Foo {
+                _unused: [u8; 0],
+            }
+        },
+        "#[repr(C)] required for #[derive(Object)]"
+    );
+    derive_compile!(
+        derive_object_or_error,
+        quote! {
+            #[derive(Object)]
+            #[repr(C)]
+            struct Foo {
+                _unused: [u8; 0],
+            }
+        },
+        quote! {
+            ::qemu_api::assert_field_type!(
+                Foo,
+                _unused,
+                ::qemu_api::qom::ParentField<<Foo as ::qemu_api::qom::ObjectImpl>::ParentType>
+            );
+            ::qemu_api::module_init! {
+                MODULE_INIT_QOM => unsafe {
+                    ::qemu_api::bindings::type_register_static(&<Foo as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
+                }
+            }
+        }
+    );
+}
+
+#[test]
+fn test_derive_tryinto() {
+    derive_compile_fail!(
+        derive_tryinto_or_error,
+        quote! {
+            #[derive(TryInto)]
+            struct Foo {
+                _unused: [u8; 0],
+            }
+        },
+        "#[repr(u8/u16/u32/u64) required for #[derive(TryInto)]"
+    );
+    derive_compile!(
+        derive_tryinto_or_error,
+        quote! {
+            #[derive(TryInto)]
+            #[repr(u8)]
+            enum Foo {
+                First = 0,
+                Second,
+            }
+        },
+        quote! {
+            impl Foo {
+                #[allow(dead_code)]
+                pub const fn into_bits(self) -> u8 {
+                    self as u8
+                }
+
+                #[allow(dead_code)]
+                pub const fn from_bits(value: u8) -> Self {
+                    match ({
+                        const First: u8 = Foo::First as u8;
+                        const Second: u8 = Foo::Second as u8;
+                        match value {
+                            First => core::result::Result::Ok(Foo::First),
+                            Second => core::result::Result::Ok(Foo::Second),
+                            _ => core::result::Result::Err(value),
+                        }
+                    }) {
+                        Ok(x) => x,
+                        Err(_) => panic!("invalid value for Foo"),
+                    }
+                }
+            }
+
+            impl core::convert::TryFrom<u8> for Foo {
+                type Error = u8;
+
+                #[allow(ambiguous_associated_items)]
+                fn try_from(value: u8) -> Result<Self, u8> {
+                    const First: u8 = Foo::First as u8;
+                    const Second: u8 = Foo::Second as u8;
+                    match value {
+                        First => core::result::Result::Ok(Foo::First),
+                        Second => core::result::Result::Ok(Foo::Second),
+                        _ => core::result::Result::Err(value),
+                    }
+                }
+            }
+        }
+    );
+}
-- 
2.50.0


