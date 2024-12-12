Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE23E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 11:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLheW-0006r8-1n; Thu, 12 Dec 2024 06:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheU-0006qm-1F
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLheR-0007B0-Q0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 06:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gSRZ84p/o+uVH6BE0fgH48VInYzmzA5a6bI3xpxAUZ8=; b=KE6CK6xNTbiY4NnAzPRejQkjm/
 Bqf/WoUXBwdS62zHF+JQcAWmCj741HGmsxnHMVhK3huKDvCAIUUP16GVGjZQKB+FV35xzdQgtVaSA
 F2CgidKn72hyqB96la9kV9mh0Kpr8fX9K+QGoIijFlfYv9g9lA+bOjLJYeT9NNsIw2+FIj91fOVPw
 Dbd3Z6vUSLeI0nfQiJrqFWv+QuplPSjwlG4QL8W9Yx6Dv5Me3xNbhUqNJdzD/XMvNfjvdAokk7qPR
 TP9Y5Q/9o+GXnr+IEMEqkiK4bAiS0x/gTsnsGHQI1vwYj7LvgpayGmnE78LbToNbd0dyNz82UH0G+
 tW9Ro8pn2ESCkFBPHqYb+wuXjhuHWvpXn3rhpsphq+mCIkfzmBXdUWQZbXtOe2ZD1QMjpduLVKv5U
 ZHJQ7K0cu8QaBJnWqlqJKbFHFKPe0tDwT51tpy2S3qldCqPuwHM8Y65L4xH9Wl7ZkHtsBikSY+mkZ
 fdtrcGKbfJj6ZTH5ifQgfAL3JfK4QWumSrWAYumd9mhjXMnF0WCq4l7OwERhykIY4+jzEJLz2KovG
 jNsiGb6J475zVHeRzSYHSYgOci1vcDdpJCq7RIZCiC4S8+qq9r72DV7MtQyha/srEKcFvh8sOThtv
 QoOB9bqxs82pkR+Jge/fVyuBWQWIald14lK6esMpw=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLhdv-00070a-28; Thu, 12 Dec 2024 11:46:07 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 11:45:49 +0000
Message-Id: <20241212114620.549285-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 03/34] next-cube: create new next.scsi container memory
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
---
 hw/m68k/next-cube.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 550e7f0b0a..f95ed4a170 100644
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


