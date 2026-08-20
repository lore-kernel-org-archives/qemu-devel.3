Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038EEC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60K-0002oT-LB; Thu, 20 Aug 2026 12:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60I-0002YJ-Oo
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60F-0005pC-Ou
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMSgXJuuPOqCzd6zANJaFmZthfUPr9EnVE81272P73w=;
 b=PvpYSfRSPaI5HgYMpF3M2qvM2qFOchnTumVK71LqEPDCPoFfyiRt8VWGOZf1H9Eg7HQaW2
 HvwqUxHOwQQ9P6ud5SRoEXcre1023T4W6neBoVnqLS1Mvy8OzDw4PYyv/ZMjKwpZQ9gb+H
 O8ypR8m0MY85NssrHXUbm1HyWIW/C4M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-9HmNva5tP7udjz4hAOyNPg-1; Thu, 20 Aug 2026 12:52:29 -0400
X-MC-Unique: 9HmNva5tP7udjz4hAOyNPg-1
X-Mimecast-MFC-AGG-ID: 9HmNva5tP7udjz4hAOyNPg_1787244748
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496b6f97676so237585e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244748; x=1787849548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JMSgXJuuPOqCzd6zANJaFmZthfUPr9EnVE81272P73w=;
 b=G26NmIqbjWfAK6qGkTQ+LyJ7GtMuuwuNr+Foka3rp5M/+j5Kmk+MhMPECigmIwwOIY
 nFLtZ41xkKndQYVZlKUSVYvZKzdMyTzpv9zDhCncg/8m3Qe4Ng/6AAs/hCHaytVGoHmM
 pnd4RokpYDED4dqMVUWs/BAR6OVsKaxyyJftjbrZDTrwqBYmHij909jQbarPoXtIm/1B
 k6Y8ndap1oQjOlblVsfCW8z5NYL1Kk6QurEk2xTyEwJQBki6wN9PP6UR4zgPNn9miQHu
 XLmfO1WT0wfmfoDPw+3jiJNy2HuaHLDYqYDXpgM45X7dLIQAfrearQjciHqf9RuIZbRW
 MSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244748; x=1787849548;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JMSgXJuuPOqCzd6zANJaFmZthfUPr9EnVE81272P73w=;
 b=UF+rSkOngpSU91Ns3TUdK3KtOVGa1f9GXMnphtNMS+UXL/u8qjExSaQ+wSe1stPEYI
 fqVahXH1DJeLBx/re2jT9wu8iBBUzLdbbppwdsMI44oraxN1XYrmV+OIXmLilBvDVNzs
 jlejPJ5Fkn4KNrUvOkbXHq470ONOk6P70nwDXMba0rs+4OpySBjUAVS9ZYh4P2+1YpXx
 VsetbjDpcif1PJqVt0ROY8IK0Tpt9EtmfVJhEcLULA3wxZ033BZu38hPSJJL7H0zWS9t
 +xRnJIRufNMogjnIp6WxOR6QQ1OBMjnztRu13UrKBT4C9NZhxTLjd1h1S5Rtx07w/pV2
 fi1Q==
X-Gm-Message-State: AOJu0YzkyS13wBaIwQweFilTiZm25MtpkeegvPR5M/8s4btrmp0MVA5x
 zq8V62QBQCvNmwytdxEMf+FRAKP/+pxHjauywNamhPJvO0ffvJ4UPiCDp+muF8c9CaOBpSL/ov/
 9qaQZO3ekC4o/uSSIJ9nF/sQJ//rpJMNuToNP9ApPMx+pJOBcNKjhh/MbveC2HzAaB7Y2D+sm9G
 80wgIKScst+P3rFvXDv0KKuGDNVcJ+YqsBkVdD0pld
X-Gm-Gg: AR+sD11wDTLAGcE8Lr31znabDU/TOrRUABFhJhp0cGjZVOrrA6L21bldU2Tge77VP0/
 p64V6gjNEBUrwZx0oBDalFLXdaR48q8Ec8GbLDUqOE7G0FvLPNJA34/eeMxOMFtTv74nz6WQa81
 3/wv571F9xTtgYscFgyDOp9cw/9uswwC9UbSH9GwS0MbysGel6BY8Rs13qgTQnTwB527tlBsKq5
 Bzr3U/o4tggRlB52yTeblzxLC4VuAl/aozuOf4J9b8oo/rTbuQ8nl/+1/rkkWVcmGPyFekwIoYr
 VXafYklUCBSx29TJ4Imag5cQhOQWcvhhP7WsyPSL1DOqhHFuUonffBQXrD6IOj+chUztGHdu6mZ
 Ui5Qex1RCTwWHeUbZXK7iI2+zmI1yV50PNtZcEjh9jgIcI9PqmM40HYvPdFXj+xMbDgEZFzE1Fh
 pTHh8=
X-Received: by 2002:a05:600c:8508:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-499b84660ffmr3550155e9.9.1787244748030; 
 Thu, 20 Aug 2026 09:52:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8508:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-499b84660ffmr3548805e9.9.1787244747395; 
 Thu, 20 Aug 2026 09:52:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0e473dsm146103905e9.15.2026.08.20.09.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 52/53] rust: pl011: switch from bilge to bitfield-struct
Date: Thu, 20 Aug 2026 18:49:55 +0200
Message-ID: <20260820164957.1895963-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The bilge crate is heavily reliant on traits and, because trait functions
are never const, bilge and const mix about as well as water and oil.
In addition, it has support for the zerocopy crate that only works for an
older version, and is hard to update because the implementation doesn't
like that zerocopy::FromBits and bilge::FromBits are the same name.
zerocopy is definitely something that QEMU could use in the future.

The bitfield-struct crate, instead, is built from the ground up to
support const.  Its use is pretty much the same (device code does not
change at all, only register declarations do), with some things being
more verbose and others being simpler.  The code for the crate itself
is much smaller, too.

It does have two disadvantages: it does not let you annotate enums
as bitfields, and it does not integrate with arbitrary-int.  Thus, it
requires manual size annotations for anything that is not a bool, iNN
or uNN.  Lack of support for arbitrary-int is a very small deal, while
enums are a bit more annoying because they require some repetition
and an implementation of two functions from_bits() and into_bits().
However, the latter is already provided by the "bits!"  and
"#[derive(common::TryInto)]" utilities, and thus is not manual
in QEMU's case.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Cargo.lock                               |  14 ++-
 Cargo.toml                               |   1 +
 rust/hw/char/pl011/Cargo.toml            |   3 +-
 rust/hw/char/pl011/src/registers.rs      | 108 +++++++++++------------
 scripts/archive-source.sh                |   1 +
 scripts/make-release                     |   1 +
 subprojects/.gitignore                   |   1 +
 subprojects/bitfield-struct-0.13-rs.wrap |   6 ++
 8 files changed, 75 insertions(+), 60 deletions(-)
 create mode 100644 subprojects/bitfield-struct-0.13-rs.wrap

diff --git a/Cargo.lock b/Cargo.lock
index 66f684098d3..6f683e8bb1e 100644
--- a/Cargo.lock
+++ b/Cargo.lock
@@ -24,6 +24,17 @@ dependencies = [
  "syn",
 ]
 
+[[package]]
+name = "bitfield-struct"
+version = "0.13.0"
+source = "registry+https://github.com/rust-lang/crates.io-index"
+checksum = "3ca6739863c590881f038d033a146c51ddae239186a4327014839fd864f44ed5"
+dependencies = [
+ "proc-macro2",
+ "quote",
+ "syn",
+]
+
 [[package]]
 name = "bilge"
 version = "0.2.0"
@@ -243,8 +254,7 @@ checksum = "7edddbd0b52d732b21ad9a5fab5c704c14cd949e5e9a1ec5929a24fded1b904c"
 name = "pl011"
 version = "0.1.0"
 dependencies = [
- "bilge",
- "bilge-impl",
+ "bitfield-struct",
  "bits",
  "bql",
  "chardev",
diff --git a/Cargo.toml b/Cargo.toml
index 0566850ecef..b35704faabe 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -101,5 +101,6 @@ used_underscore_binding = "deny"
 #wildcard_imports = "deny"   # still have many bindings::* imports
 
 # these may have false positives
+enum_variant_names = "allow"
 #option_if_let_else = "deny"
 cognitive_complexity = "deny"
diff --git a/rust/hw/char/pl011/Cargo.toml b/rust/hw/char/pl011/Cargo.toml
index 5b319455ee3..d303c241e4f 100644
--- a/rust/hw/char/pl011/Cargo.toml
+++ b/rust/hw/char/pl011/Cargo.toml
@@ -14,8 +14,7 @@ rust-version.workspace = true
 
 [dependencies]
 glib-sys.workspace = true
-bilge = { version = "0.2.0" }
-bilge-impl = { version = "0.2.0" }
+bitfield-struct = { version = "0.13" }
 bits = { path = "../../../bits" }
 common = { path = "../../../common" }
 util = { path = "../../../util" }
diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index fa572811b29..a8ab8ad93dc 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -5,12 +5,16 @@
 //! Device registers exposed as typed structs which are backed by arbitrary
 //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
 
+// rustc prefers "constant-like" enums to use upper case names, but that
+// is inconsistent in its own way.
+#![allow(non_upper_case_globals)]
+
 // For more detail see the PL011 Technical Reference Manual DDI0183:
 // https://developer.arm.com/documentation/ddi0183/latest/
 
-use bilge::prelude::*;
+use bitfield_struct::bitfield;
 use bits::bits;
-use migration::{impl_vmstate_bitsized, impl_vmstate_forward};
+use migration::impl_vmstate_forward;
 
 /// Offset of each register from the base memory address of the device.
 #[doc(alias = "offset")]
@@ -78,14 +82,18 @@ pub enum RegisterOffset {
 /// The `UARTRSR` register is updated only when a read occurs
 /// from the `UARTDR` register with the same status information
 /// that can also be obtained by reading the `UARTDR` register
-#[bitsize(8)]
-#[derive(Clone, Copy, Default, DebugBits, FromBits)]
+#[bitfield(u8)]
 pub struct Errors {
     pub framing_error: bool,
     pub parity_error: bool,
     pub break_error: bool,
     pub overrun_error: bool,
-    _reserved_unpredictable: u4,
+    #[bits(4)]
+    _reserved_unpredictable: u8,
+}
+
+impl Errors {
+    pub const BREAK: Self = Errors::new().with_break_error(true);
 }
 
 /// Data Register, `UARTDR`
@@ -93,19 +101,18 @@ pub struct Errors {
 /// The `UARTDR` register is the data register; write for TX and
 /// read for RX. It is a 12-bit register, where bits 7..0 are the
 /// character and bits 11..8 are error bits.
-#[bitsize(32)]
-#[derive(Clone, Copy, Default, DebugBits, FromBits)]
+#[bitfield(u32)]
 #[doc(alias = "UARTDR")]
 pub struct Data {
     pub data: u8,
+    #[bits(8)]
     pub errors: Errors,
     _reserved: u16,
 }
-impl_vmstate_bitsized!(Data);
+impl_vmstate_forward!(Data);
 
 impl Data {
-    // bilge is not very const-friendly, unfortunately
-    pub const BREAK: Self = Self { value: 1 << 10 };
+    pub const BREAK: Self = Self::new().with_errors(Errors::BREAK);
 }
 
 /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
@@ -119,13 +126,14 @@ impl Data {
 /// and UARTECR for writes, but really it's a single error status
 /// register where writing anything to the register clears the error
 /// bits.
-#[bitsize(32)]
-#[derive(Clone, Copy, DebugBits, FromBits)]
+#[bitfield(u32)]
 pub struct ReceiveStatusErrorClear {
+    #[bits(8)]
     pub errors: Errors,
-    _reserved_unpredictable: u24,
+    #[bits(24)]
+    _reserved_unpredictable: u32,
 }
-impl_vmstate_bitsized!(ReceiveStatusErrorClear);
+impl_vmstate_forward!(ReceiveStatusErrorClear);
 
 impl ReceiveStatusErrorClear {
     pub fn set_from_data(&mut self, data: Data) {
@@ -138,14 +146,7 @@ pub fn reset(&mut self) {
     }
 }
 
-impl Default for ReceiveStatusErrorClear {
-    fn default() -> Self {
-        0.into()
-    }
-}
-
-#[bitsize(32)]
-#[derive(Clone, Copy, DebugBits, FromBits)]
+#[bitfield(u32, default = false)]
 /// Flag Register, `UARTFR`
 ///
 /// This has the usual inbound RS232 modem-control signals, plus flags
@@ -171,9 +172,10 @@ pub struct Flags {
     pub transmit_fifo_empty: bool,
     /// RI: Ring indicator
     pub ring_indicator: bool,
-    _reserved_zero_no_modify: u23,
+    #[bits(23)]
+    _reserved_zero_no_modify: u32,
 }
-impl_vmstate_bitsized!(Flags);
+impl_vmstate_forward!(Flags);
 
 impl Flags {
     pub fn reset(&mut self) {
@@ -183,16 +185,14 @@ pub fn reset(&mut self) {
 
 impl Default for Flags {
     fn default() -> Self {
-        let mut ret: Self = 0.into();
         // After reset TXFF, RXFF, and BUSY are 0, and TXFE and RXFE are 1
-        ret.set_receive_fifo_empty(true);
-        ret.set_transmit_fifo_empty(true);
-        ret
+        Self::from(0)
+            .with_receive_fifo_empty(true)
+            .with_transmit_fifo_empty(true)
     }
 }
 
-#[bitsize(32)]
-#[derive(Clone, Copy, DebugBits, FromBits)]
+#[bitfield(u32)]
 /// Line Control Register, `UARTLCR_H`
 #[doc(alias = "UARTLCR_H")]
 pub struct LineControl {
@@ -201,48 +201,46 @@ pub struct LineControl {
     /// PEN: Parity enable
     pub parity_enabled: bool,
     /// EPS: Even parity select
+    #[bits(1)]
     pub parity: Parity,
     /// STP2: Two stop bits select
     pub two_stops_bits: bool,
     /// FEN: Enable FIFOs
+    #[bits(1)]
     pub fifos_enabled: Mode,
     /// WLEN: Word length in bits
     /// b11 = 8 bits
     /// b10 = 7 bits
     /// b01 = 6 bits
     /// b00 = 5 bits.
+    #[bits(2)]
     pub word_length: WordLength,
     /// SPS Stick parity select
     pub sticky_parity: bool,
     /// 31:8 - Reserved, do not modify, read as zero.
-    _reserved_zero_no_modify: u24,
+    #[bits(24)]
+    _reserved_zero_no_modify: u32,
 }
-impl_vmstate_bitsized!(LineControl);
+impl_vmstate_forward!(LineControl);
 
 impl LineControl {
     pub fn reset(&mut self) {
         // All the bits are cleared to 0 when reset.
-        *self = 0.into();
+        *self = Self::default();
     }
 }
 
-impl Default for LineControl {
-    fn default() -> Self {
-        0.into()
-    }
-}
-
-#[bitsize(1)]
-#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
 /// `EPS` "Even parity select", field of [Line Control
 /// register](LineControl).
+#[repr(u8)]
+#[derive(Clone, Copy, Debug, Eq, PartialEq, common::TryInto)]
 pub enum Parity {
     Odd = 0,
     Even = 1,
 }
 
-#[bitsize(1)]
-#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+#[repr(u8)]
+#[derive(Clone, Copy, Debug, Eq, PartialEq, common::TryInto)]
 /// `FEN` "Enable FIFOs" or Device mode, field of [Line Control
 /// register](LineControl).
 pub enum Mode {
@@ -253,8 +251,8 @@ pub enum Mode {
     FIFO = 1,
 }
 
-#[bitsize(2)]
-#[derive(Clone, Copy, Debug, Eq, FromBits, PartialEq)]
+#[repr(u8)]
+#[derive(Clone, Copy, Debug, Eq, PartialEq, common::TryInto)]
 #[allow(clippy::enum_variant_names)]
 /// `WLEN` Word length, field of [Line Control register](LineControl).
 ///
@@ -276,9 +274,8 @@ pub enum WordLength {
 /// The `UARTCR` register is the control register. It contains various
 /// enable bits, and the bits to write to set the usual outbound RS232
 /// modem control signals. All bits reset to 0 except TXE and RXE.
-#[bitsize(32)]
+#[bitfield(u32, default = false)]
 #[doc(alias = "UARTCR")]
-#[derive(Clone, Copy, DebugBits, FromBits)]
 pub struct Control {
     /// `UARTEN` UART enable: 0 = UART is disabled.
     pub enable_uart: bool,
@@ -286,9 +283,10 @@ pub struct Control {
     /// QEMU does not model this.
     pub enable_sir: bool,
     /// `SIRLP` SIR low-power IrDA mode. QEMU does not model this.
-    pub sir_lowpower_irda_mode: u1,
+    pub sir_lowpower_irda_mode: bool,
     /// Reserved, do not modify, read as zero.
-    _reserved_zero_no_modify: u4,
+    #[bits(4)]
+    _reserved_zero_no_modify: u8,
     /// `LBE` Loopback enable: feed UART output back to the input
     pub enable_loopback: bool,
     /// `TXE` Transmit enable
@@ -310,21 +308,19 @@ pub struct Control {
     /// 31:16 - Reserved, do not modify, read as zero.
     _reserved_zero_no_modify2: u16,
 }
-impl_vmstate_bitsized!(Control);
+impl_vmstate_forward!(Control);
 
 impl Control {
     pub fn reset(&mut self) {
-        *self = 0.into();
-        self.set_enable_receive(true);
-        self.set_enable_transmit(true);
+        *self = Self::default();
     }
 }
 
 impl Default for Control {
     fn default() -> Self {
-        let mut ret: Self = 0.into();
-        ret.reset();
-        ret
+        Self::from(0)
+            .with_enable_receive(true)
+            .with_enable_transmit(true)
     }
 }
 
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index a37acab524e..5d52644df9c 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -34,6 +34,7 @@ subprojects=(
   berkeley-testfloat-3
   bilge-0.2-rs
   bilge-impl-0.2-rs
+  bitfield-0.9-rs
   either-1-rs
   foreign-0.3-rs
   glib-sys-0.21-rs
diff --git a/scripts/make-release b/scripts/make-release
index 5f54b0e7939..fc0dc4bceb8 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -42,6 +42,7 @@ fi
 SUBPROJECTS="libvfio-user keycodemapdb berkeley-softfloat-3
   berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs attrs-0.2-rs bilge-0.2-rs
   bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
+  bilge-impl-0.2-rs bitfield-0.9-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
   libc-0.2-rs probe-0.5-rs proc-macro2-1-rs
   proc-macro-error-1-rs proc-macro-error-attr-1-rs quote-1-rs
   syn-2-rs unicode-ident-1-rs"
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 011ce4dc3b7..984f5865dc8 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -11,6 +11,7 @@
 /attrs-*
 /bilge-*
 /bilge-impl-*
+/bitfield-struct-*
 /either-*
 /foreign-*
 /glib-sys-*
diff --git a/subprojects/bitfield-struct-0.13-rs.wrap b/subprojects/bitfield-struct-0.13-rs.wrap
new file mode 100644
index 00000000000..dcffe0abd83
--- /dev/null
+++ b/subprojects/bitfield-struct-0.13-rs.wrap
@@ -0,0 +1,6 @@
+[wrap-file]
+directory = bitfield-struct-0.13.0
+source_url = https://crates.io/api/v1/crates/bitfield-struct/0.13.0/download
+source_filename = bitfield-struct-0.13.0.tar.gz
+source_hash = 3ca6739863c590881f038d033a146c51ddae239186a4327014839fd864f44ed5
+method = cargo
-- 
2.55.0


