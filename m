Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3231EE8FDDA
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQR1-0005Ws-CM; Sat, 27 Dec 2025 04:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQv-0005PV-5u
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQt-0003VR-Bj
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYWPfvt7RxlWz1Fc5/w7WlUWta1x0esdmfC55Kug0eE=;
 b=U7j5TbcZS0onQ1ZbNPPHn4mLrkCcdnwKmRT2VFpgTS8twG9migvJJ0xL9Ph3foTAtpyWLd
 4JevCsY8kK0NH4S3RXB8/i/L3MkoKeZXVILDQOW/GBwe0fHZojjzeUBJaGOqOyBOyK9wVd
 WtOiXXY3zLg/Keo12idTOIlaS1muOso=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-8eaMrJDwOH2TzNc8fFII3A-1; Sat, 27 Dec 2025 04:17:53 -0500
X-MC-Unique: 8eaMrJDwOH2TzNc8fFII3A-1
X-Mimecast-MFC-AGG-ID: 8eaMrJDwOH2TzNc8fFII3A_1766827072
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fd96b2f5so6779124f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827071; x=1767431871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYWPfvt7RxlWz1Fc5/w7WlUWta1x0esdmfC55Kug0eE=;
 b=UY7cUFM3y5MCGRXcAWAQrJyuZMEQA44X3skAdiCP2vA/kgL1RhozlnaiFgok2BG1YC
 dzvDHKOfljCN2XK+TfO4fZ5fuPaAeOBTF1cbkSwiCZQOrap5/FvIB0/HyXDhX46lZMVD
 JAwiJfbZUUXR1gTAYhjEd3ZumJFTsZXYkVT6/gRulCj7osCOt63zchXP9RoBI3kussgF
 zhczm66laLweKkycvm6/0A2n7Khq8ljQ/VpRSy+Y5SjzxgiAL9eqk2wHiOuQLOn7/GRd
 8aIw+YjB59yVgudXw5J4pVmRu80S1y7dypDtBuyc6JiqBsyAKUpO+z7VMLuvNPmLUV5P
 oZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827071; x=1767431871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kYWPfvt7RxlWz1Fc5/w7WlUWta1x0esdmfC55Kug0eE=;
 b=NIpZNYvw4IDvoUbCIJHBe0ifjhA2uJvrWOe8KAd+d3WVJYDI739+Wd+ASPYxtEPS7c
 tSf+tWwoLDDfPfo0QuQnHf/jEhxLsh4wjyB8xNUn3+yGkCqTv33TZbANhr856xcmBh8f
 d84nOU8U55LI417scgWdHzXaB0Da8hbanMcGaNsZ7wg7g/e66bBfsl8oJ9JiuAAO0nw4
 0gc0CF3bqvesYTENs2ZBsin4GoDx5aJuBRpowx9JLQ1533qhmVYJMq5bGMdN3c2xGmyv
 ExcPn8bZvNqB4bOk7bWJxeyr97Cg2IVKSFArrw/8GZg7iBvWamkhfPIUHfEnR5sUtCg2
 g6LQ==
X-Gm-Message-State: AOJu0YwsXLb8fnlghjfDUuY6Ry10mvTkRXHB/tPwOsktnrfQQ2rbXph+
 zLhuFTbEqiSjR7p75BRVnStjg8hPbYjcIRwVq8HtcCRbZxWY45eKehZpcaAC2UQk9Uv2vySb3ud
 vGnte7S5y7BGXRTt8hYd1ceGFfU9MGv8PDT4w9QqDtVEqaF/0U8AzotqJF5wtMv1/tPkpYBZVoy
 7FRjPwtnb5Utkj+A674fCd6KkRV5RYKg0hZZS2dQ8F
X-Gm-Gg: AY/fxX7T0kmYvpA6D121/hnMwNGi231tpY8iNQgq0x6oEH/9UsJxZjyW2HeXS5SPFQR
 BTtVJRRsT97xjfTOdpGW2RQlQKZEVeScgpFyJRERlLbXgTqTqEJn5jI/05+3zbbiwcCN1ajvW7Z
 9kQZHI2Btfo7xl8LyWq56+2ual9s/vnu97D6bbknBrOk0uxN7hNRxNeMUIjibg7sPC5hfrs+cWU
 MUCpam6T+rCIbF9ski8ycp+eQEiJnV7R+LxtWD3X4NXv2jhX9MeWYw0+U3w92wWIzbROxTVfATK
 CX1sjfXypqjgoD5DI13bVHbipLO7fTznYV77Nm2tDjeAxTNE8MPRAohxaHOXGLLRh9XwgaW1Ib4
 ft6vHcWO4zJ02caDlh28FIudowaowieSDiSQ5oC8jbCTtB/f/xp8SAw1ccCd9MT/glyEms6t461
 TUtnJD2jd5aw0TvKQ=
X-Received: by 2002:a05:6000:2285:b0:431:1d4:3a82 with SMTP id
 ffacd0b85a97d-4324e4c6405mr32278416f8f.11.1766827071282; 
 Sat, 27 Dec 2025 01:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvv3vS4zPd41glGYlB5sJBDi5+XzHXtprzZbh2jnkb3swK20rj84cjYdzgy8M9EOFmp/uGpg==
X-Received: by 2002:a05:6000:2285:b0:431:1d4:3a82 with SMTP id
 ffacd0b85a97d-4324e4c6405mr32278382f8f.11.1766827070708; 
 Sat, 27 Dec 2025 01:17:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm49534672f8f.31.2025.12.27.01.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 046/153] rust/hpet: add trace events
Date: Sat, 27 Dec 2025 10:14:33 +0100
Message-ID: <20251227091622.20725-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Implement the same trace events as the C implementation.

Notes:
- Keep order of hpet_ram_write_invalid_tn_cmp and hpet_ram_write_tn_cmp
  the same as the C implementation.
- Put hpet_ram_write_timer_id in HPETTimer::write() instead of
  HPETState::decode() so that reads can be excluded.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/r/20251106215606.36598-3-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/trace-events            |  2 +-
 rust/Cargo.lock                  |  1 +
 rust/hw/timer/hpet/Cargo.toml    |  1 +
 rust/hw/timer/hpet/meson.build   |  1 +
 rust/hw/timer/hpet/src/device.rs | 44 ++++++++++++++++++--------------
 5 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index f3fca6fc9b1..ac5afe84e83 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -116,7 +116,7 @@ hpet_ram_read(uint64_t addr) "enter hpet_ram_readl at 0x%" PRIx64
 hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "reading counter + %" PRIu8 " = 0x%" PRIx64
 hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
 hpet_ram_write(uint64_t addr, uint64_t value) "enter hpet_ram_writel at 0x%" PRIx64 " = 0x%" PRIx64
-hpet_ram_write_timer_id(uint64_t timer_id) "hpet_ram_writel timer_id = 0x%" PRIx64
+hpet_ram_write_timer_id(uint8_t timer_id) "hpet_ram_writel timer_id = %" PRIu8
 hpet_ram_write_tn_cfg(uint8_t reg_off) "hpet_ram_writel HPET_TN_CFG + %" PRIu8
 hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %" PRIu8
 hpet_ram_write_invalid_tn_cmp(void) "invalid HPET_TN_CMP + 4 write"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 0c1df625df1..f520597f25d 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -144,6 +144,7 @@ dependencies = [
  "migration",
  "qom",
  "system",
+ "trace",
  "util",
 ]
 
diff --git a/rust/hw/timer/hpet/Cargo.toml b/rust/hw/timer/hpet/Cargo.toml
index f781b28d8b3..5567eefda4a 100644
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
index bb64b96672e..9a3dd62caa3 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -11,6 +11,7 @@ _libhpet_rs = static_library(
     qom_rs,
     system_rs,
     hwcore_rs,
+    trace_rs,
   ],
 )
 
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index c82b27ddf15..a2c5b7d04c6 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -17,13 +17,15 @@
 use qom::prelude::*;
 use system::{
     bindings::{address_space_memory, address_space_stl_le},
-    MEMTXATTRS_UNSPECIFIED,
     prelude::*,
+    MEMTXATTRS_UNSPECIFIED,
 };
 use util::prelude::*;
 
 use crate::fw_cfg::HPETFwConfig;
 
+::trace::include_trace!("hw_timer");
+
 /// Register space for each timer block (`HPET_BASE` is defined in hpet.h).
 const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes
 
@@ -394,7 +396,8 @@ fn del_timer(&mut self) {
 
     /// Configuration and Capability Register
     fn set_tn_cfg_reg(&mut self, shift: u32, len: u32, val: u64) {
-        // TODO: Add trace point - trace_hpet_ram_write_tn_cfg(addr & 4)
+        trace::trace_hpet_ram_write_tn_cfg((shift / 8).try_into().unwrap());
+
         let old_val: u64 = self.config;
         let mut new_val: u64 = old_val.deposit(shift, len, val);
         new_val = hpet_fixup_reg(new_val, old_val, HPET_TN_CFG_WRITE_MASK);
@@ -427,17 +430,18 @@ fn set_tn_cmp_reg(&mut self, shift: u32, len: u32, val: u64) {
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
@@ -504,6 +508,9 @@ const fn read(&self, reg: TimerRegister) -> u64 {
 
     fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
         use TimerRegister::*;
+
+        trace::trace_hpet_ram_write_timer_id(self.index);
+
         match reg {
             CFG => self.set_tn_cfg_reg(shift, len, value),
             CMP => self.set_tn_cmp_reg(shift, len, value),
@@ -681,15 +688,13 @@ fn set_int_status_reg(&self, shift: u32, _len: u32, val: u64) {
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
@@ -779,11 +784,10 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
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
@@ -795,7 +799,8 @@ fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode<'_> {
     }
 
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
-        // TODO: Add trace point - trace_hpet_ram_read(addr)
+        trace::trace_hpet_ram_read(addr);
+
         let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
 
         use GlobalRegister::*;
@@ -806,16 +811,18 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
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
+                trace::trace_hpet_ram_read_reading_counter((addr & 4) as u8, cur_tick);
+
+                cur_tick
             }
             Unknown(_) => {
-                // TODO: Add trace point- trace_hpet_ram_read_invalid()
+                trace::trace_hpet_ram_read_invalid();
                 0
             }
         }) >> shift
@@ -824,7 +831,8 @@ fn read(&self, addr: hwaddr, size: u32) -> u64 {
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
         let HPETAddrDecode { shift, len, reg } = self.decode(addr, size);
 
-        // TODO: Add trace point - trace_hpet_ram_write(addr, value)
+        trace::trace_hpet_ram_write(addr, value);
+
         use GlobalRegister::*;
         use HPETRegister::*;
         match reg {
@@ -833,9 +841,7 @@ fn write(&self, addr: hwaddr, value: u64, size: u32) {
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
2.52.0


