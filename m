Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7F1C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhKl-0000nT-Bx; Fri, 04 Jul 2025 10:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIG-00056j-D4
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:40 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhID-0005gd-TY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:35 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso859227fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638892; x=1752243692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dTGa4kMhNDj9wa1wac77ORndiv7EhCr8PS2fgvtfjbU=;
 b=GZ2AM7Pi4yGWdye+JKA3fGB7b86UqMigLlYIdr8j4UM09DXw6Y15D7qyDwU2CDFLfH
 dNLYX0pRO5WTjwSXR82Jx9rW+VqfwHMIlce9TE1pMKV5uWqL0pqwKjExlR3D5aXsPO+D
 H1NvwMX8frtp1azlwXqBS/YGvYfF/0UC1KEkoNcM+s1XyDn4QI7MLvnZAvZ9ID/G/BUw
 DCvYvOBWmPkWU9NjnsWQcrMmdzT9idn+FsrJX5yMhbaRqcAZD8+UjYw3rJo5rfHrRW8m
 74Md5Fazv62hitISYlOvngeMPYWO7MLdW0ABiw4hGDvddbvZKIDcyak46EM8q+Ygm+Jq
 yhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638892; x=1752243692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTGa4kMhNDj9wa1wac77ORndiv7EhCr8PS2fgvtfjbU=;
 b=DhC7rxa25YtDtDLl5EAHp/WoRLGN+y5/fVpJ3XuDMM9w7IGvlry7jFo/9cc7JrErN/
 WhkhijkFB2TDqi9iGBUw/MF3U/bB96lCexutO2VPmRRl0cn1KiIpqQsR597VT3AvFIda
 /FTfYv27bSPTwblNVYazK3j4NrBUZHTY+u0nXX/dJ//6T2Rh8P0KVZykb8ADhYMDEcbQ
 yKQHx30s99YofQxpPnZTUzwf9XLlQ4gwCHD999Pu31oFTlvFqLB4NPbwYsf13W8YHqhs
 MWttYpwTR2imoWQ/d+LkUZXQxkVf7UPoQbtCo/kgLpTe/5ngJFSst5rxBTkA7jkLO9Y8
 t0JA==
X-Gm-Message-State: AOJu0Yz0RXRBp2IphvnqXpf9zVbqjZSYQQqF+v1tBmnHmoMSaT2MS8i9
 +7/ruI0w+ds1bUJlfAfjf0oyaD7Zmyf2OoXIpix5D77qm7PhtMfmM3pKBYU9p0rP8mbtb2TINL0
 8omUo7jQ=
X-Gm-Gg: ASbGncvNXUX9WJhfwh9TT4WmXD/wL+MnRaLXURGiYnQHwUTcpxAkwR17+Wi9jwHo11s
 o61VQneSPhj5t+NHyIu0OEHZZrSamblkTny46tyZV3wLtSjo34QYMItwQYzIJamqPif9IFsmowg
 InaLFN1qguOxCtAdaLwwKJD5k5kDHdueze80sJfgZlBGpIpP59iRIt+B89hCOCIL78EBjKevIta
 PCtT6kHdOM+LvKRDif/zwW6/y2hiCMKGci2rF3+xqpszFe6Y1Eq4dLZ6S6y9+LzC9okCMxgAD/h
 fz8VzkWRN1F1dcTW/p7YfdF+qehrSbTPg98mod2dgjODlEP3n3QQjxSX8/yrwJnTbyfI01PDiJ7
 6XUJXAR6MfMV5tlkgRONKHNVOsR532DKYsgvyyL/6swVJR7AC
X-Google-Smtp-Source: AGHT+IEhDfWOscyz0ed/xxzhZQpPNiLmdNPKN3CO+Z0b5I2MaEdRh0RA3I8AalyAqCT+flmcvMtH4A==
X-Received: by 2002:a05:6870:4211:b0:2eb:b4f8:fe7f with SMTP id
 586e51a60fabf-2f791d4c954mr2288251fac.11.1751638892522; 
 Fri, 04 Jul 2025 07:21:32 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 016/108] target/arm: Add zt0_excp_el to DisasContext
Date: Fri,  4 Jul 2025 08:19:39 -0600
Message-ID: <20250704142112.1018902-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Pipe the value through from SMCR_ELx through hflags and into
the disassembly context.  Enable EZT0 in smcr_write.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/translate.h     |  1 +
 target/arm/cpu.c               |  3 +++
 target/arm/helper.c            |  6 +++++-
 target/arm/tcg/hflags.c        | 34 +++++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-a64.c |  1 +
 6 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index cbc2043483..39a9234ff2 100644
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
index 0004a97219..b03956a793 100644
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
index 6265627762..08c43f674a 100644
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
index 3879bce848..b3f0d6f17a 100644
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
index 1ccec63bbd..59ab526375 100644
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
index b0caccca46..ad293c0885 100644
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


