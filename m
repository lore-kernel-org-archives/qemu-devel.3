Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6116EC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVEt-0001dc-V2; Tue, 05 Mar 2024 08:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDw-0000wa-Lr
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:53:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVDp-0005xr-Cw
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:52:52 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412eddd14b9so4116195e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646764; x=1710251564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=naDQJUm1BWCDp8wycCBq304iBQf/tU4pZQ1OtaRD1ng=;
 b=AYiky35Yi+n41/UhLOa1alchbNfw0mStGPwSDv+FAmkMsyXkWDdIQTR/TuWOeTHM4Z
 iJ8B9Zni+RJZU6MGsRaoxDsY4RUW/f9yNUDEB9+bSxblCSRM+tPgTA7DwoI1p8I5HirU
 gB0AqJp2d9BlT4Kgd6/fvT+XencI+ayVnls6DLT9htjC5d+w5/tHlUDHut9bDIIM5024
 hV3xbFk/VFKH3z3tT3hIBJlstZrbUfW0BU0pEBp2l24ZBxl7F0+NuwTQApRmeSwvnSjJ
 BDoV4XcTbrfil+0Jud23IkT87CO1c8JgqTzW1wqrtUdguK5iQQjVC2UXBJ88Ngeqex2J
 SK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646764; x=1710251564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=naDQJUm1BWCDp8wycCBq304iBQf/tU4pZQ1OtaRD1ng=;
 b=p3JbcvI7atSOXADpeDQJgjUivdfmkLM8+ERHaaU6V6GOec6GB/DpJBp5h9kOywv9qq
 Ou5L/Drk5OK+yLcTiZcnYl5Z3cHjcwKJ+2VUnOwQ+E0/Do1C7Wmrqdz1CeWcjOi6XS2w
 D2drsw7xogZbwVoOsRVKS3Es8pOJEclKPhH0IYuY6t23o0ZEMekY+gHIwkrIJV3exj7l
 VqnfDV84kBgAXmuoa4GSTHq5MY4s78QbkP0OAetfAYwa7XF4BJF5DnQRw1+NzPKd8ZwO
 DTGhj3qeRs5LZo0TsORcsi1zJEexqVdf8AqAtSnY9BUREr7Qh9JwZlc0oR2Cq43V9yhR
 dhUw==
X-Gm-Message-State: AOJu0YxUl2BGqrgpF4By/Ngpi6sefvNXJXcMB/CGx02fENfQ1NTBMt+d
 2AOkdgoShHNb+44wR+bJkPvIQD2nv8kyJ5BIjHKLzOf42Ee5BiR5RY3Z+FILJTNxDHeRYR4hzlf
 K
X-Google-Smtp-Source: AGHT+IEyQzZZOiwJg+/6I3K2YT9t6bJeI302y/YEaUz3b63Qz1ZcMDIDKaOnjBX73XTsAmNZ/XjPqQ==
X-Received: by 2002:adf:f20a:0:b0:33d:2473:4716 with SMTP id
 p10-20020adff20a000000b0033d24734716mr8088802wro.57.1709646763844; 
 Tue, 05 Mar 2024 05:52:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d6503000000b0033e206a0a7asm11797532wru.26.2024.03.05.05.52.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:52:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] hw/misc/stm32l4x5_rcc: Add write protections to CR
 register
Date: Tue,  5 Mar 2024 13:52:27 +0000
Message-Id: <20240305135237.3111642-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305135237.3111642-1-peter.maydell@linaro.org>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Add write protections for the fields in the CR register.
PLL configuration write protections (among others) have not
been handled yet. This is planned in a future patch set.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240303140643.81957-7-arnaud.minier@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 166 ++++++++++++++++++++++++++++------------
 1 file changed, 115 insertions(+), 51 deletions(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 2109f809e2b..bc2d63528ba 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -374,9 +374,47 @@ static void rcc_update_irq(Stm32l4x5RccState *s)
     }
 }
 
-static void rcc_update_cr_register(Stm32l4x5RccState *s)
+static void rcc_update_msi(Stm32l4x5RccState *s, uint32_t previous_value)
+{
+    uint32_t val;
+
+    static const uint32_t msirange[] = {
+        100000, 200000, 400000, 800000, 1000000, 2000000,
+        4000000, 8000000, 16000000, 24000000, 32000000, 48000000
+    };
+    /* MSIRANGE and MSIRGSEL */
+    val = extract32(s->cr, R_CR_MSIRGSEL_SHIFT, R_CR_MSIRGSEL_LENGTH);
+    if (val) {
+        /* MSIRGSEL is set, use the MSIRANGE field */
+        val = extract32(s->cr, R_CR_MSIRANGE_SHIFT, R_CR_MSIRANGE_LENGTH);
+    } else {
+        /* MSIRGSEL is not set, use the MSISRANGE field */
+        val = extract32(s->csr, R_CSR_MSISRANGE_SHIFT, R_CSR_MSISRANGE_LENGTH);
+    }
+
+    if (val < ARRAY_SIZE(msirange)) {
+        clock_update_hz(s->msi_rc, msirange[val]);
+    } else {
+        /*
+         * There is a hardware write protection if the value is out of bound.
+         * Restore the previous value.
+         */
+        s->cr = (s->cr & ~R_CSR_MSISRANGE_MASK) |
+                (previous_value & R_CSR_MSISRANGE_MASK);
+    }
+}
+
+/*
+ * TODO: Add write-protection for all registers:
+ * DONE: CR
+ */
+
+static void rcc_update_cr_register(Stm32l4x5RccState *s, uint32_t previous_value)
 {
     int val;
+    const RccClockMuxSource current_pll_src =
+        CLOCK_MUX_INIT_INFO[RCC_CLOCK_MUX_PLL_INPUT].src_mapping[
+            s->clock_muxes[RCC_CLOCK_MUX_PLL_INPUT].src];
 
     /* PLLSAI2ON and update PLLSAI2RDY */
     val = FIELD_EX32(s->cr, CR, PLLSAI2ON);
@@ -396,77 +434,101 @@ static void rcc_update_cr_register(Stm32l4x5RccState *s)
         s->cifr |= R_CIFR_PLLSAI1RDYF_MASK;
     }
 
-    /* PLLON and update PLLRDY */
+    /*
+     * PLLON and update PLLRDY
+     * PLLON cannot be reset if the PLL clock is used as the system clock.
+     */
     val = FIELD_EX32(s->cr, CR, PLLON);
-    pll_set_enable(&s->plls[RCC_PLL_PLL], val);
-    s->cr = (s->cr & ~R_CR_PLLRDY_MASK) |
-            (val << R_CR_PLLRDY_SHIFT);
-    if (s->cier & R_CIER_PLLRDYIE_MASK) {
-        s->cifr |= R_CIFR_PLLRDYF_MASK;
+    if (FIELD_EX32(s->cfgr, CFGR, SWS) != 0b11) {
+        pll_set_enable(&s->plls[RCC_PLL_PLL], val);
+        s->cr = (s->cr & ~R_CR_PLLRDY_MASK) |
+                (val << R_CR_PLLRDY_SHIFT);
+        if (s->cier & R_CIER_PLLRDYIE_MASK) {
+            s->cifr |= R_CIFR_PLLRDYF_MASK;
+        }
+    } else {
+        s->cr |= R_CR_PLLON_MASK;
     }
 
     /* CSSON: TODO */
     /* HSEBYP: TODO */
 
-    /* HSEON and update HSERDY */
+    /*
+     * HSEON and update HSERDY.
+     * HSEON cannot be reset if the HSE oscillator is used directly or
+     * indirectly as the system clock.
+     */
     val = FIELD_EX32(s->cr, CR, HSEON);
-    s->cr = (s->cr & ~R_CR_HSERDY_MASK) |
-            (val << R_CR_HSERDY_SHIFT);
-    if (val) {
-        clock_update_hz(s->hse, s->hse_frequency);
-        if (s->cier & R_CIER_HSERDYIE_MASK) {
-            s->cifr |= R_CIFR_HSERDYF_MASK;
+    if (FIELD_EX32(s->cfgr, CFGR, SWS) != 0b10 &&
+        current_pll_src != RCC_CLOCK_MUX_SRC_HSE) {
+        s->cr = (s->cr & ~R_CR_HSERDY_MASK) |
+                (val << R_CR_HSERDY_SHIFT);
+        if (val) {
+            clock_update_hz(s->hse, s->hse_frequency);
+            if (s->cier & R_CIER_HSERDYIE_MASK) {
+                s->cifr |= R_CIFR_HSERDYF_MASK;
+            }
+        } else {
+            clock_update(s->hse, 0);
         }
     } else {
-        clock_update(s->hse, 0);
+        s->cr |= R_CR_HSEON_MASK;
     }
 
     /* HSIAFS: TODO*/
     /* HSIKERON: TODO*/
 
-    /* HSION and update HSIRDY*/
-    val = FIELD_EX32(s->cr, CR, HSION);
-    s->cr = (s->cr & ~R_CR_HSIRDY_MASK) |
-            (val << R_CR_HSIRDY_SHIFT);
-    if (val) {
+    /*
+     * HSION and update HSIRDY
+     * HSION is set by hardware if the HSI16 is used directly
+     * or indirectly as system clock.
+     */
+    if (FIELD_EX32(s->cfgr, CFGR, SWS) == 0b01 ||
+        current_pll_src == RCC_CLOCK_MUX_SRC_HSI) {
+        s->cr |= (R_CR_HSION_MASK | R_CR_HSIRDY_MASK);
         clock_update_hz(s->hsi16_rc, HSI_FRQ);
         if (s->cier & R_CIER_HSIRDYIE_MASK) {
             s->cifr |= R_CIFR_HSIRDYF_MASK;
         }
     } else {
-        clock_update(s->hsi16_rc, 0);
+        val = FIELD_EX32(s->cr, CR, HSION);
+        if (val) {
+            clock_update_hz(s->hsi16_rc, HSI_FRQ);
+            s->cr |= R_CR_HSIRDY_MASK;
+            if (s->cier & R_CIER_HSIRDYIE_MASK) {
+                s->cifr |= R_CIFR_HSIRDYF_MASK;
+            }
+        } else {
+            clock_update(s->hsi16_rc, 0);
+            s->cr &= ~R_CR_HSIRDY_MASK;
+        }
     }
 
-    static const uint32_t msirange[] = {
-        100000, 200000, 400000, 800000, 1000000, 2000000,
-        4000000, 8000000, 16000000, 24000000, 32000000, 48000000
-    };
-    /* MSIRANGE and MSIRGSEL */
-    val = FIELD_EX32(s->cr, CR, MSIRGSEL);
-    if (val) {
-        /* MSIRGSEL is set, use the MSIRANGE field */
-        val = FIELD_EX32(s->cr, CR, MSIRANGE);
+    /* MSIPLLEN: TODO */
+
+    /*
+     * MSION and update MSIRDY
+     * Set by hardware when used directly or indirectly as system clock.
+     */
+    if (FIELD_EX32(s->cfgr, CFGR, SWS) == 0b00 ||
+        current_pll_src == RCC_CLOCK_MUX_SRC_MSI) {
+            s->cr |= (R_CR_MSION_MASK | R_CR_MSIRDY_MASK);
+            if (!(previous_value & R_CR_MSION_MASK) && (s->cier & R_CIER_MSIRDYIE_MASK)) {
+                s->cifr |= R_CIFR_MSIRDYF_MASK;
+            }
+            rcc_update_msi(s, previous_value);
     } else {
-        /* MSIRGSEL is not set, use the MSISRANGE field */
-        val = FIELD_EX32(s->csr, CSR, MSISRANGE);
-    }
-
-    if (val < ARRAY_SIZE(msirange)) {
-        clock_update_hz(s->msi_rc, msirange[val]);
-    } else {
-        clock_update_hz(s->msi_rc, MSI_DEFAULT_FRQ);
-        /* TODO: there is a write protection if the value is out of bound,
-           implement that instead of setting the default */
-    }
-
-    /* MSIPLLEN */
-
-    /* MSION and update MSIRDY */
-    val = FIELD_EX32(s->cr, CR, MSION);
-    s->cr = (s->cr & ~R_CR_MSIRDY_MASK) |
-            (val << R_CR_MSIRDY_SHIFT);
-    if (s->cier & R_CIER_MSIRDYIE_MASK) {
-        s->cifr |= R_CIFR_MSIRDYF_MASK;
+        val = FIELD_EX32(s->cr, CR, MSION);
+        if (val) {
+            s->cr |= R_CR_MSIRDY_MASK;
+            rcc_update_msi(s, previous_value);
+            if (s->cier & R_CIER_MSIRDYIE_MASK) {
+                s->cifr |= R_CIFR_MSIRDYF_MASK;
+            }
+        } else {
+            s->cr &= ~R_CR_MSIRDY_MASK;
+            clock_update(s->msi_rc, 0);
+        }
     }
     rcc_update_irq(s);
 }
@@ -991,15 +1053,17 @@ static void stm32l4x5_rcc_write(void *opaque, hwaddr addr,
                                   uint64_t val64, unsigned int size)
 {
     Stm32l4x5RccState *s = opaque;
+    uint32_t previous_value = 0;
     const uint32_t value = val64;
 
     trace_stm32l4x5_rcc_write(addr, value);
 
     switch (addr) {
     case A_CR:
+        previous_value = s->cr;
         s->cr = (s->cr & CR_READ_SET_MASK) |
                 (value & (CR_READ_SET_MASK | ~CR_READ_ONLY_MASK));
-        rcc_update_cr_register(s);
+        rcc_update_cr_register(s, previous_value);
         break;
     case A_ICSCR:
         s->icscr = value & ~ICSCR_READ_ONLY_MASK;
-- 
2.34.1


