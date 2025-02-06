Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2781EC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80X-0007RP-Nv; Thu, 06 Feb 2025 14:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80A-0007CT-QF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:30 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg808-0000V4-Os
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:30 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21ddab8800bso19535915ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871847; x=1739476647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDH/8N+x01y22FOds0NZm9KcrEUf3p/25H8MY3Hpnm0=;
 b=j4/eAC70Nfz4e2RPRH0q4MFIwvhFe18ljC7tol+Pi/TRYWmfi7QA7mAPZos8SUEY/N
 Sp+jRH+97it8OlbD174wuwyKfSOSodx0fNmx4NoQuI5VDrKDjZMEx5vicbaEPqiACuPd
 8foviLWh9/IrAbrf5X2uPv/PDElTyJB8uTZFUAbNxSZwdzBZvsBgwFMVgxfucShRPM4t
 5Yt0K8Bqa5yDC0M77hsUF30/nYa/5SKh/68L6LmOdROmqNjWpOWevDLHS8+bCvcK3+nS
 JTwpOjZ9HI9qt8onNLTKreLQEjJieko8U7JfNzr/obG7nBMcs7QvukyPfXrEnQO+xcJ7
 uq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871847; x=1739476647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDH/8N+x01y22FOds0NZm9KcrEUf3p/25H8MY3Hpnm0=;
 b=Gb9DsIAgVFoCHFOAQ3rHFwr+gJtXT6SyNJr6zaWMG1RmxDonwrHRNIFVJYo71QZp78
 hQNNpHUXSjknnvKl+QkTii753/DmG+I8s42hnbZNlcEfpCsLfAwn8zu8FSNUbABKrloB
 Br3K9UV44rU7Apm3SX7FXPwPZkJhaT/p63CZIy7thK6hdLIjJMyyI13/npl3IzTnghX+
 vaQWn9t6HSYtDUssMSZ1w3Ic6/Opict3fEalpZrrbaYLNqh5qvjO46aixlZQYmiEJ3te
 3zhGRl649moeeRliPF70kBr2k6eATHcP1Q4jGOCaOuyrhLyaSU66QiVeAbseoPYBLiWu
 MTxQ==
X-Gm-Message-State: AOJu0YwjkrACabyoXw1S/vpsGZz9ycpYYjPl6wkVCd78v92mbfKg+WjX
 I7NQ7w/7bt8e4KZmb70lITSCRKQKRmMPfvCaj2aMmKZIVR/797tgu5ou0R1ORi2GCs4u5ioTday
 q
X-Gm-Gg: ASbGncvJqF37U2qNtIpPFQ3P9wgKWpYRgLvnf0frJIEswtbeuL1hJluXo1JWlPXs85+
 e4nDU6KXdRwqUVG5D26m6JBeDEXoII0mliYODw6QsNB+LBL1/WcxCXAZapTJmpC3y63F6bnllCi
 z13lfTwqrm5ihx46MY5AHUz8n2esTPGORoBFBjwOPGvX7bD+vObGZWqk1iDfgoMdzPuF8FOVTun
 h2QdB9f7rWbCTouKSjgIEcqh080wRbksPMPzLKctsInvllr4wnVLWG25vgJaXHxhKe/ckqwnluB
 ORKR4Gq0b32B8HVGU4CAfHmFaXx+3I8jbh3meE3dVCPmMhM=
X-Google-Smtp-Source: AGHT+IF4+r/aDnsb7/UHoC4XX9rDoOi165GEESPhF75ANUEaJ7I5s7n4xIHJDovnrsLOlYJ8e8d/hQ==
X-Received: by 2002:a05:6a00:1884:b0:730:5c3e:8f0 with SMTP id
 d2e1a72fcca58-7305d44979amr917760b3a.6.1738871847151; 
 Thu, 06 Feb 2025 11:57:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/61] target/arm: Add zt0_excp_el to DisasContext
Date: Thu,  6 Feb 2025 11:56:28 -0800
Message-ID: <20250206195715.2150758-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Pipe the value through from SMCR_ELx through hflags
and into the disassembly context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  2 ++
 target/arm/tcg/translate.h     |  1 +
 target/arm/cpu.c               |  3 +++
 target/arm/tcg/hflags.c        | 34 +++++++++++++++++++++++++++++++++-
 target/arm/tcg/translate-a64.c |  1 +
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 091a517a93..61f959af8b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1531,6 +1531,7 @@ FIELD(SVCR, ZA, 1, 1)
 
 /* Fields for SMCR_ELx. */
 FIELD(SMCR, LEN, 0, 4)
+FIELD(SMCR, EZT0, 30, 1)
 FIELD(SMCR, FA64, 31, 1)
 
 /* Write a new value to v7m.exception, thus transitioning into or out
@@ -3240,6 +3241,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
+FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f8dc2f0d4b..3021902ce1 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -71,6 +71,7 @@ typedef struct DisasContext {
     int fp_excp_el; /* FP exception EL or 0 if enabled */
     int sve_excp_el; /* SVE exception EL or 0 if enabled */
     int sme_excp_el; /* SME exception EL or 0 if enabled */
+    int zt0_excp_el; /* ZT0 exception EL or 0 if enabled */
     int vl;          /* current vector length in bytes */
     int svl;         /* current streaming vector length in bytes */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 813cb45276..0cbc3b10c2 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -631,6 +631,9 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
                 env->cp15.cptr_el[3] |= R_CPTR_EL3_ESM_MASK;
                 env->cp15.scr_el3 |= SCR_ENTP2;
                 env->vfp.smcr_el[3] = 0xf;
+                if (cpu_isar_feature(aa64_sme2, cpu)) {
+                    env->vfp.smcr_el[3] |= R_SMCR_EZT0_MASK;
+                }
             }
             if (cpu_isar_feature(aa64_hcx, cpu)) {
                 env->cp15.scr_el3 |= SCR_HXEN;
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 9e6a1869f9..e8823c380f 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -201,6 +201,31 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
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
@@ -256,7 +281,14 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index 1ee57ebf66..bc96cee273 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10143,6 +10143,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
     dc->sve_excp_el = EX_TBFLAG_A64(tb_flags, SVEEXC_EL);
     dc->sme_excp_el = EX_TBFLAG_A64(tb_flags, SMEEXC_EL);
+    dc->zt0_excp_el = EX_TBFLAG_A64(tb_flags, ZT0EXC_EL);
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
-- 
2.43.0


