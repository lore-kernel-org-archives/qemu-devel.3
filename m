Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E805CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQvR-0001Gv-2n; Fri, 22 Aug 2025 08:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQvF-0000yL-IG
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQv9-0002oo-Ug
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=027Ne2RoE1YpgI8ZmyFgIhjjOIsJK4ozLVwseK0f3B4=;
 b=e3yx8i373z1eZh1PNBu7+uiUXpUO3vnL5ofkeY+rQsjxTFcLNpnDgv68Stmsk0vzm1cFZ+
 p/DX5hQCa0S6fAComywwrJy65ZLTjyDdWpNzpdblVpscRzBbGryCvAK1pKcaX9sVhSR5xa
 V/iFCDgqR+bN1p7o/2ogDcO8QbxpLz4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-aJMte_BSNEyy7YnXOVrp1g-1; Fri, 22 Aug 2025 08:27:22 -0400
X-MC-Unique: aJMte_BSNEyy7YnXOVrp1g-1
X-Mimecast-MFC-AGG-ID: aJMte_BSNEyy7YnXOVrp1g_1755865641
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a15fd6b45so14135485e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865641; x=1756470441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=027Ne2RoE1YpgI8ZmyFgIhjjOIsJK4ozLVwseK0f3B4=;
 b=QSYa6K6FQcwOwDm4DCzRPBvcN+qiWFUQnt1++JI2mUFLvIZ3RQCz0RRSxjtaRNOJtj
 fhh1FIOLhk6fkn+fB9jyUQMB8vOOxVwqb+67YpZhrSMD34K8d5hZJWiwTaAT7pCz6qr7
 c1YT65P78l1er+EShuSOaG2Rd7bwk7K7W0JsfnBaRyC8NgxUXqE+fwKbkVhIOQL8cilJ
 vR4UC+oF0HbBwCYqW+FjwnC/r8t7ufu4k88Ba605Y/t3BYNlZbsJy62LKQVwjOvHEPTX
 MRn5ZyYYR/O0tf6hMfgEh00nv1T5kbmm2QzC2+pPznKhTC0iWMAZuABK7vB6F+YmRWdx
 toiw==
X-Gm-Message-State: AOJu0YyvuNuaI+yXF7Zme3qhlMKO6IKvXp3Z4axNxMh8WKPlBmG484P7
 hH/zgiEqe9colggwhUYWV9pbmVwa3aie/8PMieBUf4RkhFpobYp0vTX7vSaCIPjP7kKl0Zxl8+h
 ltriBMk7Sfi4MJUZbSwN/9pirmd9qrmJ6sNlN+nVVDGqPPGKAqGo5VlxRa5HhqSSscRoOku5qle
 pDs480vjjPCERBsKZt1ohCfwVtlqMgN+wM/XLivQd1
X-Gm-Gg: ASbGncvBEhy6SNydqs6T2+F+ARCLj2dIFdHKWSZds2mS4eV7ZwfNq5N/aGMUdjahXXu
 sMS5CxfJbzwMo1la7mOq8MeKNpqen4XqWvhM5IPb0V/Dyz8c3FDUVgzKMErRuf9god9VCM+cENt
 unVOdFzNa0CyMQl4mFwCjhRwCSzBCatcGNlNMWGOLMYPUrpgnCMFdZkcuDR9sHBE/J/L1ZALPA3
 FPTnrolUy5bSWux1CjD+gP8o2yKddIe5MPFwsiqWP52CBqKaDHBVb1czAfyqe56gip1JvtMmYHU
 kLGll1ttzfR4b7gSkpwE9+Svu5ptAJjFnHoWZzODEQ8otIIwTkvmjFh92Iv3qHcHVkoV6p0McOi
 XZ/EgVQM+F9u0E+5f4J0woJPpsnqjftX/PhY8PLfgjw==
X-Received: by 2002:a05:6000:22c6:b0:3b9:51db:ba4d with SMTP id
 ffacd0b85a97d-3c5d4ce14edmr2598063f8f.24.1755865640610; 
 Fri, 22 Aug 2025 05:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4QyhNH/l/h9I8lpEV4/58c9InFecoTq547IY6++qyea3OGvYZ1od1o/0nqOqfoZc6nRZSjg==
X-Received: by 2002:a05:6000:22c6:b0:3b9:51db:ba4d with SMTP id
 ffacd0b85a97d-3c5d4ce14edmr2598032f8f.24.1755865640054; 
 Fri, 22 Aug 2025 05:27:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3e673ab01sm8671510f8f.18.2025.08.22.05.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 09/14] rust: pl011: add tracepoints
Date: Fri, 22 Aug 2025 14:26:50 +0200
Message-ID: <20250822122655.1353197-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Finally bring parity between C and Rust versions of the PL011 device model.
Changing some types of the arguments makes for nicer Rust code; C does not
care. :)

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/char/trace-events             | 14 ++++----
 rust/Cargo.lock                  |  1 +
 rust/hw/char/pl011/Cargo.toml    |  1 +
 rust/hw/char/pl011/meson.build   |  1 +
 rust/hw/char/pl011/src/device.rs | 57 ++++++++++++++++++++++----------
 5 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index 05a33036c12..9e74be2c14f 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -58,15 +58,15 @@ imx_serial_write(const char *chrname, uint64_t addr, uint64_t value) "%s:[0x%03"
 imx_serial_put_data(const char *chrname, uint32_t value) "%s: 0x%" PRIx32
 
 # pl011.c
-pl011_irq_state(int level) "irq state %d"
-pl011_read(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_read_fifo(unsigned rx_fifo_used, size_t rx_fifo_depth) "RX FIFO read, used %u/%zu"
-pl011_write(uint32_t addr, uint32_t value, const char *regname) "addr 0x%03x value 0x%08x reg %s"
-pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, size_t rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%zu, can_receive %u chars"
-pl011_fifo_rx_put(uint32_t c, unsigned read_count, size_t rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%zu depth used"
+pl011_irq_state(bool level) "irq state %d"
+pl011_read(uint64_t addr, uint32_t value, const char *regname) "addr 0x%03" PRIx64 " value 0x%08x reg %s"
+pl011_read_fifo(unsigned rx_fifo_used, unsigned rx_fifo_depth) "RX FIFO read, used %u/%u"
+pl011_write(uint64_t addr, uint32_t value, const char *regname) "addr 0x%03" PRIx64 " value 0x%08x reg %s"
+pl011_can_receive(uint32_t lcr, unsigned rx_fifo_used, unsigned rx_fifo_depth, unsigned rx_fifo_available) "LCR 0x%02x, RX FIFO used %u/%u, can_receive %u chars"
+pl011_fifo_rx_put(uint32_t c, unsigned read_count, unsigned rx_fifo_depth) "RX FIFO push char [0x%02x] %d/%u depth used"
 pl011_fifo_rx_full(void) "RX FIFO now full, RXFF set"
 pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
-pl011_receive(int size) "recv %d chars"
+pl011_receive(size_t size) "recv %zd chars"
 
 # cmsdk-apb-uart.c
 cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index aa13ab2a99a..6ed838f863f 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -91,6 +91,7 @@ dependencies = [
  "bits",
  "qemu_api",
  "qemu_api_macros",
+ "trace",
 ]
 
 [[package]]
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 88ef110507d..d71b881f4e1 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -18,6 +18,7 @@ bilge-impl = { version = "0.2.0" }
 bits = { path = "../../../bits" }
 qemu_api = { path = "../../../qemu-api" }
 qemu_api_macros = { path = "../../../qemu-api-macros" }
+trace = { path = "../../../trace" }
 
 [lints]
 workspace = true
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 16acf12f7cc..5083701d6a7 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -9,6 +9,7 @@ _libpl011_rs = static_library(
     bits_rs,
     qemu_api_rs,
     qemu_api_macros,
+    trace_rs
   ],
 )
 
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 8411db8d00c..bd30b117e92 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -4,6 +4,8 @@
 
 use std::{ffi::CStr, mem::size_of};
 
+::trace::include_trace!("trace-hw_char");
+
 use qemu_api::{
     chardev::{CharBackend, Chardev, Event},
     impl_vmstate_forward, impl_vmstate_struct,
@@ -210,13 +212,7 @@ pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
         (update, result)
     }
 
-    pub(self) fn write(
-        &mut self,
-        offset: RegisterOffset,
-        value: u32,
-        char_backend: &CharBackend,
-    ) -> bool {
-        // eprintln!("write offset {offset} value {value}");
+    pub(self) fn write(&mut self, offset: RegisterOffset, value: u32, device: &PL011State) -> bool {
         use RegisterOffset::*;
         match offset {
             DR => return self.write_data_register(value),
@@ -231,9 +227,11 @@ pub(self) fn write(
             }
             IBRD => {
                 self.ibrd = value;
+                device.trace_baudrate_change(self.ibrd, self.fbrd);
             }
             FBRD => {
                 self.fbrd = value;
+                device.trace_baudrate_change(self.ibrd, self.fbrd);
             }
             LCR_H => {
                 let new_val: registers::LineControl = value.into();
@@ -244,7 +242,7 @@ pub(self) fn write(
                 }
                 let update = (self.line_control.send_break() != new_val.send_break()) && {
                     let break_enable = new_val.send_break();
-                    let _ = char_backend.send_break(break_enable);
+                    let _ = device.char_backend.send_break(break_enable);
                     self.loopback_break(break_enable)
                 };
                 self.line_control = new_val;
@@ -281,12 +279,13 @@ pub(self) fn write(
     }
 
     fn read_data_register(&mut self, update: &mut bool) -> u32 {
+        let depth = self.fifo_depth();
         self.flags.set_receive_fifo_full(false);
         let c = self.read_fifo[self.read_pos];
 
         if self.read_count > 0 {
             self.read_count -= 1;
-            self.read_pos = (self.read_pos + 1) & (self.fifo_depth() - 1);
+            self.read_pos = (self.read_pos + 1) & (depth - 1);
         }
         if self.read_count == 0 {
             self.flags.set_receive_fifo_empty(true);
@@ -294,6 +293,7 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
         if self.read_count + 1 == self.read_trigger {
             self.int_level &= !Interrupt::RX;
         }
+        trace::trace_pl011_read_fifo(self.read_count, depth);
         self.receive_status_error_clear.set_from_data(c);
         *update = true;
         u32::from(c)
@@ -449,7 +449,9 @@ pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         self.read_fifo[slot] = value;
         self.read_count += 1;
         self.flags.set_receive_fifo_empty(false);
+        trace::trace_pl011_fifo_rx_put(value.into(), self.read_count, depth);
         if self.read_count == depth {
+            trace::trace_pl011_fifo_rx_full();
             self.flags.set_receive_fifo_full(true);
         }
 
@@ -518,8 +520,21 @@ unsafe fn init(mut this: ParentInit<Self>) {
         uninit_field_mut!(*this, clock).write(clock);
     }
 
-    const fn clock_update(&self, _event: ClockEvent) {
-        /* pl011_trace_baudrate_change(s); */
+    pub fn trace_baudrate_change(&self, ibrd: u32, fbrd: u32) {
+        let divider = 4.0 / f64::from(ibrd * (FBRD_MASK + 1) + fbrd);
+        let hz = self.clock.get_hz();
+        let rate = if ibrd == 0 {
+            0
+        } else {
+            ((hz as f64) * divider) as u32
+        };
+        trace::trace_pl011_baudrate_change(rate, hz, ibrd, fbrd);
+    }
+
+    fn clock_update(&self, _event: ClockEvent) {
+        let regs = self.regs.borrow();
+        let (ibrd, fbrd) = (regs.ibrd, regs.fbrd);
+        self.trace_baudrate_change(ibrd, fbrd)
     }
 
     pub fn clock_needed(&self) -> bool {
@@ -545,6 +560,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
             }
             Ok(field) => {
                 let (update_irq, result) = self.regs.borrow_mut().read(field);
+                trace::trace_pl011_read(offset, result, c"");
                 if update_irq {
                     self.update();
                     self.char_backend.accept_input();
@@ -559,6 +575,7 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         if let Ok(field) = RegisterOffset::try_from(offset) {
             // qemu_chr_fe_write_all() calls into the can_receive
             // callback, so handle writes before entering PL011Registers.
+            trace::trace_pl011_write(offset, value as u32, c"");
             if field == RegisterOffset::DR {
                 // ??? Check if transmitter is enabled.
                 let ch: [u8; 1] = [value as u8];
@@ -567,10 +584,7 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
                 let _ = self.char_backend.write_all(&ch);
             }
 
-            update_irq = self
-                .regs
-                .borrow_mut()
-                .write(field, value as u32, &self.char_backend);
+            update_irq = self.regs.borrow_mut().write(field, value as u32, &self);
         } else {
             log_mask_ln!(
                 Log::GuestError,
@@ -584,11 +598,19 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
 
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        regs.fifo_depth() - regs.read_count
+        let fifo_available = regs.fifo_depth() - regs.read_count;
+        trace::trace_pl011_can_receive(
+            regs.line_control.into(),
+            regs.read_count,
+            regs.fifo_depth(),
+            fifo_available,
+        );
+        fifo_available
     }
 
     fn receive(&self, buf: &[u8]) {
+        trace::trace_pl011_receive(buf.len());
+
         let mut regs = self.regs.borrow_mut();
         if regs.loopback_enabled() {
             // In loopback mode, the RX input signal is internally disconnected
@@ -637,6 +659,7 @@ fn reset_hold(&self, _type: ResetType) {
     fn update(&self) {
         let regs = self.regs.borrow();
         let flags = regs.int_level & regs.int_enabled;
+        trace::trace_pl011_irq_state(flags != 0);
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
             irq.set(flags.any_set(i));
         }
-- 
2.50.1


