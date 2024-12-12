Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE194E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 17:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLmtb-0006sH-VA; Thu, 12 Dec 2024 12:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtW-0006ps-Ch
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLmtS-0006oB-6B
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 12:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734024149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KHVqWO/pCUdfAOY6uDFnWMq+tGNU/At5wYKHm8JQJsI=;
 b=jTFW0sJWwtc3URQhmJP8PYdI/Oh/mo+gjZJN9hNfNufhTHQLqm5qJMT+gvOv8NCMlST3O4
 d0WqNXgP1cqGoFVm/HOdbpFPfGCgwYDIqTwDTQRtPk7ICgCso14XULupgB/ry+56X4p5Ez
 EPe6gsGUlBgyBbHouQWtwoLMzjawph4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-1hS0ErUeM1Gzc1ZtYIgQhw-1; Thu, 12 Dec 2024 12:22:27 -0500
X-MC-Unique: 1hS0ErUeM1Gzc1ZtYIgQhw-1
X-Mimecast-MFC-AGG-ID: 1hS0ErUeM1Gzc1ZtYIgQhw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43610eba55bso7942685e9.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 09:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734024145; x=1734628945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHVqWO/pCUdfAOY6uDFnWMq+tGNU/At5wYKHm8JQJsI=;
 b=XxDBfsOWGFiPMbIfVBArx7tkJQOdDqYNRb47A66I18rXVMwrkz4LXzgXyKatl6bNg0
 HS3EiMzcHc6YWhmUT7sbjxkhrngqJ+ibduYnvmHIidTdtJepvtR3ZpNH8zOQGBQX5XlK
 2bRcla9JrAv3p812YqrqIuVJLdjilA4NKzNgm2h7cHdbFG0aR2fPqVz1wAjk1c9EbqP8
 9Kv4lyvXlsfuqw1ra5QR5+Eos3DWvqdsxMjvPGXKvH8hvgS4rdL90xtidVkRbEMGMhex
 4K/3quxaYASQUSv4A0Ia4P1U5n3BrEZyynGBC4A5d9SwD4mCZp6y+l1o/MmxoCxotFIS
 hjfw==
X-Gm-Message-State: AOJu0YxLpc3je2NZRRICwznZpd3F7jcGRS9X9LGCwvvwHYcDajrnp7Ao
 tio0+4KL9CS4Xly6yGhJe18OrkBW0fnXgvsaTZU/4U3Lhk4sqsWf+/wgSAo7R6mk7PFc8/ge56H
 e0cG+gCs/0vDAhDH6+ah5hz4uGolhDI/gtXsx0+qb9TPuISPz1NRlBIM2qMzddtW/MB5CNP3uCX
 qjO3yDcQasbOeNJwh4PLOts0FXdW8jVUHcvESN
X-Gm-Gg: ASbGncvadW9f9Y1JEaY1Ai9cx4mvxVsuLWSh+12j/L4YSrlQAgB0VMx8+g8GZYqN1qM
 i666Lcpabf2jkF6boKZwGw3DhWxGOJ2lmYoL/E8gnRqlqRUtjqxsX5T0Ht1e7tKZJHvHIgOULUG
 YrYFpSTFFEm0igdnBzpaUZS+fg57Y5JPJK3muQnYuvvseUf35G/Ht5cHJOCV1TK/gu8RO2KI/Qo
 GATm0varU0QmNKvTm1V5zx/jO+i7P73fbycUdvtQttxZwV7HypelyoGCWjk
X-Received: by 2002:a05:600c:4e49:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-43622883cd8mr37848665e9.33.1734024145098; 
 Thu, 12 Dec 2024 09:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPtuQ9i7Q5Wttof82EifUn50vzbZkbe6+LFSMkXywkQw18sj1mp8gRfekBMl6pkeLXWAnpZg==
X-Received: by 2002:a05:600c:4e49:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-43622883cd8mr37848415e9.33.1734024144601; 
 Thu, 12 Dec 2024 09:22:24 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c6c2sm22187865e9.16.2024.12.12.09.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 09:22:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	qemu-rust@nongnu.org
Subject: [PATCH 5/7] rust: pl011: extend registers to 32 bits
Date: Thu, 12 Dec 2024 18:22:02 +0100
Message-ID: <20241212172209.533779-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212172209.533779-1-pbonzini@redhat.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The PL011 Technical Reference Manual lists the "real" size of the
registers in table 3-1, and only rounds up to the next byte when
describing the registers; for example, UARTDR is listed as having
width 12/8 (12 bits read, 8 written) and only bits 15:0 are listed
in "Table 3-2 UARTDR Register".

However, in practice these are 32-bit registers, accessible only
through 32-bit MMIO accesses; preserving the fiction that they're
smaller introduces multiple casts (to go from the bilge bitfield
type to e.g u16 to u64) and more importantly it breaks the
migration stream (though only on big-endian machines) because
the Rust vmstate macros are not yet type safe.

So, just make everything 32-bits wide.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 36 ++++++++++++++------------------
 rust/hw/char/pl011/src/lib.rs    | 23 +++++++++-----------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index e88ea24b00e..332e0a31a82 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -190,10 +190,10 @@ unsafe fn init(&mut self) {
     pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
 
-        std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
+        let value = match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
                 let device_id = self.get_class().device_id;
-                u64::from(device_id[(offset - 0xfe0) >> 2])
+                u32::from(device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
@@ -219,27 +219,25 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
                 let c = u32::from(c);
                 return std::ops::ControlFlow::Continue(u64::from(c));
             }
-            Ok(RSR) => u8::from(self.receive_status_error_clear).into(),
-            Ok(FR) => u16::from(self.flags).into(),
-            Ok(FBRD) => self.fbrd.into(),
-            Ok(ILPR) => self.ilpr.into(),
-            Ok(IBRD) => self.ibrd.into(),
-            Ok(LCR_H) => u16::from(self.line_control).into(),
-            Ok(CR) => {
-                // We exercise our self-control.
-                u16::from(self.control).into()
-            }
-            Ok(FLS) => self.ifl.into(),
-            Ok(IMSC) => self.int_enabled.into(),
-            Ok(RIS) => self.int_level.into(),
-            Ok(MIS) => u64::from(self.int_level & self.int_enabled),
+            Ok(RSR) => u32::from(self.receive_status_error_clear),
+            Ok(FR) => u32::from(self.flags),
+            Ok(FBRD) => self.fbrd,
+            Ok(ILPR) => self.ilpr,
+            Ok(IBRD) => self.ibrd,
+            Ok(LCR_H) => u32::from(self.line_control),
+            Ok(CR) => u32::from(self.control),
+            Ok(FLS) => self.ifl,
+            Ok(IMSC) => self.int_enabled,
+            Ok(RIS) => self.int_level,
+            Ok(MIS) => self.int_level & self.int_enabled,
             Ok(ICR) => {
                 // "The UARTICR Register is the interrupt clear register and is write-only"
                 // Source: ARM DDI 0183G 3.3.13 Interrupt Clear Register, UARTICR
                 0
             }
-            Ok(DMACR) => self.dmacr.into(),
-        })
+            Ok(DMACR) => self.dmacr,
+        };
+        std::ops::ControlFlow::Break(value.into())
     }
 
     pub fn write(&mut self, offset: hwaddr, value: u64) {
@@ -281,7 +279,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.fbrd = value;
             }
             Ok(LCR_H) => {
-                let value = value as u16;
                 let new_val: registers::LineControl = value.into();
                 // Reset the FIFO state on FIFO enable or disable
                 if bool::from(self.line_control.fifos_enabled())
@@ -308,7 +305,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
             }
             Ok(CR) => {
                 // ??? Need to implement the enable bit.
-                let value = value as u16;
                 self.control = value.into();
                 self.loopback_mdmctrl();
             }
diff --git a/rust/hw/char/pl011/src/lib.rs b/rust/hw/char/pl011/src/lib.rs
index 463ae60543b..0747e130cae 100644
--- a/rust/hw/char/pl011/src/lib.rs
+++ b/rust/hw/char/pl011/src/lib.rs
@@ -131,12 +131,6 @@ const fn _assert_exhaustive(val: RegisterOffset) {
 pub mod registers {
     //! Device registers exposed as typed structs which are backed by arbitrary
     //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
-    //!
-    //! All PL011 registers are essentially 32-bit wide, but are typed here as
-    //! bitmaps with only the necessary width. That is, if a struct bitmap
-    //! in this module is for example 16 bits long, it should be conceived
-    //! as a 32-bit register where the unmentioned higher bits are always
-    //! unused thus treated as zero when read or written.
     use bilge::prelude::*;
 
     /// Receive Status Register / Data Register common error bits
@@ -234,10 +228,11 @@ impl Data {
     /// # Source
     /// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register,
     /// UARTRSR/UARTECR
-    #[bitsize(8)]
+    #[bitsize(32)]
     #[derive(Clone, Copy, DebugBits, FromBits)]
     pub struct ReceiveStatusErrorClear {
         pub errors: Errors,
+        _reserved_unpredictable: u24,
     }
 
     impl ReceiveStatusErrorClear {
@@ -257,7 +252,7 @@ fn default() -> Self {
         }
     }
 
-    #[bitsize(16)]
+    #[bitsize(32)]
     #[derive(Clone, Copy, DebugBits, FromBits)]
     /// Flag Register, `UARTFR`
     #[doc(alias = "UARTFR")]
@@ -309,7 +304,7 @@ pub struct Flags {
         pub transmit_fifo_empty: bool,
         /// `RI`, is `true` when `nUARTRI` is `LOW`.
         pub ring_indicator: bool,
-        _reserved_zero_no_modify: u7,
+        _reserved_zero_no_modify: u23,
     }
 
     impl Flags {
@@ -328,7 +323,7 @@ fn default() -> Self {
         }
     }
 
-    #[bitsize(16)]
+    #[bitsize(32)]
     #[derive(Clone, Copy, DebugBits, FromBits)]
     /// Line Control Register, `UARTLCR_H`
     #[doc(alias = "UARTLCR_H")]
@@ -382,8 +377,8 @@ pub struct LineControl {
         /// the PEN bit disables parity checking and generation. See Table 3-11
         /// on page 3-14 for the parity truth table.
         pub sticky_parity: bool,
-        /// 15:8 - Reserved, do not modify, read as zero.
-        _reserved_zero_no_modify: u8,
+        /// 31:8 - Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify: u24,
     }
 
     impl LineControl {
@@ -454,7 +449,7 @@ pub enum WordLength {
     ///
     /// # Source
     /// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
-    #[bitsize(16)]
+    #[bitsize(32)]
     #[doc(alias = "UARTCR")]
     #[derive(Clone, Copy, DebugBits, FromBits)]
     pub struct Control {
@@ -532,6 +527,8 @@ pub struct Control {
         /// CTS hardware flow control is enabled. Data is only transmitted when
         /// the `nUARTCTS` signal is asserted.
         pub cts_hardware_flow_control_enable: bool,
+        /// 31:16 - Reserved, do not modify, read as zero.
+        _reserved_zero_no_modify2: u16,
     }
 
     impl Control {
-- 
2.47.1


