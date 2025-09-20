Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF54ECAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkt-00082s-Sc; Sat, 20 Sep 2025 11:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkl-0007ye-20; Sat, 20 Sep 2025 11:43:59 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkj-0001zT-BS; Sat, 20 Sep 2025 11:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383038; x=1789919038;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7K1AoX1vYKJi0eA0/Ol1SLh0EzyubRlT44C6WqHZJJI=;
 b=io4toLzMtAibBPZxMyoX9NVk+qNqlSkBYtkbZBZY0tSOltNvGFb/tL9v
 rm1vaeHfB1D3+oso7Lq1k4C7M7DXoFvFzZHoQNiiNyAiCda5cS4FpXQVy
 EidyIKrkhUWdeyFXZTAY5pcGtFYMuJ2KGRohcATxhjMi2Kgv9HO4//PKl
 hSLzy8QzX0TRZmwYwm6ZLvtR6yFvTZTGOK7ESdjFqBCpiX5wAn/cVjYw3
 X1FYHXLikVN6sXATg+lYqETdjf00zbvuzj33NCXYUcue+uWc5XeRat+1t
 p0nNVJe/ByK23f442DFbJvRUwOIboVo11hriG817EiSpwbBPTg8kzVceh g==;
X-CSE-ConnectionGUID: 8Bnhm0sbTHGb/hfMzIM5hg==
X-CSE-MsgGUID: Vfa7384yRm2qsImKSNnm0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955558"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955558"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:54 -0700
X-CSE-ConnectionGUID: mEvzBRn+RDCRYbPHf3wBNA==
X-CSE-MsgGUID: 7QuzDe2uSne9WR8nvwfbkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349478"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:52 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 09/12] rust/qdev: Test bit property for #property
Date: Sun, 21 Sep 2025 00:05:17 +0800
Message-Id: <20250920160520.3699591-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920160520.3699591-1-zhao1.liu@intel.com>
References: <20250920160520.3699591-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

There's a diference between Rust and C:

Though C macro (e.g., DEFINE_PROP_BIT or DEFINE_PROP_BIT64) always
requires default value, Rust side allows to omit this "default" field
in #property, and provides a default value ("0" - false) for this
field.

This minor difference does not break user habits and should be
acceptable. Therefore, the test cases also cover this scenario.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-macros/src/tests.rs | 99 +++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/rust/qemu-macros/src/tests.rs b/rust/qemu-macros/src/tests.rs
index c6b00c9783a8..7516bc3d92a0 100644
--- a/rust/qemu-macros/src/tests.rs
+++ b/rust/qemu-macros/src/tests.rs
@@ -89,6 +89,19 @@ struct DummyState {
         "Duplicate argument",
         "Already used here",
     );
+    derive_compile_fail!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            struct DummyState {
+                #[property(bit = 0, bit = 1)]
+                flags: u32,
+            }
+        },
+        "Duplicate argument",
+        "Already used here",
+    );
     // Check that the field name is preserved when `rename` isn't used:
     derive_compile!(
         derive_device_or_error,
@@ -145,6 +158,92 @@ unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
             }
         }
     );
+    // Check that `bit` value is used for the bit property without default
+    // value (note: though C macro (e.g., DEFINE_PROP_BIT) always requires
+    // default value, Rust side allows to default this field to "0"):
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(bit = 3)]
+                flags: u32,
+            }
+        },
+        quote! {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"flags"),
+                        info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
+                        offset: ::core::mem::offset_of!(DummyState, flags) as isize,
+                        bitnr: 3,
+                        set_default: false,
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: 0 as u64 },
+                        ..::common::Zeroable::ZERO
+                    }
+                ];
+            }
+        }
+    );
+    // Check that `bit` value is used for the bit property when used:
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(bit = 3, default = true)]
+                flags: u32,
+            }
+        },
+        quote! {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"flags"),
+                        info: <u32 as ::hwcore::QDevProp>::BIT_INFO,
+                        offset: ::core::mem::offset_of!(DummyState, flags) as isize,
+                        bitnr: 3,
+                        set_default: true,
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: true as u64 },
+                        ..::common::Zeroable::ZERO
+                    }
+                ];
+            }
+        }
+    );
+    // Check that `bit` value is used for the bit property with rename when used:
+    derive_compile!(
+        derive_device_or_error,
+        quote! {
+            #[repr(C)]
+            #[derive(Device)]
+            pub struct DummyState {
+                parent: ParentField<DeviceState>,
+                #[property(rename = "msi", bit = 3, default = false)]
+                flags: u64,
+            }
+        },
+        quote! {
+            unsafe impl ::hwcore::DevicePropertiesImpl for DummyState {
+                const PROPERTIES: &'static [::hwcore::bindings::Property] = &[
+                    ::hwcore::bindings::Property {
+                        name: ::std::ffi::CStr::as_ptr(c"msi"),
+                        info: <u64 as ::hwcore::QDevProp>::BIT_INFO,
+                        offset: ::core::mem::offset_of!(DummyState, flags) as isize,
+                        bitnr: 3,
+                        set_default: true,
+                        defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: false as u64 },
+                        ..::common::Zeroable::ZERO
+                    }
+                ];
+            }
+        }
+    );
 }
 
 #[test]
-- 
2.34.1


