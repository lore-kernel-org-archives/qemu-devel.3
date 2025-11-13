Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996CFCCFA18
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 04:59:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJPQ1-0005ic-0l; Wed, 12 Nov 2025 23:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPS-00056e-69; Wed, 12 Nov 2025 23:58:14 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vJPPQ-0001cQ-Fq; Wed, 12 Nov 2025 23:58:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763009892; x=1794545892;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lrVjytpIrKcTyu9/1bvP/HoS+1Zqb/fXXacaaiI72xo=;
 b=aa72m3dosNmudRLZZCL8qNeuWiI1rTsf4x9uHf/dFk0pnItoc9Pdx9E8
 6GIBsZrjGCkSltAiX16+MskGn0AZVKJCe+nVOf1fx/rhl/w0RDOHYxlX7
 MdkNXUJf/BRuLkcdR1izxteHrSHxZy2WYG0tiQmHsX+GzRiFw5StpM36T
 zN1tdGvujMQtaaCmnFiou7OoJOQOzr/ry7W08kEszK3VLe1sU+2/KQPeb
 2CUqvm6R7CYkuNTKkfJDZKjop1ylVXLJlTTbgXdmppS/kXUurqrM04tK9
 x7IKOiQUvLjw9Yo/PULtujhGNocyZBS187gIJVk909Vh8qz95qRXYFeTJ Q==;
X-CSE-ConnectionGUID: uQdApcnyS52kyn/vohivyA==
X-CSE-MsgGUID: OKkw2sMbRKaePTm92tO3eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="67682129"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="67682129"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 20:57:51 -0800
X-CSE-ConnectionGUID: yv+S+AEWS7yhXC4K/DloWA==
X-CSE-MsgGUID: UX9mqu2FRciqUtRrQIVOEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="193663279"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 12 Nov 2025 20:57:49 -0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 14/22] rust/hpet: Borrow HPETState.regs once in
 HPETState::post_load()
Date: Thu, 13 Nov 2025 13:19:29 +0800
Message-Id: <20251113051937.4017675-15-zhao1.liu@intel.com>
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

Timers in post_load() access the same HPETState, which is the "self"
HPETState.

So there's no need to access HPETState from child HPETTimer again and
again. Instead, just cache and borrow HPETState.regs at the beginning,
and this could save some CPU cycles and reduce borrow() calls.

It's safe, because post_load() is called with BQL protection, so that
there's no other chance to modify the regs.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/device.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 738ebb374fc9..bd673a1d0110 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -885,9 +885,11 @@ fn pre_save(&self) -> Result<(), migration::Infallible> {
     }
 
     fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
+        let regs = self.regs.borrow();
+
         for timer in self.timers.iter().take(self.num_timers) {
             let mut t = timer.borrow_mut();
-            let cnt = t.get_state().regs.borrow().counter;
+            let cnt = regs.counter;
 
             t.cmp64 = t.calculate_cmp64(cnt, t.regs.cmp);
             t.last = CLOCK_VIRTUAL.get_ns() - NANOSECONDS_PER_SECOND;
@@ -896,7 +898,7 @@ fn post_load(&self, _version_id: u8) -> Result<(), migration::Infallible> {
         // Recalculate the offset between the main counter and guest time
         if !self.hpet_offset_saved {
             self.hpet_offset
-                .set(ticks_to_ns(self.regs.borrow().counter) - CLOCK_VIRTUAL.get_ns());
+                .set(ticks_to_ns(regs.counter) - CLOCK_VIRTUAL.get_ns());
         }
 
         Ok(())
-- 
2.34.1


