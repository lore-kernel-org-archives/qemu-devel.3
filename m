Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1928AC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 12:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujzRs-0001Ye-FS; Thu, 07 Aug 2025 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRM-0008QS-4d; Thu, 07 Aug 2025 08:09:48 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ujzRJ-00059l-Ft; Thu, 07 Aug 2025 08:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754568585; x=1786104585;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iavmaBU2SAHqBwyyDCas48yylc85Ev7Gp1UBZohijB8=;
 b=ZzFW7kwxkX2IrEYPo5lR+YYApuCtNyD8mjKXF8zdP4x8IJPD6ic5va/E
 MpiY8YnXTvKKrz/UsJivTMGr953lQj2IMy1BWiExKiZfYKus4T/5LvUYA
 03lwqr3P6h3/hlOL5cYw21eTUD+/t8HnfAZpQtKMaqJVM1X93Bzw7Luk4
 zub9MxFa+yzojUdG01vDxMvhZIpMBnXbCDe72kdjPK7cTZKaaXXWDI5bn
 s03vdkArLww9Azqz7Z5dpMLf6r7u/SSmc812AdPPwnldDUxFf0H4SLZxb
 0vmCf1tpAdfAlubfEJm/riZ0zC5jSY3qG+32yqsZjdnvVWmPxsNYiHvbo w==;
X-CSE-ConnectionGUID: oOWLFifkSlKNHP+cCfx41Q==
X-CSE-MsgGUID: VbmcbZiGS4qPUvXx8iSzpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="57036805"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="57036805"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:09:44 -0700
X-CSE-ConnectionGUID: VS83TYczTT2gR/VOhmLfQg==
X-CSE-MsgGUID: qC0+2r7dStWdMJwsds8MUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="164701132"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 Aug 2025 05:09:42 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 13/26] rust: Add RCU bindings
Date: Thu,  7 Aug 2025 20:30:14 +0800
Message-Id: <20250807123027.2910950-14-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123027.2910950-1-zhao1.liu@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add rcu_read_lock() & rcu_read_unlock() bindings, then they can be used
in memory access.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/qemu-api/meson.build |  1 +
 rust/qemu-api/src/lib.rs  |  1 +
 rust/qemu-api/src/rcu.rs  | 26 ++++++++++++++++++++++++++
 rust/qemu-api/wrapper.h   |  1 +
 4 files changed, 29 insertions(+)
 create mode 100644 rust/qemu-api/src/rcu.rs

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index a362d44ed396..d40472092248 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -68,6 +68,7 @@ _qemu_api_rs = static_library(
       'src/prelude.rs',
       'src/qdev.rs',
       'src/qom.rs',
+      'src/rcu.rs',
       'src/sysbus.rs',
       'src/timer.rs',
       'src/uninit.rs',
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 86dcd8ef17a9..4705cf9ccbc5 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -26,6 +26,7 @@
 pub mod module;
 pub mod qdev;
 pub mod qom;
+pub mod rcu;
 pub mod sysbus;
 pub mod timer;
 pub mod uninit;
diff --git a/rust/qemu-api/src/rcu.rs b/rust/qemu-api/src/rcu.rs
new file mode 100644
index 000000000000..30d8b9e43967
--- /dev/null
+++ b/rust/qemu-api/src/rcu.rs
@@ -0,0 +1,26 @@
+// Copyright (C) 2025 Intel Corporation.
+// Author(s): Zhao Liu <zhao1.liu@intel.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for `rcu_read_lock` and `rcu_read_unlock`.
+//! More details about RCU in QEMU, please refer docs/devel/rcu.rst.
+
+use crate::bindings;
+
+/// Used by a reader to inform the reclaimer that the reader is
+/// entering an RCU read-side critical section.
+pub fn rcu_read_lock() {
+    // SAFETY: no return and no argument, everything is done at C side.
+    unsafe { bindings::rcu_read_lock() }
+}
+
+/// Used by a reader to inform the reclaimer that the reader is
+/// exiting an RCU read-side critical section.  Note that RCU
+/// read-side critical sections may be nested and/or overlapping.
+pub fn rcu_read_unlock() {
+    // SAFETY: no return and no argument, everything is done at C side.
+    unsafe { bindings::rcu_read_unlock() }
+}
+
+// FIXME: maybe we need rcu_read_lock_held() to check the rcu context,
+// then make it possible to add assertion at any RCU critical section.
diff --git a/rust/qemu-api/wrapper.h b/rust/qemu-api/wrapper.h
index 15a1b19847f2..ce0ac8d3f550 100644
--- a/rust/qemu-api/wrapper.h
+++ b/rust/qemu-api/wrapper.h
@@ -69,3 +69,4 @@ typedef enum memory_order {
 #include "qemu/timer.h"
 #include "system/address-spaces.h"
 #include "hw/char/pl011.h"
+#include "qemu/rcu.h"
-- 
2.34.1


