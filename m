Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF09CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkg5-0006Dz-0E; Wed, 20 May 2026 13:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfg-0005fo-UI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkfb-00044k-CH
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:25:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49021532ebdso20577175e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297921; x=1779902721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hrcak8XkkPSZfKxs46swbECTBnU0R7NtOAZ2oeIrnRE=;
 b=Ewurm3Sv3lWkFhplS2T2hObLQumkyAgqhRviCwAO0HgoQYasBqQef8ofpWxR9x1oNK
 BzSFdbgP7ajD2tgJTdBZuWkPlSbNrV2X2JhPIuch4VRz+MACH8AppDqZwj3jVH3szFfe
 of2gvhpL6uMW0ibr3zosrbdHgAktsKpwQrQoqBqcjsUJ0qpGQuLQnJ5MdxnbASQk+QOf
 40SjI0dX6Z3yQR2ahcgwtin3exy5u4Sv4ebwy3x+F1ahFRiz3A+tAw1pGL8DzAq4XDJg
 EXbhLd+QWXpdNZSg4RhJS3gNvC18PvFfTy2kV8pzEFw0iSXibpAt2SBBzoHbY1JDzUK+
 H06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297921; x=1779902721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hrcak8XkkPSZfKxs46swbECTBnU0R7NtOAZ2oeIrnRE=;
 b=bIOyiQRXwTuQAVKjRxKTefg4xMcqyTf2cKHBDwe+NzYeAnxppOlOPxaMwf9n5qckuV
 R+TjUvKfcpFj1ogNGmNh5UXI783Q93UJePZn7Jr0VzPk378vbK9L391MsBHcnoyOUhH8
 H4lIFdExM/bIxCjtIBJGzUBr7P+ARFV6f2PTIjqN8ETP494zyDSJ2XT7m7Tyv5tuTqTy
 266LdkClo0lxl57vCHxeLKRVdHlO8pq81PH97OUiunOl1BBCZOVz5i+bspjKHidKP1Yd
 7DHMj2U+P347C7NB19OSrR4uAQ4tdbn8Q2DUcHSQzvTFEXly+1HEK99ChMM+MHdFLPgZ
 8/hw==
X-Gm-Message-State: AOJu0Yyy/bFi2Myvnl6QnYRRKkAcIpQI2Vx2mAtNKzOekT+IRVO4J5FQ
 Wu9Hcd78cGUvta+0k0pWxXZjbSn+95nSO8EBmikGXWuiwUCxPgAF1yuqi4LQv4BZg0LZe8lWuwC
 F1xeiX88=
X-Gm-Gg: Acq92OGRaeQy6HJI6x8hSZ8EoNAySBDUrSanAeYdnXOU3qvWa/nZYHKN11U7JEyVE27
 sy6gI8S99W4HKdEbs8QpXtvk5p1+1gww5EakGWGXpNLgS3PAly9tqK9q5mZCJkfhgyhguClACU8
 vidflIPXy718bPqCd1pGDZj2Sq1uDp1mAe/XQMzrH2YLcuxwnyVo2FY+YQy0neoC1uPk6FtfL67
 tFQP5a5SXwOQzde5+PgF0RfLp0oKxMPSHNJRh17nQZvAAMW3CvHCnlCVMSOGnpKnPxouzfmo+dk
 qhZUhxhh0creZr5FU0VJeXK8JAXovRcAo0a4PcBdK1JsI0GEZYIt39DuZl03J4Otpg/J3ZWJIMh
 1MIccYWZUtczdFQbRd6nM/6WavhUqyPLihpzLwREVu8fExgIdVzVHCjZZkEhcF813TB0/1gur8d
 q84qH6QZz2RCt9gju2QJQdBweCsDl5/zNaYC4m9Q7UDlscZ15hdADU6mA2Ua5vDI0sVYlhTKSR
X-Received: by 2002:a05:600c:a11c:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48fe5fd536amr289864475e9.5.1779297921409; 
 Wed, 20 May 2026 10:25:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm53770476f8f.3.2026.05.20.10.25.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:25:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 17/24] target/mips: add Octeon multiplier state
Date: Wed, 20 May 2026 19:23:05 +0200
Message-ID: <20260520172313.23777-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Expose MPL/P as global TCG variables so the multiplier translators can
expand inline without helper calls.

Migrate the multiplier registers in an Octeon-only subsection so
non-Octeon CPU models do not grow migration state.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h            | 12 ++++++++++++
 target/mips/tcg/translate.h  |  2 ++
 target/mips/system/machine.c | 33 +++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c  | 18 ++++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index b478f834c13..346713705a7 100644
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
index 89dde1e7124..ab2e2173674 100644
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
index 5880b401b07..f988b3695bc 100644
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
index dac30aff8d3..123d2c89c3d 100644
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
@@ -15276,6 +15278,22 @@ void mips_tcg_init(void)
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
+        oct_mpl[i] = tcg_global_mem_new_i64(
+            tcg_env, offsetof(CPUMIPSState, active_tc.octeon.MPL[i]),
+            mpl_names[i]);
+        oct_p[i] = tcg_global_mem_new_i64(
+            tcg_env, offsetof(CPUMIPSState, active_tc.octeon.P[i]),
+            p_names[i]);
+    }
 #endif /* !TARGET_MIPS64 */
     for (unsigned i = 0; i < 32; i++) {
         int off = offsetof(CPUMIPSState, active_fpu.fpr[i].wr.d[0]);
-- 
2.53.0


