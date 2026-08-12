Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2010C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tA-0004mO-Iy; Wed, 12 Aug 2026 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t5-0004VW-Ku
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7t3-00005C-Kp
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:51 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so7806985e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537008; x=1787141808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aWmA88nopEo3kPddFZ0DwQv7aPRUq6NvE3zd5dUEApk=;
 b=Mm+yxILQRH/0khjiBjCorVqUEyX990/pi8ENS47TKVnS31ziSsoxzGSxWh3q9fvC9X
 +ihtSCi2PU+11DQS0WtGHrpmM6SwIXhXLZtQffQ3a5gItqAVtkfChV9t3PKRIxCDC9kR
 N93R/UJWO22feT3aS5c893n2ZIBgTDMoPZ2WQ5tJWgF3utzp7LQZlYpNSni5/yZTTboo
 3hnxWiBrYm60F/RoXF9dIwEHgNzZV0ljlPUn4HMUWViiP2LEuRgzm2u9qD1v1uWfRqTI
 8F8Ahkyd6wwZGCnC/haYxgCLuiitzA0JNIyEuEp3r+RB/XeB4lq+kenD++H6FULS41Am
 vlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537008; x=1787141808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aWmA88nopEo3kPddFZ0DwQv7aPRUq6NvE3zd5dUEApk=;
 b=dD+zDhWYWOgzMH/uPm5kym0ZHdb02zBsquBo0XyF3o4XHwkpMndG72cRRWAB+gDGca
 5HDr0VDP9qDP843JySS6uPDT1pmCTU+zDvEvJt0DFVFmpa+2HBwHWgRCuzgJtosQQ8Pb
 Umk/AM/Fjt7aoNKVwkKqt7GS2vkqXjFZ6FKzV9BJiLWPloKGKvSuS5Qmr6M2ViFI6Ykv
 OqzkEFWAA/h1gQNC6FvtOlXdoFzEA7rN3vDnsHnkAtfZwj2En4SO1zzmP7UCpScVqNyX
 atgADl08WC9CnCK9mBOmRBajnpRqoNsjZEQ/8Azueu1HrZXt5HFn1RIlKgHHoP03NKbY
 sPOw==
X-Gm-Message-State: AOJu0Yxp2NSQQVMKbkuhmLBunF8t+1aOhJolQvaYVdUMYHp0k5Qa+cIX
 OH2coTxDsju/sYxA7v4CJTKx10W7TnBVdA8nctigzmejt693uCMSPmLbPVNVO/P4DKAix/3l2ZV
 iNdLJ
X-Gm-Gg: AR+sD10cCkYD5P9JADDr9fwpRisECTD0Mn6byVsA1jNJv/+5HRgsoTPvy+bjf15KVGW
 mGmuD/yRrvuvK2+6C3dtbUhv+Sty05Ha7c+GQz0kfLjyzYBqsvsN/atRE2gGVs/nXQUbj5kOtGz
 4Bb3xTPiwJ2T0mSdhgDt9uZXoSSBM/UF35SYxg+bCtgFTygQUNvC0T4TfWu6+gIJA7E91J6F0RG
 9Zs30Xzot+N/zBefEbq0oXe44+x2keBHjOfkvFPeOaaSJ9Xs2+wZJlk1XYOy4RVrTXqRTahRg8d
 tqzc9PmhzQarZO8ftPCRg+PIk9Xgmxgz73oz6ZBWibeFX+iSKp6LjXcJQdK7A+d8HLidhGTjuUP
 9k3Yl3aHwQFN8B939aj1kp0hHAzWcmkXj2zafhjYcVqz10O/LwxzCJsAu1xd5N1x1kXnM3+QGc9
 j3ZIX5QM0ilHf4rLasjR38UY0ddd58rkVAztYoFQolGtph0HxEiFuBlEmCejANQzFBX5LB/joAr
 nqwEg/Ph5Abm3K1W5HOytA/PAJ7Sc+/EwFwQaAEhTdMM4E6wJuIG8bDLNdeEMc/+rF0fQ==
X-Received: by 2002:a05:600c:8b52:b0:495:4491:b8c2 with SMTP id
 5b1f17b1804b1-4997c0e6f2emr73920375e9.3.1786537008066; 
 Wed, 12 Aug 2026 05:16:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] hw/sd: Add Axiado SD host controller with eMMC PHY
Date: Wed, 12 Aug 2026 13:16:10 +0100
Message-ID: <20260812121622.649730-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

This patch add a new model for Axiado SD host controller which is compatible
with SDHCI 3.0 spec

This device model also includes a eMMC PHY which helps to control SD/eMMC

Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713073033.3883619-5-kchiu@axiado.com
[PMM: Use HWADDR_PRIx]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                  |   2 +
 hw/sd/Kconfig                |   4 ++
 hw/sd/axiado_sdhci.c         | 119 +++++++++++++++++++++++++++++++++++
 hw/sd/meson.build            |   1 +
 include/hw/sd/axiado_sdhci.h |  21 +++++++
 5 files changed, 147 insertions(+)
 create mode 100644 hw/sd/axiado_sdhci.c
 create mode 100644 include/hw/sd/axiado_sdhci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fce65e370f..7a02fed0d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1305,7 +1305,9 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
 L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/ax3000*.c
+F: hw/*/axiado*.c
 F: include/hw/arm/ax3000*.h
+F: include/hw/*/axiado*.h
 
 AVR Machines
 -------------
diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
index 633b9afec9..c69bf24f8d 100644
--- a/hw/sd/Kconfig
+++ b/hw/sd/Kconfig
@@ -23,3 +23,7 @@ config SDHCI_PCI
 config CADENCE_SDHCI
     bool
     select SDHCI
+
+config AXIADO_SDHCI
+    bool
+    select SDHCI
diff --git a/hw/sd/axiado_sdhci.c b/hw/sd/axiado_sdhci.c
new file mode 100644
index 0000000000..2e88bffdd1
--- /dev/null
+++ b/hw/sd/axiado_sdhci.c
@@ -0,0 +1,119 @@
+/*
+ * Axiado SD Host Controller with embedded PHY
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sd/axiado_sdhci.h"
+#include "sdhci-internal.h"
+#include "qapi/error.h"
+#include "hw/core/qdev-properties.h"
+#include "qemu/log.h"
+
+#define EMMC_PHY_ID     0x00
+#define EMMC_PHY_STATUS 0x50
+
+#define DLL_RDY  (1u << 0)
+#define CAL_DONE (1u << 6)
+
+static uint64_t emmc_phy_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint32_t val = 0x00;
+
+    switch (offset) {
+    case EMMC_PHY_ID:
+        val = 0x3dff6870;
+        break;
+    case EMMC_PHY_STATUS:
+        val = DLL_RDY | CAL_DONE;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "Register 0x%" HWADDR_PRIx " not implemented\n", offset);
+        break;
+    }
+
+    return val;
+}
+
+static void emmc_phy_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Register 0x%" HWADDR_PRIx " not implemented\n", offset);
+}
+
+static const MemoryRegionOps emmc_phy_ops = {
+    .read = emmc_phy_read,
+    .write = emmc_phy_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    }
+};
+
+static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    SysBusDevice *sdhci_sbd;
+
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
+    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
+
+    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
+    if (!sysbus_realize(sdhci_sbd, errp)) {
+        return;
+    }
+
+    sysbus_init_mmio(sbd, sysbus_mmio_get_region(sdhci_sbd, 0));
+
+    /* Propagate IRQ from SDHCI and SD bus  */
+    sysbus_pass_irq(sbd, sdhci_sbd);
+    s->sd_bus = qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
+
+    /* Initialize eMMC PHY MMIO */
+    memory_region_init_io(&s->emmc_phy, OBJECT(s), &emmc_phy_ops, s,
+                          "axiado.emmc-phy", 0x1000);
+
+    sysbus_init_mmio(sbd, &s->emmc_phy);
+}
+
+static void axiado_sdhci_instance_init(Object *obj)
+{
+    AxiadoSDHCIState *s = AXIADO_SDHCI(obj);
+
+    object_initialize_child(OBJECT(s), "sdhci", &s->sdhci,
+                            TYPE_SYSBUS_SDHCI);
+}
+
+static void axiado_sdhci_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = axiado_sdhci_realize;
+    dc->desc = "Axiado SD Host Controller with eMMC PHY";
+}
+
+static const TypeInfo axiado_sdhci_info = {
+    .name          = TYPE_AXIADO_SDHCI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AxiadoSDHCIState),
+    .instance_init = axiado_sdhci_instance_init,
+    .class_init    = axiado_sdhci_class_init,
+};
+
+static void axiado_sdhci_register_types(void)
+{
+    type_register_static(&axiado_sdhci_info);
+}
+
+type_init(axiado_sdhci_register_types);
diff --git a/hw/sd/meson.build b/hw/sd/meson.build
index b43d45bc56..ebf09e30a4 100644
--- a/hw/sd/meson.build
+++ b/hw/sd/meson.build
@@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_sdhci.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdhost.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
 system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhci.c'))
+system_ss.add(when: 'CONFIG_AXIADO_SDHCI', if_true: files('axiado_sdhci.c'))
diff --git a/include/hw/sd/axiado_sdhci.h b/include/hw/sd/axiado_sdhci.h
new file mode 100644
index 0000000000..85afebad93
--- /dev/null
+++ b/include/hw/sd/axiado_sdhci.h
@@ -0,0 +1,21 @@
+/*
+ * Axiado SD Host Controller
+ *
+ * Author: Kuan-Jui Chiu <kchiu@axiado.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "hw/sd/sdhci.h"
+#include "qom/object.h"
+
+#define TYPE_AXIADO_SDHCI "axiado-sdhci"
+OBJECT_DECLARE_SIMPLE_TYPE(AxiadoSDHCIState, AXIADO_SDHCI)
+
+typedef struct AxiadoSDHCIState {
+    SysBusDevice parent;
+
+    SDHCIState sdhci;
+    MemoryRegion emmc_phy;
+    BusState *sd_bus;
+} AxiadoSDHCIState;
-- 
2.43.0


