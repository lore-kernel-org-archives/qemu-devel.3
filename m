Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38174CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJe-0003hN-Mg; Fri, 15 Aug 2025 05:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJY-0003fP-7k; Fri, 15 Aug 2025 05:01:33 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJS-0005mb-Gs; Fri, 15 Aug 2025 05:01:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3b9edf504e6so891941f8f.3; 
 Fri, 15 Aug 2025 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248483; x=1755853283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2SojebcZanGvDC9GdA4G0rWkP5titIrT0YvHI+rBGq0=;
 b=IqyCTGodPTPfnOfcyPjy3Bd7kINXPcPst68OZWWpEdiUT1G4IlNbR5FipI8OmWrUaO
 dp9tnETRuDyxy4Up4a2Ugg6h1uEEGOf6xB6cS22sapyUz9O3fJ/dqegXvQxNp7zEl7LX
 G7F85QBmjorrCNgqMS1YNQcHj+Z7/+d33N8f2t3kOZ393VvfHKi65zBLNScMpVAJEE3Y
 irsMvZjxmX5YigesicBg6jOQ9I9tsIvEGu5/gvnIFl3xquNlfzdxr/cSeIpjTkhUgJTX
 Qikwc07L0RR4v4yo+zPrxkfdjtEVv4G9bXvwfkatQo4KprUNRH9jPM0Z3YAKHqvEt+nV
 wadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248483; x=1755853283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SojebcZanGvDC9GdA4G0rWkP5titIrT0YvHI+rBGq0=;
 b=kjDX9y4ykGGgP2VV98F7VyZGX3PIMDDkZex7yy/F/AhSmYCgm5RfJH/4XGFk446cif
 MgnaGFZehQsQ8OSo5jwHElVWawWp3BWHMldr4oLfqB3auT9MwGl2GJT4iVrjg1mCiHe0
 bHTu9jZMUV8GkV6c1DXVLpNHOySG3YMOoixgzx4+0mhPzYZgzfQru08uUt+VO31xMaQn
 M71tN+KeZPZCrDNALconqapV886yLo9TrPLsuz5P96r4zNmQf6cvQoPV9K1ZlWQC1nTG
 A7Zk0GNucGTzs6EYVmW/aCoy8ReRwRRw0Z8Q46gBLGNxHkQLybBNe1yrCugklFC8wn8/
 TFCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqyPejLj2Mg8XOz7ZTPWqWOnoTBRU4fHoWw/WiLXSYIDAN7GAJfk6fw4EoFjwpVuwuDwkYVIgrEtK0sA==@nongnu.org,
 AJvYcCUsaibi34xQWjiBXRmm268K506OvLXo8G+Q4ysEjWWH2PrI1QdohHm0AB+vWN/hGgJ60SfzLknswA==@nongnu.org
X-Gm-Message-State: AOJu0Yw1/JT3eE8WKU2jJvf2sLnyQQdTgVqxH/MUsV+1d6L2i91uFQp/
 ZDOoh5JrXW3trjd4+Zp+R7B0qYzbPnujcRnXFagpFGtwB4BWPHLjqp+G9UyUsWPt
X-Gm-Gg: ASbGncuzZP7CICURJ7172WZReI/gT7N4ijvgTiIK682uPLwVjvDrgeIUuIFgLXueE6n
 US4azKclTBDEgJW0a/hj2lXVxPEN5IKOLvH14PIBJBhgc4iPETlOPT9lH72t0Sk1z/QFp4TEMNP
 CZV5vDgSgnsHfBxfKyK6A/Vj59O+X5ILBKgaSi7mM47dY7mkA+/el//FVCQPgrVW6MicD7xtYl1
 feonJ638SxT/JRd2AsPBnilo8a9zIAY9yO3S5Y/4RLfw+qzzS/uXgy8ZYUdEWPoH0nVrbRD6uRC
 UUX1i0616OgZwy/j+j62pM5nqmFiRBrXHrK1E8SVJ6PEBPPc/FuHZpbJR/v0NAxeK38Oy7qFHgM
 5yibr+NP+0h0dOehGiUSc966pOzi4SiSHp1H4bTYFpkSKWQ==
X-Google-Smtp-Source: AGHT+IElNmhdNs3JXg2lXRKThXXkMAbPXoACNSFCw01TPyJiES2CuFc4C35GdmM/Dty7L4CFiT3M2g==
X-Received: by 2002:a05:600c:b8d:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-45a21848eb0mr9787855e9.23.1755248483081; 
 Fri, 15 Aug 2025 02:01:23 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:22 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v2 09/14] hw/misc: Add dummy ZYNQ DDR controller
Date: Fri, 15 Aug 2025 11:01:07 +0200
Message-ID: <20250815090113.141641-10-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x433.google.com
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
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 hw/misc/xlnx-zynq-ddrc.c         | 393 +++++++++++++++++++++++++++++++
 include/hw/misc/xlnx-zynq-ddrc.h | 140 +++++++++++
 4 files changed, 537 insertions(+)
 create mode 100644 hw/misc/xlnx-zynq-ddrc.c
 create mode 100644 include/hw/misc/xlnx-zynq-ddrc.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f9ce2f68c..99548e146f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -220,4 +220,7 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config XLNX_ZYNQ_DDRC
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 55f493521b..6ee7b6c71d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -89,6 +89,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
+system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xlnx-zynq-ddrc.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-crf.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp-apu-ctrl.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
diff --git a/hw/misc/xlnx-zynq-ddrc.c b/hw/misc/xlnx-zynq-ddrc.c
new file mode 100644
index 0000000000..8151a0e3ee
--- /dev/null
+++ b/hw/misc/xlnx-zynq-ddrc.c
@@ -0,0 +1,393 @@
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
+#include "hw/misc/xlnx-zynq-ddrc.h"
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
+static void zynq_ddrctrl_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, zynq_ddrctrl_reset);
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
diff --git a/include/hw/misc/xlnx-zynq-ddrc.h b/include/hw/misc/xlnx-zynq-ddrc.h
new file mode 100644
index 0000000000..7b9b4d551e
--- /dev/null
+++ b/include/hw/misc/xlnx-zynq-ddrc.h
@@ -0,0 +1,140 @@
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
2.50.1


