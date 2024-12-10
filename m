Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35281E77182
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jj-00014W-7o; Tue, 10 Dec 2024 11:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jg-00013P-63
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jd-0004Zl-DD
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434e398d28cso24814175e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846715; x=1734451515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d7uRkzzQifI4WDEGTtVmrinkfENs240FiQP++Jgs7pU=;
 b=g5EQ+qbumOF3+Yyoa+i0BVPYKkuMuCD+hcBZCgv+RpVDAH5nz+Jwe5dN3eI7wfOHnM
 PVSZuUJBAIGCD6TUTCZpDiaoNLldbeatr0MckEzB7lEmLr+AX8KePtNuNsLS1m4WJs57
 qZA0FkBhxbpgj35YelLo3+nu+IYgb+9zYg7Yf42qtyvRHwmTrn050lrO0UlhBihEFVm+
 T7T45n5wSpUsvSCybbtIk7AgXhlXMV3YhwFm9HthfCSTMmEj1PYENwwWxSkUNlAFZiC5
 XAqGr5xPGWCBxheHd8K8tQrrQjCVShIfIG1P8pHRV1XLhUGD2HARCsCSn7/NxsZrQKB/
 qkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846715; x=1734451515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7uRkzzQifI4WDEGTtVmrinkfENs240FiQP++Jgs7pU=;
 b=bbD9QJmr3C/fYhjB6ifwUsnFnr2+AeLqHAP+Rk/KeVsITispEID5jqeL8RYr7m1fCH
 cELP0auuQKObIyZLoJ4DB2X6D85X6xmPYj9C73ZEQPXpa0ut1d2k3lquNrdm1dFXbbFM
 zFZZjh1E8h9ZsY6NZsUxq1VG4ELCm4VsUlZUAeAXNQ4kG9bzPV9+myh7Bork2tZV4Wuz
 MlZWtRQE9neaKGKkqGQIGR3ZZFcItRUDr+7n3O6ov7vyG5UF+U9xvkvtFe3HBLNGgXMb
 jjZeatmknytCDl1zDTuzqSihPdslnwXgarobNTDL+7xb1FmfwLgZC0rMZI1xXAdPKMsN
 83wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnmskYIRv/tTenEFYDRNrdWXkSlETVCsGQu7q+cgg+Ffti4Ybda8uC/P/Epiyc1c3A+YSB5DwXs0Ur@nongnu.org
X-Gm-Message-State: AOJu0YzEmQng4KmH0gO3kfR+4nOSPrh5L/GzPDN1VWo68JomhLArScGp
 k6ghDI3J3oVkBPdjhTVmdBf8eNFtrK/ULObDmuas6P1HtiIPH4XXEjWvge/zqGFpGDSp04EeKta
 K
X-Gm-Gg: ASbGncvvK0aDl4pehYwSoVKjjm/iEQogLjLc3vqkeP40vQ+p67WktloOR4tAk5DNmv0
 M1Ef+u1DT0IOtl4DDzrvwzrpyTLCRABnhlzzJg/opNW1xQL4iMPsKZwIUqZdGYuCn+vIm3OI6Yo
 ADm11ynbls28p+2ZVeAOEK+GVoUq0VVPVoJ3u4/+gYyr/FaVmq6PIa3tfZLiiltWteE7L8nb/Zg
 GA34bl+Xl6hH6iVbNzCdcUqzx8ztHYwyZoS/JGkI9c/4mJiP7DOIUWty681
X-Google-Smtp-Source: AGHT+IFlIu6TAePwklkDgZubYLJQh6ePLOJX9v7Z0DVH+MGwfyP2X38FVxhpR/RyoqxvWNZYvRfscQ==
X-Received: by 2002:a05:600c:35d1:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-434fff42690mr43486095e9.9.1733846714661; 
 Tue, 10 Dec 2024 08:05:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/10] target/arm: Move the AArch64 EL2 TLBI insns
Date: Tue, 10 Dec 2024 16:04:46 +0000
Message-Id: <20241210160452.2427965-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Move the AArch64 EL2 TLBI insn definitions that were
in el2_cp_reginfo[] across to tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


