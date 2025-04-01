Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B6C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 00:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzPi3-0004sg-TL; Mon, 31 Mar 2025 20:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saman@enumclass.cc>)
 id 1tzPSr-0003Md-AV; Mon, 31 Mar 2025 20:26:51 -0400
Received: from out-02.smtp.spacemail.com ([63.250.43.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <saman@enumclass.cc>)
 id 1tzPSo-0000gN-R9; Mon, 31 Mar 2025 20:26:49 -0400
Received: from prod-lbout-phx.jellyfish.systems (unknown [198.177.122.3])
 by smtp.spacemail.com (Postfix) with ESMTPA id 4ZRTMH360czGpBH;
 Tue, 01 Apr 2025 00:26:35 +0000 (UTC)
Received: from enumclass.. (unknown [206.221.150.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4ZRTMG4cZgz8sWP;
 Tue,  1 Apr 2025 00:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=enumclass.cc;
 s=spacemail; t=1743467195;
 bh=S/g2k8i0K/bwT8fXEnWu/VvIS/hn/3hFxwV7PpWvqjc=;
 h=From:To:Cc:Subject:Date:From;
 b=z9mvb0+ggACBJEYkURbhqnDKCOojKoaHVM+eH4t1GmIXLObZKTpWEuLzeFmzh65xC
 DzSgCTqDZ/w8930k2omIZHzLPVjivobr1fwcp5uJ8XlT5/rg+klkMqsKRfg/Exewc4
 AZpl6qrfUJpjxWT3G8wyXChBHzHLWdxUDHTmSI7tTAUjfJQ0oL4RPnf4JdQPX50FAK
 UEb7NsKja4Y8ua0eivwqlIJW1VZoYpIb/FBkU9ElqbsvFieKzmuhM1g4vGvk8k2w3w
 EgQT0uzvjRN8/R3ckkatKyr82QE8iw+uy0/Ucxdkpttiq4B6i8UMGX8ezXgwMh/NDB
 9XPLuBK7UoUng==
From: saman <saman@enumclass.cc>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-rust@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 saman <saman@enumclass.cc>
Subject: [PATCH] Rust: Add tracing and logging support for Rust code
Date: Mon, 31 Mar 2025 19:26:33 -0500
Message-ID: <20250401002633.738345-1-saman@enumclass.cc>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.250.43.87; envelope-from=saman@enumclass.cc;
 helo=out-02.smtp.spacemail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 31 Mar 2025 20:42:30 -0400
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

This change introduces initial support for tracing and logging in Rust-based
QEMU code. As an example, tracing and logging have been implemented in the
pl011 device, which is written in Rust.

- Updated `rust/wrapper.h` to include the `qemu/log.h` and `hw/char/trace.h` header.
- Added log.rs to wrap `qemu_log_mask` and `qemu_log_mask_and_addr`
- Modified `tracetool` scripts to move C function implementation from
  header to .c
- Added log and trace in rust version of PL011 device

Future enhancements could include generating idiomatic Rust APIs for tracing
using the tracetool scripts

Signed-off-by: saman <saman@enumclass.cc>
---
 include/qemu/log-for-trace.h        |  5 +--
 rust/hw/char/pl011/src/device.rs    | 34 +++++++++++++++---
 rust/hw/char/pl011/src/registers.rs | 20 +++++++++++
 rust/qemu-api/meson.build           |  1 +
 rust/qemu-api/src/lib.rs            |  1 +
 rust/qemu-api/src/log.rs            | 54 +++++++++++++++++++++++++++++
 rust/wrapper.h                      |  2 ++
 scripts/tracetool/format/c.py       | 16 +++++++++
 scripts/tracetool/format/h.py       | 11 ++----
 util/log.c                          |  5 +++
 10 files changed, 131 insertions(+), 18 deletions(-)
 create mode 100644 rust/qemu-api/src/log.rs

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index d47c9cd446..ad5cd0dd24 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -24,10 +24,7 @@ extern int qemu_loglevel;
 #define LOG_TRACE          (1 << 15)
 
 /* Returns true if a bit is set in the current loglevel mask */
-static inline bool qemu_loglevel_mask(int mask)
-{
-    return (qemu_loglevel & mask) != 0;
-}
+bool qemu_loglevel_mask(int mask);
 
 /* main logging function */
 void G_GNUC_PRINTF(1, 2) qemu_log(const char *fmt, ...);
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bf88e0b00a..42385a7bf6 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,15 +2,21 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use std::{ffi::CStr, mem::size_of, ptr::addr_of_mut};
+use std::{
+    ffi::{CStr, CString},
+    mem::size_of,
+    ptr::addr_of_mut,
+};
 
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward,
     irq::{IRQState, InterruptSource},
+    log::Mask,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
+    qemu_log_mask,
     qom::{ObjectImpl, Owned, ParentField},
     static_assert,
     sysbus::{SysBusDevice, SysBusDeviceImpl},
@@ -298,7 +304,7 @@ pub(self) fn write(
             DMACR => {
                 self.dmacr = value;
                 if value & 3 > 0 {
-                    // qemu_log_mask(LOG_UNIMP, "pl011: DMA not implemented\n");
+                    qemu_log_mask!(Mask::log_unimp, "pl011: DMA not implemented\n");
                     eprintln!("pl011: DMA not implemented");
                 }
             }
@@ -535,11 +541,21 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                 u64::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
-                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
+                qemu_log_mask!(
+                    Mask::log_guest_error,
+                    "pl011_read: Bad offset 0x%x\n",
+                    offset as i32
+                );
                 0
             }
             Ok(field) => {
+                let regname = field.as_str();
                 let (update_irq, result) = self.regs.borrow_mut().read(field);
+                let c_string = CString::new(regname).expect("CString::new failed");
+                let name_ptr = c_string.as_ptr();
+                unsafe {
+                    qemu_api::bindings::trace_pl011_read(offset as u32, result, name_ptr);
+                }
                 if update_irq {
                     self.update();
                     self.char_backend.accept_input();
@@ -576,8 +592,16 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
 
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        u32::from(regs.read_count < regs.fifo_depth())
+        let fifo_available = u32::from(regs.read_count < regs.fifo_depth());
+        unsafe {
+            qemu_api::bindings::trace_pl011_can_receive(
+                u32::from(regs.line_control),
+                regs.read_count,
+                regs.fifo_depth().try_into().unwrap(),
+                fifo_available,
+            );
+        }
+        fifo_available
     }
 
     fn receive(&self, buf: &[u8]) {
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index cd92fa2c30..11c085030d 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -72,6 +72,26 @@ pub enum RegisterOffset {
     //Reserved = 0x04C,
 }
 
+impl RegisterOffset {
+    pub fn as_str(&self) -> &'static str {
+        match self {
+            RegisterOffset::DR => "DR",
+            RegisterOffset::RSR => "RSR",
+            RegisterOffset::FR => "FR",
+            RegisterOffset::FBRD => "FBRD",
+            RegisterOffset::ILPR => "ILPR",
+            RegisterOffset::IBRD => "IBRD",
+            RegisterOffset::LCR_H => "LCR_H",
+            RegisterOffset::CR => "CR",
+            RegisterOffset::FLS => "FLS",
+            RegisterOffset::IMSC => "IMSC",
+            RegisterOffset::RIS => "RIS",
+            RegisterOffset::MIS => "MIS",
+            RegisterOffset::ICR => "ICR",
+            RegisterOffset::DMACR => "DMACR",
+        }
+    }
+}
 /// Receive Status Register / Data Register common error bits
 ///
 /// The `UARTRSR` register is updated only when a read occurs
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 858685ddd4..f8eddf7887 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -34,6 +34,7 @@ _qemu_api_rs = static_library(
       'src/qom.rs',
       'src/sysbus.rs',
       'src/timer.rs',
+      'src/log.rs',
       'src/vmstate.rs',
       'src/zeroable.rs',
     ],
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index 05f38b51d3..b54989a243 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -21,6 +21,7 @@
 pub mod chardev;
 pub mod errno;
 pub mod irq;
+pub mod log;
 pub mod memory;
 pub mod module;
 pub mod offset_of;
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
new file mode 100644
index 0000000000..07e8bceb34
--- /dev/null
+++ b/rust/qemu-api/src/log.rs
@@ -0,0 +1,54 @@
+#[allow(non_camel_case_types)]
+#[repr(u32)]
+pub enum Mask {
+    cpu_log_tb_out_asm = crate::bindings::CPU_LOG_TB_OUT_ASM,
+    cpu_log_tb_in_asm = crate::bindings::CPU_LOG_TB_IN_ASM,
+    cpu_log_tb_op = crate::bindings::CPU_LOG_TB_OP,
+    cpu_log_tb_op_opt = crate::bindings::CPU_LOG_TB_OP_OPT,
+    cpu_log_int = crate::bindings::CPU_LOG_INT,
+    cpu_log_exec = crate::bindings::CPU_LOG_EXEC,
+    cpu_log_pcall = crate::bindings::CPU_LOG_PCALL,
+    cpu_log_tb_cpu = crate::bindings::CPU_LOG_TB_CPU,
+    cpu_log_reset = crate::bindings::CPU_LOG_RESET,
+    log_unimp = crate::bindings::LOG_UNIMP,
+    log_guest_error = crate::bindings::LOG_GUEST_ERROR,
+    cpu_log_mmu = crate::bindings::CPU_LOG_MMU,
+    cpu_log_tb_nochain = crate::bindings::CPU_LOG_TB_NOCHAIN,
+    cpu_log_page = crate::bindings::CPU_LOG_PAGE,
+    cpu_log_tb_op_ind = crate::bindings::CPU_LOG_TB_OP_IND,
+    cpu_log_tb_fpu = crate::bindings::CPU_LOG_TB_FPU,
+    cpu_log_plugin = crate::bindings::CPU_LOG_PLUGIN,
+    log_strace = crate::bindings::LOG_STRACE,
+    log_per_thread = crate::bindings::LOG_PER_THREAD,
+    cpu_log_tb_vpu = crate::bindings::CPU_LOG_TB_VPU,
+    log_tb_op_plugin = crate::bindings::LOG_TB_OP_PLUGIN,
+    log_invalid_mem = crate::bindings::LOG_INVALID_MEM,
+}
+
+#[macro_export]
+macro_rules! qemu_log_mask {
+    ($mask:expr, $fmt:expr $(, $arg:expr)*) => {{
+        let mask: Mask = $mask;
+        unsafe {
+            if $crate::bindings::qemu_loglevel_mask(mask as std::os::raw::c_int) {
+                let format_str = std::ffi::CString::new($fmt).expect("CString::new failed");
+                $crate::bindings::qemu_log(format_str.as_ptr() $(, $arg)*);
+            }
+        }
+    }};
+}
+
+#[macro_export]
+macro_rules! qemu_log_mask_and_addr {
+    ($mask:expr, $addr:expr, $fmt:expr $(, $arg:expr)*) => {{
+        let mask: Mask = $mask;
+        let addr: $crate::bindings::hwaddr = $addr;
+        unsafe {
+            if $crate::bindings::qemu_loglevel_mask(mask as std::os::raw::c_int) &&
+                $crate::bindings::qemu_log_in_addr_range(addr) {
+                let format_str = std::ffi::CString::new($fmt).expect("CString::new failed");
+                $crate::bindings::qemu_log(format_str.as_ptr() $(, $arg)*);
+            }
+        }
+    }};
+}
diff --git a/rust/wrapper.h b/rust/wrapper.h
index d4fec54657..cd2f311d71 100644
--- a/rust/wrapper.h
+++ b/rust/wrapper.h
@@ -64,5 +64,7 @@ typedef enum memory_order {
 #include "chardev/char-serial.h"
 #include "exec/memattrs.h"
 #include "qemu/timer.h"
+#include "qemu/log.h"
 #include "exec/address-spaces.h"
 #include "hw/char/pl011.h"
+#include "hw/char/trace.h"
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 69edf0d588..f2d383f89c 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -43,6 +43,22 @@ def generate(events, backend, group):
             sstate = "TRACE_%s_ENABLED" % e.name.upper(),
             dstate = e.api(e.QEMU_DSTATE))
 
+        cond = "true"
+
+        out('',
+            'void %(api)s(%(args)s)',
+            '{',
+            '    if (%(cond)s) {',
+            '        %(api_nocheck)s(%(names)s);',
+            '    }',
+            '}',
+            api=e.api(),
+            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
+            args=e.args,
+            names=", ".join(e.args.names()),
+            cond=cond
+            )
+
     out('TraceEvent *%(group)s_trace_events[] = {',
         group = group.lower())
 
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index ea126b07ea..16b360ae49 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -74,17 +74,10 @@ def generate(events, backend, group):
         cond = "true"
 
         out('',
-            'static inline void %(api)s(%(args)s)',
-            '{',
-            '    if (%(cond)s) {',
-            '        %(api_nocheck)s(%(names)s);',
-            '    }',
-            '}',
+            'void %(api)s(%(args)s);',
             api=e.api(),
-            api_nocheck=e.api(e.QEMU_TRACE_NOCHECK),
             args=e.args,
-            names=", ".join(e.args.names()),
-            cond=cond)
+            )
 
     backend.generate_end(events, group)
 
diff --git a/util/log.c b/util/log.c
index b87d399e4c..51f659be0a 100644
--- a/util/log.c
+++ b/util/log.c
@@ -143,6 +143,11 @@ void qemu_log_unlock(FILE *logfile)
     }
 }
 
+bool qemu_loglevel_mask(int mask)
+{
+    return (qemu_loglevel & mask) != 0;
+}
+
 void qemu_log(const char *fmt, ...)
 {
     FILE *f = qemu_log_trylock();
-- 
2.43.0


