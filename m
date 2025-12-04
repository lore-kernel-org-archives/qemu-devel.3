Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2892D1D89F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kp-0001uR-Jg; Thu, 04 Dec 2025 04:36:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5kE-0001Fl-Nl
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:28 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k9-0003UD-Rx
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:25 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b73545723ebso112059266b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840919; x=1765445719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjUoPuVHOv7yCQYn+9czDBAPb7tQCMl2Bj+611ltDLg=;
 b=kU9P2Z/edxk4/y4mLDReE6yLxmD+E9qOAUbwPXuEIqD8W3DURnEn1Gs7bk/RkmZc48
 xu0nBEWKVcdBqFd18xPfz12t64vQD3YQcvwyQx84UTRBwyq65lRzHOsPDVj2qtJ9XlfS
 4xMjASw+2L6YB3h2nXk+M4YjoUifWqoUBqAMMavVxFFngbKskQQHBfKADvLqgTKkDEU/
 SzVh/9YFIZqvND76z1kP2vaTgGAF3IbVd7dbDIy/w2XZ1qWO74VOceLr7F3AR1bTL4pu
 GVtRBl6GPfPO9QFBFi2Q8Zp1BbP20dOPeTEURUB+U9hd2K1nEX4dTZw6GWoo9UF1hIJp
 r3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840919; x=1765445719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SjUoPuVHOv7yCQYn+9czDBAPb7tQCMl2Bj+611ltDLg=;
 b=LQuDd+GhBQc8k2MycpYGEbramalyXJYwV3dGNvdBvxERdRR9NVj6evpzddC7hyMQ74
 D/YMQ2CdG3GygEAdNYxZtz7HOVMxfkOicUrclPkFxkTwtTbMIP2Yqmp3CgX1/8jwhoFW
 ihsUHDcfDVTsYWCp2LIJrTB2GTBhY9Lhz61gUR3adxjnhhgQKKg5j+MrhsWuyTsRf04r
 Q3L5NuCuV2PdrYUzRFPnqVRsO8f9w9wXk2DkXLoWMhGWpAZzs2DsOcLKForkMx2n62in
 uqOop3hMOAcCRPy7pTKaDoyOt94s3ufzJnkh135m9KD/h7AZhwJ3TBglBDaNoNuYWxfU
 Kqvg==
X-Gm-Message-State: AOJu0YwUU5OCZEVSEJ0Klin5DE1xT9IJZpgLIqNlta0ucL8OJUSeRZaN
 W+jcq+zgfOzZTi9KZvTaGajUxGn4SnqAeqDq4FxNiujq5mkBHO1scB+NV8nf5hef
X-Gm-Gg: ASbGncvTmvys4n/+OX+H2krLMn1gu4kFmOpmnMk9a5PgqdlpNd24pzaGKGwVG78Xtpn
 hOZevRLzeqTPw49seq7blrMFSbipUjUe/lj1z7frjUopzy4whYO7DShspSt9Nc/LZYg96A0FLCz
 HNT4mA49Xy90q6plcKK/w8/ZSBB1p7OTwQzz0Y4AZo6O3IFu/IzwF1EkLMDH6LIAGfQ6jKBY76S
 eJQfDtdxIvz5tf68XZH2alOJ9V7qdZXKU1pe/13ou2UvPqg4arG5GmIb7dayz87dKfNPG0/JpZy
 x3vFkA3HTKLI0BMDqGZqYsvxbE2gK3dL8dcx7tmqUw0s4EB2500JySrlLZ0akAo1+YEXrCcvFNN
 oQwLSFpnCPiXwDmKKcex3kotPWJ53xFrT4/7GOwytpyX8xdcqLH2S9e39elWmxwF86bLYGINlvF
 MEmpLaT6Fy43k+zfZtLrNmlRqQACQqeeU=
X-Google-Smtp-Source: AGHT+IGhuE58R6Jfkf4F52pxLW1PeusGbMrej8Q4EsRTWnj5XnVcgmkRN6VHznSzldgIth5WHoRfqw==
X-Received: by 2002:a17:907:1b1e:b0:b6d:5f52:eee8 with SMTP id
 a640c23a62f3a-b79dc520f60mr567068566b.29.1764840919274; 
 Thu, 04 Dec 2025 01:35:19 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:18 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v5 14/15] hw/arm: Add new machine based on xilinx-zynq-a9 for
 Beckhoff CX7200
Date: Thu,  4 Dec 2025 10:35:01 +0100
Message-ID: <20251204093502.50582-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x630.google.com
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
index 7877506384..00810634d2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -307,6 +307,13 @@ config ZYNQ
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
index 0000000000..85e2fd0fd6
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
+#include "hw/boards.h"
+#include "hw/block/block.h"
+#include "hw/loader.h"
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
index aeaf654790..4ea5d2648c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_common_ss.add(when: 'CONFIG_BECKHOFF_CX7200', if_true: files('beckhoff_CX7200.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
-- 
2.47.3


