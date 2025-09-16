Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A039ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9f-0007am-2E; Tue, 16 Sep 2025 04:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR9a-0007Vr-1B; Tue, 16 Sep 2025 04:35:10 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR9X-0005zx-3H; Tue, 16 Sep 2025 04:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011707; x=1789547707;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c6s+RAJPZBzQdmFf2QbKGsWT+vtbTiMBphMI82r/Poo=;
 b=fSyiAxh+1HeCOFUUQzUhS3o/NrzvBRDNIy+/l3o0LqvTnPJevQhZvoHU
 5uq4MpDRVCp9KA8dtfdeermXX5jdGKYeDGpK9FyrHYiKTeFe1PqlU0F3O
 Xy4mSU8G141PBv06LtVhHtHr/jXt/oq0TUuOfGErbpuOP7FoESDLfci0S
 uws9/M/SrvQ5rjoxAFRgYTZ6FNW1xEFgxnXMsgJnmNdxBNyrMOs7Mhw21
 qer0Foby6z35o6tU26bRlhwywn9cPtva/PmpXjBkL2J8UXv4xtYpiTLrY
 l3RzcDMeP75pA0NNw7qjYeIxRE7dQ3tz0UJsaaMOaezXMIy9aTGKmacTF A==;
X-CSE-ConnectionGUID: 4jhdDqcPRwK5ziG4Ud2OPQ==
X-CSE-MsgGUID: A51sp1EJRvygqyIhoe8odQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725213"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725213"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:31 -0700
X-CSE-ConnectionGUID: e+BY3QJgSc2a7+KOLQooXQ==
X-CSE-MsgGUID: r45eLBvYSsmV7JRch/QF8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691141"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:29 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 12/12] rust/qdev: Drop declare_properties & define_property
 macros
Date: Tue, 16 Sep 2025 16:55:57 +0800
Message-Id: <20250916085557.2008344-13-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916085557.2008344-1-zhao1.liu@intel.com>
References: <20250916085557.2008344-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

After HPET's #property conversion, there's no use case for
declare_properties & define_property. So get rid of them for now.

In future, if there's something that #property really cannot resolve,
they can be brought back.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 53 ----------------------------------------
 1 file changed, 53 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index a8cd9e3c2fd5..a32ada4c175e 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -248,59 +248,6 @@ pub fn class_init<T: DeviceImpl>(&mut self) {
     }
 }
 
-#[macro_export]
-macro_rules! define_property {
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, bit = $bitnr:expr, default = $defval:expr$(,)*) => {
-        $crate::bindings::Property {
-            // use associated function syntax for type checking
-            name: ::std::ffi::CStr::as_ptr($name),
-            info: $prop,
-            offset: ::std::mem::offset_of!($state, $field) as isize,
-            bitnr: $bitnr,
-            set_default: true,
-            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
-        $crate::bindings::Property {
-            // use associated function syntax for type checking
-            name: ::std::ffi::CStr::as_ptr($name),
-            info: $prop,
-            offset: ::std::mem::offset_of!($state, $field) as isize,
-            set_default: true,
-            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty$(,)*) => {
-        $crate::bindings::Property {
-            // use associated function syntax for type checking
-            name: ::std::ffi::CStr::as_ptr($name),
-            info: $prop,
-            offset: ::std::mem::offset_of!($state, $field) as isize,
-            set_default: false,
-            ..::common::zeroable::Zeroable::ZERO
-        }
-    };
-}
-
-#[macro_export]
-macro_rules! declare_properties {
-    ($ident:ident, $($prop:expr),*$(,)*) => {
-        pub static $ident: [$crate::bindings::Property; {
-            let mut len = 0;
-            $({
-                _ = stringify!($prop);
-                len += 1;
-            })*
-            len
-        }] = [
-            $($prop),*,
-        ];
-    };
-}
-
 unsafe impl ObjectType for DeviceState {
     type Class = DeviceClass;
     const TYPE_NAME: &'static CStr =
-- 
2.34.1


