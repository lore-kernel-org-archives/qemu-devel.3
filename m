Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493BFCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ9I-0005JD-NT; Tue, 16 Jun 2026 15:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ86-0004VX-Rb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:28 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ7z-0000zl-6M
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b9318997so36091055e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636831; x=1782241631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Uj8VsHdiz/VZVf8n44lPRhYIPhFT4loCUExswkW8++M=;
 b=nWcw2fcUFnnEqqOFVc9iySFB4vYhAss27QUKZAYUtxYAFwII5Y53fpHVVeIA6pYjk9
 J5I/zTr6JhzdzJyUmDwTv1s+LoIz1z+iJK0wJ40NUa26M7Jjw9Uce7dOXB0dQpxUlNTt
 dO2IV95pd1Gg06wCJFQpzLPVaV3IhQoKwoMqq+sK7NEZeLh6WR7joXubm4Xxh+ZpnUVc
 CN95pBFLMav6noEaJp6UCybv8YBp4NNWJwxLiuRr93pjPmJzvjwYck1zV1pdKcUjJ2L0
 pa4piJoE6t2NsyRLUT31fYAvqEEdSkdU6y5U12WO4GGb21fvjKvM6Lr/iex4d6SX0Y3L
 x97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636831; x=1782241631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uj8VsHdiz/VZVf8n44lPRhYIPhFT4loCUExswkW8++M=;
 b=Dt/irfiGkEhllf9X+aBRmk7V1m9wuWLBdWGGU79GkIomQfU+uKGwfjJ+sVCrb2fRd+
 F/zFZ/ZX3lRPBCkbhMvJSU3UWz5PoSddeW5IGbQ40PHMhu4I4v6K/595+xbXxCC7Rms+
 64MhAM9tCgJ1w/ennO3PSXZyRnCCDZtBsPbigCEq5ECaM0UrXUDw9KMf8VOP/gSzszDH
 mHjTOt0fj/9VCZSV8qwR5r2ddRnyYoX5wR22vdgq3k/UAMNusGad9+j9vfvpudf5WyF2
 c+lxkcDyYMAvtFxtRVUuMDPAy8I0sd4pWK0HMcsrKks0S/Afs1L5bt2PKoTFBQF1p9y4
 obzA==
X-Gm-Message-State: AOJu0YyIeYlY9pyqqyLJp+hiT9hJ3mAdtRicpJk6sAFNJuu5g/SVpPxb
 rfu1lDuSgc4okBNNIV5zmJWALUiigOBvZxIW6vXTp6BCMLZG8FZL3gWK44+i1stBQjSBZi8SF30
 V5Gd1
X-Gm-Gg: Acq92OGIknx0hcmrXLtEnRRtpg15Zp9vanXM81SzYoKaLJ2saiKUYR3mc19r2/1tyU/
 PfoBxMRHWRSP1PSUhWBN/bc7UUCKpCQ/AlHoNcQVZSbp7QmqNbcNo3HLaiYOLjhsUQgCTS/aWvK
 Eyo5kJxlByMUgMg880cpIdFCZwvEWGdZWyapPL1kBudAOHuNrzI1PUn2yTYEQqO9KioSH68wGs2
 UT33eFEP1zs/k/LXN2xbvgce9rYmjodLZixyFIjmuwGoPyILgxzZx+gdZ7nJtCooftCpRXuCZ2l
 n0xGaq79oLEFi5CvxTXCztA3R4+ZG63CH+fv1BVW9tcI/J7fLEJikHFSI7Du4vGCRVxAh6w62AN
 Rc0zhKydjBxRZoTT3XIwqMd+M7443BGAyxOV5Y9SerTVAyx0RUNX+8yYopAnjCORK86hM2LR/10
 Lp28QMSSGtWpALUcm4281GN304SwQRpi/zqHbCf72z2hwvHbHGUwtdqDyZs2YUlODXg+cLIET26
 bf1sBXHfpWi+l0ynm3k+wDp4aBPafau
X-Received: by 2002:a05:600c:e547:20b0:492:1eed:3e67 with SMTP id
 5b1f17b1804b1-492333d6cadmr9248505e9.26.1781636830905; 
 Tue, 16 Jun 2026 12:07:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/61] hw/arm/tegra241-cmdqv: Emulate CMDQ-V Config region
Date: Tue, 16 Jun 2026 20:06:02 +0100
Message-ID: <20260616190639.3462006-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV exposes control and status registers in the CMDQ-V
Config page (offset [0x0, 0x10000)) used to configure virtual command
queue allocation and interrupt behavior.

Add read/write emulation for the CMDQ-V Config region
([CMDQV_BASE, CMDQV_CMDQ_BASE]), backed by a simple register cache.
This includes CONFIG, PARAM, STATUS, VI error and interrupt maps, CMDQ
allocation map and the VINTF0 related registers defined in the CMDQ-V
Config space. Only VINTF0 is supported; VINTF1-63 are not.

Dispatch writes on access size: Introduced writel_mmio for 4-byte and
writell_mmio for 8-byte. Reads need no split as the MMIO framework masks
the returned value to the access size.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260609112552.378999-16-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 181 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/tegra241-cmdqv.h | 110 ++++++++++++++++++++++++
 hw/arm/trace-events     |   4 +
 3 files changed, 294 insertions(+), 1 deletion(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 3eec6073a4..8950d5153b 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -8,21 +8,200 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 
 #include "hw/arm/smmuv3.h"
 #include "hw/arm/smmuv3-common.h"
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
+#include "trace.h"
+
+static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
+                                                 hwaddr offset)
+{
+    int i;
+
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        return cmdqv->vintf_config;
+    case A_VINTF0_STATUS:
+        return cmdqv->vintf_status;
+    case A_VINTF0_SID_MATCH_0 ... A_VINTF0_SID_MATCH_15:
+        i = (offset - A_VINTF0_SID_MATCH_0) / 4;
+        return cmdqv->vintf_sid_match[i];
+    case A_VINTF0_SID_REPLACE_0 ... A_VINTF0_SID_REPLACE_15:
+        i = (offset - A_VINTF0_SID_REPLACE_0) / 4;
+        return cmdqv->vintf_sid_replace[i];
+    case A_VINTF0_LVCMDQ_ERR_MAP_0 ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        i = (offset - A_VINTF0_LVCMDQ_ERR_MAP_0) / 4;
+        return cmdqv->vintf_cmdq_err_map[i];
+    default:
+        /*
+         * GLB_FILT_CFG_0 (offset 0xC) and GLB_FILT_DATA_0 (offset 0x10) are
+         * filter config and filter data registers. They are not required for
+         * normal VINTF operation and are not emulated.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return 0;
+    }
+}
+
+static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
+                                              hwaddr offset, uint64_t value)
+{
+    int i;
+
+    switch (offset) {
+    case A_VINTF0_CONFIG:
+        /*
+         * Mask out HYP_OWN on guest writes. This bit selects Hypervisor (1) vs
+         * Guest (0) ownership of the CMDQ. Force it to 0 so the VINTF always
+         * remains guest-owned.
+         */
+        value &= ~R_VINTF0_CONFIG_HYP_OWN_MASK;
+
+        cmdqv->vintf_config = value;
+        if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
+            cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
+        } else {
+            cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
+        }
+        break;
+    case A_VINTF0_SID_MATCH_0 ... A_VINTF0_SID_MATCH_15:
+        i = (offset - A_VINTF0_SID_MATCH_0) / 4;
+        cmdqv->vintf_sid_match[i] = value;
+        break;
+    case A_VINTF0_SID_REPLACE_0 ... A_VINTF0_SID_REPLACE_15:
+        i = (offset - A_VINTF0_SID_REPLACE_0) / 4;
+        cmdqv->vintf_sid_replace[i] = value;
+        break;
+    default:
+        /*
+         * GLB_FILT_CFG_0 (offset 0xC) and GLB_FILT_DATA_0 (offset 0x10) are
+         * filter config and filter data registers. They are not required for
+         * normal VINTF operation and are not emulated.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+        return;
+    }
+}
 
 static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset,
                                          unsigned size)
 {
-    return 0;
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    uint64_t val = 0;
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x%x)\n", __func__,
+                      offset, TEGRA241_CMDQV_IO_LEN);
+        goto out;
+    }
+
+    switch (offset) {
+    case A_CONFIG:
+        val = cmdqv->config;
+        break;
+    case A_PARAM:
+        val = cmdqv->param;
+        break;
+    case A_STATUS:
+        val = cmdqv->status;
+        break;
+    case A_VI_ERR_MAP_0 ... A_VI_ERR_MAP_1:
+        val = cmdqv->vi_err_map[(offset - A_VI_ERR_MAP_0) / 4];
+        break;
+    case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
+        val = cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4];
+        break;
+    case A_CMDQ_ERR_MAP_0 ... A_CMDQ_ERR_MAP_3:
+        val = cmdqv->cmdq_err_map[(offset - A_CMDQ_ERR_MAP_0) / 4];
+        break;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
+        val = cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4];
+        break;
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        val = tegra241_cmdqv_config_vintf_read(cmdqv, offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled read access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
+
+out:
+    trace_tegra241_cmdqv_read_mmio(offset, val, size);
+    return val;
+}
+
+/* 4-byte MMIO write handler. */
+static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                       uint32_t value)
+{
+    switch (offset) {
+    case A_CONFIG:
+        cmdqv->config = value;
+        if (value & R_CONFIG_CMDQV_EN_MASK) {
+            cmdqv->status |= R_STATUS_CMDQV_ENABLED_MASK;
+        } else {
+            cmdqv->status &= ~R_STATUS_CMDQV_ENABLED_MASK;
+        }
+        break;
+    case A_VI_INT_MASK_0 ... A_VI_INT_MASK_1:
+        cmdqv->vi_int_mask[(offset - A_VI_INT_MASK_0) / 4] = value;
+        break;
+    case A_CMDQ_ALLOC_MAP_0 ... A_CMDQ_ALLOC_MAP_1:
+        cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
+        break;
+    case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
+        tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset);
+    }
+}
+
+/*
+ * 8-byte MMIO write handler.
+ */
+static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
+                                        uint64_t value)
+{
+    qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
+                      __func__, offset);
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
                                       uint64_t value, unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+
+    if (offset >= TEGRA241_CMDQV_IO_LEN) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s offset 0x%" PRIx64 " off limit (0x%x)\n", __func__,
+                      offset, TEGRA241_CMDQV_IO_LEN);
+        goto out;
+    }
+
+    switch (size) {
+    case 4:
+        tegra241_cmdqv_writel_mmio(cmdqv, offset, value);
+        break;
+    case 8:
+        tegra241_cmdqv_writell_mmio(cmdqv, offset, value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s bad write size %u at 0x%" PRIx64 "\n",
+                      __func__, size, offset);
+    }
+
+out:
+    trace_tegra241_cmdqv_write_mmio(offset, value, size);
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 00c83b6186..d49fa42cd5 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -10,10 +10,15 @@
 #ifndef HW_ARM_TEGRA241_CMDQV_H
 #define HW_ARM_TEGRA241_CMDQV_H
 
+#include "hw/core/registerfields.h"
+
 #define CMDQV_VER                 1
 #define CMDQV_NUM_CMDQ_LOG2       1
 #define CMDQV_NUM_SID_PER_VI_LOG2 4
 
+#define TEGRA241_CMDQV_MAX_CMDQ      (1U << CMDQV_NUM_CMDQ_LOG2)
+#define TEGRA241_CMDQV_MAX_NUM_SID   (1U << CMDQV_NUM_SID_PER_VI_LOG2)
+
 /*
  * Tegra241 CMDQV MMIO layout (64KB pages)
  *
@@ -36,8 +41,113 @@ typedef struct Tegra241CMDQV {
     qemu_irq irq;
     IOMMUFDVeventq *veventq;
     void *vintf_page0;
+
+    /* CMDQ-V Config page register cache */
+    uint32_t config;
+    uint32_t param;
+    uint32_t status;
+    uint32_t vi_err_map[2];
+    uint32_t vi_int_mask[2];
+    uint32_t cmdq_err_map[4];
+    uint32_t cmdq_alloc_map[TEGRA241_CMDQV_MAX_CMDQ];
+
+    /* VINTF0 register cache (within CMDQ-V Config page) */
+    uint32_t vintf_config;
+    uint32_t vintf_status;
+    uint32_t vintf_sid_match[TEGRA241_CMDQV_MAX_NUM_SID];
+    uint32_t vintf_sid_replace[TEGRA241_CMDQV_MAX_NUM_SID];
+    uint32_t vintf_cmdq_err_map[4];
 } Tegra241CMDQV;
 
+/* CMDQ-V Config page registers (offset 0x00000) */
+REG32(CONFIG, 0x0)
+FIELD(CONFIG, CMDQV_EN, 0, 1)
+FIELD(CONFIG, CMDQV_PER_CMD_OFFSET, 1, 3)
+FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
+FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
+FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
+
+REG32(PARAM, 0x4)
+FIELD(PARAM, CMDQV_VER, 0, 4)
+FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
+FIELD(PARAM, CMDQV_NUM_VI_LOG2, 8, 4)
+FIELD(PARAM, CMDQV_NUM_SID_PER_VI_LOG2, 12, 4)
+
+REG32(STATUS, 0x8)
+FIELD(STATUS, CMDQV_ENABLED, 0, 1)
+
+/* SMMU_CMDQV_VI_ERR_MAP_0/1 definitions */
+#define A_VI_ERR_MAP_0 0x14
+#define A_VI_ERR_MAP_1 0x18
+#define V_VI_ERR_MAP_NO_ERROR (0)
+#define V_VI_ERR_MAP_ERROR (1)
+
+/* SMMU_CMDQV_VI_INT_MASK_0/1 definitions */
+#define A_VI_INT_MASK_0 0x1c
+#define A_VI_INT_MASK_1 0x20
+#define V_VI_INT_MASK_NOT_MASKED (0)
+#define V_VI_INT_MASK_MASKED (1)
+
+/* SMMU_CMDQV_CMDQ_ERR_MAP_0-3 definitions */
+#define A_CMDQ_ERR_MAP_0 0x24
+#define A_CMDQ_ERR_MAP_1 0x28
+#define A_CMDQ_ERR_MAP_2 0x2c
+#define A_CMDQ_ERR_MAP_3 0x30
+
+/*
+ * CMDQ_ALLOC_MAP: one entry per physical VCMDQ. Hardware supports up to 128
+ * entries (CMDQV_NUM_CMDQ_LOG2=7), but QEMU only exposes
+ * TEGRA241_CMDQV_MAX_CMDQ (=2) VCMDQs per VM so only entries 0 and 1 are
+ * defined here.
+ */
+/* 2 identical register entries */
+#define SMMU_CMDQV_CMDQ_ALLOC_MAP_(i)                       \
+    REG32(CMDQ_ALLOC_MAP_##i, 0x200 + i * 4)                \
+    FIELD(CMDQ_ALLOC_MAP_##i, ALLOC, 0, 1)                  \
+    FIELD(CMDQ_ALLOC_MAP_##i, LVCMDQ, 1, 7)                 \
+    FIELD(CMDQ_ALLOC_MAP_##i, VIRT_INTF_INDX, 15, 6)
+
+SMMU_CMDQV_CMDQ_ALLOC_MAP_(0)
+SMMU_CMDQV_CMDQ_ALLOC_MAP_(1)
+
+/* SMMU_CMDQV_VINTF0 registers (only VINTF0 is exposed to the guest) */
+REG32(VINTF0_CONFIG, 0x1000)
+FIELD(VINTF0_CONFIG, ENABLE, 0, 1)
+FIELD(VINTF0_CONFIG, VMID, 1, 16)
+FIELD(VINTF0_CONFIG, HYP_OWN, 17, 1)
+
+REG32(VINTF0_STATUS, 0x1004)
+FIELD(VINTF0_STATUS, ENABLE_OK, 0, 1)
+FIELD(VINTF0_STATUS, STATUS, 1, 3)
+FIELD(VINTF0_STATUS, VI_NUM_LVCMDQ, 16, 8)
+
+#define V_VINTF_STATUS_NO_ERROR    (0 << 1)
+#define V_VINTF_STATUS_VCMDQ_ERROR (1 << 1)
+
+/*
+ * SMMU_CMDQV_VINTF0_SID_MATCH/_REPLACE: 16 entries per VINTF
+ * (CMDQV_NUM_SID_PER_VI_LOG2=4). Only _0 and _15 are defined,
+ * used as switch case range bounds.
+ */
+REG32(VINTF0_SID_MATCH_0, 0x1040)
+FIELD(VINTF0_SID_MATCH_0, ENABLE, 0, 1)
+FIELD(VINTF0_SID_MATCH_0, VIRT_SID, 1, 20)
+#define A_VINTF0_SID_MATCH_15  (A_VINTF0_SID_MATCH_0 + 15 * 4)
+
+REG32(VINTF0_SID_REPLACE_0, 0x1080)
+FIELD(VINTF0_SID_REPLACE_0, PHYS_SID, 0, 20)
+#define A_VINTF0_SID_REPLACE_15 (A_VINTF0_SID_REPLACE_0 + 15 * 4)
+
+/*
+ * SMMU_CMDQV_VINTF0_LVCMDQ_ERR_MAP: 4 registers per VINTF covering 32 logical
+ * VCMDQs each. With TEGRA241_CMDQV_MAX_CMDQ=2, only MAP_0 bits [1:0] carry
+ * error state. MAP_1..MAP_3 always read as 0. Only _0 and _3 are defined,
+ * used as switch case range bounds.
+ */
+REG32(VINTF0_LVCMDQ_ERR_MAP_0, 0x10c0)
+FIELD(VINTF0_LVCMDQ_ERR_MAP_0, LVCMDQ_ERR_MAP, 0, 32)
+#define A_VINTF0_LVCMDQ_ERR_MAP_3 (A_VINTF0_LVCMDQ_ERR_MAP_0 + 3 * 4)
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 3457536fb0..8c61d66a26 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -72,6 +72,10 @@ smmuv3_accel_unset_iommu_device(int devfn, uint32_t devid) "devfn=0x%x (idev dev
 smmuv3_accel_translate_ste(uint32_t vsid, uint32_t hwpt_id, uint64_t ste_1, uint64_t ste_0) "vSID=0x%x hwpt_id=0x%x ste=%"PRIx64":%"PRIx64
 smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vSID=0x%x ste type=%s hwpt_id=0x%x"
 
+# tegra241-cmdqv
+tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
+
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
 strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
2.43.0


