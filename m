Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360A0E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfz-0002EP-W1; Thu, 12 Dec 2024 06:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfy-00026D-Fc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfw-0007MM-Qi
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=UYNUshFfgGNoRs+U4AXdqH33zcSPYwwXRL/pz6Z6RNc=; b=z8iHvk/IICVGiF+WbGm3/th+0h
 wVRm1qxFXjEKW8cbeiKx9lMB6rjlNbBT6GW6AJh8GqZJc+z8tGnXIEGOkvwJ+z+MF17n91+ecJ+ys
 z5HJ1BCf33PXRkVhS2EXlfvjsajQ/6a/dHdDT/2khuSIzaCrD2BYHJ3qY+VEM6IOz63FdygrGIZI2
 syoSXxw9hIB7dV8x0ofzRxcqT55HBrR5pYih+ffKcXDzG6BfWK8g8GYhjx4IVvLNIEbw7z+fVvNoD
 E9qqEdq/M82ZcjSLrHy17iP7L53WJvU8037rot3Hmc+FiKSCtKSNBHAHr/0xHO7M2QFFKWy49lwA7
 BHhXvWOuIfxP/fujqFIbNldbJuyA0Tl+I0DgWhU2IY8iwIMrB98OduzmE/1azrWWQqqxglHcx3O8S
 aob5biM7m73Rl1z1wHwzxDyu3wJBf5NV4lgUDog18M/lv1qc1wG2TUuiNoHePGUrXSRbqzske7Zv7
 zq6XK+g6eTYNlmcjqFvzsKDt8lDToKS/iacvEWzYAKpX0mf2qPvaj0eyRkCdxYsf6eTEFHpHyWcB/
 RueDN4hxaxcMso3xnBflMsxRq8N++1eqDe/PyN3pXdh3TZBzXVF/u4Jkn0qc3BSEBsMWUPDflc7Sv
 re4GkKYa23zfv+1z2NXWEiw90dqRwwfAOQxP0N5Wo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfC-00070a-HL; Thu, 12 Dec 2024 11:47:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:13 +0000
Message-Id: <20241212114620.549285-28-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 27/34] next-cube: move rtc-data-in gpio from next-pc to
 next-rtc device
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

Add a new rtc-data-out gpio to the next-pc device and wire it up to the next-rtc
rtc-data-in gpio using the standard qdev gpio APIs.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index a7a8b3cbbf..35eeeb0d59 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -105,6 +105,7 @@ struct NeXTPC {
 
     NeXTRTC rtc;
     qemu_irq rtc_power_irq;
+    qemu_irq rtc_data_irq;
 };
 
 typedef struct next_dma {
@@ -179,8 +180,8 @@ static bool next_rtc_cmd_is_write(uint8_t cmd)
 
 static void next_rtc_data_in_irq(void *opaque, int n, int level)
 {
-    NeXTPC *s = NEXT_PC(opaque);
-    NeXTRTC *rtc = &s->rtc;
+    NeXTRTC *rtc = NEXT_RTC(opaque);
+    NeXTPC *s = NEXT_PC(container_of(rtc, NeXTPC, rtc));
 
     if (rtc->phase < 8) {
         rtc->command = (rtc->command << 1) | level;
@@ -274,13 +275,10 @@ static void next_scr2_rtc_update(NeXTPC *s)
         /* If we are in going down clock... do something */
         if (((old_scr2 & SCR2_RTCLK) != (scr2_2 & SCR2_RTCLK)) &&
                 ((scr2_2 & SCR2_RTCLK) == 0)) {
-            qemu_irq rtc_data_in_irq = qdev_get_gpio_in_named(
-                DEVICE(s), "rtc-data-in", 0);
-
             if (scr2_2 & SCR2_RTDATA) {
-                qemu_irq_raise(rtc_data_in_irq);
+                qemu_irq_raise(s->rtc_data_irq);
             } else {
-                qemu_irq_lower(rtc_data_in_irq);
+                qemu_irq_lower(s->rtc_data_irq);
             }
         }
     } else {
@@ -1028,6 +1026,12 @@ static void next_rtc_reset_hold(Object *obj, ResetType type)
     memcpy(rtc->ram, rtc_ram2, 32);
 }
 
+static void next_rtc_init(Object *obj)
+{
+    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
+                            "rtc-data-in", 1);
+}
+
 static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 3,
@@ -1057,6 +1061,7 @@ static void next_rtc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo next_rtc_info = {
     .name = TYPE_NEXT_RTC,
     .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_rtc_init,
     .instance_size = sizeof(NeXTRTC),
     .class_init = next_rtc_class_init,
 };
@@ -1128,6 +1133,9 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(d), errp)) {
         return;
     }
+    /* Data from NeXTPC to RTC */
+    qdev_connect_gpio_out_named(dev, "rtc-data-out", 0,
+                                qdev_get_gpio_in_named(d, "rtc-data-in", 0));
 }
 
 static void next_pc_init(Object *obj)
@@ -1166,8 +1174,8 @@ static void next_pc_init(Object *obj)
     s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
     qdev_init_gpio_in_named(DEVICE(obj), next_pc_rtc_data_in_irq,
                             "pc-rtc-data-in", 1);
-    qdev_init_gpio_in_named(DEVICE(obj), next_rtc_data_in_irq,
-                            "rtc-data-in", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->rtc_data_irq,
+                             "rtc-data-out", 1);
 }
 
 /*
-- 
2.39.5


