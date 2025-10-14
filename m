Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F060CCD195
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJz-0002er-80; Tue, 14 Oct 2025 16:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJp-0002UK-AT
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ7-0005Nt-5E
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-279e2554c8fso59003925ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472457; x=1761077257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMECpVU5E9kzsZb98t3Yw5ZuCGjt7ssQd/wUmdpWVR4=;
 b=b5AGGD3NnK5RKtoYoinLlaCiNX9MjhSLDwg2z1wdL4esIvTvcrCAzH8T8Wb4avCoZq
 8G76/cC88oCkcwg3KBo6oxmpKBZTidrz6EqTdXAKEfAQIkzCdgrjNxZ2D+nltaqSEIP2
 zwGkychOhN8Qo/RSCQ8tYvK14JS2w/ComCsHWE2Q5ZnKxCWhE2seqwFHa78ck+7AE4eu
 MqAeCY0Z+0NS3E2J82gokLG++EvtH5wv1bcyDDa4zRrDF8pqiFFRVVjJDC6hOxgfbIRk
 9S2JxRNFgrM9couC6wkVvmtFqHRqHoKvY3nAoj5aIAYZDIaBS/hR7ZrGNOOFGGWxv8ES
 vaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472457; x=1761077257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMECpVU5E9kzsZb98t3Yw5ZuCGjt7ssQd/wUmdpWVR4=;
 b=rlfRmb2dj0f0IrawX4GA5V9CNTLKi7tAuTEQQFKVLnQJ6imfej+lPCCLW0Qn3ghYNp
 668RCFEP19h5MKo4smGwrM6WxZYWks3mowv1cDRpjiQVZ64iZxZhCtiOoMSlppAv86HE
 EBljyJUNlaNecVeo4wiWVHFXRmsTQwLqTGxP5hQbZW/jBay6hGOTMVPdc83zl5qoXoxu
 tCacpE5sMLKFRnSlt7079pVs7EpKP0r+XE6NJGKtC5/t28gOJrCAL0/Fdr7jTIexaq16
 jd36pYggM5+G6eOKI1malC+kgBz/xoX3qRdcmS1vK03fZxRS06iIdhXpk2EVALfOV0o0
 +Euw==
X-Gm-Message-State: AOJu0YzyKalI4jSTVuSyDdNedPmcanZFUFy2MZGMVztSQo6EZ1r5iLr7
 mmOaho82eL43OZCgO7TQ/65zm1sTIQ0AjYbhJSXXNhtFwONi2dagO2LI3XRG4MXMjFMS75ZGx8e
 G/hqbt8Y=
X-Gm-Gg: ASbGnctejXcaHox/HFUENG2h3D0NyUyJX2sAVNunaq8bJRMISVLs5CZc35T67m+jarG
 KHsoowJOVUxJcp57ncjLXVIBOawj7BM82myQ1SmfAoqDVOm13Is3Ur2JiKO5zbVYywYXd8BnDsv
 zg+xkP4iZ2EHoJri+WYmKnwUCw22hCB9SqF2hVAF3xoriXkmMFN0ikRHMrxjiLHB5/eJz7Fv51U
 wPiLmgm7qJGE7D3OBAcoMwVvSbAjjt6Hg+T3Q1aO38pYPPIOaXR+bK79P16E7Fz66vJ3QF1+Rw5
 GD5kw1j6p8mTQ/Iw7RPN9AHQurXfKmxHczn+cRO/d5uZUzZHRYbceDixe8yimbMwb+Dp6gL+HXG
 8cXN63Kn2mGb/546EAfGPONEn/Xl4c9akzwQAfJUxe7QijB9pvLURW4U2JRCSsQ==
X-Google-Smtp-Source: AGHT+IEhcBe99nc3sobaQStPgf0BZXkuHu9ROVxwE9WLhcbEnCJgYNSl0yl/wXugfRXS4Fc6QPro0A==
X-Received: by 2002:a17:902:c410:b0:288:e46d:b325 with SMTP id
 d9443c01a7336-290272e1b7bmr391495045ad.43.1760472457131; 
 Tue, 14 Oct 2025 13:07:37 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 25/37] target/arm: Extend TTBR system registers to 128-bit
Date: Tue, 14 Oct 2025 13:07:06 -0700
Message-ID: <20251014200718.422022-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

So far, just extend the data type and check access; do not yet
consume the 128-bit table format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  9 +++--
 target/arm/helper.c | 83 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e03d832717..65037f1dd3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -344,7 +344,8 @@ typedef struct CPUArchState {
         uint64_t cptr_el[4];  /* ARMv8 feature trap registers */
         uint64_t sder; /* Secure debug enable register. */
         uint32_t nsacr; /* Non-secure access control register. */
-        union { /* MMU translation table base 0. */
+        /* MMU translation table bases. */
+        union {
             struct {
                 uint64_t _unused_ttbr0_0;
                 uint64_t ttbr0_ns;
@@ -353,7 +354,7 @@ typedef struct CPUArchState {
             };
             uint64_t ttbr0_el[4];
         };
-        union { /* MMU translation table base 1. */
+        union {
             struct {
                 uint64_t _unused_ttbr1_0;
                 uint64_t ttbr1_ns;
@@ -364,6 +365,10 @@ typedef struct CPUArchState {
         };
         uint64_t vttbr_el2; /* Virtualization Translation Table Base.  */
         uint64_t vsttbr_el2; /* Secure Virtualization Translation Table. */
+        /* High 64 bits of 128-bit Translation Table Bases. */
+        uint64_t ttbr0_el_hi[4];
+        uint64_t ttbr1_el_hi[4];
+        uint64_t vttbr_el2_hi;
         /* MMU translation table base control. */
         uint64_t tcr_el[4];
         uint64_t tcr2_el[3];
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2b55e219c2..90a940aeb9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -108,10 +108,6 @@ void raw_write128(CPUARMState *env, const ARMCPRegInfo *ri,
     CPREG_FIELD128_H64(env, ri) = valuehi;
 }
 
-#undef CPREG_FIELD32
-#undef CPREG_FIELD64
-#undef CPREG_FIELD128_H64
-
 static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     return (char *)env + ri->fieldoffset;
@@ -522,6 +518,16 @@ static CPAccessResult access_d128(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_tvm_trvm_d128(CPUARMState *env,
+                                           const ARMCPRegInfo *ri, bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret == CP_ACCESS_OK) {
+        ret = access_d128(env, ri, isread);
+    }
+    return ret;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -2932,7 +2938,7 @@ static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void flush_if_asid_change(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t new, unsigned mask)
 {
-    uint64_t old = raw_read(env, ri);
+    uint64_t old = CPREG_FIELD64(env, ri);
 
     /* The ASID or VMID is in bits [63:48]. */
     if ((old ^ new) >> 48) {
@@ -2961,6 +2967,16 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vmsa_ttbr_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t vallo, uint64_t valhi)
+{
+    flush_if_asid_change(env, ri, vallo,
+                         ARMMMUIdxBit_E10_1 |
+                         ARMMMUIdxBit_E10_1_PAN |
+                         ARMMMUIdxBit_E10_0);
+    raw_write128(env, ri, vallo, valhi);
+}
+
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
@@ -2981,6 +2997,18 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vmsa_tcr_ttbr_el2_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       uint64_t vallo, uint64_t valhi)
+{
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        flush_if_asid_change(env, ri, vallo,
+                             ARMMMUIdxBit_E20_2 |
+                             ARMMMUIdxBit_E20_2_PAN |
+                             ARMMMUIdxBit_E20_0);
+    }
+    raw_write128(env, ri, vallo, valhi);
+}
+
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -2992,6 +3020,13 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vttbr_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t vallo, uint64_t valhi)
+{
+    flush_if_asid_change(env, ri, vallo, alle1_tlbmask(env));
+    raw_write128(env, ri, vallo, valhi);
+}
+
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
     { .name = "DFSR", .cp = 15, .crn = 5, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm, .type = ARM_CP_ALIAS,
@@ -3339,26 +3374,35 @@ static void define_ttbr_registers(ARMCPU *cpu)
         { .name = "TTBR0_EL1", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
           .access = PL1_RW, .accessfn = access_tvm_trvm,
-          .fgt = FGT_TTBR0_EL1,
+          .access128fn = access_tvm_trvm_d128,
+          .fgt = FGT_TTBR0_EL1, .type = ARM_CP_128BIT,
           .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
           .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 0),
           .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 0),
           .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[1]) },
+          .write128fn = vmsa_ttbr_write128, .raw_write128fn = raw_write128,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[1]),
+          .fieldoffsethi = offsetof(CPUARMState, cp15.ttbr0_el_hi[1]) },
         { .name = "TTBR1_EL1", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
           .access = PL1_RW, .accessfn = access_tvm_trvm,
-          .fgt = FGT_TTBR1_EL1,
+          .access128fn = access_tvm_trvm_d128,
+          .fgt = FGT_TTBR1_EL1, .type = ARM_CP_128BIT,
           .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
           .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 1),
           .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 1),
           .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[1]) },
+          .write128fn = vmsa_ttbr_write128, .raw_write128fn = raw_write128,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[1]),
+          .fieldoffsethi = offsetof(CPUARMState, cp15.ttbr1_el_hi[1]) },
         { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-          .access = PL2_RW, .resetvalue = 0,
+          .access = PL2_RW, .access128fn = access_d128, .type = ARM_CP_128BIT,
           .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
+          .write128fn = vmsa_tcr_ttbr_el2_write128,
+          .raw_write128fn = raw_write128,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]),
+          .fieldoffsethi = offsetof(CPUARMState, cp15.ttbr0_el_hi[2]) },
         { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
           .access = PL3_RW, .resetvalue = 0,
@@ -4548,9 +4592,13 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .writefn = vttbr_write, .raw_writefn = raw_write },
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
-      .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
+      .type = ARM_CP_128BIT,
+      .access = PL2_RW, .access128fn = access_d128,
+      .writefn = vttbr_write, .raw_writefn = raw_write,
+      .write128fn = vttbr_write128, .raw_write128fn = raw_write128,
       .nv2_redirect_offset = 0x20,
-      .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
+      .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2),
+      .fieldoffsethi = offsetof(CPUARMState, cp15.vttbr_el2_hi) },
     { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 0, .opc2 = 0,
       .access = PL2_RW, .raw_writefn = raw_write, .writefn = sctlr_write,
@@ -6196,9 +6244,12 @@ static const ARMCPRegInfo contextidr_el2 = {
 static const ARMCPRegInfo vhe_reginfo[] = {
     { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
-      .raw_writefn = raw_write,
-      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
+      .type = ARM_CP_128BIT,
+      .access = PL2_RW, .access128fn = access_d128,
+      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
+      .write128fn = vmsa_tcr_ttbr_el2_write128, .raw_write128fn = raw_write128,
+      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]),
+      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el_hi[2]) },
 #ifndef CONFIG_USER_ONLY
     { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
-- 
2.43.0


