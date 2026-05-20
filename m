Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A7CCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf58-0001w7-5N; Wed, 20 May 2026 07:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf4D-00018X-74
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:32 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf49-0003s4-Kx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a87edf88b3so5094288e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276380; x=1779881180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hrcak8XkkPSZfKxs46swbECTBnU0R7NtOAZ2oeIrnRE=;
 b=caFFjp80rZFyz6SFtu61mif7LCLhrSSUfEBRJ5jGYAgzlCgHbQwPaW4zVT87deIELj
 lN19Lhag+SSj8HcLfDHWuVC63pWuQIbhbo1at3yCTB2ICmP0IrUiFRBMPBjDvO1uu7+N
 MhDdeVh2L5uTlAIuVynVGmRlcM10uLOyFy/PSrsympmtlxpgvRbqE/KE0vUyD/Aw70Ek
 mk4s2tpqo3qHwzgXnX02/l7zUSJ1sLBQtQkV9Rq+xqaKBdYuOADCEXE3sfNEvn1abdjz
 V2GeAKfDYztH1mY7QC/FszUG4W7NWCWBKtFLh9/EJ88YCwWU8JbAYiQF8v/ijTR0N4KU
 PecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276380; x=1779881180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hrcak8XkkPSZfKxs46swbECTBnU0R7NtOAZ2oeIrnRE=;
 b=bNFPyu8VAdzVgLzWXWpFcapOmLrk0E2BCuP0urNm1vU+oaP0TRsO9Bgz1NaF7xPuQY
 3HtoW89WwQkXDA3F8coBqsUt5Kr/r8jZHitS5dqMreta4MUnAuSl70S6e5X8BWVaXFki
 mWEBSCrfeU9x2uDwCLWtw9Hhzb9OS1kFFhoENVQdIfwJKOkCLPp4SqylKPhpZIs0ctKC
 MGv+fKkKZosFdtZQJ/8nXsecSEqobB+JEg/GxhdpGa/TwwnJLJngURUKzIL2FkoiX6yQ
 gzXY8ZdxrtY6RO0nHTX4C24kxlUu5L8HdmQsq21YcJvno1x72SlY7+4swMkaSFFWVRX1
 dwlQ==
X-Gm-Message-State: AOJu0YwGUDyOAzRsua/p2k49E9FQ+sh+pRDI+wacZpOsiE0WVLsLyaQh
 gc0efsR5VupcIu9HlFFVQmw2zh+uhAUjT88offETS63EXHAanfGZu/J3iI3oALB86Ikop9HMsJZ
 aDIEGJn4=
X-Gm-Gg: Acq92OECeFYQT0chHfzfwBK67ZWF1UvLAoxbhWUV+opmacDB40mjvAjkl8Ix1i3Znr2
 5YtjTant2KccQGjyDKaSkQorP32NFArVYigpAkpS4EhoaKwRAb3X0mtrXkozh12N/iF/a9zQlir
 fI3m2oEhfVB6nzFnSoPXEyllWyzCpv66YIyiTd2025Ct8bsttCjQeWazEMXGm72Zr07cXy74UWf
 agmshD3KAI8ZFoR/aoFmxJFuSjh5tFbhESkKWhTniF54JswMln5OneVcIpBGzRQF3AJow1zZOAa
 dMWAywY/liXK/upwGJ79rVDLvpXsNAkazBbRP2DMfJNxToruvIJ9wFMeX/N6X1uNPN3y8Y21ZVk
 PQ+P02GgiDShiBmNrYtBIYJ42pILZVhP6TGEO7rDjkz9QOFPvPGVdQSmJ8AfyuB28L3Sz2fd0dc
 LhPUwqaAL/MDnAa6aY3cBSK18w7A55ak6JKtcl4u+u0BaUMgW/tXcoFlu9+k6HiHhRERdUYuh/3
 Ia8jw==
X-Received: by 2002:a5d:52cb:0:b0:45e:655d:6f7 with SMTP id
 ffacd0b85a97d-45e655d0715mr24828444f8f.24.1779272416368; 
 Wed, 20 May 2026 03:20:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm51541404f8f.16.2026.05.20.03.20.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v11 17/24] target/mips: add Octeon multiplier state
Date: Wed, 20 May 2026 12:17:58 +0200
Message-ID: <20260520101807.9971-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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


