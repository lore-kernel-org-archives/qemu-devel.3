Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7178CD4F39
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Ik-000588-6G; Wed, 13 May 2026 06:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fi-0003Ba-Id
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fd-0001UD-Cc
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so65831065e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669738; x=1779274538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o2t7PZDF9vUDOSmBWfSaV5aVfQQ9dcmhkK2nrRvQItQ=;
 b=BX57nFcXS+I7RUzA+MvABfbbBf0M+kpYyZtHlwTVbXp3gc3Om0/HeS2RttTxdMsmnj
 XCyOge1RmgL4bUsvBhbSKrZ1izPFl3EJ7m+nQ6VzSW9xmR1FF2pW1uzLh5Xb5ejhhkYV
 L2NeSta+L5+wIf0noSZHEkg4UjkUfziiFDB+a/gl7z8pKExmfsGWsGFMMLWvtchm1cIV
 40qMTobQhyAAcKCM2N/ZzwQZ4w4IckWpAJ0YjfJPZCZQOpUD84cIYkN6BNsUo+/LS7FK
 myKFBmD+Vkkgm8RDdl4h3WW+PkGUvfLKMwahLwrNbEqnAFHDwgimz8FbDYC1eQexllJ1
 7Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669738; x=1779274538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o2t7PZDF9vUDOSmBWfSaV5aVfQQ9dcmhkK2nrRvQItQ=;
 b=XtwkEBRRj2z7wgCkD8jwlJIH6YKr5ukDxJi15cArXX8Nxbo4sTF4lwdw/2O6mepvbZ
 MTvTsj3MjqKInVvo1vcpj4/oCDV4MhTgMnA3QWeQni9msiK9UIYz5rgAR2/RnJi1J2YT
 yCzpAzgiq/n4GD5BRMQgLwl5JzaekepEhtsGVa4m/pOaRJFeZ27RTdQYe8FsNu3jKPkd
 6M4Uirr8hhWa6ineWOo/C4DKqx/Ogd3b5x7scOSq6tWwdoCSUeQDsfgOjQKRC7BgPlYI
 rGn7B3ndA6giah2b+8NwtNROvxt5SLoE8Pev1HOT1Dx13ViE9+LHl8cfrKDigMnJl02U
 0TwQ==
X-Gm-Message-State: AOJu0Yy8YlYuAWjZliRd0cCX1f1wFG8o0wxskuqzo8orDlMgLO6EB7BR
 3OM9EDzLdzeqp/H/VQJh23WXvz5YYe4/Wq6YbrWg8nLpT+rShYLoO2tDCXA4uX+c
X-Gm-Gg: Acq92OF86Y4ZUyUviAF+qefGLjwHHL5FI6G7cW5T07xDMsKCEf4VT7vbfa5k1mFXApR
 C4/IA5pfVvyzF7oFC7cPtUq3GCna9GagXY6wIo/1EBIE54DIMgrpKr6xS/39YthWyQpHfgZKQ8J
 Am7taRzm+PsmLk5d97ZVAiGRKt/u0C66BQFacGMnno7X1iSMxpyJ4e/A+s6+f0VzAyFw+63qHnS
 BKHwlspZ2jHYPDZgCupvSLD4GQcRq6Vh/xd2X/FMSTqKaLrPKQRoQ9yVXDro8tsjKcuvN2In+BM
 z+KwK6+GFsMNesl5FkusBpdrNnN+wKLqWvd7VYxY4omnS6aA/obcr43VxRDpc1eOYQsjiYtMHrT
 2VquNohYoYiO0MBzZb/KCG3UtnMranFSPD2fG1TDyV2I99ykaXSl3oVqa3gqtvyCpFHqs8mLmsE
 M9+iRLfMRN+WmweFyBgb6dA0K1dv7WBQaXrlASFNnO7pk8vWd5fnnszPs=
X-Received: by 2002:a05:600c:c4ac:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-48fc9a3a9c1mr39734435e9.21.1778669738403; 
 Wed, 13 May 2026 03:55:38 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:38 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v6 14/15] hw/arm: Add new machine based on xilinx-zynq-a9 for
 Beckhoff CX7200
Date: Wed, 13 May 2026 12:55:16 +0200
Message-ID: <20260513105517.146706-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

Introduce a new machine type 'beckhoff-cx7200' that inherits from the
xilinx-zynq-a9 machine. The CX7200 is an industrial PC based on the
Xilinx Zynq-7000 SoC.
The machine preserves all standard Zynq features (boot-mode selection,
SPI, UART, Ethernet, etc.) while adding CX7200-specific hardware
components.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/Kconfig           |   7 +++
 hw/arm/beckhoff_CX7200.c | 104 +++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |   1 +
 3 files changed, 112 insertions(+)
 create mode 100644 hw/arm/beckhoff_CX7200.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5b198402d5..ecb1729768 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -291,6 +291,13 @@ config ZYNQ
     select XILINX_SPIPS
     select ZYNQ_DEVCFG
 
+config BECKHOFF_CX7200
+    bool
+    default y
+    depends on TCG && ARM
+    select ZYNQ
+    select BECKHOFF_CCAT
+
 config ARM_V7M
     bool
     # currently v7M must be included in a TCG build due to translate.c
diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
new file mode 100644
index 0000000000..2edca63267
--- /dev/null
+++ b/hw/arm/beckhoff_CX7200.c
@@ -0,0 +1,104 @@
+
+/*
+ * Modified Xilinx Zynq Baseboard System emulation for Beckhoff CX7200.
+ *
+ * Copyright (c) 2024 Beckhoff Automation GmbH & Co. KG
+ *
+ * Based on /hw/arm/xilinx_zynq.c:
+ * Copyright (c) 2010 Xilinx.
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.croshtwaite@petalogix.com)
+ * Copyright (c) 2012 Petalogix Pty Ltd.
+ * Original code by Haibing Ma.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/core/boards.h"
+#include "hw/block/block.h"
+#include "hw/core/loader.h"
+#include "qemu/error-report.h"
+#include "hw/arm/xilinx_zynq.h"  /* For ZynqMachineState */
+#include "hw/cpu/a9mpcore.h"
+#include "qom/object.h"
+
+#define TYPE_CX7200_MACHINE MACHINE_TYPE_NAME("beckhoff-cx7200")
+
+#define CX7200_PERIPHCLK_DIVIDER 2
+#define CX7200_PS7_CPU_CLK_FREQUENCY 720000000
+
+static void ccat_init(uint32_t base, BlockBackend *eeprom_blk)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("beckhoff-ccat");
+    if (eeprom_blk) {
+        qdev_prop_set_drive_err(dev, "eeprom", eeprom_blk, &error_fatal);
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
+static void beckhoff_cx7200_init(MachineState *machine)
+{
+    DriveInfo *di;
+    BlockBackend *blk;
+    MachineClass *parent_mc;
+    DeviceState *a9mpcore_dev;
+    A9MPPrivState *a9mp_priv_state;
+
+    object_property_set_str(OBJECT(machine), "flash-type", "is25lp016d",
+                            &error_fatal);
+
+    parent_mc = MACHINE_CLASS(object_class_get_parent(
+                                  object_get_class(OBJECT(machine))));
+    parent_mc->init(machine);
+
+    /* Find A9MPCore and set timer frequencies directly */
+    a9mpcore_dev = DEVICE(object_resolve_path_type("", TYPE_A9MPCORE_PRIV,
+                                                   NULL));
+    if (a9mpcore_dev) {
+        a9mp_priv_state = A9MPCORE_PRIV(a9mpcore_dev);
+
+        /* Direct struct access - devices are already realized */
+        a9mp_priv_state->gtimer.freq_hz = CX7200_PS7_CPU_CLK_FREQUENCY;
+        a9mp_priv_state->gtimer.periphclk_divider = CX7200_PERIPHCLK_DIVIDER;
+        a9mp_priv_state->mptimer.freq_hz = CX7200_PS7_CPU_CLK_FREQUENCY;
+        a9mp_priv_state->mptimer.periphclk_divider = CX7200_PERIPHCLK_DIVIDER;
+        a9mp_priv_state->wdt.freq_hz = CX7200_PS7_CPU_CLK_FREQUENCY;
+        a9mp_priv_state->wdt.periphclk_divider = CX7200_PERIPHCLK_DIVIDER;
+    } else {
+        error_setg(&error_fatal, "Could not find A9MPCore device "
+                                 "for CX7200 timer configuration");
+    }
+
+    di = drive_get(IF_NONE, 0, 0);
+    blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    ccat_init(0x40000000, blk);
+}
+
+static void beckhoff_cx7200_machine_class_init(ObjectClass *oc,
+                                               const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Beckhoff CX7200 Industrial PC (Zynq-based)";
+    mc->init = beckhoff_cx7200_init;
+}
+
+static const TypeInfo beckhoff_cx7200_machine_type = {
+    .name = TYPE_CX7200_MACHINE,
+    .parent = TYPE_ZYNQ_MACHINE,
+    .class_init = beckhoff_cx7200_machine_class_init,
+    .instance_size = sizeof(ZynqMachineState),
+};
+
+static void beckhoff_cx7200_machine_register_types(void)
+{
+    type_register_static(&beckhoff_cx7200_machine_type);
+}
+
+type_init(beckhoff_cx7200_machine_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 84b8ec5fb5..cb51d8a484 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_BECKHOFF_CX7200', if_true: files('beckhoff_CX7200.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
-- 
2.47.3


