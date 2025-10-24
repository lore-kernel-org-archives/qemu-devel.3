Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58658CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 03:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC8qP-00025F-FC; Thu, 23 Oct 2025 23:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vC8qN-00024a-34; Thu, 23 Oct 2025 23:51:59 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vC8q8-0000mR-KI; Thu, 23 Oct 2025 23:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761277905; x=1792813905;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=P9d7AvBWexqqmIBuTu4J+YIDKpgdaZUG36V6xx42Upo=;
 b=c888EEjKT/LKKpqesaSdWMj9jeUE74MpmY/WiwceP0opM25NBl4Fo1z7
 KVGtXQNdZ/9wyRBEDHdOOz9XAyRBkF559NwuTYFMIye4AnC6b9eJuAKhQ
 lRE2Orly3Bk4dARgBZVv3TemVBbx8TNkQMz6leRiLt+276X8ZloR827bR
 wGrBPMScbzFedfBZs0VDfP4T8cm4+MaBq5KshByB0HQSKh9khHeRr6hAC
 V82oi803RuS0NLPDoyqhFIEk2jW9HxQjrNNQYY13z5Rd1fvnTBQNm7/zc
 4yzQtF5uDkx5kJHlFq2dycA48gVaOgn4TW1oXZJjB6/OgSkUQQX8uMdCl g==;
X-CSE-ConnectionGUID: Oj2HehJkRBO3PMLHFO0h0A==
X-CSE-MsgGUID: mQ1LqAOQQVqgE3OGyV6TNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="80892393"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="80892393"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 20:51:39 -0700
X-CSE-ConnectionGUID: PFl4ODBQTbCbTcn/isx1hQ==
X-CSE-MsgGUID: Yu/nMQgkQEKnbWmup76g/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="183554351"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 23 Oct 2025 20:51:38 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2] rust/qemu-macros: Convert bit value to u8 within
 #[property]
Date: Fri, 24 Oct 2025 12:13:44 +0800
Message-Id: <20251024041344.1389488-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

For bit property, make the type conversion within the #[property] macro
so that users do not need to handle the conversion.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes Since v2:
 - Check #field_ty::BITS instead of u8::MAX.
 - Update test cases.
---
 rust/hw/timer/hpet/src/device.rs |  2 +-
 rust/qemu-macros/src/lib.rs      | 23 ++++++++++++++++++-----
 rust/qemu-macros/src/tests.rs    | 15 ++++++++++++---
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 86638c076666..23f2eefd1cd9 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -539,7 +539,7 @@ pub struct HPETState {
     // Internal state
     /// Capabilities that QEMU HPET supports.
     /// bit 0: MSI (or FSB) support.
-    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
+    #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT, default = false)]
     flags: u32,
 
     /// Offset of main counter relative to qemu clock.
diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 50239f228be2..ee417bb4b4ef 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -262,12 +262,25 @@ macro_rules! str_to_c_str {
             },
         )?;
         let field_ty = field.ty.clone();
-        let qdev_prop = if bitnr.is_none() {
-            quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO }
+        let (qdev_prop, bitval) = if let Some(bitval) = bitnr {
+            (
+                quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO },
+                quote! {
+                    {
+                        const {
+                            assert!(#bitval >= 0 && #bitval < #field_ty::BITS as _,
+                                    "bit number exceeds type bits range");
+                        }
+                        #bitval as u8
+                    }
+                },
+            )
         } else {
-            quote! { <#field_ty as ::hwcore::QDevProp>::BIT_INFO }
+            (
+                quote! { <#field_ty as ::hwcore::QDevProp>::BASE_INFO },
+                quote! { 0 },
+            )
         };
-        let bitnr = bitnr.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         let set_default = defval.is_some();
         let defval = defval.unwrap_or(syn::Expr::Verbatim(quote! { 0 }));
         properties_expanded.push(quote! {
@@ -275,7 +288,7 @@ macro_rules! str_to_c_str {
                 name: ::std::ffi::CStr::as_ptr(#prop_name),
                 info: #qdev_prop,
                 offset: ::core::mem::offset_of!(#name, #field_name) as isize,
-                bitnr: #bitnr,
+                bitnr: #bitval,
                 set_default: #set_default,
                 defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
                 ..::common::Zeroable::ZERO
diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index 65691412ff57..b65cf656fa36 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -179,7 +179,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                         name: ::std::ffi::CStr::as_ptr(c"flags"),
                         info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
-                        bitnr: 3,
+                        bitnr : {
+                            const { assert!(3 >= 0 && 3 < u32::BITS as _ , "bit number exceeds type bits range"); }
+                            3 as u8
+                        },
                         set_default: false,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: 0 as u64 },
                         ..::common::Zeroable::ZERO
@@ -207,7 +210,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                         name: ::std::ffi::CStr::as_ptr(c"flags"),
                         info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
-                        bitnr: 3,
+                        bitnr : {
+                            const { assert!(3 >= 0 && 3 < u32::BITS as _ , "bit number exceeds type bits range"); }
+                            3 as u8
+                        },
                         set_default: true,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
                         ..::common::Zeroable::ZERO
@@ -235,7 +241,10 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
                         name: ::std::ffi::CStr::as_ptr(c"msi"),
                         info: <u64 as ::hwcore::QDevProp>::BIT_INFO,
                         offset: ::core::mem::offset_of!(DummyState, flags) as isize,
-                        bitnr: 3,
+                        bitnr : {
+                            const { assert!(3 >= 0 && 3 < u64::BITS as _ , "bit number exceeds type bits range"); }
+                            3 as u8
+                        },
                         set_default: true,
                         defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: false as u64 },
                         ..::common::Zeroable::ZERO
-- 
2.34.1


