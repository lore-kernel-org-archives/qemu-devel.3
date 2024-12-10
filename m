Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059E3E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2jg-00013F-5K; Tue, 10 Dec 2024 11:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2je-00012Q-Fw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:18 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tL2jb-0004Zc-Kw
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:05:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-434e69857d9so20179755e9.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733846714; x=1734451514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dGGSS2vQjmB7zMhjMhjsB0nPRLcLV12mDjOJEQhx1rw=;
 b=oYCKyWbbbU38IdXLNkZyofOP+0YkzuknXNwS/kBExxXNWM+Noomrvpd5s437GceX1R
 TbVJ0Va2yNWW0F3yW7vTn774hMD6EyCVqMfIpEQGeTD9dbRI2URexnu5DZstbs0a/P/d
 eGlVE9VJna0rYmEqIqD528P3nelwOYrMsTXhZhcuuaumIgAAyJv3+Oaq7Sk8S05fApqA
 Rvm1RQjClWAfutYHuULTT3W7f1G4bPEbnoINGi63xFnWWTfYW4N/fLEC0MdxqNiOaF3p
 80N1+Q5TQdS/WLCwl2FgtDQzQwMT0MVZtV/iGyp0vEJKAza7Wg2VDaHbSqZaURyVXVBP
 LawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733846714; x=1734451514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dGGSS2vQjmB7zMhjMhjsB0nPRLcLV12mDjOJEQhx1rw=;
 b=UxYbEiFcsU8sQ6hkBw68PV96JjjKxWbE95y2bFImOILD0COjnzMIuy5gQsQ3xP7YkL
 PA5BMwKew3OEXQuuQKE70yU9OMrbKrG9kHWB6qm3ZNAse4e8GCJpvYBocvwhIGVwWlqy
 fFbF2ch2PQdanMNzGWM8zsRXcuEA75aph/vh8APXmKgUO3Ny2ClRHPPOcsMJIikslQaY
 lk2YI1nqlfLXGwa0+tQ/2pGNhc255+82DMxrDCTkU8XJ2t56c683NN+fENwQAMClGODe
 fpAb/aOQXgq9/nUa8oSCni+m+9ROmRzOSv1V0cU4SHR+QyAmbLKOyJBhchgHhf/xzWI/
 5QuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGmUKLNKyo3YA0O40LFhzJeDoDua1JUgtbLAPI7fkxh0zHvIJ5vCbpqboOm9UR9nGAW4iTEqHNWEuV@nongnu.org
X-Gm-Message-State: AOJu0YwnsHQ6qJHI4GVMw9cFWm4P0IdaWur0oBxo2iAQS6r3qEMOfeph
 WTw5gh3TYqJsBAwAxJFcSHN+R11546uLFua4pkdp00sqgEe9yYxMw04XRIGSEcrFpbWkOnU3V2R
 M
X-Gm-Gg: ASbGnct6enBCxmML5zj4X+vm0KdmUIej9kV7g5ltcWgYWJ05C2VP1gPc7Nca3vq2odS
 5RsMZJhBPCcx5J0A6/Ox5bYawOGdtwAmDFwsL/je18YFFKkOLnBlwGocqP1sIIxI8fCpE+i5VF0
 4cS2J2cTwfgQOJF+HT4l0uIoKMPs/Q+z1sKkKyKGCCqQn/z8BuJlFMgGmjarQv/4HWPRt45tkOx
 hcHZ7or6gTDll5zdVcSCKKWeZFashyV28gA75FX37EqtxCF7g+wlruJ6VzJ
X-Google-Smtp-Source: AGHT+IHirj6A8Te2F/4Xmts4LaEPPBbk50kRIPjFCGkJMSWNWH7lSQocgwbiDCksOOk1IKF2s0uzdw==
X-Received: by 2002:a05:600c:45c7:b0:434:fc5d:179c with SMTP id
 5b1f17b1804b1-435021bae2bmr32822465e9.13.1733846707658; 
 Tue, 10 Dec 2024 08:05:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm124671605e9.18.2024.12.10.08.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:05:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 03/10] target/arm: Move AArch64 TLBI insns from v8_cp_reginfo[]
Date: Tue, 10 Dec 2024 16:04:45 +0000
Message-Id: <20241210160452.2427965-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210160452.2427965-1-peter.maydell@linaro.org>
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Move the AArch64 TLBI insns that are declared in v8_cp_reginfo[]
into tlb-insns.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        |  11 +++
 target/arm/helper.c        | 182 +++----------------------------------
 target/arm/tcg/tlb-insns.c | 160 ++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+), 171 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 851cd045b2c..a14f5bb6c98 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -1143,5 +1143,16 @@ CPAccessResult access_ttlb(CPUARMState *env, const ARMCPRegInfo *ri,
 CPAccessResult access_ttlbis(CPUARMState *env, const ARMCPRegInfo *ri,
                              bool isread);
 bool tlb_force_broadcast(CPUARMState *env);
+int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
+                       uint64_t addr);
+int vae1_tlbbits(CPUARMState *env, uint64_t addr);
+int vae1_tlbmask(CPUARMState *env);
+int ipas2e1_tlbmask(CPUARMState *env, int64_t value);
+void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value);
+void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value);
+void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value);
 
 #endif /* TARGET_ARM_CPREGS_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3c69225e1d9..cc7da7f1159 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4685,7 +4685,7 @@ static CPAccessResult access_tocu(CPUARMState *env, const ARMCPRegInfo *ri,
  * Page D4-1736 (DDI0487A.b)
  */
 
-static int vae1_tlbmask(CPUARMState *env)
+int vae1_tlbmask(CPUARMState *env)
 {
     uint64_t hcr = arm_hcr_el2_eff(env);
     uint16_t mask;
@@ -4721,8 +4721,8 @@ static int vae2_tlbmask(CPUARMState *env)
 }
 
 /* Return 56 if TBI is enabled, 64 otherwise. */
-static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
-                              uint64_t addr)
+int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
+                       uint64_t addr)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
     int tbi = aa64_va_parameter_tbi(tcr, mmu_idx);
@@ -4731,7 +4731,7 @@ static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
     return (tbi >> select) & 1 ? 56 : 64;
 }
 
-static int vae1_tlbbits(CPUARMState *env, uint64_t addr)
+int vae1_tlbbits(CPUARMState *env, uint64_t addr)
 {
     uint64_t hcr = arm_hcr_el2_eff(env);
     ARMMMUIdx mmu_idx;
@@ -4767,8 +4767,8 @@ static int vae2_tlbbits(CPUARMState *env, uint64_t addr)
     return tlbbits_for_regime(env, mmu_idx, addr);
 }
 
-static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                      uint64_t value)
+void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     int mask = vae1_tlbmask(env);
@@ -4776,19 +4776,6 @@ static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
 }
 
-static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = vae1_tlbmask(env);
-
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
-    } else {
-        tlb_flush_by_mmuidx(cs, mask);
-    }
-}
-
 static int e2_tlbmask(CPUARMState *env)
 {
     return (ARMMMUIdxBit_E20_0 |
@@ -4797,15 +4784,6 @@ static int e2_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_E2);
 }
 
-static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                  uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = alle1_tlbmask(env);
-
-    tlb_flush_by_mmuidx(cs, mask);
-}
-
 static void tlbi_aa64_alle2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
@@ -4824,8 +4802,8 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E3);
 }
 
-static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
+void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     int mask = alle1_tlbmask(env);
@@ -4881,8 +4859,8 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E3);
 }
 
-static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                   uint64_t value)
+void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
 {
     CPUState *cs = env_cpu(env);
     int mask = vae1_tlbmask(env);
@@ -4892,27 +4870,6 @@ static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
 }
 
-static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                 uint64_t value)
-{
-    /*
-     * Invalidate by VA, EL1&0 (AArch64 version).
-     * Currently handles all of VAE1, VAAE1, VAALE1 and VALE1,
-     * since we don't support flush-for-specific-ASID-only or
-     * flush-last-level-only.
-     */
-    CPUState *cs = env_cpu(env);
-    int mask = vae1_tlbmask(env);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-    int bits = vae1_tlbbits(env, pageaddr);
-
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
-    } else {
-        tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
-    }
-}
-
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
@@ -4935,7 +4892,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                                   ARMMMUIdxBit_E3, bits);
 }
 
-static int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
+int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
 {
     /*
      * The MSB of value is the NS field, which only applies if SEL2
@@ -4948,30 +4905,6 @@ static int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
             : ARMMMUIdxBit_Stage2);
 }
 
-static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                    uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = ipas2e1_tlbmask(env, value);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-
-    if (tlb_force_broadcast(env)) {
-        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
-    } else {
-        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
-    }
-}
-
-static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                                      uint64_t value)
-{
-    CPUState *cs = env_cpu(env);
-    int mask = ipas2e1_tlbmask(env, value);
-    uint64_t pageaddr = sextract64(value << 12, 0, 56);
-
-    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
-}
-
 #ifdef TARGET_AARCH64
 typedef struct {
     uint64_t base;
@@ -5462,99 +5395,6 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 14, .opc2 = 2,
       .fgt = FGT_DCCISW,
       .access = PL1_W, .accessfn = access_tsw, .type = ARM_CP_NOP },
-    /* TLBI operations */
-    { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVMALLE1IS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIASIDE1IS,
-      .writefn = tlbi_aa64_vmalle1is_write },
-    { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAAE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVALE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VAALE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAALE1IS,
-      .writefn = tlbi_aa64_vae1is_write },
-    { .name = "TLBI_VMALLE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVMALLE1,
-      .writefn = tlbi_aa64_vmalle1_write },
-    { .name = "TLBI_VAE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_ASIDE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIASIDE1,
-      .writefn = tlbi_aa64_vmalle1_write },
-    { .name = "TLBI_VAAE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAAE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_VALE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVALE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_VAALE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
-      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
-      .fgt = FGT_TLBIVAALE1,
-      .writefn = tlbi_aa64_vae1_write },
-    { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1is_write },
-    { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1is_write },
-    { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_VMALLS12E1IS", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
-    { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1_write },
-    { .name = "TLBI_IPAS2LE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_ipas2e1_write },
-    { .name = "TLBI_ALLE1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1_write },
-    { .name = "TLBI_VMALLS12E1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
-      .writefn = tlbi_aa64_alle1is_write },
 #ifndef CONFIG_USER_ONLY
     /* 64 bit address translation operations */
     { .name = "AT_S1E1R", .state = ARM_CP_STATE_AA64,
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 66096093dcc..ff7698e31b6 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -169,6 +169,73 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
 }
 
+static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, mask);
+    } else {
+        tlb_flush_by_mmuidx(cs, mask);
+    }
+}
+
+static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                  uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = alle1_tlbmask(env);
+
+    tlb_flush_by_mmuidx(cs, mask);
+}
+
+static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                 uint64_t value)
+{
+    /*
+     * Invalidate by VA, EL1&0 (AArch64 version).
+     * Currently handles all of VAE1, VAAE1, VAALE1 and VALE1,
+     * since we don't support flush-for-specific-ASID-only or
+     * flush-last-level-only.
+     */
+    CPUState *cs = env_cpu(env);
+    int mask = vae1_tlbmask(env);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+    int bits = vae1_tlbbits(env, pageaddr);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr, mask, bits);
+    } else {
+        tlb_flush_page_bits_by_mmuidx(cs, pageaddr, mask, bits);
+    }
+}
+
+static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                    uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = ipas2e1_tlbmask(env, value);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+
+    if (tlb_force_broadcast(env)) {
+        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+    } else {
+        tlb_flush_page_by_mmuidx(cs, pageaddr, mask);
+    }
+}
+
+static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                      uint64_t value)
+{
+    CPUState *cs = env_cpu(env);
+    int mask = ipas2e1_tlbmask(env, value);
+    uint64_t pageaddr = sextract64(value << 12, 0, 56);
+
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, mask);
+}
+
 static const ARMCPRegInfo tlbi_not_v7_cp_reginfo[] = {
     /*
      * MMU TLB control. Note that the wildcarding means we cover not just
@@ -277,6 +344,99 @@ static const ARMCPRegInfo tlbi_v8_cp_reginfo[] = {
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
       .writefn = tlbiipas2is_hyp_write },
+    /* AArch64 TLBI operations */
+    { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVMALLE1IS,
+      .writefn = tlbi_aa64_vmalle1is_write },
+    { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAE1IS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIASIDE1IS,
+      .writefn = tlbi_aa64_vmalle1is_write },
+    { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAAE1IS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVALE1IS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_VAALE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
+      .access = PL1_W, .accessfn = access_ttlbis, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAALE1IS,
+      .writefn = tlbi_aa64_vae1is_write },
+    { .name = "TLBI_VMALLE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVMALLE1,
+      .writefn = tlbi_aa64_vmalle1_write },
+    { .name = "TLBI_VAE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 1,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAE1,
+      .writefn = tlbi_aa64_vae1_write },
+    { .name = "TLBI_ASIDE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 2,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIASIDE1,
+      .writefn = tlbi_aa64_vmalle1_write },
+    { .name = "TLBI_VAAE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 3,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAAE1,
+      .writefn = tlbi_aa64_vae1_write },
+    { .name = "TLBI_VALE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVALE1,
+      .writefn = tlbi_aa64_vae1_write },
+    { .name = "TLBI_VAALE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 7,
+      .access = PL1_W, .accessfn = access_ttlb, .type = ARM_CP_NO_RAW,
+      .fgt = FGT_TLBIVAALE1,
+      .writefn = tlbi_aa64_vae1_write },
+    { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ipas2e1is_write },
+    { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ipas2e1is_write },
+    { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle1is_write },
+    { .name = "TLBI_VMALLS12E1IS", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 6,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle1is_write },
+    { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ipas2e1_write },
+    { .name = "TLBI_IPAS2LE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_ipas2e1_write },
+    { .name = "TLBI_ALLE1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 4,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle1_write },
+    { .name = "TLBI_VMALLS12E1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
+      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .writefn = tlbi_aa64_alle1is_write },
 };
 
 static const ARMCPRegInfo tlbi_el2_cp_reginfo[] = {
-- 
2.34.1


