Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303D1CD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 16:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waFgL-0006k7-UI; Thu, 18 Jun 2026 12:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waFg4-0006dJ-AV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:33:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1waFg2-0006Lr-G2
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 12:33:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so1163520f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 09:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781800393; x=1782405193; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kea4dc/isoBx6rpEUTWsbHn6iNysu9QKjGPmvqVX+qw=;
 b=yoDeb5v3OUKQfkubIRHaH244Ch5UYQeqgScWNgtQTMdrGlaEXUyfJkJDt97G9Vtpq1
 zaxwofOKSOFRNln+L+4imwLaFTwuZaI+lJxRukHR5w3uW6m98KXfMHr9fqi7LuqHT3We
 foTbMCPGOUXGEOwLukqTH0IGgbvKayWnLrr6vQpdLus5OhjSx1HVJaMlWL2inWbTymsy
 MrERgHKAGUWopEImBRT3K+xNygmUssCiTfpu04g6OqfpuW029+c6dLtnO3ovspAkzrfF
 ptUkIYG+Va23pQQonDI9s1hbUhu1c9Pz9IypkA2T8ta3NAXsvjevpU8Xeb73hK1MC9dN
 OYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781800393; x=1782405193;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kea4dc/isoBx6rpEUTWsbHn6iNysu9QKjGPmvqVX+qw=;
 b=Adf6C5hRvUewjuDHlnVMwc7CZdzCqpSmtwXh8JWRohU9wrCCPcmjXEZ5ctO8sBU49y
 942xp7yVjaF+DzY5F0mXXhbP1HJdLSgBNmJcR2k9Z3MlmFIHzC1xQXuBxs9+vCelA9cw
 LZKl94Z9BfaeSuoyPtZEjGHbGL6CosdByjQhHF0w/W9meHgxjpoAxla5/tnLGowxPlxy
 CRJFbGW02qs2TYro+/MIrBKkuaY97C/POOQINRzROcHac1UYBwH4ry4RApPJ+urLG0YY
 0I39pwK6PsemVX56yTZ3VUgsjVjbeKvmtDIMLFW/ylFd0HilypS2CMaGd2mbtSyB2Kky
 h6Aw==
X-Gm-Message-State: AOJu0YxCelB3CgzZw44Hq4ZQiTeLEdcBigdZ+NX4PfSjsStCS9RT8DG/
 DV1UVG5p+dpI5+7rfhPsV6xctep0sSlChZcYAfKDzVcsYGwWjFzvLCBpnhPBzaFcwpY=
X-Gm-Gg: AfdE7cnc2zbbMhmAWuKJU2NdvFA3s4pRWw9YlMMaLpamx5l5oOjrKZiqmMEsNbfqful
 Cq3tRMpgf9dRXu8C/Gpvw7DSg0ABCUV41kxcgknnlIcIiSN7cq1dQsrAgpE3HeITesGEOJxRcKQ
 kL5zyBmiApWzedj7ecNlB5WGjU0EZC/9TGTGJ14150mFITdbwttNUHMz9zojGP8s7nNKT86EVAP
 b1LuL+WpDPPks+OAIpEQ6HLayjC5KHCWv8kbclExCodCRD9pJglsRyE0+C+CWU21nR3XamWwt4u
 01uJV0Zq5ebmi0huy8jOEfSApqOj478dvPOamk5+zsxcFFOYntHXH4AoCHkYcnaFO473xotWLbB
 uoGEEGL6GMo2ffwEVHknn7TyRB0s130yyOLzNXSfPKtw/QC/CX7rAVpxurpifbGvpjZm96hWONo
 1JxFLoW9zJzq6isg==
X-Received: by 2002:a5d:5f82:0:b0:45e:f2bd:2b17 with SMTP id
 ffacd0b85a97d-4650853517amr133653f8f.21.1781800392723; 
 Thu, 18 Jun 2026 09:33:12 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:b52:6a9:569d:e33e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc426e1sm26942f8f.29.2026.06.18.09.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 09:33:12 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Thu, 18 Jun 2026 17:33:05 +0100
Subject: [PATCH v3 2/6] target/arm: Setup new registers for GPC3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-jmac-gpc3b-v3-2-353e546067e7@linaro.org>
References: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
In-Reply-To: <20260618-jmac-gpc3b-v3-0-353e546067e7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x434.google.com
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

Adds GPCBW_EL3. A custom write function is necessary to flush TLBs
when this register is written. Also allows write to the GPCBW bit of
GPCCR_EL3.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu.h    |  7 +++++++
 target/arm/helper.c | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 31a5567c95..84d33e87dc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -559,6 +559,7 @@ typedef struct CPUArchState {
         /* RME registers */
         uint64_t gpccr_el3;
         uint64_t gptbr_el3;
+        uint64_t gpcbw_el3;
         uint64_t mfar_el3;
 
         /* NV2 register */
@@ -1244,6 +1245,8 @@ void arm_v7m_cpu_do_interrupt(CPUState *cpu);
 typedef struct ARMGranuleProtectionConfig {
     /* GPCCR_EL3 */
     uint64_t gpccr;
+    /* GPCBW_EL3 */
+    uint64_t gpcbw;
     /* GPTBR_EL3 */
     uint64_t gptbr;
     /* ID_AA64MMFR0_EL1.PARange */
@@ -2116,6 +2119,10 @@ FIELD(GPCCR, NA6, 27, 1)
 FIELD(GPCCR, NA7, 28, 1)
 FIELD(GPCCR, GPCBW, 29, 1)
 
+FIELD(GPCBW, BWSIZE, 37, 2)
+FIELD(GPCBW, BWSTRIDE, 32, 5)
+FIELD(GPCBW, BWADDR, 0, 25)
+
 FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 22e71a2804..8538a28ce6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5001,6 +5001,10 @@ static void gpccr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                    R_GPCCR_SPAD_MASK | R_GPCCR_NSPAD_MASK | R_GPCCR_RLPAD_MASK;
     }
 
+    if (cpu_isar_feature(aa64_rme_gpc3, env_archcpu(env))) {
+        rw_mask |= R_GPCCR_GPCBW_MASK;
+    }
+
     env->cp15.gpccr_el3 = (value & rw_mask) | (env->cp15.gpccr_el3 & ~rw_mask);
 }
 
@@ -5010,11 +5014,26 @@ static void gpccr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
                                      env_archcpu(env)->reset_l0gptsz);
 }
 
+static void gpcbw_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                        uint64_t value)
+{
+    uint64_t rw_mask = R_GPCBW_BWADDR_MASK | R_GPCBW_BWSTRIDE_MASK |
+                       R_GPCBW_BWSIZE_MASK;
+    ARMCPU *cpu = env_archcpu(env);
+
+    tlb_flush(CPU(cpu));
+    env->cp15.gpcbw_el3 = (value & rw_mask);
+}
+
 static const ARMCPRegInfo rme_reginfo[] = {
     { .name = "GPCCR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 6,
       .access = PL3_RW, .writefn = gpccr_write, .resetfn = gpccr_reset,
       .fieldoffset = offsetof(CPUARMState, cp15.gpccr_el3) },
+    { .name = "GPCBW_EL3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 5,
+      .access = PL3_RW, .writefn = gpcbw_write,
+      .fieldoffset = offsetof(CPUARMState, cp15.gpcbw_el3) },
     { .name = "GPTBR_EL3", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 1, .opc2 = 4,
       .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.gptbr_el3) },

-- 
2.43.0


