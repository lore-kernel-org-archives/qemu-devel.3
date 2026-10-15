Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7D5CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtS-0003rO-Lm; Thu, 15 Oct 2026 14:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt6-0003ky-Ul
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt5-00010I-2Z
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso711269f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087745; x=1792692545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gCXpy/YATXKD7IJ5gVE8xSjzEOVIPjSSZvJa3xBkBJI=;
 b=uamoXOYbeL2ITmKoX6OPc5WHQNa0ZOU1Wuu5LMUw8zyhCDcXk6IGKRJiBPtIZJEzU6
 QYf1AIxjsWkmQzPwjvCVMBFcjRG8Ho9W9peWTNm6yzFSlVWVbuXRU55C9YToa509BdLq
 5JOkUiFsegLaXC3A1rD0mBDyp316niPEjfmQ02udYZXn1Pz0UdD+ZGp/08H/e/sdW+Mr
 xlGTcXIRMWbUSQPiFhQTIiJEHI0nwVFXhYImHJsf0rXYR9YWDeGzX2/lLIVLNriTx865
 h3/bMpgfcny1QqiH1wXijnc/72ngdvNHsTX9FrEkSMaumYnFVQZyRRzdpx/xeiZc9mXz
 ZsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087745; x=1792692545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gCXpy/YATXKD7IJ5gVE8xSjzEOVIPjSSZvJa3xBkBJI=;
 b=BCdeJWC01Rkm40qhK3erF3TyX/Ty0+Virwu4zVnSLvZN2h4WIq6fNy97tWci19e/5X
 TBx+/UNavkGBMdgeIZSWkzedcF/NcQ0j/aicjoXmw5SQoHyakeiPN4bm2M6hOU3LUrMF
 3S1jI5shoqsf7t6JyPkjhM/0ldpbn3leUMcRzHuYpTwmpTzRiatmM5jCRH8xYMkHQGrs
 fD0Dn84ttI3WgpIBO0B5bHwYL1tpXb3po7Sw5Wg1CtGwkW67vr8xkqPmHl09PldmbS4e
 kpwwyBw6wXTDB+hTN/blkF0nglF2KGS++oYtEd5pyHpg735g7PCYztk7mjvCxNiLbw6E
 QY0Q==
X-Gm-Message-State: AFq9FYLMgJ2ofDZhS/tpno8DeosDOfS9H7SHmAocjYJXaQziJIwyoyQW
 0XK2HaLrr6JuyLgGWNoiHj91jmXlcCD1Q/tHAw45Ip5tWGYEnHrrE/ulQ+7A1ZHcgW9HQnvZ4g1
 d3DD4sS0=
X-Gm-Gg: AYBFou2whQfTyAtEBw93BSJrUgwkMSIVDiaxoFT69J0IPLclpCCPbaYHUfY5wXGyTMp
 GR1RhFOLmYspDUfvTjM5NhyqujGcCO1W2JOgvzIqv9oq5RT3zervfxE6/RMgqFUm94EVAxBT64d
 Fqs9q5CYMo0p4eHLuJZS9uoiW3kM72rTGLEu3LCJ51PUgUrZk6N5HUtcdMXCKBetfO/U5wU2zDD
 mGSIx1draKZ9XV5TTWdqkfTIvGskEcF1ILXcmRJ2o7sgvAiw5Rmu1HV6ovjECzP5V4UaimklZsZ
 0FoDcPaQdCtVMexBdbdrjkk9F5vn8KuoJbOwBcJ/lLkwi1nsrceGTJ4h4FZbWu6WvaeYFPSEaL+
 bLw50kuTFCRXpP5rh3JikNtAWQbo8RCnR6hzxQpWsUcBczBdg1OChZ+srcGTKF5HV4bAdjX2F6L
 MF3jt1AhGYiM55WiNRxbkMCD0+7ZTjuSQ8z/+4we7MGuR5DdC6923DbVipInwgVsNzbZMKDVjx7
 9ZmmpwhCctX8a5Zo/AZAVN16MZW5sfNesAeebaLdwxAleWUidA/KaeIgWOkgbDaXPy4BOoJMybs
 s18=
X-Received: by 2002:a05:6000:38e:b0:48d:db77:d119 with SMTP id
 ffacd0b85a97d-48ddb77d2ebmr25715045f8f.2.1792087745471; 
 Thu, 15 Oct 2026 11:09:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] hw/misc/stm32_rcc: Mirror clock ready and switch status
 bits
Date: Thu, 15 Oct 2026 19:08:46 +0100
Message-ID: <20261015180858.1863407-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
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

From: Manuele Conti <manuele.conti@archimede-energia.com>

RM0090 7.3.1/7.3.3: oscillator ready bits follow their
corresponding enable bits, and SWS follows SW. Upstream stored raw
values, so firmware polling for ready or checking SWS never saw the
expected state.

Mirror the enable bits into the ready bits on CR writes and SW into
SWS on CFGR writes. Clock switching is instantaneous in QEMU. No
oscillator startup or PLL lock delay is modelled.

Add qtest coverage for HSION, HSEON, PLLON, PLLI2SON and SW,
including clearing the ready bits again when the oscillators are
disabled.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/stm32_rcc.c              | 19 ++++++++++
 tests/qtest/stm32f405-rcc-test.c | 62 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |  2 +-
 3 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32f405-rcc-test.c

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 5cfb39e5607..814c5ea3b01 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -90,6 +90,25 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
+    case STM32_RCC_CR:
+        /*
+         * Oscillators become ready immediately in QEMU.
+         * Mirror enable bits into ready bits. See RM0090 7.3.1.
+         */
+        value = deposit32(value, 1, 1, extract32(value, 0, 1));
+        value = deposit32(value, 17, 1, extract32(value, 16, 1));
+        value = deposit32(value, 25, 1, extract32(value, 24, 1));
+        value = deposit32(value, 27, 1, extract32(value, 26, 1));
+        s->regs[addr >> 2] = value;
+        return;
+    case STM32_RCC_CFGR:
+        /*
+         * System clock switching is instantaneous in QEMU.
+         * Mirror SW[1:0] into SWS[3:2]. See RM0090 7.3.3.
+         */
+        value = deposit32(value, 2, 2, extract32(value, 0, 2));
+        s->regs[addr >> 2] = value;
+        return;
     case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
     case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
         prev_value = s->regs[addr / 4];
diff --git a/tests/qtest/stm32f405-rcc-test.c b/tests/qtest/stm32f405-rcc-test.c
new file mode 100644
index 00000000000..1a8819b6f5b
--- /dev/null
+++ b/tests/qtest/stm32f405-rcc-test.c
@@ -0,0 +1,62 @@
+/*
+ * STM32F405 RCC tests
+ *
+ * Copyright (c) 2026 Manuele Conti <manuele.conti@archimede-energia.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define RCC_BASE        0x40023800
+#define RCC_CR          (RCC_BASE + 0x00)
+#define RCC_CFGR        (RCC_BASE + 0x08)
+
+#define CR_HSION        (1U << 0)
+#define CR_HSIRDY       (1U << 1)
+#define CR_HSEON        (1U << 16)
+#define CR_HSERDY       (1U << 17)
+#define CR_PLLON        (1U << 24)
+#define CR_PLLRDY       (1U << 25)
+#define CR_PLLI2SON     (1U << 26)
+#define CR_PLLI2SRDY    (1U << 27)
+
+static void test_cr_ready_bits(void)
+{
+    uint32_t on = CR_HSION | CR_HSEON | CR_PLLON | CR_PLLI2SON;
+    uint32_t ready = CR_HSIRDY | CR_HSERDY | CR_PLLRDY | CR_PLLI2SRDY;
+
+    writel(RCC_CR, on);
+    g_assert_cmphex(readl(RCC_CR), ==, on | ready);
+
+    writel(RCC_CR, 0);
+    g_assert_cmphex(readl(RCC_CR), ==, 0);
+}
+
+static void test_cfgr_switch_status(void)
+{
+    unsigned int sw;
+
+    for (sw = 0; sw < 4; sw++) {
+        writel(RCC_CFGR, sw);
+        g_assert_cmphex(readl(RCC_CFGR), ==, sw | (sw << 2));
+    }
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/stm32f405/rcc/cr-ready-bits", test_cr_ready_bits);
+    qtest_add_func("/stm32f405/rcc/cfgr-switch-status",
+                   test_cfgr_switch_status);
+
+    qtest_start("-machine olimex-stm32-h405");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 69bebe5a396..2f63621e393 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -254,7 +254,7 @@ qtests_exynos4210 = \
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
-   ['stm32f405-timer-test'] : []) + \
+   ['stm32f405-timer-test', 'stm32f405-rcc-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
-- 
2.43.0


