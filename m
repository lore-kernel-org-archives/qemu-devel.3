Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8125C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 14:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXL44-0000rN-QG; Thu, 03 Jul 2025 10:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXL42-0000qz-RE
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:37:26 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXL3x-0003EE-PZ
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 10:37:26 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so15472334a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 07:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751553439; x=1752158239; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UgN/FxtBkjS1o/sTbqBEuCOXWdexvI4CUOuORGk+ghc=;
 b=v5NgVcSEjNIr049gJ6OBuSsD/16Hr3woom5K/bH7tlvLapneRLKIwTBc8etikaOCyL
 QRWAugNLckZYpw8Mgot0Q6jdE1xwxqXewvLijMxWoTrM5t50qHRCvQM1IEBmvsvt1how
 2fy0nEBodkczLEiQDGyTseZ7UFl7hpY6PNp/ECf9I7gIiUtKdmBLccs6x8AG7gw4ZGZ8
 Ow+SjtjJdV/wzjZLVvISFwvbh9knq0JtBNmlnlrFYrSu0guuKspxwJsxV2B2P+/C21sc
 rqq/qbwbA0bqO29Gw0OHhJgQPxz5MM8BoVfmT15mydVzDIOwm0ZbsE42ku98yvuNfO5Z
 hzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751553439; x=1752158239;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgN/FxtBkjS1o/sTbqBEuCOXWdexvI4CUOuORGk+ghc=;
 b=NsXszZ8j8IGenKVKZpwFPzxjIjpu7cJMDWAGAF2rQSvjGddkUUTXxuDFEiq1iT0sBy
 lO+djP9vZK+2URTwj7KfsZW9SN/iBd67DvhVYuYmoPpvTKvidagrErWErkm/sOzSgcgQ
 hdbTdvDIjPYWejis6276dLqBk+GID/rdyNgf9FxwyUEPZS5D6q1A8Zythg3T/dtB8tYe
 INAPvOIbL+YgEeByaQBz0Gq0bZOKV46IAbS+3nU602W8SLkr2ahNksGKnzzSLukQq0tX
 okooGd1ZJ4j7y8Q76bzSa76nmjODQpDcgmkE9meWOjQBdh8UcUdbGS8w6lsQMWoslxCz
 w/uA==
X-Gm-Message-State: AOJu0YxmGnYc1ibQ/v36xfSDGoVTCcc3qXMj28cn1i+K3VJq3UPc9WoN
 qnZ1LLrVJcSKSVakiBc+QdvPm+urPAlvgGLMFNQm4NHNNYg5pnzm09p3I6wpIv6NabQ=
X-Gm-Gg: ASbGncuxAZlCJhl51HOEukNAIh5P+MpXPz0CkYlLtjjRSc0Hukvtuy9KQpnRZPL7T2f
 GOkHFhdQAgX0m7+FJhocSLtzDE/4cXDQMtmAVhxlPFdk5Ys3cKqmApTamFjPpYSljfESguQyJ7e
 hMOpl+WkrQhfZaLOR4egUI17pCFYwrHtmxT7B+sSjjvdMnEb1ybA26LP0Y/SuPRWUP61u579RQb
 AjXv2UviMMQE2zpB+GjwhfE1onQp/pgP4D2TUN/cbI+SFK4KqJCRFcaaxDkEXuPinnLQLMXUPvZ
 yaHTGP6aMz6hXks5fMFnVGqXk3nN/zDqOicFYI2UuoPoD9593FhjNyEUxEpqiQk3XkSvfeNt9AV
 8za4IokENillhiRUAh0eVmexkIFyfRr0=
X-Google-Smtp-Source: AGHT+IGbAmCPrQ7pBgdLUQqn37lad7ouRjDl7odnYpk8w4LkYwZ5ihI1XR5EYsHVgtAiLYrr6AXM/Q==
X-Received: by 2002:a17:906:7953:b0:ae3:64ec:5eb0 with SMTP id
 a640c23a62f3a-ae3d83c9f66mr332125466b.11.1751553438410; 
 Thu, 03 Jul 2025 07:37:18 -0700 (PDT)
Received: from [127.0.1.1] (ppp-2-86-212-125.home.otenet.gr. [2.86.212.125])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c01980sm1250103866b.81.2025.07.03.07.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 07:37:17 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 03 Jul 2025 17:37:02 +0300
Subject: [PATCH RFC v2] rust: add qdev DeviceProperties derive macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org>
X-B4-Tracking: v=1; b=H4sIAI2VZmgC/32PzWrDMBCEXyXoXBVLkeSfU6DQB+i1BCNba0dgS
 85KdhtC3r1bt/TYwx5ml/lm9s4SoIfEmsOdIWw++RhIyKcD6y82jMC9I81kIXWhpeS4psyvDja
 +YFwAM7l5KSuoBmOVqYCRdUEY/OeOfWdvry/sTMuLTznibY/axH76n7oJLrjuRNVJGuvEafLBY
 nyOOLLz4ycH4bpS6/wb9leafviGl8Vxh7edD86HMbV2muJHu4YAPaRk8dZmtCHNKyG4M0K5Tml
 RWtVQScrobALex3n2uTn0Jb16dE67shaqHhSUUINzRTEYrYTpjaoAdE31Hl/IkdPxXAEAAA==
X-Change-ID: 20250522-rust-qdev-properties-728e8f6a468e
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=20174;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=/VO5zP5Lo+XvaHQwOkGYbNjfoknEuyrHlAKbcgzewMg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9acFdkYng3bFJENktoYlQ1bXhnT05XekpYR3ppCllvQ0RWVTMzVWNKTjQrR3Br
 dmVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUdhVm5RQUt
 DUkIzS2Nkd2YzNEowSloyRUFDQjBuM0lBU3dvSkozaEJ1clQwNWE2UHdVUzV5OUEzeW1wd3JLVA
 p5WlkrOUIrc2ptSU9PYjhKbDJQWmt5aFF5VDAvUDliSGxNRnB2UWd6Wm5Gc3lhRWRBbEc3a2dtY
 TV1YVRsSHRYCm9jRzluNXF4dUlTY2YvSk1ZNVUxbmpCWVVCd0RVL2QwR2p6YnMxNTVxNGhYZ01Z
 Ni9yZkdtWDlvMU51UGhVaHEKRVU4OVpFcWZ6YnZLeGlFZVF0Z1RraU5kNzN2UUVMUmV2S21ZSWs
 yU0RtM0NITSt2SkljY3FZYkZtbGVMY1VZUgpXOWtlZko2cHJYOVI5dzdybHdOTFg5emNHZU00cD
 RjOTd4RW5pVXNjSnN0OWMyeGJySC9QMnZObE44VXY3c1NMCnc1YUMvdEdYRHVRT3o1UmtVZVcyW
 mo5TXgxSDB4cXVxVW5ybCs2d0JlTnJWOTZDWlpuMTlJWmZrVzRDUFdZNysKQ2ROL3hidDFNRzJ5
 UGc1S1FRMXI5aVp3Tzl0VnJXUmI4RkgyeFJUblY2R2hlR1VWOVhTTk1DT0ZGWWY4dkVVcwpqR2V
 STFVFdEJHem1ieEhGOXNyVGYxVWFCS3lyTllCNU1MTXJEWmw2WkhGQkJ5WVNGU1UwNjhjYnBqZG
 9rdjNBCkpPQVE1QnREQXFUNnNkdEJ2SG5UTS9zUUdOZFkxWHBMNmVLMFJ4S3ZibTNIcUVBSDJ4a
 XZQTVI4WWNWRmRjT0QKNXJJOWg5RS91NkJMTEw4ekhKaXlLdU53NjJ6emdUQnhkaSttOHB5MlhE
 V21ZOFdWVENDTnE4dlV5OUlVeHF6TQphRDQwdStoaGUvWVVzbC96RWJqVUFPdUlHQ2hsenhFVTZ
 jNG1uaWtUaFdQQ0pZMklNYWtQYmFyZDFHRzJSMVZDCmlYUEFoUT09Cj1YeXJFCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
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

Add derive macro for declaring qdev properties directly above the field
definitions. To do this, we split DeviceImpl::properties method on a
separate trait so we can implement only that part in the derive macro
expansion (we cannot partially implement the DeviceImpl trait).

Adding a `property` attribute above the field declaration will generate
a `qemu_api::bindings::Property` array member in the device's property
list.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
TODOs:

- Update hpet code to use the derive macro
- Change MacroError use to syn::Error use if changed in upstream too

Changes in v2:
- Rewrite to take advantage of const_refs_to_static feature, we still
  need to update to a newer MSRV.
- Use existing get_fields function (Paolo)
- return errors instead of panicking (Paolo)
- Link to v1: https://lore.kernel.org/qemu-devel/20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org
---
 rust/hw/char/pl011/src/device.rs       |  13 +-
 rust/hw/char/pl011/src/device_class.rs |  26 +---
 rust/hw/timer/hpet/src/device.rs       |   4 +-
 rust/qemu-api-macros/src/lib.rs        | 217 ++++++++++++++++++++++++++++++++-
 rust/qemu-api/src/qdev.rs              |  57 +++++++--
 rust/qemu-api/tests/tests.rs           |   9 +-
 6 files changed, 282 insertions(+), 44 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5b53f2649f161287f40f79075afba47db6d9315c..b2b8dcdfeb6797286918a5ec3e94e1c254e176fe 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,7 +12,10 @@
     log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qdev::{
+        Clock, ClockEvent, DeviceImpl, DevicePropertiesImpl, DeviceState, ResetType,
+        ResettablePhasesImpl,
+    },
     qom::{ObjectImpl, Owned, ParentField, ParentInit},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -101,12 +104,13 @@ pub struct PL011Registers {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::DeviceProperties)]
 /// PL011 Device Model in QEMU
 pub struct PL011State {
     pub parent_obj: ParentField<SysBusDevice>,
     pub iomem: MemoryRegion,
     #[doc(alias = "chr")]
+    #[property(rename = "chardev")]
     pub char_backend: CharBackend,
     pub regs: BqlRefCell<PL011Registers>,
     /// QEMU interrupts
@@ -125,6 +129,7 @@ pub struct PL011State {
     #[doc(alias = "clk")]
     pub clock: Owned<Clock>,
     #[doc(alias = "migrate_clk")]
+    #[property(rename = "migrate-clk", default = true)]
     pub migrate_clock: bool,
 }
 
@@ -172,9 +177,6 @@ impl ObjectImpl for PL011State {
 }
 
 impl DeviceImpl for PL011State {
-    fn properties() -> &'static [Property] {
-        &device_class::PL011_PROPERTIES
-    }
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
@@ -709,6 +711,7 @@ impl PL011Impl for PL011Luminary {
     const DEVICE_ID: DeviceId = DeviceId(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
 }
 
+impl DevicePropertiesImpl for PL011Luminary {}
 impl DeviceImpl for PL011Luminary {}
 impl ResettablePhasesImpl for PL011Luminary {}
 impl SysBusDeviceImpl for PL011Luminary {}
diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index d328d846323f6080a9573053767e51481eb32941..83d70d7d82aac4a3252a0b4cb24af705b01d3635 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -8,11 +8,8 @@
 };
 
 use qemu_api::{
-    bindings::{qdev_prop_bool, qdev_prop_chr},
-    prelude::*,
-    vmstate::VMStateDescription,
-    vmstate_clock, vmstate_fields, vmstate_of, vmstate_struct, vmstate_subsections, vmstate_unused,
-    zeroable::Zeroable,
+    prelude::*, vmstate::VMStateDescription, vmstate_clock, vmstate_fields, vmstate_of,
+    vmstate_struct, vmstate_subsections, vmstate_unused, zeroable::Zeroable,
 };
 
 use crate::device::{PL011Registers, PL011State};
@@ -82,22 +79,3 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
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
index acf7251029e912f18a5690b0d6cf04ea8151c5e1..35b8e57fa897f625a6b3e266f9a751a630c21a64 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -1031,11 +1031,13 @@ impl ObjectImpl for HPETState {
     ..Zeroable::ZERO
 };
 
-impl DeviceImpl for HPETState {
+impl qemu_api::qdev::DevicePropertiesImpl for HPETState {
     fn properties() -> &'static [Property] {
         &HPET_PROPERTIES
     }
+}
 
+impl DeviceImpl for HPETState {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_HPET)
     }
diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index c18bb4e036f4e7737f9b95ac300b7d1e8742ef1f..1746da4d967b7ec733c0d97c26d3275fb1cd6645 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,10 +3,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use quote::quote;
+use quote::{quote, quote_spanned, ToTokens};
 use syn::{
-    parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned, token::Comma, Data,
-    DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token, Variant,
+    parse::Parse, parse_macro_input, parse_quote, punctuated::Punctuated, spanned::Spanned,
+    token::Comma, Data, DeriveInput, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
+    Variant,
 };
 
 mod utils;
@@ -146,6 +147,216 @@ pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wr
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
+    qdev_prop: Option<syn::Path>,
+    bitnr: Option<syn::Expr>,
+    defval: Option<syn::Expr>,
+}
+
+impl Parse for DeviceProperty {
+    fn parse(input: syn::parse::ParseStream) -> syn::Result<Self> {
+        let _: syn::Token![#] = input.parse()?;
+        let bracketed;
+        _ = syn::bracketed!(bracketed in input);
+        let _attribute = bracketed.parse::<syn::Ident>()?;
+        debug_assert_eq!(&_attribute.to_string(), "property");
+        let mut retval = Self {
+            rename: None,
+            qdev_prop: None,
+            bitnr: None,
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
+            } else if value == "qdev_prop" {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.qdev_prop.is_some() {
+                    return Err(syn::Error::new(
+                        value.span(),
+                        "`qdev_prop` can only be used at most once",
+                    ));
+                }
+                retval.qdev_prop = Some(content.parse()?);
+            } else if value == "bitnr" {
+                let _: syn::Token![=] = content.parse()?;
+                if retval.bitnr.is_some() {
+                    return Err(syn::Error::new(
+                        value.span(),
+                        "`bitnr` can only be used at most once",
+                    ));
+                }
+                retval.bitnr = Some(content.parse()?);
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
+#[proc_macro_derive(DeviceProperties, attributes(property))]
+pub fn derive_device_properties(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_device_properties_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
+}
+
+fn derive_device_properties_or_error(
+    input: DeriveInput,
+) -> Result<proc_macro2::TokenStream, MacroError> {
+    let span = proc_macro::Span::call_site();
+    let properties: Vec<(syn::Field, proc_macro2::Span, DeviceProperty)> =
+        get_fields(&input, "#[derive(DeviceProperties)]")?
+            .iter()
+            .flat_map(|f| {
+                f.attrs
+                    .iter()
+                    .filter(|a| a.path().is_ident("property"))
+                    .map(|a| {
+                        Ok((
+                            f.clone(),
+                            f.span(),
+                            syn::parse(a.to_token_stream().into()).map_err(|err| {
+                                MacroError::Message(
+                                    format!("Could not parse `property` attribute: {err}"),
+                                    f.span(),
+                                )
+                            })?,
+                        ))
+                    })
+            })
+            .collect::<Result<Vec<_>, MacroError>>()?;
+    let name = &input.ident;
+    let mut properties_expanded = vec![];
+    let zero = syn::Expr::Verbatim(quote! { 0 });
+
+    for (field, field_span, prop) in properties {
+        let DeviceProperty {
+            rename,
+            qdev_prop,
+            bitnr,
+            defval,
+        } = prop;
+        let field_name = field.ident.as_ref().unwrap();
+        let prop_name = rename
+            .as_ref()
+            .map(|lit| -> Result<proc_macro2::TokenStream, MacroError> {
+                match lit {
+                DevicePropertyName::CStr(lit) => {
+                    let span = lit.span();
+                    Ok(quote_spanned! {span=>
+                        #lit
+                    })
+                }
+                DevicePropertyName::Str(lit) => {
+                    let span = lit.span();
+                    let value = lit.value();
+                    let lit = std::ffi::CString::new(value.as_str())
+                        .map_err(|err| {
+                            MacroError::Message(
+                                format!("Property name `{value}` cannot be represented as a C string: {err}"),
+                                span
+                            )
+                        })?;
+                    let lit = syn::LitCStr::new(&lit, span);
+                    Ok(quote_spanned! {span=>
+                        #lit
+                    })
+                }
+            }})
+            .unwrap_or_else(|| {
+                let span = field_name.span();
+                let field_name_value = field_name.to_string();
+                let lit = std::ffi::CString::new(field_name_value.as_str()).map_err(|err| {
+                    MacroError::Message(
+                        format!("Field `{field_name_value}` cannot be represented as a C string: {err}\nPlease set an explicit property name using the `rename=...` option in the field's `property` attribute."),
+                        span
+                    )
+                })?;
+                let lit = syn::LitCStr::new(&lit, span);
+                Ok(quote_spanned! {span=>
+                    #lit
+                })
+            })?;
+        let field_ty = field.ty.clone();
+        let qdev_prop = qdev_prop
+            .as_ref()
+            .map(|path| {
+                quote_spanned! {field_span=>
+                    unsafe { &#path }
+                }
+            })
+            .unwrap_or_else(
+                || quote_spanned! {field_span=> <#field_ty as ::qemu_api::qdev::QDevProp>::VALUE },
+            );
+        let set_default = defval.is_some();
+        let bitnr = bitnr.as_ref().unwrap_or(&zero);
+        let defval = defval.as_ref().unwrap_or(&zero);
+        properties_expanded.push(quote_spanned! {field_span=>
+            ::qemu_api::bindings::Property {
+                name: ::std::ffi::CStr::as_ptr(#prop_name),
+                info: #qdev_prop ,
+                offset: ::core::mem::offset_of!(#name, #field_name) as isize,
+                bitnr: #bitnr,
+                set_default: #set_default,
+                defval: ::qemu_api::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
+                ..::qemu_api::zeroable::Zeroable::ZERO
+            }
+        });
+    }
+
+    Ok(quote_spanned! {span.into()=>
+        impl ::qemu_api::qdev::DevicePropertiesImpl for #name {
+            fn properties() -> &'static [::qemu_api::bindings::Property] {
+                static PROPERTIES: &'static [::qemu_api::bindings::Property] = &[#(#properties_expanded),*];
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
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 36f02fb57dbffafb21a2e7cc96419ca42e865269..01f199f198c6a5f8a761beb143e567fc267028aa 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -101,8 +101,54 @@ pub trait ResettablePhasesImpl {
     T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
 }
 
+/// Helper trait to return pointer to a [`bindings::PropertyInfo`] for a type.
+///
+/// This trait is used by [`qemu_api_macros::DeviceProperty`] derive macro.
+///
+/// # Safety
+///
+/// This trait is marked as `unsafe` because currently having a `const` refer to an `extern static`
+/// results in this compiler error:
+///
+/// ```text
+/// constructing invalid value: encountered reference to `extern` static in `const`
+/// ```
+///
+/// It is the implementer's responsibility to provide a valid [`bindings::PropertyInfo`] pointer
+/// for the trait implementation to be safe.
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
+pub trait DevicePropertiesImpl {
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
@@ -111,13 +157,6 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
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
@@ -175,7 +214,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             self.vmsd = vmsd;
         }
-        let prop = <T as DeviceImpl>::properties();
+        let prop = <T as DevicePropertiesImpl>::properties();
         if !prop.is_empty() {
             unsafe {
                 bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index a658a49fcfdda8fa4b9d139c10afb6ff3243790b..e8eadfd6e9add385ffc97de015b84aae825c18ee 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -9,7 +9,7 @@
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
-    qdev::{DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
+    qdev::{DeviceImpl, DevicePropertiesImpl, DeviceState, Property, ResettablePhasesImpl},
     qom::{ObjectImpl, ParentField},
     sysbus::SysBusDevice,
     vmstate::VMStateDescription,
@@ -68,10 +68,13 @@ impl ObjectImpl for DummyState {
 
 impl ResettablePhasesImpl for DummyState {}
 
-impl DeviceImpl for DummyState {
+impl DevicePropertiesImpl for DummyState {
     fn properties() -> &'static [Property] {
         &DUMMY_PROPERTIES
     }
+}
+
+impl DeviceImpl for DummyState {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE)
     }
@@ -85,6 +88,8 @@ pub struct DummyChildState {
 
 qom_isa!(DummyChildState: Object, DeviceState, DummyState);
 
+impl DevicePropertiesImpl for DummyChildState {}
+
 pub struct DummyChildClass {
     parent_class: <DummyState as ObjectType>::Class,
 }

---
base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
change-id: 20250522-rust-qdev-properties-728e8f6a468e
prerequisite-change-id: 20250703-rust_bindings_allow_unnecessary_transmutes-d614db4517a4:v1
prerequisite-patch-id: 570fede8eee168ade58c7c7599bdc8b94c8c1a22

--
γαῖα πυρί μιχθήτω


