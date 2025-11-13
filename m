Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57BDCCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 05:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPPC-0004tN-7L; Wed, 12 Nov 2025 23:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOx-0004lQ-I2; Wed, 12 Nov 2025 23:57:45 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPOs-0001cD-Kk; Wed, 12 Nov 2025 23:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009859; x=1794545859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9GE+hk+1IXfDmzkd0C2JXTi850FRaaGqtgpTyN8LixA=;
 b=KqmMx80ypLkQ+pPgvN0EtNv6b+eiZv/AWdZYn/6r/dK7HqULpbeJQzPq
 jCNSYM1mSi80zK9zPEQY30XFy3Io/RgetFhjWMB2EaWnRgqF2JKf+Q8qv
 IN52lvDgNM2qO9lp+15d3DcczVwbLXeCCajPFv4s/1J2zKunr4F2WuyTq
 Jh7FV8emnmCQLQouYnzJZaIiqWjOWEwl8OryxC6eH8eCbrh22JS8/m1LW
 Z1uJ8QrPUVabYLkOM2dXq6I2YkaSKOVWC5ZY6kXmncVdYR/qN/tpETrBJ
 p0J7vr0Py5/nONVjYTcKOMFeULmTEYbM4pZo9XY5j1al1KpO9ZnNQpUQ+ g==;
X-CSE-ConnectionGUID: 5KMOHGDrRveUO0WnLzPhGw==
X-CSE-MsgGUID: k6P4mUumTYKjx6s5n+ONnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682084"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:36 -0800
X-CSE-ConnectionGUID: fWcBP6ETR1eIk8oxB+g2VA==
X-CSE-MsgGUID: Y2r+tZemR0WjRr3M8E4dww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663245"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:34 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 07/22] rust/hpet: Reduce unnecessary mutable self argument
Date: Thu, 13 Nov 2025 13:19:22 +0800
Message-Id: <20251113051937.4017675-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113051937.4017675-1-zhao1.liu@intel.com>
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

Methods of Timer and InterruptSource have been made as safe, so make the
related methods of HPETTimer to accept immutable self reference.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3564aa79c6e5..5e08b91494cf 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -324,7 +324,7 @@ fn get_int_route(&self) -> usize {
         }
     }
 
-    fn set_irq(&mut self, set: bool) {
+    fn set_irq(&self, set: bool) {
         let route = self.get_int_route();
 
         if set && self.is_int_enabled() && self.get_state().is_hpet_enabled() {
@@ -350,7 +350,7 @@ fn set_irq(&mut self, set: bool) {
         }
     }
 
-    fn update_irq(&mut self, set: bool) {
+    fn update_irq(&self, set: bool) {
         // If Timer N Interrupt Enable bit is 0, "the timer will
         // still operate and generate appropriate status bits, but
         // will not cause an interrupt"
@@ -388,7 +388,7 @@ fn set_timer(&mut self) {
         self.arm_timer(self.cmp64);
     }
 
-    fn del_timer(&mut self) {
+    fn del_timer(&self) {
         // Just remove the timer from the timer_list without destroying
         // this timer instance.
         self.qemu_timer.delete();
@@ -657,7 +657,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             self.counter.set(self.get_ticks());
 
             for timer in self.timers.iter().take(self.num_timers) {
-                timer.borrow_mut().del_timer();
+                timer.borrow().del_timer();
             }
         }
 
@@ -681,7 +681,7 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
 
         for (index, timer) in self.timers.iter().take(self.num_timers).enumerate() {
             if cleared & (1 << index) != 0 {
-                timer.borrow_mut().update_irq(false);
+                timer.borrow().update_irq(false);
             }
         }
     }
-- 
2.34.1


