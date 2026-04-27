Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93878FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLP4-0000qZ-5f; Mon, 27 Apr 2026 08:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNP-0007nT-Tk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNM-0005Te-LH
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:47:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso86366965e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294066; x=1777898866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncA954+/b3LBw7J5Pq2tPoyKl97Mh8cz0m0mv1bmSPo=;
 b=HUwYVXlzEaFlkXfXAYr3l3t2eEVrHy+pBtdY1ED7Eq9cqB/cf4k4+iV6f5jLZMYR/D
 aXLrRhzGj382P3+YR3QuST0YsvP160qhANyDjmglVCh6f0jTvg/ynFkSkNMtMpJHS3i/
 SEWYmSibq5ZqOX0BK25pjHD/dy+Wja5LL2MIYaRLP/2HEXTBxJ3HHr1XqW+RClCZUYPm
 kEVObazlwgLj0o5vk/xi4ZN1RNb0bpFbx3osix6Gm8R8rPNEo5/1/WunJErEvOJ2ikFH
 r+jSfGgvShFQMxr+L6cLH0bjx6hjHO9BWJwt5C9FijpYlG8aKVL4wIO8ldc9VSawavhM
 9bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294066; x=1777898866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ncA954+/b3LBw7J5Pq2tPoyKl97Mh8cz0m0mv1bmSPo=;
 b=RIG1/egWDG8e6J1VjXdpD6up6ulbzpksfP8lF7v2UY0yted01fsEabEawgs6JYavmt
 tLEXBwLYd5u7GCUUYd9p6WuXNTc5l8RU1HszknaW8hhQUM1mIk1aDy+8XAKp8yN0nCe5
 9CLlloq6RNS3jjXDYrp0R0Pd7a99l/VWYANIBQgHHdov9pPqtV1cBN6SKRtUyYIb1XCf
 /Zv41ObUBtXtdQEpMm8mCWgwLjM+v71N4Rv/koGtdzoooJIg7f9KKOOKvprF3KABZF/K
 rfv+2NC54DzNK6KkIpWsw+mBQR/1bnpPNYgRjV9PfpeUPIwI45j0YtOBajma7ZprjCQ/
 RB3g==
X-Gm-Message-State: AOJu0YyWiedlUn7IbrfH8dmwYRh+NInx6Bv3uhWAngphod1JZX9TsmKb
 JW6pYPjIhplpt6GEraA2H9gRu8TMM9+ih6Xev5oOKp7PUgyOg8UkeqZZLfM/jwXkEcGXIMU7XGX
 FvUtN
X-Gm-Gg: AeBDieuXO/nAspEJAq0ynL7A1uS1wM62Da/XsQjpx4Ne25tedQkYGEAotafQco1LpPC
 siexCs44rF9DhZFolNQbkkNcONW4wh5G4eDm/0Rp+/fGxIzwe3jDoOtnWFm3jwXHmKyt9ZCvLcI
 3zyFoxbHSbWvaBmZEOij6ZBGbKS/50fa7XWcN5FdZxQFrydyOJkx7GCCTCGQzUtfYBcpR/cNXp4
 6DBIquDsDdg5/Wrgnt0cKivaWe3zKsJBk0W3ZRMg0OaggFn2K51m0fopk9aSBX6/bryBL9ebehg
 r6agDHN0j6GbnZ3glh6GWUb+AMuC4U+1s42nIyVsb2H3c8qY8UKkA8y+axg2hnDtYJfA2CrH04V
 4mLAxRinGlIndDo+Ql0jWe70B7AxjpkGb/lqp4D2omdmKuv9PYUa41FwDb1S7jch/ujbAaptePJ
 Vyfe6KtYItGmgEJMhRo6eQTeDMOb2tT7JDPG3dpKtkye2qCbMRm4cIw8CLavL+FSHoKEEgesTvL
 ko48jZVLm2LOPHpUjwnkE4K7DKYoM3ykM6Kazuq9w==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id
 5b1f17b1804b1-488fb7786e4mr484660105e9.19.1777294066384; 
 Mon, 27 Apr 2026 05:47:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/63] hw/arm/fsl-imx8mm: Add PCIe support
Date: Mon, 27 Apr 2026 13:46:42 +0100
Message-ID: <20260427124738.966578-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

This enables support for Designware PCI Express Controller emulation
It provides a controlled environment to debug the linux pci subsystem

Reviewed-by: Philippe Mathieu-Daude <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  3 +++
 hw/arm/fsl-imx8mm.c         | 30 ++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mm.h | 10 ++++++++++
 3 files changed, 43 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 74e8c431a2..59d5aba2db 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -619,11 +619,14 @@ config FSL_IMX8MP_EVK
 
 config FSL_IMX8MM
     bool
+    imply PCI_DEVICES
     select ARM_GIC
     select FSL_IMX8MP_ANALOG
     select FSL_IMX8MP_CCM
     select IMX
     select SDHCI
+    select PCI_EXPRESS_DESIGNWARE
+    select PCI_EXPRESS_FSL_IMX8M_PHY
 
 config FSL_IMX8MM_EVK
     bool
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 2a4d4d5e6d..633b121630 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -184,6 +184,10 @@ static void fsl_imx8mm_init(Object *obj)
         g_autofree char *name = g_strdup_printf("usdhc%d", i + 1);
         object_initialize_child(obj, name, &s->usdhc[i], TYPE_IMX_USDHC);
     }
+
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
+    object_initialize_child(obj, "pcie_phy", &s->pcie_phy,
+                            TYPE_FSL_IMX8M_PCIE_PHY);
 }
 
 static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
@@ -388,6 +392,30 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0,
                     fsl_imx8mm_memmap[FSL_IMX8MM_SNVS_HP].addr);
 
+    /* PCIe */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_PCIE1].addr);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTA_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTB_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTC_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_INTD_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 4,
+                       qdev_get_gpio_in(gicdev, FSL_IMX8MM_PCI_MSI_IRQ));
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_phy), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie_phy), 0,
+                    fsl_imx8mm_memmap[FSL_IMX8MM_PCIE_PHY1].addr);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mm_memmap); i++) {
         switch (i) {
@@ -395,6 +423,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MM_CCM:
         case FSL_IMX8MM_GIC_DIST:
         case FSL_IMX8MM_GIC_REDIST:
+        case FSL_IMX8MM_PCIE1:
+        case FSL_IMX8MM_PCIE_PHY1:
         case FSL_IMX8MM_RAM:
         case FSL_IMX8MM_OCRAM:
         case FSL_IMX8MM_SNVS_HP:
diff --git a/include/hw/arm/fsl-imx8mm.h b/include/hw/arm/fsl-imx8mm.h
index 93a30a2f55..3181c02574 100644
--- a/include/hw/arm/fsl-imx8mm.h
+++ b/include/hw/arm/fsl-imx8mm.h
@@ -16,6 +16,8 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
+#include "hw/pci-host/designware.h"
+#include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -44,6 +46,8 @@ struct FslImx8mmState {
     IMXSerialState     uart[FSL_IMX8MM_NUM_UARTS];
     MemoryRegion ocram;
     SDHCIState         usdhc[FSL_IMX8MM_NUM_USDHCS];
+    DesignwarePCIEHost pcie;
+    FslImx8mPciePhyState   pcie_phy;
 };
 
 enum FslImx8mmMemoryRegions {
@@ -166,6 +170,12 @@ enum FslImx8mmIrqs {
     FSL_IMX8MM_UART2_IRQ    = 27,
     FSL_IMX8MM_UART3_IRQ    = 28,
     FSL_IMX8MM_UART4_IRQ    = 29,
+
+    FSL_IMX8MM_PCI_INTA_IRQ = 122,
+    FSL_IMX8MM_PCI_INTB_IRQ = 123,
+    FSL_IMX8MM_PCI_INTC_IRQ = 124,
+    FSL_IMX8MM_PCI_INTD_IRQ = 125,
+    FSL_IMX8MM_PCI_MSI_IRQ  = 127,
 };
 
 #endif /* FSL_IMX8MM_H */
-- 
2.43.0


