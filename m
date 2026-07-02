Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6622C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLU-0007vp-Un; Thu, 02 Jul 2026 14:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLN-0007XF-W1
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:41:02 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLI-0005ZF-PS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:41:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-493be1b9682so16022955e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783017655; x=1783622455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up8FV2HuMbPxWSZlYmqknqCP4ZGv1LSFUSsUpf/V/tg=;
 b=Wh+Eklko33hJGSEMA/D3DJZux1rcjvT068QA0GNvTbVj3YSaXajRzgruiDyytZa3ww
 gaI6YcKl1w2CxiYGU+6iJswF7+2nYvhhvCHYHAHWIlwWKWbPuEm1OQhk+TyeaUYFT/GH
 blbeYuVmnQAxfQhZDMmlqmblYMrP+qYAoyxXrj+dTWUxW7Bg43/O1idA0i9ur7clSnag
 JxbGNxZHA34eBpnJyR0Jq4fQ3yHLXqklQBh2bCh2xP7qiJO7HWoq1klYnSw0LzRZpLEb
 MznOvYfCm7btb+H5GL3BMVaBfRtKiWaD2jkl7sUnAbbyVYj+oCw8TFkd5YlpD4S2qI9K
 SgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017655; x=1783622455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=up8FV2HuMbPxWSZlYmqknqCP4ZGv1LSFUSsUpf/V/tg=;
 b=Dtd762Cmgrmo1nuc1V8d6JldJU38mYE0m5zxrYGoK9LEmE3mhGYgEbcNtLcxqe5Zek
 GlpZl0NCWNItWlFI4pl2t6M93QcYL8pa0EUns7AVSa8idAfC59VGRBEPa/Cpbw6xmoln
 ixoLW7wVo7QA2gDHM8f73FYLpbTYeaIATlyujKirT2HfFBUMO+YHNqGhm+Fd2/sttyys
 ABSrDcXD6AYxS+GNSHu5MeBXBUFPFuGnj9GK2JGq6Fx2KpiRmJz0WnVT1Z+ATZRH85dX
 eT0lVy/A6S/vpXzD6f6RT8UG/wnnlz1HDR/U5J/WaqfzKKGRPfEnmkNtY2KdADt7trMl
 F8QA==
X-Gm-Message-State: AOJu0YzZ6FFS6GR39aTSDi83m9SrcVyzhns5P+JvGxJqBZpXCRqIIziL
 a1kgKl0w5kK4nRSuiFnYsrKASyXl+a0RScjjRBEUPNUHEAxMZMoSY9dnicPgDw==
X-Gm-Gg: AfdE7ckLYAmOpwGKdK75efLUtty3zTeS1ARzefuR4VmAGYiqbWuXlLxGh7NT1rSaOyh
 122ax4++Izm125Xw5THrRyjaDf6P6A0mClWEKN3GHjl44pZZVDDd+MucdqkrRhG3AwuprYDU8NA
 llLB6fSfe5UEC23gFWE2IXNh9YjYgsonhd/mk37MoP+LyGMMJrCPlRNYNLMBcveMDhoNupAaxiL
 cUYZnR9SwYv9cx2dWOBVLEJnQnHyoCDI1AglfVYQAIuIbN/GrPxpTvCOzAf7XCeday7nbeY2rvD
 oYIrJVohd81dyZhBdSV07/d6JT93U+ZbJGkTuPWsYJlu8305aMXgJMAgIU1B1IQVHSRYf+PRkb8
 eIwDsA95yINhGTk3O/tXUfFb5DVMFcr3cdnaBvOtHwbD1S7vxY0/wJEo9RLsZu+hx1Fg84D86As
 Fc907olpKB9T/eVN8XmrZgiNRXNFlWmw4jFTVXDbPMMgrEIGXBTv0CkPBWazQOAviOo14lvGyTs
 qinUSanwSVie/pQBcdFM+2ma2Cb7eStgEhN
X-Received: by 2002:a05:600c:8590:b0:493:b7a6:3dac with SMTP id
 5b1f17b1804b1-493c2ba5810mr84595485e9.33.1783017655184; 
 Thu, 02 Jul 2026 11:40:55 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-25c8-8a00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c8:8a00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm120271225e9.1.2026.07.02.11.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:54 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH v2 5/5] hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP
 and imx8mp-evk
Date: Thu,  2 Jul 2026 20:40:38 +0200
Message-ID: <20260702184038.178196-6-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
References: <20260702184038.178196-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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

Real hardware supports CAN FD which is missing in the emulation and is
considered future work. Still, CAN communication already works under Linux.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/system/arm/imx8m.rst   |  1 +
 include/hw/arm/fsl-imx8mp.h |  8 ++++++++
 hw/arm/fsl-imx8mp.c         | 38 +++++++++++++++++++++++++++++++++++++
 hw/arm/imx8mp-evk.c         | 21 ++++++++++++++++++++
 hw/misc/imx8mp_ccm.c        |  3 +++
 hw/arm/Kconfig              |  1 +
 6 files changed, 72 insertions(+)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index afbc33b2f4..1bcb8255be 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -18,6 +18,7 @@ following devices:
  * 1 Designware PCI Express Controller
  * 1 Ethernet Controller
  * 2 Designware USB 3 Controllers
+ * 2 FlexCAN 3 CAN Controllers (``imx8mp-evk`` only)
  * 5 GPIO Controllers
  * 6 I2C Controllers
  * 3 SPI Controllers
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 3b6183ed1d..2be3c51af5 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -17,6 +17,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/net/flexcan.h"
 #include "hw/net/imx_fec.h"
 #include "hw/core/or-irq.h"
 #include "hw/pci-host/designware.h"
@@ -37,6 +38,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 #define FSL_IMX8MP_RAM_SIZE_MAX     (8 * GiB)
 
 enum FslImx8mpConfiguration {
+    FSL_IMX8MP_NUM_CANS         = 2,
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
@@ -68,11 +70,14 @@ struct FslImx8mpState {
     USBDWC3            usb[FSL_IMX8MP_NUM_USBS];
     DesignwarePCIEHost pcie;
     FslImx8mPciePhyState   pcie_phy;
+    FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       ocram;
 
     uint32_t           phy_num;
     bool               phy_connected;
+
+    CanBusState       *canbus[FSL_IMX8MP_NUM_CANS];
 };
 
 enum FslImx8mpMemoryRegions {
@@ -279,6 +284,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
     FSL_IMX8MP_PCI_INTD_IRQ = 123,
     FSL_IMX8MP_PCI_MSI_IRQ  = 140,
+
+    FSL_IMX8MP_FLEXCAN1_IRQ  = 142,
+    FSL_IMX8MP_FLEXCAN2_IRQ  = 144,
 };
 
 #endif /* FSL_IMX8MP_H */
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 7c03ed3c34..bcd91739d9 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -246,6 +246,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->wdt[i], TYPE_IMX2_WDT);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        g_autofree char *name = g_strdup_printf("flexcan%d", i);
+        object_initialize_child(obj, name, &s->flexcan[i], TYPE_CAN_FLEXCAN3);
+    }
+
     object_initialize_child(obj, "eth0", &s->enet, TYPE_IMX_ENET);
 
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
@@ -669,6 +674,34 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
+    /* FlexCANs */
+    for (i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } flexcan_table[FSL_IMX8MP_NUM_CANS] = {
+            {
+                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN1].addr,
+                FSL_IMX8MP_FLEXCAN1_IRQ
+            }, {
+                fsl_imx8mp_memmap[FSL_IMX8MP_FLEXCAN2].addr,
+                FSL_IMX8MP_FLEXCAN2_IRQ
+            },
+        };
+
+        object_property_set_link(OBJECT(&s->flexcan[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
+                                 OBJECT(s->canbus[i]), &error_abort);
+
+        sysbus_realize(SYS_BUS_DEVICE(&s->flexcan[i]), &error_abort);
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                        flexcan_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->flexcan[i]), 0,
+                           qdev_get_gpio_in(gicdev, flexcan_table[i].irq));
+    }
+
     /* On-Chip RAM */
     if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
@@ -684,6 +717,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         switch (i) {
         case FSL_IMX8MP_ANA_PLL:
         case FSL_IMX8MP_CCM:
+        case FSL_IMX8MP_FLEXCAN1 ... FSL_IMX8MP_FLEXCAN2:
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
@@ -715,6 +749,10 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 static const Property fsl_imx8mp_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected, true),
+    DEFINE_PROP_LINK("canbus0", FslImx8mpState, canbus[0], TYPE_CAN_BUS,
+                     CanBusState *),
+    DEFINE_PROP_LINK("canbus1", FslImx8mpState, canbus[1], TYPE_CAN_BUS,
+                     CanBusState *),
 };
 
 static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index ca0ee2d3f2..16e9722d14 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -26,6 +26,7 @@ struct FslImx8mpEvkState {
     MachineState parent_obj;
 
     FslImx8mpState soc;
+    CanBusState *canbus[FSL_IMX8MP_NUM_CANS];
 
     struct arm_boot_info boot_info;
 };
@@ -86,6 +87,12 @@ static void imx8mp_evk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX8MP);
     object_property_set_uint(OBJECT(&s->soc), "fec1-phy-num", 1, &error_fatal);
+    for (int i = 0; i < FSL_IMX8MP_NUM_CANS; i++) {
+        g_autofree char *bus_name = g_strdup_printf("canbus%d", i);
+
+        object_property_set_link(OBJECT(&s->soc), bus_name,
+                                 OBJECT(s->canbus[i]), &error_fatal);
+    }
     sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
@@ -122,6 +129,19 @@ static const char *imx8mp_evk_get_default_cpu_type(const MachineState *ms)
     return ARM_CPU_TYPE_NAME("cortex-a53");
 }
 
+static void imx8mp_evk_machine_init(Object *obj)
+{
+    FslImx8mpEvkState *s = IMX8MPEVK_MACHINE(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[0],
+                             object_property_allow_set_link, 0);
+
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&s->canbus[1],
+                             object_property_allow_set_link, 0);
+}
+
 static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -140,6 +160,7 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .name = TYPE_IMX8MPEVK_MACHINE,
         .parent = TYPE_MACHINE,
         .class_init = imx8mp_evk_machine_class_init,
+        .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
         .interfaces = aarch64_machine_interfaces,
     },
diff --git a/hw/misc/imx8mp_ccm.c b/hw/misc/imx8mp_ccm.c
index 911911ed86..97d363e79d 100644
--- a/hw/misc/imx8mp_ccm.c
+++ b/hw/misc/imx8mp_ccm.c
@@ -129,6 +129,9 @@ static uint32_t imx8mp_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
     case CLK_HIGH:
         freq = CKIH_FREQ;
         break;
+    case CLK_CAN:
+        freq = 40000000; /* 40Mhz, taken from device tree */
+        break;
     case CLK_IPG:
     case CLK_IPG_HIGH:
         /*
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5f5c4899ad..0416ba823c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -600,6 +600,7 @@ config FSL_IMX8MP
     imply I2C_DEVICES
     imply PCI_DEVICES
     select ARM_GIC
+    select CAN_FLEXCAN
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
-- 
2.55.0


