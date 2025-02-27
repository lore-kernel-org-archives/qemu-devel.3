Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6BBC282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 17:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnhjb-00066Q-Hv; Thu, 27 Feb 2025 12:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnhjU-00063H-KV
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnhjR-0008EJ-Vz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 12:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740677491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=kDYIjvzU7H8Cux61Q7gAom7URz/tocSa6TAOkLN7aNE=;
 b=jF8dF9CwWjZZuleiQQiqwIwgpzROJ1cU45wtCWEphaEGRL1AMhz7yXoQZ8QRZYbWhmoMPQ
 2dDN8oXa7QVxU86FsMeMy4di4JtnIGtbYrmgm0UqjHisAAJFEu3axmVBgQygUfhxjflLI4
 IM6Pqoiow6cADtE6OM+WNNcdVj1+KC0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-eWtTxZu-OaCG9-Zfy9N8VQ-1; Thu, 27 Feb 2025 12:31:29 -0500
X-MC-Unique: eWtTxZu-OaCG9-Zfy9N8VQ-1
X-Mimecast-MFC-AGG-ID: eWtTxZu-OaCG9-Zfy9N8VQ_1740677488
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-abb76bd0feeso185607966b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 09:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740677487; x=1741282287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kDYIjvzU7H8Cux61Q7gAom7URz/tocSa6TAOkLN7aNE=;
 b=hVB5b4Pjjq6aFxk4bon2o6kjI01fRIdHQTao/KhdRZ09Rp22i+hWNokRWwRKFr3iJc
 eSU3RRIkFl3+JgqxfqFgvRsBmJMoeRexIc4lX9E0U267m6+WWVVGyvGuZhfQMclXfMZm
 kyiR6sTeUrBjTry+PXCuXIqRRE8iHSPWKpkdKebxLE2Ubii0f0nzNmC7hGb+h4eXJsOe
 OdkQNSRZwT+nclrqKG1GhUlegAk1xBWu7hqw6WdikTwxclQqxuLvlqOqbDvr7V9DPtWV
 nYRt3g6yntLTsjhGP0cI3vYHbLRYXUzAnYdECjIqo4u2O8JHMVj2RhYyz+6vFkFGqHyQ
 ocrg==
X-Gm-Message-State: AOJu0Yxmryga2WEwHLolZr9k8drs32rdSA77bCtsQq9WXb7qtPkFFfnq
 AjRteJTq6n+0qAKtgfPhrBG5UxutdG/mgr6QOGhJQTFH6wgNlKYX+Ge7k/dZ47+NvzAxLpXhZ18
 Ist3KQOmBJfkBcSTJz8TxY0r7KkjmzLOPIxaHqou9uXN2gc/TroEL/6YWAh1GzXXQKhHSKOujog
 HR+8txxTTaRbGEQB0bvgFyLwA9vsKFTCyb3p27/oM=
X-Gm-Gg: ASbGncvYNk2rh0xBRRyXt1qYXAfGRDbgPSOWT3alpJipVqxYj5H/R2o2ydEpAqdBrsI
 8WgZjv/3L5QRM1PyI27LmK+ykrSzIehG2LpwPdn8hHQpQPXMAth9sijt99Z2AaeuMgttISxExA4
 Qlp+OcJEsjQ0FrwVqDgmbpiGrtIHM/SCJzl2Pfqu+yjSTHbxxd08BKZtzkrprr5Uz9mrlmhWLNZ
 lv9YnhE7q5HVLBXpAdCLaKCVQZZuOT+ctUmMx2USPi8OIJ4BxQNEvFNuoGM1M0ZrqiwdO0Bhx1G
 yOWOqJourAhoI28wOA==
X-Received: by 2002:a17:907:970c:b0:ab7:d66f:c872 with SMTP id
 a640c23a62f3a-abf26850676mr23662666b.19.1740677487054; 
 Thu, 27 Feb 2025 09:31:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOrfQKS0QCntCV2407FPcpHcgQ06WoRppHEm8m1Ku+7uXgSn2jCzzi8LMWgY+6yygP4HKaoA==
X-Received: by 2002:a17:907:970c:b0:ab7:d66f:c872 with SMTP id
 a640c23a62f3a-abf26850676mr23658166b.19.1740677486317; 
 Thu, 27 Feb 2025 09:31:26 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c6ed8d5sm155385466b.101.2025.02.27.09.31.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 09:31:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rust: hpet: decode HPET registers into enums
Date: Thu, 27 Feb 2025 18:31:25 +0100
Message-ID: <20250227173125.821057-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Generalize timer_and_addr() to decode all registers into a single enum
HPETRegister, and use the TryInto derive to separate valid and
invalid values.

The main advantage lies in checking that all registers are enumerated
in the "match" statements.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml                |   2 +
 rust/hw/char/pl011/src/lib.rs  |   2 -
 rust/hw/timer/hpet/src/hpet.rs | 204 +++++++++++++++++----------------
 3 files changed, 110 insertions(+), 98 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index 5041d6291fd..ab1185a8143 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -37,6 +37,8 @@ result_unit_err = "allow"
 should_implement_trait = "deny"
 # can be for a reason, e.g. in callbacks
 unused_self = "allow"
+# common in device crates
+upper_case_acronyms = "allow"
 
 # default-allow lints
 as_ptr_cast_mut = "deny"
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 45c13ba899e..dbae76991c9 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -12,8 +12,6 @@
 //! See [`PL011State`](crate::device::PL011State) for the device model type and
 //! the [`registers`] module for register types.
 
-#![allow(clippy::upper_case_acronyms)]
-
 use qemu_api::c_str;
 
 mod device;
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index a440c9f4cb9..af273f02c54 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -48,8 +48,6 @@
 const HPET_CLK_PERIOD: u64 = 10; // 10 ns
 const FS_PER_NS: u64 = 1000000; // 1000000 femtoseconds == 1 ns
 
-/// General Capabilities and ID Register
-const HPET_CAP_REG: u64 = 0x000;
 /// Revision ID (bits 0:7). Revision 1 is implemented (refer to v1.0a spec).
 const HPET_CAP_REV_ID_VALUE: u64 = 0x1;
 const HPET_CAP_REV_ID_SHIFT: usize = 0;
@@ -65,8 +63,6 @@
 /// Main Counter Tick Period (bits 32:63)
 const HPET_CAP_CNT_CLK_PERIOD_SHIFT: usize = 32;
 
-/// General Configuration Register
-const HPET_CFG_REG: u64 = 0x010;
 /// Overall Enable (bit 0)
 const HPET_CFG_ENABLE_SHIFT: usize = 0;
 /// Legacy Replacement Route (bit 1)
@@ -74,14 +70,6 @@
 /// Other bits are reserved.
 const HPET_CFG_WRITE_MASK: u64 = 0x003;
 
-/// General Interrupt Status Register
-const HPET_INT_STATUS_REG: u64 = 0x020;
-
-/// Main Counter Value Register
-const HPET_COUNTER_REG: u64 = 0x0f0;
-
-/// Timer N Configuration and Capability Register (masked by 0x18)
-const HPET_TN_CFG_REG: u64 = 0x000;
 /// bit 0, 7, and bits 16:31 are reserved.
 /// bit 4, 5, 15, and bits 32:64 are read-only.
 const HPET_TN_CFG_WRITE_MASK: u64 = 0x7f4e;
@@ -109,11 +97,51 @@
 /// Timer N Interrupt Routing Capability (bits 32:63)
 const HPET_TN_CFG_INT_ROUTE_CAP_SHIFT: usize = 32;
 
-/// Timer N Comparator Value Register (masked by 0x18)
-const HPET_TN_CMP_REG: u64 = 0x008;
+#[derive(qemu_api_macros::TryInto)]
+#[repr(u64)]
+#[allow(non_camel_case_types)]
+/// Timer registers, masked by 0x18
+enum TimerRegister {
+    /// Timer N Configuration and Capability Register
+    CFG = 0,
+    /// Timer N Comparator Value Register
+    CMP = 8,
+    /// Timer N FSB Interrupt Route Register
+    ROUTE = 16,
+}
 
-/// Timer N FSB Interrupt Route Register (masked by 0x18)
-const HPET_TN_FSB_ROUTE_REG: u64 = 0x010;
+#[derive(qemu_api_macros::TryInto)]
+#[repr(u64)]
+#[allow(non_camel_case_types)]
+/// Global registers
+enum GlobalRegister {
+    /// General Capabilities and ID Register
+    CAP = 0,
+    /// General Configuration Register
+    CFG = 0x10,
+    /// General Interrupt Status Register
+    INT_STATUS = 0x20,
+    /// Main Counter Value Register
+    COUNTER = 0xF0,
+}
+
+enum HPETRegister<'a> {
+    /// Global register in the range from `0` to `0xff`
+    Global(GlobalRegister),
+
+    /// Register in the timer block `0x100`...`0x3ff`
+    Timer(&'a BqlRefCell<HPETTimer>, TimerRegister),
+
+    /// Invalid address
+    #[allow(dead_code)]
+    Unknown(hwaddr),
+}
+
+struct HPETAddrDecode<'a> {
+    shift: u32,
+    len: u32,
+    reg: HPETRegister<'a>,
+}
 
 const fn hpet_next_wrap(cur_tick: u64) -> u64 {
     (cur_tick | 0xffffffff) + 1
@@ -460,33 +488,21 @@ fn callback(&mut self) {
         self.update_irq(true);
     }
 
-    const fn read(&self, addr: hwaddr, _size: u32) -> u64 {
-        let shift: u64 = (addr & 4) * 8;
-
-        match addr & !4 {
-            HPET_TN_CFG_REG => self.config >> shift, // including interrupt capabilities
-            HPET_TN_CMP_REG => self.cmp >> shift,    // comparator register
-            HPET_TN_FSB_ROUTE_REG => self.fsb >> shift,
-            _ => {
-                // TODO: Add trace point - trace_hpet_ram_read_invalid()
-                // Reserved.
-                0
-            }
+    const fn read(&self, reg: TimerRegister) -> u64 {
+        use TimerRegister::*;
+        match reg {
+            CFG => self.config, // including interrupt capabilities
+            CMP => self.cmp,    // comparator register
+            ROUTE => self.fsb,
         }
     }
 
-    fn write(&mut self, addr: hwaddr, value: u64, size: u32) {
-        let shift = ((addr & 4) * 8) as u32;
-        let len = std::cmp::min(size * 8, 64 - shift);
-
-        match addr & !4 {
-            HPET_TN_CFG_REG => self.set_tn_cfg_reg(shift, len, value),
-            HPET_TN_CMP_REG => self.set_tn_cmp_reg(shift, len, value),
-            HPET_TN_FSB_ROUTE_REG => self.set_tn_fsb_route_reg(shift, len, value),
-            _ => {
-                // TODO: Add trace point - trace_hpet_ram_write_invalid()
-                // Reserved.
-            }
+    fn write(&mut self, reg: TimerRegister, value: u64, shift: u32, len: u32) {
+        use TimerRegister::*;
+        match reg {
+            CFG => self.set_tn_cfg_reg(shift, len, value),
+            CMP => self.set_tn_cmp_reg(shift, len, value),
+            ROUTE => self.set_tn_fsb_route_reg(shift, len, value),
         }
     }
 }
@@ -743,76 +759,72 @@ fn reset_hold(&self, _type: ResetType) {
         self.rtc_irq_level.set(0);
     }
 
-    fn timer_and_addr(&self, addr: hwaddr) -> Option<(&BqlRefCell<HPETTimer>, hwaddr)> {
-        let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
+    fn decode(&self, mut addr: hwaddr, size: u32) -> HPETAddrDecode {
+        let shift = ((addr & 4) * 8) as u32;
+        let len = std::cmp::min(size * 8, 64 - shift);
 
-        // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
-        if timer_id > self.num_timers.get() {
-            // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
-            None
+        addr &= !4;
+        let reg = if (0..=0xff).contains(&addr) {
+            GlobalRegister::try_from(addr).map(HPETRegister::Global)
         } else {
-            // Keep the complete address so that HPETTimer's read and write could
-            // detect the invalid access.
-            Some((&self.timers[timer_id], addr & 0x1F))
-        }
+            let timer_id: usize = ((addr - 0x100) / 0x20) as usize;
+            if timer_id <= self.num_timers.get() {
+                // TODO: Add trace point - trace_hpet_ram_[read|write]_timer_id(timer_id)
+                TimerRegister::try_from(addr)
+                    .map(|reg| HPETRegister::Timer(&self.timers[timer_id], reg))
+            } else {
+                // TODO: Add trace point -  trace_hpet_timer_id_out_of_range(timer_id)
+                Err(addr)
+            }
+        };
+
+        // reg is now a Result<HPETRegister, hwaddr>
+        // convert the Err case into HPETRegister as well
+        let reg = reg.unwrap_or_else(HPETRegister::Unknown);
+        HPETAddrDecode { shift, len, reg }
     }
 
     fn read(&self, addr: hwaddr, size: u32) -> u64 {
-        let shift: u64 = (addr & 4) * 8;
-
-        // address range of all TN regs
         // TODO: Add trace point - trace_hpet_ram_read(addr)
-        if (0x100..=0x3ff).contains(&addr) {
-            match self.timer_and_addr(addr) {
-                None => 0, // Reserved,
-                Some((timer, tn_addr)) => timer.borrow_mut().read(tn_addr, size),
-            }
-        } else {
-            match addr & !4 {
-                HPET_CAP_REG => self.capability.get() >> shift, /* including HPET_PERIOD 0x004 */
-                // (CNT_CLK_PERIOD field)
-                HPET_CFG_REG => self.config.get() >> shift,
-                HPET_COUNTER_REG => {
-                    let cur_tick: u64 = if self.is_hpet_enabled() {
-                        self.get_ticks()
-                    } else {
-                        self.counter.get()
-                    };
+        let HPETAddrDecode { shift, reg, .. } = self.decode(addr, size);
 
-                    // TODO: Add trace point - trace_hpet_ram_read_reading_counter(addr & 4,
-                    // cur_tick)
-                    cur_tick >> shift
-                }
-                HPET_INT_STATUS_REG => self.int_status.get() >> shift,
-                _ => {
-                    // TODO: Add trace point- trace_hpet_ram_read_invalid()
-                    // Reserved.
-                    0
+        use GlobalRegister::*;
+        use HPETRegister::*;
+        (match reg {
+            Timer(timer, tn_reg) => timer.borrow_mut().read(tn_reg),
+            Global(CAP) => self.capability.get(), /* including HPET_PERIOD 0x004 */
+            Global(CFG) => self.config.get(),
+            Global(INT_STATUS) => self.int_status.get(),
+            Global(COUNTER) => {
+                // TODO: Add trace point
+                // trace_hpet_ram_read_reading_counter(addr & 4, cur_tick)
+                if self.is_hpet_enabled() {
+                    self.get_ticks()
+                } else {
+                    self.counter.get()
                 }
             }
-        }
+            Unknown(_) => {
+                // TODO: Add trace point- trace_hpet_ram_read_invalid()
+                0
+            }
+        }) >> shift
     }
 
     fn write(&self, addr: hwaddr, value: u64, size: u32) {
-        let shift = ((addr & 4) * 8) as u32;
-        let len = std::cmp::min(size * 8, 64 - shift);
+        let HPETAddrDecode { shift, len, reg } = self.decode(addr, size);
 
         // TODO: Add trace point - trace_hpet_ram_write(addr, value)
-        if (0x100..=0x3ff).contains(&addr) {
-            match self.timer_and_addr(addr) {
-                None => (), // Reserved.
-                Some((timer, tn_addr)) => timer.borrow_mut().write(tn_addr, value, size),
-            }
-        } else {
-            match addr & !0x4 {
-                HPET_CAP_REG => {} // General Capabilities and ID Register: Read Only
-                HPET_CFG_REG => self.set_cfg_reg(shift, len, value),
-                HPET_INT_STATUS_REG => self.set_int_status_reg(shift, len, value),
-                HPET_COUNTER_REG => self.set_counter_reg(shift, len, value),
-                _ => {
-                    // TODO: Add trace point - trace_hpet_ram_write_invalid()
-                    // Reserved.
-                }
+        use GlobalRegister::*;
+        use HPETRegister::*;
+        match reg {
+            Timer(timer, tn_reg) => timer.borrow_mut().write(tn_reg, value, shift, len),
+            Global(CAP) => {} // General Capabilities and ID Register: Read Only
+            Global(CFG) => self.set_cfg_reg(shift, len, value),
+            Global(INT_STATUS) => self.set_int_status_reg(shift, len, value),
+            Global(COUNTER) => self.set_counter_reg(shift, len, value),
+            Unknown(_) => {
+                // TODO: Add trace point - trace_hpet_ram_write_invalid()
             }
         }
     }
-- 
2.48.1


