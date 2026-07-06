Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C27C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggif-0007DX-Bw; Mon, 06 Jul 2026 06:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiW-00076i-7T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiU-0003SM-Gi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493ba701891so22641875e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334301; x=1783939101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5+F9UmJYVVfNUxs32WT2PQRCUaAu3WmtNkJ31m9rOPw=;
 b=V3KmuBgK3fS1Nfd8/xG7FFekIaLzG5T0/ulfAuoIfdOpjbbVzw8CL4LCBwUdpvBUFx
 0AF2bdYEieSby++8Nahp6XYDZYlxbnLEHUNbO0tZUSapRIZloyuOGuZgU2eYF/+sWR9c
 Huv2iPR/WOVp2BWNA6MwGQCGB6T7wKCVr6YmMpz27mQgfQleRnnG3J6uWQ1kX2zycDR+
 HAX3u5P2N8HmaNB2tjCsH/Apc0cW6l5X/AbyWTFpHOdooOE6m+RFhwqjP8H6eHDyKs0m
 Nwj8bDaexESYIPQJ1zZDRktV7I5giGcuL/OnalUGtWCUaZWc8OlIPTpT0JEYVrviFD5E
 Ca9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334301; x=1783939101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5+F9UmJYVVfNUxs32WT2PQRCUaAu3WmtNkJ31m9rOPw=;
 b=GnqFbv8XfVKQciGm4bcG0k2lMne4M95bTj4QaDspUxQyGIS2QOYxr1wR9WUld0hV9F
 bMih68q4YMuXedgAZzCEcaH6ifC4oEnoAAea13oVfqsAm1AwPtPSfGdQL0ynwtkZWU+P
 VdSsCpqDypMBVoeYTrFKvt3rgBSBvScbN6bsq3v2hUhYQGhxkGH8vAIQUrjg2ZC0xrQ5
 tx7Uwjj5WMusV74YMFSFkGHS06nWqpwp8lKkECT549zzgTSQ6nkUP7lcCGXlz2J++Agq
 pftq0+6SMgTjgCaVzJOexIUcOb7Qhmo1bSrxyiDCOJY59hF3prZVaUt+b/pjQf4P2kCW
 SPAg==
X-Gm-Message-State: AOJu0Yxp54SpMMVkQwLDd2irDf4kYj3ZBMOT/ZmCcCBTlhhX9BsRwc6C
 Ko8UOMLNuGiuvzVYG9VeYrSY5A/UqLWTgTYRDE0HMcS/anEO1QVX6W8e6HYcju7UoVmEXaFVqPO
 ZMp1A6ss7xg==
X-Gm-Gg: AfdE7ckSqnaEMyX10Tl3p7H/uKqJfROxtO1o5Vj0xfZ5n9Tt6s3/wFrGDgksgJsGYpl
 MlkD1l8JXvNNGazf+idmlG1HfnigUKIbDtT/excQUJ2TRWu/mbYiXD5vAjRixH86pgDISlEm8i3
 zSg/BbNxVL+UM8TrbEE/R7mL+s5/T5kVy1d9ugK8QwCeNu/YmUfMuZTDcAkA6mOgK3j9iXxyls4
 FM6R1lTQB0hLyORhzmScFELkl01VHuEBB9TBQrfMoH23m1zXl4k1ore3xD80FxQhi12q4jX1bsQ
 /cPvEpV0WeHC+dFv6HTeWzz257ORS567GPb4gSD/MlQi986PQPMnlaB/lJhajgPTL3yFZjHmVcN
 5cdkOjHIIzRsaJeeXchgfiiut0RG53cu9rr0cMnUg6KoEghDHvQ9m2f5w1M9BYzBdaQV3m7iFgE
 is7HnUn7sSIEMc5KTlY6BhKuaTj3YLtenjD0lF9xwmkzCQAXZbIpVo9McGBKsO1FaLCJZqjfOwv
 t0sdaNlo1WDk0SmtRmPsg==
X-Received: by 2002:a05:600c:c4a5:b0:493:aab3:c09c with SMTP id
 5b1f17b1804b1-493d11fa9abmr113902605e9.28.1783334300973; 
 Mon, 06 Jul 2026 03:38:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/49] hw/misc/imx25_ccm: Replace DPRINTF with trace events
Date: Mon,  6 Jul 2026 11:37:27 +0100
Message-ID: <20260706103752.320511-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: jack wang <163wangjack@gmail.com>

Signed-off-by: jack wang <163wangjack@gmail.com>
[PMM: Removed incorrect change to a function prototype;
 use just "trace.h" for include]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx25_ccm.c  | 32 +++++++++-----------------------
 hw/misc/trace-events |  9 +++++++++
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index a6665d5535..a91b0be682 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -16,18 +16,8 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "hw/misc/trace.h"
 
-#ifndef DEBUG_IMX25_CCM
-#define DEBUG_IMX25_CCM 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX25_CCM) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX25_CCM, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
 
 static const char *imx25_ccm_reg_name(uint32_t reg)
 {
@@ -118,7 +108,7 @@ static uint32_t imx25_ccm_get_mpll_clk(IMXCCMState *dev)
         freq = imx_ccm_calc_pll(s->reg[IMX25_CCM_MPCTL_REG], CKIH_FREQ);
     }
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_mpll_clk(freq);
 
     return freq;
 }
@@ -136,7 +126,7 @@ static uint32_t imx25_ccm_get_mcu_clk(IMXCCMState *dev)
 
     freq = freq / (1 + EXTRACT(s->reg[IMX25_CCM_CCTL_REG], ARM_CLK_DIV));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_mcu_clk(freq);
 
     return freq;
 }
@@ -149,7 +139,7 @@ static uint32_t imx25_ccm_get_ahb_clk(IMXCCMState *dev)
     freq = imx25_ccm_get_mcu_clk(dev)
            / (1 + EXTRACT(s->reg[IMX25_CCM_CCTL_REG], AHB_CLK_DIV));
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_ahb_clk(freq);
 
     return freq;
 }
@@ -160,7 +150,7 @@ static uint32_t imx25_ccm_get_ipg_clk(IMXCCMState *dev)
 
     freq = imx25_ccm_get_ahb_clk(dev) / 2;
 
-    DPRINTF("freq = %u\n", freq);
+    trace_imx25_ccm_get_ipg_clk(freq);
 
     return freq;
 }
@@ -168,7 +158,7 @@ static uint32_t imx25_ccm_get_ipg_clk(IMXCCMState *dev)
 static uint32_t imx25_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
 {
     uint32_t freq = 0;
-    DPRINTF("Clock = %d)\n", clock);
+    trace_imx25_ccm_get_clock_frequency(clock, freq);
 
     switch (clock) {
     case CLK_NONE:
@@ -186,7 +176,7 @@ static uint32_t imx25_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
         break;
     }
 
-    DPRINTF("Clock = %d) = %u\n", clock, freq);
+    trace_imx25_ccm_get_clock_frequency(clock, freq);
 
     return freq;
 }
@@ -195,8 +185,6 @@ static void imx25_ccm_reset(DeviceState *dev)
 {
     IMX25CCMState *s = IMX25_CCM(dev);
 
-    DPRINTF("\n");
-
     memset(s->reg, 0, IMX25_CCM_MAX_REG * sizeof(uint32_t));
     s->reg[IMX25_CCM_MPCTL_REG] = 0x800b2c01;
     s->reg[IMX25_CCM_UPCTL_REG] = 0x84042800;
@@ -238,8 +226,7 @@ static uint64_t imx25_ccm_read(void *opaque, hwaddr offset, unsigned size)
                       HWADDR_PRIx "\n", TYPE_IMX25_CCM, __func__, offset);
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx25_ccm_reg_name(offset >> 2),
-            value);
+    trace_imx25_ccm_read(imx25_ccm_reg_name(offset >> 2), value);
 
     return value;
 }
@@ -249,8 +236,7 @@ static void imx25_ccm_write(void *opaque, hwaddr offset, uint64_t value,
 {
     IMX25CCMState *s = (IMX25CCMState *)opaque;
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx25_ccm_reg_name(offset >> 2),
-            (uint32_t)value);
+    trace_imx25_ccm_write(imx25_ccm_reg_name(offset >> 2), value);
 
     if (offset < 0x70) {
         /*
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 3449ad9527..13f120d140 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -275,6 +275,15 @@ imx6_src_reset(void) ""
 imx7_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx7_src_write(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
 
+# imx25_ccm.c
+imx25_ccm_get_mpll_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_mcu_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_ahb_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_ipg_clk(uint32_t freq) "freq = %u"
+imx25_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(clock = %d) = %u"
+imx25_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx25_ccm_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
+
 # iotkit-sysinfo.c
 iotkit_sysinfo_read(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 iotkit_sysinfo_write(uint64_t offset, uint64_t data, unsigned size) "IoTKit SysInfo write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.43.0


