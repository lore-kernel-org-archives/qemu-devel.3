Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7658D2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XES-0002V9-Ol; Wed, 23 Oct 2024 05:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEF-0002F4-LC
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XEB-0000bi-4e
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=plgyIRELuJgsSWoEKO5PlBOncWGcc+Kig0rZ6sIFh1w=; b=NHhBHOIKTimS3ozza1YqldFhTf
 tq6dwY0vGcXpkvSrn5F0DBQ/v4lBI+wOUcvS2fED4CR2khud+tEPS8tM4MKCzHSbvpkSnsz5OIoSu
 S2ANtd9WGwm2iM7qaL3GNZzyOAjdcL9/+pewhLv/0fbv9/f+6yROHTbJDGEovIHWmqDO5l1VOYRvF
 NPMsQOTbKWiS5G0MEVPjNsv4LueFlfnq1BSeQLIW0oQp3MiNkvBseL1c5YkY/ZeJpoqcx+4pZYJv5
 RaJ3w/h8F73cQWlhEIG9T3C9kBScC/EPpn99d7pP6fvGMqY3zyQuU8EojZiIQ/bhLlCEvs6z0ZJHU
 AIclL6Na+H1Ud6PSTHEsR7T0H1/J7j3UMycLV7SYsjlvnTjqu0gOBS8etKpEcrL18/vWp1pgDbzMu
 Xb0HH3Ix2I2y22lKA1PkU0XFUR1u3E8PjBPBZIlK73FFR8zfArK1L0iP13KNdJD606X82ZZjIrQ0t
 KhUmvGetcGjbFc2o01vQkYyPM7IaBes0GJoF8oTD6zyHrtzl9PXfqeKwY1hZCHLpbLp7hs1kn1jlW
 Qa4INI9D4xpQJWPBIk5Dj7BWBnF2BFMT8Q0jEV+Tqsi/73/KZB0LJSieeKgvnC8fYBORI2LyfVCU8
 G/cRYW/EzpZWGm/nBrMQnHOw+DOpdr1+kSAe18kY4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDg-0008EL-Vh; Wed, 23 Oct 2024 10:00:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:37 +0100
Message-Id: <20241023085852.1061031-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 21/36] next-cube: use qemu_irq to drive int_status in
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
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 33297f01b8..bb375b63ca 100644
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


