Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766D5C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEE-0008UE-ME; Fri, 04 Jul 2025 12:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEC-0008Sq-VR
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:32 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEA-0006Au-Fq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so7306895e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646329; x=1752251129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oKJajPVNDiBfbKBnnOuTzq+dn0t+mh0UzlVR45H+DLw=;
 b=knqimNeG+h6yAIiapTRSSinF+TGmXw9LhGzHAAVCIK4v9on4bIqEj0ShbDfrAWKEwM
 R7GHvfnCAsVohdE0TNKjClHgOrm1SrtwvaGoO7iGvFYfGpbZmwHplFGnwHDFO3VsgZj5
 hUitvA6nRrC1TJBxiEcu3higRQauK3bkDm+geeyN6XwI66D3LhqgKCDTPrThKERzvNO/
 lzCjdCy0MEDr+aj23y1KLRfboZ9BzHuGucBkvkvDJhQz2sqCWXItB9tqDvM5SNsJ7QOi
 pDiLfjsYMSg/Bj7X6mbZlWVYoEJVzQG6KQQmVYqsHhAMpI8s6AnC1eSQtkQBaXB8985I
 026g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646329; x=1752251129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oKJajPVNDiBfbKBnnOuTzq+dn0t+mh0UzlVR45H+DLw=;
 b=kleTGQGiPJFGZkVVnE4YLll51H8cYkXaSzppgjiBXB2mqUfk2gFc3lCX2TyLmcc2JC
 hnG+XQB+UC0TInHmNrh7wHsUKeurUr2INRST/G8LEKus5ajE0EYxGhvihTzIp8tcUrhM
 pyG5kC5gSBJYza5fsRIpJT6KW7YYxcgrLehAiqSd7YLkshSKf7jM22VMHrQYQdSSQs7S
 o5Kov0jrMW2aucrkTLcZxeIJLmwKo+p2ar9UKuuM//JS4XE+Gt43OPoLtcPctxEUMT9Y
 aBPrAHsOFlA3B1Iowl5Ww75/neH20z308vFBGdDMxvTqwkZw/zBwEdEpYN+e7srnzxD4
 eesA==
X-Gm-Message-State: AOJu0YyIG8f6034qH/gK921hiGEaqVfG82erd6PvLEAk5+605OzE0oXx
 qoAuT/FgO/rODHXODhf6Q5WruW1ug1Znr/UC5dpmN8cW/X1cz+0qeYkp57THMyrdGqQmYt6fS4i
 y1UH0
X-Gm-Gg: ASbGncsPMfMgMSJi3VBBIG4x8vBOi1yDdpDX+BX+AADDrxASKJN9e2223FA8GScwGCG
 hs9m1UkQMb8vjvmrrgX2KiTYbto0mxF4fiiZxIjksrMhHm4c88/iHlorEMODSFXBaztQTUKT6Kh
 HyWfCIA2Kuu9T8uyFWo+iK1TnAZN4rBawIwSmU+O6AhkYpel+A0siDRDmysZqMTfTLV/6lFA9NX
 m4HWUw7g+CbSIemTEP4KZdD6LfnPDkfm1e1KSOoyOcq4FE0pe8O4nQW24LHFayNdCt0lkJHWn0C
 Dah6kRt81SeDiSt1lWoZqPlcSpsmyAPadUTsRUvXQLw7GwJxdggS2pEsRf6pYQxixOfH
X-Google-Smtp-Source: AGHT+IH9pn28oN5TDzdIacOObSEE+Q+rNEPLkXjkJUkLUJjybSElrDeASVAL4CwRugL9f/rDXpwqSA==
X-Received: by 2002:a05:600c:46c8:b0:43d:563:6fef with SMTP id
 5b1f17b1804b1-454b9f2f337mr917955e9.21.1751646328792; 
 Fri, 04 Jul 2025 09:25:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 028/119] target/arm: Add zt0_excp_el to DisasContext
Date: Fri,  4 Jul 2025 17:23:28 +0100
Message-ID: <20250704162501.249138-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Pipe the value through from SMCR_ELx through hflags and into
the disassembly context.  Enable EZT0 in smcr_write.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-17-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/translate.h     |  1 +
 target/arm/cpu.c               |  3 +++
 target/arm/helper.c            |  6 +++++-
 target/arm/tcg/hflags.c        | 34 +++++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-a64.c |  1 +
 6 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cbc20434836..39a9234ff28 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1513,6 +1513,7 @@ FIELD(SVCR, ZA, 1, 1)
 
 /* Fields for SMCR_ELx. */
 FIELD(SMCR, LEN, 0, 4)
+FIELD(SMCR, EZT0, 30, 1)
 FIELD(SMCR, FA64, 31, 1)
 
 /* Write a new value to v7m.exception, thus transitioning into or out
@@ -3084,6 +3085,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
+FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 0004a97219b..b03956a7937 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -70,6 +70,7 @@ typedef struct DisasContext {
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
     int sme_excp_el; /* SME exception EL or 0 if enabled */
+    int zt0_excp_el; /* ZT0 exception EL or 0 if enabled */
     int vl;          /* current vector length in bytes */
     int svl;         /* current streaming vector length in bytes */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 62656277625..08c43f674a2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -635,6 +635,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
                 env->cp15.cptr_el[3] |= R_CPTR_EL3_ESM_MASK;
                 env->cp15.scr_el3 |= SCR_ENTP2;
                 env->vfp.smcr_el[3] = 0xf;
+                if (cpu_isar_feature(aa64_sme2, cpu)) {
+                    env->vfp.smcr_el[3] |= R_SMCR_EZT0_MASK;
+                }
             }
             if (cpu_isar_feature(aa64_hcx, cpu)) {
                 env->cp15.scr_el3 |= SCR_HXEN;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3879bce8489..b3f0d6f17a8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6682,10 +6682,14 @@ static void smcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     int cur_el = arm_current_el(env);
     int old_len = sve_vqm1_for_el(env, cur_el);
+    uint64_t valid_mask = R_SMCR_LEN_MASK | R_SMCR_FA64_MASK;
     int new_len;
 
     QEMU_BUILD_BUG_ON(ARM_MAX_VQ > R_SMCR_LEN_MASK + 1);
-    value &= R_SMCR_LEN_MASK | R_SMCR_FA64_MASK;
+    if (cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
+        valid_mask |= R_SMCR_EZT0_MASK;
+    }
+    value &= valid_mask;
     raw_write(env, ri, value);
 
     /*
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 1ccec63bbd4..59ab5263753 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -214,6 +214,31 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
     return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
 }
 
+/*
+ * Return the exception level to which exceptions should be taken for ZT0.
+ * C.f. the ARM pseudocode function CheckSMEZT0Enabled, after the ZA check.
+ */
+static int zt0_exception_el(CPUARMState *env, int el)
+{
+#ifndef CONFIG_USER_ONLY
+    if (el <= 1
+        && !el_is_in_host(env, el)
+        && !FIELD_EX64(env->vfp.smcr_el[1], SMCR, EZT0)) {
+        return 1;
+    }
+    if (el <= 2
+        && arm_is_el2_enabled(env)
+        && !FIELD_EX64(env->vfp.smcr_el[2], SMCR, EZT0)) {
+        return 2;
+    }
+    if (arm_feature(env, ARM_FEATURE_EL3)
+        && !FIELD_EX64(env->vfp.smcr_el[3], SMCR, EZT0)) {
+        return 3;
+    }
+#endif
+    return 0;
+}
+
 static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
@@ -269,7 +294,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
             DP_TBFLAG_A64(flags, PSTATE_SM, 1);
             DP_TBFLAG_A64(flags, SME_TRAP_NONSTREAMING, !sme_fa64(env, el));
         }
-        DP_TBFLAG_A64(flags, PSTATE_ZA, FIELD_EX64(env->svcr, SVCR, ZA));
+
+        if (FIELD_EX64(env->svcr, SVCR, ZA)) {
+            DP_TBFLAG_A64(flags, PSTATE_ZA, 1);
+            if (cpu_isar_feature(aa64_sme2, env_archcpu(env))) {
+                int zt0_el = zt0_exception_el(env, el);
+                DP_TBFLAG_A64(flags, ZT0EXC_EL, zt0_el);
+            }
+        }
     }
 
     sctlr = regime_sctlr(env, stage1);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b0caccca46e..ad293c08858 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10139,6 +10139,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
     dc->sve_excp_el = EX_TBFLAG_A64(tb_flags, SVEEXC_EL);
     dc->sme_excp_el = EX_TBFLAG_A64(tb_flags, SMEEXC_EL);
+    dc->zt0_excp_el = EX_TBFLAG_A64(tb_flags, ZT0EXC_EL);
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
-- 
2.43.0


