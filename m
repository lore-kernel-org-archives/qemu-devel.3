Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3210ECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Z74-0001bv-AF; Tue, 14 Oct 2025 03:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Z71-0001VH-Nr
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:06:23 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Z6z-0001iL-Pq
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760425581; x=1791961581;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8BhEbCt70rrUrXwfNPSuJBz1lOrViR2HxvGzcNUyCWw=;
 b=Fpx/Ev0SOtc/HdRoAAQdTajCiMWNI+WdRwY2eiS/OEGbZrPkTib6RewO
 IyFljQIAa9gPYPiYQs6qnrXvU1DwZBq+d+VR8MqrDZZdm/FI23S0VCnWu
 atLQPmyXX4ub+1NJG+TkuYq4hJvSmEtdZ8EeLT8PW0TvX7/Qn5/66HoDf
 f+swhPM0ZoUEUJiFDl9mdBMHQ6jPPeDJhcs8I7phkIqUbZfUNO8IwovZO
 MBR1jskR/Pabh9qPe/hsLlUylbZSPz7lkxLdOh4OrXDuQ6HexN5YL8Pei
 qgFpex8kuKHNwJMH13lAV5cE9gjmrFCGYgw/LH4usNSjtOfiXaXt3Rz9/ Q==;
X-CSE-ConnectionGUID: pS8AxZonRES58YwezFdx2g==
X-CSE-MsgGUID: CTx10GuMRK+bEIK+P6VtUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73256546"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="73256546"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 00:06:19 -0700
X-CSE-ConnectionGUID: mk20ZWw3To2kvoLIb9uOWw==
X-CSE-MsgGUID: UKT1qZGuTn+bFQtaQeCMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181762249"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 00:06:18 -0700
Date: Tue, 14 Oct 2025 15:28:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 2/2] rust/timer: Add Timer::modify_ns()
Message-ID: <aO37mEDYQaC3x29Y@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-10-pbonzini@redhat.com>
 <aO3z7zbztw3TaxY+@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO3z7zbztw3TaxY+@intel.com>
Received-SPF: pass client-ip=192.198.163.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add the binding of timer_mod_ns(), and re-implement Timer::modify()
based on Timer::modify_ns().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/util/src/timer.rs | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index c3a9de6b72df..88f120c54185 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -10,7 +10,7 @@
 use common::{callbacks::FnCall, Opaque};

 use crate::bindings::{
-    self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod, QEMUClockType,
+    self, qemu_clock_get_ns, timer_del, timer_init_full, timer_mod_ns, QEMUClockType,
 };

 /// A safe wrapper around [`bindings::QEMUTimer`].
@@ -86,10 +86,18 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
         }
     }

-    pub fn modify(&self, expire_time: i64) {
+    pub fn modify_ns(&self, expire_time: i64) {
         // SAFETY: the only way to obtain a Timer safely is via methods that
         // take a Pin<&mut Self>, therefore the timer is pinned
-        unsafe { timer_mod(self.as_mut_ptr(), expire_time) }
+        unsafe { timer_mod_ns(self.as_mut_ptr(), expire_time) }
+    }
+
+    pub fn modify(&self, expire_time: i64) {
+        // SAFETY: the only way to obtain a Timer safely is via methods that
+        // take a Pin<&mut Self>, therefore the timer is pinned and is valid
+        let scale = unsafe { *self.as_ptr() }.scale as i64;
+        // Following C's behavior, scale expire_time even when it is negative.
+        self.modify_ns(expire_time * scale);
     }

     pub fn delete(&self) {
--
2.34.1



