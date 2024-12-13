Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF19CE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9YY-000303-Bt; Fri, 13 Dec 2024 12:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YC-0000RY-DW
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:06 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y8-0001mI-Ec
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so19215045e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111237; x=1734716037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PnZrF/tSgFnWOLB78XUnLnp4yZ94TIfs2kxs+s5SEtA=;
 b=ILMci85be/Jzkz/iSjZNiBZeTgzzNWBiBIleucfVXCz9ZU17GvB4Gjbdvbnq57TpOY
 KElzHwYdYREcPU5YfIe+P3RU3zj0WqlbUGlWgl6C4pGkh2nUvfHAmdPnjt5EItcBnffz
 txdt92uozHIGwEI1npPj0zqSnVDxl3MErPguM21mypTmoQNHHc+QHFEDB/XeCyoGQaba
 Z82SJSk6Zb/edBNN2Bj6lZ6DN1f185sRUEvM6DsYm4Hzts2yhGLxOitkw6OGNCG/J1e3
 QDPKglgkQdQh5FVlwzmH9EPfButl8HmqwZEyKJ8iRdvLTMnJH8fhhx443pfWPwZ/Uxsg
 Yy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111237; x=1734716037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PnZrF/tSgFnWOLB78XUnLnp4yZ94TIfs2kxs+s5SEtA=;
 b=Kr2giwj/8W+AyLKuBpDYOUrxIPXwz19PXAdixtP8ic2h+hE3Fo5ShVwV8biTrQKZUq
 ZYgMhAV4kP4ORWF/GG7q3GpowNZcvTOcv+8b2sP+Ul5/7T/+HB8Y3vj8tBaWAlmS7Rb7
 y4XbZ0t5wXP6YLTgP8Ojr7spPsZNDQxLTcTRcgOix8REFy0W+t8eayTi+BvReNSU4KZT
 oofhANH/2O+VlQL0OF5AunYfopq4QjoOSKSWbDg3o0ETeB5fPYK5mqy3Jle5xzJZbf0x
 RDkroZRSUMYjhNlBbBS1px3Ug2vYYrFvfwBFbJQXbrt44lDgEEZ345ZvKzMl1lqa0GXJ
 r3WQ==
X-Gm-Message-State: AOJu0Yyd2o6nb+X6AKaJcU71iAvWgXH96cNKmo0AIOaSpzzItQb6iWLY
 0GSm3z6EP2SNKZ6cj9/Lfqrk0DJlKwaAvWDkqGF7Z3c6+1BezFEPw27gXPYK5hZeAx1WBFPftty
 D
X-Gm-Gg: ASbGnctRJ2zVuKUKuGrmdRcvzLUnX+ikW8LU+Z6uylI6/7AWuO4yCODHRCuQKeXpH36
 pKpyG/LgL4KE7Qfvao5mDR7w7SE+wSdkycK8TnIVfFjCGcgJsg/NcBWSCL2uObToqww92SNZvSV
 3pSWQe1QycNLBGcKzievWuatwSmWNsLGT+qUfz0zE4SKi6LomHen0rBamMoVnKWhS1zyl5viWHD
 wcP8wNmN74zHPRZLXN3H9LoZVhSaXKTwp3QqWH6ko0n8Bjaz3yi64ctQTFRcQ==
X-Google-Smtp-Source: AGHT+IEl/FpQc+i6jaXiDqlgGrsCKP6zPFX9caOQ1Jq80j+TFNRV2M5UMdvkhPR9i9bFFzcWt966fw==
X-Received: by 2002:a05:6000:1a8b:b0:385:e5d8:2bea with SMTP id
 ffacd0b85a97d-3888dcd4a0emr2821232f8f.20.1734111236668; 
 Fri, 13 Dec 2024 09:33:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 80/85] target/arm: Move AArch64 EL3 TLBI insns
Date: Fri, 13 Dec 2024 17:32:24 +0000
Message-Id: <20241213173229.3308926-81-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Move the AArch64 EL3 TLBI insns from el3_cp_reginfo[] across
to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-6-peter.maydell@linaro.org
---
 target/arm/cpregs.h        |  4 +++
 target/arm/helper.c        | 56 +++-----------------------------------
 target/arm/tcg/tlb-insns.c | 54 ++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 52 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 57446ae1b52..722ac5bb884 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1161,5 +1161,9 @@ void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value);
 void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value);
+void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value);
+void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value);
 
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6942d2f2fb3..baeabb5ec73 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4784,15 +4784,6 @@ int e2_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_E2);
 }
 
-static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E3);
-}
-
 void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
@@ -4811,29 +4802,14 @@ void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
-static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
+void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
 {
     CPUState *cs = env_cpu(env);
 
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E3);
 }
 
-static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
-{
-    /*
-     * Invalidate by VA, EL3
-     * Currently handles both VAE3 and VALE3, since we don't support
-     * flush-last-level-only.
-     */
-    ARMCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E3);
-}
-
 void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -4856,8 +4832,8 @@ void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
-static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   uint64_t value)
+void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
@@ -6223,30 +6199,6 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 6, .crn = 5, .crm = 1, .opc2 = 1,
       .access = PL3_RW, .type = ARM_CP_CONST,
       .resetvalue = 0 },
-    { .name = "TLBI_ALLE3IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle3is_write },
-    { .name = "TLBI_VAE3IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3is_write },
-    { .name = "TLBI_VALE3IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3is_write },
-    { .name = "TLBI_ALLE3", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle3_write },
-    { .name = "TLBI_VAE3", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3_write },
-    { .name = "TLBI_VALE3", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_vae3_write },
 };
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 1eebb6055ce..528265404de 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -200,6 +200,15 @@ static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, mask);
 }
 
+static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = CPU(cpu);
+
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E3);
+}
+
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -216,6 +225,21 @@ static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
 }
 
+static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    /*
+     * Invalidate by VA, EL3
+     * Currently handles both VAE3 and VALE3, since we don't support
+     * flush-last-level-only.
+     */
+    ARMCPU *cpu = env_archcpu(env);
+    CPUState *cs = CPU(cpu);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E3);
+}
+
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -511,6 +535,33 @@ static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae2is_write },
 };
 
+static const ARMCPRegInfo tlbi_el3_cp_reginfo[] = {
+    { .name = "TLBI_ALLE3IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 0,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle3is_write },
+    { .name = "TLBI_VAE3IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae3is_write },
+    { .name = "TLBI_VALE3IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae3is_write },
+    { .name = "TLBI_ALLE3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 0,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle3_write },
+    { .name = "TLBI_VAE3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 1,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae3_write },
+    { .name = "TLBI_VALE3", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 5,
+      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_vae3_write },
+};
+
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -537,4 +588,7 @@ void define_tlb_insn_regs(ARMCPU *cpu)
             && arm_feature(env, ARM_FEATURE_V8))) {
         define_arm_cp_regs(cpu, tlbi_el2_cp_reginfo);
     }
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        define_arm_cp_regs(cpu, tlbi_el3_cp_reginfo);
+    }
 }
-- 
2.34.1


