Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AB3C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t7-0004bf-W1; Wed, 12 Aug 2026 08:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t6-0004Ww-Hy
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:52 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t4-00005j-Of
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso6379945e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537009; x=1787141809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zuwGx2HFEApiFHISSkbLdQ9wtICYLQqmdzOFnfBhNzI=;
 b=ChnukK7FN4WqJNs+FwuKxF17jN2pVVLr6catk5l/TYTNICYR8lMjRRJvX0R9NDTF0c
 I5eMFTVspMzPBxvkHLbGWSlf+eyO3SdnlU/GnOeXUAZmZuBFmk2tX4NpTGp+R+uTWl+b
 iPi559SpighCcLgXjcA79w7IQ1HCZAsUNoUxj//f6nC/3GLOcfh94tPp6L1dycJbhrpz
 5TXjzjIRAu/Wbx1P2mt4CnFgYvZtezS1WS3ESevmQ7/o4/gsYrFcnoxepOYJnk1Q4IkJ
 enFt+Pq+DwLFbJKwA4sORxT+Ov6IjA2J2R+PsHnvG9e7CEV1dwQJshFMVHH/3mJ9Hxpn
 S/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537009; x=1787141809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zuwGx2HFEApiFHISSkbLdQ9wtICYLQqmdzOFnfBhNzI=;
 b=J5EALTxGAyG5UQTywuu/F1JPBpSIzSbci9wtGBrQ19vDfamjH96iLKa1+8NoOl2EO0
 6IYAQkkiU6PFP5EiCTlEHg+9NDdB2lwN2ANKJCAZ2mhDYb5xsd9F5QkVabktF2Hz/81Q
 yS5jSCPmABOiCUQAee2mhsI/XDdiUGDn4kAjNVrwRKdumORCxX0S9T2iMNulbgLnjBBQ
 V66s56qFIh01EmUOzxpDGSz+zdiokFUlOjVITAunq3GVZKqQfXrBJNIzB8rkL51fnVOx
 YS4vp03/xgquOzXb8t5+A/at/K0wCAhPS3LDokr3kWhMIeRrXrAnP9H8cvHMkQbte+T4
 6itQ==
X-Gm-Message-State: AOJu0YxNrjSd5ZH52rXaDW90MsFJby18FJT//20CWpYRNL2VzvGiQbA4
 ILw/fOsTFzWs6WSwcpITdfxXd4DxdbJKBeIRW0fNamoi6u59tlgLjV6zT/Jye1FuthCveo9XliL
 u9fMQ
X-Gm-Gg: AR+sD13B+2iUM7yD6fb3LDisu4q0z+swWQpv8gI/JJoaVFOMob/SxQMtjcqgUQHnqMK
 9Mnm18LYkb/u19L8hKTcruWqn2QB4e+2rQW2QqzsmcsRSSIthCV129cCQjyE6MUFncxwp6x5Cw7
 GZi4sTlGTjqaqfbfw6gNckw8jKAtKeIbJl6mrFvJYzOSJuqtOzeNozbrk1sasAD+ENVFHwyAPYW
 qe6KXyG8n2nOADdaH5dcU4gvq1llINicRKs5YikNtZvA/8JIjvMvgO/0ol7Y3XGPNCsatkIKSfr
 YQSRWIAAgf5zyVPh9HZQKKUy126E2/1cLx9wNYLKzLCoxnEJYEyaZlPSiCSSnli9rH9Sp//r+VT
 xVI1h23XN93Nn+x2fZzCM8a3zWFqFqWq1huCcTh5mIbHUKy0HkSs0/hfEe7p20/UKHJAdMX4qCj
 A39XEC6nWddqilboHiVbj/2dV8QhHfFpd3USsnsmR2KrJzMazN2jJKMDRlmVujWM3a+c5ybgxUl
 k3Axl//g16ciLkH62qz8h1R/kgO69/EmJ1mXrbq5uvOzPd8PNYYCtBDnInBMaGBFh7qyZo=
X-Received: by 2002:a05:600c:4f56:b0:499:7dfb:6e6a with SMTP id
 5b1f17b1804b1-4997dfb6ed4mr28030725e9.5.1786537009219; 
 Wed, 12 Aug 2026 05:16:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/26] hw/arm: ax3000-soc: Enable Axiado SD host controller
Date: Wed, 12 Aug 2026 13:16:11 +0100
Message-ID: <20260812121622.649730-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Kuan-Jui Chiu <kchiu@axiado.com>

Enable SD host controller into Axiado AX3000 SoC to load kernel and rootfs
from eMMC.

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713073033.3883619-6-kchiu@axiado.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig              |  1 +
 hw/arm/ax3000-soc.c         | 22 ++++++++++++++++++++++
 include/hw/arm/ax3000-soc.h |  7 +++++++
 3 files changed, 30 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 69161a439c..32e7d83339 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -731,4 +731,5 @@ config AXIADO_SOC
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
+    select AXIADO_SDHCI
     select UNIMP
diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index aaeae11074..23903b081b 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -35,6 +35,7 @@ static void ax3000_init(Object *obj)
     }
 
     object_initialize_child(obj, "clk", &s->ax3000_clk, TYPE_AX3000_CLK);
+    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
 }
 
 static void ax3000_realize(DeviceState *dev, Error **errp)
@@ -46,6 +47,7 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
     QList *redist_region_count;
     SysBusDevice *sdhci0_sbd;
     DeviceState *card;
+    DriveInfo *dinfo;
 
     /* CPUs */
     for (int i = 0; i < sc->num_cpus; i++) {
@@ -165,6 +167,26 @@ static void ax3000_realize(DeviceState *dev, Error **errp)
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ax3000_clk), 0, AX3000_PLL_BASE);
+
+    /* SDHCI */
+    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
+    if (!sysbus_realize(sdhci0_sbd, errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(sdhci0_sbd, 0, AX3000_SDHCI0_BASE);
+    sysbus_mmio_map(sdhci0_sbd, 1, AX3000_EMMC_PHY_BASE);
+    sysbus_connect_irq(sdhci0_sbd, 0,
+                       qdev_get_gpio_in(gic_dev, AX3000_SDHCI0_IRQ));
+
+    dinfo = drive_get(IF_SD, 0, 0);
+    if (dinfo) {
+        card = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(card, "drive",
+                                blk_by_legacy_dinfo(dinfo),
+                                &error_fatal);
+        qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
+    }
 }
 
 static void ax3000_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/ax3000-soc.h b/include/hw/arm/ax3000-soc.h
index 329aa4e769..52b47aa829 100644
--- a/include/hw/arm/ax3000-soc.h
+++ b/include/hw/arm/ax3000-soc.h
@@ -13,6 +13,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/misc/axiado_clk.h"
+#include "hw/sd/axiado_sdhci.h"
 #include "hw/core/sysbus.h"
 #include "qemu/units.h"
 
@@ -34,6 +35,9 @@ OBJECT_DECLARE_TYPE(Ax3000SoCState, Ax3000SoCClass, AX3000_SOC)
 #define AX3000_UART2_BASE       0x80620000
 #define AX3000_UART3_BASE       0x80520800
 
+#define AX3000_SDHCI0_BASE      0x86000000
+#define AX3000_EMMC_PHY_BASE    0x80801C00
+
 #define AX3000_TIMER_CTRL       0x8A020000
 #define AX3000_PLL_BASE         0x80000000
 
@@ -52,6 +56,7 @@ typedef struct Ax3000SoCState {
     MemoryRegion        dram[AX3000_NUM_BANKS];
     Ax3000ClkState      ax3000_clk;
     CadenceUARTState    uart[AX3000_NUM_UARTS];
+    AxiadoSDHCIState    sdhci0;
 } Ax3000SoCState;
 
 typedef struct Ax3000SoCClass {
@@ -65,6 +70,8 @@ enum Ax3000Irqs {
     AX3000_UART1_IRQ    = 113,
     AX3000_UART2_IRQ    = 114,
     AX3000_UART3_IRQ    = 170,
+
+    AX3000_SDHCI0_IRQ   = 123,
 };
 
 #endif /* AXIADO_AX3000_H */
-- 
2.43.0


