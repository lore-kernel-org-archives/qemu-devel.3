Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA16C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWG7-0003bL-DP; Mon, 10 Feb 2025 11:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thWG5-0003au-QO; Mon, 10 Feb 2025 11:03:41 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1thWG3-000753-2y; Mon, 10 Feb 2025 11:03:41 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8FA664E6033;
 Mon, 10 Feb 2025 17:03:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ULhHOK9T2hcW; Mon, 10 Feb 2025 17:03:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DDA7F4E600E; Mon, 10 Feb 2025 17:03:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/sd/sdhci: Set reset value of interrupt registers
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
    philmd@linaro.org
Message-Id: <20250210160329.DDA7F4E600E@zero.eik.bme.hu>
Date: Mon, 10 Feb 2025 17:03:29 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

The interrupt enable registers are not reset to 0 on Freescale eSDHC
but some bits are enabled on reset. At least some U-Boot versions seem
to expect this and not initialise these registers before expecting
interrupts. Use existing vendor property for Freescale eSDHC and set
the reset value of the interrupt registers to match Freescale
documentation.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: Restrict to e500. Adding a reset method in a subclass does not
work because the common reset function is called directly on register
write from the guest but there's already provision for vendor specific
behaviour which can be used to restrict this to Freescale SoCs.

 hw/ppc/e500.c         | 1 +
 hw/sd/sdhci.c         | 4 ++++
 include/hw/sd/sdhci.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 26933e0457..560eb42a12 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1044,6 +1044,7 @@ void ppce500_init(MachineState *machine)
         dev = qdev_new(TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint8(dev, "sd-spec-version", 2);
         qdev_prop_set_uint8(dev, "endianness", DEVICE_BIG_ENDIAN);
+        qdev_prop_set_uint8(dev, "vendor", SDHCI_VENDOR_FSL);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
         sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC85XX_ESDHC_IRQ));
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 99dd4a4e95..afa3c6d448 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -307,6 +307,10 @@ static void sdhci_reset(SDHCIState *s)
     s->data_count = 0;
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
+    if (s->vendor == SDHCI_VENDOR_FSL) {
+        s->norintstsen = 0x013f;
+        s->errintstsen = 0x117f;
+    }
 }
 
 static void sdhci_poweron_reset(DeviceState *dev)
diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 38c08e2859..f722d8eb1c 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -110,6 +110,7 @@ typedef struct SDHCIState SDHCIState;
 
 #define SDHCI_VENDOR_NONE       0
 #define SDHCI_VENDOR_IMX        1
+#define SDHCI_VENDOR_FSL        2
 
 /*
  * Controller does not provide transfer-complete interrupt when not
-- 
2.30.9


