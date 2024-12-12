Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA577E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLhfG-0006yz-AP; Thu, 12 Dec 2024 06:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheq-0006uc-Dx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:05 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheo-0007EB-22
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=mPL0mA6GmeXe4+/ZbC2Xbi8t4/wlTO5peNBXEd6WPOw=; b=vk7ZM34C96o8LIZj8oa2CQQp0M
 d1zSZEJZSGnAI9glZmlldfxspL03x9/bd5yoIB4iAek56d6zxKYmqumSDVic0mc16bSaGUabBVXyB
 AgSBaHZNUnF9q6H9hdLEPbbU8So1f76XFQlF8M/SjIJirvw8R4ZQDVWM3ORgbl+UoXnjxxtHfdKN/
 XTuUY4jwahfz1J5t0D4izpxtJwb2iPb5EzNF1pmIhjP8b+zqDTzSR1wsL/72jFkluSV8bWJ11tB92
 ec5BSR7QnMQfuP+h1csT9RX4Mv04B+Buy+2J1x+4ZrzY2ArVKH6voAetPQ/Syj5rIVJwFpukr6Yyf
 U7xrZrawCCHmAru10Krlao7gQLB04krZyj83M02edRFGVbQlf6bN2ud92blPfMQQ8AYaemSNMpz80
 8yLA9YCQU0z7kjvIkNBpYGiK9gr2evNrPzdqy6F+ZMf5Hj3KgaC+4UKSGB3jT8E3jb+JiLBbPwDQI
 giVgTY+PTDDvyF+Fm8tN0K8v7fzUTBLADZyVzw83JpGgbQ4wz+eBH7EYPn8rbj0DMK6M9GlTkyeZy
 X5YPZmPlZUA9lzNIxxpD8qhB/ceK0qlYOyLS9ObYXdAG+XIfuPahiShnIa+xaC/zJEwNt9GASb2gd
 uBSMseu3Sav1CysQ8VvqFKdEAWGgZK3Q2qL4UAxr4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheD-00070a-GA; Thu, 12 Dec 2024 11:46:29 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:56 +0000
Message-Id: <20241212114620.549285-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 10/34] next-cube: map ESCC registers as a subregion of the
 next.scr memory region
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

Since the ESCC device exists within the memory range of the next.scr memory region, map
the ESCC device registers as a subregion of the next.scr memory region instead of
directly to the system address space.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index d08026ccf9..efbb11e74b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -980,6 +980,7 @@ static const MemoryRegionOps next_floppy_ops = {
 
 static void next_escc_init(DeviceState *pcdev)
 {
+    NeXTPC *next_pc = NEXT_PC(pcdev);
     DeviceState *dev;
     SysBusDevice *s;
 
@@ -997,7 +998,9 @@ static void next_escc_init(DeviceState *pcdev)
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
-    sysbus_mmio_map(s, 0, 0x2118000);
+
+    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
+                                sysbus_mmio_get_region(s, 0));
 }
 
 static void next_pc_reset(DeviceState *dev)
-- 
2.39.5


