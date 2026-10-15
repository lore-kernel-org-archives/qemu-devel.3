Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5DBCC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPvK-000191-DC; Thu, 15 Oct 2026 14:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvD-0000m3-GH
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:19 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xHPvB-0001OM-4n
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:11:19 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-91791ec1b83so15985186d6.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792087876; x=1792692676; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q6ZzcCN/48+ddiMOZle0TgzJkgvqGX4oc6Q3aSB1qFo=;
 b=clgVj8CQxOzTk42wSxQ/JXQTcIaGEIfDIJqQTaSFiE62ITRPhactEXUbBmCmeWRgq6
 kJJ1Fh3m75Z5KxorktUHB0R/eu9DPCVcs79WsSJHkKPhwZayqJXR+gMD3k42wkuTb/hn
 u6tIEqtei4sg5jPGqRupcR2vqYun5U/u60AYc9T19tYNyJV2g4537G6ikml2wryNwb3P
 mU0GnM6e86EZAV/QsBHXva+w9H1JuJU1042G2+KPKzeZEAYwTUXV66AtfSnol9DDxzRL
 wOZ5wra5ShetgOEeQ4WGFI6Geyl8uzTv0C0q1NSpGSYANUcovDyJRCLFfSOqcLZuMS8X
 rROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087876; x=1792692676;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q6ZzcCN/48+ddiMOZle0TgzJkgvqGX4oc6Q3aSB1qFo=;
 b=kLTCmzB+Mt0InXCMTah0ijw92eZiHg0Zjk1N2IlAtI0ZkgiSAL0DtEK9gXLhQZdl1Y
 uA2PUWdFxNvPjXBAiyWCzxQfdbUz2t2n1FLeaB/abF1E5xlAPCr+SPmnLdUF2fiuAJPM
 FP6OrcSwuu4FPBqRP4nQKfyfXTDQ4bP+bYYd1PJEX+tN6A6wm2ydnCkdUIprA53Z3tOK
 mSP2eUeRsMeGB1Qa4CDomUmDOFX15QD+dTyc06hcEXqbfzV4TFpUMEEmxPvvYJtxGuX6
 cE4TciNtQwYlFUYpxHRTbPfMOUpodMxS/5WatLadnwo1wzJ6XHjQnYs49Qq1wty0YcHJ
 LQHA==
X-Gm-Message-State: AFq9FYJ7YXdHpTIYzxbMS65POg6gr5AqYVkHHfDqP4didOs1e9LeCbOz
 GLKxMvQzgazq+ehlryr0GsofTDjwRmEn91W+51FOiWhLUBudtEFBjvknlTk+GTG6
X-Gm-Gg: AYBFou2IyrfvpG6dWpsXkmcCXM92P3e0XufE28XzJflRtsXCsa6LrTR+CGZHbJ5I9kR
 aOo6LeUkRdz5lIOYUZ4WQr+6ccm38cbqrdW0p8bK1HAOfJ8epukg9iLWRhwCYjjw/D2qWtgpPiX
 LJdMRVhZ65D1wjJqEBULRDp3xCZB5vEYoGsdCeECnt0se6sqm+g/yd6jcbxN9oDaDrERZ94rzvM
 595HCri1wQFjv5JZZGyl72gOBcDBHHoSCNPiwS1uhzyAHJNjvhlDr4ACXyo1SHLM3X8Hk4HpMD2
 7ZWL7Df2n3AoJYlpmzfCipDdKkcGGkNa56++tiIma6HXfCeoJ/lhd4NcnpAlr4Os61nLgm7Zkcx
 y36/Eexa/8imarm05DU8DKabGDUEnPdssjQPkl6Eb8dY6pwT950jSKI+fsoSoBEhPtKGeqKZzqZ
 LLcFPs6GtV63HcppXioJoWMFC6faI6mDEMhupmqc1GNMuYEXR+7MfZRozRX7sPAVeUchS6VZFJA
 rxOKx0Jxp/SMtgGNAOP2yGNdm9+LV5BH25Jy5yB6u5hLPgrAqhgB1aW5PpKsCk1bi8qLQ==
X-Received: by 2002:a05:6214:458b:b0:91b:8b44:d4be with SMTP id
 6a1803df08f44-91b8b44da3bmr183022846d6.28.1792087875991; 
 Thu, 15 Oct 2026 11:11:15 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:919:5388:4e10:5949])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcba45dffsm1816206d6.12.2026.10.15.11.11.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Oct 2026 11:11:15 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v2 3/5] hw/misc/bcm2838_thermal: add BCM2838 thermal sensor
Date: Thu, 15 Oct 2026 14:11:09 -0400
Message-ID: <20261015181111.60491-4-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015181111.60491-1-marcelomanzo@gmail.com>
References: <20261015181111.60491-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qv1-xf35.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Add a dummy BCM2838 (BCM2711/Raspberry Pi 4B) thermal sensor: a
single status register that always reports a fixed 25C reading with
both "valid" bits set. Real hardware reports live temperature; a
fixed reading is enough for guests that just probe the sensor and
read it, without modeling actual thermal behavior.

Part of Sergey Kambalin's original Raspberry Pi 4B series (patchwork
series 829638, posted to qemu-devel in 2024, never merged). Ported
to current master by Marcelo Manzo: header paths moved under
hw/core/, class_init()'s const void *data. No functional change
otherwise (this device has no reset or migration state to begin
with).

Boot-tested: guest's thermal_zone0/temp reports 25310 (25.31C),
matching the fixed reading this device returns.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2838_thermal.c         | 98 +++++++++++++++++++++++++++++++
 hw/misc/meson.build               |  1 +
 include/hw/misc/bcm2838_thermal.h | 23 ++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 include/hw/misc/bcm2838_thermal.h

diff --git a/hw/misc/bcm2838_thermal.c b/hw/misc/bcm2838_thermal.c
new file mode 100644
index 0000000000..40148ddbb9
--- /dev/null
+++ b/hw/misc/bcm2838_thermal.c
@@ -0,0 +1,98 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2838_thermal.h"
+#include "hw/core/registerfields.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG32(STAT, 0x200)
+FIELD(STAT, DATA, 0, 10)
+FIELD(STAT, VALID_1, 10, 1)
+FIELD(STAT, VALID_2, 16, 1)
+
+#define BCM2838_THERMAL_SIZE 0xf00
+
+#define THERMAL_OFFSET_C 410040
+#define THERMAL_COEFF  (-487.0f)
+#define MILLIDEGREE_COEFF 1000
+
+static uint16_t bcm2838_thermal_temp2adc(int temp_C)
+{
+    return (temp_C * MILLIDEGREE_COEFF - THERMAL_OFFSET_C) / THERMAL_COEFF;
+}
+
+static uint64_t bcm2838_thermal_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_STAT:
+        /* Temperature is always 25°C */
+        val = FIELD_DP32(val, STAT, DATA, bcm2838_thermal_temp2adc(25));
+        val = FIELD_DP32(val, STAT, VALID_1, 1);
+        val = FIELD_DP32(val, STAT, VALID_2, 1);
+
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s can't access addr: 0x%"HWADDR_PRIx,
+                     TYPE_BCM2838_THERMAL, addr);
+    }
+    return val;
+}
+
+static void bcm2838_thermal_write(void *opaque, hwaddr addr,
+                                      uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write 0x%" PRIx64
+                                " to 0x%" HWADDR_PRIx "\n",
+                __func__, value, addr);
+}
+
+static const MemoryRegionOps bcm2838_thermal_ops = {
+    .read = bcm2838_thermal_read,
+    .write = bcm2838_thermal_write,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void bcm2838_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2838ThermalState *s = BCM2838_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2838_thermal_ops,
+                          s, TYPE_BCM2838_THERMAL, BCM2838_THERMAL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static void bcm2838_thermal_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_thermal_realize;
+
+    /* This device has no state: no need for vmstate or reset */
+}
+
+static const TypeInfo bcm2838_thermal_info = {
+    .name = TYPE_BCM2838_THERMAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Bcm2838ThermalState),
+    .class_init = bcm2838_thermal_class_init,
+};
+
+static void bcm2838_thermal_register_types(void)
+{
+    type_register_static(&bcm2838_thermal_info);
+}
+
+type_init(bcm2838_thermal_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 0d07fcbc20..078996b881 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
   'bcm2838_rng200.c',
+  'bcm2838_thermal.c',
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/include/hw/misc/bcm2838_thermal.h b/include/hw/misc/bcm2838_thermal.h
new file mode 100644
index 0000000000..1ba524ed8b
--- /dev/null
+++ b/include/hw/misc/bcm2838_thermal.h
@@ -0,0 +1,23 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_THERMAL_H
+#define BCM2838_THERMAL_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_THERMAL "bcm2838-thermal"
+OBJECT_DECLARE_SIMPLE_TYPE(Bcm2838ThermalState, BCM2838_THERMAL)
+
+struct Bcm2838ThermalState {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+};
+
+#endif /* BCM2838_THERMAL_H */
-- 
2.55.0


