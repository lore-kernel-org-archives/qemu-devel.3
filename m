Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B12CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvJ-00015N-HQ; Thu, 15 Oct 2026 14:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvE-0000qG-Q9
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:21 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvB-0001Ol-RM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:20 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-91791ec1b83so15985306d6.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087877; x=1792692677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b0LHOlMwdZRsFjhbtVUanZachS5ovUUpJ90cHCX85Lg=;
 b=Rf50hwLH/JZEtTiZCUFfpZrzQfJltkcgv5m16vNaGjMywrYihkXCtqworYuO30gZJk
 dxf3vuJGO84TCWbNGdVoYgIhwyClYx/jxq7PZt9+SngpDN3F8xkkn43nexbubN060Onf
 ID+zydkKkqKg3Ga3QbbItMRNsL9LhRsnzXYckaOjmw6p8UMk+p/Ji+NKzaIEBRMup+9S
 0YxT5fU0eAH4TGLvWvHvHRNwJOpcl8FMM1wXL7/k/yg8JliBGK0IMzN9sWIL0SOjDkUs
 koro6CA0HdlbE6SDwVbuS0ryrxzQvqzlbKAi6Pa+43bthFiM5uIy5w51fSlIP5eWVhgu
 7HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087877; x=1792692677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b0LHOlMwdZRsFjhbtVUanZachS5ovUUpJ90cHCX85Lg=;
 b=mJgrM5G+pJheN+uS/+ofjEvV8kXQ9VnLOBCAQxf/6d0qr0sjPGrmCrjUESOiXuzh8t
 R/iZtq6XMkd+Q2yvScEM2AMB9U8BoytUgK0vfGpJ1f4mpDm/xD2Bl8U9RIEczkLu6XzS
 zLuI3x4MFV+4tS/Ro8xcI0qk+a89i85wq+Vmy13r0uTPdYshtxwPxoBc6X8llrJ5dJ+R
 g69zvL6J/bMSCcPRRU9X7/pgjy+1xf17T63NuuIBz1GOiPybNvGbnjO2sfsQC7s4WXfo
 UyDRn5u9lMFuyT1aIcm6zYswxboNvkwOskkOgezW0uUO4paUYi0s1wjdR1V3ehDLEUW8
 dj+g==
X-Gm-Message-State: AFq9FYKv2T1NandaxIfOndtHZLPn7Y2VZtKC3ViFBApHD4G+QnLJI1Ok
 pzY4y5ddR4OQeLJeXPnVLXqXU/ypUtpOWLG7hfdDySREZF3Kow+WQLOruHUN3YT+
X-Gm-Gg: AYBFou0pdOK/yI3iK8woiaM1P6eiUI0bgBOvD89WMOtHDLwVdcQgmT95X7v/26c/IWg
 E4mF4+QFKyjgk/mLQzFc/osK076n9ZyrESs+ALfXMV+3YdQA183SDXUvRy1TzS59d42mlFyg1S9
 khngdSlzmKzP5Ce2IW2FHsll63+eTC0uqm8tClrvpT5Yb31/pdNHvoIjSPpBRzCg92Noc1Ox6wt
 Oj4MfeZE3bQZvddrB48BjNTuvseCCNyBzY/K63L6SijyNP6KhwLhorkzuPL1PYSD9IsFmFvOXS1
 /K5Fd6wCM1tXWLmd3kc+zThznfDt0TBr/5uKXTToZp+ksORHWVAwPf1pSLPoTRW6Kb5et2nMB4C
 wdz9InDB/lM2GwewFDHQMg5DqyZKlYuIQAKds1SrgfcUNLPSPVLMBd6EsV7pIcPDI6n8jnY1cqK
 CD1PeOTa46Xn4BkCBcSFF6La7LL6C0g1JXfCfd0WEXb1s9f9TgwfFkx8YdLBjeqBFvL3rSbyt0X
 8xxmM0N9ZvncwIORRkzrJ1v00K0He4iP8y0nsx+KpJtH8Vo7UZw8nq89s29e668ecVUnG/nSwlp
 dWHa
X-Received: by 2002:ad4:5ce4:0:b0:915:e9af:3145 with SMTP id
 6a1803df08f44-91b554e9eefmr350583736d6.12.1792087876777; 
 Thu, 15 Oct 2026 11:11:16 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcba45dffsm1816206d6.12.2026.10.15.11.11.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:16 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 4/5] hw/arm/bcm2838: enable BCM2838 thermal sensor
Date: Thu, 15 Oct 2026 14:11:10 -0400
Message-ID: <20261015181111.60491-5-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181111.60491-1-marcelomanzo@gmail.com>
References: <20261015181111.60491-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf2b.google.com
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

Wire the BCM2838 thermal sensor (added in the previous patch) into
the SoC: instantiate it in the peripherals block and map its
register region at the real BCM2711 physical address. Also stop
raspi4b from masking out the "brcm,bcm2711-thermal" device-tree
node, now that the sensor it describes is actually implemented.

Adapted from patch 17/41 of Sergey Kambalin's Raspberry Pi 4B series
(patchwork series 829638) against current QEMU master.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 35e2fc005c..f4e9cb88f1 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -38,6 +38,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Random Number Generator */
     object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
 
+    /* Thermal */
+    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_THERMAL);
+
     /* GPIO */
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
 
@@ -72,6 +75,7 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
     MemoryRegion *rng200_mr;
     qemu_irq rng_200_irq;
+    MemoryRegion *thermal_mr;
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -96,6 +100,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                          BCM2835_IC_GPU_IRQ, INTERRUPT_RNG);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0, rng_200_irq);
 
+    /* THERMAL */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
+        return;
+    }
+    thermal_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0);
+    memory_region_add_subregion(&s->peri_low_mr, 0x15D2000, thermal_mr);
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 87fcba036d..61adccded9 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
     /* Temporarily disable following devices until they are implemented */
     const char *nodes_to_remove[] = {
         "brcm,bcm2711-pcie",
-        "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
 
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 15423527e8..a720eea821 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2838_rng200.h"
+#include "hw/misc/bcm2838_thermal.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -66,6 +67,7 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     BCM2838Rng200State rng200;
+    Bcm2838ThermalState thermal;
     SDHCIState emmc2;
     BCM2838GpioState gpio;
 
-- 
2.55.0


