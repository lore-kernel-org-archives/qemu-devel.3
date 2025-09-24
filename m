Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A98CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Loy-0005GA-DU; Wed, 24 Sep 2025 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Low-0005Eu-CY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1Loo-0004p8-3L
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8v7cUZBltXG+hT2nF8O88wJMH1Aq/7McKhlOMyN52ZY=;
 b=g3+xRm8wYsHsfMlHNpoB70ptpx8DpKt8bjDct3jvpBzCwfApmbGk0eTWDLiWGY3sTJT10n
 50Bg+G0tzsWWzjwqM4Eu79YMQ+hkUmuT6RTR/9Xy1hDaqcF4eJ4T4nbhcfGM6ME7ITe67W
 oM+oxjMAn5sv02WB3/bRtJPlRg0JxEs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-iYylprS2NcCzUo0dI2QQmg-1; Wed, 24 Sep 2025 05:29:39 -0400
X-MC-Unique: iYylprS2NcCzUo0dI2QQmg-1
X-Mimecast-MFC-AGG-ID: iYylprS2NcCzUo0dI2QQmg_1758706178
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b2cc0d644bcso204809166b.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706178; x=1759310978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8v7cUZBltXG+hT2nF8O88wJMH1Aq/7McKhlOMyN52ZY=;
 b=fYfoOcxCLGrySEb+AW1gKqn8g2B3SwPF6HvbE+fsggOSvIHRJTc/1zhTDOYh2u6gmu
 I5b6luMSGbAEHpmRq+dsaVJZvt+NLQ1kAKc0a/EJEayylZpy2obaAo+ObzYSZwhg26Dv
 Jq1CzrRIfwp5GqDZTc+QnBzB/rANguxXKzj0NKm13mcdNVtNEdlLgukhAviNAE2MUUj/
 e38IjG7cLyLrXUmmzSR+5R/NdwtRTTXQQi5zHtk/JNaFKmwFOb0FnXo7iZYuS2YPhlL0
 Q1OFNFTR3NecqBUfdbV1h5VHztlMSOHsn/PbJNqnkCnhN3Zz0deUFgN2zJm9iy9esZCj
 Lhng==
X-Gm-Message-State: AOJu0YyXAlYPSs4/CXubxpUcDDE2hDvvOUM+a7yfiVOT2mTRtESu7tLH
 DL7lUeUsp1SVQJPn/vJuya+rzSpzMSkckLiOABP9cqzVFdj8gaw0VhL7XCusJUVa22cbdm9R+op
 P6VeC86zh/jpMa+6awH889hmDXvANaZOP4GYyN5Lcx+lsDAC6dSYOdKvDK56ODvJXfkucBWuvJG
 PcGrYZGSIVucSxPeynhaLdAM6I+9vsC06tLyzmAXIo
X-Gm-Gg: ASbGncuekB+0rHt/jNqAowMtoE1FwKzf4/PA/WXCqMcI0NeO7hRfWUILB93zsppibbK
 EBn/do3RcY/hRV35ZeY23R4ALJ3cYkPVRiF9E0hINSsZWRRFmGgdZMmq4WGtu2Qxb0SHXv2tmwM
 1XoelcM7IzdRzEjeFG770iML01t0K/3Z9NxYJ7lF9PLnJnpDAom+kB+y22REuLtq6x33HcK2710
 I0GlPzIIKcODTAaFEmMmW9K1YyTEXq0OB8DpFXinuDHuFbjRSWMexu53N85kOXtLAESO5Wzr9R0
 kC3BnNkYVOGlqR8L3EJs4qxXKOyLf7ialCWp9twOKgiz1w+ZF7tQD+PlKZe9H/wfHQmsdtmzc0E
 sX6wIOWuIHmPIsgSQA5ptGPjb7azxsvYIAa07uEMzLj7oXw==
X-Received: by 2002:a17:907:934c:b0:afe:e7f1:289d with SMTP id
 a640c23a62f3a-b302b22ac3dmr578936966b.62.1758706177536; 
 Wed, 24 Sep 2025 02:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG89ZmLGf6N/dkjnzdkAbubgqCHYnmo9XiRdIgNZfmWBCEdtgwfeLjffBP9k+NvpCx6CCuuKg==
X-Received: by 2002:a17:907:934c:b0:afe:e7f1:289d with SMTP id
 a640c23a62f3a-b302b22ac3dmr578919866b.62.1758706173366; 
 Wed, 24 Sep 2025 02:29:33 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b26847b9f37sm1151972066b.18.2025.09.24.02.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:29:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 14/29] rust/qdev: Support bit property in #property macro
Date: Wed, 24 Sep 2025 11:28:34 +0200
Message-ID: <20250924092850.42047-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add BIT_INFO to QDevProp trait, so that bit related property info could
be bound to u32 & u64.

Then add "bit=*" field in #property attributes macro to allow device to
configure bit property.

In addtion, convert the #property field parsing from `if-else` pattern
to `match` pattern, to help readability. And note, the `bitnr` member of
`Property` struct is generated by manual TokenStream construction,
instead of conditional repetition (like #(bitnr: #bitnr,)?) since
`quote` doesn't support this.

In addtion, rename VALUE member of QDevProp trait to BASE_INFO.

And update the test cases about qdev property.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20250920160520.3699591-9-zhao1.liu@intel.com
---
 rust/hw/core/src/qdev.rs      | 19 ++++++++++++-------
 rust/qemu-macros/src/lib.rs   | 18 +++++++++++++++---
 rust/qemu-macros/src/tests.rs |  8 +++++---
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 85422e0379e..9c82e1716c5 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -109,8 +109,8 @@ pub trait ResettablePhasesImpl {
 ///
 /// # Safety
 ///
-/// This trait is marked as `unsafe` because `VALUE` must be a valid raw
-/// reference to a [`bindings::PropertyInfo`].
+/// This trait is marked as `unsafe` because `BASE_INFO` and `BIT_INFO` must be
+/// valid raw references to [`bindings::PropertyInfo`].
 ///
 /// Note we could not use a regular reference:
 ///
@@ -131,14 +131,19 @@ pub trait ResettablePhasesImpl {
 /// It is the implementer's responsibility to provide a valid
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
 pub unsafe trait QDevProp {
-    const VALUE: *const bindings::PropertyInfo;
+    const BASE_INFO: *const bindings::PropertyInfo;
+    const BIT_INFO: *const bindings::PropertyInfo = {
+        panic!("invalid type for bit property");
+    };
 }
 
 macro_rules! impl_qdev_prop {
-    ($type:ty,$info:ident) => {
+    ($type:ty,$info:ident$(, $bit_info:ident)?) => {
         unsafe impl $crate::qdev::QDevProp for $type {
-            const VALUE: *const $crate::bindings::PropertyInfo =
+            const BASE_INFO: *const $crate::bindings::PropertyInfo =
                 addr_of!($crate::bindings::$info);
+            $(const BIT_INFO: *const $crate::bindings::PropertyInfo =
+                addr_of!($crate::bindings::$bit_info);)?
         }
     };
 }
@@ -146,8 +151,8 @@ unsafe impl $crate::qdev::QDevProp for $type {
 impl_qdev_prop!(bool, qdev_prop_bool);
 impl_qdev_prop!(u8, qdev_prop_uint8);
 impl_qdev_prop!(u16, qdev_prop_uint16);
-impl_qdev_prop!(u32, qdev_prop_uint32);
-impl_qdev_prop!(u64, qdev_prop_uint64);
+impl_qdev_prop!(u32, qdev_prop_uint32, qdev_prop_bit);
+impl_qdev_prop!(u64, qdev_prop_uint64, qdev_prop_bit64);
 impl_qdev_prop!(usize, qdev_prop_usize);
 impl_qdev_prop!(i32, qdev_prop_int32);
 impl_qdev_prop!(i64, qdev_prop_int64);
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 37e1b723bd5..3e21b67b471 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -179,6 +179,7 @@ fn parse(input: ParseStream<'_>) -> syn::Result<Self> {
 #[derive(Default, Debug)]
 struct DeviceProperty {
     rename: Option<DevicePropertyName>,
+    bitnr: Option<syn::Expr>,
     defval: Option<syn::Expr>,
 }
 
@@ -187,6 +188,7 @@ fn parse_from(&mut self, a: &Attribute) -> syn::Result<()> {
         use attrs::{set, with, Attrs};
         let mut parser = Attrs::new();
         parser.once("rename", with::eq(set::parse(&mut self.rename)));
+        parser.once("bit", with::eq(set::parse(&mut self.bitnr)));
         parser.once("default", with::eq(set::parse(&mut self.defval)));
         a.parse_args_with(&mut parser)
     }
@@ -222,7 +224,11 @@ fn derive_device_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     let mut properties_expanded = vec![];
 
     for (field, prop) in properties {
-        let DeviceProperty { rename, defval } = prop;
+        let DeviceProperty {
+            rename,
+            bitnr,
+            defval,
+        } = prop;
         let field_name = field.ident.unwrap();
         macro_rules! str_to_c_str {
             ($value:expr, $span:expr) => {{
@@ -252,14 +258,20 @@ macro_rules! str_to_c_str {
             },
         )?;
         let field_ty = field.ty.clone();
-        let qdev_prop = quote! { <#field_ty as ::hwcore::QDevProp>::VALUE };
+        let qdev_prop = if bitnr.is_none() {
+            quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO }
+        } else {
+            quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO }
+        };
+        let bitnr = bitnr.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         let set_default = defval.is_some();
         let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         properties_expanded.push(quote! {
             ::hwcore::bindings::Property {
                 name: ::std::ffi::CStr::as_ptr(#prop_name),
-                info: #qdev_prop ,
+                info: #qdev_prop,
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
+                bitnr: #bitnr,
                 set_default: #set_default,
                 defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
                 ..::common::Zeroable::ZERO
diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index 00a106612fc..ec137132ae7 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -60,7 +60,7 @@ struct DummyState {
                 migrate_clock: bool,
             }
         },
-        "Expected one of `default` or `rename`"
+        "Expected one of `bit`, `default` or `rename`"
     );
     // Check that repeated attributes are not allowed:
     derive_compile_fail!(
@@ -106,8 +106,9 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                 const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
                     ::hwcore::bindings::Property {
                         name: ::std::ffi::CStr::as_ptr(c"migrate_clock"),
-                        info: <bool as ::hwcore::QDevProp>::VALUE,
+                        info: <bool as ::hwcore::QDevProp>::BASE_INFO,
                         offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
+                        bitnr: 0,
                         set_default: true,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
                         ..::common::Zeroable::ZERO
@@ -133,8 +134,9 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                 const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
                     ::hwcore::bindings::Property {
                         name: ::std::ffi::CStr::as_ptr(c"migrate-clk"),
-                        info: <bool as ::hwcore::QDevProp>::VALUE,
+                        info: <bool as ::hwcore::QDevProp>::BASE_INFO,
                         offset: ::core::mem::offset_of!(DummyState, migrate_clock) as isize,
+                        bitnr: 0,
                         set_default: true,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
                         ..::common::Zeroable::ZERO
-- 
2.51.0


