Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3061BC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHH-0002Kq-Tr; Fri, 26 Jan 2024 09:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHB-0002EK-Ic
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNH9-0007s9-EQ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33adec41b55so143127f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279626; x=1706884426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HEc7i4Xgpnf10j5Y5ryc8bAt0O15wFZx7gUBthUTBOc=;
 b=LXA1JhHa3XiDCcf2Ag33XakAXiFH3/5L77zXh9XF6B9y2TnfvLKruwOo7PbAxy4+cS
 DOSS7/WvIG8AVnHPZkkeDlOQd7o4+AclbjTvEmz+cR1SJ01V0LtOJK1o8b/1yiS3uS86
 G4ncAFKWxj/InLsZf6JwCl3HGXLgtmcxK351Xp+6ERknTOfDxQE7U5Lx/BpyuRw5BWRV
 j3Gi637W0KL/aOKLkEZapokxHaru5TXRjuL5Tom35S3H3eUXUvG3QNnQBZjoWfDDYRJf
 6JbtvATgGVUbOt8PCw6T9EAEwtB4bd40GzBWcq7X66k2DZKHdp3kR/px1gYo2p4a1ftU
 xEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279626; x=1706884426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HEc7i4Xgpnf10j5Y5ryc8bAt0O15wFZx7gUBthUTBOc=;
 b=T9jwgG1RKoi+kq+svpELbW3VNVDTx4BetfCMeOwmwHjZMwWYFedhjE6P4bHBGyKKT/
 W7WmIJVjI5o5NyowGFKW9WX5Dmmn4nl/8DRZ9QoIFsKws9qS2F9SidB2PEzqcPNv7QA/
 cbiECSnJWzYW25FHvzUvNb7FDoGBlbjOYgUdNQm1eAsqivt7pjwjA7EHMdhPCSPJ0o4U
 fiMhWHPq7xSZxTjhZUyIl+OXD8YREu9uCbc7EnAeAOTVj7ZrJ5kZgZWmBzzf2dCLFa5d
 GVD902/jERynqPWrt7u+Q6xiEHe5T1hw1Dug1SVclTwbNoHbPO74JeKnTrxcCoSYwCOb
 Gcxg==
X-Gm-Message-State: AOJu0YyLGdD5PFMfjcNRIUAJMJgK7AIOgLUFxdFoRAMXng19Xy6ZGQ+i
 DuNvqisTkhtVZrxxavbndtActctTKVfI38VL1Ueo8GVJnnfq4YQ5lIvTyCes0HkHc2YDgUX+qEq
 M
X-Google-Smtp-Source: AGHT+IEBJsVcIccN1l8L3fD3K33Rqts/LmE+VB4VNCA563ESrfAyEp/c3IMlV7XWuGRjZdhk6LG3MQ==
X-Received: by 2002:adf:ca8d:0:b0:337:aa92:7835 with SMTP id
 r13-20020adfca8d000000b00337aa927835mr701798wrh.43.1706279626005; 
 Fri, 26 Jan 2024 06:33:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/36] hw/arm: Add AHCI/SATA controller to Allwinner R40 and
 Bananapi board
Date: Fri, 26 Jan 2024 14:33:13 +0000
Message-Id: <20240126143341.2101237-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Guenter Roeck <linux@roeck-us.net>

Allwinner R40 supports an AHCI compliant SATA controller.
Add support for it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20240115182757.1095012-3-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/bananapi_m2u.rst |  1 +
 include/hw/arm/allwinner-r40.h   |  3 +++
 hw/arm/allwinner-r40.c           | 12 +++++++++++-
 hw/arm/Kconfig                   |  1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index e77c425e2cb..542310591d6 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -22,6 +22,7 @@ The Banana Pi M2U machine supports the following devices:
  * EMAC ethernet
  * GMAC ethernet
  * Clock Control Unit
+ * SATA
  * TWI (I2C)
  * USB 2.0
 
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index ae82822d424..c589fcc1c15 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -22,6 +22,7 @@
 
 #include "qom/object.h"
 #include "hw/timer/allwinner-a10-pit.h"
+#include "hw/ide/ahci.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
@@ -46,6 +47,7 @@ enum {
     AW_R40_DEV_MMC1,
     AW_R40_DEV_MMC2,
     AW_R40_DEV_MMC3,
+    AW_R40_DEV_AHCI,
     AW_R40_DEV_EHCI1,
     AW_R40_DEV_OHCI1,
     AW_R40_DEV_EHCI2,
@@ -112,6 +114,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwSRAMCState sramc;
     AwA10PITState timer;
+    AllwinnerAHCIState sata;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     EHCISysBusState ehci[AW_R40_NUM_USB];
     OHCISysBusState ohci[AW_R40_NUM_USB];
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 2e8943eff74..534be4a735d 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -46,6 +46,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_AHCI]       = 0x01c18000,
     [AW_R40_DEV_EHCI1]      = 0x01c19000,
     [AW_R40_DEV_OHCI1]      = 0x01c19400,
     [AW_R40_DEV_EHCI2]      = 0x01c1c000,
@@ -93,7 +94,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "usb0-host",  0x01c14000, 4 * KiB },
     { "crypto",     0x01c15000, 4 * KiB },
     { "spi2",       0x01c17000, 4 * KiB },
-    { "sata",       0x01c18000, 4 * KiB },
     { "usb1-phy",   0x01c19800, 2 * KiB },
     { "sid",        0x01c1b000, 4 * KiB },
     { "usb2-phy",   0x01c1c800, 2 * KiB },
@@ -186,6 +186,7 @@ enum {
     AW_R40_GIC_SPI_MMC2      = 34,
     AW_R40_GIC_SPI_MMC3      = 35,
     AW_R40_GIC_SPI_EMAC      = 55,
+    AW_R40_GIC_SPI_AHCI      = 56,
     AW_R40_GIC_SPI_OHCI1     = 64,
     AW_R40_GIC_SPI_OHCI2     = 65,
     AW_R40_GIC_SPI_EHCI1     = 76,
@@ -285,6 +286,8 @@ static void allwinner_r40_init(Object *obj)
                                 TYPE_AW_SDHOST_SUN50I_A64);
     }
 
+    object_initialize_child(obj, "sata", &s->sata, TYPE_ALLWINNER_AHCI);
+
     for (size_t i = 0; i < AW_R40_NUM_USB; i++) {
         object_initialize_child(obj, "ehci[*]", &s->ehci[i],
                                 TYPE_PLATFORM_EHCI);
@@ -423,6 +426,13 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
 
+    /* SATA / AHCI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0,
+                    allwinner_r40_memmap[AW_R40_DEV_AHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_AHCI));
+
     /* USB */
     for (size_t i = 0; i < AW_R40_NUM_USB; i++) {
         g_autofree char *bus = g_strdup_printf("usb-bus.%zu", i);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4a2a5fca974..704517edd4f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -408,6 +408,7 @@ config ALLWINNER_H3
 config ALLWINNER_R40
     bool
     default y if TCG && ARM
+    select AHCI
     select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
     select AXP2XX_PMU
-- 
2.34.1


