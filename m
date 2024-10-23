Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040FDD2E029
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDc-0000dY-Pz; Wed, 23 Oct 2024 04:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDa-0000a2-1n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDY-0000MW-HT
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=evm69BBfWFDM8NB+iqopEmx8dDp6vhesKr29nHSWe7k=; b=x55XxXhNN1W4TbtrCEvlgMFhHQ
 862lhD3jHbWl8GWpJahXG0NpxUwSpP8+vn+8lZEIFD/nIlZ88gPNrnqoJUk+Txk4raLFLfHXvHLg0
 PmtdYnZXsYJE60d30CUTKWc1se0m439kuy0x7EvWBrMwkkCyZCtcyQFLKC7/qb18QO9jmQcgJa1Ef
 nu0HiIXcdvIAFvB6yfcBf2j5ZU98DyK9kXmuItIuKhnJUaJidK088CnYZhKYFWr9BXUaRLNnx9ucE
 ntEdWaFNuF8dV8D/g3g5a4PrWyVPznjBtZ9a5v/B8rX7jHCzBML2kIwFnun90XR1sLAKCElqXx/NH
 kun+gxtJoVVk8EaaR5fQ9TQpQb9ORNsWpRCLcfK/mjwxJnzShqUxNcvfhkBfeVcVr/SoL4Owdo0jL
 56R6W2hFhuhv0ERrBT7faTUXbMAJeObefjMsMq+ssNejzp82DLf0csTdOSocajuuu7GP0WVDagzbX
 zt6zIaaes/oE0O0TAmuaByAY3G+JZzQHvBZ+M1xxCaenvQC3OPhNbR0PiNPiCdGmZa+yQKfRnsFV6
 3VsMm44PF0yJ5x3rEDo2CDhFyF5Iws21ZBmS/NUzfOAIDaJOdIiVOK0m46NDozeV7EUjSOEbfr1SM
 fwEhkCBBT45fIedBBkicYaSP1kpUXB4ojDwyeqNIY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDI-0008EL-5l; Wed, 23 Oct 2024 09:59:32 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:29 +0100
Message-Id: <20241023085852.1061031-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/36] next-cube: move ESCC to be QOM child of next-pc device
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

Since the ESCC is part of the next-pc device, move the ESCC to be a QOM child
of the next-pc device.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 54 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 7f714640da..915dd80f6f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -124,6 +124,8 @@ struct NeXTPC {
     qemu_irq scsi_reset;
     qemu_irq scsi_dma;
 
+    ESCCState escc;
+
     NextRtc rtc;
 };
 
@@ -978,31 +980,6 @@ static const MemoryRegionOps next_floppy_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void next_escc_init(DeviceState *pcdev)
-{
-    NeXTPC *next_pc = NEXT_PC(pcdev);
-    DeviceState *dev;
-    SysBusDevice *s;
-
-    dev = qdev_new(TYPE_ESCC);
-    qdev_prop_set_uint32(dev, "disabled", 0);
-    qdev_prop_set_uint32(dev, "frequency", 9600 * 384);
-    qdev_prop_set_uint32(dev, "it_shift", 0);
-    qdev_prop_set_bit(dev, "bit_swap", true);
-    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
-    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
-    qdev_prop_set_uint32(dev, "chnBtype", escc_serial);
-    qdev_prop_set_uint32(dev, "chnAtype", escc_serial);
-
-    s = SYS_BUS_DEVICE(dev);
-    sysbus_realize_and_unref(s, &error_fatal);
-    sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
-    sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
-
-    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
-                                sysbus_mmio_get_region(s, 0));
-}
-
 static void next_pc_reset(DeviceState *dev)
 {
     NeXTPC *s = NEXT_PC(dev);
@@ -1043,6 +1020,28 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
     /* Floppy */
     memory_region_add_subregion(&s->scrmem, 0x14108,
                                 &s->floppy_mem);
+
+    /* ESCC */
+    d = DEVICE(object_resolve_path_component(OBJECT(dev), "escc"));
+    qdev_prop_set_uint32(d, "disabled", 0);
+    qdev_prop_set_uint32(d, "frequency", 9600 * 384);
+    qdev_prop_set_uint32(d, "it_shift", 0);
+    qdev_prop_set_bit(d, "bit_swap", true);
+    qdev_prop_set_chr(d, "chrB", serial_hd(1));
+    qdev_prop_set_chr(d, "chrA", serial_hd(0));
+    qdev_prop_set_uint32(d, "chnBtype", escc_serial);
+    qdev_prop_set_uint32(d, "chnAtype", escc_serial);
+
+    sbd = SYS_BUS_DEVICE(d);
+    if (!sysbus_realize(sbd, errp)) {
+        return;
+    }
+    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(dev, NEXT_SCC_I));
+    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(dev, NEXT_SCC_DMA_I));
+
+    memory_region_add_subregion(&s->scrmem, 0x18000,
+                                sysbus_mmio_get_region(sbd, 0));
+
 }
 
 static void next_pc_init(Object *obj)
@@ -1064,6 +1063,8 @@ static void next_pc_init(Object *obj)
 
     memory_region_init_io(&s->floppy_mem, OBJECT(s), &next_floppy_ops, s,
                           "next.floppy", 4);
+
+    object_initialize_child(obj, "escc", &s->escc, TYPE_ESCC);
 }
 
 /*
@@ -1201,9 +1202,6 @@ static void next_cube_init(MachineState *machine)
         }
     }
 
-    /* Serial */
-    next_escc_init(pcdev);
-
     /* TODO: */
     /* Network */
 
-- 
2.39.5


