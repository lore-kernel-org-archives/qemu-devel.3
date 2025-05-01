Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E74C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbM1-00019n-6Z; Thu, 01 May 2025 17:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLk-0000yo-Ku
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:45 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLi-0001Yw-53
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:44 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b041afe0ee1so1365336a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134500; x=1746739300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpjRSP299/Pwnlg0y40yyEXNMYiNnhME3gCevLegoTY=;
 b=WTg+LwZPqm8YCo4SI3pV5buhkKl9QCRjasueFqFK1gRtkKk/2JdBMDgr7/+9Sp23oq
 QoYbTnp6oahzXI+6fYH7Lz+jRh5DxYWfqkw1PcTkwvJVPVwUeq/ybU+TFXlh7IG2zjv/
 XQI0NeDVS7bHhRgFwKvEEn4Q2Iqw0JdhFKFhc1LoGWRDtksvoop3c26D4WNomhzBnwHN
 NIOBXJd+A7Z/Oc/CXDll5ofvSJBsRIkZW3BNlyrxb7m1DJYZT+VfbSHHadcQUNHBX7FJ
 w8LAPwv3WbHuyWa6Bihg1iW7rzcvO1Uuvu2is1nY0UYYftzHu7002ovNMOdPDSm60Ffb
 NBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134500; x=1746739300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpjRSP299/Pwnlg0y40yyEXNMYiNnhME3gCevLegoTY=;
 b=XbP58ZX5I8P0a8xNxDgJiASp2iT7SQoB8N3hS9je6dneeDgnbgqYS2n2JoLdRRNUSW
 kZ1KAKqQp091eK17/brkG2PPwWZEVm0jTFfFWRkBjLsnMD6usy08bWOI1iV3spL4nfAw
 ivT06sRARbZnlPwJzCzw2xbCCpY4AjnWQb3SB8z+0KlQMZstfxisb3ttqo/u3cfgYcfl
 P6zvlqa1odcS2Wz6RZLdy8cHc48mWy0xxr/CQftKlh5XMgwWFZNKviPZERzx4Jt/uaFG
 DI8Oefclb+cX0JmGcZ2+38k2sMWdhgvz3mqdBmh81XgZAIA8jruhIZ4Gk/OwcRHxUhRT
 BW4g==
X-Gm-Message-State: AOJu0Yx9PNcpNQhvvfcRDgUdH4SsB/+uObyLbF/6JU/ngEHzZXaVkDYJ
 t4SRjQ0/lfVJ0JCXxnDfh7DmWrPbJOSLSlvPgkFiW8S97nFG9q81mSMZ0Io5SZE9BXpvnd/4APf
 X
X-Gm-Gg: ASbGncsW2bEH08l1aGyQNsoSsCF7eKLVyJk1gMlmqkepRrv27s7Md7SmjJ21qcI5ZOn
 MfARmhSnrsmAua5FLstRjUBU73Iv9BLLFc8985o5q2WnLQg/r4bwgUCD4Ho7am526tb2TE1jDmL
 3iA0V7sKjgY2A8b9C+5rlvmR7DO4O8x5wgUOKuawBpW1NoIkd8T2Qje6kNO1+CLv0sH2S5NThVx
 CtPe1//XYXy0poS0l+gVg5Evm1tZe+qa/JGSdqpwCkoeY1XDnwdl1R8O0CjOMnuGeMAEjz8q3L8
 AMICRZLbs9RljKHJcEmyTz/U7+/u2kiexJlHDoRLaIdQH0Nkx/hAqZrBQlBe7kJ7hWCCEYDY+08
 =
X-Google-Smtp-Source: AGHT+IHFsKGUtIhT1JXqo5MPrWz4ctJEyy/RU/9Dqqj8nu6dXNfYDqX9ScgDwxzkOMUM9Jop3gVSkA==
X-Received: by 2002:a17:90b:2d48:b0:2fe:8c22:48b0 with SMTP id
 98e67ed59e1d1-30a4e5c6031mr938847a91.15.1746134500457; 
 Thu, 01 May 2025 14:21:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 31/59] target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
Date: Thu,  1 May 2025 14:20:45 -0700
Message-ID: <20250501212113.2961531-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

This function is only relevant to tcg.
Move it to a tcg-specific file.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c  | 97 -------------------------------------
 target/riscv/tcg/tcg-cpu.c | 98 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 97 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f2e90a9889..d5039f69a9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -135,103 +135,6 @@ bool riscv_env_smode_dbltrp_enabled(CPURISCVState *env, bool virt)
 #endif
 }
 
-void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
-                          uint64_t *cs_base, uint32_t *pflags)
-{
-    RISCVCPU *cpu = env_archcpu(env);
-    RISCVExtStatus fs, vs;
-    uint32_t flags = 0;
-    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
-
-    *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
-    *cs_base = 0;
-
-    if (cpu->cfg.ext_zve32x) {
-        /*
-         * If env->vl equals to VLMAX, we can use generic vector operation
-         * expanders (GVEC) to accerlate the vector operations.
-         * However, as LMUL could be a fractional number. The maximum
-         * vector size can be operated might be less than 8 bytes,
-         * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
-         * only when maxsz >= 8 bytes.
-         */
-
-        /* lmul encoded as in DisasContext::lmul */
-        int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
-        uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
-        uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
-        uint32_t maxsz = vlmax << vsew;
-        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
-                           (maxsz >= 8);
-        flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
-        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
-        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
-                           FIELD_EX64(env->vtype, VTYPE, VLMUL));
-        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
-        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
-                           FIELD_EX64(env->vtype, VTYPE, VTA));
-        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
-                           FIELD_EX64(env->vtype, VTYPE, VMA));
-        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
-    } else {
-        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
-    }
-
-    if (cpu_get_fcfien(env)) {
-        /*
-         * For Forward CFI, only the expectation of a lpad at
-         * the start of the block is tracked via env->elp. env->elp
-         * is turned on during jalr translation.
-         */
-        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
-        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
-    }
-
-    if (cpu_get_bcfien(env)) {
-        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
-    }
-
-#ifdef CONFIG_USER_ONLY
-    fs = EXT_STATUS_DIRTY;
-    vs = EXT_STATUS_DIRTY;
-#else
-    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
-
-    flags |= riscv_env_mmu_index(env, 0);
-    fs = get_field(env->mstatus, MSTATUS_FS);
-    vs = get_field(env->mstatus, MSTATUS_VS);
-
-    if (env->virt_enabled) {
-        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
-        /*
-         * Merge DISABLED and !DIRTY states using MIN.
-         * We will set both fields when dirtying.
-         */
-        fs = MIN(fs, get_field(env->mstatus_hs, MSTATUS_FS));
-        vs = MIN(vs, get_field(env->mstatus_hs, MSTATUS_VS));
-    }
-
-    /* With Zfinx, floating point is enabled/disabled by Smstateen. */
-    if (!riscv_has_ext(env, RVF)) {
-        fs = (smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR) == RISCV_EXCP_NONE)
-             ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
-    }
-
-    if (cpu->cfg.debug && !icount_enabled()) {
-        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
-    }
-#endif
-
-    flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
-    flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
-    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
-    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
-    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
-    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
-
-    *pflags = flags;
-}
-
 RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 50782e0f0e..e67de7dfe2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -36,6 +36,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #include "system/tcg.h"
+#include "exec/icount.h"
 #endif
 
 /* Hash that stores user set extensions */
@@ -97,6 +98,103 @@ static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
     return riscv_env_mmu_index(cpu_env(cs), ifetch);
 }
 
+void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
+                          uint64_t *cs_base, uint32_t *pflags)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    RISCVExtStatus fs, vs;
+    uint32_t flags = 0;
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
+
+    *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
+    *cs_base = 0;
+
+    if (cpu->cfg.ext_zve32x) {
+        /*
+         * If env->vl equals to VLMAX, we can use generic vector operation
+         * expanders (GVEC) to accerlate the vector operations.
+         * However, as LMUL could be a fractional number. The maximum
+         * vector size can be operated might be less than 8 bytes,
+         * which is not supported by GVEC. So we set vl_eq_vlmax flag to true
+         * only when maxsz >= 8 bytes.
+         */
+
+        /* lmul encoded as in DisasContext::lmul */
+        int8_t lmul = sextract32(FIELD_EX64(env->vtype, VTYPE, VLMUL), 0, 3);
+        uint32_t vsew = FIELD_EX64(env->vtype, VTYPE, VSEW);
+        uint32_t vlmax = vext_get_vlmax(cpu->cfg.vlenb, vsew, lmul);
+        uint32_t maxsz = vlmax << vsew;
+        bool vl_eq_vlmax = (env->vstart == 0) && (vlmax == env->vl) &&
+                           (maxsz >= 8);
+        flags = FIELD_DP32(flags, TB_FLAGS, VILL, env->vill);
+        flags = FIELD_DP32(flags, TB_FLAGS, SEW, vsew);
+        flags = FIELD_DP32(flags, TB_FLAGS, LMUL,
+                           FIELD_EX64(env->vtype, VTYPE, VLMUL));
+        flags = FIELD_DP32(flags, TB_FLAGS, VL_EQ_VLMAX, vl_eq_vlmax);
+        flags = FIELD_DP32(flags, TB_FLAGS, VTA,
+                           FIELD_EX64(env->vtype, VTYPE, VTA));
+        flags = FIELD_DP32(flags, TB_FLAGS, VMA,
+                           FIELD_EX64(env->vtype, VTYPE, VMA));
+        flags = FIELD_DP32(flags, TB_FLAGS, VSTART_EQ_ZERO, env->vstart == 0);
+    } else {
+        flags = FIELD_DP32(flags, TB_FLAGS, VILL, 1);
+    }
+
+    if (cpu_get_fcfien(env)) {
+        /*
+         * For Forward CFI, only the expectation of a lpad at
+         * the start of the block is tracked via env->elp. env->elp
+         * is turned on during jalr translation.
+         */
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_LP_EXPECTED, env->elp);
+        flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
+    }
+
+    if (cpu_get_bcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+    }
+
+#ifdef CONFIG_USER_ONLY
+    fs = EXT_STATUS_DIRTY;
+    vs = EXT_STATUS_DIRTY;
+#else
+    flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
+
+    flags |= riscv_env_mmu_index(env, 0);
+    fs = get_field(env->mstatus, MSTATUS_FS);
+    vs = get_field(env->mstatus, MSTATUS_VS);
+
+    if (env->virt_enabled) {
+        flags = FIELD_DP32(flags, TB_FLAGS, VIRT_ENABLED, 1);
+        /*
+         * Merge DISABLED and !DIRTY states using MIN.
+         * We will set both fields when dirtying.
+         */
+        fs = MIN(fs, get_field(env->mstatus_hs, MSTATUS_FS));
+        vs = MIN(vs, get_field(env->mstatus_hs, MSTATUS_VS));
+    }
+
+    /* With Zfinx, floating point is enabled/disabled by Smstateen. */
+    if (!riscv_has_ext(env, RVF)) {
+        fs = (smstateen_acc_ok(env, 0, SMSTATEEN0_FCSR) == RISCV_EXCP_NONE)
+             ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
+    }
+
+    if (cpu->cfg.debug && !icount_enabled()) {
+        flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
+    }
+#endif
+
+    flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
+    flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
+    flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
+    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
+
+    *pflags = flags;
+}
+
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
-- 
2.43.0


