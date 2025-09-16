Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49B8CAC59A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 08:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyR9D-0006wi-66; Tue, 16 Sep 2025 04:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR97-0006gp-Lk; Tue, 16 Sep 2025 04:34:41 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uyR91-0005zs-Vh; Tue, 16 Sep 2025 04:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758011676; x=1789547676;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p9Y4FxxNCJO8k3rMn0WRG6+uJf08DdF+53l2IzwHTQo=;
 b=M8u8OdvVA+nJvyRsD79iFeNE1S5B8JtHMA3iWuykN7NPdM9XyU5fP9tN
 6fi68lJq4/0pVZ0eILfzmsfgfbXoqc1BltQVw/NAQmQ2DWsjFtp8EO9iO
 oyAHZJFy1Fn87kTM5jF+DAHlFYfGOuYUA8kngJfD7u0qJeP51mXIhrxDR
 5V+Or0RuadBNJufPf6wIgWUrRd8y3ZvhZOyfe07sF254mkRAveBkkc8i5
 sFhlK+tfF2rrM6m7K2g2jMTv2Qy7jOuC4RSK0nFM125KUonj8sgKxCN3F
 WDD8PNHHCD4k/A5fKIpWsGw4Nu/haPQOpymmWqaPbBNGYbzqb/gdeo3FJ w==;
X-CSE-ConnectionGUID: tuKjyQamSTe1HoaQo5EYZA==
X-CSE-MsgGUID: bqyu53swR2a2NnygreaKEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="77725189"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="77725189"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2025 01:34:24 -0700
X-CSE-ConnectionGUID: +C3BFFERSXmXLsW/u29JpQ==
X-CSE-MsgGUID: R0kZ0Lb5QayhxG8CHs1r9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; d="scan'208";a="174691098"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 16 Sep 2025 01:34:22 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/12] rust/qdev: Support property info for more common types
Date: Tue, 16 Sep 2025 16:55:53 +0800
Message-Id: <20250916085557.2008344-9-zhao1.liu@intel.com>
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

Add a helper macro to implement QDevProp trait for u8/u16/u32/usize/i32
/i64.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index d887046d8de1..b57dc05ebb0e 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -134,20 +134,24 @@ pub unsafe trait QDevProp {
     const BASE_INFO: *const bindings::PropertyInfo;
 }
 
-/// Use [`bindings::qdev_prop_bool`] for `bool`.
-unsafe impl QDevProp for bool {
-    const BASE_INFO: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
-}
-
-/// Use [`bindings::qdev_prop_uint64`] for `u64`.
-unsafe impl QDevProp for u64 {
-    const BASE_INFO: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
+macro_rules! impl_qdev_prop {
+    ($type:ty,$info:ident) => {
+        unsafe impl $crate::qdev::QDevProp for $type {
+            const BASE_INFO: *const $crate::bindings::PropertyInfo =
+                addr_of!($crate::bindings::$info);
+        }
+    };
 }
 
-/// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
-unsafe impl QDevProp for chardev::CharBackend {
-    const BASE_INFO: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
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


