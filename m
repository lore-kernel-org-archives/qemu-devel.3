Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34161CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhCv-0006gV-T2; Mon, 22 Jun 2026 12:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCL-0006N9-QW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCJ-0006kN-Nj
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:33 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490b3637b90so35759085e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782144510; x=1782749310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ln8LVse1Hr1HieXuRLz/DSdUQM+FEfUXoey8nULdcDY=;
 b=OaW3phME8/bOc7eZKjX9BjbI0EG1XlsVjvQ8yZ2Mr1Kt9s0ssC8pKygZVz2uD+mEI6
 7dhbz/N+T4/1NqKpRHR2jozgd+AW/uiI0jEI9Ex34cf+tIskD168c8x07JSvGpBfbWBD
 dIEuOer7Cog89Q83NbBTivKJh1crSjLvjyIOYVlsF3yoWGcIGnLVALQ9Tq2bmKzCIuum
 UrGlSH4z6KJn+GlaN1NNsjT/3uSIkqurTXt9Qk8e/W7nfDz4iq0FSf88jPURVsJ7yO/D
 uQC8y5dMhngLh61ysx3ipnNlmiaDXmVeR1fvWESq+4SPliNy9KUaJDlie6Z377S/YN90
 LpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144510; x=1782749310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ln8LVse1Hr1HieXuRLz/DSdUQM+FEfUXoey8nULdcDY=;
 b=hnh5/McW0Db/jvo6fOY6haZ5McSe6KCJPbggCd0B8iOM2Er8i2PV7ZExs6dtAzG2Xk
 I3u5yaVZit7Tidyj549mC2cKIvcij1LBk11SNu3zbuHtkR6SsLhtubYjpeF5BoelPW0f
 7bjY3trjdf+4PX/5m8q5vT5Gko9C4jlxXKEouVoE5lgsZCll3tT8QL/Gxfat42bJwyrv
 VIGeuHtgzXUuo/DlyS+sco9TnwHLBHk/Ri2cz42S9RqAq5rPIxqWnxkIZP6iiQSaSIis
 rFbNaGQnyIdWlxTXb9cYY1Ve9eXlLzXKB49Dp0r/VrS09rjo1pWUc4yakoVIw3lOkecQ
 SPUA==
X-Gm-Message-State: AOJu0YxLG91TPd9+Ycb+gcEjlx2MlkrxYsZNPfX7T/sJDHzufYqE4gwK
 UI8hlP2v2hc4d0jBW//tWqKsW2UrmTCvAD/pc8XcGa3U2TL1j8wzg6Uda22Nn6p8
X-Gm-Gg: AfdE7cmBcfufu2yjPBxWGnmbuGNDSF/gevvkUNrf7KePk/FL/c1LJRU47Cw0jBZ0h+y
 IMyOHdzqzxvTT1uInzYIg1C9CltFdMELB7IgbdQqKoFQMz1urGD8PNwXXGATawXSUhaWxhlBX97
 mipjMYJ+ewSmwc1R7LjBnubG15UKlFTfjDUQ9zgfHAtLOteovuLG9AQM/AK8ibpssJYzeeVFa7W
 y9sy0GvDRi7Zj8OEDkQEZBrOZI/FCw+lgG9I3AReIH8dNCCfabKf45C9qdKQxQEG1OrgqIYPxcm
 1CktJMsSJL8lSb97ga91PTzgQW+uhLAXcenl9zzqONK2umo//baxP4m5mLmnhwVzn2GbCxVMBNS
 PQNpRkDpcctMWXX5KcnMF3uSEooH1wRDzjvx7LF5Qb7G231BgLswCvfk+H1kPur0qnU8TpLVtDI
 fsq0t9Tt2c8599YPt/s1j8PeHypMFasc12eNy0m0OPlY+DZGjYWtq9Hw==
X-Received: by 2002:a05:600c:46cc:b0:492:5889:ee4d with SMTP id
 5b1f17b1804b1-4925889ee90mr31597935e9.24.1782144509928; 
 Mon, 22 Jun 2026 09:08:29 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm225062545e9.9.2026.06.22.09.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 09:08:29 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v6 5/7] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
Date: Mon, 22 Jun 2026 18:08:10 +0200
Message-ID: <4159df998b0508bb411284ef406de23bbc5edfd8.1782140438.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782140438.git.matyas.bobek@gmail.com>
References: <cover.1782140438.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

FlexcanState is added to the FslIMX6State struct like other peripherals.

Add two new machine properties to Sabrelite machine for linking
the embedded FlexCAN instances to QEMU CAN buses by name.
No other machine uses FslIMX6State.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 hw/arm/Kconfig            |  1 +
 hw/arm/fsl-imx6.c         | 29 +++++++++++++++++++++++++++++
 hw/arm/sabrelite.c        | 24 ++++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h |  6 ++++++
 4 files changed, 60 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 500bfdfe2a..5f5c4899ad 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -520,6 +520,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select CAN_FLEXCAN
     select WDT_IMX2
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f663ddbf0a..bf106a9063 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -90,6 +90,10 @@ static void fsl_imx6_init(Object *obj)
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
+    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN);
+    }
     for (i = 0; i < FSL_IMX6_NUM_WDTS; i++) {
         snprintf(name, NAME_SIZE, "wdt%d", i);
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
@@ -377,6 +381,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gic, spi_table[i].irq));
     }
 
+    /* Initialize all FLEXCANs */
+    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } flexcan_table[FSL_IMX6_NUM_CANS] = {
+            { FSL_IMX6_CAN1_ADDR, FSL_IMX6_FLEXCAN1_IRQ },
+            { FSL_IMX6_CAN2_ADDR, FSL_IMX6_FLEXCAN2_IRQ },
+        };
+
+        s->flexcan[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_abort);
+
+        sysbus_realize(SYS_BUS_DEVICE(&s->flexcan[i]), &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0, flexcan_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                           qdev_get_gpio_in(gic, flexcan_table[i].irq));
+    }
+
     object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num,
                              &error_abort);
     qemu_configure_nic_device(DEVICE(&s->eth), true, NULL);
@@ -480,6 +505,10 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
 static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
+    DEFINE_PROP_LINK("canbus0", FslIMX6State, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", FslIMX6State, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
 };
 
 static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 7e036e6388..84bbc2f979 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -24,6 +24,7 @@ struct SabreliteMachineState {
     MachineState parent_obj;
 
     FslIMX6State soc;
+    CanBusState *canbus[FSL_IMX6_NUM_CANS];
 };
 
 #define TYPE_SABRELITE_MACHINE MACHINE_TYPE_NAME("sabrelite")
@@ -64,6 +65,13 @@ static void sabrelite_init(MachineState *machine)
     /* Ethernet PHY address is 6 */
     object_property_set_int(OBJECT(&s->soc), "fec-phy-num", 6, &error_fatal);
 
+    for (int i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        g_autofree char *bus_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), bus_name,
+                                 OBJECT(s->canbus[i]), &error_fatal);
+    }
+
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
@@ -112,6 +120,21 @@ static void sabrelite_init(MachineState *machine)
     }
 }
 
+static void sabrelite_machine_instance_init(Object *obj)
+{
+    SabreliteMachineState *s = SABRELITE_MACHINE(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link,
+                             0);
+
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link,
+                             0);
+}
+
 static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -128,6 +151,7 @@ static const TypeInfo sabrelite_machine_init_typeinfo = {
     .name          = TYPE_SABRELITE_MACHINE,
     .parent        = TYPE_MACHINE,
     .class_init    = sabrelite_machine_class_init,
+    .instance_init = sabrelite_machine_instance_init,
     .instance_size = sizeof(SabreliteMachineState),
     .abstract      = false,
     .interfaces    = arm_machine_interfaces,
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index cddd100dd6..376deea3a4 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -30,12 +30,14 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/net/flexcan.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
+#include "net/can_emu.h"
 #include "qom/object.h"
 
 #define TYPE_FSL_IMX6 "fsl-imx6"
@@ -51,6 +53,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_WDTS 2
 #define FSL_IMX6_NUM_USB_PHYS 2
 #define FSL_IMX6_NUM_USBS 4
+#define FSL_IMX6_NUM_CANS 2
 
 struct FslIMX6State {
     /*< private >*/
@@ -73,6 +76,7 @@ struct FslIMX6State {
     IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
     ChipideaState      usb[FSL_IMX6_NUM_USBS];
     IMXFECState        eth;
+    FlexcanState       flexcan[FSL_IMX6_NUM_CANS];
     DesignwarePCIEHost pcie;
     OrIRQState         pcie4_msi_irq;
     MemoryRegion       rom;
@@ -80,6 +84,8 @@ struct FslIMX6State {
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
     uint32_t           phy_num;
+
+    CanBusState       *canbus[FSL_IMX6_NUM_CANS];
 };
 
 
-- 
2.54.0


