Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F0FC3DA61
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2024 22:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVfSZ-0005ds-9C; Sun, 21 Jul 2024 18:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sVfSW-0005cs-3m; Sun, 21 Jul 2024 18:55:17 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sVfSS-0007xC-W9; Sun, 21 Jul 2024 18:55:14 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A9FE64E6000;
 Mon, 22 Jul 2024 00:55:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id gPugac4jC7r3; Mon, 22 Jul 2024 00:55:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B32704E6039; Mon, 22 Jul 2024 00:55:06 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hw/i2c/mpc_i2c.c: Fix mmio region size
To: qemu-devel@nongnu.org,
    qemu-trivial@nongnu.org
Cc: philmd@linaro.org
Message-Id: <20240721225506.B32704E6039@zero.eik.bme.hu>
Date: Mon, 22 Jul 2024 00:55:06 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The last register of this device is at offset 0x14 occupying 8 bits so
to cover it the mmio region needs to be 0x15 bytes long. Also correct
the name of the field storing this register value to match the
register name.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/i2c/mpc_i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index cb051a520f..06d4ce7d68 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -82,7 +82,7 @@ struct MPCI2CState {
     uint8_t cr;
     uint8_t sr;
     uint8_t dr;
-    uint8_t dfssr;
+    uint8_t dfsrr;
 };
 
 static bool mpc_i2c_is_enabled(MPCI2CState *s)
@@ -293,7 +293,7 @@ static void mpc_i2c_write(void *opaque, hwaddr addr,
         }
         break;
     case MPC_I2C_DFSRR:
-        s->dfssr = value;
+        s->dfsrr = value;
         break;
     default:
         DPRINTF("ERROR: Bad write addr 0x%x\n", (unsigned int)addr);
@@ -319,7 +319,7 @@ static const VMStateDescription mpc_i2c_vmstate = {
         VMSTATE_UINT8(cr, MPCI2CState),
         VMSTATE_UINT8(sr, MPCI2CState),
         VMSTATE_UINT8(dr, MPCI2CState),
-        VMSTATE_UINT8(dfssr, MPCI2CState),
+        VMSTATE_UINT8(dfsrr, MPCI2CState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -329,7 +329,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error **errp)
     MPCI2CState  *i2c = MPC_I2C(dev);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
     memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
-                          "mpc-i2c", 0x14);
+                          "mpc-i2c", 0x15);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
     i2c->bus = i2c_init_bus(dev, "i2c");
 }
-- 
2.30.9


