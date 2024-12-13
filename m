Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C6FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9aH-00008f-BE; Fri, 13 Dec 2024 12:36:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YB-0000RV-LA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:06 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y5-0001lM-Br
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:03 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so1000918f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111234; x=1734716034; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qq5JezWAvvQQNLy9rclqYIOw0RJcJBgtsySv4HgTsTw=;
 b=onjVAfx1P8QWMjeLGXx1+nU7RHPzpN8TE2p12h/p9bxkrK3FY5r/LoKjBdYhd4KBaj
 wrt1qFGw68+/PK8beYoAHIm1bG23czw8M2pX//r8TOy5U3OcwiKvPXyTgRvBk/oSOBc8
 RXfNb9TF+MP0TIpPuvY4wjDoRJJOd5uPB4szI41Rtb8VpPwgK6EEjpGf3S/s+9MS9gKZ
 2R6UMat94iNF+9nHjLzv9RdVxHdwh4exlkAy7VSVSXgZ2fzJEWI3xzQW7qSD2Xx24U7k
 j4De8YX/SdY2+YI6SXCF4Z2lTPyo971vzJHCUmwBzNNjk2AvqFzM2SpQwFnLVk7ei1/3
 t6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111234; x=1734716034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qq5JezWAvvQQNLy9rclqYIOw0RJcJBgtsySv4HgTsTw=;
 b=dZ4HQIlXxf+7hSxAxP1f/g34/tVO3xMgD6F4hSFAj8fdpo9E0/3p9HlMXJVoI4NNv7
 2qQP4NMezSid7Eo2tVT2iIVdZIAgurFVsu0TqUjJMEqzbn92EdzDUXnE887UP6dJ4A+8
 RjBAWMnPMSBeFVIIKgKHnt0CJ8grEKlm2ujqf6r4iKL7BM6ugbusVS6vBRuV6Xq/z0XV
 wXWKxrnKnm9E+v5AKvesk3BM49wVbvEryTcAGluidVAzO06Vs4x9p/YUQqXhBBNZy+hC
 c2Lm4VnSEkdF7eJbFfRky/lKRjnGN8QR1do1cIDvW+PFNLs2fuDgHe8v0j2TYUA7pr89
 V8ug==
X-Gm-Message-State: AOJu0YxwFo9o32jDhtcHI1Z/wwRKEzrtFd/ZHevxSfB3+k0uld/UFsdc
 5AfYVmWFdGZ3DwpF2LGw3aCxwbFVgWiG/Cx9qiLDi4Ragji1wRJcjM4noB7y9cODFvedKQmDUqH
 m
X-Gm-Gg: ASbGncuwsFTc9SxJjRkEiqDHNG+U0UDu4nQDQXqyBDZ8KWgqNbyRCX+ur5gki2NbUlO
 gBTDjL0eMEguA4V8cg5ABPLbCdT0bBxAazgcLyILiZbmWw5NqjFJv0DCr8C/g96iyWD5UKGW95q
 4bftZbbGA7wuyX+jvIN7sntLlmMNvVUAlLPL0D/dKCn2NVC1rvgLZ3h4o7sR9nSdYZzqiQ772TT
 RxhbsGXEebKyWg3lZs65xC7frQ9oFFNfZVjjrul7+iN4WCbVULtoyfhmumvlw==
X-Google-Smtp-Source: AGHT+IEjEMvqYVlV3j3LJ1f4FINw/0CrKuL0+84rQFiDzGtIkRh3XHzyQBtX/CLQ83QiOUOTk+Pw6g==
X-Received: by 2002:a05:6000:144f:b0:385:fae4:424e with SMTP id
 ffacd0b85a97d-3888e0c07b9mr2408616f8f.52.1734111233796; 
 Fri, 13 Dec 2024 09:33:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:52 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 77/85] target/arm: Move TLBI insns for AArch32 EL2 to
 tlbi_insn_helper.c
Date: Fri, 13 Dec 2024 17:32:21 +0000
Message-Id: <20241213173229.3308926-78-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

Move the AArch32 TLBI insns for AArch32 EL2 to tlbi_insn_helper.c.
To keep this as an obviously pure code-movement, we retain the
same condition for registering tlbi_el2_cp_reginfo that we use for
el2_cp_reginfo. We'll be able to simplify this condition later,
since the need to define the reginfo for EL3-without-EL2 doesn't
apply for the TLBI ops specifically.

This move brings all the uses of tlbimva_hyp_write() and
tlbimva_hyp_is_write() back into a single file, so we can move those
also, and make them file-local again.

The helper alle1_tlbmask() is an exception to the pattern that we
only need to make these functions global temporarily, because once
this refactoring is complete it will be called by both code in
helper.c (vttbr_write()) and by code in tlb-insns.c.  We therefore
put its prototype in a permanent home in internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-3-peter.maydell@linaro.org
---
 target/arm/cpregs.h        |  4 --
 target/arm/internals.h     |  6 +++
 target/arm/helper.c        | 74 +--------------------------------
 target/arm/tcg/tlb-insns.c | 85 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 77 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 26c27dc5cb6..851cd045b2c 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1143,9 +1143,5 @@ CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
 CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
                              bool isread);
 bool tlb_force_broadcast(CPUARMState *env);
-void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                       uint64_t value);
-void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value);
 
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 2adedb94777..c3a5b1385f1 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1820,4 +1820,10 @@ uint64_t gt_get_countervalue(CPUARMState *env);
  * and CNTVCT_EL0 (this will be either 0 or the value of CNTVOFF_EL2).
  */
 uint64_t gt_virt_cnt_offset(CPUARMState *env);
+
+/*
+ * Return mask of ARMMMUIdxBit values corresponding to an "invalidate
+ * all EL1" scope; this covers stage 1 and stage 2.
+ */
+int alle1_tlbmask(CPUARMState *env);
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6a9bf70f185..3c69225e1d9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -438,7 +438,7 @@ static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
-static int alle1_tlbmask(CPUARMState *env)
+int alle1_tlbmask(CPUARMState *env)
 {
     /*
      * Note that the 'ALL' scope must invalidate both stage 1 and
@@ -465,58 +465,6 @@ bool tlb_force_broadcast(CPUARMState *env)
     return arm_current_el(env) == 1 && (arm_hcr_el2_eff(env) & HCR_FB);
 }
 
-static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                               uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx(cs, alle1_tlbmask(env));
-}
-
-static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, alle1_tlbmask(env));
-}
-
-
-static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                              uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
-}
-
-static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
-}
-
-void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                       uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
-
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
-}
-
-void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
-
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_E2);
-}
-
 static const ARMCPRegInfo cp_reginfo[] = {
     /*
      * Define the secure and non-secure FCSE identifier CP registers
@@ -6248,26 +6196,6 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
-    { .name = "TLBIALLNSNH",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_nsnh_write },
-    { .name = "TLBIALLNSNHIS",
-      .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_nsnh_is_write },
-    { .name = "TLBIALLH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_hyp_write },
-    { .name = "TLBIALLHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbiall_hyp_is_write },
-    { .name = "TLBIMVAH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_write },
-    { .name = "TLBIMVAHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
-      .writefn = tlbimva_hyp_is_write },
     { .name = "TLBI_ALLE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
       .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index cdf23352d7a..66096093dcc 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -99,6 +99,25 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
+
+    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+}
+
+static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
+
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                             ARMMMUIdxBit_E2);
+}
+
 static void tlbiipas2_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                 uint64_t value)
 {
@@ -117,6 +136,39 @@ static void tlbiipas2is_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUIdxBit_Stage2);
 }
 
+static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx(cs, alle1_tlbmask(env));
+}
+
+static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, alle1_tlbmask(env));
+}
+
+
+static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                              uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+}
+
+static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+}
+
 static const ARMCPRegInfo tlbi_not_v7_cp_reginfo[] = {
     /*
      * MMU TLB control. Note that the wildcarding means we cover not just
@@ -227,6 +279,29 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .writefn = tlbiipas2is_hyp_write },
 };
 
+static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
+    { .name = "TLBIALLNSNH",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_nsnh_write },
+    { .name = "TLBIALLNSNHIS",
+      .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_nsnh_is_write },
+    { .name = "TLBIALLH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_hyp_write },
+    { .name = "TLBIALLHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbiall_hyp_is_write },
+    { .name = "TLBIMVAH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbimva_hyp_write },
+    { .name = "TLBIMVAHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
+      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .writefn = tlbimva_hyp_is_write },
+};
+
 void define_tlb_insn_regs(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
@@ -243,4 +318,14 @@ void define_tlb_insn_regs(ARMCPU *cpu)
     if (arm_feature(env, ARM_FEATURE_V8)) {
         define_arm_cp_regs(cpu, tlbi_v8_cp_reginfo);
     }
+    /*
+     * We retain the existing logic for when to register these TLBI
+     * ops (i.e. matching the condition for el2_cp_reginfo[] in
+     * helper.c), but we will be able to simplify this later.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL2)
+        || (arm_feature(env, ARM_FEATURE_EL3)
+            && arm_feature(env, ARM_FEATURE_V8))) {
+        define_arm_cp_regs(cpu, tlbi_el2_cp_reginfo);
+    }
 }
-- 
2.34.1


