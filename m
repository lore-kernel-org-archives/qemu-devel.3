Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B6CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvj-0001fI-G3; Thu, 15 Oct 2026 14:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPve-0001Xj-8I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:47 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvb-0001Ws-Uy
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:45 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-53582498790so21324051cf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087903; x=1792692703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RxL0fo4TNNnlw8zar6Zs/O9xtJH6YRcFE/jBzRkop6g=;
 b=jq+LhheHE46H4KO9cQGQjNGwFfpO+VjS5OFPxT1KG3ZJEzqNOvChH7IEYKOtJyoME8
 EZBY/uhr91czZ95vPX11vWxfj5MMcdoR9CCbT3UxBHBAUtKj0ug9lfh0162IAcJvqpwo
 pj7LHphPk2K1JmKUrWtloklXa3BN4Tj49K2Zj15Em4Faxr3nfWFRnTTpRmJlPWH9rPby
 PIz3pmhCm79HfJxRVXTnxZnoroZsb/BgVkCAzXaSWbojMjsqFdvNFVXjyTIGWH7e+ibz
 oUq2pCUfi8k2ADyJ5S/WHK8QHVnBnV+0u9Kjvql1UG3w3jaeXLwTM9ClR1c3AU3f/wiy
 zuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087903; x=1792692703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RxL0fo4TNNnlw8zar6Zs/O9xtJH6YRcFE/jBzRkop6g=;
 b=LuVbhKiqqU7KEDOLwnp6K48BZ3wQEc0ERahMaw9leXWAyLxqeTOOxJ1+WwemHJeGoW
 G9RYhru1aRu353DtqV8/duDD8YDrBgb7QBhUV7yY8G4CGZCHu274Vwpipqr6V5vVQIH0
 /4b8xbXH1qV85KtMVun4tOSyfQvqasbsLYhi7E50bSFR6M7T4v6OGWdpsteLC0WBRBGQ
 xqwI5fzc71p7eJs1ZK+zzjxJxwNTNvxzvVii3r+dMonOFEpLvWCtjsqMLEXZAgJF182G
 PPWMZ9zQ4ct5UDu5b1fdNgyKGB7fP1oLL0hJ3EjvljLUwaZFF8GOPaM+VRFqgvg2VKPE
 EUvw==
X-Gm-Message-State: AFq9FYLdlVHHImgnjKsKHiR5Scz1XeYBRfjQVy1Y9NllOrkLGF3TydON
 d3G+NvR++RdgjRl65fxBIkDTu/V1JC/Roduf03DTZfLBwjMc5bis4HIuFkG5dFl6
X-Gm-Gg: AYBFou3iE5ycQw0ImQ5p+HNaJbPHhicnXOTO0eOXV3B5E/pgvGX4HC1kXhlfu4CiKDo
 xuA/dfY1non3m98oulSPx/e2sXlNvGZ520NqPlQYEHUAGjoQn3OKZuT6ajXI0hMlYWKz5yYFXHs
 cyiLFcZ4+qZDblA/MQX8WYbjWlV4s0E+FehqcLLDWp88IwEmf5L1IuZAAeFAvVhC5dRJbWM/z8H
 0EtWL8AGI/1Umi0g0aTRbO44eeRJJCkOn+IWEtzj72BMtvaGPD34csGzS+FmfZFCKpODAjUYAxo
 Hz+vCO2xPw7wU1W41d6v2RFwpUSjdjFwSD16BDN4a44y3RHm3ofpHnskJUtaEUWRYreipO7Detg
 d5O9usAWODzpMQJz9iwmyz9Gp6Nap37ociImNsM9Rc26KF/LF9fHdPG8t35+ILe2rI0PX15WO6w
 XRpAN9Hp9u39D8G20pmOlPPyfGETUDYPJS0SgTRWK+b38HrYXHnffkYAFOH0M65Dtjmffb3pgGX
 R7iMs6sFptYyiP49AmASuwOuK8D1KHU4kwxr8i7ySd8yUcj7CDE6V/K1Hqh8Vv+2EK2QQ==
X-Received: by 2002:ac8:5f8e:0:b0:51c:fc4:a144 with SMTP id
 d75a77b69052e-5359f46d56bmr333354931cf.4.1792087902925; 
 Thu, 15 Oct 2026 11:11:42 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536127efe4asm32130611cf.19.2026.10.15.11.11.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:42 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v3 14/16] hw/arm/bcm2838: enable BCM2838 GENET controller
Date: Thu, 15 Oct 2026 14:11:19 -0400
Message-ID: <20261015181122.60608-15-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181122.60608-1-marcelomanzo@gmail.com>
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x82e.google.com
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

Wire the BCM2838 GENET device (added in the previous patches) into
the SoC: instantiate it in the peripherals block with
qemu_configure_nic_device() so it picks up a -nic/-netdev from the
command line, map its register region at the real BCM2711 physical
offset, and route its two interrupt lines through the GIC. Also stop
raspi4b from masking out the "brcm,bcm2711-genet-v5" device-tree
node, now that the controller it describes is actually implemented.

Adapted from patches 19-29/41 of Sergey Kambalin's Raspberry Pi 4B
series (patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/bcm2838.c                     |  6 ++++++
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index fc56f87934..f47b96c3bf 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -239,6 +239,12 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
                                       int_n);
     }
 
+    /* Connect Gigabit Ethernet controller to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_A));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 1,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_B));
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index d923ba968a..012a4567e7 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -44,6 +44,10 @@ static void bcm2838_peripherals_init(Object *obj)
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
 
+    /* Gigabit Ethernet */
+    object_initialize_child(obj, "genet", &s->genet, TYPE_BCM2838_GENET);
+    qemu_configure_nic_device(DEVICE(&s->genet), true, NULL);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -217,6 +221,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 &s->pcie_mmio_alias);
 
+    /* Gigabit Ethernet */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->genet), errp)) {
+        return;
+    }
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->genet), 0);
+    memory_region_add_subregion(&s->peri_low_mr, GENET_OFFSET, regs_mr);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 931f2cca67..6076b43922 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -65,7 +65,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
     const char *nodes_to_remove[] = {
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
-        "brcm,bcm2711-genet-v5",
     };
 
     for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 2a4307bed7..deddab50d2 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/arm/bcm2838_pcie.h"
+#include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -70,6 +71,7 @@ struct BCM2838PeripheralState {
     SDHCIState emmc2;
     MemoryRegion pcie_mmio_alias;
     BCM2838PcieHostState pcie_host;
+    BCM2838GenetState genet;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
-- 
2.55.0


