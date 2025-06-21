Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55041C7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z8-000587-0W; Sat, 21 Jun 2025 19:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z3-00055d-8O
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7z1-0004TQ-B1
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7390d21bb1cso2296067b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549850; x=1751154650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+WW7MKuXjGWTCC1bO3NTFLtX2fhll/t7Qwx1wrIAn2E=;
 b=keg/vK2yccWlFac1+1dtUTulIDTv7nBAD7n/zfOpN1aZmo/l7ilefKJfaQCOcyZ7bv
 qr1DyuWedwD93ohg8JB7wv1xpV3DvqquJKu6iVEH9uCxwEvz/n0ALHmrkZ4L7tr7rXYs
 gC7uAQNTQTsoJOBrmZkfXpEZ5T8QboGbP+TkrttNP/8lQleF43+OjRQpijyjwWbwqWkF
 BWalM2RANr4gdoUK5JbpQsVAewoKVx7fEvQWX5vg+6pVyvJ3a+2Yotdx/UbScNwjpVc/
 iiB+dlXSyAvMi0e1hN+J/0Frp6feYUGo9Iee81cHoKPN5e+RIF6evrfg7wHWZmblts9+
 TnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549850; x=1751154650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WW7MKuXjGWTCC1bO3NTFLtX2fhll/t7Qwx1wrIAn2E=;
 b=Hfhdi3UuZ7y7mzcEQG6szlpPGf27LuDeG9mF1ARcyqEpDIBXJxWN9SWZDc+Con5bnU
 +Kic3j3rrBhMyUYPVSfu3i0pFhafjSO81JOmd75wqleXXzj/i5Y1Z7fN+Pt95k3jdRce
 5DlKoftA/D3uPEShb1m7RjLfhnM7DbnfvkUqtK8RerC9xAF6qxS9k0DHcvfHRBQJ0H4+
 y2/+OfI5hiA8p6Q4uBBNZ0rbp5KAqJSjVUuIiIjVr+djnwmgGUj1MyjxEgUXJXf04Zbg
 bw9xlmCnKSG2SOzgwyAMHHM47lPBoSFTocw2+JFm9mupxmvxoMbs/bGKp3+v1XmKSdmr
 0hTg==
X-Gm-Message-State: AOJu0YwBHK5QZYk+00sbAzBSQnZ5jK+7xT3rrl7HT0EOGWltI+sT/ltZ
 UDK5L357IQM6Ply8D4IGZUrmHOZVVSuKmlyo5xHUx+ihG6x4Z0awYLCcMP8uXShSNnK2eUw1ymn
 hzWo7
X-Gm-Gg: ASbGncuXodZB+KfPxvmOITeUMKGtwrSN38aRyiUxnF2i78QLaBhwt4CwUKkkZDcgyEw
 88c86b0lVhNtx3MZLdfRRT/dffJatDIy5Jrk1mIBfxJvF94iI9suOKiL09V+oTXeUgf+fe2sH3H
 HqVRCiloUvuB30WogVg/2b/Y+0UFLDtV7+HfP/X1jS63Ptj+XGECfUXyNpzhEXoM1IlZAQU0dV/
 Ikrpjt1vMmjvFAo0VLd6hHqZlklST7Ks2DqYdn4riYFS0dVLBbWmMlUmpBaoP1+WL+qhi96/V7F
 3VRDvnteiF71MyrETgl2aN6+WeBQUz3blm/yCTSTzO8cLF8TDTpooUTcjz5jwRCvPCIIakRl1l6
 0Gwv+Velmb0CVhgUSbJFE
X-Google-Smtp-Source: AGHT+IE8UuXIY6oXH9edKUk1BezvTeua8pYZvR0FQuJG7Si+yFa+qlHDbpGu6BsnZwmyoaXepW1dJw==
X-Received: by 2002:a05:6a00:4f8f:b0:742:a334:466a with SMTP id
 d2e1a72fcca58-7490d6659f7mr10868991b3a.12.1750549850043; 
 Sat, 21 Jun 2025 16:50:50 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 017/101] target/arm: Add zt0_excp_el to DisasContext
Date: Sat, 21 Jun 2025 16:49:13 -0700
Message-ID: <20250621235037.74091-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 465fc188d0..fae253e567 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1497,6 +1497,7 @@ FIELD(SVCR, ZA, 1, 1)
 
 /* Fields for SMCR_ELx. */
 FIELD(SMCR, LEN, 0, 4)
+FIELD(SMCR, EZT0, 30, 1)
 FIELD(SMCR, FA64, 31, 1)
 
 /* Write a new value to v7m.exception, thus transitioning into or out
@@ -3067,6 +3068,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
+FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1bfdb0fb9b..5153824a49 100644
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
index f7cbdd6814..3ceb8d87f4 100644
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
index ac80f572a2..f7737f5d86 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10128,6 +10128,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->trap_eret = EX_TBFLAG_A64(tb_flags, TRAP_ERET);
     dc->sve_excp_el = EX_TBFLAG_A64(tb_flags, SVEEXC_EL);
     dc->sme_excp_el = EX_TBFLAG_A64(tb_flags, SMEEXC_EL);
+    dc->zt0_excp_el = EX_TBFLAG_A64(tb_flags, ZT0EXC_EL);
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
-- 
2.43.0


