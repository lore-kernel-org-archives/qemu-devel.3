Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41593CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZBg-0001HM-U6; Tue, 16 Jun 2026 15:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8S-0004iC-Mf
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8M-00010U-C3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so49704245e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636833; x=1782241633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y0U9XSoqZ7NscbSwIzDuis0V8cuLT6uo3vwbdLjQW14=;
 b=bACIDaHvjXhlUUu77RvNDnTw8hQ/XaiTbFLrlN/3KZTHN1jTYjQakFLNSeJgTisV5/
 1f7zCePfsGDwlnnyDR5opSYISpfhxGhF9YCbB/F01yMaHVa7ibYWhWo0gwV3SEobfj8J
 w2e7su69ZSeHVNx4vTQZRs5bSubmzO907WwefCVeLY/bXVVSmchkTTggyRjbjd3f15I7
 qFCj+CT7HtkJnuHJuPD32RTMuOxOFYfqmJSlK8ripifn94dcULWC9ZrYv0LhpG2A8UZp
 8XNGuBhc9wfUEJ7rBM1fvP9e29mSgy7xL0v7h9ra65ywJ5WnscsLVJKXpR85ULRT5gfn
 arIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636833; x=1782241633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y0U9XSoqZ7NscbSwIzDuis0V8cuLT6uo3vwbdLjQW14=;
 b=kDVJiampqovLT//2ZF0PTsYBBbpeVD8qoS0Hp796Ar+Z9XgkpGPIBKL1AMz4DUCr02
 earSlH+HcTB/i2MZCwcpSugpm6hRB/QCIbdpB5knNUUjT8wVmyoKYiGyKaQeI3wAxG7G
 jH1swuvdms7nL4OzL27k0VlGpQ0GMB1yvI0EIgY49kxP02DEy885yAEoyHIcQ8jrNlHu
 UspEaDgNAHxZulbHRpUyGFRRCCkBFeqHoj5ljzm0cLnAdFGfatmneI0+Cjvx0zSdA0lz
 49orz4nLyh5fQobWAJu9GLiu3U2NbcSUiZrLiePt5k4HIxSGRwoSVkAlFBGKeDxvYfVn
 jO1Q==
X-Gm-Message-State: AOJu0YwLPOzcidMQIvj5OKnCYtgYIjoMGvXsLYRuh2rYoEFYzZ1niBzO
 wB6deqKU9ot8Fw0VcvcuGw6dV5VWs1gK8nDOsleb5NnlUdE7Au7++TD5aH59Rh9H/RJdGwuP188
 TE7R4
X-Gm-Gg: Acq92OHNw485FPRmztaCrFu2LLLaB6rIIXi2pWZ6PrNTeYKIQxByUY5UCo4AdIZz+k+
 VjEz3XKB4nn2dZ1ofwghlyObvpKfNoBTi4xgaYhqSavsDOFYIUJGy9jvluYV+cpvgN+qDDeX7pz
 UcTj7vpqtSTvltYwG/p6nILzfnhbKNqpKYW5amXLiSzfCCXW9rS6i3vlYxQKX3eb0MWqEjc+vS+
 3SGPWYiYcI4BxNvsZbv+n4V4+tylIheqLeMjcObCm9amTc2oatXJxJnGN+X3KrXxwdZNimhKjbu
 h14CPiCc7J2j+oK/UOGwMbH8AY9RnLYiC5ilCvk2ILIjivlsClbRq+ohpDanEJTl4kdDy8ss90l
 osde/lYG/vtIwB3QK5pQHb4GDLfF7sLxTugX8bmYmgENkJTEwIzSGw2kSVaCQ9XZn1/jOuBY2+O
 6jjh5f95nJgS3JNtr3Rbp+RFbg6SKq/4u5F/uG8z+fKYxleEKMgZOMl1r8lZWOul1EEFsrF5qpG
 XA40iVxRTVNtIJ/65ja5CSnEC2OC8+c
X-Received: by 2002:a05:600c:8184:b0:490:625e:bb68 with SMTP id
 5b1f17b1804b1-4923339f885mr15021255e9.3.1781636832885; 
 Tue, 16 Jun 2026 12:07:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/61] hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
Date: Tue, 16 Jun 2026 20:06:04 +0100
Message-ID: <20260616190639.3462006-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

This is the write side counterpart of the VCMDQ read emulation. Add
write handling for both the direct VCMDQ aperture and the VINTF
logical aperture using the same index decoding and VINTF-to-VCMDQ
translation logic as the read path.

VINTF aperture writes are translated to their direct-aperture
equivalent and update the same cached state. Page 1 registers
(BASE, CONS_INDX_BASE) always update the cache.

Per the CMDQV architecture, a VCMDQ must be allocated to a Virtual
Interface before it is used to send commands to the SMMU. Until
that allocation happens, MMIO writes only update cached register
state - no command consumption, error handling, or interrupt
activity is driven from these writes. Subsequent patches wire up
IOMMU_HW_QUEUE_ALLOC, mmap the host VINTF Page 0, and install it
into guest MMIO; after that, Page 0 writes from either aperture
reach the hardware-backed mmap'd page instead of just the cache.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260609112552.378999-18-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 159 +++++++++++++++++++++++++++++++++++++++-
 hw/arm/trace-events     |   2 +
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 2dfd377ee9..1f3d883cfe 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -120,6 +120,104 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
     }
 }
 
+/*
+ * Write a VCMDQ Page 0 register (control/status) using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * Page 0 registers are all 32-bit; this helper is only called for 4-byte
+ * writes.
+ */
+static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
+                                             hwaddr offset0, int index,
+                                             uint32_t value, bool direct)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        cmdqv->vcmdq_cons_indx[index] = value;
+        break;
+    case A_VCMDQ0_PROD_INDX:
+        /* VCMDQ is functional only once allocated to a VINTF; cache only. */
+        cmdqv->vcmdq_prod_indx[index] = value;
+        break;
+    case A_VCMDQ0_CONFIG:
+        if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
+            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        } else {
+            cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        }
+        cmdqv->vcmdq_config[index] = value;
+        break;
+    case A_VCMDQ0_GERRORN:
+        /* VCMDQ is functional only once allocated to a VINTF; cache only. */
+        cmdqv->vcmdq_gerrorn[index] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page0(index, direct ? "direct" : "vi",
+                                           offset0, value);
+}
+
+/*
+ * Write a VCMDQ Page 1 register (base / DRAM address) - 4-byte access.
+ */
+static void tegra241_cmdqv_write_vcmdq_page1(Tegra241CMDQV *cmdqv,
+                                             hwaddr offset0, int index,
+                                             uint32_t value, bool direct)
+{
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
+        cmdqv->vcmdq_base[index] =
+            deposit64(cmdqv->vcmdq_base[index], 0, 32, value);
+        break;
+    case A_VCMDQ0_BASE_H:
+        cmdqv->vcmdq_base[index] =
+            deposit64(cmdqv->vcmdq_base[index], 32, 32, value);
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            deposit64(cmdqv->vcmdq_cons_indx_base[index], 0, 32, value);
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            deposit64(cmdqv->vcmdq_cons_indx_base[index], 32, 32, value);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page1(index, direct ? "direct" : "vi",
+                                           offset0, value);
+}
+
+/*
+ * Write a VCMDQ Page 1 register - 8-byte access at BASE_L or DRAM_L.
+ */
+static void tegra241_cmdqv_write_vcmdq_page1_64(Tegra241CMDQV *cmdqv,
+                                                hwaddr offset0, int index,
+                                                uint64_t value, bool direct)
+{
+    switch (offset0) {
+    case A_VCMDQ0_BASE_L:
+        cmdqv->vcmdq_base[index] = value;
+        break;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        cmdqv->vcmdq_cons_indx_base[index] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled 64-bit write at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+    }
+    trace_tegra241_cmdqv_write_vcmdq_page1(index, direct ? "direct" : "vi",
+                                           offset0, value);
+}
+
 static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
                                               hwaddr offset, uint64_t value)
 {
@@ -243,6 +341,8 @@ out:
 static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                        uint32_t value)
 {
+    int index;
+
     switch (offset) {
     case A_CONFIG:
         cmdqv->config = value;
@@ -261,6 +361,39 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VINTF Page0 registers are hardware aliases of VCMDQ Page0 registers.
+         * Translate the VINTF aperture offset to its VCMDQ Page0 equivalent
+         * before dispatching to the Page 0 helper.
+         */
+        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+        break;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ Page 0 access. Each VCMDQ occupies a
+         * CMDQV_VCMDQ_STRIDE-byte window; extract the index and normalize
+         * to the VCMDQ0_* offset before calling the Page 0 helper.
+         */
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page0(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above. */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+        break;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
@@ -268,14 +401,36 @@ static void tegra241_cmdqv_writel_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
 }
 
 /*
- * 8-byte MMIO write handler.
+ * 8-byte MMIO write handler. Only Page 1 BASE / CONS_INDX_BASE_DRAM accept
+ * full 64-bit writes; other offsets are write-ignored.
  */
 static void tegra241_cmdqv_writell_mmio(Tegra241CMDQV *cmdqv, hwaddr offset,
                                         uint64_t value)
 {
-    qemu_log_mask(LOG_UNIMP,
+    int index;
+
+    switch (offset) {
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /*
+         * VINTF Page1 registers are hardware aliases of VCMDQ Page1 registers.
+         * Translate the VINTF aperture offset to its VCMDQ Page1 equivalent
+         * before dispatching to the Page 1 helper.
+         */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, false);
+        break;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq_page1_64(cmdqv,
+                offset - index * CMDQV_VCMDQ_STRIDE, index, value, true);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
                       "%s unhandled 64-bit write at 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
+    }
 }
 
 static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 5156604228..666967dc5e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -77,6 +77,8 @@ tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset:
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
+tegra241_cmdqv_write_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.43.0


