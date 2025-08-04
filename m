Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D560BC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwwi-0006ME-3M; Mon, 04 Aug 2025 11:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXT-0005u4-6o
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:48 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uivXQ-0002a8-QY
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:47:42 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60bfcada295so5375219a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754315259; x=1754920059; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1g36ux8HgAALY4gkuyvI7RgM/186e9wJyZv+KvDnUw=;
 b=udg3GRWZkj+aJ36V+naVfRbgT3IQ8czsPuJcWtLxW0+5yhRPt2HVyYLXwoLfIifbPV
 JGgQGPArIf73VUB0Q7ivFqtXKT67oX4WOkLDCC4rli+TdV3+d5Hx7tsWDSG+OYjdvoVr
 OwkXxkaQiwIyX+OzKy07ugw7uOGioCd4KfBREfPnHVkn/qiynJgDe567iCuTP5CWNm96
 F9MM5+BkHNSk/ZOduhjdnIhQjCQ9JoxDEW0qDfZra5jEwLND5kOYMiR7igQe09LKi5Ui
 c9nLtR56UFTQJJdIQAmOn2Ty/q5AMjFhVorZEl9wKI+5DAGIGEDqFtZYJvVhCyLiPidA
 hi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754315259; x=1754920059;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1g36ux8HgAALY4gkuyvI7RgM/186e9wJyZv+KvDnUw=;
 b=lKIKROInFARxDgycnH6OlvE3sxpE7Gr/j3+YyDkFd+np+Ys2BjqGW2Z6IUNhqxrsF4
 SZcof2KwoHJiRLaA5WFuvgftKm1TJ6FWuLwIF3LgaJc937W6ofEvszIb4Tq1LIeg+ia8
 bC9SXFJudkrvI0I7XK11UHPqDY5F13va+sOH50TZuOYC5M5+ZMr7iXablMNfGw0Iuxu1
 rcLUS5jxHtQl3BvVy8D6/78SNEXXvonLvnJl704XlusAocYl9tL581E14YPNyZjY2iRw
 V648Hs1sy+eWUDBIgPq4NsHcFnUnF5jq9x0X2jd3teJOCmYcY2yjLBQwyQzf8W9FTZC7
 Z2+A==
X-Gm-Message-State: AOJu0YxsaUKs7prixXEJoM7CtgN3qW0Z3OcnVeOogJowwKRdfSdOU18x
 Jrznfa11+dPf2/daB/jDop742wEu8g2YwShJJk41N6jmy6p2jcJcZlMXQtcNo771epQ=
X-Gm-Gg: ASbGnct9aT1LLAtHrYqXPKNKwkuRQTrnEC/juXOl/2/SGjYqU/QGzXVhO+22EByTz73
 /6afQQsJr4sLfoqUf28dfWZjbfu/7DJ/HaiApytfv/CFTV0n+CYVno7dbRy6VjkHs7ahyYpCXwK
 fihBw/UiGJGSM0XyYYS5HRlTW2csY8Jb+6ZaUTvi+bAsOd3iaZrNKKnxiemLjEtDrg+hpSBwd9S
 Xj2YMPv8ocYFgcfnmJK3SqhD3cKDa3PDBZTmnYLlrI/Ig5Te0MdSQTKwse0jjLRS2uwbXGpJjQM
 kNEyBLX7vhWkSJRPOHoHOliJ1j68l8WEaxxkcmuKtBB16SJKsP08AWkO5GkzCtnlIp9YbVhqksD
 twTLPLdsu3SVH3puclvjtVxf0HggSAY0+KpSVAUywvw8LIFDU4PFrjV0ZoSazsvwt9O09D4Dt4f
 619A==
X-Google-Smtp-Source: AGHT+IG8RGCFgCO3yKf/C4CrEzwJw6XCNTEZUrEz1pBa3Fy5V8qkNipd/L5tFzj5jNMO1TyvnnzIXw==
X-Received: by 2002:a05:6402:234b:b0:602:241c:345 with SMTP id
 4fb4d7f45d1cf-615e73873bcmr8241457a12.23.1754315259075; 
 Mon, 04 Aug 2025 06:47:39 -0700 (PDT)
Received: from [127.0.1.1] (athedsl-4441708.home.otenet.gr. [79.129.182.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-615a8f15d9fsm6850590a12.17.2025.08.04.06.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:47:38 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 04 Aug 2025 16:47:18 +0300
Subject: [PATCH RFC 5/5] rust/pl011: add trace events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-rust_trace-v1-5-b20cc16b0c51@linaro.org>
References: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
In-Reply-To: <20250804-rust_trace-v1-0-b20cc16b0c51@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 alex.bennee@linaro.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5557;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=kom9/VHSo8s+yoYa39OFIN1NNX+OksayFdjf0XxvDuE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9rTG4wNmtmT3dyU1VpbGp3alFaeFIwcnpFNmdvCndld3ZFUk5iYnVwaDlTckUx
 NW1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUpDNTlBQUt
 DUkIzS2Nkd2YzNEowRXdGRC85QUphYzhuMm1kTFRGRS9sRXQwdExqcG45Y2xlWlJYbjAxazFsVw
 pEanpaZFhFU0t0MEIrUXBRTXk4dVp5R3hsOEM0ajFETXpXaWVGNnVuUjFiTlhaZGFVUHM1d3JKa
 k5od2hHTXdmCmtoeTNrUTFRRm9RbDlveXEvTTA5N0ZtU2RFQm5kY0U2c25qZFdqWHVOdEplOXJN
 Q0ZkMHQ2M1ExeXZuVTExaE4KVEt5R2YyeHp5SHJqK3M2QkxxdEtHUFNOc1V4QXF2R1BlTEdlWlh
 6eXFsOEwraWZNdkR5OGhIR0hEVFIySzdNOQphalcyWURXZDM2VnRFYTMrajJha2lDdmRXY0dEQz
 VJeVo0NExMaGYwa2htYzlsbTNRamRPZ0QrTHZRWFpqUW1JCmlKMmZnSERhTG1kQmNNeER1ZHVia
 XR4NHBjdmtrbHZPMm1yNUNwWUo2U1NQYkdsNDRhQWJVN3FzQmFxWFpVMkoKM3dwbDB4VEVBc3JU
 a3pWc0FVL3NoUG5VVGp5UHRGZ2E2cHBrbFBQOWxMVUpFS0FIdGVxbmxyem1UMG1McC9jawpocUt
 kNU1EOWtncFg3YWxKeXQwRmVFWVdxYjY0MytCOXJTcjFzNW5kY3VsTWlTRmFzSVZ1Q0U4MnFKSm
 RSZnBNCm1Mb040QkhlVW10c2V1M0VmSlJFYk1MNEpwMVVSWVZieXZyT1pCR2tqa1gzMEQ5bEJWM
 1NuNmZ1ZkxleWtEdG0KQ0V3elhKT3B6aTZ5aHNzTk92N0xSUnBkTXY3Um9yUVVYYzBzUWRvYzVy
 NWROeFVTQ01MUzdpM1dNOXpKWGFOdwpBYWZnSTlqTjk5RytxLzNJVGpGQzZNbG9xRFlUK0VxcWN
 1OUhtTXBWcmp1V21jV3R2UzF6Rnl4bkt5Nm9wTkc1CjBhVkNRQT09Cj04S3ZLCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add all C trace events (missing: baudrate)

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 rust/hw/char/pl011/src/device.rs | 28 +++++++++++++++++++++++---
 rust/hw/char/pl011/src/lib.rs    | 43 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index ceb71dd99b661b9f4da98f2dbabe18e82142035b..dabb4ffb5ed0b2df388ca266d3b549fe9cf6d7bc 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -27,7 +27,14 @@
     zeroable::Zeroable,
 };
 
-use crate::registers::{self, Interrupt, RegisterOffset};
+use crate::{
+    registers::{self, Interrupt, RegisterOffset},
+    trace_events::{
+        trace_pl011_can_receive, trace_pl011_fifo_rx_full, trace_pl011_fifo_rx_put,
+        trace_pl011_irq_state, trace_pl011_read, trace_pl011_read_fifo, trace_pl011_receive,
+        trace_pl011_write,
+    },
+};
 
 // TODO: You must disable the UART before any of the control registers are
 // reprogrammed. When the UART is disabled in the middle of transmission or
@@ -305,6 +312,7 @@ fn read_data_register(&mut self, update: &mut bool) -> u32 {
         }
         self.receive_status_error_clear.set_from_data(c);
         *update = true;
+        trace_pl011_read_fifo!(self.read_count, self.fifo_depth());
         u32::from(c)
     }
 
@@ -458,7 +466,9 @@ pub fn fifo_rx_put(&mut self, value: registers::Data) -> bool {
         self.read_fifo[slot] = value;
         self.read_count += 1;
         self.flags.set_receive_fifo_empty(false);
+        trace_pl011_fifo_rx_put!(value.into(), self.read_count, depth);
         if self.read_count == depth {
+            trace_pl011_fifo_rx_full!();
             self.flags.set_receive_fifo_full(true);
         }
 
@@ -554,6 +564,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
                     self.update();
                     self.char_backend.accept_input();
                 }
+                trace_pl011_read!(offset, result, field);
                 result.into()
             }
         }
@@ -562,6 +573,7 @@ fn read(&self, offset: hwaddr, _size: u32) -> u64 {
     fn write(&self, offset: hwaddr, value: u64, _size: u32) {
         let mut update_irq = false;
         if let Ok(field) = RegisterOffset::try_from(offset) {
+            trace_pl011_write!(offset, value, field);
             // qemu_chr_fe_write_all() calls into the can_receive
             // callback, so handle writes before entering PL011Registers.
             if field == RegisterOffset::DR {
@@ -589,11 +601,20 @@ fn write(&self, offset: hwaddr, value: u64, _size: u32) {
 
     fn can_receive(&self) -> u32 {
         let regs = self.regs.borrow();
-        // trace_pl011_can_receive(s->lcr, s->read_count, r);
-        regs.fifo_depth() - regs.read_count
+        let fifo_depth = regs.fifo_depth();
+        let fifo_available = fifo_depth - regs.read_count;
+
+        trace_pl011_can_receive!(
+            regs.line_control.into(),
+            regs.read_count,
+            fifo_depth,
+            fifo_available
+        );
+        fifo_available
     }
 
     fn receive(&self, buf: &[u8]) {
+        trace_pl011_receive!(buf.len());
         let mut regs = self.regs.borrow_mut();
         if regs.loopback_enabled() {
             // In loopback mode, the RX input signal is internally disconnected
@@ -642,6 +663,7 @@ fn reset_hold(&self, _type: ResetType) {
     fn update(&self) {
         let regs = self.regs.borrow();
         let flags = regs.int_level & regs.int_enabled;
+        trace_pl011_irq_state!((flags != 0).into());
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
             irq.set(flags.any_set(i));
         }
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 2b70d2ff5604179b367b91cbcfdbf9480fa30180..ecfbad27c80fc551a2ced2f9cfe2109b9142e26a 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -19,3 +19,46 @@
 
 pub const TYPE_PL011: &::std::ffi::CStr = c"pl011";
 pub const TYPE_PL011_LUMINARY: &::std::ffi::CStr = c"pl011_luminary";
+
+#[qemu_api_macros::trace_events]
+pub mod trace_events {
+    fn pl011_irq_state(level: u32) {
+        "irq state {level}"
+    }
+
+    fn pl011_read(
+        addr: qemu_api::memory::hwaddr,
+        value: u32,
+        regname: crate::registers::RegisterOffset,
+    ) {
+        "addr {addr:#x} value {value:#x} reg {regname:?}"
+    }
+
+    fn pl011_read_fifo(rx_fifo_used: u32, rx_fifo_depth: u32) {
+        "RX FIFO read, used {rx_fifo_used}/{rx_fifo_depth}"
+    }
+
+    fn pl011_write(
+        addr: qemu_api::memory::hwaddr,
+        value: u64,
+        regname: crate::registers::RegisterOffset,
+    ) {
+        "addr {addr:#x} value {value:#x} reg {regname:?}"
+    }
+
+    fn pl011_can_receive(lcr: u32, rx_fifo_used: u32, rx_fifo_depth: u32, rx_fifo_available: u32) {
+        "LCR {lcr:#x}, RX FIFO used {rx_fifo_used}/{rx_fifo_depth}, can_receive {rx_fifo_available} chars"
+    }
+
+    fn pl011_fifo_rx_put(c: u32, read_count: u32, rx_fifo_depth: u32) {
+        "RX FIFO push char [{c:#x}] {read_count}/{rx_fifo_depth} depth used"
+    }
+
+    fn pl011_fifo_rx_full() {
+        "RX FIFO now full, RXFF set"
+    }
+
+    fn pl011_receive(size: usize) {
+        "recv {size} chars"
+    }
+}

-- 
2.47.2


