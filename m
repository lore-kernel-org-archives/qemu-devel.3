Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A4CC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9Yy-00037n-0o; Fri, 11 Jul 2025 04:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ua9S7-0001M0-6b
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:49:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ua9Rz-0003NS-CA
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:49:52 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-455e6fb8057so3204785e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752223782; x=1752828582; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vhtYSIZwTks+U2FrcpwJn+n273C3qKLVoaZdAk37u2M=;
 b=w+oB2D3eflyRG8ExXlRxYp9fTZdOiIh3+wN0oak4DV2yNLq4aEeDP2WtlbdQjhtKz5
 QG3izTSwQ4/ipkMdH3lCGrc2be0c/DZoyh4f1pr04x85r6QkjyJbUadFvufSbegiXnjF
 n0nQyUbR7C7DJ6sxO0c8DYu7nCnS9o8qdJCQQkTkaDkccUTqfoSz1LiTjc1E/qZiePu1
 qfb0+q9XGsyxmscqDDLn9tMWZx4/9keNaSj7FrvRPaVrvl3E9EyEuyXcU3GfT43e5EJl
 Joh+K7h20crVtC62H9jXBt8vwfI6FBo1x2Wt2Zxk/31SO8NK0pTEPLZq0qcyaBbUFB51
 nEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223782; x=1752828582;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vhtYSIZwTks+U2FrcpwJn+n273C3qKLVoaZdAk37u2M=;
 b=YbZf+aKMR5S/ZA8MWfRi5OvrdeVzdQTTiBf7BMxBsD2mXZ9H5XvpIobssWQR9gLhZW
 ip0Lt4dj2DhuVisufJRDRikb+CepRMVkIoeaUDMc5t8lHn4oqVv6BunDKdKvfkSK1Wg/
 ocGxeUteDPCmJDPcm92NR8Isn4czILah9eoTPJew2cGnG/oaEpq/QfzJRQ/XUk/K53Gi
 Dcv8gGzOgtzo2q0dKTwn0AiPTnTXVbkrvOrFSujdQ/v+/ADVAcGFDG2LM/NGGC/PTZEf
 PRq4rmOwcRMVT1HNx0D6MZB2t3MF1qKbEWxFX6QDyqe8ELKPX9RZBWvvm1gTe3fU+K5A
 Oiyw==
X-Gm-Message-State: AOJu0Yz/m5X0aDf069pv+gwE1lsiVBwI9r7KHlKMVf588RD3+dlQ9tIj
 S3djUeSEVyMDzHnGBLZ6rPZ5bdqeOD2LNVj0p7X4q7cxPtj2nk2wJ7DGJ4rdSrnw6As=
X-Gm-Gg: ASbGncuHV+D9/6ZHrdz1ZvJac8HJfLEKtZ9Dl+OZo5jj+U6SzqxdBCNHDv2AsRhTHRg
 kWXLpsPaXRJHxdvqnVWuJOquwc517yzZTR/DGVKNGLiT7ZlKK3/iX6HoV6tvT69mjW2yMvQIPx1
 lfnmiL8Pled9fJvueTA8D/mArqyrvTESMF+qHUnq/cjo5gvyii8kWfG6iwSJXHaO7uCOB6pXAO+
 JIsMP1XHCixwI42QnJcB+c9RPSGt+OwvyTrNdEya3JxyRy+IiGAA2ihX9OxIfdXJGFtyVChPo/G
 APodPtUH38HvJiZXNKJc52R7apWVldN5nqvAnW5IX9DhWGuTHPktapnEM7GZK6NOASnaMfgapG2
 OCAbDcY7oiOBRikvPNjIVVBRdGnFYDxnKYcsnJquz5/A5H0RPUTAfJZJe4ypxg7DpmWI=
X-Google-Smtp-Source: AGHT+IGN7brDpnyy9cvqfu+icEwoQ7ujSBQHf9rxmzeECAho5I9ilK9ufMYuJDWcxviehJyFs/OJqQ==
X-Received: by 2002:a05:600c:4589:b0:453:92b6:ff84 with SMTP id
 5b1f17b1804b1-4556f8bd13dmr15621395e9.3.1752223781714; 
 Fri, 11 Jul 2025 01:49:41 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4440352.home.otenet.gr. [79.129.177.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537932sm40955625e9.20.2025.07.11.01.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 01:49:41 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 11 Jul 2025 11:49:26 +0300
Subject: [PATCH v3] rust: add qdev Device derive macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250711-rust-qdev-properties-v3-1-e198624416fb@linaro.org>
X-B4-Tracking: v=1; b=H4sIABXQcGgC/4XRS27DIBAG4KtYrEsFmIftVe9RVRb2jFOkGBLAb
 qMody9J2qZZRF2wGKT/Y2Y4koTRYSJddSQRV5dc8KWonyoyvlu/Qeqg1EQwoZgSgsYlZboHXOk
 uhh3GXNLUiAabSVupGyQluos4uc8L+/pW6neXcoiHyysrP9/+A66ccqoG3gyiHAv8Zeu8jeE5x
 A05i6u4KYbVDxRRFJB2sqPRGlt5p5yujUbcL2XsfO32NnVX3eH94Dw4v0m93W7DR794jyOmZOO
 hz9H6NC+FoKC5hEEqbqzsyqh/9/gryqtoAXoo61+xn+0YQzFd7ouSE63RgJ1apkCLh853Z5dwo
 qqGFrVlQ8N+IoNNSMcwzy531WjKN9UACkzLZTtJNNgiAGOTVpLrUcsGUbVlM6cvI/HmrhgCAAA
 =
X-Change-ID: 20250522-rust-qdev-properties-728e8f6a468e
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24788;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=wnTR/z95vLJb904rqMOXwFTZYuZ2sXw53+iriT2+OXk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9jTkFrc3ZmSDRocjBwOW5JYWdxWm5NcVBld1ZLCm5pc2lYdWJSa29DU0ovT1lU
 V2lKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUhEUUpBQUt
 DUkIzS2Nkd2YzNEowREZjRC85WlFrZEFWUkdxTERYTG5yeE9QVTF3YTFYQVlTd3ZqNWo3NW9ZVA
 puWURUVnA0SVc2dFB4ME1aU1p4cUc3Y0pUb0VBWktuR00ydzh6NEdSMWdGY1BpMnpSVEdRVjVDW
 FlURE1QQUxvCnJWenFWRVBCNVp6NDFUWHZaTS85b3BHWHRDK252TC9uR0tZQ3JpRjlLeUdqZERG
 NU94VVQrUUp4QllicmhTa1oKWjVCblZrR1RVZlF3MW51Z0wwL0cxNGdIZ0V2TDczZitPWjl4Z3J
 WeFY1bVYweUtWV1h3UzF2MFVVWGZLYjhNVQpTTThPUndTR21PMlhHYkVONHNZajlzNzVVVDNYZm
 9oZTJ6bkwyVUJwVmc5T1VWRlRBRFk4anplaFdoS0RMMzBzCi9qemoyQnMzR2RaZk9sUDRVRHNJT
 UlWeUxZME81VFcyL014NVp4eWEyWXpqMm5xSTJwTnlLc1VBM3N5b2lMeVMKOWdSSG85a1prcFVH
 MFY0cUhEaGxsaDVjNHkrdGxEbDZzMTl5WFM1OEkvejdhZm9aT1owNm53UlVqa2NOVzJkSwovc0d
 SVTV3YmJEYm83ZVFUaXdYYS9Ud1A2RXpSajB5VnVMSmRiRWlDVHl5b3lkbXdCWlNQdmxOaG5GTn
 Q1MjB0CjlUZkp2aXJ4MFVCSk1oQStPRWtsQzlJVzQyc3FpYlpUYVR4SENyaUxkVEhOZDR3QldlW
 mRRcTRCUkplNWFsNVYKc3Z4cGxMVmNiTWF0ZnJXZlFEamRYMlRBZEoxSGpSdFl0SVkrcjRiQmhO
 UCtNdUJuNVFmRndWN1Y4RWFRK1l5awpRRWpVNERrYUpreHNYZUhHRlR3c0xoSlREY3lySVJLdUR
 Yd2RYdFFTbUgzL1pHdXdDUTZXalcweE8vc2RhZjZvCmoyTnJyZz09Cj1RaWZnCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
This patch depends on patches that haven't been merged yet to master, so
you can checkout this tree if you want to test it:
  https://gitlab.com/epilys/qemu/-/tree/b4/rust-qdev-properties

TODOs:

- Update hpet code to use the derive macro

Changes in v3:
- Change MacroError use to syn::Error, depends on
  <20250703-rust_macros-v1-1-b99f82febbbf@linaro.org>
- Add derive macro unit test, depends on
  <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
- Rename derive macro to just `Device`
- Fixed clippy warnings (shadowing of var declarations etc)
- Fixed unnecessary quote_spanned uses (thanks Paolo)
- Removed unnecessary .as_ref() (Paolo)
- Refactor CString conversion for property name (Paolo)
- use Derive macro for empty property impls (Paolo)
- Remove qdev_prop/bitnr attributes, add them in future work
- Expand doc comment of QdevProp trait to explain about extern static
  refs
- Mark DevicePropertiesImpl trait as unsafe
- Link to v2: https://lore.kernel.org/qemu-devel/20250703-rust-qdev-properties-v2-1-d4afac766e94@linaro.org

Changes in v2:
- Rewrite to take advantage of const_refs_to_static feature, we still
  need to update to a newer MSRV.
- Use existing get_fields function (Paolo)
- return errors instead of panicking (Paolo)
- Link to v1: https://lore.kernel.org/qemu-devel/20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org
---
 rust/hw/char/pl011/src/device.rs       |  11 ++-
 rust/hw/char/pl011/src/device_class.rs |  26 +-----
 rust/hw/timer/hpet/src/device.rs       |   5 +-
 rust/qemu-api-macros/src/lib.rs        | 151 ++++++++++++++++++++++++++++++++-
 rust/qemu-api-macros/src/tests.rs      | 111 ++++++++++++++++++++++++
 rust/qemu-api/src/qdev.rs              |  68 +++++++++++++--
 rust/qemu-api/tests/tests.rs           |  24 ++----
 7 files changed, 334 insertions(+), 62 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5b53f2649f161287f40f79075afba47db6d9315c..4338ba80a698bb9150cffb38888d13ffa861d5d4 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,7 +12,7 @@
     log_mask_ln,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
-    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, Owned, ParentField, ParentInit},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -101,12 +101,13 @@ pub struct PL011Registers {
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
@@ -125,6 +126,7 @@ pub struct PL011State {
     #[doc(alias = "clk")]
     pub clock: Owned<Clock>,
     #[doc(alias = "migrate_clk")]
+    #[property(rename = "migrate-clk", default = true)]
     pub migrate_clock: bool,
 }
 
@@ -172,9 +174,6 @@ impl ObjectImpl for PL011State {
 }
 
 impl DeviceImpl for PL011State {
-    fn properties() -> &'static [Property] {
-        &device_class::PL011_PROPERTIES
-    }
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
@@ -686,7 +685,7 @@ pub fn post_load(&self, _version_id: u32) -> Result<(), ()> {
 }
 
 #[repr(C)]
-#[derive(qemu_api_macros::Object)]
+#[derive(qemu_api_macros::Object, qemu_api_macros::Device)]
 /// PL011 Luminary device model.
 pub struct PL011Luminary {
     parent_obj: ParentField<PL011State>,
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
index acf7251029e912f18a5690b0d6cf04ea8151c5e1..cffd20c471f1524f8a41b3a5b8c9309f3b59c61c 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -1031,11 +1031,14 @@ impl ObjectImpl for HPETState {
     ..Zeroable::ZERO
 };
 
-impl DeviceImpl for HPETState {
+// SAFETY: HPET_PROPERTIES is a valid Property array constructed with the qemu_api::declare_properties macro.
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
index b525d89c09e496a1f7f5582dc6d994e318f62bca..c95c0b612129f1460bb532d17f6acb40d31bcd5d 100644
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
@@ -146,6 +147,150 @@ pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wr
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
+                let cstr = std::ffi::CString::new(value.as_str())
+                    .map_err(|err| {
+                        Error::new(
+                            span,
+                            format!("Property name `{value}` cannot be represented as a C string: {err}"),
+                        )
+                    })?;
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
index b75b6fbb98956583826eca51aee7b48bb06aab21..5bcabe6823e22985129a82e89a54533e6ace6778 100644
--- a/rust/qemu-api-macros/src/tests.rs
+++ b/rust/qemu-api-macros/src/tests.rs
@@ -32,6 +32,117 @@ macro_rules! derive_compile {
 }
 
 #[test]
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
+#[test]
 fn test_derive_object() {
     derive_compile_fail!(
         derive_object_or_error,
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 36f02fb57dbffafb21a2e7cc96419ca42e865269..f1dcb14f6ea76e9457e0a5b18f92df7f18c54436 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -101,8 +101,65 @@ pub trait ResettablePhasesImpl {
     T::EXIT.unwrap()(unsafe { state.as_ref() }, typ);
 }
 
+/// Helper trait to return pointer to a [`bindings::PropertyInfo`] for a type.
+///
+/// This trait is used by [`qemu_api_macros::Device`] derive macro.
+///
+/// Base types that already have `qdev_prop_*` globals in the QEMU API should use those values as
+/// exported by the [`bindings`] module, instead of redefining them.
+///
+/// # Safety
+///
+/// This trait is marked as `unsafe` because currently having a `const` refer to an `extern static`
+/// as a reference instead of a raw pointer results in this compiler error:
+///
+/// ```text
+/// constructing invalid value: encountered reference to `extern` static in `const`
+/// ```
+///
+/// This is because the compiler generally might dereference a normal reference during const
+/// evaluation, but not in this case (if it did, it'd need to dereference the raw pointer so this
+/// would fail to compile).
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
@@ -111,13 +168,6 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
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
@@ -175,7 +225,7 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             self.vmsd = vmsd;
         }
-        let prop = <T as DeviceImpl>::properties();
+        let prop = <T as DevicePropertiesImpl>::properties();
         if !prop.is_empty() {
             unsafe {
                 bindings::device_class_set_props_n(self, prop.as_ptr(), prop.len());
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index a658a49fcfdda8fa4b9d139c10afb6ff3243790b..aff3eecd654e14952884d96cc793548df4e390b0 100644
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

---
base-commit: c77283dd5d79149f4e7e9edd00f65416c648ee59
change-id: 20250522-rust-qdev-properties-728e8f6a468e
prerequisite-change-id: 20250703-rust_bindings_allow_unnecessary_transmutes-d614db4517a4:v1
prerequisite-patch-id: 570fede8eee168ade58c7c7599bdc8b94c8c1a22
prerequisite-change-id: 20250704-rust_add_derive_macro_unit_tests-3e7daf905d62:v1
prerequisite-patch-id: 08d7aa46ded5f33efaf4e9d450f1080854cb6b2d
prerequisite-patch-id: 48db905333ffc7c9725cf72d646cc265a9d9ef36
prerequisite-change-id: 20250703-rust_macros-53d9e6a0b802:v1
prerequisite-patch-id: 985f50552aa858d14dcbc709d87e65d21538747d

--
γαῖα πυρί μιχθήτω


