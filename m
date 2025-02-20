Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C6C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Jf-0008BV-GS; Thu, 20 Feb 2025 11:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Je-00088m-Bx
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:22 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JY-0008HZ-7G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439950a45daso7361055e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068532; x=1740673332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aUXW76xCffZa9zPUWiSPrvT56KUzMZo15HOGptTYgjc=;
 b=qErI6AWyGMLSXWjPWBDoh/jVFdFK4VfbaIXe51/inyI3jA2Ih8W+t+iRVA99wOQjEY
 POmZstLRgoBtKhwAhc/ORQtBHCmp+tKNIIVsYYN9UjCRwgP8XnfMhwkvlPDVuDrhjb9x
 L7Jt+jkVHbACYXyyEfslHBWtPlyOuEoSd47RNWvmWPep13gQUAEu+mKqOU+3x9J7hTi6
 Lm46B/bSNaUyQk2874U3TuacqHBK4YVAjhqEZLHfUaqtx+yA4I7AK44hOXo/LNjkaOMJ
 zvjSziTvtXKJHhLXGuZl3gSzxmGntvVqXXGAvsdrDIkLF9rKbJtPOFRzJmmx7L12sLno
 8EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068532; x=1740673332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUXW76xCffZa9zPUWiSPrvT56KUzMZo15HOGptTYgjc=;
 b=d4KnF4WuiwVVJyksoR1SPgy2282cz6FtfqAXBKprJz6wPwEOiVt3Dh34mJguQ+4Kuj
 ZXaykhPF3djgJihsHldAtda75gU9xkfYu7CA3lrUlqih+v1hTLBolquVhkS875SRq46I
 xKSSuSml976wIlUe356Qca+MFw/Ivr4J03YEL/F+2mJJqgzNeZShIuvvZBwyY/xn60zb
 fq+2bf/d64Dw2jOJon9UTwkq6iQvBOL0mNFU4VJJlHceX/TFsgVLputPQF9I5ehFz1el
 CqlvVSUGS0iEyC7368qCZ8YKxh6c8m/GxSb8k3uBDlwnIf4khhKdoygYDWyQjSKT8FAq
 pcnA==
X-Gm-Message-State: AOJu0YxONo0AK3h8f0+GAV0VMSOm46cfcq5KgMi08/IvEsBVqOjvqA26
 WKX/ZHq/TAPV1QH+mNKgWnI/BBQsZ4FK9vr0oQmYAHs/CttCTB5ibgpNqrI4+nzqeRRNbP30xst
 n
X-Gm-Gg: ASbGncu4JRbbVOTrDO7ItZ/WaERZjNXB9zwb6xz9kIgsgQUqRi6DmivcwaLPbIfriOp
 iD40Wjsn543x7fJfh+bIYaJ4/pGrNS9i20550+1OJ8xsVqTUh+QsgD9RHtFjle1C73UnE7m01BY
 WSLu/t6LFVXJ/gZ4Sjz6t/nY0zANSQROBUZffufHaf0AWd6EiPWeHPtHTl4NznQQcyLgCpjUgZ+
 liyvsZUxknetr+KQGHlfzfsUEbwio6XEW1eQ40s/GAmQ/s3SB+pAt62REoK4gN5CVjKn9Cac+gq
 Ev5esXVWy1xKXXSh6iSGyg==
X-Google-Smtp-Source: AGHT+IFQA6F+COzGPJT9kPeSUXoJFvtNCAOoeNoiFzv6CkZt770ogX4ByXIi/vbOVE1XaWl7cW+ICQ==
X-Received: by 2002:a05:600c:3ba8:b0:439:a138:20 with SMTP id
 5b1f17b1804b1-439a1380584mr48000005e9.20.1740068532236; 
 Thu, 20 Feb 2025 08:22:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] hw/net: Add NPCM8XX PCS Module
Date: Thu, 20 Feb 2025 16:21:19 +0000
Message-ID: <20250220162123.626941-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Hao Wu <wuhaotsh@google.com>

The PCS exists in NPCM8XX's GMAC1 and is used to control the SGMII
PHY. This implementation contains all the default registers and
the soft reset feature that are required to load the Linux kernel
driver. Further features have not been implemented yet.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250219184609.1839281-15-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/npcm_pcs.h |  42 ++++
 hw/net/npcm_pcs.c         | 410 ++++++++++++++++++++++++++++++++++++++
 hw/net/meson.build        |   1 +
 hw/net/trace-events       |   4 +-
 4 files changed, 455 insertions(+), 2 deletions(-)
 create mode 100644 include/hw/net/npcm_pcs.h
 create mode 100644 hw/net/npcm_pcs.c

diff --git a/include/hw/net/npcm_pcs.h b/include/hw/net/npcm_pcs.h
new file mode 100644
index 00000000000..d5c481ad70d
--- /dev/null
+++ b/include/hw/net/npcm_pcs.h
@@ -0,0 +1,42 @@
+/*
+ * Nuvoton NPCM8xx PCS Module
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef NPCM_PCS_H
+#define NPCM_PCS_H
+
+#include "hw/sysbus.h"
+
+#define NPCM_PCS_NR_SR_CTLS     (0x12 / sizeof(uint16_t))
+#define NPCM_PCS_NR_SR_MIIS     (0x20 / sizeof(uint16_t))
+#define NPCM_PCS_NR_SR_TIMS     (0x22 / sizeof(uint16_t))
+#define NPCM_PCS_NR_VR_MIIS     (0x1c6 / sizeof(uint16_t))
+
+struct NPCMPCSState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+
+    uint16_t indirect_access_base;
+    uint16_t sr_ctl[NPCM_PCS_NR_SR_CTLS];
+    uint16_t sr_mii[NPCM_PCS_NR_SR_MIIS];
+    uint16_t sr_tim[NPCM_PCS_NR_SR_TIMS];
+    uint16_t vr_mii[NPCM_PCS_NR_VR_MIIS];
+};
+
+#define TYPE_NPCM_PCS "npcm-pcs"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMPCSState, NPCM_PCS)
+
+#endif /* NPCM_PCS_H */
diff --git a/hw/net/npcm_pcs.c b/hw/net/npcm_pcs.c
new file mode 100644
index 00000000000..ce5034e2343
--- /dev/null
+++ b/hw/net/npcm_pcs.c
@@ -0,0 +1,410 @@
+/*
+ * Nuvoton NPCM8xx PCS Module
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+/*
+ * Disclaimer:
+ * Currently we only implemented the default values of the registers and
+ * the soft reset feature. These are required to boot up the GMAC module
+ * in Linux kernel for NPCM845 boards. Other functionalities are not modeled.
+ */
+
+#include "qemu/osdep.h"
+
+#include "exec/hwaddr.h"
+#include "hw/registerfields.h"
+#include "hw/net/npcm_pcs.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "trace.h"
+
+#define NPCM_PCS_IND_AC_BA      0x1fe
+#define NPCM_PCS_IND_SR_CTL     0x1e00
+#define NPCM_PCS_IND_SR_MII     0x1f00
+#define NPCM_PCS_IND_SR_TIM     0x1f07
+#define NPCM_PCS_IND_VR_MII     0x1f80
+
+REG16(NPCM_PCS_SR_CTL_ID1, 0x08)
+REG16(NPCM_PCS_SR_CTL_ID2, 0x0a)
+REG16(NPCM_PCS_SR_CTL_STS, 0x10)
+
+REG16(NPCM_PCS_SR_MII_CTRL, 0x00)
+REG16(NPCM_PCS_SR_MII_STS, 0x02)
+REG16(NPCM_PCS_SR_MII_DEV_ID1, 0x04)
+REG16(NPCM_PCS_SR_MII_DEV_ID2, 0x06)
+REG16(NPCM_PCS_SR_MII_AN_ADV, 0x08)
+REG16(NPCM_PCS_SR_MII_LP_BABL, 0x0a)
+REG16(NPCM_PCS_SR_MII_AN_EXPN, 0x0c)
+REG16(NPCM_PCS_SR_MII_EXT_STS, 0x1e)
+
+REG16(NPCM_PCS_SR_TIM_SYNC_ABL, 0x10)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR, 0x12)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_UPR, 0x14)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR, 0x16)
+REG16(NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_UPR, 0x18)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR, 0x1a)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_UPR, 0x1c)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR, 0x1e)
+REG16(NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_UPR, 0x20)
+
+REG16(NPCM_PCS_VR_MII_MMD_DIG_CTRL1, 0x000)
+REG16(NPCM_PCS_VR_MII_AN_CTRL, 0x002)
+REG16(NPCM_PCS_VR_MII_AN_INTR_STS, 0x004)
+REG16(NPCM_PCS_VR_MII_TC, 0x006)
+REG16(NPCM_PCS_VR_MII_DBG_CTRL, 0x00a)
+REG16(NPCM_PCS_VR_MII_EEE_MCTRL0, 0x00c)
+REG16(NPCM_PCS_VR_MII_EEE_TXTIMER, 0x010)
+REG16(NPCM_PCS_VR_MII_EEE_RXTIMER, 0x012)
+REG16(NPCM_PCS_VR_MII_LINK_TIMER_CTRL, 0x014)
+REG16(NPCM_PCS_VR_MII_EEE_MCTRL1, 0x016)
+REG16(NPCM_PCS_VR_MII_DIG_STS, 0x020)
+REG16(NPCM_PCS_VR_MII_ICG_ERRCNT1, 0x022)
+REG16(NPCM_PCS_VR_MII_MISC_STS, 0x030)
+REG16(NPCM_PCS_VR_MII_RX_LSTS, 0x040)
+REG16(NPCM_PCS_VR_MII_MP_TX_BSTCTRL0, 0x070)
+REG16(NPCM_PCS_VR_MII_MP_TX_LVLCTRL0, 0x074)
+REG16(NPCM_PCS_VR_MII_MP_TX_GENCTRL0, 0x07a)
+REG16(NPCM_PCS_VR_MII_MP_TX_GENCTRL1, 0x07c)
+REG16(NPCM_PCS_VR_MII_MP_TX_STS, 0x090)
+REG16(NPCM_PCS_VR_MII_MP_RX_GENCTRL0, 0x0b0)
+REG16(NPCM_PCS_VR_MII_MP_RX_GENCTRL1, 0x0b2)
+REG16(NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0, 0x0ba)
+REG16(NPCM_PCS_VR_MII_MP_MPLL_CTRL0, 0x0f0)
+REG16(NPCM_PCS_VR_MII_MP_MPLL_CTRL1, 0x0f2)
+REG16(NPCM_PCS_VR_MII_MP_MPLL_STS, 0x110)
+REG16(NPCM_PCS_VR_MII_MP_MISC_CTRL2, 0x126)
+REG16(NPCM_PCS_VR_MII_MP_LVL_CTRL, 0x130)
+REG16(NPCM_PCS_VR_MII_MP_MISC_CTRL0, 0x132)
+REG16(NPCM_PCS_VR_MII_MP_MISC_CTRL1, 0x134)
+REG16(NPCM_PCS_VR_MII_DIG_CTRL2, 0x1c2)
+REG16(NPCM_PCS_VR_MII_DIG_ERRCNT_SEL, 0x1c4)
+
+/* Register Fields */
+#define NPCM_PCS_SR_MII_CTRL_RST            BIT(15)
+
+static const uint16_t npcm_pcs_sr_ctl_cold_reset_values[NPCM_PCS_NR_SR_CTLS] = {
+    [R_NPCM_PCS_SR_CTL_ID1]                 = 0x699e,
+    [R_NPCM_PCS_SR_CTL_STS]                 = 0x8000,
+};
+
+static const uint16_t npcm_pcs_sr_mii_cold_reset_values[NPCM_PCS_NR_SR_MIIS] = {
+    [R_NPCM_PCS_SR_MII_CTRL]                = 0x1140,
+    [R_NPCM_PCS_SR_MII_STS]                 = 0x0109,
+    [R_NPCM_PCS_SR_MII_DEV_ID1]             = 0x699e,
+    [R_NPCM_PCS_SR_MII_DEV_ID2]             = 0xced0,
+    [R_NPCM_PCS_SR_MII_AN_ADV]              = 0x0020,
+    [R_NPCM_PCS_SR_MII_EXT_STS]             = 0xc000,
+};
+
+static const uint16_t npcm_pcs_sr_tim_cold_reset_values[NPCM_PCS_NR_SR_TIMS] = {
+    [R_NPCM_PCS_SR_TIM_SYNC_ABL]            = 0x0003,
+    [R_NPCM_PCS_SR_TIM_SYNC_TX_MAX_DLY_LWR] = 0x0038,
+    [R_NPCM_PCS_SR_TIM_SYNC_TX_MIN_DLY_LWR] = 0x0038,
+    [R_NPCM_PCS_SR_TIM_SYNC_RX_MAX_DLY_LWR] = 0x0058,
+    [R_NPCM_PCS_SR_TIM_SYNC_RX_MIN_DLY_LWR] = 0x0048,
+};
+
+static const uint16_t npcm_pcs_vr_mii_cold_reset_values[NPCM_PCS_NR_VR_MIIS] = {
+    [R_NPCM_PCS_VR_MII_MMD_DIG_CTRL1]         = 0x2400,
+    [R_NPCM_PCS_VR_MII_AN_INTR_STS]           = 0x000a,
+    [R_NPCM_PCS_VR_MII_EEE_MCTRL0]            = 0x899c,
+    [R_NPCM_PCS_VR_MII_DIG_STS]               = 0x0010,
+    [R_NPCM_PCS_VR_MII_MP_TX_BSTCTRL0]        = 0x000a,
+    [R_NPCM_PCS_VR_MII_MP_TX_LVLCTRL0]        = 0x007f,
+    [R_NPCM_PCS_VR_MII_MP_TX_GENCTRL0]        = 0x0001,
+    [R_NPCM_PCS_VR_MII_MP_RX_GENCTRL0]        = 0x0100,
+    [R_NPCM_PCS_VR_MII_MP_RX_GENCTRL1]        = 0x1100,
+    [R_NPCM_PCS_VR_MII_MP_RX_LOS_CTRL0]       = 0x000e,
+    [R_NPCM_PCS_VR_MII_MP_MPLL_CTRL0]         = 0x0100,
+    [R_NPCM_PCS_VR_MII_MP_MPLL_CTRL1]         = 0x0032,
+    [R_NPCM_PCS_VR_MII_MP_MPLL_STS]           = 0x0001,
+    [R_NPCM_PCS_VR_MII_MP_LVL_CTRL]           = 0x0019,
+};
+
+static void npcm_pcs_soft_reset(NPCMPCSState *s)
+{
+    memcpy(s->sr_ctl, npcm_pcs_sr_ctl_cold_reset_values,
+           NPCM_PCS_NR_SR_CTLS * sizeof(uint16_t));
+    memcpy(s->sr_mii, npcm_pcs_sr_mii_cold_reset_values,
+           NPCM_PCS_NR_SR_MIIS * sizeof(uint16_t));
+    memcpy(s->sr_tim, npcm_pcs_sr_tim_cold_reset_values,
+           NPCM_PCS_NR_SR_TIMS * sizeof(uint16_t));
+    memcpy(s->vr_mii, npcm_pcs_vr_mii_cold_reset_values,
+           NPCM_PCS_NR_VR_MIIS * sizeof(uint16_t));
+}
+
+static uint16_t npcm_pcs_read_sr_ctl(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_CTLS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_CTL read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->sr_ctl[regno];
+}
+
+static uint16_t npcm_pcs_read_sr_mii(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_MII read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->sr_mii[regno];
+}
+
+static uint16_t npcm_pcs_read_sr_tim(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_TIMS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_TIM read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->sr_tim[regno];
+}
+
+static uint16_t npcm_pcs_read_vr_mii(NPCMPCSState *s, hwaddr offset)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_VR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: VR_MII read offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return 0;
+    }
+
+    return s->vr_mii[regno];
+}
+
+static void npcm_pcs_write_sr_ctl(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_CTLS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_CTL write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->sr_ctl[regno] = v;
+}
+
+static void npcm_pcs_write_sr_mii(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_MII write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->sr_mii[regno] = v;
+
+    if ((offset == A_NPCM_PCS_SR_MII_CTRL) && (v & NPCM_PCS_SR_MII_CTRL_RST)) {
+        /* Trigger a soft reset */
+        npcm_pcs_soft_reset(s);
+    }
+}
+
+static void npcm_pcs_write_sr_tim(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_SR_TIMS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: SR_TIM write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->sr_tim[regno] = v;
+}
+
+static void npcm_pcs_write_vr_mii(NPCMPCSState *s, hwaddr offset, uint16_t v)
+{
+    hwaddr regno = offset / sizeof(uint16_t);
+
+    if (regno >= NPCM_PCS_NR_VR_MIIS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: VR_MII write offset 0x%04" HWADDR_PRIx
+                      " is out of range.\n",
+                      DEVICE(s)->canonical_path, offset);
+        return;
+    }
+
+    s->vr_mii[regno] = v;
+}
+
+static uint64_t npcm_pcs_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCMPCSState *s = opaque;
+    uint16_t v = 0;
+
+    if (offset == NPCM_PCS_IND_AC_BA) {
+        v = s->indirect_access_base;
+    } else {
+        switch (s->indirect_access_base) {
+        case NPCM_PCS_IND_SR_CTL:
+            v = npcm_pcs_read_sr_ctl(s, offset);
+            break;
+
+        case NPCM_PCS_IND_SR_MII:
+            v = npcm_pcs_read_sr_mii(s, offset);
+            break;
+
+        case NPCM_PCS_IND_SR_TIM:
+            v = npcm_pcs_read_sr_tim(s, offset);
+            break;
+
+        case NPCM_PCS_IND_VR_MII:
+            v = npcm_pcs_read_vr_mii(s, offset);
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Read with invalid indirect address base: 0x%"
+                          PRIx16 "\n", DEVICE(s)->canonical_path,
+                          s->indirect_access_base);
+        }
+    }
+
+    trace_npcm_pcs_reg_read(DEVICE(s)->canonical_path, s->indirect_access_base,
+                            offset, v);
+    return v;
+}
+
+static void npcm_pcs_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    NPCMPCSState *s = opaque;
+
+    trace_npcm_pcs_reg_write(DEVICE(s)->canonical_path, s->indirect_access_base,
+                             offset, v);
+    if (offset == NPCM_PCS_IND_AC_BA) {
+        s->indirect_access_base = v;
+    } else {
+        switch (s->indirect_access_base) {
+        case NPCM_PCS_IND_SR_CTL:
+            npcm_pcs_write_sr_ctl(s, offset, v);
+            break;
+
+        case NPCM_PCS_IND_SR_MII:
+            npcm_pcs_write_sr_mii(s, offset, v);
+            break;
+
+        case NPCM_PCS_IND_SR_TIM:
+            npcm_pcs_write_sr_tim(s, offset, v);
+            break;
+
+        case NPCM_PCS_IND_VR_MII:
+            npcm_pcs_write_vr_mii(s, offset, v);
+            break;
+
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Write with invalid indirect address base: 0x%02"
+                          PRIx16 "\n", DEVICE(s)->canonical_path,
+                          s->indirect_access_base);
+        }
+    }
+}
+
+static void npcm_pcs_enter_reset(Object *obj, ResetType type)
+{
+    NPCMPCSState *s = NPCM_PCS(obj);
+
+    npcm_pcs_soft_reset(s);
+}
+
+static const struct MemoryRegionOps npcm_pcs_ops = {
+    .read = npcm_pcs_read,
+    .write = npcm_pcs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 2,
+        .max_access_size = 2,
+        .unaligned = false,
+    },
+};
+
+static void npcm_pcs_realize(DeviceState *dev, Error **errp)
+{
+    NPCMPCSState *pcs = NPCM_PCS(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&pcs->iomem, OBJECT(pcs), &npcm_pcs_ops, pcs,
+                          TYPE_NPCM_PCS, 8 * KiB);
+    sysbus_init_mmio(sbd, &pcs->iomem);
+}
+
+static const VMStateDescription vmstate_npcm_pcs = {
+    .name = TYPE_NPCM_PCS,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(indirect_access_base, NPCMPCSState),
+        VMSTATE_UINT16_ARRAY(sr_ctl, NPCMPCSState, NPCM_PCS_NR_SR_CTLS),
+        VMSTATE_UINT16_ARRAY(sr_mii, NPCMPCSState, NPCM_PCS_NR_SR_MIIS),
+        VMSTATE_UINT16_ARRAY(sr_tim, NPCMPCSState, NPCM_PCS_NR_SR_TIMS),
+        VMSTATE_UINT16_ARRAY(vr_mii, NPCMPCSState, NPCM_PCS_NR_VR_MIIS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void npcm_pcs_class_init(ObjectClass *klass, void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->desc = "NPCM PCS Controller";
+    dc->realize = npcm_pcs_realize;
+    dc->vmsd = &vmstate_npcm_pcs;
+    rc->phases.enter = npcm_pcs_enter_reset;
+}
+
+static const TypeInfo npcm_pcs_types[] = {
+    {
+        .name = TYPE_NPCM_PCS,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCMPCSState),
+        .class_init = npcm_pcs_class_init,
+    },
+};
+DEFINE_TYPES(npcm_pcs_types)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 3bb5d749a83..e6759e26ca6 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -40,6 +40,7 @@ system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
 system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
 system_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c', 'npcm_gmac.c'))
+system_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm_pcs.c'))
 
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c35bfb2eb8d..72b69c4a8bb 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -483,8 +483,8 @@ npcm_gmac_packet_tx_desc_data(const char* name, uint32_t tdes0, uint32_t tdes1)
 npcm_gmac_tx_desc_owner(const char* name, uint32_t desc_addr) "%s: TX Descriptor @0x%04" PRIX32 " is owned by software"
 
 # npcm_pcs.c
-npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-npcm_pcs_reg_write(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_read(const char *name, uint16_t indirect_access_base, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_write(const char *name, uint16_t indirect_access_base, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
 
 # dp8398x.c
 dp8393x_raise_irq(int isr) "raise irq, isr is 0x%04x"
-- 
2.43.0


