Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D845E77183
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfT-0007rH-9P; Thu, 12 Dec 2024 06:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfQ-0007jE-VH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:41 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhfP-0007I1-IX
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=P/frkQP0PmukM3oGKgbUARxtABmTAXuVIIXp+J+2TYc=; b=YqauidBfrUBqoYYclFf/j70ocM
 gimQVcebOZKuqUzLC70N0513O5th48G3/20sMCoMXuiVRywjNY3o5BQLqh7FKio9aRC+7rngYDZXg
 2TmePrw+2sHajyREib6KOHyykdOvaPH5Zn7OgtHT43avgnZTYf6QLFaACoqfedJLlsCuZF3Thed4V
 mX1lBTJOjsI8q7r1ljlh48BerJ03SxOwjqfZVjW4VbGq/q33REcLNuboP0P65sSZ7CfviZZSN8qZS
 PnihgZY+gWtkKLyGOWWWHfGghlstd/E10MnS4jtMAhtqWBeYuBWv8uQNalfNY4aL7HY4MwwkC/gpo
 dbmQf1tO9kQDY2MQFhzCp/HEoHEw/XSxYHkFJamTd2j1aaDQHLkMOTl/3Rbb6xnu5HRR9rUfF2WqC
 y/tzGflMJhKH+nfutXenDOy9yzi2CW9QYf9af4yb76uB9iKGrfjojtHZ8TqyV9jsL28bFTJxQMAao
 wMZUacOfyUtaFBecQNOxBhUmyjFMPqjpuYErivSd3waepM7hazX4Hm23jaCLg2buZ9a34MJWByXZv
 QDBOPsWiI8TNALTuEUfcp76wirE0t3tvKJfccjSH6/pUfKnlIx1HoX9rpRMRXTRtPtG3OZf+pqdy/
 xogOIbhl/G8fq9rK5juxSA7C26HdC/Sk9kbp1qDcY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheh-00070a-GF; Thu, 12 Dec 2024 11:46:57 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:46:05 +0000
Message-Id: <20241212114620.549285-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 19/34] next-cube: use qemu_irq to drive int_status in
 next_scr2_rtc_update()
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

Rather than directly clear bit 3 in int_status in next_scr2_rtc_update(), use
a qemu_irq to drive the equivalent NEXT_PWR_I signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0b07cd1a75..7c6dc132fe 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -98,6 +98,7 @@ struct NeXTPC {
     ESCCState escc;
 
     NeXTRTC rtc;
+    qemu_irq rtc_power_irq;
 };
 
 typedef struct next_dma {
@@ -267,7 +268,7 @@ static void next_scr2_rtc_update(NeXTPC *s)
                     /* clear FTU */
                     if (rtc->value & 0x04) {
                         rtc->status = rtc->status & (~0x18);
-                        s->int_status = s->int_status & (~0x04);
+                        qemu_irq_lower(s->rtc_power_irq);
                     }
                 }
             }
@@ -1093,6 +1094,8 @@ static void next_pc_init(Object *obj)
     memory_region_init_io(&s->timer_mem, OBJECT(s), &next_timer_ops, s,
                           "next.timer", 4);
     sysbus_init_mmio(sbd, &s->timer_mem);
+
+    s->rtc_power_irq = qdev_get_gpio_in(DEVICE(obj), NEXT_PWR_I);
 }
 
 /*
-- 
2.39.5


