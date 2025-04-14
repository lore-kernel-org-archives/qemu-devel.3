Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B6FC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoI-0003J2-JX; Mon, 14 Apr 2025 10:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoD-0003EF-Ed; Mon, 14 Apr 2025 10:29:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoB-00066q-LS; Mon, 14 Apr 2025 10:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640952; x=1776176952;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zxb9LLhjivKhW2dVowN5asrmv67wUZSMMGWnyVhMP5Q=;
 b=WwaGSMlFYUU5GLSWgxcjHApCEW+EnzUVHeVH6ZKzpy8DX0prwo08ymqx
 1S5qGzvW9jc6kgOWCaxuczWJMh1ocrcS4MooKZTeSz964D7/d2M1TadL7
 edvir3uf+knSME1lXNLV88D2KfvvhKxB+eoLDXNNFD6o79xt9W0bITpNo
 vHCMf57ezMs66QHbPG7axcVjZ4c5gqam16uzXFgNjO+DaWX5npuPoAYc1
 HG6oaRgKpwx4AzM2UjYBLLjeuvY29Pm23BqRsc1cwWEDG7sZFZBxdd0RG
 x80XwqA1rkwB/wJqTfwJGbNUTa11oA6BAVdtrc85lA9HDHWmNT0V7TpfV w==;
X-CSE-ConnectionGUID: v5HEKrJWQGmZaF4aEYenqw==
X-CSE-MsgGUID: es3+rSaQQ5qDegSxHhhmLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501855"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501855"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:08 -0700
X-CSE-ConnectionGUID: Kjgjjjq3TXuKhHmALl+MNg==
X-CSE-MsgGUID: 0rI9w6P1Qmy46NUIPBftJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606087"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:07 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 7/9] rust/hpet: convert HPETTimer index to u8 type
Date: Mon, 14 Apr 2025 22:49:41 +0800
Message-Id: <20250414144943.1112885-8-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
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

The C version of HPET uses the uint8_t type for timer index ("tn"), and
usize type in Rust version will break migration between the C and Rust
versions.

So convert HPETTimer index' type to u8 (consistent with the C version of
HPET) to make it friendly for vmstate support.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 1afa891362fa..dc8a23f29d95 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -184,7 +184,7 @@ fn timer_handler(timer_cell: &BqlRefCell<HPETTimer>) {
 pub struct HPETTimer {
     /// timer N index within the timer block (`HPETState`)
     #[doc(alias = "tn")]
-    index: usize,
+    index: u8,
     qemu_timer: Timer,
     /// timer block abstraction containing this timer
     state: NonNull<HPETState>,
@@ -210,7 +210,7 @@ pub struct HPETTimer {
 }
 
 impl HPETTimer {
-    fn init(&mut self, index: usize, state: &HPETState) {
+    fn init(&mut self, index: u8, state: &HPETState) {
         *self = HPETTimer {
             index,
             // SAFETY: the HPETTimer will only be used after the timer
@@ -235,7 +235,7 @@ fn init(&mut self, index: usize, state: &HPETState) {
             Timer::NS,
             0,
             timer_handler,
-            &state.timers[self.index],
+            &state.timers[self.index as usize],
         )
     }
 
@@ -246,7 +246,7 @@ fn get_state(&self) -> &HPETState {
     }
 
     fn is_int_active(&self) -> bool {
-        self.get_state().is_timer_int_active(self.index)
+        self.get_state().is_timer_int_active(self.index.into())
     }
 
     const fn is_fsb_route_enabled(&self) -> bool {
@@ -611,7 +611,7 @@ fn handle_legacy_irq(&self, irq: u32, level: u32) {
 
     fn init_timer(&self) {
         for (index, timer) in self.timers.iter().enumerate() {
-            timer.borrow_mut().init(index, self);
+            timer.borrow_mut().init(index.try_into().unwrap(), self);
         }
     }
 
-- 
2.34.1


