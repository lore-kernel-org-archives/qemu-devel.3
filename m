Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AF3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggis-0007bG-6a; Mon, 06 Jul 2026 06:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiT-00076T-Md
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiR-0003RQ-VT
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so25871645e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334298; x=1783939098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=umLdS5gBN/eDnp3kIhJOVCqi4IixifjbGJbrrXBV5Rw=;
 b=Ae9rSSpJygK3uNxsYCw+81NPIJ/RIf90QNAFLlAU3U+g6yaoHSFrt+IQu03Fbqm8/I
 CcmgapKCSpMOJd+QlwxMge5dHIC7iLddSGNU52FbKBNu7piE6MG8AbpCz6lYJvxTmb/X
 7FxkNWwwf/pja0/EhQw9P7gMaMc0TqhFoIeC+hO2tEfZ6CG6Q9drC4y14gamsmBqAgx6
 1m2UDVeFS2r6UQLOwZwjpipw3eUVbuNiXvhYt2OgwnbZl5gxSABQeMPx1gEcrDrs3HCf
 7IfKKQB+QjmeTZdHGl/axrXd+a21XiF2wdz3aZOaipW9szU+y2ZXqSBMsa+C+c+ge3A5
 jvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334298; x=1783939098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umLdS5gBN/eDnp3kIhJOVCqi4IixifjbGJbrrXBV5Rw=;
 b=LbTcDT8IzoDS1774YNGIyPqG2L7RAqIshdfUNhk/CyCUFmf/mWnZ+gd4yTx8W5VkNb
 /dJb3pYRqYDY2127waNVwJQ4ORvSMp2y/9qcHpgEeqOBCg9028XVshXeKN3S1VIng7Bt
 0Ex1B9kSysK4KcMcthVRn0ntGgdLonchrlmKVcE/1vQOHmQTiqKa2nPNHU3kwohI8qYZ
 b5TLX76qRPvnZPoKDhl6fBWHmXDzAsKJLvsGlnB/vVrwytdyA2bXOtKQmBHzpfRjtqPn
 H3bYYCPJIcPNG2fw+lJ4TyhCQe3f0Cvj/B0lB8j7AUw+5/usc/si4s/dd2iFCNlthjXv
 gO+g==
X-Gm-Message-State: AOJu0YwOjgj/ed1RRa6QMUkrQHiEQBTyHskSobjo9wDq8VobRuDgJuO0
 nK1NuIrKC+71C8KlVfmMMRgDSNJvDu2yHuK7KNJhxSXpMxW9baCCTOVsmajcS3xQHxtR2NLsvo/
 7IIKgLIEUnQ==
X-Gm-Gg: AfdE7cnSw+578imBTv8NJXNH665Gz02nCjVahFfez5mBYTZ3l4Gzm9Jo78fPSyeBtjb
 jHagQ8MshdJ+F3iPtxDj90fj0mz3H8wCMRgFSft2ZQnYRI79rI0nWgGWEDuKaR96pRpxbXk0Rwe
 NvbalfSUKlyHUniw4ckbMMtDNYZmN1TjcPKdNfFlUdz0siK2F+gLLmGKK5E4LH+3MDBXvMp+U34
 UoR8V35ErAmz7De/xQH0HQay1Y3d4Gg3lG6s4OVeoeOTPFupzs5RpTSflr3uswOZSV06YbLJGOi
 2HXnOcl0U0AggwTzuaDA6se02qrRKhX6wiRPzJ1Hh0jZHc10MLAaADUt1LfPf/ty7E2RqCOe6PQ
 L+vsc5SXD9S6rG+kcY3PGa5BWMtnWO2FVB7O9fiZxiKw76d5oknI2W2DsZ3GoSAxgBPJBk3lAUQ
 LF8U1UK5iKoW5NN+LWndD+shw+04mbn2+xsoYXZJ367yWIyH0b9gDayjPKi+EhzeIWZD9h5f2vL
 +wzBAVVfS4pflS/mKMImw==
X-Received: by 2002:a05:600c:3110:b0:492:28be:6098 with SMTP id
 5b1f17b1804b1-493d11d8025mr126177205e9.11.1783334298474; 
 Mon, 06 Jul 2026 03:38:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/49] hw/misc/imx_ccm: Replace DPRINTF with trace events
Date: Mon,  6 Jul 2026 11:37:26 +0100
Message-ID: <20260706103752.320511-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
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

From: jack wang <163wangjack@gmail.com>

Signed-off-by: jack wang <163wangjack@gmail.com>
[PMM: trace include is just "trace.h"]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx_ccm.c    | 18 +++---------------
 hw/misc/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/hw/misc/imx_ccm.c b/hw/misc/imx_ccm.c
index 9403c5daa3..9f34f9b7b3 100644
--- a/hw/misc/imx_ccm.c
+++ b/hw/misc/imx_ccm.c
@@ -14,18 +14,7 @@
 #include "qemu/osdep.h"
 #include "hw/misc/imx_ccm.h"
 #include "qemu/module.h"
-
-#ifndef DEBUG_IMX_CCM
-#define DEBUG_IMX_CCM 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_CCM) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_CCM, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 
 uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
@@ -37,7 +26,7 @@ uint32_t imx_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
         freq = klass->get_clock_frequency(dev, clock);
     }
 
-    DPRINTF("(clock = %d) = %u\n", clock, freq);
+    trace_imx_ccm_get_clock_frequency(clock, freq);
 
     return freq;
 }
@@ -64,8 +53,7 @@ uint32_t imx_ccm_calc_pll(uint32_t pllreg, uint32_t base_freq)
     freq = ((2 * (base_freq >> 10) * (mfi * mfd + mfn)) /
             (mfd * pd)) << 10;
 
-    DPRINTF("(pllreg = 0x%08x, base_freq = %u) = %d\n", pllreg, base_freq,
-            freq);
+    trace_imx_ccm_calc_pll(pllreg, base_freq, freq);
 
     return freq;
 }
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 99910fc068..3449ad9527 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -237,6 +237,10 @@ iotkit_secctl_s_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit Sec
 iotkit_secctl_ns_read(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_ns_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs write: offset 0x%x data 0x%" PRIx64 " size %u"
 
+# imx_ccm.c
+imx_ccm_get_clock_frequency(uint32_t clock, uint32_t freq) "(clock = %u) = %u"
+imx_ccm_calc_pll(uint32_t pllreq, uint32_t base_freq, uint32_t freq) "(pllreg = 0x%08x, base_freq = %u) = %u"
+
 # imx6_ccm.c
 imx6_analog_get_periph_clk(uint32_t freq) "freq = %u Hz"
 imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u Hz"
-- 
2.43.0


