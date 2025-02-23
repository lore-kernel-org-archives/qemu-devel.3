Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31483C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmAST-00008U-Iv; Sun, 23 Feb 2025 06:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASR-00006t-Pm; Sun, 23 Feb 2025 06:47:39 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASP-0005xQ-Th; Sun, 23 Feb 2025 06:47:39 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso543629666b.0; 
 Sun, 23 Feb 2025 03:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311255; x=1740916055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0cpSSAv1AUYF0uxmfB8np+vhpcvonT8w0NjJQwSMQo=;
 b=SVbmhpxipoYrWq05H8Z+qNDzAWpeILD7Ur0I6v5rYqlmJRxhmSRYhHp85vFmw6hvVZ
 HFW8gnJg80sABQX3ABNq4EpEuKn5CYX1ZAzz9L8xODvwJ10kPqAurf3JS+Jsl+vVn3uP
 gbSJgetGjDW4CBOTAb/Ihz8iwm+rOyG7zo0L48cqEnArRoYqYgylEAOafmyKTQdU+4Ar
 vmOdhBwn6Hs1uvL1SJ6umcltW3kCN/8c1BSsYbA4WZxP74JZepgX/BNWI0cIMMbtW2nu
 ssJikoGmF3MTmEb+aU2RFk/ZGCM145UY/c+/SNAOU7WyPVuC/xdcqRcqPvgin2tvqphv
 si/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311255; x=1740916055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0cpSSAv1AUYF0uxmfB8np+vhpcvonT8w0NjJQwSMQo=;
 b=RYfRcpmHmwagsop2MmBU4JMAQR/jjSRCD6KqYv0QFywq/H72MafTPn0DhxYxgQ++Dd
 d3JBd4o7rKYJimdTB2BZ5VF/HyGD6fhbdEtMvOPsN9cezFmrclfUan90vFaqXHbIEJRM
 Ydxj+w0Qm0I+tp47GpKsTcqbfpEuUjMS16zfohAUwv7CMLs1V2dRTtLRQAh3R4wIU/BJ
 8vn3MDFHrfCngG9oM18/LWR8PStD/bDTUUTuq/Nf7qKQn22N3Pd14kY2NUdQh9WIAb/i
 OxZM2Tom8KJ/EofvnZLoTyZIIy2k3b/HxCcGlAtKu5pGORKMMv2Ez5pCLn2vS/voVacj
 nNJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoHA49haVHXdW9AzXnYP1PNEMkRIMDTm0eaStwmkX56Ns6VenXhyLzYNOrkdIQXEv/qPdjY16aPg==@nongnu.org
X-Gm-Message-State: AOJu0YwVjwBcEFp7qc5xQQEpXFOxKXqZ9RlbHDsqsGoTb5bIud1IureL
 2AkD5L5g2KrBcFxD1e0UKYHBNjezMC8Yn+G293eApRPEbKJTJpE113crCg==
X-Gm-Gg: ASbGncui0XVm0ve+a7KHqyGmY1qK8PhZkUdLPnk9hV0tMEk35nXLDqvSGZZ8moQIK08
 ZHwoxDis4FiwSBlr0HJHPxJrvh7MUDAYuSkS6tz6P1CE9YWh2Ekgdw30IePfwAG3aoboEWq60oj
 e0RvwR1duFbFRz7vpbCXPvdIU/cD2jsGt0W44QrtPBbvd/VgNTN3pDEsWBwfsyMzuID6SseDsZ3
 62cfHUf16DlhlMKG7oWpRCgx4EJBo/cG9JEO5RT6AQvElrhVw7I8G7S0qxdFnvo/PIltz4I79H5
 bGtDnixuclPcnh0llX/nUi0lRfp2bU4uy3yc67m0DiRtXzbgm+AdZh63ZP6St0CG1IjR/MPHXfD
 +bntjMWOusMze
X-Google-Smtp-Source: AGHT+IFh6vVgL6CCOJ3C/ET0u+qvqtUebEjjUFPi7WYngK6urkRMjg6wb4ThSWwIrbOi6LrL+0FDVA==
X-Received: by 2002:a17:907:c22:b0:ab7:b6cb:b633 with SMTP id
 a640c23a62f3a-abc09b2b7e2mr938737866b.34.1740311255447; 
 Sun, 23 Feb 2025 03:47:35 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:34 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 10/18] hw/arm/fsl-imx8mp: Add I2C controllers
Date: Sun, 23 Feb 2025 12:47:00 +0100
Message-ID: <20250223114708.1780-11-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x635.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8mp-evk.rst |  1 +
 include/hw/arm/fsl-imx8mp.h    | 11 +++++++++++
 hw/arm/fsl-imx8mp.c            | 29 +++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/docs/system/arm/imx8mp-evk.rst b/docs/system/arm/imx8mp-evk.rst
index 37d3630d09..ef0d997250 100644
--- a/docs/system/arm/imx8mp-evk.rst
+++ b/docs/system/arm/imx8mp-evk.rst
@@ -15,6 +15,7 @@ The ``imx8mp-evk`` machine implements the following devices:
  * 3 USDHC Storage Controllers
  * 1 Designware PCI Express Controller
  * 5 GPIO Controllers
+ * 6 I2C Controllers
  * Secure Non-Volatile Storage (SNVS) including an RTC
  * Clock Tree
 
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 18ea52d083..2590056627 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -12,6 +12,7 @@
 #include "cpu.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
+#include "hw/i2c/imx_i2c.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
@@ -31,6 +32,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 enum FslImx8mpConfiguration {
     FSL_IMX8MP_NUM_CPUS         = 4,
     FSL_IMX8MP_NUM_GPIOS        = 5,
+    FSL_IMX8MP_NUM_I2CS         = 6,
     FSL_IMX8MP_NUM_IRQS         = 160,
     FSL_IMX8MP_NUM_UARTS        = 4,
     FSL_IMX8MP_NUM_USDHCS       = 3,
@@ -45,6 +47,7 @@ struct FslImx8mpState {
     IMX8MPCCMState     ccm;
     IMX8MPAnalogState  analog;
     IMX7SNVSState      snvs;
+    IMXI2CState        i2c[FSL_IMX8MP_NUM_I2CS];
     IMXSerialState     uart[FSL_IMX8MP_NUM_UARTS];
     SDHCIState         usdhc[FSL_IMX8MP_NUM_USDHCS];
     DesignwarePCIEHost pcie;
@@ -205,6 +208,11 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_UART5_IRQ    = 30,
     FSL_IMX8MP_UART6_IRQ    = 16,
 
+    FSL_IMX8MP_I2C1_IRQ     = 35,
+    FSL_IMX8MP_I2C2_IRQ     = 36,
+    FSL_IMX8MP_I2C3_IRQ     = 37,
+    FSL_IMX8MP_I2C4_IRQ     = 38,
+
     FSL_IMX8MP_GPIO1_LOW_IRQ  = 64,
     FSL_IMX8MP_GPIO1_HIGH_IRQ = 65,
     FSL_IMX8MP_GPIO2_LOW_IRQ  = 66,
@@ -216,6 +224,9 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_GPIO5_LOW_IRQ  = 72,
     FSL_IMX8MP_GPIO5_HIGH_IRQ = 73,
 
+    FSL_IMX8MP_I2C5_IRQ     = 76,
+    FSL_IMX8MP_I2C6_IRQ     = 77,
+
     FSL_IMX8MP_PCI_INTA_IRQ = 126,
     FSL_IMX8MP_PCI_INTB_IRQ = 125,
     FSL_IMX8MP_PCI_INTC_IRQ = 124,
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 456fa47dc7..3da81e28ca 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -208,6 +208,11 @@ static void fsl_imx8mp_init(Object *obj)
         object_initialize_child(obj, name, &s->uart[i], TYPE_IMX_SERIAL);
     }
 
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        g_autofree char *name = g_strdup_printf("i2c%d", i + 1);
+        object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
+    }
+
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         g_autofree char *name = g_strdup_printf("gpio%d", i + 1);
         object_initialize_child(obj, name, &s->gpio[i], TYPE_IMX_GPIO);
@@ -360,6 +365,29 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
+    /* I2Cs */
+    for (i = 0; i < FSL_IMX8MP_NUM_I2CS; i++) {
+        static const struct {
+            hwaddr addr;
+            unsigned int irq;
+        } i2c_table[FSL_IMX8MP_NUM_I2CS] = {
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C1].addr, FSL_IMX8MP_I2C1_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C2].addr, FSL_IMX8MP_I2C2_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C3].addr, FSL_IMX8MP_I2C3_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C4].addr, FSL_IMX8MP_I2C4_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C5].addr, FSL_IMX8MP_I2C5_IRQ },
+            { fsl_imx8mp_memmap[FSL_IMX8MP_I2C6].addr, FSL_IMX8MP_I2C6_IRQ },
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
     for (i = 0; i < FSL_IMX8MP_NUM_GPIOS; i++) {
         static const struct {
@@ -470,6 +498,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index be5a2c02b7..28ae409c85 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -595,11 +595,13 @@ config FSL_IMX7
 
 config FSL_IMX8MP
     bool
+    imply I2C_DEVICES
     imply PCI_DEVICES
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
+    select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select PCI_EXPRESS_FSL_IMX8M_PHY
     select SDHCI
-- 
2.48.1


