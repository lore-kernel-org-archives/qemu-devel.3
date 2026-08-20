Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD991C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CG-0004qj-Hw; Thu, 20 Aug 2026 08:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CD-0004p1-Vv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:38 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CB-0001XI-7B
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:37 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so3731900a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230114; x=1787834914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4MRvYdw615nh8ZPgiL5QIiN8untfHb3/fkVaP/Y9iL0=;
 b=IeYnbHXjBv50SjvzQjBQzhnbv5BPSuMSL7q4m3RQuRtVkhuzHCOjJm91MRq3YMAMmK
 0RRx1rxP2TLdQlLuZHattVCjFvWqE3fd++80AuKDae9gbvcvX3TpiIQPv+a/r652U/tA
 EsbQP5l0lYSYx0pwrAbHnuYF9LVvNt+7zwBhc+bRXvsKq6jWfPm1PqCNXpkIqM3d6MLQ
 KPPHkoUuCHYg3FnFBrAjpb1v/cz/3Jb7e9PFWsFqyTthMh8u/LWK/RCke7Lsqd5disWY
 xu/ntBqPFZ7izLo7O9hE/h0+r3cevpMB07BHhjCvUmsk7vFtikksMG+mtlVVBcSfLk3V
 Tw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230114; x=1787834914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4MRvYdw615nh8ZPgiL5QIiN8untfHb3/fkVaP/Y9iL0=;
 b=JNcVTAbJCSyN5TLGncMAxDzooNdMCpJoidEuIL0V6ZIiqVBB8opQElxJMLiWPsfq1b
 q/6msnlnHFtCBUOjg69FaRikANZrWu6D/Oyfq/LKTX+OszkMVqYlfQFlWiVEIoeDRp3D
 Xs2ZRG8i/rgOirzS94G45qL5LLwhc22WHCfJ26Jl3cEytrGtqhf9KSWmYDjvppPqB8wC
 ToD2Cvh+D67+ZWdeXm2gcODUk8quTIO+4s7QsQX1kO9oyGtI/lcJOffK+qdnq0BVdTgZ
 Lmz79ruAZEganhx6Nd2a4vWCudHRp5knjceZkbNvhutYULfpqo8ZMF+wycDBvn2nk1LR
 vzZA==
X-Gm-Message-State: AFuF++nWIGt5LnbmFeH4y2RZU49qa7uElDJOrayC4EUcMzA2mhlR78/+
 NPY9c3IGYQ19ykKpoevQy0oIF7js0M9Fd17c5X6p5OWGMuiB4kh/gE5Ot52/RQuA
X-Gm-Gg: AR+sD10GgmeGtKiTL68K22pPfwvBmJUVSW3QRw7Td/Vb9tZVWxZyk4yhh0XcnjasHa4
 2Kt1aWMB98fX1TOUaF5p88vqPMbBRkyoHK0JMoZ/qea9Qd59us3gPAeN5ox4FSy1W6YPBEMYDKq
 tqYmr4bEiz4nypMicmCKtg4h2koMkcrs5SOOkSlsTAzo3zg3av4hLVmAXnQXC2N1FdQrJrGn/6c
 RcjG+XkYtFfIpqwZFFBsb7z2mHnHZTidfwIoNPpbdQ1eUlHQEViY994EjER7HrtrcYdN2aqAoQ3
 5fpQETiEriflljLzCy/cE6jzNFpCSoxRMJwhD/1g/l7AKMAJ3EBLE/DFUtUnEXIJ7ZeD6AWzJNh
 bXGkcGqKMqwexuHVf1YKO17NasYWW6TjZJEOkluoOD1ent37w3EcO1y8Xrz+Le2wAJG7nGTOytA
 eLP3o1tiTdTF/WGOMKrU97UILn8k2PRVM54s4gRF/VME1S9mH8/x3j3Oeixf1kGoXeAk/+ngFd4
 CR72N9SNbU=
X-Received: by 2002:a05:6402:42cb:b0:6a3:f8ab:19f7 with SMTP id
 4fb4d7f45d1cf-6a4032f4508mr8312845a12.11.1787230113266; 
 Thu, 20 Aug 2026 05:48:33 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:32 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 02/14] hw/i2c/omap_i2c: implement soft reset and NACK
 reporting
Date: Thu, 20 Aug 2026 14:48:02 +0200
Message-ID: <20260820124824.618671-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the pieces of the controller that the TI K3 ROM/SPL and the Linux
omap-i2c driver actually exercise:

 - OMAP_I2C_SYSC.SRST triggers a soft reset and SYSS.RDONE reports its
   completion, instead of the register being a plain scratch value.
 - A transfer to an address that nobody acknowledges raises STAT.NACK and
   ends the transfer, rather than being silently completed.

This allows to let a guest probe an I2C bus and correctly conclude that a
device is absent.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/i2c/omap_i2c.c | 234 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 232 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
index d6e28a1a89..e56f75d6f5 100644
--- a/hw/i2c/omap_i2c.c
+++ b/hw/i2c/omap_i2c.c
@@ -37,6 +37,7 @@ struct OMAPI2CState {
     I2CBus *bus;
 
     uint8_t revision;
+    uint8_t mmio_version;
     void *iclk;
     void *fclk;
 
@@ -58,6 +59,61 @@ struct OMAPI2CState {
 #define OMAP2_INTR_REV  0x34
 #define OMAP2_GC_REV    0x34
 
+/*
+ * MMIO register layout selector.  The classic OMAP1/OMAP2 "IP V1" map is the
+ * default and is what every existing OMAP board relies on.  "IP V2" is the
+ * OMAP4-and-later layout ("ti,omap4-i2c" / "ti,am64-i2c"), which relocates the
+ * registers and adds the IRQSTATUS_RAW / IRQENABLE_SET / IRQENABLE_CLR set.
+ * The transfer/reset/NACK engine is shared; only the address decode differs.
+ */
+#define OMAP_I2C_MMIO_V1  0
+#define OMAP_I2C_MMIO_V2  2
+
+/* IP V2 register offsets, as used from OMAP4 onwards. */
+#define OMAP_I2C_V2_REVNB_LO       0x00
+#define OMAP_I2C_V2_REVNB_HI       0x04
+#define OMAP_I2C_V2_SYSC           0x10
+#define OMAP_I2C_V2_IRQSTATUS_RAW  0x24
+#define OMAP_I2C_V2_IRQSTATUS      0x28
+#define OMAP_I2C_V2_IRQENABLE_SET  0x2c
+#define OMAP_I2C_V2_IRQENABLE_CLR  0x30
+#define OMAP_I2C_V2_WE             0x34
+#define OMAP_I2C_V2_SYSS           0x90
+#define OMAP_I2C_V2_BUF            0x94
+#define OMAP_I2C_V2_CNT            0x98
+#define OMAP_I2C_V2_DATA           0x9c
+#define OMAP_I2C_V2_CON            0xa4
+#define OMAP_I2C_V2_OA             0xa8
+#define OMAP_I2C_V2_SA             0xac
+#define OMAP_I2C_V2_PSC            0xb0
+#define OMAP_I2C_V2_SCLL           0xb4
+#define OMAP_I2C_V2_SCLH           0xb8
+#define OMAP_I2C_V2_SYSTEST        0xbc
+#define OMAP_I2C_V2_BUFSTAT        0xc0
+
+/*
+ * Translate an IP-V2 offset for a register whose semantics are identical to
+ * the V1 model into the V1 offset the shared read/write switch decodes.
+ * Returns -1 for offsets that have no direct V1 equivalent (those are handled
+ * inline by the V2 front-end).
+ */
+static int omap_i2c_v2_to_v1(int offset)
+{
+    switch (offset) {
+    case OMAP_I2C_V2_BUF:     return 0x14;
+    case OMAP_I2C_V2_CNT:     return 0x18;
+    /* DATA (0x9c) is handled inline byte-wise by the V2 front-end. */
+    case OMAP_I2C_V2_CON:     return 0x24;
+    case OMAP_I2C_V2_OA:      return 0x28;
+    case OMAP_I2C_V2_SA:      return 0x2c;
+    case OMAP_I2C_V2_PSC:     return 0x30;
+    case OMAP_I2C_V2_SCLL:    return 0x34;
+    case OMAP_I2C_V2_SCLH:    return 0x38;
+    case OMAP_I2C_V2_SYSTEST: return 0x3c;
+    default:                  return -1;
+    }
+}
+
 static void omap_i2c_interrupts_update(OMAPI2CState *s)
 {
     qemu_set_irq(s->irq, s->stat & s->mask);
@@ -162,6 +218,83 @@ static uint32_t omap_i2c_read(void *opaque, hwaddr addr)
     int offset = addr & OMAP_MPUI_REG_MASK;
     uint16_t ret;
 
+    if (s->mmio_version == OMAP_I2C_MMIO_V2) {
+        switch (offset) {
+        case OMAP_I2C_V2_REVNB_LO:
+            return s->revision;
+        case OMAP_I2C_V2_REVNB_HI:
+            return 0;
+        case OMAP_I2C_V2_SYSC:
+            return 0;
+        case OMAP_I2C_V2_IRQSTATUS_RAW:
+        case OMAP_I2C_V2_IRQSTATUS:     /* STAT mirrors IRQSTATUS_RAW */
+            return s->stat | (i2c_bus_busy(s->bus) << 12);
+        case OMAP_I2C_V2_IRQENABLE_SET:
+        case OMAP_I2C_V2_IRQENABLE_CLR:
+            return s->mask;
+        case OMAP_I2C_V2_WE:
+            return 0;
+        case OMAP_I2C_V2_SYSS:
+            /* reset is instantaneous in the model: RDONE always reads set */
+            return 1;
+        case OMAP_I2C_V2_BUFSTAT:
+            return 0;
+        case OMAP_I2C_V2_DATA: {
+            /*
+             * The OMAP4/AM64x driver accesses the DATA register one byte per
+             * MMIO access (readw of a single byte), unlike the classic V1
+             * 16-bit FIFO convention.  Pop exactly one byte (oldest first,
+             * FIFO is filled LSB-first by omap_i2c_fifo_run()).
+             */
+            uint8_t b = s->fifo & 0xff;
+            if (s->rxlen > 0) {
+                s->fifo >>= 8;
+                s->rxlen--;
+            }
+            /*
+             * Refill from the slave while the transfer is still live (this
+             * may complete count_cur and issue the STOP, leaving the last
+             * few prefetched bytes buffered in the FIFO with the bus idle).
+             */
+            omap_i2c_fifo_run(s);
+            /*
+             * Drive the RRDY/ARDY handshake directly off the FIFO drain
+             * state so it keeps working after the bus has gone idle: RRDY
+             * stays asserted while buffered bytes remain, and ARDY is raised
+             * once the last byte has been consumed (master-receive).
+             */
+            if (s->rxlen > 0) {
+                s->stat |= 1 << 3;                          /* RRDY */
+            } else {
+                s->stat &= ~(1 << 3);                       /* RRDY */
+                if (((s->control >> 10) & 1) &&             /* MST */
+                    ((~s->control >> 9) & 1)) {             /* TRX (receive) */
+                    s->stat |= 1 << 2;                      /* ARDY */
+                    s->control &= ~(1 << 10);               /* MST */
+                    /*
+                     * DCOUNT decrements to 0 on real hardware and stays
+                     * there; leave it at 0 so a following address-only probe
+                     * (which programs no CNT) starts from 0 and completes
+                     * with ARDY instead of waiting for phantom TX bytes.
+                     */
+                    s->count = 0;
+                    s->count_cur = 0;
+                }
+            }
+            s->stat &= ~(1 << 11);                          /* ROVR */
+            omap_i2c_interrupts_update(s);
+            return b;
+        }
+        default:
+            offset = omap_i2c_v2_to_v1(offset);
+            if (offset < 0) {
+                OMAP_BAD_REG(addr);
+                return 0;
+            }
+            break;
+        }
+    }
+
     switch (offset) {
     case 0x00:  /* I2C_REV */
         return s->revision;                     /* REV */
@@ -266,6 +399,83 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
     int offset = addr & OMAP_MPUI_REG_MASK;
     int nack;
 
+    if (s->mmio_version == OMAP_I2C_MMIO_V2) {
+        switch (offset) {
+        case OMAP_I2C_V2_SYSC:
+            if (value & 2) {                    /* SRST */
+                omap_i2c_reset(DEVICE(s));
+            }
+            return;
+        case OMAP_I2C_V2_DATA:
+            /*
+             * The OMAP4/AM64x driver writes the DATA register one byte per
+             * MMIO access (writew of a single byte).  Push exactly one byte,
+             * mirroring the classic 8-bit FIFO path (omap_i2c_writeb()).
+             */
+            if (s->txlen <= 2) {
+                s->fifo <<= 8;
+                s->txlen += 1;
+                s->fifo |= value & 0xff;
+                s->stat &= ~(1 << 10);                  /* XUDF */
+                if (s->txlen > 2) {
+                    s->stat &= ~(1 << 4);               /* XRDY */
+                }
+                omap_i2c_fifo_run(s);
+                /*
+                 * If the transmit finished and issued its STOP, leave DCOUNT
+                 * at 0 (see the DATA read path) so the next probe/transfer
+                 * that does not reprogram CNT is not tricked into expecting
+                 * stale phantom bytes.
+                 */
+                if (!i2c_bus_busy(s->bus)) {
+                    s->count = 0;
+                    s->count_cur = 0;
+                }
+                omap_i2c_interrupts_update(s);
+            }
+            return;
+        case OMAP_I2C_V2_IRQSTATUS_RAW:
+        case OMAP_I2C_V2_IRQSTATUS:             /* write-1-to-clear */
+            s->stat &= ~(value & 0x7fff);
+            /*
+             * XRDY/RRDY are level events: after the driver clears them it
+             * expects them to re-assert while the transfer still has room /
+             * data.  Re-run the FIFO engine for a live transfer, then
+             * re-assert RRDY if bytes remain buffered even after the bus has
+             * gone idle (the tail of a receive drains from the FIFO).
+             */
+            omap_i2c_fifo_run(s);
+            if (s->rxlen > 0) {
+                s->stat |= 1 << 3;              /* RRDY */
+            }
+            omap_i2c_interrupts_update(s);
+            return;
+        case OMAP_I2C_V2_IRQENABLE_SET:
+            s->mask |= value & 0xff;
+            omap_i2c_interrupts_update(s);
+            return;
+        case OMAP_I2C_V2_IRQENABLE_CLR:
+            s->mask &= ~(value & 0xff);
+            omap_i2c_interrupts_update(s);
+            return;
+        case OMAP_I2C_V2_WE:
+            return;                             /* wakeup enable: ignored */
+        case OMAP_I2C_V2_REVNB_LO:
+        case OMAP_I2C_V2_REVNB_HI:
+        case OMAP_I2C_V2_SYSS:
+        case OMAP_I2C_V2_BUFSTAT:
+            OMAP_RO_REG(addr);
+            return;
+        default:
+            offset = omap_i2c_v2_to_v1(offset);
+            if (offset < 0) {
+                OMAP_BAD_REG(addr);
+                return;
+            }
+            break;
+        }
+    }
+
     switch (offset) {
     case 0x00:  /* I2C_REV */
     case 0x0c:  /* I2C_IV */
@@ -412,6 +622,10 @@ static void omap_i2c_writeb(void *opaque, hwaddr addr,
     OMAPI2CState *s = opaque;
     int offset = addr & OMAP_MPUI_REG_MASK;
 
+    if (s->mmio_version == OMAP_I2C_MMIO_V2 && offset == OMAP_I2C_V2_DATA) {
+        offset = 0x1c;                          /* I2C_DATA */
+    }
+
     switch (offset) {
     case 0x1c:  /* I2C_DATA */
         if (s->txlen > 2) {
@@ -489,10 +703,24 @@ static void omap_i2c_init(Object *obj)
 static void omap_i2c_realize(DeviceState *dev, Error **errp)
 {
     OMAPI2CState *s = OMAP_I2C(dev);
+    uint64_t size;
 
+    if (s->mmio_version == OMAP_I2C_MMIO_V2) {
+        size = 0x100;                           /* AM64x main_i2c reg length */
+    } else {
+        size = (s->revision < OMAP2_INTR_REV) ? 0x800 : 0x1000;
+    }
     memory_region_init_io(&s->iomem, OBJECT(dev), &omap_i2c_ops, s, "omap.i2c",
-                          (s->revision < OMAP2_INTR_REV) ? 0x800 : 0x1000);
-
+                          size);
+
+    /*
+     * The IP-V2 wiring (e.g. TI AM64x) drives the module from the SoC clock
+     * tree rather than the legacy omap_clk pointer stubs, so the fclk/iclk
+     * requirement only applies to the classic OMAP boards.
+     */
+    if (s->mmio_version == OMAP_I2C_MMIO_V2) {
+        return;
+    }
     if (!s->fclk) {
         error_setg(errp, "omap_i2c: fclk not connected");
         return;
@@ -516,6 +744,8 @@ void omap_i2c_set_fclk(OMAPI2CState *i2c, omap_clk clk)
 
 static const Property omap_i2c_properties[] = {
     DEFINE_PROP_UINT8("revision", OMAPI2CState, revision, 0),
+    DEFINE_PROP_UINT8("mmio-version", OMAPI2CState, mmio_version,
+                      OMAP_I2C_MMIO_V1),
 };
 
 static void omap_i2c_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


