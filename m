Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F605D5B866
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVEol-0001IU-2d; Mon, 15 Dec 2025 15:05:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEof-0001Dw-VM
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:05:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1vVEoe-0008Ek-0A
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:05:09 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso19477695e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765829106; x=1766433906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZF9wwWcTLoFiuMQD2IDI2pw2UM1Zgmh8KdbQbm6V4OU=;
 b=HIhpR5T+6upqE1FJlvobTlZKNsNVCM+1RYJMzitW665Oht0xJkuVwUCaf/Rt+I1+Jy
 6P250i2bxybWmHTSyP4bhRFC6EecVLWM4WHCp3xPDhd57rMV4Jfmbj1QQBEEKO+4HAoi
 KVUA3tkLba0sjBxJEr94vbZh0yFsiUJOF0bhRtZm+L/RWc+zMX7a+wvZ0q+WVwnYpvKV
 v7/oh+26oZpbhWlgcOn1++Xdt4Rl+Y/gj4rGrOBfVtoO2DDensYYnOUZ2D13pgCA70Ua
 cU/hF7R5zhh+IEm/y0vJKodOY09D6VHAmkMnSova16MJYxpeQiisD+l7z//bBUtE66UZ
 7PDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765829106; x=1766433906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZF9wwWcTLoFiuMQD2IDI2pw2UM1Zgmh8KdbQbm6V4OU=;
 b=q3y1Tu/nh5UIdXKJwrI+GTi4p7nvQ40CkHDFm886MSq6TJzK01l65OXi8XlU1D7EhA
 O3KTqW+n5LddGZWQlObO7uQuGw0IacFH5NrMZ/j9iW2GnmiLmFUMesvyDciu2PheMXF6
 NTPc8UjVDTa71wbAnferEqUKzAsox/2BFD2kQbDqwCwpcprRlrzsrf3jG092TbEBor+j
 dvkz5E42QGLVdKRGkt1VxOJ//wpXk44Gtlg7vAgPyRzNk1AOrp10bMFI/Coz3xt0K53w
 G/q7UlXtz+5uH30bgqJQzggoQgdTCyY+0ml5H8pUvack+iHxcGOWpi2+ZWrdF7INh2+w
 vf9w==
X-Gm-Message-State: AOJu0Yx3dDIsf4TYlhQ4maodPpdgfjiI9p89OahayYAsV8vUV1Lk5SAP
 Nsl8iQGut+TqoWagA4dy/g96Mdam0Um3a62iy8DfLmiVdNqU7jzrpPmwywBwPw==
X-Gm-Gg: AY/fxX55N7nQC94SxW7QnOu8Pp116XRZyz//4va4V56ljf9bGI8F8hrmNhmnKKFXMhV
 pUQAYixEL79rsV7kgTzJKYUW5pDxPx5OlZm6pR30+C+KRAwkpQ7voRHmiY+QuT4/UBQWgmQ3eiX
 6F/nR2b4Un11h0B+4aQ2Pbw0Vs7BI7BxzLFbuBNtO5mjkRe3EdbEBPl0DHJbGuJfbmSUc3zPY8S
 XTkBuCZ6NCVfCH5bM1P+yQwRx/FMT7iBx/WXdrMNUcU5op3PYwC5+t8km33/MS/oqAxC0Z2JRZE
 z89Eqbj3UXFGYQdSb7V3x3Qf12uHgzVn24cUU67mtzHSMnAsKxe8DVn4KE3DcfOpjUROkev6ej2
 iEhKKAP52X+bkX3XRQXq3+GUi+Txy308wwkGoVgzIHF7R+PPN/69R1xJtHWzVV6h+JVfh8D0o7c
 zcrJHdhtr6CRKrfKQ+/WKiKuLa/glUte1p3QvEWrPpzaKEiTd6o9jD
X-Google-Smtp-Source: AGHT+IGGWzLkznCIEFVNzvowWp5Zx3eVJryUYk428PLU1cT5GURPo1d1vbvzb3oKVUK4N10k+iPeFQ==
X-Received: by 2002:a05:600c:4e49:b0:477:9caa:1a26 with SMTP id
 5b1f17b1804b1-47a8f90cb29mr120036685e9.29.1765829106305; 
 Mon, 15 Dec 2025 12:05:06 -0800 (PST)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f703efesm72603235e9.16.2025.12.15.12.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:05:05 -0800 (PST)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v1 4/6] hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
Date: Mon, 15 Dec 2025 21:03:13 +0100
Message-ID: <e3ce5bc65896f0cca0f641150ad09ddc2480d3e8.1765826753.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x336.google.com
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

FlexcanState is added to struct FslIMX6State like other peripherals.

Add two new machine properties to Sabrelite machine for linking
the embedded FlexCAN instances to QEMU CAN buses by name.
No other machine uses FslIMX6State.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
---
 hw/arm/Kconfig            |  1 +
 hw/arm/fsl-imx6.c         | 29 +++++++++++++++++++++++++++++
 hw/arm/sabrelite.c        | 18 +++++++++++++++++-
 include/hw/arm/fsl-imx6.h |  7 +++++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7877506384..76aa7fee57 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -530,6 +530,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select CAN_FLEXCAN
     select WDT_IMX2
     select PL310  # cache controller
     select PCI_EXPRESS_DESIGNWARE
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f3a60022d8..19656ba571 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -97,6 +97,10 @@ static void fsl_imx6_init(Object *obj)
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
@@ -379,6 +383,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
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
@@ -482,6 +507,10 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
 static const Property fsl_imx6_properties[] = {
     DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
+    DEFINE_PROP_LINK("canbus0", FslIMX6State, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", FslIMX6State, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
 };
 
 static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 29418af190..4bb8fe80d5 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -23,6 +23,7 @@
 typedef struct SabreliteMachineState {
     MachineState parent_obj;
     FslIMX6State soc;
+    CanBusState *canbus[FSL_IMX6_NUM_CANS];
 
     struct arm_boot_info binfo;
 } Sabrelite;
@@ -65,6 +66,13 @@ static void sabrelite_init(MachineState *machine)
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
@@ -118,7 +126,15 @@ static void sabrelite_machine_instance_init(Object *obj)
 {
     Sabrelite *s = SABRELITE_MACHINE(obj);
 
-    (void)s;
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link,
+                             0);
+
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link,
+                             0);
 }
 
 static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 124bbd478f..8edbcebe46 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -30,11 +30,13 @@
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/imx_spi.h"
 #include "hw/net/imx_fec.h"
+#include "hw/net/flexcan.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/or-irq.h"
 #include "system/memory.h"
+#include "net/can_emu.h"
 #include "cpu.h"
 #include "qom/object.h"
 
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
@@ -80,6 +84,9 @@ struct FslIMX6State {
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
     uint32_t           phy_num;
+
+    /* CAN bus. */
+    CanBusState       *canbus[FSL_IMX6_NUM_CANS];
 };
 
 
-- 
2.52.0


