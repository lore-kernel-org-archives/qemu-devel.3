Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A139CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 07:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Z5Y-000143-RS; Tue, 14 Oct 2025 03:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Z5X-00013p-AI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:04:51 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8Z5U-0001Ri-7o
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 03:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760425489; x=1791961489;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=aEoV2nwVq/Zd9n2KK099QaT/uplOERgtEr8hEZnRzJY=;
 b=EmxymkItmZ9Ut8il1OUhQgjqDpYKGlRAQRmlhQ16y25cGpK+fM9E43jj
 QBINpjpk1+T4DWKlyR0WpE+A743AfSEZPGex3YF4h7MHQhhQWRY7aLviB
 HbmXqRA4iLnOsn+Eirk5z2MbNy17Ixrh/fgHHD89dBe69kCtCToUoyJlw
 vXJeOcSj13ArVf1KUKmwP4A256VZd4xZ+d5nFTdSwr24IP4hNsUcyPpmy
 3IPrFip888l1l7+ysm+0aW1UhmGWwoQh4R3AnffVNgoEL+lx5yN3MUnIT
 A29iMUphKxg9032Oo4jnr0k1d63Qba6XW+JWU+83rzMKBvJjJyYyH26mf w==;
X-CSE-ConnectionGUID: +VwvXE5STZ6Fu2SsezIr6Q==
X-CSE-MsgGUID: MmLR2UNwQhuFXxHmZYTaxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="72846968"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="72846968"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 00:04:44 -0700
X-CSE-ConnectionGUID: 0y3fDW2LT8OyJcdThmIUxA==
X-CSE-MsgGUID: F4foXZG2R02rlsTO+XOGUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="182581479"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 14 Oct 2025 00:04:42 -0700
Date: Tue, 14 Oct 2025 15:26:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 1/2] rust/timer: Make Timer::modify() accept an i64
 expire_time Timer
Message-ID: <aO37N2wfO+afES7d@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-10-pbonzini@redhat.com>
 <aO3z7zbztw3TaxY+@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO3z7zbztw3TaxY+@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

At C side, timer_mod() accepts the int64_t expire_time as an argument.

In fact, int64_t defines the positive value range accepted by
expire_timer is (0, INT64_MAX].

But at Rust side, Timer::modify() accepts an u64 expire_time and convert
it to i64 internally. This is a lazy approach, assuming no one would use
negative values to modify the timer. However, logically speaking, a
negative expire_time is acceptable - it means that the current timer
should fire immediately.

Moreover, specifying expire_time as i64 allows callers to more clearly
understand the accepted value range, preventing them from unexpectedly
finding a `u64` (> `i64::MAX`) silently converted to a negative value.

Make Timer::modify() accept an i64 expire_time.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 2 +-
 rust/util/src/timer.rs           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 86638c076666..f0ac01758e72 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -365,7 +365,7 @@ fn arm_timer(&mut self, tick: u64) {
         }

         self.last = ns;
-        self.qemu_timer.modify(self.last);
+        self.qemu_timer.modify(self.last.try_into().unwrap());
     }

     fn set_timer(&mut self) {
diff --git a/rust/util/src/timer.rs b/rust/util/src/timer.rs
index c6b3e4088ecb..c3a9de6b72df 100644
--- a/rust/util/src/timer.rs
+++ b/rust/util/src/timer.rs
@@ -86,10 +86,10 @@ pub fn init_full<'timer, 'opaque: 'timer, T, F>(
         }
     }

-    pub fn modify(&self, expire_time: u64) {
+    pub fn modify(&self, expire_time: i64) {
         // SAFETY: the only way to obtain a Timer safely is via methods that
         // take a Pin<&mut Self>, therefore the timer is pinned
-        unsafe { timer_mod(self.as_mut_ptr(), expire_time as i64) }
+        unsafe { timer_mod(self.as_mut_ptr(), expire_time) }
     }

     pub fn delete(&self) {
--
2.34.1


