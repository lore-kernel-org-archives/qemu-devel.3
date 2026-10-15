Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386D4CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvT-0001QP-TJ; Thu, 15 Oct 2026 14:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvP-0001LH-Om
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:33 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvN-0001Sg-SO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:31 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-53582498790so21321351cf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087889; x=1792692689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EXt6qHV/mvy6GrJ8aNrYj+2IGCNQMcbXpBjjuInDD2s=;
 b=kjJjt4f9JmiBhlSP5A6nINV5jeylEavw8c1+nJjkUEyL2+tLb5iqFaHd2VGkeffZXy
 qipL2MG8AjXOf9BetiIKM3l7dxkyDRbgud+2isWjHe/cLSFQjp76rjltZ+bXvC+SGTGl
 7x1C14U3pcfdoodHIACOVp1Z5ulx7LW3aDfKKXEj7q40C7wulP9AUPla/8h4Xf0TlVF5
 sRSgRNeyukd7OtxQzdUV9P/YRwg2g/bfQqeOMfn+S/agQ7o1jcN2GmFuqsdg1D3XrQ2d
 OdiE+VE4VHTm2y77CgYzDHebNxMnncW2SUckDSMlOhwgmi8QjoXgU5aTQEXle74qj6F+
 WdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087889; x=1792692689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EXt6qHV/mvy6GrJ8aNrYj+2IGCNQMcbXpBjjuInDD2s=;
 b=XKGfR8iZeMRAMIFYaFrNPuiAOKn8qJtTpt243ROAiXsn20DukQ4F+MGN/ZN5+N3Ght
 ut8BfoLVV5eIrkD5yR//4cLJZst9B6PyNInlkmhRamPKQ8luf7D+lqXCgvsWIKnOTPJk
 Ty2IQI6rzKBXRZpGdSVPcj4BJZc9IpxNz/WuA4pvS3wa+8pUjuwxRGEAxC2Yz7kufk4v
 V6lSPDVLIcoG9GYIFgGaz+DBVSEhq3Xrap+7ykgx55M/lw7E6vEPt1OQJvKBBRt7qtRI
 W3bCmIAW7Q1zCe9GZqXK+f13I4vr96cpNrgveodT70yzaecZPmf+rNGAfOmy8ghzVUBJ
 y22Q==
X-Gm-Message-State: AFq9FYKi77QrLkaZrMo+dju1NlxjpCUnuX1SbYfCEwcv9PgtxIyra0f8
 CMPobEaJ1IKH9rQArWkiLhqcvisIPUTLuW+yzdDJewu/hZmp9Gs/PE2EUcPKQRpX
X-Gm-Gg: AYBFou0U7OB1hMLo81VGRG+wJMjX809mEXd1xCga43K4VxRcYMiOO53Y/SceelCJo1U
 mby4tc+B+l5LWIdTdaLSffeCpdkPIBjvX8sAQwAHPzSlYubxhyAg30GHJ13My/BjrhV3/aI2pyG
 nRBSQh0MPLc6SXdBupYI9QaaANPdpTlFypI8CN86u1CN+1F8zCwoMHmZkU0hP7TX9mUsCKwZBVi
 pJol1OWX42qnmU5liZtgNfi0ZqS7K3YzUR850WpS2dq2u0E2CdUNPE1saxHoWREkYKCU1fHHc3f
 NTmqX1CzjYuaqW37E9gDNaDsUk578z3pFB3vcvMrrfSLyEewS5IT6oENY5YeCjakDzx0kU0sj0E
 BBB/xJAlVyuTpHc3q/gsYoB6K3Ig3DYO2yGD+AXdazz6vgcScwVCDxI54XSr7Jn6x2Gm4c0N+wy
 TsmYQ8dnaxQDKY63P9R08v1Vq6BmXth9rBNuZu20rkCVqlYwagAibOSfL5YMCN7BWqXXQdEXt+e
 PPa+4KnxlPQHD8Qa+GSLWpxg/A/69SnEfg4giQi4USE67md2Jj25nzFr1Xd3C0oX0genK3vx1P7
 JyYi
X-Received: by 2002:a05:622a:1312:b0:535:a5fb:67f3 with SMTP id
 d75a77b69052e-535a5fb84c1mr319330561cf.63.1792087888547; 
 Thu, 15 Oct 2026 11:11:28 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:27 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v3 03/16] hw/arm/bcm2838: enable BCM2838 PCIe host bridge
Date: Thu, 15 Oct 2026 14:11:08 -0400
Message-ID: <20261015181122.60608-4-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x82f.google.com
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

Wire the BCM2838 PCIe host bridge into the SoC's peripheral block:
instantiate it, map its RC registers and MMIO window.

Per Peter Maydell's review of a later follow-up series, fold in the
remaining defect from what was originally a separate bugfix here,
since this device isn't in upstream git yet: the PCI MMIO window was
mapped at the ARM base address with no address translation, even
though PCIE_MMIO_OFFSET was defined for exactly that purpose (and
otherwise unused). The DTB declares CPU 0x600000000 as mapping to PCI
0xc0000000, so a guest would read PCI address 0 where it expected a
device BAR. Map an alias at the correct PCI offset instead.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/bcm2838.c                     |  9 +++++++
 hw/arm/bcm2838_peripherals.c         | 35 ++++++++++++++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  3 +++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 089af412a3..fc56f87934 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -230,6 +230,15 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
 
+    /* Connect PCIe host bridge to the interrupt controller */
+    for (int n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
+        int int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
+                           qdev_get_gpio_in(gicdev, int_n));
+        bcm2838_pcie_host_set_irq_num(BCM2838_PCIE_HOST(&ps->pcie_host), n,
+                                      int_n);
+    }
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 812b5b8480..d923ba968a 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -15,6 +15,11 @@
 #define CLOCK_ISP_OFFSET        0xc11000
 #define CLOCK_ISP_SIZE          0x100
 
+#define PCIE_RC_OFFSET          0x1500000
+#define PCIE_MMIO_OFFSET        0xc0000000
+#define PCIE_MMIO_ARM_OFFSET    0x600000000
+#define PCIE_MMIO_SIZE          0x40000000
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -35,6 +40,10 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
+    /* PCIe Host Bridge */
+    object_initialize_child(obj, "pcie-host", &s->pcie_host,
+                            TYPE_BCM2838_PCIE_HOST);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -67,6 +76,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    MemoryRegion *regs_mr;
+    MemoryRegion *mmio_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -182,6 +193,30 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
                  CLOCK_ISP_SIZE);
 
+    /* PCIe Root Complex */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
+        return;
+    }
+    /* RC registers region */
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 0);
+    memory_region_add_subregion(&s->peri_low_mr, PCIE_RC_OFFSET, regs_mr);
+    /*
+     * MMIO region.
+     *
+     * The BCM2711 PCIe controller translates addresses between the ARM and
+     * PCI address spaces: the DTB declares CPU 0x600000000 as mapping to PCI
+     * 0xc0000000. Map an alias of the PCI window starting at that PCI offset
+     * so accesses land on the right addresses; mapping the window directly
+     * would expose PCI address 0 at the ARM base instead, and every BAR
+     * behind the root port would be read at the wrong address.
+     */
+    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 1);
+    memory_region_init_alias(&s->pcie_mmio_alias, OBJECT(s),
+                             "bcm2838_pcie_mmio_alias", mmio_mr,
+                             PCIE_MMIO_OFFSET, PCIE_MMIO_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
+                                &s->pcie_mmio_alias);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 566d64572d..931f2cca67 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -63,7 +63,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
-        "brcm,bcm2711-pcie",
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0be97e67c7..7fe92789e8 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -65,6 +66,8 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     SDHCIState emmc2;
+    MemoryRegion pcie_mmio_alias;
+    BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
-- 
2.55.0


