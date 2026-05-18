Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5276CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmSi-0003lq-6T; Sun, 17 May 2026 21:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSN-0003Wq-C7
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:50 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOmSJ-0007Kt-46
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:07:40 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-366087480d8so1365348a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779066458; x=1779671258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+J/RqB0l9WD6AketvkKe7bOMdoUOtkp2QzRU8k3nw8=;
 b=HgbD0T9nD3lmVbp4DFGADVoOJtM8mxDfDdvLQ/J2nbov2kFyE9JF93rDgHz1fbWc3S
 R2YaQwB+/TKEy37YAE7WSQ3gK12OEE/xwcoHzCNzoTfsxa83Y2EKUQTrAFWL/ZRSmjMA
 VOgAtp9lQtwCd4/qt1iDi6CQB9JmCPhYrsyxrJYCpxQYIaQx+ZlE8BtkBBHW9MiNtI7E
 6H6htZZj8Y6W4laVfIjTWrtbBuRu/iTf663S9GEibLEqwIDbpcZ6mK6Vk0Z+LLJJsMw8
 ItTjlQVMQGs7hd9OJRFYStFECG+rQPyKHayhoS7tL+WQQHZCrR0Bqi9BJUO4kN7FNd6g
 6f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066458; x=1779671258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+J/RqB0l9WD6AketvkKe7bOMdoUOtkp2QzRU8k3nw8=;
 b=HQpD1QKgESCmxbF78jDvoXrFekNd4NMlklNmDx4NxW4Fy1AMoFwGAXBv5XlDbRMrSL
 2ruobYdB5N4h/syq/LWmkcLuIhaR4M5PLV+P+kVbb83fkUdWy8ztWOZ/bTrSa4xW4qrD
 f2j7K8RGrKgsiKNbxTdO2E5SXQCw++ZX++s/CFmuhtXNtBmC2e4qeN2Q/BoDG92sRucF
 zvP7O53FexhNxoi01yLT+YFe5LrkCMpA+GXbHOwX/mpF0ndfRXkMcLB12lv1r9G4K6xZ
 a8BmMQrd4nx2FR18cBlv9SoXHBumq8lXrBGIB5xpfZhm0ZUpHUErf5UfGoLGonx/g2M7
 zP0g==
X-Gm-Message-State: AOJu0Yxjkx1W5Vq3BRfh76HlLITwaYaq8y05rf2fd3WYWAWe5kLKplIn
 lBE9hxGZ3CgnHG7kAjH1edwf8OS037MjQd4RDpRJmXDwqdxa6WdgUtpLdARYL/st2dRt+e0cntD
 KxvYp
X-Gm-Gg: Acq92OHvEomG5QqFtgxL57eYRh4m+LWrEl5crVFXY99H7tOa3gSyvCmJkOlmq5xTqLU
 fLQzIptXeP3/y35rCv0shYNqDG4Lu0WoHZGlYQ8SFMv1XTSfKo30kpJl7Euo/LG/iMXlJFx6+/9
 UEhOH6Z2ROwcq1SIqc19Yg/oUGSivBPnsOSlRaLDnRKXt4SoBFHAZyO3I0Zmo9nvece7msnj1hq
 pxgNBmzaTa89OoOL9ImVL+zsAgP46K8OvInvIRxb4bOwcbzMpjEaCHYc1Wqgza+iP5KkCtzTIwk
 HUjZx/qQpu1rAsa74G5J4Jy3maKIL7ZQYliDZybPV6yvUhJkg4a1wi8EghVggdZuNaZzBKexxNn
 3vSs1348KKg+yT/3OYa9+KXhli0+2rZvtV4Gac8cZcvI7NyPXp0NiOy95sFHvKaRmfxsz0kD7Ai
 WyJUegzmhpzot98K/b98DJWS6a2Ueu
X-Received: by 2002:a17:90b:260b:b0:35f:bb33:d728 with SMTP id
 98e67ed59e1d1-369519f37damr14710412a91.11.1779066457537; 
 Sun, 17 May 2026 18:07:37 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36951584654sm9160939a91.7.2026.05.17.18.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 18:07:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: james.hilliard1@gmail.com,
	philmd@linaro.org
Subject: [PATCH v7.5 3/9] target/mips: add Octeon multiplier state
Date: Sun, 17 May 2026 18:07:27 -0700
Message-ID: <20260518010733.502237-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010733.502237-1-richard.henderson@linaro.org>
References: <20260518010733.502237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

Add per-thread Octeon multiplier state for the MPL and P limb banks used
by the VMULU/VMM0/V3MULU instruction family.

Octeon3 extends the older MPL0-MPL2/P0-P2 state with high lanes
MPL3-MPL5/P3-P5, programmed by the two-source MTM/MTP forms. Represent
both banks as uint64_t arrays so the TC state matches the architected
64-bit limb layout used by Octeon68XX user-mode code.

Migrate the multiplier registers in an Octeon-only subsection so
non-Octeon CPU models do not grow migration state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260514-mips-octeon-missing-insns-v2-v7-14-226686be4ce1@gmail.com>
---
 target/mips/cpu.h            | 12 ++++++++++++
 target/mips/tcg/translate.h  |  2 ++
 target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c  | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index cbb9b3e1b1..0bf8f5e7a5 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -459,6 +459,14 @@ typedef struct mips_def_t mips_def_t;
 
 
 typedef struct TCState TCState;
+
+/*
+ * Octeon3 adds a second bank of multiplier/product limbs used by the
+ * two-source MTM/MTP forms: MPL0..2/P0..2 from rs and MPL3..5/P3..5 from rt.
+ */
+#define OCTEON_MULTIPLIER_LANES 3
+#define OCTEON_MULTIPLIER_REGS (2 * OCTEON_MULTIPLIER_LANES)
+
 struct TCState {
     target_ulong gpr[32];
 #if defined(TARGET_MIPS64)
@@ -497,6 +505,10 @@ struct TCState {
     target_ulong CP0_TCScheFBack;
     int32_t CP0_Debug_tcstatus;
     target_ulong CP0_UserLocal;
+    struct {
+        uint64_t MPL[OCTEON_MULTIPLIER_REGS];
+        uint64_t P[OCTEON_MULTIPLIER_REGS];
+    } octeon;
 
     int32_t msacsr;
 
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 89dde1e712..ab2e217367 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -189,6 +189,8 @@ void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz, int crc32c);
 extern TCGv cpu_gpr[32], cpu_PC;
 #if defined(TARGET_MIPS64)
 extern TCGv_i64 cpu_gpr_hi[32];
+extern TCGv_i64 oct_mpl[OCTEON_MULTIPLIER_REGS];
+extern TCGv_i64 oct_p[OCTEON_MULTIPLIER_REGS];
 #endif
 extern TCGv cpu_HI[MIPS_DSP_ACC], cpu_LO[MIPS_DSP_ACC];
 extern TCGv_i32 fpu_fcr0, fpu_fcr31;
diff --git a/target/mips/system/machine.c b/target/mips/system/machine.c
index 5880b401b0..f988b3695b 100644
--- a/target/mips/system/machine.c
+++ b/target/mips/system/machine.c
@@ -120,6 +120,17 @@ static const VMStateDescription vmstate_inactive_tc = {
     .fields = vmstate_tc_fields
 };
 
+static const VMStateDescription vmstate_octeon_multiplier_tc = {
+    .name = "cpu/tc/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(octeon.MPL, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_UINT64_ARRAY(octeon.P, TCState, OCTEON_MULTIPLIER_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* MVP state */
 
 static const VMStateDescription vmstate_mvp = {
@@ -247,6 +258,27 @@ static const VMStateDescription mips_vmstate_timer = {
     }
 };
 
+static bool mips_octeon_needed(void *opaque)
+{
+    MIPSCPU *cpu = opaque;
+
+    return cpu->env.insn_flags & INSN_OCTEON;
+}
+
+static const VMStateDescription mips_vmstate_octeon_multiplier = {
+    .name = "cpu/octeon_multiplier",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mips_octeon_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(env.active_tc, MIPSCPU, 1,
+                       vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_STRUCT_ARRAY(env.tcs, MIPSCPU, MIPS_SHADOW_SET_MAX, 1,
+                             vmstate_octeon_multiplier_tc, TCState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
     .version_id = 21,
@@ -363,6 +395,7 @@ const VMStateDescription vmstate_mips_cpu = {
     },
     .subsections = (const VMStateDescription * const []) {
         &mips_vmstate_timer,
+        &mips_vmstate_octeon_multiplier,
         NULL
     }
 };
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 54ed253a7d..5b5ef0d995 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1179,6 +1179,8 @@ static TCGv cpu_lladdr, cpu_llval;
 static TCGv_i32 hflags;
 TCGv_i32 fpu_fcr0, fpu_fcr31;
 TCGv_i64 fpu_f64[32];
+TCGv_i64 oct_mpl[OCTEON_MULTIPLIER_REGS];
+TCGv_i64 oct_p[OCTEON_MULTIPLIER_REGS];
 
 static const char regnames_HI[][4] = {
     "HI0", "HI1", "HI2", "HI3",
@@ -15272,6 +15274,22 @@ void mips_tcg_init(void)
                                                         active_tc.gpr_hi[i]),
                                                rname);
     }
+
+    for (unsigned i = 0; i < OCTEON_MULTIPLIER_REGS; ++i) {
+        static const char mpl_names[OCTEON_MULTIPLIER_REGS][5] = {
+            "MPL0", "MPL1", "MPL2", "MPL3", "MPL4", "MPL5",
+        };
+        static const char p_names[OCTEON_MULTIPLIER_REGS][3] = {
+            "P0", "P1", "P2", "P3", "P4", "P5",
+        };
+
+        oct_mpl[i] = tcg_global_mem_new_i64(tcg_env,
+                                            offsetof(CPUMIPSState, active_tc.octeon.MPL[i]),
+                                            mpl_names[i]);
+        oct_p[i] = tcg_global_mem_new_i64(tcg_env,
+                                          offsetof(CPUMIPSState, active_tc.octeon.P[i]),
+                                          p_names[i]);
+    }
 #endif /* !TARGET_MIPS64 */
     for (unsigned i = 0; i < 32; i++) {
         int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
-- 
2.43.0


