Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CC2C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXddX-0001SQ-1K; Fri, 04 Jul 2025 06:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXddR-0001RG-9h
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:27:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXddM-0005Rf-Qf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:27:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso7957555e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624827; x=1752229627; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XcG193KL04Vyt8IK+5wFFCt320k2qvBu9/epx6xtd4A=;
 b=XycNIsvaK5KCv4Nm4cKOOOHjAEOI6CKQTBn9OmzytMC/aNFZVH4wWDH9ItV9XmXIYs
 qD1d8zHkSQ0r3xV8fEfD/zsNevvZ1JQzkjXkcTdi9U0CtQy6IcW98PQyXUJL7rmeqZIf
 Bi4iRjTcl1MryTGpw69BG6h8NUZO4ttdZG2NBRGGQvdQjdyZ0vu6/TZSflRJvPpZ8xN2
 3PEG0cPpahR9487zWizaUSrsKtOacR9a+icPKrtC9IOP603v7PP1uZNlraZIzAPy7YYg
 nBVgQ0IBXOJFqhJ/r6DJ0FPBsrQDwA2yQXCMgF/mNc2GfuhwInucsPS21bQ81500+KDQ
 p0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624827; x=1752229627;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcG193KL04Vyt8IK+5wFFCt320k2qvBu9/epx6xtd4A=;
 b=s6+AFOdOQD/u5t1yBObyd3Z/yf5Ighd2F5ISRlYKaYwXg2ziIsL/9QLoMcYIAHlaVP
 0RaymXAErqRhCbTvS0B/OCPZ3ndI05GfeUlp0h3mgf9TI0H6fdMqGukb7rrF1aS7NnPm
 rxSIzMp6RyesSA5FSfqJgU4mMgrjs69jrRuGywrKF+8KutRJLe346E19e5oDDLlO2FYx
 aw4Ozd2QrJjMy1ebtNwxBgd9mxe1cQdMLq/7npdeETgL6TqnIlZYuKZ2FZ7Q9j7THqt2
 wNaEAGkUS0vnIT4RNJ8MhZlZBm4rhu0n47UEIOCBvDNZjrNjALs0w72cMnnC9WAFFZsG
 y8Iw==
X-Gm-Message-State: AOJu0YxNLDFUZ+ZDSLakVT46chCt+FvQ18ZW+sIaqmIvY6FIrd8POk2I
 n4KMRNRK0Jip1BU8E+NQr+6P4cGzlq+n6hI/wcKCYhHUMhWQQ2qV2loIJJz7O6CWBt0=
X-Gm-Gg: ASbGncvo90BlEqWlZa7t1/YII32zjbqu+CH/XnLXh80gqh8uGR78CfNyJ2PoL7oGOk8
 TAc6zGASwP2xkxPZltOjCZUA11tPacbrdsBIwsfFdNYkzCCom8cGeH9O5cc+nHUExhxUUEkuHgb
 0QfrS9Pc2PEZiSbzm4oGPyKm3oIx17bNLFHvXtmu3tJSWGx7Hd2f8MRuzzMRGvYoCuIc9OCAg6S
 szmgBmkqDYZe4/WXMYsZG+TbWTqbYktYAtNn4Zrxr/2/S1jkeL2vHl2o2IgB8iEJo/oXvlyns92
 CmpyNiqUT/tMMVmChRW6E0DhaTdcqZTcIXgCtABmfDLSqLNBqHXsG66puL+98xlMenTtD3+pMBH
 F1rcBXJIQmQyEOINioCU1OsLizKbW+8I=
X-Google-Smtp-Source: AGHT+IGIrwbGfGHZ2CaiInXJ01X26/gPoKi/ZtUq8Acj6KKYibHGmeG/JNlC9svtXZpzUYaobsx9lA==
X-Received: by 2002:a05:600c:c4a5:b0:453:8bc7:5c9b with SMTP id
 5b1f17b1804b1-454b3105598mr20525425e9.24.1751624826956; 
 Fri, 04 Jul 2025 03:27:06 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bead7csm51037475e9.39.2025.07.04.03.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 03:27:06 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 04 Jul 2025 13:26:58 +0300
Subject: [PATCH 2/2] rust/qemu-api-macros: add unit tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-rust_add_derive_macro_unit_tests-v1-2-ebd47fa7f78f@linaro.org>
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
In-Reply-To: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6628;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=80zbO5iIpVqM83OtEbnFWqLbbSQHskxNes79FFPF+SE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9aNngzUU9NcFFFc2g1Z2tTb1Q1NW5VZUlhT1pXCkh1ZUk4Vk4raHAzZ2ZKVS9x
 NWlKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdlc2R3QUt
 DUkIzS2Nkd2YzNEowQmJaRC85TnN6d0xlVGt2aXFBSy85MDdKeUZldUdRaXlvYkl1WXE3dFI0Yw
 owa0t4T3hIdXhNOXRLTDkzeFQ4L2VjYU9pTEducjUwYTBSMUtVaWYreGRRSlFEN0JCWVZqcU0yV
 DlJc0g1aDhyCmFhNzlTcTlaRncwMzBsbW4vR1J1RnI4TXcwaENvRXBLMEtJZ3FrSit5NE9seUsy
 eVUyKzZqUFdPS3FwRmtBVmwKV05CQXlmOG51UUJ4am9wTnNCUUZpeEdUSnRESWQxZWdaOW9waWl
 KeHRycDBrVUo5Qm9rMnhtbHJmVE5TRTJ4YwpLWTBZa0RXUWZkeXY0REZOZzU3blJGNnlGdXdsWj
 lqU2hiS1NmWmtKbzFzY2pBcDJZTkh5MlhlYnhuSmVTT0g0ClRGL3J1d2M1czRRRmRZNFpnamRVb
 GJVVVNJWFN2aGxtTFNwK012N1ZCTUx4WEtwMXFMVU1OSTRpWG4vYWFIOVoKY2RiRWszeUZySitD
 Z1RsZkJhOUhWRGxmZUgySDFJdnVFMnVxcks4WEFkSVBWb0UwckJnaXVoT3U4Vkp0NFhObgpNYU4
 yT1NZKy9CMkg0cDQxcVlDRzN0bDZWZFp5d3Mxc2E3a2xKdXJCaWhvVDdJMklkQm9NaVRLYUliVm
 k5dDVoCllrRGtGTndwckhZcmlsRTcvc1VhditvNGRBbDFHK2E4eWNMa1BLTk1STFNtTlVNOXUvb
 XQ0RzlWQVNTdkNlOWkKc0lMNFdaZU04QzIzVGJLSjhYTkdyazA2OEYrVHVONTZZWFQvbHFOcm9L
 aHNaaGpjRTJTdXlyd1J2WEpqelBUVQoxb0VtVjIzSVFOU3cxVzFPNThzM0Nad1lKcXlJdlFSc1d
 IQ21DVXVNdHZ3bGNYTkhuYzVvZWJPZzJhSmlROTFNCm9NNUFRQT09Cj0zWHZwCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add unit tests to check Derive macro output for expected error messages,
or for expected correct codegen output.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/qemu-api-macros/meson.build  |   3 +
 rust/qemu-api-macros/src/lib.rs   |   3 +
 rust/qemu-api-macros/src/tests.rs | 135 ++++++++++++++++++++++++++++++++++++++
 rust/qemu-api-macros/src/utils.rs |   1 +
 4 files changed, 142 insertions(+)

diff --git a/rust/qemu-api-macros/meson.build b/rust/qemu-api-macros/meson.build
index 8610ce1c8440c4b6e38a8462d4975bf76d72fb05..2152bcb99b30e4bdcc1c5b887b7903a37f6181c3 100644
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
index 4b30bea9eafc7924bf593113c3f42c5b1010c4b9..6c6e9b683f047f79cb377e6d30e23490f66bd711 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -15,6 +15,9 @@
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
index 0000000000000000000000000000000000000000..dfca7d4838f141783472a4e728312aebeb9b5a8b
--- /dev/null
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -0,0 +1,135 @@
+// Copyright 2025, Linaro Limited
+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use super::*;
+use quote::quote;
+
+macro_rules! derive_compile_fail {
+    ($derive_fn:ident, $input:expr, $error_msg:expr) => {{
+        let input: proc_macro2::TokenStream = $input;
+        let error_msg: &str = $error_msg;
+        let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> =
+            $derive_fn;
+
+        let input: syn::DeriveInput = syn::parse2(input).unwrap();
+        let result = derive_fn(input);
+        let MacroError::Message(err, _) = result.unwrap_err() else {
+            panic!()
+        };
+        assert_eq!(err, error_msg);
+    }};
+}
+
+macro_rules! derive_compile {
+    ($derive_fn:ident, $input:expr, $($expected:tt)*) => {{
+        let input: proc_macro2::TokenStream = $input;
+        let expected: proc_macro2::TokenStream = $($expected)*;
+        let derive_fn: fn(input: syn::DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> =
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
diff --git a/rust/qemu-api-macros/src/utils.rs b/rust/qemu-api-macros/src/utils.rs
index 02c91aed7f6a6d33075bbaa8b4fec4536da94e60..6287d06090b60e7fc1da7fbd563d44effcc0039c 100644
--- a/rust/qemu-api-macros/src/utils.rs
+++ b/rust/qemu-api-macros/src/utils.rs
@@ -5,6 +5,7 @@
 use proc_macro2::Span;
 use quote::quote_spanned;
 
+#[derive(Debug)]
 pub enum MacroError {
     Message(String, Span),
     ParseError(syn::Error),

-- 
2.47.2


