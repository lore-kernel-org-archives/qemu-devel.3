Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9373EE7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOByt-0007BZ-9j; Thu, 19 Dec 2024 03:34:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByr-00070S-Qj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOByp-0005Ht-Sc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8Hmi+GykNL3FXbMwL0qg3+bnuuJSORXl/Ac00UuXSo=;
 b=MF0GdCkV0HIFN+s6JXan9nXV2allKhBfM5FZ2ugdDbuDsaYf+zB27J53SDFanBZrOJ4Bmz
 UpcT2EQCp21Iqp7NAJkfKcI1b6B1/FbuoyapeXmefQJN55LRqObBWP4b6WSpiUtOqkFARt
 8WKKgAo+HQUBgMuoexDq/QjIMjgDwQw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-45JvSyWDOSa7ZlZJ9marNg-1; Thu, 19 Dec 2024 03:33:57 -0500
X-MC-Unique: 45JvSyWDOSa7ZlZJ9marNg-1
X-Mimecast-MFC-AGG-ID: 45JvSyWDOSa7ZlZJ9marNg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3878ad4bf8cso319783f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597235; x=1735202035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8Hmi+GykNL3FXbMwL0qg3+bnuuJSORXl/Ac00UuXSo=;
 b=RXcHtrLfzF0WjyGcjYyvrez7jqT+qdHEIQcoNU6LJ0O8MmFtmRaQ+tOjW5S2FjVyOC
 9p9RLBkcw7smzlriYkz0s02qURbh9qsnflfVjfRSRnYZxkvLb2Jo5GazYveB1Qgom2k8
 zNie2M8FNb3lK3wf+3V977mZj8at8SPg0pvzROWv1tciAZ0u8cKdlEbkjfQf7Sb+2GBF
 d9MsRFC8R61D+8B+12RxKXgbhLtDYk/sED7WKbln43QthV/lPH+WhyBDro1Odo7UemyI
 WYuStZOdpBDZfxpD0WFY3Q/WMhIFmym7pKW67APQyIufFetRiYLDsfI3OlPVY1iaXYEA
 k8OQ==
X-Gm-Message-State: AOJu0YyD7Wa4DI+tlCQyWUmvZuXzFdendG3EQFIq8jQT3698Parxt5cp
 S2ybB1cEWzAqj6pXZ3zw+IITcZ4Scm58IFxE+ZyiuQzQS759vOPHDuxwjD2hfprSjLD8217oPpy
 kWCnNKNGcLTX6KgQwoe2FIj8IofMHaakD8aq+oel1hxqkUmqm/nSBrg8TpxkO4NvRUq2FR6bcaO
 ilHa5S9Qc9ZVid0BSXU2K76WBYIN5enpIFxex0
X-Gm-Gg: ASbGnctbwmmuUxRxxf6vSL8ZJuYPue0tvkc91KaudKw/8+NwGTjtUv41O7A6i7Sfg83
 iE5CQyUdb6PeVJjsGUof3UbG+VLEvPKU2yVmpzmXOjj8UcqHrI6MjlgjzEaON3hQGiajxu4a1rS
 fxFE9CFjT+p5QpkJUuPq/wlpeXQUOdNBPoqgUJvwhREqwn89R3puq2+hgiIcWyfXSl7o/3LUjXR
 9K4Loet00EqIoVxU5X7/GrlgkTGPEqGwamNh5YiZNw/RKsIKAvojsGAj1L5
X-Received: by 2002:a5d:584c:0:b0:385:ea11:dd92 with SMTP id
 ffacd0b85a97d-388e4d42bf8mr5551473f8f.15.1734597235189; 
 Thu, 19 Dec 2024 00:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH7Knlh0i/Tn3orSfT+92gKRmkMzrdmN+3cbZnV6bfuhrz37LsZXrx4DiOgTBM2zyruBOx1Q==
X-Received: by 2002:a5d:584c:0:b0:385:ea11:dd92 with SMTP id
 ffacd0b85a97d-388e4d42bf8mr5551438f8f.15.1734597234665; 
 Thu, 19 Dec 2024 00:33:54 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6e19sm972226f8f.100.2024.12.19.00.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 39/41] rust: pl011: extend registers to 32 bits
Date: Thu, 19 Dec 2024 09:32:26 +0100
Message-ID: <20241219083228.363430-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

The PL011 Technical Reference Manual lists the "real" size of the
registers in table 3-1, and only rounds up to the next byte when
describing the registers; for example, UARTDR is listed as having
width 12/8 (12 bits read, 8 written) and only bits 15:0 are listed
in "Table 3-2 UARTDR Register".

However, in practice these are 32-bit registers, accessible only
through 32-bit MMIO accesses; preserving the fiction that they're
smaller introduces multiple casts (to go from the bilge bitfield
type to e.g u16 to u64) and more importantly it breaks the
migration stream because the Rust vmstate macros are not yet
type safe.

So, just make everything 32-bits wide.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 36 ++++++++++++++------------------
 rust/hw/char/pl011/src/lib.rs    | 23 +++++++++-----------
 2 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5e3a9c6f581..090e5d64504 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -186,9 +186,9 @@ unsafe fn init(&mut self) {
     pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
 
-        std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
+        let value = match RegisterOffset::try_from(offset) {
             Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
-                u64::from(self.device_id[(offset - 0xfe0) >> 2])
+                u32::from(self.device_id[(offset - 0xfe0) >> 2])
             }
             Err(_) => {
                 // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
@@ -214,27 +214,25 @@ pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u
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
@@ -276,7 +274,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
                 self.fbrd = value;
             }
             Ok(LCR_H) => {
-                let value = value as u16;
                 let new_val: registers::LineControl = value.into();
                 // Reset the FIFO state on FIFO enable or disable
                 if bool::from(self.line_control.fifos_enabled())
@@ -303,7 +300,6 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
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


