Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31D9C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OND-00013N-LG; Tue, 01 Sep 2026 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONC-00012K-0C
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:58 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONA-0007Bw-3T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:57 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso6253758a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268674; x=1788873474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o1nePPo8i10ilYcV4CD8N6UBKH0v+1I5NmABoSXkSQs=;
 b=W38HtqgfwgzqDKBPUKuJMyxf7eNzejvJiwN/iOo/pVlQOU5eaZgnsMHSs4yG/WJQ7C
 fxHKK5x0/PqqWozH7nIohKXT0/bmbEBgiALrGmxGNVGkORljZxXvknHaEvOfeSVOzu0U
 vU2bAN0yZe6JjV1Oe4egHBJonFuxkWJJWe2KisgGQF8QBmz8Nap9J1h3jlyOBEGNW2ie
 NXe1+bTnsm04uH5V5Xy47OyxizwhaxYeIcovEAGypifWiAJAZqyALHvhVB0x8RJjUjVx
 rCLR0feqwa5I1jHGRhLk+fzQdPXzGTlH76nJzWFwuLdXW9rMvqxX/1hHxAxy85zoRB3T
 BfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268674; x=1788873474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o1nePPo8i10ilYcV4CD8N6UBKH0v+1I5NmABoSXkSQs=;
 b=JDraTHxivi3YZ/vyUbcQAqFDYWSpqHb6qA2xmeO9c0JLnuUeucMSOMgALTCpnK6IzX
 lC7ib6to1t5d6YJngXKHIZe7vRQUlw7ofJGzwqM2Vs/+eUhwjg6Srr7CNsD+8lpWYCJp
 ltvgEBfiwnHEK98DzGONRUBkgHqQnqdtTlBoXs1NAuov9Ut6leA/DfrzdAseGbMb/tkm
 UZiYokxS0hATgsvdccuWU1Tz4Vlk0OwcZJa8gbeXNGga1Vlr4vV4o9Bj+mL9ErDinh9s
 2hVEvnRINQYF9EJf7kS8Z1FxEWHfSpF6rsRpg2Nw4sQOfr1GRWoGXMEOVDuRZSwBbZvt
 c/Fg==
X-Gm-Message-State: AFuF++kTS3/TppbfCvC7jX2QGPSvPVWrvGIQ/kKpMD34fZj1SFOJw6/b
 3Bq6eJ2t6ioFkbT7pjBQeMP3B1Ez1LLiLAaOjRMpALWC7MtTRVbulh2vPSLM1hS/8ybqw04sS1Y
 Jm+Dg28A=
X-Gm-Gg: AR+sD12+GURV816M3bomm3M09pxzonGA8VfKZZl3roL6jyaUuviIi7LrvK1XB8dBNzD
 blpye8aQqBB9dyXobFZqmWVtatUe61ruojB/tuzUXEEnlydIrgHOdaSZHXhqKUdOPcCJUzwWWSl
 ZCJzu70qH9+5MvrdQ4JwiqIqBhPpQNaNNmiCdIQgCkrMkbcjRwyk3ZWLOKQcP9J9gtOrSkbBmnc
 yXmCR9ouE9yGeN27BUZhLyTF/SUbW23RdZy3LN/hpw4ueaEm+Q/jxD6F0OA+phDAg2u0qfEwY0Q
 mdWU49u8Tf9nzbkeNEGeiQx7twuTtai0xrpL42OQh6kBPSsqN9D+lX7TnEGydGbO0V4CesIoB4g
 bDyBCTYhS+crXxZVvvtxSGBYdOB3s2xXztnTuuUOUQYacDM6zan43IM6m5tsfOcKGbF7CSwK/M4
 i5UA2cVYCtTRl8RxUmY6TXpDwcawxYWBWKdGfLZ7LryhMXZM3l+nEOFuW1msj9Ld3qt7SHOFGv9
 tclFE86r+hPCvjevOXTalrkLOuJ96XHp3DC7Lth2UlYIEo1c/uPqonFixmbPxdVrTY0fRA=
X-Received: by 2002:a17:907:6d24:b0:c25:4cff:5d01 with SMTP id
 a640c23a62f3a-c25571b1b5amr2076552066b.18.1788268674508; 
 Tue, 01 Sep 2026 06:17:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/58] hw/misc/mps2-fpgaio.c: add GPIOALT2 register
Date: Tue,  1 Sep 2026 14:16:54 +0100
Message-ID: <20260901131732.2263947-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

From: Simon Xu <simonxhy0404@gmail.com>

Add GPIOALT2 register for new an555 board.
Implement register access as RW with LOG_UNIMP for writes.
Add "has-gpioalt2" property to make each board configurable.
Add gpioalt2 vmstate subsection for device state migration.

Reviewed-by: Owen Giles <owen.giles@hpe.com>
Reviewed-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
Message-Id: <20260805153005.9989-10-simonxhy0404@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c              |  6 ++++++
 hw/misc/mps2-fpgaio.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/misc/mps2-fpgaio.h |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index d6d178642ba..79f53a0d09e 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -122,6 +122,7 @@ struct MPS2TZMachineClass {
     uint32_t fpgaio_num_leds; /* Number of LEDs in FPGAIO LED0 register */
     bool fpgaio_has_switches; /* Does FPGAIO have SWITCH register? */
     bool fpgaio_has_dbgctrl; /* Does FPGAIO have DBGCTRL register? */
+    bool fpgaio_has_gpioalt2; /* Does FPGAIO have GPIOALT2 register? */
     int numirq; /* Number of external interrupts */
     int uart_overflow_irq; /* number of the combined UART overflow IRQ */
     uint32_t init_svtor; /* init-svtor setting for SSE */
@@ -494,6 +495,7 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *mms, void *opaque,
     qdev_prop_set_uint32(DEVICE(fpgaio), "num-leds", mmc->fpgaio_num_leds);
     qdev_prop_set_bit(DEVICE(fpgaio), "has-switches", mmc->fpgaio_has_switches);
     qdev_prop_set_bit(DEVICE(fpgaio), "has-dbgctrl", mmc->fpgaio_has_dbgctrl);
+    qdev_prop_set_bit(DEVICE(fpgaio), "has-gpioalt2", mmc->fpgaio_has_gpioalt2);
     sysbus_realize(SYS_BUS_DEVICE(fpgaio), &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
 }
@@ -1350,6 +1352,7 @@ static void mps2tz_an505_class_init(ObjectClass *oc, const void *data)
     mmc->fpgaio_num_leds = 2;
     mmc->fpgaio_has_switches = false;
     mmc->fpgaio_has_dbgctrl = false;
+    mmc->fpgaio_has_gpioalt2 = false;
     mmc->numirq = 92;
     mmc->uart_overflow_irq = 47;
     mmc->init_svtor = 0x10000000;
@@ -1384,6 +1387,7 @@ static void mps2tz_an521_class_init(ObjectClass *oc, const void *data)
     mmc->fpgaio_num_leds = 2;
     mmc->fpgaio_has_switches = false;
     mmc->fpgaio_has_dbgctrl = false;
+    mmc->fpgaio_has_gpioalt2 = false;
     mmc->numirq = 92;
     mmc->uart_overflow_irq = 47;
     mmc->init_svtor = 0x10000000;
@@ -1418,6 +1422,7 @@ static void mps3tz_an524_class_init(ObjectClass *oc, const void *data)
     mmc->fpgaio_num_leds = 10;
     mmc->fpgaio_has_switches = true;
     mmc->fpgaio_has_dbgctrl = false;
+    mmc->fpgaio_has_gpioalt2 = false;
     mmc->numirq = 95;
     mmc->uart_overflow_irq = 47;
     mmc->init_svtor = 0x10000000;
@@ -1457,6 +1462,7 @@ static void mps3tz_an547_class_init(ObjectClass *oc, const void *data)
     mmc->fpgaio_num_leds = 10;
     mmc->fpgaio_has_switches = true;
     mmc->fpgaio_has_dbgctrl = true;
+    mmc->fpgaio_has_gpioalt2 = false;
     mmc->numirq = 96;
     mmc->uart_overflow_irq = 48;
     mmc->init_svtor = 0x00000000;
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index da78cb60701..208f9fd60fb 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -31,6 +31,7 @@
 REG32(LED0, 0)
 REG32(DBGCTRL, 4)
 REG32(BUTTON, 8)
+REG32(GPIOALT2, 0xc)
 REG32(CLK1HZ, 0x10)
 REG32(CLK100HZ, 0x14)
 REG32(COUNTER, 0x18)
@@ -142,6 +143,9 @@ static uint64_t mps2_fpgaio_read(void *opaque, hwaddr offset, unsigned size)
          */
         r = 0;
         break;
+    case A_GPIOALT2:
+        r = s->gpioalt2;
+        break;
     case A_PRESCALE:
         r = s->prescale;
         break;
@@ -210,6 +214,14 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
                       "MPS2 FPGAIO: DBGCTRL unimplemented\n");
         s->dbgctrl = value;
         break;
+    case A_GPIOALT2:
+        if (!s->has_gpioalt2) {
+            goto bad_offset;
+        }
+        qemu_log_mask(LOG_UNIMP,
+                      "MPS2 FPGAIO: GPIOALT2 unimplemented\n");
+        s->gpioalt2 = value;
+        break;
     case A_PRESCALE:
         resync_counter(s);
         s->prescale = value;
@@ -301,6 +313,24 @@ static void mps2_fpgaio_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static bool needed_gpioalt2(void *opaque)
+{
+    MPS2FPGAIO *s = MPS2_FPGAIO(opaque);
+
+    return s->has_gpioalt2;
+}
+
+static const VMStateDescription mps2_fpgaio_gpioalt2_vmstate = {
+    .name = "mps2-fpgaio/gpioalt2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = needed_gpioalt2,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(gpioalt2, MPS2FPGAIO),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription mps2_fpgaio_vmstate = {
     .name = "mps2-fpgaio",
     .version_id = 3,
@@ -317,6 +347,10 @@ static const VMStateDescription mps2_fpgaio_vmstate = {
         VMSTATE_INT64(pscntr_sync_ticks, MPS2FPGAIO),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &mps2_fpgaio_gpioalt2_vmstate,
+        NULL
+    }
 };
 
 static const Property mps2_fpgaio_properties[] = {
@@ -326,6 +360,7 @@ static const Property mps2_fpgaio_properties[] = {
     DEFINE_PROP_UINT32("num-leds", MPS2FPGAIO, num_leds, 2),
     DEFINE_PROP_BOOL("has-switches", MPS2FPGAIO, has_switches, false),
     DEFINE_PROP_BOOL("has-dbgctrl", MPS2FPGAIO, has_dbgctrl, false),
+    DEFINE_PROP_BOOL("has-gpioalt2", MPS2FPGAIO, has_gpioalt2, false),
 };
 
 static void mps2_fpgaio_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
index edd9f231212..75126866169 100644
--- a/include/hw/misc/mps2-fpgaio.h
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -40,11 +40,13 @@ struct MPS2FPGAIO {
     uint32_t num_leds;
     bool has_switches;
     bool has_dbgctrl;
+    bool has_gpioalt2;
 
     uint32_t led0;
     uint32_t prescale;
     uint32_t misc;
     uint32_t dbgctrl;
+    uint32_t gpioalt2;
 
     /* QEMU_CLOCK_VIRTUAL time at which counter and pscntr were last synced */
     int64_t pscntr_sync_ticks;
-- 
2.43.0


