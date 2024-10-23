Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050E0D2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDC-00081h-Fx; Wed, 23 Oct 2024 04:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDB-00080t-H9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDA-0000KA-5n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/DrqSKmnp9M+9bamXDATfF7q+7CGyrvwvqhVWuUYqXU=; b=pEpgqSVdog1NmfM5p0EUI4yqQ5
 UW3W6uI0UoGhfPuqYhxsy8zwCxAEvAHMI3fFLqZgGqZLikzOElLUUCTMIVCD9RWbMXgbep06nBOpk
 NeJacqhzPLcxWFzJ/5zZEZjZ0pXcmp9IEB+V8U53Otmfu28tHVvojOSkWbc2INDIpRA5LiM1fyFqC
 hWONBqbGANQr4JlhS/O98jmetJmBTR1KlOb/UmHarsBjOwCplWRDUC6Y7yQ4f6y9LZ/jnUKt50emc
 fXRPahSIlYfMjAxLgbTgSY/5r7TMc71elvLYrti7eYDF4lIGZQApXzPsTAbn1XwL+tNhvVkOVpH0K
 DTKX4QW72jzy0IVT2V59PzXtgTzdc7V9BkQ94qOOOFf+rBQzJpJgdvQ7LdO3pz/EtWEcmehBnYSNI
 gKFyYC/ZaAyqeQo14UYr9YllYFKC7cnlWeHAP8wRJMsO23XOvKTaPFOlLzBJdrSWhPPL9perBlUTT
 DdmGmfdh2+F6YLm8mIY1jeyYN0R7xb6CbUR9ANH7DJeSP/+Ds3AQhnGFcLUF1T6rwlQL/RfiYEHqb
 FfzmsgrfSo1PsNLXiN4290xovijafeORxGzAKbqGDGHstVk+LXwmYde6BXE5cx12pqrMtXCGfx4Kz
 XvgmPmiJx/Hc2I8xmrZv3H5qwEipDPTn5bCljYj5c=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XCp-0008EL-Tm; Wed, 23 Oct 2024 09:59:08 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:21 +0100
Message-Id: <20241023085852.1061031-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 05/36] next-cube: create new next.scsi container memory region
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
index 6bdd91c9c6..9e457fdf12 100644
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


