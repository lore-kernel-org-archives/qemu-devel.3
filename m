Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF03C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAg8-00075x-Om; Mon, 29 Jun 2026 08:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfk-0006xe-QC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfh-0007Rc-LR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:08 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4936e85e0deso10237015e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734462; x=1783339262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7RKjdoQN2UDq3Fu/0bG4dxPSqOTiQ2ZKnh7ijMCw0AY=;
 b=lt+3HD9Lte1EFBTe/GNl7Dh6x/3GgKp3G8ZFENa6DkENssn2kaNybyXilqrzQm5CNy
 9Rx12E5zSA3ordmQTlHKXRxaA58wtKCekAK1ZYv7uVhAn627DjL1hhicVJiSvz7tefCN
 xJ7/rhma3r0oyc6vkAmb+enhWQGA/clcI2L9ZCfjuGa/QFiiGV//k9XEoadkz6xPNam2
 KfvcWi1m0X3e3/wx/5tCvbQSAiUotQQwkAd+TvUmLnEUFf2GGlCT7CzWpZK6A9Rs7j7W
 5fU4xHxrZsn9wnthLadMKYlEAcW07sRRMjbXjd07hSmn20QuHstVmUDDpVU+TD4cIOAO
 TW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734462; x=1783339262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7RKjdoQN2UDq3Fu/0bG4dxPSqOTiQ2ZKnh7ijMCw0AY=;
 b=P3OqwmYajYFtvtf8goynHb1IXZDOZy7ftYqdL0/41NlGGJYP3cQbOxRxl11zt6o3aL
 VUUjBL72r64qINquY9lOdq9VqaMtTWPFL4JKHQpvlX9FJJvaTfBGqHU+GXWTLoXePUP/
 /YskNO3scUayD3X10mzH9d/+HG2tPEnpBm7QockJ3RrA+bxKfYCu7yMgv7UK7S4Ll68j
 DIFE+4DgIBG8VveM+cgCsprRQN5w2vfA/VdWiIHgGBGTNPZmUfGrUttYEv67n1NvbXBy
 AwIYDqE/kbLfrsN+BACMoApQR1W0OStZZsK013ne28A2P0rzuH3yKeKXpP3oWycJ9iA1
 rqrg==
X-Gm-Message-State: AOJu0YwF6RTi9V/WfYFhydARV2zkMXWcCA4yzYX9Sc8SPUKmBcmERSeS
 oHk81u9aOoakiJ5wqKV9mrMpfzshtVxUiZBEDI58jr+dJ8bZrxYXOqfnr7Uj55o2hLa0VcXmUWD
 AP0vG
X-Gm-Gg: AfdE7ckp9gP7gu9dmSmua/GnAf55kYvU/peFUs+EX6gdLXbfCmACVwUuyOzGAuWYNKT
 tmVOr5YkMBXHcrp1MRj1wo9O2FcyVzM5p4WncQugtDX1g7Y+EBW3m3TglHLlNfDNWG8fajQ/pjv
 lhIuZpb72oQ2NIAqwEO1smkLdA77XXbK3ENS5tqCBFy9sOECEkI9P7fUSgpMAPkfNA3telwmQfB
 2KhkPqe2HRD1U/BwU/Tjs6YFdRjxbjOIir1xbeuyENHCPHmbgGILmT5Z4COknnpPdLKVfXBCPhf
 +Tyl5ub01tvKUfY5gJe2P6LSUblHhZfOadICn64WDCvk0ihh6uHPB5dt/VBwn/VzbA2Uv3HdYV6
 KbmBw9NmreLUcADNA5APrfRSRzho0wvzrpBOYYLxVlXtahxCvprNNWsRzhBx/aEIXouFqTQ7aXk
 Fe/3XjMbLSf0vGOAaSC+sA0mxzwU3Al25Et1Ltsm+6xPFUw3HJaaxQVx+RZnj1k+XbGvnixzKsF
 J2fqbNBL5vwQBSMrlUmuw==
X-Received: by 2002:a05:600c:a12:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-492668ad891mr275037525e9.30.1782734461059; 
 Mon, 29 Jun 2026 05:01:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/54] target/arm: Setup new registers for GPC3
Date: Mon, 29 Jun 2026 13:00:04 +0100
Message-ID: <20260629120032.1645265-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

From: Jim MacArthur <jim.macarthur@linaro.org>

Adds GPCBW_EL3. A custom write function is necessary to flush TLBs
when this register is written. Also allows write to the GPCBW bit of
GPCCR_EL3.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260618-jmac-gpc3b-v3-2-353e546067e7@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index a234aa031c..ddca634538 100644
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


