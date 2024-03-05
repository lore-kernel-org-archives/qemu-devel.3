Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016B2C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVF1-0002Vw-SN; Tue, 05 Mar 2024 08:53:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDs-0000vX-To
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDm-0005xL-Ff
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:48 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33e1207bba1so4538489f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646761; x=1710251561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uGzpyI9XVFpyvThOBaS71QfWPFb/RDXMpVkRqMA05YE=;
 b=Yl29RtKkELLesXUUbkQE0aef3GfYs+BdON3/l/KX62P8UXBtgYPaBaGF75i0x6lF/H
 f60lyxYOG6SItTcsqvEE58jZXD4JXEZmIXpKYD06VV0xpxUerEVMZ+UZYZe2Y5k/491o
 geuGyh5d29Jq0ZOsb7tBejZY7OuEcv2RTjAktD5cm5BsZmqFbVSVfTQh0zHEpe0n4r2C
 3xZGnJpzCK2CJJS03K59S544rhmtYRBhe10dOmpViNfnNqhCO9VghCduKYWYTI7EwTBB
 ufIXyft6lK7nPJrC0hRmYM70CnKwhmMl2EHifzwBeKjQtDqd6bx1cOVuY2i9v+E+OxPU
 K5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646761; x=1710251561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uGzpyI9XVFpyvThOBaS71QfWPFb/RDXMpVkRqMA05YE=;
 b=rsy/NbPp43uhc6sFzenwPKZbgzQMBPYuh+0QXqwgx2SUm3LV/c25fPKO8hY4jUj8GR
 wdzSesUU7uDziFUdfJ9ignLoJun6CwrXhq3B3F36Th8jHbj5CVKGwBPa5/G4aJLYY0f8
 sHDHW+DMZJO9J2y4UhX7Ro5WufKIL/+d5dBzUFjmcQVmaEAuBYH3W9msqWzykE7z0w7p
 pvFMOtFHPHiwtXMHywNaBj84+CZx47Fyony0y0lS0/XzMIxM1HUB0Vk7VW4dYNkzE6Sy
 T/A4FYaySvy9WVrswRqB+o4L8rtQs1tL2BNRR/g2/R0HW1hdPUkGIfnXPROEFRGx50zJ
 22Bg==
X-Gm-Message-State: AOJu0YxVnCzjlxMG5/dSF1W4pfrt9DMxe/HQLDTVEv8QufZKt6iSGLpH
 wdZIFIQP3dLtfRd6x3brxqnQHCVJGHraaSezVmDyyiFcqlZgknODq8NiuQZo6S/MWkdG9INrSER
 g
X-Google-Smtp-Source: AGHT+IF1tpbbhyrfDT7BQo/U8AM4lwnoAt54qWA/eR04pb5K6RWfmRdX7q891H9PSPPEcYxjp/9jHQ==
X-Received: by 2002:adf:ec4f:0:b0:33e:3d71:445f with SMTP id
 w15-20020adfec4f000000b0033e3d71445fmr4631228wrn.32.1709646761095; 
 Tue, 05 Mar 2024 05:52:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] hw/char/pl011: Add support for loopback
Date: Tue,  5 Mar 2024 13:52:21 +0000
Message-Id: <20240305135237.3111642-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Tong Ho <tong.ho@amd.com>

This patch adds loopback for sent characters, sent BREAK,
and modem-control signals.

Loopback of send and modem-control is often used for uart
self tests in real hardware but missing from current pl011
model, resulting in self-test failures when running in QEMU.

This implementation matches what is observed in real pl011
hardware placed in loopback mode:
1. Input characters and BREAK events from serial backend
   are ignored, but
2. Both TX characters and BREAK events are still sent to
   serial backend, in addition to be looped back to RX.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240227054855.44204-1-tong.ho@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/pl011.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 855cb82d08d..8753b84a842 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -49,10 +49,14 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 }
 
 /* Flag Register, UARTFR */
+#define PL011_FLAG_RI   0x100
 #define PL011_FLAG_TXFE 0x80
 #define PL011_FLAG_RXFF 0x40
 #define PL011_FLAG_TXFF 0x20
 #define PL011_FLAG_RXFE 0x10
+#define PL011_FLAG_DCD  0x04
+#define PL011_FLAG_DSR  0x02
+#define PL011_FLAG_CTS  0x01
 
 /* Data Register, UARTDR */
 #define DR_BE   (1 << 10)
@@ -76,6 +80,13 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_FEN     (1 << 4)
 #define LCR_BRK     (1 << 0)
 
+/* Control Register, UARTCR */
+#define CR_OUT2     (1 << 13)
+#define CR_OUT1     (1 << 12)
+#define CR_RTS      (1 << 11)
+#define CR_DTR      (1 << 10)
+#define CR_LBE      (1 << 7)
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -251,6 +262,89 @@ static void pl011_trace_baudrate_change(const PL011State *s)
                                 s->ibrd, s->fbrd);
 }
 
+static bool pl011_loopback_enabled(PL011State *s)
+{
+    return !!(s->cr & CR_LBE);
+}
+
+static void pl011_loopback_mdmctrl(PL011State *s)
+{
+    uint32_t cr, fr, il;
+
+    if (!pl011_loopback_enabled(s)) {
+        return;
+    }
+
+    /*
+     * Loopback software-driven modem control outputs to modem status inputs:
+     *   FR.RI  <= CR.Out2
+     *   FR.DCD <= CR.Out1
+     *   FR.CTS <= CR.RTS
+     *   FR.DSR <= CR.DTR
+     *
+     * The loopback happens immediately even if this call is triggered
+     * by setting only CR.LBE.
+     *
+     * CTS/RTS updates due to enabled hardware flow controls are not
+     * dealt with here.
+     */
+    cr = s->cr;
+    fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
+                      PL011_FLAG_DSR | PL011_FLAG_CTS);
+    fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
+    fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
+    fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
+    fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
+
+    /* Change interrupts based on updated FR */
+    il = s->int_level & ~(INT_DSR | INT_DCD | INT_CTS | INT_RI);
+    il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
+    il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
+    il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
+    il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
+
+    s->flags = fr;
+    s->int_level = il;
+    pl011_update(s);
+}
+
+static void pl011_put_fifo(void *opaque, uint32_t value);
+
+static void pl011_loopback_tx(PL011State *s, uint32_t value)
+{
+    if (!pl011_loopback_enabled(s)) {
+        return;
+    }
+
+    /*
+     * Caveat:
+     *
+     * In real hardware, TX loopback happens at the serial-bit level
+     * and then reassembled by the RX logics back into bytes and placed
+     * into the RX fifo. That is, loopback happens after TX fifo.
+     *
+     * Because the real hardware TX fifo is time-drained at the frame
+     * rate governed by the configured serial format, some loopback
+     * bytes in TX fifo may still be able to get into the RX fifo
+     * that could be full at times while being drained at software
+     * pace.
+     *
+     * In such scenario, the RX draining pace is the major factor
+     * deciding which loopback bytes get into the RX fifo, unless
+     * hardware flow-control is enabled.
+     *
+     * For simplicity, the above described is not emulated.
+     */
+    pl011_put_fifo(s, value);
+}
+
+static void pl011_loopback_break(PL011State *s, int brk_enable)
+{
+    if (brk_enable) {
+        pl011_loopback_tx(s, DR_BE);
+    }
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -266,6 +360,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        pl011_loopback_tx(s, ch);
         s->int_level |= INT_TX;
         pl011_update(s);
         break;
@@ -295,13 +390,15 @@ static void pl011_write(void *opaque, hwaddr offset,
             int break_enable = value & LCR_BRK;
             qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
                               &break_enable);
+            pl011_loopback_break(s, break_enable);
         }
         s->lcr = value;
         pl011_set_read_trigger(s);
         break;
     case 12: /* UARTCR */
-        /* ??? Need to implement the enable and loopback bits.  */
+        /* ??? Need to implement the enable bit.  */
         s->cr = value;
+        pl011_loopback_mdmctrl(s);
         break;
     case 13: /* UARTIFS */
         s->ifl = value;
@@ -361,12 +458,21 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
+    /*
+     * In loopback mode, the RX input signal is internally disconnected
+     * from the entire receiving logics; thus, all inputs are ignored,
+     * and BREAK detection on RX input signal is also not performed.
+     */
+    if (pl011_loopback_enabled(opaque)) {
+        return;
+    }
+
     pl011_put_fifo(opaque, *buf);
 }
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
-    if (event == CHR_EVENT_BREAK) {
+    if (event == CHR_EVENT_BREAK && !pl011_loopback_enabled(opaque)) {
         pl011_put_fifo(opaque, DR_BE);
     }
 }
-- 
2.34.1


