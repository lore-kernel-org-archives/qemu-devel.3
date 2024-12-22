Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A53EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLZi-00055H-EF; Sun, 22 Dec 2024 08:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZV-00053F-Ba
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:38 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZS-0000Zt-0m
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=xpbqi5MPloLCqAu6nBXYDhUpUya24zqYngDy7Um/6dA=; b=Meemdi7A8WYVosxklZ4clHeyFJ
 wDIbwQEEsTF0MEz6wxZRfd9G41D5JAQkxd6H/yYjfOSrqEMO6D5Jq+ipYKbHrezkQG+GG7XsUnQmT
 JQCgBT1haRpYAL/8cso0TowNzsQIWxsCN0P1Ml7uUq+D7DcGLfiEg70Z60QZhDXKjYTYfHI9bHmo4
 Rk7LoOP9UJq2j+QjTRf8yeSf+swctP0aUUttCxdsxBiV6V5lOaCYidYu5sr67KK9B1DNq4KaWmJi0
 DZLbt06HcQ/SyZ1bef+6uCr6uhwcPctjooejS8PMbi91JCmj7g4LchYsHtS51rd6JUMqTgkdSDExE
 kDXFU4LEX/w22ZgUsLIXHvlcyg+s+nWHx+II8Mk9v2yo2XIDkfWBAmHVXeb0+/tqW5cgnVft/gDhH
 qUym1X+erwzIlWVOGU/PDlGbRjAOrDSL8gODuO8ID7cqmAsVjG463qGktNuYoSjzG9LhsCY4cgCmd
 XABTPS87RvfHfq0xPDsliTJ8wN8wyCzetErZeNszqw13bigAI7gAFjk/sbHOD4lgjrRXndfPYm3Nf
 ekSZp7MA8M3UZufmMuJc10VCYr9f+Z5+I4YRQlOZlMw73ZHluZNJVj3Ni48K+dOf3WvSZ08riUUqi
 cqt5l5c1mnpOT3LjirZ3qPnKpI7NKiwPM6zLtEoHk=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLYo-0002L7-IT; Sun, 22 Dec 2024 12:59:58 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:42 +0000
Message-Id: <20241222130012.1013374-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 03/33] next-cube: create new next.scsi container memory
 region
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

Move the ESP SCSI and SCSI CSR registers to the new next.scsi container memory
region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index f918998182..58b4762ecd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -94,6 +94,7 @@ struct NeXTPC {
 
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
+    MemoryRegion scsimem;
 
     uint32_t scr1;
     uint32_t scr2;
@@ -843,7 +844,12 @@ static void next_scsi_init(DeviceState *pcdev)
     sysbusdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbusdev, &error_fatal);
     sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(pcdev, NEXT_SCSI_I));
-    sysbus_mmio_map(sysbusdev, 0, 0x2114000);
+
+    memory_region_init(&next_pc->scsimem, OBJECT(next_pc), "next.scsi", 0x40);
+    memory_region_add_subregion(&next_pc->scsimem, 0x0,
+                                sysbus_mmio_get_region(sysbusdev, 0));
+
+    memory_region_add_subregion(&next_pc->scrmem, 0x14000, &next_pc->scsimem);
 
     next_pc->scsi_reset = qdev_get_gpio_in(dev, 0);
     next_pc->scsi_dma = qdev_get_gpio_in(dev, 1);
-- 
2.39.5


