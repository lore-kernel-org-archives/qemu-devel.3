Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C459FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jm-00019t-O1; Tue, 10 Dec 2024 11:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jk-00015G-Ke
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2ji-0004ak-Mb
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a044dce2so64022335e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846721; x=1734451521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FeFzMEVdDE+AUInCn4fOg/ohIGFS9Yg/qg9aPiQLoxI=;
 b=yt4Db1AW0+Gx9bZAKNCzFTMeqE9W4o6VNxlkicXHqx8MmUKeot5BbNWxVcVW5tkIZ/
 hLVZbMjh7yU7fw1yYQYo5uKbTV63zyym8HjXzdZQagOOIi7W3iYV9NmfvX/0CHoZgZkh
 nFfqjw9K6G5K0K9nJ6SX6iVMeREOWtiVUOTAndqhvaXBTMPEiZya4FndnH9sW1JiG8vo
 DBw1O3ak2dH2ePzkGeRUNtvt2TlTbout56ilAn15OBS83S0lB/f2i4ZhoGS7eI1JhqFP
 mmU0ZzHDn//hFLiQGFlDt+JS8ypX5/5o17dW8IfRHDeUij5RqDR/4pzgd0Y3tjwFdWWr
 W1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846721; x=1734451521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FeFzMEVdDE+AUInCn4fOg/ohIGFS9Yg/qg9aPiQLoxI=;
 b=wVc/hjN6y2u9IwIpH75qkJJzEPHs11EU4tMXbPVDvwUrnLmVo1oCiEbGcUrEmWIIW7
 G0W2ng2+tHnBAg7A/RDMxpuNPIbyTU5yN4W+dGISFZFX0E3MCwy97GENPwxnKWSOPYZC
 nUdCRmEofNbxdIboHLWwDwDrU3Mq4/H/U6BCFMSxaHBfH8JTaJpMTC4MDTjNmJUV/Y7r
 H3hyH673A1nraN/MGu4tT61IdhB2XqjhEzk639zu/ccpKN1mFyD3The4wdpCeDg0GFZM
 Fxtut3gewkVz/XLz51t4WFZWqDxzQUe1j6YyUg08KOBFoBHYwZQUlZ6Isz6uY6NhdBWt
 tgMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7OoXOVwP+0fLKZDwH8hUs4s2AKJBH5Vzh95J+gqkZIhgCt3F3lMotzfCAavf5tR+VFxGa/b93+36K@nongnu.org
X-Gm-Message-State: AOJu0YznG22k8olciyoXiTbdyu3bLBrHON4EG3yucDfzxPqb0Di+5nRB
 F1pcFapfZTKUJ9+G/tpOuNpifEZRki/ffUSld1gtXCjRZ905hfowOFOF4oDTtH8=
X-Gm-Gg: ASbGncu6xt4DI8ib7IfJnFrvwzI2fkfZzPA7vMNhJoumWGaojr9UxYwd4TuUvk1iVW1
 9J66rHzNbearJ+FYPBmSBxyKlTK7LLY/9/ugl6BpMq8op4wGzHjxaF+nxcdxNDvrN7/mWZ5spHZ
 Cd0MHDV7yyVA9ZaR/v9pgjocmMqKSpK2mcCv7jTFJd/rlz99dwvgkp5Iz27oSzgS8bi0kTdCLxl
 fRQlPN6PvH6iqTZJOGpiPmorie8ON4TP88H6x30+ZAtSPSvl3HrISEmZKGc
X-Google-Smtp-Source: AGHT+IEP9I1ujG2N7Q08WdkeRglWS3lo7eBhqTNLsa19NtvEhVnxEG6+4adLBSUQDJ3vZFHro13h/Q==
X-Received: by 2002:a05:600c:458c:b0:434:9ec0:9e4e with SMTP id
 5b1f17b1804b1-434fffba059mr59758535e9.30.1733846717286; 
 Tue, 10 Dec 2024 08:05:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/10] target/arm: Move AArch64 EL3 TLBI insns
Date: Tue, 10 Dec 2024 16:04:47 +0000
Message-Id: <20241210160452.2427965-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


