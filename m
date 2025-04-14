Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3023C369B4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KoI-0003J5-OU; Mon, 14 Apr 2025 10:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoD-0003EE-25; Mon, 14 Apr 2025 10:29:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u4KoB-00064c-7o; Mon, 14 Apr 2025 10:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744640951; x=1776176951;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KnEVRmkcMIjIQwxvCGT+LbKbf6vs9GNqHGy18nPzohw=;
 b=adw62zf9KCrkSlE5zEXvxrWfr+o+azJu+kCndv7u3JTqDXxdkMoKqgqK
 gYDX+40tjeyEnZlAFgl28+Rfq5uRbCswMufuTPL8qyYU3aveQKDKHzdIN
 DwxAVDErv2Nq6ltwXgp1izaaPHX8K0HFJ2Bpk+rqVNlk+mHsavXMOeLBN
 rRIkYUGwYWNyG4J+M9NYgkC+2QuUwOzQLC9F88Uid57AJMO6+URHdBcOI
 rUhmK+DT9UrhRUe+ehte3E6WndOlTFAW0hLQs1FIgmgh/5RDBPFGRoXFA
 Y2BwnUJZ9FcWIyZ53byXuG6ND9dkKLf/aMWzcnxF7QbfH3eKsO9P+DR0D g==;
X-CSE-ConnectionGUID: uu4xSA84T1+ATxaKT4qUbw==
X-CSE-MsgGUID: xabTlAVMSHy7KJnZKwlsbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="71501850"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="71501850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 07:29:07 -0700
X-CSE-ConnectionGUID: Ae+5aztLRxG6Mb7NAKOw/A==
X-CSE-MsgGUID: Vdm4i2ThQLKeiMEysP/hjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; d="scan'208";a="134606083"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa005.fm.intel.com with ESMTP; 14 Apr 2025 07:29:05 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 6/9] rust/hpet: convert num_timers to u8 type
Date: Mon, 14 Apr 2025 22:49:40 +0800
Message-Id: <20250414144943.1112885-7-zhao1.liu@intel.com>
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

The C version of HPET uses the uint8_t type for num_timers, and usize
type in Rust version will break migration between the C and Rust
versions.

So convert num_timers' type to u8 (consistent with the C version of
HPET) to make it friendly for vmstate support.

Note the commit 7bda68e8e2b0 ("qdev, rust/hpet: fix type of HPET
'timers property") supports the usize type property, but the uint8
property has to be re-supported now.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 rust/hw/timer/hpet/src/hpet.rs | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 3ae3ec25f17a..1afa891362fa 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -12,7 +12,7 @@
 use qemu_api::{
     bindings::{
         address_space_memory, address_space_stl_le, qdev_prop_bit, qdev_prop_bool,
-        qdev_prop_uint32, qdev_prop_usize,
+        qdev_prop_uint32, qdev_prop_uint8,
     },
     c_str,
     cell::{BqlCell, BqlRefCell},
@@ -34,9 +34,9 @@
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
 /// Minimum recommended hardware implementation.
-const HPET_MIN_TIMERS: usize = 3;
+const HPET_MIN_TIMERS: u8 = 3;
 /// Maximum timers in each timer block.
-const HPET_MAX_TIMERS: usize = 32;
+const HPET_MAX_TIMERS: u8 = 32;
 
 /// Flags that HPETState.flags supports.
 const HPET_FLAG_MSI_SUPPORT_SHIFT: usize = 0;
@@ -559,14 +559,19 @@ pub struct HPETState {
 
     /// HPET timer array managed by this timer block.
     #[doc(alias = "timer")]
-    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS],
-    num_timers: BqlCell<usize>,
+    timers: [BqlRefCell<HPETTimer>; HPET_MAX_TIMERS as usize],
+    num_timers: BqlCell<u8>,
 
     /// Instance id (HPET timer block ID).
     hpet_id: BqlCell<usize>,
 }
 
 impl HPETState {
+    // Get num_timers with `usize` type, which is useful to play with array index.
+    fn get_num_timers(&self) -> usize {
+        self.num_timers.get().into()
+    }
+
     const fn has_msi_flag(&self) -> bool {
         self.flags & (1 << HPET_FLAG_MSI_SUPPORT_SHIFT) != 0
     }
@@ -628,7 +633,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             self.hpet_offset
                 .set(ticks_to_ns(self.counter.get()) - CLOCK_VIRTUAL.get_ns());
 
-            for timer in self.timers.iter().take(self.num_timers.get()) {
+            for timer in self.timers.iter().take(self.get_num_timers()) {
                 let mut t = timer.borrow_mut();
 
                 if t.is_int_enabled() && t.is_int_active() {
@@ -640,7 +645,7 @@ fn set_cfg_reg(&self, shift: u32, len: u32, val: u64) {
             // Halt main counter and disable interrupt generation.
             self.counter.set(self.get_ticks());
 
-            for timer in self.timers.iter().take(self.num_timers.get()) {
+            for timer in self.timers.iter().take(self.get_num_timers()) {
                 timer.borrow_mut().del_timer();
             }
         }
@@ -663,7 +668,7 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
         let new_val = val << shift;
         let cleared = new_val & self.int_status.get();
 
-        for (index, timer) in self.timers.iter().take(self.num_timers.get()).enumerate() {
+        for (index, timer) in self.timers.iter().take(self.get_num_timers()).enumerate() {
             if cleared & (1 << index) != 0 {
                 timer.borrow_mut().update_irq(false);
             }
@@ -737,7 +742,7 @@ fn realize(&self) {
             1 << HPET_CAP_COUNT_SIZE_CAP_SHIFT |
             1 << HPET_CAP_LEG_RT_CAP_SHIFT |
             HPET_CAP_VENDER_ID_VALUE << HPET_CAP_VENDER_ID_SHIFT |
-            ((self.num_timers.get() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
+            ((self.get_num_timers() - 1) as u64) << HPET_CAP_NUM_TIM_SHIFT | // indicate the last timer
             (HPET_CLK_PERIOD * FS_PER_NS) << HPET_CAP_CNT_CLK_PERIOD_SHIFT, // 10 ns
         );
 
@@ -746,7 +751,7 @@ fn realize(&self) {
     }
 
     fn reset_hold(&self, _type: ResetType) {
-        for timer in self.timers.iter().take(self.num_timers.get()) {
+        for timer in self.timers.iter().take(self.get_num_timers()) {
             timer.borrow_mut().reset();
         }
 
@@ -774,7 +779,7 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
             GlobalRegister::try_from(addr).map(HPETRegister::Global)
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
-            if timer_id <= self.num_timers.get() {
+            if timer_id <= self.get_num_timers() {
                 // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
                     .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
@@ -859,8 +864,8 @@ impl ObjectImpl for HPETState {
         c_str!("timers"),
         HPETState,
         num_timers,
-        unsafe { &qdev_prop_usize },
-        usize,
+        unsafe { &qdev_prop_uint8 },
+        u8,
         default = HPET_MIN_TIMERS
     ),
     qemu_api::define_property!(
-- 
2.34.1


