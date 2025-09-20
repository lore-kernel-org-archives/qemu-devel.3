Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E328CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkm-0007zg-Gv; Sat, 20 Sep 2025 11:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzki-0007wo-JF; Sat, 20 Sep 2025 11:43:56 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkf-0001zT-Lx; Sat, 20 Sep 2025 11:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383034; x=1789919034;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yXrP73a12JJn4IAYq71AmqAT+gHNTzZ0Y1rswE00zAo=;
 b=bBRblinQuMaIBPtXkCisnX/7+UGYUe4C+f3bzkSGCF9aOIbVwc7glc17
 Mj5Fpka5FU+whR4bJVK/cL+aAm9PZHTwC1ZN7ilW2wivZUTxtzHwLrE/g
 KTAzEAPIyNi84I1YQbXbEGUW3FwGF6hqhqlF/jPk1WERaiXDvX5ocPln3
 DFx44FhJ6S2LjG+SN69sxnZZ5oxW5P8s6TCMItmtQx7qj7dHpQpcfTkmr
 SFCQXqhlgRykB+Ge83V8TKKzNYTRQVAGO+KyThwZTlhfRkhBIAYBUG746
 xqEZazytGNWolfXatcCZn0IzsXHc4LCWdHuRhNoRHT46AspMKLY6iEttY g==;
X-CSE-ConnectionGUID: mAQdu+OmSh+rD+g2efUbng==
X-CSE-MsgGUID: FpCJ3QjcQo2Q+QExBzGMpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955541"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955541"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:50 -0700
X-CSE-ConnectionGUID: jkWtAfONRP2NTTHTpKjTQw==
X-CSE-MsgGUID: slE/YtbiQCmIYmNVttLrmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349467"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:48 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 07/12] rust/qdev: Support property info for more common
 types
Date: Sun, 21 Sep 2025 00:05:15 +0800
Message-Id: <20250920160520.3699591-8-zhao1.liu@intel.com>
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

Add a helper macro to implement QDevProp trait for u8/u16/u32/usize/i32
/i64.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 89c21e7c6b50..14d6ecf2ca23 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -134,20 +134,24 @@ pub unsafe trait QDevProp {
     const VALUE: *const bindings::PropertyInfo;
 }
 
-/// Use [`bindings::qdev_prop_bool`] for `bool`.
-unsafe impl QDevProp for bool {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
-}
-
-/// Use [`bindings::qdev_prop_uint64`] for `u64`.
-unsafe impl QDevProp for u64 {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
+macro_rules! impl_qdev_prop {
+    ($type:ty,$info:ident) => {
+        unsafe impl $crate::qdev::QDevProp for $type {
+            const VALUE: *const $crate::bindings::PropertyInfo =
+                addr_of!($crate::bindings::$info);
+        }
+    };
 }
 
-/// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
-unsafe impl QDevProp for chardev::CharBackend {
-    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
-}
+impl_qdev_prop!(bool, qdev_prop_bool);
+impl_qdev_prop!(u8, qdev_prop_uint8);
+impl_qdev_prop!(u16, qdev_prop_uint16);
+impl_qdev_prop!(u32, qdev_prop_uint32);
+impl_qdev_prop!(u64, qdev_prop_uint64);
+impl_qdev_prop!(usize, qdev_prop_usize);
+impl_qdev_prop!(i32, qdev_prop_int32);
+impl_qdev_prop!(i64, qdev_prop_int64);
+impl_qdev_prop!(chardev::CharBackend, qdev_prop_chr);
 
 /// Trait to define device properties.
 ///
-- 
2.34.1


