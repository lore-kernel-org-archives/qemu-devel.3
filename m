Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5591CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3o-0002Q5-QW; Sun, 18 Oct 2026 09:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3c-0002Fb-At
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:12 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3Z-0002G6-KD
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:12 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-93e515769d3so127274285a.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330569; x=1792935369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=csf0U0RhbxwQQltmr3Lieh/UYJFGGnzp3gtbjXPkc6Y=;
 b=I/lTJB1b/Ruddj9botp8MGn9sipJG6wHH2RQB156QEwVpaUPwk8JWhcKYiTgOw9U4A
 8LyZNcXBGpgqPNMtqug0WAUMDMHH7Kj6cb5IgjoWgoHXFouDI3xA+90ytt2PaKHd1AWb
 rE4mP2sVaZnNUnz+SZcq/92rv+dQbvAA0ssJJZd5MrGUiW40ppqmxhUT0B+qq+S+CJPt
 5/lg8vNSkBIjrBD0/PFyVmrOzlszacGp/oZSu/kwLVIGymhv0JMw1iaUaYlM5vB5JRe5
 DXAMhn4i/LPkOEwNuW4+3gKCOUl/n430A47fvWcLysXbPcppgdKU5tmBPCD/CnLpOYGy
 8uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330569; x=1792935369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=csf0U0RhbxwQQltmr3Lieh/UYJFGGnzp3gtbjXPkc6Y=;
 b=pB+GgNqNcOVKm+h9tJU0JoJJir6U5wM/o7zeW+1pUPq/YSy8eXMmeVty2W3AWZs2QZ
 Y+pVkyQkP62MCvTV905kQ5TkvFBzpe7/V3TL29I8FbS5s6gQU7C34J3SXH/G8PHX9JaH
 nJHoyu6n/nmbQpI78Gm3i5LDgFQ3yRbUVpUgBhhNp0TgMslHeX+1Q/yHF/uCymMztFc9
 iSjEruhsX6OjPXfACNE1SA18MZzWk7B6G1kLjV/iP7Q+ple/Pa+yKOHmYGt476SqWhEG
 bdyBm2wOwjNDK/grxtstQ1i9UPogjoYvW6SmNn4zew96zQ2b3YLD53gX71VkBwwitPFn
 eIMw==
X-Gm-Message-State: AFq9FYKkdkpbqddCNfaPJRrP6m0I0WUEd2FiPiMnOMwArIHWqIaQMwoe
 Tqse5wWrT8olBLdMWH56hXrLwHs8Kx/MOwhcI/ox9NEU/JfZoEIleaPolIVtMPyy
X-Gm-Gg: AYBFou067+k9cZMMc6KfKv7hWhHxRNqOPc/iFg3rL/AJp0QPhQi/3wDTCVRNF8sIpcG
 HgcKUUHqY5uCHFc1qsZrcKKLIz9eB1qz1UUjU9PnCSRG2oc1ry6urW8YRYGKvw0hVAs5JZIH5Nb
 SvpUEx0RX0gwPRRs+ervciIW4HuGY7YnwjYptGHPaVvUk4ZQBxM4K6700HLSdqqkb/b81e8nX+I
 U3+xpJJVKrTOesojLhCpzF+aL8AX7xP1prIS/6NhdkzAsOjz4hGZoY5i+rLPpbiaicb7KaX0eQn
 xmyojpvr9xYVZ09c4V+11kA2LWAnru82sDiRNL5cCuoYZrHYnzQ9rFqzpTZy0dPrI1Wa5LXJ2HV
 6QA9ryHdgp5uRJJ4U4QtviQf220xpeBqFZFVNJ7ugigKgvpT8fyuJLGjDPOd8OzjlqyNGJFk/0Y
 gwTt3yy/AHQCXeTrXc0ttrz60tA9N17mu+u9/7CFM9msM536GXSFbeGvq79CNhxpKXMzwZdkVT9
 MhcDGpPsMmL+VOD3y3iJyuQN0HClLA00hew21S4GfMDfLgssrmgFBo/R46zOsFCW8BBbar2
X-Received: by 2002:a05:620a:6f82:20b0:93f:2e72:8389 with SMTP id
 af79cd13be357-93f2e7288eamr402557585a.54.1792330568494; 
 Sun, 18 Oct 2026 06:36:08 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:08 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v4 03/17] hw/arm/bcm2838: enable BCM2838 PCIe host bridge
Date: Sun, 18 Oct 2026 09:35:49 -0400
Message-ID: <20261018133603.64323-4-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72f.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2838.c                     |  7 ++++++
 hw/arm/bcm2838_peripherals.c         | 35 ++++++++++++++++++++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  3 +++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 089af412a3..8f8e107c56 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -230,6 +230,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
 
+    /* Connect PCIe host bridge to the interrupt controller */
+    for (int n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
+        int int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
+                           qdev_get_gpio_in(gicdev, int_n));
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


