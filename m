Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB35CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIW6U-0006fy-GW; Thu, 30 Apr 2026 14:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW61-0006Xc-T7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:50 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW5i-0005Up-0u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:29 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so826242f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777573584; x=1778178384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3dVxY32CjowmtmVFCE73w8gSca6PnatFzVRgmRIRyW8=;
 b=acnyPf0+t86KbP2jZodTrLh9Qr0Q72onw3c2Lixrz2bb3ENzMB+TG/eoh2TWg5nRkq
 XxGWUf+zCQzlovq1De41iT0zXbpnl3v6Q/bovZK2hRVqf3iOg0/N5mZ4wfj6Lu8SyOzj
 wkbYiRnpBa4be9Ufketq6VmPkWP7XZt4ESdtnd6VxRrh3hquzvUp3LvqJy+CC4JgwYwK
 sjvyCko80y1RQ14ZKZD7mPZ38gZ/gHmzaE9DZaPCm2H3kt2U7Rkwon1CtYHEZASlrluC
 R7K0tw0te/PFN6O5MWCsP3AFNS0M59ZF86ieZRQNm2Y4WYayWb81XGe69YdTrJtyakAI
 Az1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573584; x=1778178384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3dVxY32CjowmtmVFCE73w8gSca6PnatFzVRgmRIRyW8=;
 b=QsKvgqh6dsjK9XnMZKXUaS4N5R77Uh/sm2Sjp0VgaTdWpEy56Io2MX25Oy70FTlpss
 VmxO3MucGPwjlf2DxfFuxeIDfsB8P2ng2Pt36PqXPBUnGqZsoUMXd5hb5haPpIjfR8Dt
 EaU88fYlQBEonKV8qSWla1rjCrwBC7eox9O7QOBLjS2IEeLsbkQfwx+Sy8b9tKVswcHi
 tiira799HI67kQ0enH5UZV7l9VrEfGbOraVHiGp0zQAbn3NxlM+/cvbwL3SpNCwDwfsP
 fx1JbjuePLt/zMIA7Q0pBGh4wCN1npGX02+41u5ie8FOYq253EaQPB4eVc3glpMnaRaw
 g2GQ==
X-Gm-Message-State: AOJu0YwMa09Z/1B21Lu58BX+fkl0I6Gk0IppKQZ+Hyc4DwxBSL4/ofFo
 vLSa3ortCRcMfEfLhb0nvZhC7x3KUhvx1VnVveDx7u9Qv2xO45FgMtNuXdx9lZ8r
X-Gm-Gg: AeBDievcsTfrLmBi9rkrM7RaDk/iZJPeSYjoCB8AyLBxI44K7iN7s+ZlnjnkQUYzOiR
 TvmJ+EO40rL4mrD/5x5IFDaEaEClTla9vJSR1Z8yqkfWwKgDNvrEasgzBNGTKPFkH2toGy4GmLL
 2qFqvTJuFpnR/pisdSF66kvneYBpYi1HQxWWSEY3VxB3ryYpk4nwk+E45lfSLxLcbYThLG4eX7y
 fvYlo+18YVyydMqFe5U1ZcKI3mArlmng871uO0SGGzVOa7wzcqumye9R+GQokGf9cjbL/lxnnKe
 ecvE3t7wrZcJUC8vEc0MHScDAMdavHvIsCiHJ1L8TX3tqqGQSWV9JNqCUyOJkDsbspRnuzkR+0E
 X3J2cZ1/ltzf28b1QtynLUtneBG3dH5vGcHWhbUT+mWT/t0iB7PxLV/VG6WkRc/2vSZt/OHRmz6
 Ey6fEL9tuvYb4MbO9hrmeaMkS5bVkqpe6bZAhwPaaZBekgxnd9P10VLzMpFyx2nl+h
X-Received: by 2002:a5d:588c:0:b0:43f:dfbc:8c71 with SMTP id
 ffacd0b85a97d-4493e2ba985mr7641432f8f.25.1777573584083; 
 Thu, 30 Apr 2026 11:26:24 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c00sm14674925f8f.25.2026.04.30.11.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 11:26:23 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v3 5/7] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
Date: Thu, 30 Apr 2026 20:26:07 +0200
Message-ID: <9e1dbfc5153fa1e952275f3cce30ddb60b423da8.1777571962.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777571962.git.matyas.bobek@gmail.com>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index c31752e83a..5bd0d0972e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -518,6 +518,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select CAN_FLEXCAN
     select WDT_IMX2
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f663ddbf0a..337921d17d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -90,6 +90,10 @@ static void fsl_imx6_init(Object *obj)
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
+    for (i = 0; i < FSL_IMX6_NUM_CANS; i++) {
+        snprintf(name, NAME_SIZE, "flexcan%d", i + 1);
+        object_initialize_child(obj, name, &s->can[i], TYPE_CAN_FLEXCAN);
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
+        s->can[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->can[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_abort);
+
+        sysbus_realize(SYS_BUS_DEVICE(&s->can[i]), &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->can[i]), 0, flexcan_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->can[i]), 0,
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
index cddd100dd6..8ea1677e86 100644
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
+    FlexcanState       can[FSL_IMX6_NUM_CANS];
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
2.53.0


