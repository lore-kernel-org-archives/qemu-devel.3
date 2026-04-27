Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8065AFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLOZ-0000GB-Rw; Mon, 27 Apr 2026 08:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNQ-0007nV-0a
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNN-0005U3-Ip
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b150559bso81056025e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294068; x=1777898868; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dWl2agwSOZcRjYpLQ3Cbs8b4kpJoVPljgBk5DCsC6g4=;
 b=Lsa3H0steqKDbBusivLgOa6aP07Q5uWefcRr2SCLBhcLvI7smYsIK6X9ghmfSbNG93
 GZHspMNmJq9M5EEGvU/9FzO4GDUt89Pxt3LFbd5jbsEzOkHYNqMG5v5PxP8sxBWBmzYY
 HOYTZQDrCfpoqrqeq8b3dCjIma5VF2p58FT+ekGtCx3bDgH5ITLNRd+wVS46tmVwe2/0
 h058eigl9Gx3qm605FSzvoBMZFdd3qjtgP07okHdCPdyshoOt2VwljZkLzpDj26XI45t
 h/ffx7Ob2ozYrS4xEOwXuhUJESJW6jWdDDvoKN00VqYyuaxd+12XYQzc1w6qkk5tNF7V
 XntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294068; x=1777898868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dWl2agwSOZcRjYpLQ3Cbs8b4kpJoVPljgBk5DCsC6g4=;
 b=W2lDeQdKAXqTTHgZm1LBj1G1QdQ+ch6Y/XXv/LeQNCDWplPzPGqX0XYBI1PdTkxBNB
 OMLVPIWvKVV+vXaArvcpwuVhVvOJiV2k5aUvrwXLHIfBMgalHtyU1cUOcen/9Zxv//Id
 /IlhK6CoY0TEwJzetQGV6KgmqDwLR/FKpOObuk1FKubjyEL61TgHofakiSz8Iv0QzNtZ
 zsRpQzWGWqJhPe9Wg0oFP2CNFzJYL/+Z59nMOgtxhKRGF5xKfu0NydL4LRaysZd2fpel
 QDI4JzQ1MpjovINpQsrUJ7Hvvse1iaoG7NwHyT9mqK2DaCedgmJjOyTay+tYAZZPwBOA
 6Z6Q==
X-Gm-Message-State: AOJu0YxI9QtAeIUjhdUoleHc7Nsc8yt4E8up06bYOygwivxsHWu2qytV
 h3fboJhqzNoIN4oniLBAl6l3YUEasqnziTn0+N9llE/V+H45zbP+J+yOj++ciEfmJ/jnWFKjGlU
 Y7xLQ
X-Gm-Gg: AeBDieunHIdfLeApNMXCY4+RzIPsjSvoUkrdmMXLTDbOu7Qgf/RusQU4nPCXEx1s7Yk
 ZE/HLL/VNgytfA6T0/wtswRzzEMpuqy0o2J0NcHcTyWfxWQa7vdG6f4wcusZjJjx299XhJgINu/
 uxTTX9hjFdP0qk2qR7W2UyO2KJEM77hyVGUAJamkJDF0lcoeG8kiIcIqxk7RS6FvRl6o7o1AGtZ
 DfmSaRl91zEyZ7OJWXWbNPEMzTuESvNeQPe0B+HhMDpFwrA1bO38Rm1prHgB/Q/lqu+u3G5O5zS
 CgtknInucvtKebxoOeu6RH67T0jDkmawpwutxB1bd76oKTm9C3lkrQM0Y7Iz+H21KehJe8wjPGd
 S+W8FpM8In1i56EwEGk0XzRRhL4zGffko2eTM4nKt9zED1htGnrLIOf4GlF8hAlBJQWeIFPHLqJ
 0G5exZb2Q1BCB8curOTzopvRRHkdSjxdAkaMoa/wBT9qpeDcZ3RnMjIoi15h0tIw0VsaSwn3YHA
 NN9278fvr0gd3p6svWQ8TYzbI9OiVKmNGqGgjsyUQ==
X-Received: by 2002:a05:600c:8b28:b0:48a:5c23:cab with SMTP id
 5b1f17b1804b1-48a5c230e78mr327201915e9.19.1777294067989; 
 Mon, 27 Apr 2026 05:47:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/63] hw/arm/fsl-imx8mm: Adding support for I2C emulation
Date: Mon, 27 Apr 2026 13:46:44 +0100
Message-ID: <20260427124738.966578-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

This can be used to test and debug I2C device drivers.
Added I2C interrupts

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  2 ++
 hw/arm/fsl-imx8mm.c         | 27 +++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h |  8 ++++++++
 3 files changed, 37 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 59d5aba2db..e8296f9a28 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -620,10 +620,12 @@ config FSL_IMX8MP_EVK
 config FSL_IMX8MM
     bool
     imply PCI_DEVICES
+    imply I2C_DEVICES
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select IMX_I2C
     select SDHCI
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 85bce5a788..3632d85197 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -180,6 +180,11 @@ static void fsl_imx8mm_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
+        g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
     for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
         g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
@@ -370,6 +375,27 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mm_memmap[FSL_IMX8MM_OCRAM].addr,
                                 &s->ocram);
 
+    /* I2Cs */
+    for (i = 0; i < FSL_IMX8MM_NUM_I2CS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MM_NUM_I2CS] = {
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C1].addr, FSL_IMX8MM_I2C1_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C2].addr, FSL_IMX8MM_I2C2_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C3].addr, FSL_IMX8MM_I2C3_IRQ },
+            { fsl_imx8mm_memmap[FSL_IMX8MM_I2C4].addr, FSL_IMX8MM_I2C4_IRQ },
+        };
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c[i]), errp)) {
+            return;
+        }
+
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c[i]), 0, i2c_table[i].addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c[i]), 0,
+                           qdev_get_gpio_in(gicdev, i2c_table[i].irq));
+    }
+
     /* GPIOs */
     for (i = 0; i < FSL_IMX8MM_NUM_GPIOS; i++) {
         static const struct {
@@ -477,6 +503,7 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
         case FSL_IMX8MM_GPIO1 ... FSL_IMX8MM_GPIO5:
+        case FSL_IMX8MM_I2C1 ... FSL_IMX8MM_I2C4:
         case FSL_IMX8MM_PCIE1:
         case FSL_IMX8MM_PCIE_PHY1:
         case FSL_IMX8MM_RAM:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 4fe27b9575..d6df16e9d4 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -13,6 +13,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
@@ -32,6 +33,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mmState, FSL_IMX8MM)
 enum FslImx8mmConfiguration {
     FSL_IMX8MM_NUM_CPUS         = 4,
     FSL_IMX8MM_NUM_GPIOS        = 5,
+    FSL_IMX8MM_NUM_I2CS         = 4,
     FSL_IMX8MM_NUM_IRQS         = 128,
     FSL_IMX8MM_NUM_UARTS        = 4,
     FSL_IMX8MM_NUM_USDHCS       = 3,
@@ -46,6 +48,7 @@ struct FslImx8mmState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXI2CState        i2c[FSL_IMX8MM_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
@@ -174,6 +177,11 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_UART3_IRQ    = 28,
     FSL_IMX8MM_UART4_IRQ    = 29,
 
+    FSL_IMX8MM_I2C1_IRQ     = 35,
+    FSL_IMX8MM_I2C2_IRQ     = 36,
+    FSL_IMX8MM_I2C3_IRQ     = 37,
+    FSL_IMX8MM_I2C4_IRQ     = 38,
+
     FSL_IMX8MM_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MM_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MM_GPIO2_LOW_IRQ  = 66,
-- 
2.43.0


