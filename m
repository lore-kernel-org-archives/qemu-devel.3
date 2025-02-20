Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2FBC021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9Ja-0007rm-0h; Thu, 20 Feb 2025 11:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JW-0007db-Hv
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:14 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9JT-0008HD-Nu
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:22:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38f6475f747so481804f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068530; x=1740673330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zvv1wBsU1EWf+45EIG61GOs4Njq3NeuMz7F64ADAq60=;
 b=JGnM8ZjlgETFnHZLwclspZdJ6MLfroIfdCXBLyGCvTPr3Vu7paPRb4gFRFV2XZh8fI
 XDp1ZrZaLE5Azh+2V3KQttcwDLnELM2HgtfC41GYEi23sVjyCcDxxeeX5O9HoqECe6YT
 qjRz9S1+s26AUlB/ilBcuuInwCKftAZ8l0bkmtm1keZsPlNU3Q7cNYXmHaWIiK+SapST
 idFKKcI+kSNVqGUBsY8QBZvVDtSCqfSZYz+jW/2QHnQvmG7XEOjCkYW3zYfqlvdqZBTc
 H1BtmGJvRWEkIxSgcfL2a/ujfaH5F+shM9uyzA03IwOMu9ATMxMwAsen94wfUIJKcj03
 rY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068530; x=1740673330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvv1wBsU1EWf+45EIG61GOs4Njq3NeuMz7F64ADAq60=;
 b=bq0NbYy8CVXet2lnew3lmthdChgX36h6D6qytszdRmLrtBBYc8LzKoDruso959YOIm
 bBWLg7HOEbR2APfyXbYZWSz51q12ZSdNGTlJk+74gNzLHJjI4x75kEqEY/sIlL+nN0EC
 WJJSYzPjnXqctEi9t2N9u75UJAK4KiTbmD7DNEkF5CV6wZMI4RvrkdrWiTg2HZ5qgM+p
 UTXuSKFSLJ10ZthwCYwzwPRrBsPFcL1IkKrmUVgGeRjUrewwcGPIr7agAkyiCOuLiKfQ
 Mg3IDfblQB7GA/BjDDwzOsaUwNz10yyEClJ5OTbymb9QAEFkBfU0+HHWkxGwAxm2q+5P
 Qjow==
X-Gm-Message-State: AOJu0YxY2IemxUyZJMk2Xb7WMIVqKyczbLrXbo4Nzd768ISOvtwgO3SR
 EbIqjNQjfpGMbTX+KsWbT4MVM3n71PesRl+SFG9PSPiurqCyrbkB+AXAIYHOC/rtWVJ/nyQifxd
 7
X-Gm-Gg: ASbGncuKyNdOohligUwdmm9VaAj4ehr9lpmnJTlMiqbAQuCLc7HIRU3KlRNqMegB9KM
 p5CV4digKDXT2uXtGcR149NhNomjXcOhqIxseecQGoqmJ6k8fhMUA9lUhLew3qnTNgXVkhFA+Ku
 hlVrvGw90NrbBVDRhlSAOLWEyjVmI2xwuj5FfUFQ/9D0uA4dHfpRhWNHrB0K73SPGvcSNkET+Sm
 kzZyVEHo7ud3wORX7JkFoh76tOXenNcMoNOCIfFvlORN0w3Z4BmyidbUYr9oJVT34uCsZ2iSUUY
 +ZpK333cfnuHRX6RVKcnFw==
X-Google-Smtp-Source: AGHT+IE0zfM4GxIXG2Z0+9Pwjn9x8tK9TiHb2786h5KltzZAPQFTNdczJ3aJzX4xn3col+uPW+ZUCQ==
X-Received: by 2002:a05:6000:1842:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-38f650e1ea6mr2933343f8f.15.1740068528245; 
 Thu, 20 Feb 2025 08:22:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.22.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:22:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/41] hw/misc: Move NPCM7XX CLK to NPCM CLK
Date: Thu, 20 Feb 2025 16:21:16 +0000
Message-ID: <20250220162123.626941-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

A lot of NPCM7XX and NPCM8XX CLK modules share the same code,
this commit moves the NPCM7XX CLK to NPCM CLK for these
properties.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Message-id: 20250219184609.1839281-12-wuhaotsh@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm7xx.h   |   2 +-
 include/hw/misc/npcm_clk.h |  24 +++++----
 hw/misc/npcm_clk.c         | 106 +++++++++++++++++++++----------------
 hw/misc/trace-events       |   6 +--
 4 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index e80fd91f204..56536565b74 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -90,7 +90,7 @@ struct NPCM7xxState {
     MemoryRegion        *dram;
 
     NPCMGCRState        gcr;
-    NPCM7xxCLKState     clk;
+    NPCMCLKState     clk;
     NPCM7xxTimerCtrlState tim[3];
     NPCM7xxADCState     adc;
     NPCM7xxPWMState     pwm[NPCM7XX_NR_PWM_MODULES];
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index 0aef81e10c8..db03b46a52b 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -20,11 +20,12 @@
 #include "hw/clock.h"
 #include "hw/sysbus.h"
 
-/*
- * Number of registers in our device state structure. Don't change this without
- * incrementing the version_id in the vmstate.
- */
 #define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
+/*
+ * Number of maximum registers in NPCM device state structure. Don't change
+ * this without incrementing the version_id in the vmstate.
+ */
+#define NPCM_CLK_MAX_NR_REGS            NPCM7XX_CLK_NR_REGS
 
 #define NPCM7XX_WATCHDOG_RESET_GPIO_IN "npcm7xx-clk-watchdog-reset-gpio-in"
 
@@ -80,7 +81,7 @@ typedef enum NPCM7xxClockDivider {
     NPCM7XX_CLOCK_NR_DIVIDERS,
 } NPCM7xxClockConverter;
 
-typedef struct NPCM7xxCLKState NPCM7xxCLKState;
+typedef struct NPCMCLKState NPCMCLKState;
 
 /**
  * struct NPCM7xxClockPLLState - A PLL module in CLK module.
@@ -94,7 +95,7 @@ typedef struct NPCM7xxClockPLLState {
     DeviceState parent;
 
     const char *name;
-    NPCM7xxCLKState *clk;
+    NPCMCLKState *clk;
     Clock *clock_in;
     Clock *clock_out;
 
@@ -115,7 +116,7 @@ typedef struct NPCM7xxClockSELState {
     DeviceState parent;
 
     const char *name;
-    NPCM7xxCLKState *clk;
+    NPCMCLKState *clk;
     uint8_t input_size;
     Clock *clock_in[NPCM7XX_CLK_SEL_MAX_INPUT];
     Clock *clock_out;
@@ -140,7 +141,7 @@ typedef struct NPCM7xxClockDividerState {
     DeviceState parent;
 
     const char *name;
-    NPCM7xxCLKState *clk;
+    NPCMCLKState *clk;
     Clock *clock_in;
     Clock *clock_out;
 
@@ -155,7 +156,7 @@ typedef struct NPCM7xxClockDividerState {
     };
 } NPCM7xxClockDividerState;
 
-struct NPCM7xxCLKState {
+struct NPCMCLKState {
     SysBusDevice parent;
 
     MemoryRegion iomem;
@@ -165,7 +166,7 @@ struct NPCM7xxCLKState {
     NPCM7xxClockSELState sels[NPCM7XX_CLOCK_NR_SELS];
     NPCM7xxClockDividerState dividers[NPCM7XX_CLOCK_NR_DIVIDERS];
 
-    uint32_t regs[NPCM7XX_CLK_NR_REGS];
+    uint32_t regs[NPCM_CLK_MAX_NR_REGS];
 
     /* Time reference for SECCNT and CNTR25M, initialized by power on reset */
     int64_t ref_ns;
@@ -174,7 +175,8 @@ struct NPCM7xxCLKState {
     Clock *clkref;
 };
 
+#define TYPE_NPCM_CLK "npcm-clk"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMCLKState, NPCM_CLK)
 #define TYPE_NPCM7XX_CLK "npcm7xx-clk"
-OBJECT_DECLARE_SIMPLE_TYPE(NPCM7xxCLKState, NPCM7XX_CLK)
 
 #endif /* NPCM_CLK_H */
diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index 2bcb731099e..0ecf0df3bbf 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -198,7 +198,7 @@ static NPCM7xxClockPLL find_pll_by_reg(enum NPCM7xxCLKRegisters reg)
     }
 }
 
-static void npcm7xx_clk_update_all_plls(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_plls(NPCMCLKState *clk)
 {
     int i;
 
@@ -207,7 +207,7 @@ static void npcm7xx_clk_update_all_plls(NPCM7xxCLKState *clk)
     }
 }
 
-static void npcm7xx_clk_update_all_sels(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_sels(NPCMCLKState *clk)
 {
     int i;
 
@@ -216,7 +216,7 @@ static void npcm7xx_clk_update_all_sels(NPCM7xxCLKState *clk)
     }
 }
 
-static void npcm7xx_clk_update_all_dividers(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_dividers(NPCMCLKState *clk)
 {
     int i;
 
@@ -225,7 +225,7 @@ static void npcm7xx_clk_update_all_dividers(NPCM7xxCLKState *clk)
     }
 }
 
-static void npcm7xx_clk_update_all_clocks(NPCM7xxCLKState *clk)
+static void npcm7xx_clk_update_all_clocks(NPCMCLKState *clk)
 {
     clock_update_hz(clk->clkref, NPCM7XX_CLOCK_REF_HZ);
     npcm7xx_clk_update_all_plls(clk);
@@ -635,7 +635,7 @@ static void npcm7xx_clk_divider_init(Object *obj)
 }
 
 static void npcm7xx_init_clock_pll(NPCM7xxClockPLLState *pll,
-        NPCM7xxCLKState *clk, const PLLInitInfo *init_info)
+        NPCMCLKState *clk, const PLLInitInfo *init_info)
 {
     pll->name = init_info->name;
     pll->clk = clk;
@@ -647,7 +647,7 @@ static void npcm7xx_init_clock_pll(NPCM7xxClockPLLState *pll,
 }
 
 static void npcm7xx_init_clock_sel(NPCM7xxClockSELState *sel,
-        NPCM7xxCLKState *clk, const SELInitInfo *init_info)
+        NPCMCLKState *clk, const SELInitInfo *init_info)
 {
     int input_size = init_info->input_size;
 
@@ -664,7 +664,7 @@ static void npcm7xx_init_clock_sel(NPCM7xxClockSELState *sel,
 }
 
 static void npcm7xx_init_clock_divider(NPCM7xxClockDividerState *div,
-        NPCM7xxCLKState *clk, const DividerInitInfo *init_info)
+        NPCMCLKState *clk, const DividerInitInfo *init_info)
 {
     div->name = init_info->name;
     div->clk = clk;
@@ -683,7 +683,7 @@ static void npcm7xx_init_clock_divider(NPCM7xxClockDividerState *div,
     }
 }
 
-static Clock *npcm7xx_get_clock(NPCM7xxCLKState *clk, ClockSrcType type,
+static Clock *npcm7xx_get_clock(NPCMCLKState *clk, ClockSrcType type,
         int index)
 {
     switch (type) {
@@ -700,7 +700,7 @@ static Clock *npcm7xx_get_clock(NPCM7xxCLKState *clk, ClockSrcType type,
     }
 }
 
-static void npcm7xx_connect_clocks(NPCM7xxCLKState *clk)
+static void npcm7xx_connect_clocks(NPCMCLKState *clk)
 {
     int i, j;
     Clock *src;
@@ -724,10 +724,10 @@ static void npcm7xx_connect_clocks(NPCM7xxCLKState *clk)
     }
 }
 
-static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t npcm_clk_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxCLKState *s = opaque;
+    NPCMCLKState *s = opaque;
     int64_t now_ns;
     uint32_t value = 0;
 
@@ -766,19 +766,19 @@ static uint64_t npcm7xx_clk_read(void *opaque, hwaddr offset, unsigned size)
         break;
     };
 
-    trace_npcm7xx_clk_read(offset, value);
+    trace_npcm_clk_read(offset, value);
 
     return value;
 }
 
-static void npcm7xx_clk_write(void *opaque, hwaddr offset,
+static void npcm_clk_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
     uint32_t reg = offset / sizeof(uint32_t);
-    NPCM7xxCLKState *s = opaque;
+    NPCMCLKState *s = opaque;
     uint32_t value = v;
 
-    trace_npcm7xx_clk_write(offset, value);
+    trace_npcm_clk_write(offset, value);
 
     if (reg >= NPCM7XX_CLK_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -842,7 +842,7 @@ static void npcm7xx_clk_write(void *opaque, hwaddr offset,
 static void npcm7xx_clk_perform_watchdog_reset(void *opaque, int n,
         int level)
 {
-    NPCM7xxCLKState *clk = NPCM7XX_CLK(opaque);
+    NPCMCLKState *clk = NPCM_CLK(opaque);
     uint32_t rcr;
 
     g_assert(n >= 0 && n <= NPCM7XX_NR_WATCHDOGS);
@@ -856,9 +856,9 @@ static void npcm7xx_clk_perform_watchdog_reset(void *opaque, int n,
     }
 }
 
-static const struct MemoryRegionOps npcm7xx_clk_ops = {
-    .read       = npcm7xx_clk_read,
-    .write      = npcm7xx_clk_write,
+static const struct MemoryRegionOps npcm_clk_ops = {
+    .read       = npcm_clk_read,
+    .write      = npcm_clk_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid      = {
         .min_access_size        = 4,
@@ -867,9 +867,9 @@ static const struct MemoryRegionOps npcm7xx_clk_ops = {
     },
 };
 
-static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
+static void npcm_clk_enter_reset(Object *obj, ResetType type)
 {
-    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+    NPCMCLKState *s = NPCM_CLK(obj);
 
     QEMU_BUILD_BUG_ON(sizeof(s->regs) != sizeof(cold_reset_values));
 
@@ -882,7 +882,7 @@ static void npcm7xx_clk_enter_reset(Object *obj, ResetType type)
      */
 }
 
-static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
+static void npcm7xx_clk_init_clock_hierarchy(NPCMCLKState *s)
 {
     int i;
 
@@ -918,19 +918,19 @@ static void npcm7xx_clk_init_clock_hierarchy(NPCM7xxCLKState *s)
     clock_update_hz(s->clkref, NPCM7XX_CLOCK_REF_HZ);
 }
 
-static void npcm7xx_clk_init(Object *obj)
+static void npcm_clk_init(Object *obj)
 {
-    NPCM7xxCLKState *s = NPCM7XX_CLK(obj);
+    NPCMCLKState *s = NPCM_CLK(obj);
 
-    memory_region_init_io(&s->iomem, obj, &npcm7xx_clk_ops, s,
-                          TYPE_NPCM7XX_CLK, 4 * KiB);
+    memory_region_init_io(&s->iomem, obj, &npcm_clk_ops, s,
+                          TYPE_NPCM_CLK, 4 * KiB);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
 }
 
-static int npcm7xx_clk_post_load(void *opaque, int version_id)
+static int npcm_clk_post_load(void *opaque, int version_id)
 {
     if (version_id >= 1) {
-        NPCM7xxCLKState *clk = opaque;
+        NPCMCLKState *clk = opaque;
 
         npcm7xx_clk_update_all_clocks(clk);
     }
@@ -938,10 +938,10 @@ static int npcm7xx_clk_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void npcm7xx_clk_realize(DeviceState *dev, Error **errp)
+static void npcm_clk_realize(DeviceState *dev, Error **errp)
 {
     int i;
-    NPCM7xxCLKState *s = NPCM7XX_CLK(dev);
+    NPCMCLKState *s = NPCM_CLK(dev);
 
     qdev_init_gpio_in_named(DEVICE(s), npcm7xx_clk_perform_watchdog_reset,
             NPCM7XX_WATCHDOG_RESET_GPIO_IN, NPCM7XX_NR_WATCHDOGS);
@@ -996,15 +996,15 @@ static const VMStateDescription vmstate_npcm7xx_clk_divider = {
     },
 };
 
-static const VMStateDescription vmstate_npcm7xx_clk = {
-    .name = "npcm7xx-clk",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .post_load = npcm7xx_clk_post_load,
+static const VMStateDescription vmstate_npcm_clk = {
+    .name = "npcm-clk",
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .post_load = npcm_clk_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, NPCM7xxCLKState, NPCM7XX_CLK_NR_REGS),
-        VMSTATE_INT64(ref_ns, NPCM7xxCLKState),
-        VMSTATE_CLOCK(clkref, NPCM7xxCLKState),
+        VMSTATE_UINT32_ARRAY(regs, NPCMCLKState, NPCM_CLK_MAX_NR_REGS),
+        VMSTATE_INT64(ref_ns, NPCMCLKState),
+        VMSTATE_CLOCK(clkref, NPCMCLKState),
         VMSTATE_END_OF_LIST(),
     },
 };
@@ -1033,17 +1033,23 @@ static void npcm7xx_clk_divider_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_npcm7xx_clk_divider;
 }
 
-static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+static void npcm_clk_class_init(ObjectClass *klass, void *data)
 {
     ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM7XX_CLK_NR_REGS);
+    dc->vmsd = &vmstate_npcm_clk;
+    dc->realize = npcm_clk_realize;
+    rc->phases.enter = npcm_clk_enter_reset;
+}
 
+static void npcm7xx_clk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END > NPCM_CLK_MAX_NR_REGS);
+    QEMU_BUILD_BUG_ON(NPCM7XX_CLK_REGS_END != NPCM7XX_CLK_NR_REGS);
     dc->desc = "NPCM7xx Clock Control Registers";
-    dc->vmsd = &vmstate_npcm7xx_clk;
-    dc->realize = npcm7xx_clk_realize;
-    rc->phases.enter = npcm7xx_clk_enter_reset;
 }
 
 static const TypeInfo npcm7xx_clk_pll_info = {
@@ -1070,11 +1076,18 @@ static const TypeInfo npcm7xx_clk_divider_info = {
     .class_init         = npcm7xx_clk_divider_class_init,
 };
 
+static const TypeInfo npcm_clk_info = {
+    .name               = TYPE_NPCM_CLK,
+    .parent             = TYPE_SYS_BUS_DEVICE,
+    .instance_size      = sizeof(NPCMCLKState),
+    .instance_init      = npcm_clk_init,
+    .class_init         = npcm_clk_class_init,
+    .abstract           = true,
+};
+
 static const TypeInfo npcm7xx_clk_info = {
     .name               = TYPE_NPCM7XX_CLK,
-    .parent             = TYPE_SYS_BUS_DEVICE,
-    .instance_size      = sizeof(NPCM7xxCLKState),
-    .instance_init      = npcm7xx_clk_init,
+    .parent             = TYPE_NPCM_CLK,
     .class_init         = npcm7xx_clk_class_init,
 };
 
@@ -1083,6 +1096,7 @@ static void npcm7xx_clk_register_type(void)
     type_register_static(&npcm7xx_clk_pll_info);
     type_register_static(&npcm7xx_clk_sel_info);
     type_register_static(&npcm7xx_clk_divider_info);
+    type_register_static(&npcm_clk_info);
     type_register_static(&npcm7xx_clk_info);
 }
 type_init(npcm7xx_clk_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index f25dbd6030c..4383808d7ad 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -130,9 +130,9 @@ mos6522_set_sr_int(void) "set sr_int"
 mos6522_write(uint64_t addr, const char *name, uint64_t val) "reg=0x%"PRIx64 " [%s] val=0x%"PRIx64
 mos6522_read(uint64_t addr, const char *name, unsigned val) "reg=0x%"PRIx64 " [%s] val=0x%x"
 
-# npcm7xx_clk.c
-npcm7xx_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
-npcm7xx_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+# npcm_clk.c
+npcm_clk_read(uint64_t offset, uint32_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
+npcm_clk_write(uint64_t offset, uint32_t value) "offset: 0x%04" PRIx64 " value: 0x%08" PRIx32
 
 # npcm_gcr.c
 npcm_gcr_read(uint64_t offset, uint64_t value) " offset: 0x%04" PRIx64 " value: 0x%08" PRIx64
-- 
2.43.0


