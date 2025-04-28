Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB68C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoM-0005A7-EX; Mon, 28 Apr 2025 16:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoI-00058j-Dz
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoG-0000cq-7F
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:38 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso5293135b3a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871034; x=1746475834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nj/KkQHJ+XNFYfBYngAfvob8GBlvpvqFFYAf7mtabnU=;
 b=L6Yjn2MVA1J9oaq3OFeHgURQor6NTB6LrHKCFj/iIYnqfu7lb4ySxkR/P+fm3+nJNq
 tt3g20gLFSuaDBWKRMUXtKpEQUcQoZ1nt3caYi4pRWEzxB9PPGLRh5YH4rY3DK4RBWZK
 hGB4ElbO90OFIMVNPZX668V/444pb34VI/Jw361SazuHMS6cfTMSV8HK+m8lkWVjLHd/
 vV2+riDrN76DggmE/yu8IBloJc3bfX6JzRKGYx8r4Qn6ar7fTb0bIp+E+UazOY7XMcNc
 ig5vbZgn7SXx6utN+FIL2KHxwVc5z+pxWF/+TQ6KJw6SFyCFZqcpAQuwkKaMjlMnbyJi
 Dfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871034; x=1746475834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nj/KkQHJ+XNFYfBYngAfvob8GBlvpvqFFYAf7mtabnU=;
 b=Xp0EiyKMliqPoqay8WfxSPRE/TS+8QMnZlvJk4rXU0wgwhNq6fQGyqQE671tYoh7AF
 qtDik6qU85+zgevZ6TQG7Vi46eZkwKq/uUy7RUZLzVlYZ+U1weexCfBP5qbhaCNCAlkU
 UvsUIMQjVrDMUcBMrzhY4Pi4MzQyi3MJw8FpMgopE7r512Jr/6Vo0whRrK7ZLhviDskn
 Nxzw/r1dKxp+2nG3gn6t/P/gCHWghnHGg1XqoB//dn1zLgjVQ7lyatmpyUhDeAYSdQvV
 mQl1Vb63vmRv0qv5mbZW2p4xdiZuLS9rYZ5JykveZhGC5JZNq2ffE+gfHsaRHlsSk+p1
 LcDA==
X-Gm-Message-State: AOJu0Yym+MOY93wF3qrIcToYDfzj9vOfz7XIW6Xa34RPATjom3QKw2y4
 FEfz/0J/kA61vrZIEquBitxN+XDLEYyx1+/PfLWIJ117jx8IyT7yBlpw5CmMZZGV2BpY3esufpL
 M
X-Gm-Gg: ASbGncvAoT/nOjjwSWJUobqeurXoHv/0wAwdi5Tng66hGR7cZLQg8UnYmh4NPpAPd2U
 ZQEpfSTIonUoSKFDHeVl7F4rd+8253NxpVLKrpdCKk+zmKUg8e2vIlfEK25t9eKh+nWYlPDC5sJ
 jNY2AizmVRWttQNBunti1sGsm92PRv3r9VJG5Nd2bi3t7cU9klNRk/iABxJ0U9vNieiWpCIhNYS
 cXamw+v84nGCiWjO7kkfkK9f32m9wXBLd8aIX9Iy0WCBYUCRQ76N8LB6cwcggtJofEMkML0Ns6K
 kp5AoT1ZVGVuij/Pk+A0JBOhEslPBJLcQ1fEZA0LOO/5j6dTo8APigsTweF0ntjnFwtTqlLTEpP
 XPPkfa/aeQQ==
X-Google-Smtp-Source: AGHT+IHnhl/SXBPuV+Teh2onhSMDZZRSjqgEBJhNx8fQi22TSLVw/o4y42POuk8xy668uBRrxuyThQ==
X-Received: by 2002:a05:6a00:a28:b0:736:5725:59b4 with SMTP id
 d2e1a72fcca58-73ff7255d50mr14179829b3a.3.1745871034415; 
 Mon, 28 Apr 2025 13:10:34 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 06/10] target/riscv: Move cpu_get_tb_cpu_state to tcg-cpu.c
Date: Mon, 28 Apr 2025 13:10:24 -0700
Message-ID: <20250428201028.1699157-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index e3e7fea66a..f2cacef5e5 100644
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


