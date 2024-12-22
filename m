Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC5FE7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLcf-0007Ru-9Q; Sun, 22 Dec 2024 08:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZw-0005Hg-SW
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:20 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZs-0000gK-Dj
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EDjKG0MR9wst3TyCsLTmFTNz1h59/lIe/yxqED+heiM=; b=wPdni01XS2os8mpnVWGgw+d57s
 BoVGYtGAHv0a9W/IgyYMNvj0p3djxfpPg2YuEB8oiEthyVegoZlCrbDjREeP/S20HcCcZTTPOuQaJ
 jzfayaDMX7mUyKsPodPq20MUthYK/ydoQSHdMWBIGGHdWDyZverRlae6vXee3OPoQeYRi2//p4dYI
 QvLcIIfZzZVblihb7Qu1/laymwb8uM09ZCKntaW4nwi1wBhW6SD0PMA27HkpfevPqWtF/wqXYZZv7
 BoGUHOPfsOci5V5orTR24CGSwS11TeN/k4rdVxfwZL4sDsdgqSDb1TKzI/rHEQeAbteR7Yl1huq8R
 pm02luc15PTrpVldC0YaSTlj+K5i9jU+kWpak0MtMszlSJphl4KvptGL02OP4gAUrHD3hpTavw5sN
 T2d8Yf+DL0kzEusZCEfbGHNlspX14eLseb0x1qsIvZReUjPXqn85wtHufNuE8v7LuRBv9HYVtXRCm
 ZIcBo2cqpIt5KfAoAm310s9FMm3PJrR2nhfCWVDjNBr6z+mbkBBk0vimRwdzR4mAj8ho9Fm6JunOS
 5jhTCzTioaT3nH8DiaEM8opoJBFOEnMytvHQrda6R5hN0Qjn2F0oR2xMfM71k1mmtmEA0xo46nAsE
 wS9eo1RhAmf4VBlWNhwBF9I2/mO3gyT0wU9A2ZJ8o=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZE-0002L7-Sg; Sun, 22 Dec 2024 13:00:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:49 +0000
Message-Id: <20241222130012.1013374-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 10/33] next-cube: map ESCC registers as a subregion of the
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9c0ddf91f8..4b175cd9ab 100644
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


