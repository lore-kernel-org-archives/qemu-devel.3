Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9DFC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmy-0004Oj-GV; Thu, 15 May 2025 06:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmw-0004OH-EU
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmt-00088D-0Q
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso6413025e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304761; x=1747909561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=51BFccdTXBVY20jOsT7VzsPgWHsL1ys8mbXjW7Ru+Ls=;
 b=IAm5H0ZjYnn57BryjDlo9/fZ9eqpb5ORgLIeZ8p2h+n/bVUGs9W027i7Pf7vFazbyv
 QtdvVhyZEE0BwzHRXb9+tTQteGjkX9+PhEsYhIOaQerw2DZo7m4RD1IRzjvkCCyvgNyJ
 Hu6BY6vSFgMNv2XdnfsvIftdNRX4M1bzz+L2nzlN7yjlNn5PcJivSYk5Con0n6DdtslC
 XSEZt7iFFB3VrZW9HMGbtHbNgHay8C+v1qDGWPAS2mfcgbLG8/FGXW0yl8Tbgc32A0Rr
 qWS0u5DknMzyc9xQY99DGdC8R05ZlHAWHQOj9008jy+WyJTFpMQXA5tfZV5Fv0jHmebx
 aWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304761; x=1747909561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51BFccdTXBVY20jOsT7VzsPgWHsL1ys8mbXjW7Ru+Ls=;
 b=UZ6Igclj5Zhiif0aHAGdM55xwfbOTDWfk7NVbAIodDQVnQOjbBcdNl2OijPTV+Tr80
 45iAN8fAPE9Vyvk9sSpssRjsCLsgwYx0ogfYsxEux5JmUFHvPZeeePZWBsW9xsWcU5HO
 MUogimV66NyfMULUHxMwhhdjoaYy1C+Y/FFbmBFLDpaafM+VPWdIIKT/dek/ieSdqHp9
 mSiJ2LoDqI+XwPFPTd5n7H94qDOrSd9X6RlgvAqKqfcqlwSJyV0ZY0U+JIBZCG1edC7O
 KE31R74VHJknR2nLxze94Gstwv4QONlIgYEljXk7UaLq8VTGoMrVIBi830Q6ORio9MtU
 OGkA==
X-Gm-Message-State: AOJu0YzXae92zfr/B/+5zsAusUkEigi2oGiQmjAe/i5uhtnZNQkRGaDF
 Ujl+uOEZTNFCwgU4pckIP1PgUWFlUmnsrPI0QZ+/uLu0J5ZM6+r09LasXsy1inPDvrEvjXsGGR1
 XUZk=
X-Gm-Gg: ASbGncvgwFk8gvDV2pKLg998JcJYJY86vITLfcEOng4Kujy8eKoKJzHuLdnYEOabW7R
 i3WStMqdhF2mEYioYCKbHWNe9ZFzsPaQ85Xk4wVpY4x/fS7jglgTxICv2bHNv0oAbcIZ/gqIoq7
 vEnvxhkrynGEIstjpkQbyqBh+ZnWHZlnDk9jHauJbJnLGepMjsVKWxVL7dHVqFEOlA42G4mfkQg
 /RRttm0dGaGoCS2XWMK5xNUSF7Xcs1oUcpSR2gOX5Ec84NCP2sqGveBil4es9O3Og/w2lcKkavW
 xodbdFq1swkTEDtD5zPwtAADhH9wfVwMOeVvUC9qiyU2zy82oLiypS7duA==
X-Google-Smtp-Source: AGHT+IG7EvUJAdjdTwTQ9lfWlJCWNnGsh9vII/srXMBGlya3+3T3dVV2CEFBmbKM6xgXZVO7Dd+2Ng==
X-Received: by 2002:a05:600c:1f14:b0:442:e147:bea6 with SMTP id
 5b1f17b1804b1-442fa3fe0f5mr14525315e9.11.1747304760617; 
 Thu, 15 May 2025 03:26:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/58] rust: pl011: Cut down amount of text quoted from PL011
 TRM
Date: Thu, 15 May 2025 11:24:56 +0100
Message-ID: <20250515102546.2149601-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Currently the comments in the Rust pl011 register.rs file include
large amounts of text from the PL011 TRM.  This is much more
commentary than we typically quote from a device reference manual,
and much of it is not relevant to QEMU.  Compress and rephrase the
comments so that we are not quoting such a large volume of TRM text.

We add a URL for the TRM; readers who need more detail on the
function of the register bits can find it there, presented in
context with the overall description of the hardware.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 rust/hw/char/pl011/src/registers.rs | 261 ++++++----------------------
 1 file changed, 51 insertions(+), 210 deletions(-)

diff --git a/rust/hw/char/pl011/src/registers.rs b/rust/hw/char/pl011/src/registers.rs
index cd92fa2c300..690feb63785 100644
--- a/rust/hw/char/pl011/src/registers.rs
+++ b/rust/hw/char/pl011/src/registers.rs
@@ -5,13 +5,13 @@
 //! Device registers exposed as typed structs which are backed by arbitrary
 //! integer bitmaps. [`Data`], [`Control`], [`LineControl`], etc.
 
+// For more detail see the PL011 Technical Reference Manual DDI0183:
+// https://developer.arm.com/documentation/ddi0183/latest/
+
 use bilge::prelude::*;
 use qemu_api::impl_vmstate_bitsized;
 
 /// Offset of each register from the base memory address of the device.
-///
-/// # Source
-/// ARM DDI 0183G, Table 3-1 p.3-3
 #[doc(alias = "offset")]
 #[allow(non_camel_case_types)]
 #[repr(u64)]
@@ -87,48 +87,11 @@ pub struct Errors {
     _reserved_unpredictable: u4,
 }
 
-// TODO: FIFO Mode has different semantics
 /// Data Register, `UARTDR`
 ///
-/// The `UARTDR` register is the data register.
-///
-/// For words to be transmitted:
-///
-/// - if the FIFOs are enabled, data written to this location is pushed onto the
-///   transmit
-/// FIFO
-/// - if the FIFOs are not enabled, data is stored in the transmitter holding
-///   register (the
-/// bottom word of the transmit FIFO).
-///
-/// The write operation initiates transmission from the UART. The data is
-/// prefixed with a start bit, appended with the appropriate parity bit
-/// (if parity is enabled), and a stop bit. The resultant word is then
-/// transmitted.
-///
-/// For received words:
-///
-/// - if the FIFOs are enabled, the data byte and the 4-bit status (break,
-///   frame, parity,
-/// and overrun) is pushed onto the 12-bit wide receive FIFO
-/// - if the FIFOs are not enabled, the data byte and status are stored in the
-///   receiving
-/// holding register (the bottom word of the receive FIFO).
-///
-/// The received data byte is read by performing reads from the `UARTDR`
-/// register along with the corresponding status information. The status
-/// information can also be read by a read of the `UARTRSR/UARTECR`
-/// register.
-///
-/// # Note
-///
-/// You must disable the UART before any of the control registers are
-/// reprogrammed. When the UART is disabled in the middle of
-/// transmission or reception, it completes the current character before
-/// stopping.
-///
-/// # Source
-/// ARM DDI 0183G 3.3.1 Data Register, UARTDR
+/// The `UARTDR` register is the data register; write for TX and
+/// read for RX. It is a 12-bit register, where bits 7..0 are the
+/// character and bits 11..8 are error bits.
 #[bitsize(32)]
 #[derive(Clone, Copy, Default, DebugBits, FromBits)]
 #[doc(alias = "UARTDR")]
@@ -144,30 +107,17 @@ impl Data {
     pub const BREAK: Self = Self { value: 1 << 10 };
 }
 
-// TODO: FIFO Mode has different semantics
 /// Receive Status Register / Error Clear Register, `UARTRSR/UARTECR`
 ///
-/// The UARTRSR/UARTECR register is the receive status register/error clear
-/// register. Receive status can also be read from the `UARTRSR`
-/// register. If the status is read from this register, then the status
-/// information for break, framing and parity corresponds to the
-/// data character read from the [Data register](Data), `UARTDR` prior to
-/// reading the UARTRSR register. The status information for overrun is
-/// set immediately when an overrun condition occurs.
+/// This register provides a different way to read the four receive
+/// status error bits that can be found in bits 11..8 of the UARTDR
+/// on a read. It gets updated when the guest reads UARTDR, and the
+/// status bits correspond to that character that was just read.
 ///
-///
-/// # Note
-/// The received data character must be read first from the [Data
-/// Register](Data), `UARTDR` before reading the error status associated
-/// with that data character from the `UARTRSR` register. This read
-/// sequence cannot be reversed, because the `UARTRSR` register is
-/// updated only when a read occurs from the `UARTDR` register. However,
-/// the status information can also be obtained by reading the `UARTDR`
-/// register
-///
-/// # Source
-/// ARM DDI 0183G 3.3.2 Receive Status Register/Error Clear Register,
-/// UARTRSR/UARTECR
+/// The TRM confusingly describes this offset as UARTRSR for reads
+/// and UARTECR for writes, but really it's a single error status
+/// register where writing anything to the register clears the error
+/// bits.
 #[bitsize(32)]
 #[derive(Clone, Copy, DebugBits, FromBits)]
 pub struct ReceiveStatusErrorClear {
@@ -196,54 +146,29 @@ fn default() -> Self {
 #[bitsize(32)]
 #[derive(Clone, Copy, DebugBits, FromBits)]
 /// Flag Register, `UARTFR`
+///
+/// This has the usual inbound RS232 modem-control signals, plus flags
+/// for RX and TX FIFO fill levels and a BUSY flag.
 #[doc(alias = "UARTFR")]
 pub struct Flags {
-    /// CTS Clear to send. This bit is the complement of the UART clear to
-    /// send, `nUARTCTS`, modem status input. That is, the bit is 1
-    /// when `nUARTCTS` is LOW.
+    /// CTS: Clear to send
     pub clear_to_send: bool,
-    /// DSR Data set ready. This bit is the complement of the UART data set
-    /// ready, `nUARTDSR`, modem status input. That is, the bit is 1 when
-    /// `nUARTDSR` is LOW.
+    /// DSR: Data set ready
     pub data_set_ready: bool,
-    /// DCD Data carrier detect. This bit is the complement of the UART data
-    /// carrier detect, `nUARTDCD`, modem status input. That is, the bit is
-    /// 1 when `nUARTDCD` is LOW.
+    /// DCD: Data carrier detect
     pub data_carrier_detect: bool,
-    /// BUSY UART busy. If this bit is set to 1, the UART is busy
-    /// transmitting data. This bit remains set until the complete
-    /// byte, including all the stop bits, has been sent from the
-    /// shift register. This bit is set as soon as the transmit FIFO
-    /// becomes non-empty, regardless of whether the UART is enabled
-    /// or not.
+    /// BUSY: UART busy. In real hardware, set while the UART is
+    /// busy transmitting data. QEMU's implementation never sets BUSY.
     pub busy: bool,
-    /// RXFE Receive FIFO empty. The meaning of this bit depends on the
-    /// state of the FEN bit in the UARTLCR_H register. If the FIFO
-    /// is disabled, this bit is set when the receive holding
-    /// register is empty. If the FIFO is enabled, the RXFE bit is
-    /// set when the receive FIFO is empty.
+    /// RXFE: Receive FIFO empty
     pub receive_fifo_empty: bool,
-    /// TXFF Transmit FIFO full. The meaning of this bit depends on the
-    /// state of the FEN bit in the UARTLCR_H register. If the FIFO
-    /// is disabled, this bit is set when the transmit holding
-    /// register is full. If the FIFO is enabled, the TXFF bit is
-    /// set when the transmit FIFO is full.
+    /// TXFF: Transmit FIFO full
     pub transmit_fifo_full: bool,
-    /// RXFF Receive FIFO full. The meaning of this bit depends on the state
-    /// of the FEN bit in the UARTLCR_H register. If the FIFO is
-    /// disabled, this bit is set when the receive holding register
-    /// is full. If the FIFO is enabled, the RXFF bit is set when
-    /// the receive FIFO is full.
+    /// RXFF: Receive FIFO full
     pub receive_fifo_full: bool,
-    /// Transmit FIFO empty. The meaning of this bit depends on the state of
-    /// the FEN bit in the [Line Control register](LineControl),
-    /// `UARTLCR_H`. If the FIFO is disabled, this bit is set when the
-    /// transmit holding register is empty. If the FIFO is enabled,
-    /// the TXFE bit is set when the transmit FIFO is empty. This
-    /// bit does not indicate if there is data in the transmit shift
-    /// register.
+    /// TXFE: Transmit FIFO empty
     pub transmit_fifo_empty: bool,
-    /// `RI`, is `true` when `nUARTRI` is `LOW`.
+    /// RI: Ring indicator
     pub ring_indicator: bool,
     _reserved_zero_no_modify: u23,
 }
@@ -270,54 +195,23 @@ fn default() -> Self {
 /// Line Control Register, `UARTLCR_H`
 #[doc(alias = "UARTLCR_H")]
 pub struct LineControl {
-    /// BRK Send break.
-    ///
-    /// If this bit is set to `1`, a low-level is continually output on the
-    /// `UARTTXD` output, after completing transmission of the
-    /// current character. For the proper execution of the break command,
-    /// the software must set this bit for at least two complete
-    /// frames. For normal use, this bit must be cleared to `0`.
+    /// BRK: Send break
     pub send_break: bool,
-    /// 1 PEN Parity enable:
-    ///
-    /// - 0 = parity is disabled and no parity bit added to the data frame
-    /// - 1 = parity checking and generation is enabled.
-    ///
-    /// See Table 3-11 on page 3-14 for the parity truth table.
+    /// PEN: Parity enable
     pub parity_enabled: bool,
-    /// EPS Even parity select. Controls the type of parity the UART uses
-    /// during transmission and reception:
-    /// - 0 = odd parity. The UART generates or checks for an odd number of 1s
-    ///   in the data and parity bits.
-    /// - 1 = even parity. The UART generates or checks for an even number of 1s
-    ///   in the data and parity bits.
-    /// This bit has no effect when the `PEN` bit disables parity checking
-    /// and generation. See Table 3-11 on page 3-14 for the parity
-    /// truth table.
+    /// EPS: Even parity select
     pub parity: Parity,
-    /// 3 STP2 Two stop bits select. If this bit is set to 1, two stop bits
-    /// are transmitted at the end of the frame. The receive
-    /// logic does not check for two stop bits being received.
+    /// STP2: Two stop bits select
     pub two_stops_bits: bool,
-    /// FEN Enable FIFOs:
-    /// 0 = FIFOs are disabled (character mode) that is, the FIFOs become
-    /// 1-byte-deep holding registers 1 = transmit and receive FIFO
-    /// buffers are enabled (FIFO mode).
+    /// FEN: Enable FIFOs
     pub fifos_enabled: Mode,
-    /// WLEN Word length. These bits indicate the number of data bits
-    /// transmitted or received in a frame as follows: b11 = 8 bits
+    /// WLEN: Word length in bits
+    /// b11 = 8 bits
     /// b10 = 7 bits
     /// b01 = 6 bits
     /// b00 = 5 bits.
     pub word_length: WordLength,
-    /// 7 SPS Stick parity select.
-    /// 0 = stick parity is disabled
-    /// 1 = either:
-    /// • if the EPS bit is 0 then the parity bit is transmitted and checked
-    /// as a 1 • if the EPS bit is 1 then the parity bit is
-    /// transmitted and checked as a 0. This bit has no effect when
-    /// the PEN bit disables parity checking and generation. See Table 3-11
-    /// on page 3-14 for the parity truth table.
+    /// SPS Stick parity select
     pub sticky_parity: bool,
     /// 31:8 - Reserved, do not modify, read as zero.
     _reserved_zero_no_modify: u24,
@@ -342,11 +236,7 @@ fn default() -> Self {
 /// `EPS` "Even parity select", field of [Line Control
 /// register](LineControl).
 pub enum Parity {
-    /// - 0 = odd parity. The UART generates or checks for an odd number of 1s
-    ///   in the data and parity bits.
     Odd = 0,
-    /// - 1 = even parity. The UART generates or checks for an even number of 1s
-    ///   in the data and parity bits.
     Even = 1,
 }
 
@@ -381,88 +271,39 @@ pub enum WordLength {
 
 /// Control Register, `UARTCR`
 ///
-/// The `UARTCR` register is the control register. All the bits are cleared
-/// to `0` on reset except for bits `9` and `8` that are set to `1`.
-///
-/// # Source
-/// ARM DDI 0183G, 3.3.8 Control Register, `UARTCR`, Table 3-12
+/// The `UARTCR` register is the control register. It contains various
+/// enable bits, and the bits to write to set the usual outbound RS232
+/// modem control signals. All bits reset to 0 except TXE and RXE.
 #[bitsize(32)]
 #[doc(alias = "UARTCR")]
 #[derive(Clone, Copy, DebugBits, FromBits)]
 pub struct Control {
-    /// `UARTEN` UART enable: 0 = UART is disabled. If the UART is disabled
-    /// in the middle of transmission or reception, it completes the current
-    /// character before stopping. 1 = the UART is enabled. Data
-    /// transmission and reception occurs for either UART signals or SIR
-    /// signals depending on the setting of the SIREN bit.
+    /// `UARTEN` UART enable: 0 = UART is disabled.
     pub enable_uart: bool,
-    /// `SIREN` `SIR` enable: 0 = IrDA SIR ENDEC is disabled. `nSIROUT`
-    /// remains LOW (no light pulse generated), and signal transitions on
-    /// SIRIN have no effect. 1 = IrDA SIR ENDEC is enabled. Data is
-    /// transmitted and received on nSIROUT and SIRIN. UARTTXD remains HIGH,
-    /// in the marking state. Signal transitions on UARTRXD or modem status
-    /// inputs have no effect. This bit has no effect if the UARTEN bit
-    /// disables the UART.
+    /// `SIREN` `SIR` enable: disable or enable IrDA SIR ENDEC.
+    /// QEMU does not model this.
     pub enable_sir: bool,
-    /// `SIRLP` SIR low-power IrDA mode. This bit selects the IrDA encoding
-    /// mode. If this bit is cleared to 0, low-level bits are transmitted as
-    /// an active high pulse with a width of 3/ 16th of the bit period. If
-    /// this bit is set to 1, low-level bits are transmitted with a pulse
-    /// width that is 3 times the period of the IrLPBaud16 input signal,
-    /// regardless of the selected bit rate. Setting this bit uses less
-    /// power, but might reduce transmission distances.
+    /// `SIRLP` SIR low-power IrDA mode. QEMU does not model this.
     pub sir_lowpower_irda_mode: u1,
     /// Reserved, do not modify, read as zero.
     _reserved_zero_no_modify: u4,
-    /// `LBE` Loopback enable. If this bit is set to 1 and the SIREN bit is
-    /// set to 1 and the SIRTEST bit in the Test Control register, UARTTCR
-    /// on page 4-5 is set to 1, then the nSIROUT path is inverted, and fed
-    /// through to the SIRIN path. The SIRTEST bit in the test register must
-    /// be set to 1 to override the normal half-duplex SIR operation. This
-    /// must be the requirement for accessing the test registers during
-    /// normal operation, and SIRTEST must be cleared to 0 when loopback
-    /// testing is finished. This feature reduces the amount of external
-    /// coupling required during system test. If this bit is set to 1, and
-    /// the SIRTEST bit is set to 0, the UARTTXD path is fed through to the
-    /// UARTRXD path. In either SIR mode or UART mode, when this bit is set,
-    /// the modem outputs are also fed through to the modem inputs. This bit
-    /// is cleared to 0 on reset, to disable loopback.
+    /// `LBE` Loopback enable: feed UART output back to the input
     pub enable_loopback: bool,
-    /// `TXE` Transmit enable. If this bit is set to 1, the transmit section
-    /// of the UART is enabled. Data transmission occurs for either UART
-    /// signals, or SIR signals depending on the setting of the SIREN bit.
-    /// When the UART is disabled in the middle of transmission, it
-    /// completes the current character before stopping.
+    /// `TXE` Transmit enable
     pub enable_transmit: bool,
-    /// `RXE` Receive enable. If this bit is set to 1, the receive section
-    /// of the UART is enabled. Data reception occurs for either UART
-    /// signals or SIR signals depending on the setting of the SIREN bit.
-    /// When the UART is disabled in the middle of reception, it completes
-    /// the current character before stopping.
+    /// `RXE` Receive enable
     pub enable_receive: bool,
-    /// `DTR` Data transmit ready. This bit is the complement of the UART
-    /// data transmit ready, `nUARTDTR`, modem status output. That is, when
-    /// the bit is programmed to a 1 then `nUARTDTR` is LOW.
+    /// `DTR` Data transmit ready
     pub data_transmit_ready: bool,
-    /// `RTS` Request to send. This bit is the complement of the UART
-    /// request to send, `nUARTRTS`, modem status output. That is, when the
-    /// bit is programmed to a 1 then `nUARTRTS` is LOW.
+    /// `RTS` Request to send
     pub request_to_send: bool,
-    /// `Out1` This bit is the complement of the UART Out1 (`nUARTOut1`)
-    /// modem status output. That is, when the bit is programmed to a 1 the
-    /// output is 0. For DTE this can be used as Data Carrier Detect (DCD).
+    /// `Out1` UART Out1 signal; can be used as DCD
     pub out_1: bool,
-    /// `Out2` This bit is the complement of the UART Out2 (`nUARTOut2`)
-    /// modem status output. That is, when the bit is programmed to a 1, the
-    /// output is 0. For DTE this can be used as Ring Indicator (RI).
+    /// `Out2` UART Out2 signal; can be used as RI
     pub out_2: bool,
-    /// `RTSEn` RTS hardware flow control enable. If this bit is set to 1,
-    /// RTS hardware flow control is enabled. Data is only requested when
-    /// there is space in the receive FIFO for it to be received.
+    /// `RTSEn` RTS hardware flow control enable
     pub rts_hardware_flow_control_enable: bool,
-    /// `CTSEn` CTS hardware flow control enable. If this bit is set to 1,
-    /// CTS hardware flow control is enabled. Data is only transmitted when
-    /// the `nUARTCTS` signal is asserted.
+    /// `CTSEn` CTS hardware flow control enable
     pub cts_hardware_flow_control_enable: bool,
     /// 31:16 - Reserved, do not modify, read as zero.
     _reserved_zero_no_modify2: u16,
-- 
2.43.0


