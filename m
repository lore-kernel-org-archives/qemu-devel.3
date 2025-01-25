Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED8CC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 12:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbfLA-0008Dq-UF; Sat, 25 Jan 2025 07:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfL0-0008BP-AM; Sat, 25 Jan 2025 07:32:35 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbfKy-0005TJ-1X; Sat, 25 Jan 2025 07:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737808352; x=1769344352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y5lOC7itXdhtdQbuxxpKxG5odZWwd5vj2vFriJDCYUw=;
 b=dSYKUEThJQldZ+OXg15zJgiNoxZbiFOAV+qqPAdrzLWPlvDE6zFT6Q2Y
 /CmUnIROxsPbcVQnN+Gd9dZMEeFe1MSTvvuUIxwaJlUqrYpsFoPqWnql5
 rpjeUD4t6mYBNyV3KlRU9XunmNVBj7RAKRmpFlvRqwa9cbAdIzwju5Qgn
 z7B1ECiYygc70KOE9qyEz7i0QnZKCh5AY6+SGf8tURowHQl0mb482PGTm
 N9ugDPpyNm9evNa1HqLRb5/T4CzRPCJvi4lkVfg964Wpy+TUdAPGmpGO3
 iqYBV2RkLXU7P0jUbE2+JdhXwlt+dd4d1lL/8vo3ne1lu2YWDQsRaUNLq A==;
X-CSE-ConnectionGUID: uAM7Wb+CRIy8nj7C4kk+fQ==
X-CSE-MsgGUID: gjEYxZQVSsiaQ6j0q3eWmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38434702"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="38434702"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2025 04:32:30 -0800
X-CSE-ConnectionGUID: oBuYJ4s6SJKukxDGJdDOuQ==
X-CSE-MsgGUID: KqpmlBRwSWOvjDiIhqv8MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; d="scan'208";a="107897654"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 25 Jan 2025 04:32:27 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 02/10] rust/qdev: add the macro to define bit property
Date: Sat, 25 Jan 2025 20:51:29 +0800
Message-Id: <20250125125137.1223277-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250125125137.1223277-1-zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

HPET device (Rust device) needs to define the bit type property.

Add a variant of define_property macro to define bit type property.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/src/qdev.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index b348f2f4ce71..32740c873604 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -166,6 +166,18 @@ fn class_init(dc: &mut DeviceClass) {
 
 #[macro_export]
 macro_rules! define_property {
+    ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, bit = $bitnr:expr, default = $defval:expr$(,)*) => {
+        $crate::bindings::Property {
+            // use associated function syntax for type checking
+            name: ::std::ffi::CStr::as_ptr($name),
+            info: $prop,
+            offset: $crate::offset_of!($state, $field) as isize,
+            bitnr: $bitnr,
+            set_default: true,
+            defval: $crate::bindings::Property__bindgen_ty_1 { u: $defval as u64 },
+            ..$crate::zeroable::Zeroable::ZERO
+        }
+    };
     ($name:expr, $state:ty, $field:ident, $prop:expr, $type:ty, default = $defval:expr$(,)*) => {
         $crate::bindings::Property {
             // use associated function syntax for type checking
-- 
2.34.1


