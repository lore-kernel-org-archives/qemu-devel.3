Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB77FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 15:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzzkm-0007zF-6U; Sat, 20 Sep 2025 11:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkh-0007vd-2d; Sat, 20 Sep 2025 11:43:55 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uzzkd-0001zY-2m; Sat, 20 Sep 2025 11:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758383032; x=1789919032;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pFp62miZ41RQpRrF2bJMVDi/xIKfTioqkf1d5QID2Po=;
 b=HW7wDw8RaxMiz4bzlhxgu+uWxq61jmlz2H4HONwWMBgq6DU5BjSzJGFA
 PdU0/2g/klxfxS7mWPaxol0y87dHhFgqcMgnM0K9PTO2GHwGWP6cXuwdN
 hxfrAn2p9L92aUlncvQUNI9G2UY4mM1V3AafnP1Cpw/1kfPIfeUfLGIlX
 kmJk52PBuhUIfoSIgMUcZRDfzGRNQZB/W+RDUMukiUgZgkAsnwAYYrCGq
 gGIozcjl2miXyj3MCaEa3KzIyZAm/uy54fd/dUUKtKtfc2AEqqfI2s4eI
 iz/hVMJ7zu8BQR70Az9onR8PE6Bgejc/BxvBnQm9hPeZZZnQu/YgJGSVi w==;
X-CSE-ConnectionGUID: hQrvM99RRVea5vGY8CzxcA==
X-CSE-MsgGUID: 4IIb0a1JTBW0XuMaLstSaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11559"; a="70955528"
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="70955528"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2025 08:43:47 -0700
X-CSE-ConnectionGUID: eBOXPHaETA6IqvSxTIl9Rw==
X-CSE-MsgGUID: QmAk+qAqSnC0rTxNCMIh4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,281,1751266800"; d="scan'208";a="181349455"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 20 Sep 2025 08:43:46 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 05/12] rust/qdev: use addr_of! in QDevProp
Date: Sun, 21 Sep 2025 00:05:13 +0800
Message-Id: <20250920160520.3699591-6-zhao1.liu@intel.com>
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

We want a &raw pointer, so unsafe { &_ } is not needed.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/core/src/qdev.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index e384cad4d26b..d8113238e513 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -6,7 +6,7 @@
 
 use std::{
     ffi::{c_int, c_void, CStr, CString},
-    ptr::NonNull,
+    ptr::{addr_of, NonNull},
 };
 
 use chardev::Chardev;
@@ -129,17 +129,17 @@ pub unsafe trait QDevProp {
 
 /// Use [`bindings::qdev_prop_bool`] for `bool`.
 unsafe impl QDevProp for bool {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_bool };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_bool);
 }
 
 /// Use [`bindings::qdev_prop_uint64`] for `u64`.
 unsafe impl QDevProp for u64 {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_uint64 };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_uint64);
 }
 
 /// Use [`bindings::qdev_prop_chr`] for [`chardev::CharBackend`].
 unsafe impl QDevProp for chardev::CharBackend {
-    const VALUE: *const bindings::PropertyInfo = unsafe { &bindings::qdev_prop_chr };
+    const VALUE: *const bindings::PropertyInfo = addr_of!(bindings::qdev_prop_chr);
 }
 
 /// Trait to define device properties.
-- 
2.34.1


