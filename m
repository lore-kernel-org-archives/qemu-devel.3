Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13474CF58F1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 20:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLpA0-0007wT-JR; Wed, 19 Nov 2025 15:52:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLp9z-0007uo-7o
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:52:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vLp9x-00023x-GD
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 15:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763585532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4NQAtf7TbdXclJV1DiwxB4R+oO7azwdGGte+itj1sw=;
 b=iDMwddBE67SMgnGCwkHpJATZGH8pxr4tREz6hWGkF//XrHXe0ld7yQjy4XB28cYZaUhCJi
 1C44JAxlNfUDn8aJ4CbNWKU0B5OEaXHrvD2T8XlLtl4YQyNL/UcdV4X18iKsyLm6OeEpJT
 YVFFE+5RqtFFEDq9EmQRDIlj/g+dJsY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54--GV5gDRJOi2_06dSrp_rdw-1; Wed,
 19 Nov 2025 15:52:09 -0500
X-MC-Unique: -GV5gDRJOi2_06dSrp_rdw-1
X-Mimecast-MFC-AGG-ID: -GV5gDRJOi2_06dSrp_rdw_1763585527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07BEF19560AF; Wed, 19 Nov 2025 20:52:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75B5219540E7; Wed, 19 Nov 2025 20:52:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-rust@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Josh Stone <jistone@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/4] rust/hpet: add trace events
Date: Wed, 19 Nov 2025 15:51:58 -0500
Message-ID: <20251119205200.173170-3-stefanha@redhat.com>
In-Reply-To: <20251119205200.173170-1-stefanha@redhat.com>
References: <20251119205200.173170-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the same trace events as the C implementation.

Notes:
- Keep order of hpet_ram_write_invalid_tn_cmp and hpet_ram_write_tn_cmp
  the same as the C implementation.
- Put hpet_ram_write_timer_id in HPETTimer::write() instead of
  HPETState::decode() so that reads can be excluded.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 rust/hw/timer/hpet/Cargo.toml    |  1 +
 rust/hw/timer/hpet/meson.build   |  1 +
 rust/hw/timer/hpet/src/device.rs | 45 +++++++++++++++++++-------------
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index f781b28d8b..5567eefda4 100644
--- a/rust/hw/timer/hpet/Cargo.toml
+++ b/rust/hw/timer/hpet/Cargo.toml
@@ -18,6 +18,7 @@ bql = { path = "../../../bql" }
 qom = { path = "../../../qom" }
 system = { path = "../../../system" }
 hwcore = { path = "../../../hw/core" }
+trace = { path = "../../../trace" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index bb64b96672..465995bb5a 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -11,6 +11,7 @@ _libhpet_rs = static_library(
     qom_rs,
     system_rs,
     hwcore_rs,
+    trace_rs
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 3564aa79c6..90b0ae927c 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -32,6 +32,8 @@
 
 use crate::fw_cfg::HPETFwConfig;
 
+::trace::include_trace!("hw_timer");
+
 /// Register space for each timer block (`HPET_BASE` is defined in hpet.h).
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
@@ -402,7 +404,8 @@ fn del_timer(&mut self) {
 
     /// Configuration and Capability Register
     fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
-        // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
+        trace::trace_hpet_ram_write_tn_cfg((shift / 8).try_into().unwrap());
+
         let old_val: u64 = self.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
         new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
@@ -435,17 +438,18 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
         let mut length = len;
         let mut value = val;
 
-        // TODO: Add trace point - trace_hpet_ram_write_tn_cmp(addr & 4)
         if self.is_32bit_mod() {
             // High 32-bits are zero, leave them untouched.
             if shift != 0 {
-                // TODO: Add trace point - trace_hpet_ram_write_invalid_tn_cmp()
+                trace::trace_hpet_ram_write_invalid_tn_cmp();
                 return;
             }
             length = 64;
             value = u64::from(value as u32); // truncate!
         }
 
+        trace::trace_hpet_ram_write_tn_cmp((shift / 8).try_into().unwrap());
+
         if !self.is_periodic() || self.is_valset_enabled() {
             self.cmp = self.cmp.deposit(shift, length, value);
         }
@@ -512,6 +516,9 @@ const fn read(&self, reg: TimerRegister) -> u64 {
 
     fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
         use TimerRegister::*;
+
+        trace::trace_hpet_ram_write_timer_id(self.index as u64);
+
         match reg {
             CFG => self.set_tn_cfg_reg(shift, len, value),
             CMP => self.set_tn_cmp_reg(shift, len, value),
@@ -689,15 +696,13 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
     /// Main Counter Value Register
     fn set_counter_reg(&self, shift: u32, len: u32, val: u64) {
         if self.is_hpet_enabled() {
-            // TODO: Add trace point -
-            // trace_hpet_ram_write_counter_write_while_enabled()
-            //
             // HPET spec says that writes to this register should only be
             // done while the counter is halted. So this is an undefined
             // behavior. There's no need to forbid it, but when HPET is
             // enabled, the changed counter value will not affect the
             // tick count (i.e., the previously calculated offset will
             // not be changed as well).
+            trace::trace_hpet_ram_write_counter_write_while_enabled();
         }
         self.counter
             .set(self.counter.get().deposit(shift, len, val));
@@ -787,11 +792,10 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
         } else {
             let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
             if timer_id < self.num_timers {
-                // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
                 TimerRegister::try_from(addr & 0x18)
                     .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
             } else {
-                // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
+                trace::trace_hpet_timer_id_out_of_range(timer_id.try_into().unwrap());
                 Err(addr)
             }
         };
@@ -803,7 +807,8 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
     }
 
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
-        // TODO: Add trace point - trace_hpet_ram_read(addr)
+        trace::trace_hpet_ram_read(addr);
+
         let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
 
         use GlobalRegister::*;
@@ -814,16 +819,21 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
             Global(CFG) => self.config.get(),
             Global(INT_STATUS) => self.int_status.get(),
             Global(COUNTER) => {
-                // TODO: Add trace point
-                // trace_hpet_ram_read_reading_counter(addr & 4, cur_tick)
-                if self.is_hpet_enabled() {
+                let cur_tick = if self.is_hpet_enabled() {
                     self.get_ticks()
                 } else {
                     self.counter.get()
-                }
+                };
+
+                trace::trace_hpet_ram_read_reading_counter(
+                    (addr & 4) as u8,
+                    cur_tick
+                );
+
+                cur_tick
             }
             Unknown(_) => {
-                // TODO: Add trace point- trace_hpet_ram_read_invalid()
+                trace::trace_hpet_ram_read_invalid();
                 0
             }
         }) >> shift
@@ -832,7 +842,8 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, reg } = self.decode(addr, size);
 
-        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
+        trace::trace_hpet_ram_write(addr, value);
+
         use GlobalRegister::*;
         use HPETRegister::*;
         match reg {
@@ -841,9 +852,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
             Global(CFG) => self.set_cfg_reg(shift, len, value),
             Global(INT_STATUS) => self.set_int_status_reg(shift, len, value),
             Global(COUNTER) => self.set_counter_reg(shift, len, value),
-            Unknown(_) => {
-                // TODO: Add trace point - trace_hpet_ram_write_invalid()
-            }
+            Unknown(_) => trace::trace_hpet_ram_write_invalid(),
         }
     }
 
-- 
2.51.1


