Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5072E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLdJ-000182-0s; Sun, 22 Dec 2024 08:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaa-0005vK-EI
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:45 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaZ-0000mE-2G
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=0n2ocJEQqvXgvNZcTWPnLKxPrbd1AKABIpnoHOYzFyc=; b=PqlVoiddmrIgdHx8Mz/nRBBeTD
 +c1YtZPmUYW/izzwtW6Ev9H4hLhDRRdPIyYtFof/L3Vw1UWAXTBs6tfD0+XQFzUgtVtnVz3GcJtLw
 AvPBFjZhls0Ak7w5AhKpNiieGxrvRYf8Hyo/kUL51Twp3OviLmo97CyozYDCnoLA90ChQs7E3SR2Q
 Xl09uh6SsljsL3hAQnzhGESXYqqqimT8noLzG11Pr7bv+epz/shhVG+bGojWYBH/nJ32QjtCI4mGk
 MNpZ3bhkKXbCiVR5x0hIadgVGieXk0OET1bx5XaYtggbbUIgkbFt4xGUwX8fR46RbUn5N3j6mQauO
 lcay4vxaTvX6n79EqvRL0pjs8JqCUJGuIzBneUW61tJxLi8/Js/dzAyFz5ZMsAujQRTqw8+gNJJZI
 cozhq2KakV1aQnG07uDsiJv41El7dJEBpHHjPUUdlgZ9ds8SVoKQeaMdaVtraMIgO146h1XML2x0j
 /CxO9tG/09nUALiSQz1c+i/9K0YrGfgak0U8V5CDJsFqTy5TeuTcczSNx9JVyKAeqC4GZt1GVMQTN
 Qhm7oh6MHjGPgaONUweiJcCbssxo3VTryqrLK4xfhnPZ5WF2vUonTShjz1H0wbwOA5h/J73CJpt/0
 LystFb30XghcBHLGA6Kuh9IU2y3e610imYEGf3s5Y=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZm-0002L7-5S; Sun, 22 Dec 2024 13:00:57 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:58 +0000
Message-Id: <20241222130012.1013374-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 19/33] next-cube: use qemu_irq to drive int_status in
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
index 830ed17e68..39cc883fd0 100644
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


