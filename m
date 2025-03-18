Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E6C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWir-0001r4-Cx; Tue, 18 Mar 2025 09:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWik-0001Lr-Ds; Tue, 18 Mar 2025 09:11:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWih-0003l4-DK; Tue, 18 Mar 2025 09:11:01 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso185092766b.0; 
 Tue, 18 Mar 2025 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303457; x=1742908257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8z+PHMNfzA0XW1PBgVhogbq+RReNZeV3FJfN4W1yf98=;
 b=bJg2A4sebX/6VWcyZbFM9bfqE8BhQzCdwL2PI1HcfeoohJuk946xulXgUzf42xvsVE
 pb6V7ZH/JTRW4KEViLxItRjlwRD+seYjBMCASWdsD7HDHOnUnGLBEiFVwLmMdDY2Ho+H
 Sj34SYVnkB081FmH4OTDmhfb+j+7G2gAqYo4suPq7gU1kNTI1f2iXPuHkDBQACu7OhK5
 41oyNrsIgjv41yxKXTN8ozObxeAjxoJ69u8dAiQ+Ust4pqIndXTxOr9XrpCNbigPIfuO
 haVuUcSCsV02kuSjP4D9kmDmywbKWoe8CVCpxwrgjtq4aM1F9cXEjkUuJsVU/HrETfqX
 za3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303457; x=1742908257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z+PHMNfzA0XW1PBgVhogbq+RReNZeV3FJfN4W1yf98=;
 b=YGyeUr0Ti8+xvMugsZxBsAHKcgkGMAlpHom3m5PB3O6nCzZUg4kU4nDI0cxAI/Q6em
 jX4p5yI2pWOvK6gpUbPoGYmAeCHKKaIolISecXh8Pyy7BLDq1oaInvVUok/8Bq6O7xlG
 mqMhiF4WCSpg74rgZO5hm+btUaahLbo/xyL3/pgUDkhtiRb5o3DGx2uP/0E5Ir6TxLom
 DPP7BSMv1SOQcHgE/5KpDWhZ/Zdje9ZL57lvAIgehG55qE1sYVF5lMUl0OIWwy2VbKxm
 F9N/6YDC75yavEXaFq9OTFDMfM/VLqV6vZrOWHvjyjq829JF9ld1gVO1mdX8V2xJa+VU
 rn8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcaJhVdwWd+dHaA7+Vx8+MhH65Zg6b9DX0lNZ7wYYK0yhx5OzsXdtn4iIEPRjCuZqPYAC7XWYN4A==@nongnu.org
X-Gm-Message-State: AOJu0Yzhr1+Y/ngCEtAsycNgyLMEzAyGtWsoj4eMqgCl8mN9RBWep2/P
 krP3tn2YrmYs89+P4q85+CGlZuJWG0jxTdrmy5Fkq8BTBUBPyU3sYGps56be
X-Gm-Gg: ASbGncsAdmiHD3KqRt5WLAb7dgmISbxoZ1aiX8vpc9+6IQHL/9qRRppABy0tQdTqpIi
 xV3xLnlSnqQu0U17AFw8/INrt2Q0hzgZEi6q8I22DAVeHghA7OIZaklNlK8qOpT9BRePUEtlvmA
 q75PEo8N8ythcvrRZ+6kYCQU46ETstgpfQMy7cgjKl20bgCle+5ZkxDJZpH1/JD8MGSBDRLbPph
 NaysRHe6vht4OiK06gLIoX5NwemAbbe9Op0UysvBTi0zsywm1dkVOfhr0H7DROrhS5AaJhh947a
 XuGRkVA4Cgm3LLYgN+rS7rnBfEwelsEv8r+C9GtG2kxttq/T7pu71H7SmabRtdYZVJo=
X-Google-Smtp-Source: AGHT+IGY9c4APGKBp+xm0KfRaH0oxOof2+Jwm8vsWPIt+arlYfsaJlLTDrl4RgF+nBwnbdOyenjTkA==
X-Received: by 2002:a17:907:2ce3:b0:ac2:c397:2b36 with SMTP id
 a640c23a62f3a-ac3302c92cfmr1630146266b.22.1742303453859; 
 Tue, 18 Mar 2025 06:10:53 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:10:53 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 09/21] hw/misc: Add dummy ZYNQ DDR controller
Date: Tue, 18 Mar 2025 14:08:00 +0100
Message-ID: <20250318130817.119636-10-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x62a.google.com
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

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/misc/Kconfig         |   3 +
 hw/misc/meson.build     |   1 +
 hw/misc/zynq_ddr-ctrl.c | 331 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 335 insertions(+)
 create mode 100644 hw/misc/zynq_ddr-ctrl.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..1bc4228572 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -222,4 +222,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config DDR_CTRLR
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..8d4c4279c4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -91,6 +91,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
+system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_ddr-ctrl.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-crf.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-apu-ctrl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
diff --git a/hw/misc/zynq_ddr-ctrl.c b/hw/misc/zynq_ddr-ctrl.c
new file mode 100644
index 0000000000..8cdf8be743
--- /dev/null
+++ b/hw/misc/zynq_ddr-ctrl.c
@@ -0,0 +1,331 @@
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/registerfields.h"
+#include "system/block-backend.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "system/dma.h"
+
+#ifndef DDRCTRL_ERR_DEBUG
+#define DDRCTRL_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (DDRCTRL_ERR_DEBUG > (level)) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define DB_PRINT(...) DB_PRINT_L(0, ## __VA_ARGS__)
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
+REG32(PHY_CMD_TIMEOUT_RDDA, 0x50)
+REG32(TA_CPT, 0x50)
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
+#define TYPE_DDRCTRL "zynq.ddr-ctlr"
+#define DDRCTRL(obj) \
+    OBJECT_CHECK(DDRCTRLState, (obj), TYPE_DDRCTRL)
+
+typedef struct DDRCTRLState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t reg[ZYNQ_DDRCTRL_NUM_REG];
+} DDRCTRLState;
+
+
+static bool zynq_ddrctrl_check_addr(hwaddr addr, bool rnw)
+{
+    switch (addr) {
+    case R_PHY_DBG_REG:
+    case R_MODE_STS_REG:
+    case R_CHE_CORR_ECC_LOG_REG_OFFSET ...
+                    R_CHE_CORR_ECC_DATA_71_64_REG_OFFSET:
+    case R_CHE_UNCORR_ECC_ADDR_REG_OFFSET ...
+                    R_CHE_UNCORR_ECC_DATA_71_64_REG_OFFSET:
+    case R_CHE_ECC_CORR_BIT_MASK_31_0_REG_OFFSET:
+    case R_CHE_ECC_CORR_BIT_MASK_63_32_REG_OFFSET:
+    case R_REG69_6A0 ... R_AXI_ID:
+    case R_MODE_REG_READ:
+        return rnw;
+    default:
+        return true;
+    }
+}
+
+static void zynq_ddrctrl_reset_init(Object *obj, ResetType type)
+{
+    DDRCTRLState *s = DDRCTRL(obj);
+
+    DB_PRINT("RESET");
+
+    s->reg[R_DDRC_CTRL]                      = 0x00000200;
+    s->reg[R_TWO_RANK_CFG]                   = 0x000C1076;
+    s->reg[R_HPR_REG]                        = 0x03C0780F;
+    s->reg[R_LPR_REG]                        = 0x03C0780F;
+    s->reg[R_WR_REG]                         = 0x0007F80F;
+    s->reg[R_DRAM_PARAM_REG0]                = 0x00041016;
+    s->reg[R_DRAM_PARAM_REG1]                = 0x351B48D9;
+    s->reg[R_DRAM_PARAM_REG2]                = 0x83015904;
+    s->reg[R_DRAM_PARAM_REG3]                = 0x250882D0;
+    s->reg[R_DRAM_PARAM_REG4]                = 0x0000003C;
+    s->reg[R_DRAM_INIT_PARAM]                = 0x00002007;
+    s->reg[R_DRAM_EMR_REG]                   = 0x00000008;
+    s->reg[R_DRAM_EMR_MR_REG]                = 0x00000940;
+    s->reg[R_DRAM_BURST8_RDWR]               = 0x00020034;
+    s->reg[R_DRAM_ADDR_MAP_BANK]             = 0x00000F77;
+    s->reg[R_DRAM_ADDR_MAP_COL]              = 0xFFF00000;
+    s->reg[R_DRAM_ADDR_MAP_ROW]              = 0x0FF55555;
+    s->reg[R_DRAM_ODT_REG]                   = 0x00000249;
+    s->reg[R_PHY_CMD_TIMEOUT_RDDA]           = 0x00010200;
+    s->reg[R_DLL_CALIB]                      = 0x00000101;
+    s->reg[R_ODT_DELAY_HOLD]                 = 0x00000023;
+    s->reg[R_CTRL_REG1]                      = 0x0000003E;
+    s->reg[R_CTRL_REG2]                      = 0x00020000;
+    s->reg[R_CTRL_REG3]                      = 0x00284027;
+    s->reg[R_CTRL_REG4]                      = 0x00001610;
+    s->reg[R_CTRL_REG5]                      = 0x00455111;
+    s->reg[R_CTRL_REG6]                      = 0x00032222;
+    s->reg[R_CHE_REFRESH_TIMER0]             = 0x00008000;
+    s->reg[R_CHE_T_ZQ]                       = 0x10300802;
+    s->reg[R_CHE_T_ZQ_SHORT_INTERVAL_REG]    = 0x0020003A;
+    s->reg[R_REG_2D]                         = 0x00000200;
+    s->reg[R_DFI_TIMING]                     = 0x00200067;
+    s->reg[R_ECC_SCRUB]                      = 0x00000008;
+    s->reg[R_PHY_CONFIG0]                    = 0x40000001;
+    s->reg[R_PHY_CONFIG1]                    = 0x40000001;
+    s->reg[R_PHY_CONFIG2]                    = 0x40000001;
+    s->reg[R_PHY_CONFIG3]                    = 0x40000001;
+    s->reg[R_PHY_RD_DQS_CFG0]                = 0x00000040;
+    s->reg[R_PHY_RD_DQS_CFG1]                = 0x00000040;
+    s->reg[R_PHY_RD_DQS_CFG2]                = 0x00000040;
+    s->reg[R_PHY_RD_DQS_CFG3]                = 0x00000040;
+    s->reg[R_PHY_WE_CFG0]                    = 0x00000040;
+    s->reg[R_PHY_WE_CFG1]                    = 0x00000040;
+    s->reg[R_PHY_WE_CFG2]                    = 0x00000040;
+    s->reg[R_PHY_WE_CFG3]                    = 0x00000040;
+    s->reg[R_WR_DATA_SLV0]                   = 0x00000080;
+    s->reg[R_WR_DATA_SLV1]                   = 0x00000080;
+    s->reg[R_WR_DATA_SLV2]                   = 0x00000080;
+    s->reg[R_WR_DATA_SLV3]                   = 0x00000080;
+    s->reg[R_REG_64]                         = 0x10020000;
+    s->reg[R_AXI_PRIORITY_WR_PORT0]          = 0x000803FF;
+    s->reg[R_AXI_PRIORITY_WR_PORT1]          = 0x000803FF;
+    s->reg[R_AXI_PRIORITY_WR_PORT2]          = 0x000803FF;
+    s->reg[R_AXI_PRIORITY_WR_PORT3]          = 0x000803FF;
+    s->reg[R_AXI_PRIORITY_RD_PORT0]          = 0x000003FF;
+    s->reg[R_AXI_PRIORITY_RD_PORT1]          = 0x000003FF;
+    s->reg[R_AXI_PRIORITY_RD_PORT2]          = 0x000003FF;
+    s->reg[R_AXI_PRIORITY_RD_PORT3]          = 0x000003FF;
+    s->reg[R_LPDDR_CTRL2]                    = 0x003C0015;
+    s->reg[R_LPDDR_CTRL3]                    = 0x00000601;
+}
+
+static uint64_t zynq_ddrctrl_read(void *opaque, hwaddr addr, unsigned size)
+{
+    DDRCTRLState *s = opaque;
+    addr /= 4;
+    uint32_t ret = s->reg[addr];
+
+    if (!zynq_ddrctrl_check_addr(addr, true)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "zynq_slcr: Invalid read access to "
+                      " addr %" HWADDR_PRIx "\n", addr * 4);
+        return 0;
+    }
+
+    DB_PRINT("addr: %08" HWADDR_PRIx " data: %08" PRIx32 "\n", addr * 4, ret);
+    return ret;
+}
+
+static void zynq_ddrctrl_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    DDRCTRLState *s = opaque;
+    addr /= 4;
+
+    if (!zynq_ddrctrl_check_addr(addr, false)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "zynq_slcr: Invalid read access to "
+                      " addr %" HWADDR_PRIx "\n", addr * 4);
+        return;
+    }
+
+    DB_PRINT("addr: %08" HWADDR_PRIx " data: %08" PRIx64 "\n", addr * 4, val);
+
+    switch (addr) {
+    case R_DDRC_CTRL:
+        if (val & 0x1) {
+            s->reg[R_MODE_STS_REG] |=
+                    (R_MODE_STS_REG_DDR_REG_OPERATING_MODE_MASK & 0x1);
+        } else {
+            s->reg[R_MODE_STS_REG] &=
+                    ~R_MODE_STS_REG_DDR_REG_OPERATING_MODE_MASK;
+        }
+        break;
+    }
+
+    s->reg[addr] = val;
+}
+
+static const MemoryRegionOps ddrctrl_ops = {
+    .read = zynq_ddrctrl_read,
+    .write = zynq_ddrctrl_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void zynq_ddrctrl_init(Object *obj)
+{
+    DB_PRINT("Init\n");
+
+    DDRCTRLState *s = DDRCTRL(obj);
+
+    memory_region_init_io(&s->iomem, obj, &ddrctrl_ops, s, "ddrctrl",
+                          ZYNQ_DDRCTRL_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void zynq_ddrctrl_class_init(ObjectClass *klass, void *data)
+{
+    DB_PRINT("Class init\n");
+
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = zynq_ddrctrl_reset_init;
+}
+
+static const TypeInfo ddrctrl_info = {
+    .name = TYPE_DDRCTRL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(DDRCTRLState),
+    .class_init = zynq_ddrctrl_class_init,
+    .instance_init = zynq_ddrctrl_init,
+};
+
+static void ddrctrl_register_types(void)
+{
+    type_register_static(&ddrctrl_info);
+}
+
+type_init(ddrctrl_register_types)
-- 
2.49.0


