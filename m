Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A74D3749A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RJ3-0001LW-8Z; Thu, 17 Oct 2024 10:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1RJ0-0001Kw-Pg
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:16:47 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1RIv-0002JY-QH
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729174602; x=1760710602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/yQo6+7bsP8eC1dyMzAtkIfv6PJcEMqZ4e/WQ4T07fw=;
 b=ErO7qKK+yY65A+JqILC4v/1eKASvGhCd0H/uvC0L+xw29tLNEs2qEwHN
 w5bmaXnK2dxVpknAN+cRLzgQOTbgiX2R++L+Mvw4RNkgf6qxpya++rwbi
 xGlA/+JqRlJFTUtxBN1qA60sDq7uGiNgkYxdxBlXqUSz7go84m1p5KirQ
 8UmPq4K5ArHp2G3GBurwQ26SfLpM5khFFCiYoIxPxJdFEX3bAr6oBeADB
 +YfhIoYwmcCR8rx0ZASjTxZ8bIGC+qaY64dsuJF8hHjHuj/XXYSHrgG9i
 SA2W1953YQmjg89kDeaKEIGObwneQF+vTcQSMb1z57aXG0/8zLtDPYa87 w==;
X-CSE-ConnectionGUID: X/oeM8AeTeSOoXlAjBZdHA==
X-CSE-MsgGUID: Eqyt9oW6RJyj1D35WaxGCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="39299399"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="39299399"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 07:16:40 -0700
X-CSE-ConnectionGUID: oTyaXtXdQ7aKfOI3FZp8fA==
X-CSE-MsgGUID: 3NmUE+CXTlWSc//DU259KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; d="scan'208";a="78900057"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 17 Oct 2024 07:16:38 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Junjie Mao <junjie.mao@hotmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 2/2] rust/qemu-api: Bind PropertyInfo to type
Date: Thu, 17 Oct 2024 22:32:45 +0800
Message-Id: <20241017143245.1248589-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017143245.1248589-1-zhao1.liu@intel.com>
References: <20241017143245.1248589-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

For traditional property definitions implemented in C, since the C
language cannot bind variable types to specific methods or variables,
user must specify the concrete PropertyInfo and variable type in the
DEFINE_PROP macro and its variants. Then the property macro effectively
associate PropertyInfo with variable type through clever check.

However, in Rust, this process can be more elegant. By introducing the
PropertyType trait, QAPI (in Rust) can associate PropertyInfo with
specific types, allowing Rust to infer the predefined PropertyInfo from
the variable type.

This avoids user errors in passing incorrect PropertyInfo and simplifies
property definitions. And based on this enhancement, the property
definition macro can eliminate the need for the type and prop parameters.

Co-developed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/char/pl011/src/device_class.rs |  4 ---
 rust/qemu-api/src/device_class.rs      | 48 +++++++++++++++++++++++---
 rust/qemu-api/src/tests.rs             |  4 ---
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index b7ab31af02d7..295e970e8564 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -21,15 +21,11 @@
         c"chardev",
         PL011State,
         char_backend,
-        unsafe { &qdev_prop_chr },
-        CharBackend
     ),
     qemu_api::define_property!(
         c"migrate-clk",
         PL011State,
         migrate_clock,
-        unsafe { &qdev_prop_bool },
-        bool
     ),
 }
 
diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index be363fd63223..0b9d6ca705d3 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -4,7 +4,7 @@
 
 use std::sync::OnceLock;
 
-use crate::bindings::Property;
+use crate::bindings::{CharBackend, Property, PropertyInfo, qdev_prop_chr, qdev_prop_bool};
 
 #[macro_export]
 macro_rules! device_class_init {
@@ -24,16 +24,54 @@ macro_rules! device_class_init {
     };
 }
 
+pub trait PropertyType {
+    fn get_prop_info() -> *const PropertyInfo;
+}
+
+pub trait PropertyTypeImpl<T: PropertyType> {
+    fn get_prop_info(_: *const T) -> *const PropertyInfo;
+}
+
+impl<T: PropertyType> PropertyTypeImpl<T> for () {
+    fn get_prop_info(_: *const T) -> *const PropertyInfo {
+        T::get_prop_info()
+    }
+}
+
+impl PropertyType for CharBackend {
+    fn get_prop_info() -> *const PropertyInfo {
+        // SAFETY: Access to a defined c-structure, no other operation is performed.
+        unsafe { std::ptr::addr_of!(qdev_prop_chr) }
+    }
+}
+
+impl PropertyType for bool {
+    fn get_prop_info() -> *const PropertyInfo {
+        // SAFETY: Access to a defined c-structure, no other operation is performed.
+        unsafe { std::ptr::addr_of!(qdev_prop_bool) }
+    }
+}
+
+#[macro_export]
+macro_rules! get_prop_info {
+    ($state:ty, $field:ident) => {{
+    use $crate::device_class::PropertyTypeImpl;
+    let base = std::mem::MaybeUninit::<$state>::uninit().as_ptr();
+    <()>::get_prop_info(unsafe { std::ptr::addr_of!((*base).$field) })
+    }};
+}
+
+
 #[macro_export]
 macro_rules! define_property {
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
+    ($name:expr, $state:ty, $field:ident, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             name: {
                 #[used]
                 static _TEMP: &::core::ffi::CStr = $name;
                 _TEMP.as_ptr()
             },
-            info: $prop,
+            info: $crate::get_prop_info!($state, $field),
             offset: ::core::mem::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
@@ -47,14 +85,14 @@ macro_rules! define_property {
             link_type: ::core::ptr::null(),
         }
     };
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) => {
+    ($name:expr, $state:ty, $field:ident$(,)*) => {
         $crate::bindings::Property {
             name: {
                 #[used]
                 static _TEMP: &::core::ffi::CStr = $name;
                 _TEMP.as_ptr()
             },
-            info: $prop,
+            info: $crate::get_prop_info!($state, $field),
             offset: ::core::mem::offset_of!($state, $field)
                 .try_into()
                 .expect("Could not fit offset value to type"),
diff --git a/rust/qemu-api/src/tests.rs b/rust/qemu-api/src/tests.rs
index df54edbd4e27..d2b7451ef707 100644
--- a/rust/qemu-api/src/tests.rs
+++ b/rust/qemu-api/src/tests.rs
@@ -27,15 +27,11 @@ pub struct DummyState {
                 c"chardev",
                 DummyState,
                 char_backend,
-                unsafe { &qdev_prop_chr },
-                CharBackend
             ),
             define_property!(
                 c"migrate-clk",
                 DummyState,
                 migrate_clock,
-                unsafe { &qdev_prop_bool },
-                bool
             ),
     }
 
-- 
2.34.1


