Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F695C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 15:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtKj-000564-0n; Tue, 13 Aug 2024 11:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKc-0004sQ-28
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdtKW-0004du-Hr
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:21:04 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52f025bc147so6518409e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723562458; x=1724167258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jVktBdEeVfNZEE6GZ7T90l8yWHTJZu2wzXIiHmL8XoE=;
 b=cu307PRwEL2I03rv5Go6jz0WJNISgyEZlMrsNep09nEN72daXcKbhaEfNMLN2LOBTz
 DDaxl5wZeF1eUHwX0SNGxysD8eEAK8jl2773KSDgCDwaEOJH1rAzuSI15lKg0mxYsSGA
 ZcJCBTG8WXiU4R8nUX56HcBzikTH/SwaixEW49L6LD8nryiPN/WBwt6DhLcoB6mN5sYj
 S7aCozc4yQMxRrybxLfZHS2k7HlSNFeRiT4KRTlglxYop002H28V4SUVHQldYbk5bf/y
 pPRdtDDgZc+7dVunTYRo2doyJI02KfqYR85b38wtIKdlg+9UJEUYICWLEGYi4w050YwM
 BuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723562458; x=1724167258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jVktBdEeVfNZEE6GZ7T90l8yWHTJZu2wzXIiHmL8XoE=;
 b=pWgYtgr3pe4V1Rl7rNojPdxSt8VtH6Nwgd5BxeEFjvTX10178UnRG8ZGj9h2WmcZVA
 VwkIjXTMNI6aULCogo5oHO4LocU1I0rk/nbuwC7rOC0ddeiaEdxl9s1XvHqMNY2Ac2+1
 vP+4coZNAmPe9hNqj81zAAwFjDDqPSul8sFGo/UBLn11S5cTUVnICjeIrI2Uoeu/OcJP
 f9yBwe4MKy8BYsLo3Xm1RHeNO+NyoJ/ImV6Cf2wzeOGAwRI/K7Hc4WF62Ew0xf1HeeD/
 X1M2Kx1SFP8FcFJxnHfh5f73H5vu2Ar6uZLzdQe/I6LsNvOSuPOKC+zHUneqWr+JVHOi
 QDvA==
X-Gm-Message-State: AOJu0Yw5cnQ9WlrBCs8qlgXr8+AN4qZCU00FIsl1hSDo3n+Ak7X9rlCH
 1LSPVSVoKnuR+INy+mngMrSv/o+kMJDWj9I6RknlB1dnD6gobGblyH1lNFUlekjoIYLldx9xk5r
 7
X-Google-Smtp-Source: AGHT+IFnjlj5YTd3CkSzgPGwf5wUqx09CxhP+cz7rBxJ3YehcjdfSNaAXQM73G81buRrjbZqN4Af2Q==
X-Received: by 2002:a05:6512:2314:b0:530:e28a:3c17 with SMTP id
 2adb3069b0e04-5321365d343mr2751205e87.25.1723562457321; 
 Tue, 13 Aug 2024 08:20:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfee676sm10654792f8f.49.2024.08.13.08.20.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 08:20:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and
 MCOSEL values
Date: Tue, 13 Aug 2024 16:20:51 +0100
Message-Id: <20240813152054.2445099-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813152054.2445099-1-peter.maydell@linaro.org>
References: <20240813152054.2445099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zheyu Ma <zheyuma97@gmail.com>

This commit adds validation checks for the MCOPRE and MCOSEL values in
the rcc_update_cfgr_register function. If the MCOPRE value exceeds
0b100 or the MCOSEL value exceeds 0b111, an error is logged and the
corresponding clock mux is disabled. This helps in identifying and
handling invalid configurations in the RCC registers.

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine b-l475e-iot01a -qtest \
stdio
writeq 0x40021008 0xffffffff
EOF

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2356
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 417bd5e85f6..59d428fa662 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -543,19 +543,31 @@ static void rcc_update_cfgr_register(Stm32l4x5RccState *s)
     uint32_t val;
     /* MCOPRE */
     val = FIELD_EX32(s->cfgr, CFGR, MCOPRE);
-    assert(val <= 0b100);
-    clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
-                         1, 1 << val);
+    if (val > 0b100) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid MCOPRE value: 0x%"PRIx32"\n",
+                      __func__, val);
+        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
+    } else {
+        clock_mux_set_factor(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                             1, 1 << val);
+    }
 
     /* MCOSEL */
     val = FIELD_EX32(s->cfgr, CFGR, MCOSEL);
-    assert(val <= 0b111);
-    if (val == 0) {
+    if (val > 0b111) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid MCOSEL value: 0x%"PRIx32"\n",
+                      __func__, val);
         clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
     } else {
-        clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], true);
-        clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
-                             val - 1);
+        if (val == 0) {
+            clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], false);
+        } else {
+            clock_mux_set_enable(&s->clock_muxes[RCC_CLOCK_MUX_MCO], true);
+            clock_mux_set_source(&s->clock_muxes[RCC_CLOCK_MUX_MCO],
+                                 val - 1);
+        }
     }
 
     /* STOPWUCK */
-- 
2.34.1


