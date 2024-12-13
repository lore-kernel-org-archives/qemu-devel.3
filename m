Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C496E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Yj-0004TM-5A; Fri, 13 Dec 2024 12:34:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9YC-0000RX-D1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:06 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y6-0001m4-2s
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:34:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434f80457a4so19355775e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111236; x=1734716036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IXb1EyNQgSAc6Jv9qKhwJUtQcVIW/R0AFPQfAJk+WHA=;
 b=mJgSUrxah3PyldZzAeRCjzVEEX0UdEwRzGjj4lpWqx1YVxinOCVtLwVjlrdIkQb6GR
 pSYI0WIye6bZD+YYgzRGjuSyiW7jMDvlPvAUcP56FPBd0w0SpP1vCe3icKRvAwlo6cL1
 h+J3lL7P0gQxxzoGaM/G96/0e8LnxZ7s0AJhwCGRH8NJdGb/3oWusfw7SwKgURpAWy2y
 YF/wXQq4qSPj17rV+sXwv4Oq/mtdWY3rXFWiNXtUT4aY1cTGHv2gi+B4vX4Lcq68c6W+
 1SWecXJ5E/tXzyAFMpoxRekdAsFoSagTxfZpeoMJUqzhZ4WbR0efoisi9PBsDO8bXAog
 JJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111236; x=1734716036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IXb1EyNQgSAc6Jv9qKhwJUtQcVIW/R0AFPQfAJk+WHA=;
 b=PRb+CCE3KBAyljrkosNBJ7gJA4hfls4NDEULrTWarOVeOOnG4TKtVRvcjB36rckwdD
 xZTS4pPQT9Z2k6mj+bo3Fe+Wz0PO5wZbH7a8rMNo9vkhNpyUa64kVX3VdhyQapoai8aT
 aMF9F9TOPyc8MYfqSn18BtiY+2e+6jIuqwWMWrVQWLxRCjSDXOuTvnyvCMEn5p5nGkFg
 DUUpjiEp0FvLKCgXXd1bMFrdWVGkEiednTDFjBvPZOfr7RxUr23i3w6WEi2qIPzDl/Gd
 pQJVWc5W4JLcQ82caLdLa4R89WOAsW6RLozErM9ysjVygPBJKFy+FfB3WOxMbXtaL3NA
 Y2MA==
X-Gm-Message-State: AOJu0Yx22j/YFRUKlA/vlnxfG447sCT9yxEVmSOS8kWMrKxXaalZ8YHA
 IFhdphS5Zsz9tnEGJCg5FbSyoPBeyau/jKJ2nz90AAZIyo/iSR1A0YLGAE7R8y0xzteDZgc9vxZ
 2
X-Gm-Gg: ASbGncta3grH+zbU9ID/IOCXBveLN/WyD/Vjb33Qlq+Z3ur+jTdMekpmzlY+XqtdQ8Z
 cuYML07dzSDUn6qj3R5G0esJA4SR+SNY1m18efW1Odh6qumRHpoHYE0CCIxvWlsqLeHMDXsnNWT
 1/ijYGZrQ9k6kuvG047YWzJEOqEXF0SIW6Y63ygTpvtj2QgyQZBcX41CeXYHZXlo14eQ+MBN/Bu
 8tVlEaB2yYCcC+/1Y02WV8TpJ9Isw2z9YgatUuFjw/M6PsTkI155UeCMHh/Bw==
X-Google-Smtp-Source: AGHT+IGncxJurxxsGHHDefbTBbgDD9nMjfSz1VAywkL71pejKCVbBHfhMU3IRw01cPbakVvyktwFHg==
X-Received: by 2002:a05:600c:1c09:b0:435:edb0:5d27 with SMTP id
 5b1f17b1804b1-436230bfd93mr63250495e9.9.1734111235781; 
 Fri, 13 Dec 2024 09:33:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 79/85] target/arm: Move the AArch64 EL2 TLBI insns
Date: Fri, 13 Dec 2024 17:32:23 +0000
Message-Id: <20241213173229.3308926-80-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Move the AArch64 EL2 TLBI insn definitions that were
in el2_cp_reginfo[] across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241210160452.2427965-5-peter.maydell@linaro.org
---
 target/arm/cpregs.h        |  7 +++++
 target/arm/helper.c        | 61 ++++----------------------------------
 target/arm/tcg/tlb-insns.c | 49 ++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 55 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index a14f5bb6c98..57446ae1b52 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1146,13 +1146,20 @@ bool tlb_force_broadcast(CPUARMState *env);
 int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
                        uint64_t addr);
 int vae1_tlbbits(CPUARMState *env, uint64_t addr);
+int vae2_tlbbits(CPUARMState *env, uint64_t addr);
 int vae1_tlbmask(CPUARMState *env);
+int vae2_tlbmask(CPUARMState *env);
 int ipas2e1_tlbmask(CPUARMState *env, int64_t value);
+int e2_tlbmask(CPUARMState *env);
 void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value);
 void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value);
 void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value);
+void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value);
+void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value);
 
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cc7da7f1159..6942d2f2fb3 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4705,7 +4705,7 @@ int vae1_tlbmask(CPUARMState *env)
     return mask;
 }
 
-static int vae2_tlbmask(CPUARMState *env)
+int vae2_tlbmask(CPUARMState *env)
 {
     uint64_t hcr = arm_hcr_el2_eff(env);
     uint16_t mask;
@@ -4748,7 +4748,7 @@ int vae1_tlbbits(CPUARMState *env, uint64_t addr)
     return tlbbits_for_regime(env, mmu_idx, addr);
 }
 
-static int vae2_tlbbits(CPUARMState *env, uint64_t addr)
+int vae2_tlbbits(CPUARMState *env, uint64_t addr)
 {
     uint64_t hcr = arm_hcr_el2_eff(env);
     ARMMMUIdx mmu_idx;
@@ -4776,7 +4776,7 @@ void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
-static int e2_tlbmask(CPUARMState *env)
+int e2_tlbmask(CPUARMState *env)
 {
     return (ARMMMUIdxBit_E20_0 |
             ARMMMUIdxBit_E20_2 |
@@ -4784,15 +4784,6 @@ static int e2_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_E2);
 }
 
-static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = e2_tlbmask(env);
-
-    tlb_flush_by_mmuidx(cs, mask);
-}
-
 static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -4811,8 +4802,8 @@ void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
-static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
+void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     int mask = e2_tlbmask(env);
@@ -4828,22 +4819,6 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E3);
 }
 
-static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
-{
-    /*
-     * Invalidate by VA, EL2
-     * Currently handles both VAE2 and VALE2, since we don't support
-     * flush-last-level-only.
-     */
-    CPUState *cs = env_cpu(env);
-    int mask = vae2_tlbmask(env);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = vae2_tlbbits(env, pageaddr);
-
-    tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
-}
-
 static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -4870,7 +4845,7 @@ void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
-static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
     CPUState *cs = env_cpu(env);
@@ -6036,30 +6011,6 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
     { .name = "HTTBR", .cp = 15, .opc1 = 4, .crm = 2,
       .access = PL2_RW, .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
-    { .name = "TLBI_ALLE2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_alle2_write },
-    { .name = "TLBI_VAE2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2_write },
-    { .name = "TLBI_VALE2", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2_write },
-    { .name = "TLBI_ALLE2IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_alle2is_write },
-    { .name = "TLBI_VAE2IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
-    { .name = "TLBI_VALE2IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
-      .writefn = tlbi_aa64_vae2is_write },
 #ifndef CONFIG_USER_ONLY
     /*
      * Unlike the other EL2-related AT operations, these must
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index ff7698e31b6..1eebb6055ce 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -191,6 +191,31 @@ static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, mask);
 }
 
+static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = e2_tlbmask(env);
+
+    tlb_flush_by_mmuidx(cs, mask);
+}
+
+static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    /*
+     * Invalidate by VA, EL2
+     * Currently handles both VAE2 and VALE2, since we don't support
+     * flush-last-level-only.
+     */
+    CPUState *cs = env_cpu(env);
+    int mask = vae2_tlbmask(env);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae2_tlbbits(env, pageaddr);
+
+    tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
+}
+
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
@@ -460,6 +485,30 @@ static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
     { .name = "TLBIMVAHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
       .writefn = tlbimva_hyp_is_write },
+    { .name = "TLBI_ALLE2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_alle2_write },
+    { .name = "TLBI_VAE2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_vae2_write },
+    { .name = "TLBI_VALE2", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_vae2_write },
+    { .name = "TLBI_ALLE2IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_alle2is_write },
+    { .name = "TLBI_VAE2IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_vae2is_write },
+    { .name = "TLBI_VALE2IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EL3_NO_EL2_UNDEF,
+      .writefn = tlbi_aa64_vae2is_write },
 };
 
 void define_tlb_insn_regs(ARMCPU *cpu)
-- 
2.34.1


