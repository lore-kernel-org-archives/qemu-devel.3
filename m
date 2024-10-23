Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C78D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XEX-0002wA-O0; Wed, 23 Oct 2024 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XES-0002XV-TF
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEP-0000cf-1y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=zqxGnF/qV7BdR0oz3jvXLm+F7TTOtd3gMdpcwNcWh1c=; b=Q3XSDVyrJvu8byKfWx/uruwxhJ
 N0KMfGmC+f2gtWe9uDxrMTBDz/vnc3HTH+fsN7dBvMDVNH8Z46PHqxq8dcg+8aF4QOI2kBskdQw6w
 dNNnCXEtuUtz53HMNTnrdjrJM/G902IOa/pYQmooLs2konYZndKfGF4IBxe0paTx5uv7BBGqAeeli
 kegVY+CSB/U8AHZ2HrkkEKXmpd7/kAzuMd8J6D9JqeEPYX7lcy/XBCGfcpjcbXBm27q+quXFsu4Gn
 0MGOc5jG154nT82Q9+GdDJBwOczU1ayk5xClOBiDXL06H1DMS3htCCh6dXQN9COV3dJjTEaygnILO
 T66xT9Sms9O7LEeDBJL11fNNTXJ8VyqBP/xexgJ0EFrHFogMsq4Mob8g/pEQBvYrOCP8Gd+I5YMwN
 35L4Y8gWYEmsty8Fe7BR3fhsg6sLnejwUL8+pyIHfkQt72hp70idmeKzMw6lmQXsL4AkeskSu7DXU
 0tHBeGlUD4h3XwUv6DXLsOeCu2RGcNF25nMzKyJO/xPXQ+B60F+Mn+xFX2juDI/QwhQ8vuqKWFlNu
 iKOQ9h2fa14FxOwTeuH5dBychQNk0HPmM5vdzyvSTJM1GWPIinReKrtvhvy03jIfp7213xtr15gpw
 g+QjCElSIhh1DqMcRmUBP8AeQk8P35rsESaQ1Y810=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDu-0008EL-F8; Wed, 23 Oct 2024 10:00:14 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:40 +0100
Message-Id: <20241023085852.1061031-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 24/36] next-cube: use named gpio to set RTC data bit in scr2
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This is in preparation for moving NeXTRTC to its own separate device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index bca975065f..2a2e970830 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -240,10 +240,13 @@ static void next_scr2_rtc_update(NeXTPC *s)
                                  ((scr2_2 & SCR2_RTDATA) ? 1 : 0);
                 } else {
                     /* Shift out value to read */
+                    qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
+                        DEVICE(s), "pc-rtc-data-in", 0);
+
                     if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
-                        scr2_2 |= SCR2_RTDATA;
+                        qemu_irq_raise(rtc_data_in_irq);
                     } else {
-                        scr2_2 &= ~SCR2_RTDATA;
+                        qemu_irq_lower(rtc_data_in_irq);
                     }
                 }
             }
@@ -270,8 +273,6 @@ static void next_scr2_rtc_update(NeXTPC *s)
         rtc->command = 0;
         rtc->value = 0;
     }
-
-    s->scr2 = deposit32(s->scr2, 8, 8, scr2_2);
 }
 
 static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -1001,6 +1002,20 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static void next_pc_rtc_data_in_irq(void *opaque, int n, int level)
+{
+    NeXTPC *s = NEXT_PC(opaque);
+    uint8_t scr2_2 = extract32(s->scr2, 8, 8);
+
+    if (level) {
+        scr2_2 |= SCR2_RTDATA;
+    } else {
+        scr2_2 &= ~SCR2_RTDATA;
+    }
+
+    s->scr2 = deposit32(s->scr2, 8, 8, scr2_2);
+}
+
 static void next_pc_reset_hold(Object *obj, ResetType type)
 {
     NeXTPC *s = NEXT_PC(obj);
@@ -1087,6 +1102,8 @@ static void next_pc_init(Object *obj)
     sysbus_init_mmio(sbd, &s->timer_mem);
 
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
+    qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
+                            "pc-rtc-data-in", 1);
 }
 
 /*
-- 
2.39.5


