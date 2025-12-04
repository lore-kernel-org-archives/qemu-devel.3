Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A127D1F9A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 09:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR5kd-0001eb-Pb; Thu, 04 Dec 2025 04:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k8-0001Be-AA
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:21 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vR5k2-0003QF-Tp
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 04:35:19 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6408f9cb1dcso1037638a12.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 01:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764840912; x=1765445712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tuhKr8tcgT6+mlw34YZY+4u+6pYYVBP54SxXZIOuzm8=;
 b=Hv39Ad2p7GSIyRsL4JHoqTdPSvYlAv1SMfv+PC8ZVn8ymVjyjmUQLcejftAQc+vocf
 U+T+/qMd9c0QxI8yxhQFzLTwtRk4eChPf28rprgRDACmTYSu+KnWjq7+C4bRrqeqjcMg
 sn70Vpt3G+GSA5n81AfFo8Qg9xUz6TQT3414eArfr9kzhJC0nCcalANeVIdMu6RQ/XfW
 aALwAEQXb2j8sWv1puK+9o+4QJutPN41YV8N5B7gb5eFLLp6pcGlhSRp0ZraBOiyuzY2
 0unHyqLSXGyXEZn2yI4z8WmnJ+l4Z75wkDsvoO83ALWW4eKaGESR8MtJYGAmv1PRPp1G
 O0Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764840912; x=1765445712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tuhKr8tcgT6+mlw34YZY+4u+6pYYVBP54SxXZIOuzm8=;
 b=Kj/Ig9FhXkTYJeTIoPnF4K/d8g6OatmC9VGiC+8BfScfxkdTJfM9Pmwfpam/tClIJX
 MM9OXL0t8ELIC+cspw8N4T/Bl2E+QIityeXtxIb4fapdiFWFmBvpNMmRO42ErKrnHWWn
 sL4zdvo2RidVw5wss6Soofkjcu2fpozT9suFB4b5JxIVIuB/6ryvVSABBQctWmUE6n+z
 rfb46VSx4AI9vbvjMznNhmgzOFFYozC0HUek8DySkLM20MAyM0rusfwq2h9TFyShDrOI
 XO3d9DKheLndgFM5m0At4Gw3Srh4MhrcZ7vKjjJNJTA04oG4sXREIPQ1ORAAsjkUCHW8
 oerg==
X-Gm-Message-State: AOJu0Yxv3hxCYcxFR2MVilez5ieYNrn+YSypgxmuc2luiNgsX9+IzC+u
 70lm9URpGp6MN43TVBU9ZRJnMfZrlpX4DDLfonllpoJoTkFWEFVBkUpp00UHiN5b
X-Gm-Gg: ASbGnctCelfZPH7A7Ocj4+QWaJH8Dtuninhfd1eO0kbYSW8m/25YsCQUVaFeD5kk1VX
 d8+89+TXpTp3iWs+35L7G2s07WSaNrp72T57HviEcP6ccQF6M7yFVQJ4QkitW+TqBDA0V2pdEfk
 2mo26ALGTYdpJpz8Z+Jt60A8ciJsu6AAh9Ss/EwZCLPmUL70fVY3eE8fj1kaLbRnDQ39JsLj5na
 C7Gwqb1enaSRimRWpSkYQpWSKTwdDTU8eq+6jbW7uc50BcnQp5tybPG7gdKGu0P0V9FkQTHh4Q6
 1w+plz4pPhz4+QdhxvCNLXwrc4dVw+uWVKcH1G88tni3HIdP1LpNJmRxyFaIJTIBW4tJSUqzoZ0
 POpSJ38zSOUoyAIaetdXtwYeFfqpop00BoMJl3c9OLoJ4NG8A1uP0aY2Km3Gr2uX54SNcVmOPvW
 UhtX3o3WvT6heVRHfPal9USqiUgcvW4D0=
X-Google-Smtp-Source: AGHT+IGbTp52ffiAOuTZ0CkHGcZnt1fCqBP/SAx3+ujyxgBGQ3xLec06lqUfgfp8wzncQt7cu1Ue9Q==
X-Received: by 2002:a05:6402:430a:b0:647:a636:76c with SMTP id
 4fb4d7f45d1cf-647abdf82e3mr1739596a12.31.1764840912236; 
 Thu, 04 Dec 2025 01:35:12 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edf72asm856573a12.11.2025.12.04.01.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 01:35:11 -0800 (PST)
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
Subject: [PATCH v5 08/15] hw/misc: Add dummy ZYNQ DDR controller
Date: Thu,  4 Dec 2025 10:34:55 +0100
Message-ID: <20251204093502.50582-9-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204093502.50582-1-corvin.koehne@gmail.com>
References: <20251204093502.50582-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52a.google.com
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

A dummy DDR controller for ZYNQ has been added. While all registers are present,
not all are functional. Read and write access is validated, and the user mode
can be set. This provides a basic DDR controller initialization, preventing
system hangs due to endless polling or similar issues.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
---
 hw/arm/xilinx_zynq.c             |  16 +-
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 hw/misc/xlnx-zynq-ddrc.c         | 413 +++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-zynq-ddrc.h | 148 +++++++++++
 5 files changed, 578 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c82edd3bed..c03ed09a67 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -201,6 +201,17 @@ static void zynq_set_boot_mode(Object *obj, const char *str,
     m->boot_mode = mode;
 }
 
+static void ddr_ctrl_init(uint32_t base)
+{
+    DeviceState *dev;
+    SysBusDevice *busdev;
+
+    dev = qdev_new("zynq.ddr-ctlr");
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, base);
+}
+
 static void zynq_init(MachineState *machine)
 {
     ZynqMachineState *zynq_machine = ZYNQ_MACHINE(machine);
@@ -312,6 +323,8 @@ static void zynq_init(MachineState *machine)
     sysbus_create_varargs("cadence_ttc", 0xF8002000,
             pic[69-GIC_INTERNAL], pic[70-GIC_INTERNAL], pic[71-GIC_INTERNAL], NULL);
 
+    ddr_ctrl_init(0xF8006000);
+
     gem_init(0xE000B000, pic[54 - GIC_INTERNAL]);
     gem_init(0xE000C000, pic[77 - GIC_INTERNAL]);
 
@@ -393,9 +406,6 @@ static void zynq_init(MachineState *machine)
     /* System Watchdog Timer Registers */
     create_unimplemented_device("zynq.swdt", 0xF8005000, 4 * KiB);
 
-    /* DDR memory controller */
-    create_unimplemented_device("zynq.ddrc", 0xF8006000, 4 * KiB);
-
     /* AXI_HP Interface (AFI) */
     create_unimplemented_device("zynq.axi_hp0", 0xF8008000, 0x28);
     create_unimplemented_device("zynq.axi_hp1", 0xF8009000, 0x28);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..3de37c9e1d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -240,4 +240,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config XLNX_ZYNQ_DDRC
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..ffbcca9796 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -95,6 +95,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
+system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xlnx-zynq-ddrc.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-crf.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-apu-ctrl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
diff --git a/hw/misc/xlnx-zynq-ddrc.c b/hw/misc/xlnx-zynq-ddrc.c
new file mode 100644
index 0000000000..0403be8189
--- /dev/null
+++ b/hw/misc/xlnx-zynq-ddrc.c
@@ -0,0 +1,413 @@
+/*
+ * QEMU model of the Xilinx Zynq Double Data Rate Controller
+ *
+ * Copyright (c) Beckhoff Automation GmbH. & Co. KG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/registerfields.h"
+#include "system/block-backend.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "system/dma.h"
+#include "hw/misc/xlnx-zynq-ddrc.h"
+#include "migration/vmstate.h"
+
+#ifndef DDRCTRL_ERR_DEBUG
+#define DDRCTRL_ERR_DEBUG 0
+#endif
+
+static void zynq_ddrctrl_post_write(RegisterInfo *reg, uint64_t val)
+{
+    DDRCTRLState *s = DDRCTRL(reg->opaque);
+    if (reg->access->addr == A_DDRC_CTRL) {
+        if (val & 0x1) {
+            s->reg[R_MODE_STS_REG] |=
+                (R_MODE_STS_REG_DDR_REG_OPERATING_MODE_MASK & 0x1);
+        } else {
+            s->reg[R_MODE_STS_REG] &=
+                ~R_MODE_STS_REG_DDR_REG_OPERATING_MODE_MASK;
+        }
+    }
+}
+
+static const RegisterAccessInfo xlnx_zynq_ddrc_regs_info[] = {
+    /* 0x00 - 0x3C: Basic DDRC control and config */
+    { .name = "DDRC_CTRL",
+      .addr = A_DDRC_CTRL,
+      .reset = 0x00000200,
+      .post_write = zynq_ddrctrl_post_write },
+    { .name = "TWO_RANK_CFG",
+      .addr = A_TWO_RANK_CFG,
+      .reset = 0x000C1076 },
+    { .name = "HPR_REG",
+      .addr = A_HPR_REG,
+      .reset = 0x03C0780F },
+    { .name = "LPR_REG",
+      .addr = A_LPR_REG,
+      .reset = 0x03C0780F },
+    { .name = "WR_REG",
+      .addr = A_WR_REG,
+      .reset = 0x0007F80F },
+    { .name = "DRAM_PARAM_REG0",
+      .addr = A_DRAM_PARAM_REG0,
+      .reset = 0x00041016 },
+    { .name = "DRAM_PARAM_REG1",
+      .addr = A_DRAM_PARAM_REG1,
+      .reset = 0x351B48D9 },
+    { .name = "DRAM_PARAM_REG2",
+      .addr = A_DRAM_PARAM_REG2,
+      .reset = 0x83015904 },
+    { .name = "DRAM_PARAM_REG3",
+      .addr = A_DRAM_PARAM_REG3,
+      .reset = 0x250882D0 },
+    { .name = "DRAM_PARAM_REG4",
+      .addr = A_DRAM_PARAM_REG4,
+      .reset = 0x0000003C },
+    { .name = "DRAM_INIT_PARAM",
+      .addr = A_DRAM_INIT_PARAM,
+      .reset = 0x00002007 },
+    { .name = "DRAM_EMR_REG",
+      .addr = A_DRAM_EMR_REG,
+      .reset = 0x00000008 },
+    { .name = "DRAM_EMR_MR_REG",
+      .addr = A_DRAM_EMR_MR_REG,
+      .reset = 0x00000940 },
+    { .name = "DRAM_BURST8_RDWR",
+      .addr = A_DRAM_BURST8_RDWR,
+      .reset = 0x00020034 },
+    { .name = "DRAM_DISABLE_DQ",
+      .addr = A_DRAM_DISABLE_DQ },
+    { .name = "DRAM_ADDR_MAP_BANK",
+      .addr = A_DRAM_ADDR_MAP_BANK,
+      .reset = 0x00000F77 },
+    { .name = "DRAM_ADDR_MAP_COL",
+      .addr = A_DRAM_ADDR_MAP_COL,
+      .reset = 0xFFF00000 },
+    { .name = "DRAM_ADDR_MAP_ROW",
+      .addr = A_DRAM_ADDR_MAP_ROW,
+      .reset = 0x0FF55555 },
+    { .name = "DRAM_ODT_REG",
+      .addr = A_DRAM_ODT_REG,
+      .reset = 0x00000249 },
+
+    /* 0x4C - 0x5C: PHY and DLL */
+    { .name = "PHY_DBG_REG",
+      .addr = A_PHY_DBG_REG },
+    { .name = "PHY_CMD_TIMEOUT_RDDATA_CPT",
+      .addr = A_PHY_CMD_TIMEOUT_RDDATA_CPT,
+      .reset = 0x00010200 },
+    { .name = "MODE_STS_REG",
+      .addr = A_MODE_STS_REG },
+    { .name = "DLL_CALIB",
+      .addr = A_DLL_CALIB,
+      .reset = 0x00000101 },
+    { .name = "ODT_DELAY_HOLD",
+      .addr = A_ODT_DELAY_HOLD,
+      .reset = 0x00000023 },
+
+    /* 0x60 - 0x7C: Control registers */
+    { .name = "CTRL_REG1",
+      .addr = A_CTRL_REG1,
+      .reset = 0x0000003E },
+    { .name = "CTRL_REG2",
+      .addr = A_CTRL_REG2,
+      .reset = 0x00020000 },
+    { .name = "CTRL_REG3",
+      .addr = A_CTRL_REG3,
+      .reset = 0x00284027 },
+    { .name = "CTRL_REG4",
+      .addr = A_CTRL_REG4,
+      .reset = 0x00001610 },
+    { .name = "CTRL_REG5",
+      .addr = A_CTRL_REG5,
+      .reset = 0x00455111 },
+    { .name = "CTRL_REG6",
+      .addr = A_CTRL_REG6,
+      .reset = 0x00032222 },
+
+    /* 0xA0 - 0xB4: Refresh, ZQ, powerdown, misc */
+    { .name = "CHE_REFRESH_TIMER0",
+      .addr = A_CHE_REFRESH_TIMER0,
+      .reset = 0x00008000 },
+    { .name = "CHE_T_ZQ",
+      .addr = A_CHE_T_ZQ,
+      .reset = 0x10300802 },
+    { .name = "CHE_T_ZQ_SHORT_INTERVAL_REG",
+      .addr = A_CHE_T_ZQ_SHORT_INTERVAL_REG,
+      .reset = 0x0020003A },
+    { .name = "DEEP_PWRDWN_REG",
+      .addr = A_DEEP_PWRDWN_REG },
+    { .name = "REG_2C",
+      .addr = A_REG_2C },
+    { .name = "REG_2D",
+      .addr = A_REG_2D,
+      .reset = 0x00000200 },
+
+    /* 0xB8 - 0xF8: ECC, DFI, etc. */
+    { .name = "DFI_TIMING",
+      .addr = A_DFI_TIMING,
+      .reset = 0x00200067 },
+    { .name = "CHE_ECC_CONTROL_REG_OFFSET",
+      .addr = A_CHE_ECC_CONTROL_REG_OFFSET },
+    { .name = "CHE_CORR_ECC_LOG_REG_OFFSET",
+      .addr = A_CHE_CORR_ECC_LOG_REG_OFFSET },
+    { .name = "CHE_CORR_ECC_ADDR_REG_OFFSET",
+      .addr = A_CHE_CORR_ECC_ADDR_REG_OFFSET },
+    { .name = "CHE_CORR_ECC_DATA_31_0_REG_OFFSET",
+      .addr = A_CHE_CORR_ECC_DATA_31_0_REG_OFFSET },
+    { .name = "CHE_CORR_ECC_DATA_63_32_REG_OFFSET",
+      .addr = A_CHE_CORR_ECC_DATA_63_32_REG_OFFSET },
+    { .name = "CHE_CORR_ECC_DATA_71_64_REG_OFFSET",
+      .addr = A_CHE_CORR_ECC_DATA_71_64_REG_OFFSET },
+    { .name = "CHE_UNCORR_ECC_LOG_REG_OFFSET",
+      .addr = A_CHE_UNCORR_ECC_LOG_REG_OFFSET },
+    { .name = "CHE_UNCORR_ECC_ADDR_REG_OFFSET",
+      .addr = A_CHE_UNCORR_ECC_ADDR_REG_OFFSET },
+    { .name = "CHE_UNCORR_ECC_DATA_31_0_REG_OFFSET",
+      .addr = A_CHE_UNCORR_ECC_DATA_31_0_REG_OFFSET },
+    { .name = "CHE_UNCORR_ECC_DATA_63_32_REG_OFFSET",
+      .addr = A_CHE_UNCORR_ECC_DATA_63_32_REG_OFFSET },
+    { .name = "CHE_UNCORR_ECC_DATA_71_64_REG_OFFSET",
+      .addr = A_CHE_UNCORR_ECC_DATA_71_64_REG_OFFSET },
+    { .name = "CHE_ECC_STATS_REG_OFFSET",
+      .addr = A_CHE_ECC_STATS_REG_OFFSET },
+    { .name = "ECC_SCRUB",
+      .addr = A_ECC_SCRUB,
+      .reset = 0x00000008 },
+    { .name = "CHE_ECC_CORR_BIT_MASK_31_0_REG_OFFSET",
+      .addr = A_CHE_ECC_CORR_BIT_MASK_31_0_REG_OFFSET },
+    { .name = "CHE_ECC_CORR_BIT_MASK_63_32_REG_OFFSET",
+      .addr = A_CHE_ECC_CORR_BIT_MASK_63_32_REG_OFFSET },
+
+    /* 0x114 - 0x174: PHY config, ratios, DQS, WE */
+    { .name = "PHY_RCVER_ENABLE",
+      .addr = A_PHY_RCVER_ENABLE },
+    { .name = "PHY_CONFIG0",
+      .addr = A_PHY_CONFIG0,
+      .reset = 0x40000001 },
+    { .name = "PHY_CONFIG1",
+      .addr = A_PHY_CONFIG1,
+      .reset = 0x40000001 },
+    { .name = "PHY_CONFIG2",
+      .addr = A_PHY_CONFIG2,
+      .reset = 0x40000001 },
+    { .name = "PHY_CONFIG3",
+      .addr = A_PHY_CONFIG3,
+      .reset = 0x40000001 },
+    { .name = "PHY_INIT_RATIO0",
+      .addr = A_PHY_INIT_RATIO0 },
+    { .name = "PHY_INIT_RATIO1",
+      .addr = A_PHY_INIT_RATIO1 },
+    { .name = "PHY_INIT_RATIO2",
+      .addr = A_PHY_INIT_RATIO2 },
+    { .name = "PHY_INIT_RATIO3",
+      .addr = A_PHY_INIT_RATIO3 },
+    { .name = "PHY_RD_DQS_CFG0",
+      .addr = A_PHY_RD_DQS_CFG0,
+      .reset = 0x00000040 },
+    { .name = "PHY_RD_DQS_CFG1",
+      .addr = A_PHY_RD_DQS_CFG1,
+      .reset = 0x00000040 },
+    { .name = "PHY_RD_DQS_CFG2",
+      .addr = A_PHY_RD_DQS_CFG2,
+      .reset = 0x00000040 },
+    { .name = "PHY_RD_DQS_CFG3",
+      .addr = A_PHY_RD_DQS_CFG3,
+      .reset = 0x00000040 },
+    { .name = "PHY_WR_DQS_CFG0",
+      .addr = A_PHY_WR_DQS_CFG0 },
+    { .name = "PHY_WR_DQS_CFG1",
+      .addr = A_PHY_WR_DQS_CFG1 },
+    { .name = "PHY_WR_DQS_CFG2",
+      .addr = A_PHY_WR_DQS_CFG2 },
+    { .name = "PHY_WR_DQS_CFG3",
+      .addr = A_PHY_WR_DQS_CFG3 },
+    { .name = "PHY_WE_CFG0",
+      .addr = A_PHY_WE_CFG0,
+      .reset = 0x00000040 },
+    { .name = "PHY_WE_CFG1",
+      .addr = A_PHY_WE_CFG1,
+      .reset = 0x00000040 },
+    { .name = "PHY_WE_CFG2",
+      .addr = A_PHY_WE_CFG2,
+      .reset = 0x00000040 },
+    { .name = "PHY_WE_CFG3",
+      .addr = A_PHY_WE_CFG3,
+      .reset = 0x00000040 },
+
+    /* 0x17C - 0x194: Write data slaves, misc */
+    { .name = "WR_DATA_SLV0",
+      .addr = A_WR_DATA_SLV0,
+      .reset = 0x00000080 },
+    { .name = "WR_DATA_SLV1",
+      .addr = A_WR_DATA_SLV1,
+      .reset = 0x00000080 },
+    { .name = "WR_DATA_SLV2",
+      .addr = A_WR_DATA_SLV2,
+      .reset = 0x00000080 },
+    { .name = "WR_DATA_SLV3",
+      .addr = A_WR_DATA_SLV3,
+      .reset = 0x00000080 },
+    { .name = "REG_64",
+      .addr = A_REG_64,
+      .reset = 0x10020000 },
+    { .name = "REG_65",
+      .addr = A_REG_65 },
+
+    /* 0x1A4 - 0x1C4: Misc registers */
+    { .name = "REG69_6A0",
+      .addr = A_REG69_6A0 },
+    { .name = "REG69_6A1",
+      .addr = A_REG69_6A1 },
+    { .name = "REG6C_6D2",
+      .addr = A_REG6C_6D2 },
+    { .name = "REG6C_6D3",
+      .addr = A_REG6C_6D3 },
+    { .name = "REG6E_710",
+      .addr = A_REG6E_710 },
+    { .name = "REG6E_711",
+      .addr = A_REG6E_711 },
+    { .name = "REG6E_712",
+      .addr = A_REG6E_712 },
+    { .name = "REG6E_713",
+      .addr = A_REG6E_713 },
+
+    /* 0x1CC - 0x1E8: DLL, PHY status */
+    { .name = "PHY_DLL_STS0",
+      .addr = A_PHY_DLL_STS0 },
+    { .name = "PHY_DLL_STS1",
+      .addr = A_PHY_DLL_STS1 },
+    { .name = "PHY_DLL_STS2",
+      .addr = A_PHY_DLL_STS2 },
+    { .name = "PHY_DLL_STS3",
+      .addr = A_PHY_DLL_STS3 },
+    { .name = "DLL_LOCK_STS",
+      .addr = A_DLL_LOCK_STS },
+    { .name = "PHY_CTRL_STS",
+      .addr = A_PHY_CTRL_STS },
+    { .name = "PHY_CTRL_STS_REG2",
+      .addr = A_PHY_CTRL_STS_REG2 },
+
+    /* 0x200 - 0x2B4: AXI, LPDDR, misc */
+    { .name = "AXI_ID",
+      .addr = A_AXI_ID },
+    { .name = "PAGE_MASK",
+      .addr = A_PAGE_MASK },
+    { .name = "AXI_PRIORITY_WR_PORT0",
+      .addr = A_AXI_PRIORITY_WR_PORT0,
+      .reset = 0x000803FF },
+    { .name = "AXI_PRIORITY_WR_PORT1",
+      .addr = A_AXI_PRIORITY_WR_PORT1,
+      .reset = 0x000803FF },
+    { .name = "AXI_PRIORITY_WR_PORT2",
+      .addr = A_AXI_PRIORITY_WR_PORT2,
+      .reset = 0x000803FF },
+    { .name = "AXI_PRIORITY_WR_PORT3",
+      .addr = A_AXI_PRIORITY_WR_PORT3,
+      .reset = 0x000803FF },
+    { .name = "AXI_PRIORITY_RD_PORT0",
+      .addr = A_AXI_PRIORITY_RD_PORT0,
+      .reset = 0x000003FF },
+    { .name = "AXI_PRIORITY_RD_PORT1",
+      .addr = A_AXI_PRIORITY_RD_PORT1,
+      .reset = 0x000003FF },
+    { .name = "AXI_PRIORITY_RD_PORT2",
+      .addr = A_AXI_PRIORITY_RD_PORT2,
+      .reset = 0x000003FF },
+    { .name = "AXI_PRIORITY_RD_PORT3",
+      .addr = A_AXI_PRIORITY_RD_PORT3,
+      .reset = 0x000003FF },
+    { .name = "EXCL_ACCESS_CFG0",
+      .addr = A_EXCL_ACCESS_CFG0 },
+    { .name = "EXCL_ACCESS_CFG1",
+      .addr = A_EXCL_ACCESS_CFG1 },
+    { .name = "EXCL_ACCESS_CFG2",
+      .addr = A_EXCL_ACCESS_CFG2 },
+    { .name = "EXCL_ACCESS_CFG3",
+      .addr = A_EXCL_ACCESS_CFG3 },
+    { .name = "MODE_REG_READ",
+      .addr = A_MODE_REG_READ },
+    { .name = "LPDDR_CTRL0",
+      .addr = A_LPDDR_CTRL0 },
+    { .name = "LPDDR_CTRL1",
+      .addr = A_LPDDR_CTRL1 },
+    { .name = "LPDDR_CTRL2",
+      .addr = A_LPDDR_CTRL2,
+      .reset = 0x003C0015 },
+    { .name = "LPDDR_CTRL3",
+      .addr = A_LPDDR_CTRL3,
+      .reset = 0x00000601 },
+};
+
+static void zynq_ddrctrl_reset(DeviceState *dev)
+{
+    DDRCTRLState *s = DDRCTRL(dev);
+    int i;
+
+    for (i = 0; i < ZYNQ_DDRCTRL_NUM_REG; ++i) {
+        register_reset(&s->regs_info[i]);
+    }
+}
+
+static const MemoryRegionOps ddrctrl_ops = {
+    .read = register_read_memory,
+    .write = register_write_memory,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_zynq_ddrctrl = {
+    .name = "zynq_ddrc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(reg, DDRCTRLState, ZYNQ_DDRCTRL_NUM_REG),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void zynq_ddrctrl_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    DDRCTRLState *s = DDRCTRL(obj);
+
+    s->reg_array =
+        register_init_block32(DEVICE(obj), xlnx_zynq_ddrc_regs_info,
+                              ARRAY_SIZE(xlnx_zynq_ddrc_regs_info),
+                              s->regs_info, s->reg,
+                              &ddrctrl_ops,
+                              DDRCTRL_ERR_DEBUG,
+                              ZYNQ_DDRCTRL_MMIO_SIZE);
+
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
+}
+
+static void zynq_ddrctrl_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, zynq_ddrctrl_reset);
+    dc->vmsd = &vmstate_zynq_ddrctrl;
+}
+
+static const TypeInfo ddrctrl_info = {
+    .name = TYPE_DDRCTRL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DDRCTRLState),
+    .instance_init = zynq_ddrctrl_init,
+    .class_init = zynq_ddrctrl_class_init,
+};
+
+static void ddrctrl_register_types(void)
+{
+    type_register_static(&ddrctrl_info);
+}
+
+type_init(ddrctrl_register_types)
diff --git a/include/hw/misc/xlnx-zynq-ddrc.h b/include/hw/misc/xlnx-zynq-ddrc.h
new file mode 100644
index 0000000000..3d45a02176
--- /dev/null
+++ b/include/hw/misc/xlnx-zynq-ddrc.h
@@ -0,0 +1,148 @@
+/*
+ * QEMU model of the Xilinx Zynq Double Data Rate Controller
+ *
+ * Copyright (c) Beckhoff Automation GmbH. & Co. KG
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef XLNX_ZYNQ_DDRC_H
+#define XLNX_ZYNQ_DDRC_H
+
+#include "hw/sysbus.h"
+#include "hw/register.h"
+
+#define TYPE_DDRCTRL "zynq.ddr-ctlr"
+#define DDRCTRL(obj) \
+    OBJECT_CHECK(DDRCTRLState, (obj), TYPE_DDRCTRL)
+
+REG32(DDRC_CTRL, 0x00)
+REG32(TWO_RANK_CFG, 0x04)
+REG32(HPR_REG, 0x08)
+REG32(LPR_REG, 0x0C)
+REG32(WR_REG, 0x10)
+REG32(DRAM_PARAM_REG0, 0x14)
+REG32(DRAM_PARAM_REG1, 0x18)
+REG32(DRAM_PARAM_REG2, 0x1C)
+REG32(DRAM_PARAM_REG3, 0x20)
+REG32(DRAM_PARAM_REG4, 0x24)
+REG32(DRAM_INIT_PARAM, 0x28)
+REG32(DRAM_EMR_REG, 0x2C)
+REG32(DRAM_EMR_MR_REG, 0x30)
+REG32(DRAM_BURST8_RDWR, 0x34)
+REG32(DRAM_DISABLE_DQ, 0x38)
+REG32(DRAM_ADDR_MAP_BANK, 0x3C)
+REG32(DRAM_ADDR_MAP_COL, 0x40)
+REG32(DRAM_ADDR_MAP_ROW, 0x44)
+REG32(DRAM_ODT_REG, 0x48)
+REG32(PHY_DBG_REG, 0x4C)
+REG32(PHY_CMD_TIMEOUT_RDDATA_CPT, 0x50)
+REG32(MODE_STS_REG, 0x54)
+    FIELD(MODE_STS_REG, DDR_REG_DBG_STALL, 3, 3)
+    FIELD(MODE_STS_REG, DDR_REG_OPERATING_MODE, 0, 2)
+REG32(DLL_CALIB, 0x58)
+REG32(ODT_DELAY_HOLD, 0x5C)
+REG32(CTRL_REG1, 0x60)
+REG32(CTRL_REG2, 0x64)
+REG32(CTRL_REG3, 0x68)
+REG32(CTRL_REG4, 0x6C)
+REG32(CTRL_REG5, 0x78)
+REG32(CTRL_REG6, 0x7C)
+REG32(CHE_REFRESH_TIMER0, 0xA0)
+REG32(CHE_T_ZQ, 0xA4)
+REG32(CHE_T_ZQ_SHORT_INTERVAL_REG, 0xA8)
+REG32(DEEP_PWRDWN_REG, 0xAC)
+REG32(REG_2C, 0xB0)
+REG32(REG_2D, 0xB4)
+REG32(DFI_TIMING, 0xB8)
+REG32(CHE_ECC_CONTROL_REG_OFFSET, 0xC4)
+REG32(CHE_CORR_ECC_LOG_REG_OFFSET, 0xC8)
+REG32(CHE_CORR_ECC_ADDR_REG_OFFSET, 0xCC)
+REG32(CHE_CORR_ECC_DATA_31_0_REG_OFFSET, 0xD0)
+REG32(CHE_CORR_ECC_DATA_63_32_REG_OFFSET, 0xD4)
+REG32(CHE_CORR_ECC_DATA_71_64_REG_OFFSET, 0xD8)
+REG32(CHE_UNCORR_ECC_LOG_REG_OFFSET, 0xDC)
+REG32(CHE_UNCORR_ECC_ADDR_REG_OFFSET, 0xE0)
+REG32(CHE_UNCORR_ECC_DATA_31_0_REG_OFFSET, 0xE4)
+REG32(CHE_UNCORR_ECC_DATA_63_32_REG_OFFSET, 0xE8)
+REG32(CHE_UNCORR_ECC_DATA_71_64_REG_OFFSET, 0xEC)
+REG32(CHE_ECC_STATS_REG_OFFSET, 0xF0)
+REG32(ECC_SCRUB, 0xF4)
+REG32(CHE_ECC_CORR_BIT_MASK_31_0_REG_OFFSET, 0xF8)
+REG32(CHE_ECC_CORR_BIT_MASK_63_32_REG_OFFSET, 0xFC)
+REG32(PHY_RCVER_ENABLE, 0x114)
+REG32(PHY_CONFIG0, 0x118)
+REG32(PHY_CONFIG1, 0x11C)
+REG32(PHY_CONFIG2, 0x120)
+REG32(PHY_CONFIG3, 0x124)
+REG32(PHY_INIT_RATIO0, 0x12C)
+REG32(PHY_INIT_RATIO1, 0x130)
+REG32(PHY_INIT_RATIO2, 0x134)
+REG32(PHY_INIT_RATIO3, 0x138)
+REG32(PHY_RD_DQS_CFG0, 0x140)
+REG32(PHY_RD_DQS_CFG1, 0x144)
+REG32(PHY_RD_DQS_CFG2, 0x148)
+REG32(PHY_RD_DQS_CFG3, 0x14C)
+REG32(PHY_WR_DQS_CFG0, 0x154)
+REG32(PHY_WR_DQS_CFG1, 0x158)
+REG32(PHY_WR_DQS_CFG2, 0x15C)
+REG32(PHY_WR_DQS_CFG3, 0x160)
+REG32(PHY_WE_CFG0, 0x168)
+REG32(PHY_WE_CFG1, 0x16C)
+REG32(PHY_WE_CFG2, 0x170)
+REG32(PHY_WE_CFG3, 0x174)
+REG32(WR_DATA_SLV0, 0x17C)
+REG32(WR_DATA_SLV1, 0x180)
+REG32(WR_DATA_SLV2, 0x184)
+REG32(WR_DATA_SLV3, 0x188)
+REG32(REG_64, 0x190)
+REG32(REG_65, 0x194)
+REG32(REG69_6A0, 0x1A4)
+REG32(REG69_6A1, 0x1A8)
+REG32(REG6C_6D2, 0x1B0)
+REG32(REG6C_6D3, 0x1B4)
+REG32(REG6E_710, 0x1B8)
+REG32(REG6E_711, 0x1BC)
+REG32(REG6E_712, 0x1C0)
+REG32(REG6E_713, 0x1C4)
+REG32(PHY_DLL_STS0, 0x1CC)
+REG32(PHY_DLL_STS1, 0x1D0)
+REG32(PHY_DLL_STS2, 0x1D4)
+REG32(PHY_DLL_STS3, 0x1D8)
+REG32(DLL_LOCK_STS, 0x1E0)
+REG32(PHY_CTRL_STS, 0x1E4)
+REG32(PHY_CTRL_STS_REG2, 0x1E8)
+REG32(AXI_ID, 0x200)
+REG32(PAGE_MASK, 0x204)
+REG32(AXI_PRIORITY_WR_PORT0, 0x208)
+REG32(AXI_PRIORITY_WR_PORT1, 0x20C)
+REG32(AXI_PRIORITY_WR_PORT2, 0x210)
+REG32(AXI_PRIORITY_WR_PORT3, 0x214)
+REG32(AXI_PRIORITY_RD_PORT0, 0x218)
+REG32(AXI_PRIORITY_RD_PORT1, 0x21C)
+REG32(AXI_PRIORITY_RD_PORT2, 0x220)
+REG32(AXI_PRIORITY_RD_PORT3, 0x224)
+REG32(EXCL_ACCESS_CFG0, 0x294)
+REG32(EXCL_ACCESS_CFG1, 0x298)
+REG32(EXCL_ACCESS_CFG2, 0x29C)
+REG32(EXCL_ACCESS_CFG3, 0x2A0)
+REG32(MODE_REG_READ, 0x2A4)
+REG32(LPDDR_CTRL0, 0x2A8)
+REG32(LPDDR_CTRL1, 0x2AC)
+REG32(LPDDR_CTRL2, 0x2B0)
+REG32(LPDDR_CTRL3, 0x2B4)
+
+
+#define ZYNQ_DDRCTRL_MMIO_SIZE      0x400
+#define ZYNQ_DDRCTRL_NUM_REG        (ZYNQ_DDRCTRL_MMIO_SIZE / 4)
+
+typedef struct DDRCTRLState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    RegisterInfoArray *reg_array;
+    uint32_t reg[ZYNQ_DDRCTRL_NUM_REG];
+    RegisterInfo regs_info[ZYNQ_DDRCTRL_NUM_REG];
+} DDRCTRLState;
+#endif
-- 
2.47.3


