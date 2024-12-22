Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C619FE7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdT-0002Fe-Qh; Sun, 22 Dec 2024 08:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLan-0006Bv-V8
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:02:07 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLal-0000p6-QT
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ceI7/UMZpo6UqpGncQLJnM9zNfx5YW+rnPoAZubGHVc=; b=AyVZX91JsTPsGUkANyJGFhoeJa
 Q5SBG09E4DH350xR9Jv8H65APaU4c+T1la+8Jc+1ZUvcWxUbezqgg5Bks/YgRSYISglmGheWJESmS
 CPOO+iZB1cfnFIhCLAZyYcOqarHPVr+hVHntEWY7CngvSivYwJQqULgOfCaL+90DwSQ/eM9MXKScB
 0U3zW0zbV8VkxxMgaSmOljIpK5SYlZiqxZZMdr2bZwqFYcwP8VMH9y2LKlnLURLvRxOlJ6+fEKuLx
 P5DqGJVtUo++hZhey5hwYeFEcSijCBWva8JsDSI77HsPe6KfXBT06eBErj/j++GWmvVHQ7+YVy7JB
 4hFzviAvhPI8rCE04/P1NfW3U/EfGGa26a/KG1dj86VMjKnRDG262Nyv92rsuXSeZXckCTQPfiUYA
 mnRuO5Lo7/fKAf+HjtUJGWH1znAFUree26UmHuY9//9UsvHkrr0w0ZsT8JCf5T62eFi3mbwHhZ4GT
 Kxe8G8MTdF3pSKJhvEhiFPDX6KqddantRDn1mJzYG+FQL3l9P4FyQltD9RN6V17jVxBiBs2nV+os2
 8W+AXowsj4JBQmTbd9N+yyyMcOokWKvFO0mEjP0wtyEfQdJNc4o+tdaY+T4kKhJ8f7cE5bs2JjaT8
 VB1/5f86zjAiJANbVEO4mNcnW+42CT+jT6rEFtZ/8=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZy-0002L7-Hy; Sun, 22 Dec 2024 13:01:10 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 13:00:01 +0000
Message-Id: <20241222130012.1013374-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 22/33] next-cube: use named gpio to set RTC data bit in scr2
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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 1fb09fee7d..bc3afa7d54 100644
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


