Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADFDCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjT-0006ko-JD; Tue, 16 Jun 2026 06:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjR-0006c0-5h
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:21 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjO-0003r0-IU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:20 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c85825bbc4fso2696281a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604556; x=1782209356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTJICuTgtDm/SYdUsrTzXK3QgvqftbPFI8VVLkqtBQ0=;
 b=lzh8q/5BOINsa4GC9vcJi645RfF5exWtEush+D/7I4AUdBeo0qnF8Tu4hIiFAI6x/C
 jbGWUvaO/f30A7zBEFibz3J7P8S3b2gnJgBZ8ePDvKJRQa7zhOICewCC8w/lzzem7eME
 2AoOrvlJHXkEz37jcV84R9/Pd0a6+Mb7BjCSyxhATxagiyqCyaPBd4UIwU8q5WzLyYCq
 T8V4DD8DROAk/Mnw8Ta5RSBSU+V7Sgkr0T0YUyHMEW14kCbQJ3VQU5Ct0QgT6YebxUqC
 1+Hs6GDN1VT//FqZ3khxdZpGe1TD9o3pSmBIfMGRGPqHvU9vZNkZgqqbOgdMWSgB4as7
 g30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604556; x=1782209356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hTJICuTgtDm/SYdUsrTzXK3QgvqftbPFI8VVLkqtBQ0=;
 b=EFV4qVfZLELR9zfuNsoyszYGTy4obrL+uMPInh1Cw/XuubT3sGAjzl2f28xC0oBNe7
 ZcgCv7Ap2w+50iZZTu3D2zodsP5Ty6AhfMTiU3fAzTJB7wHE/QRkIBBNWf5+kyqxljCt
 lpSVNK3TLB6k6+ArrPPL0f9+BC7l7rGisfR6OsLXAg4DRyefRkPKo+49Tpt3SV1cUF+9
 jzLjwLAm395lP43vrXC3kEuUucEYwznbD3Sy7L1keqH5sn99z1M16BlD61hmh/zQdyNZ
 /lV5i0u+cA9mqiSwtihRRi3urMt3IxVI9W6P4HVabdipVPIMKfRBRNkeNCpkzTzaQsvM
 HcpQ==
X-Gm-Message-State: AOJu0YyFNh8SXwcNUTbIVfPDEX++eNtK2qAcnrasQqEftyvRN38j4Zcs
 bL7q82z4nnW77b6re6oEaXpoENDguCdGP6GXpJCItdxede6tya7nVZDCeHXXJstJ
X-Gm-Gg: Acq92OGNlDvbfiZpg3J7l87n0h/M70sbayAii6LGm+vGhwj0lqCmMa3nn9pAMMSSYeg
 awUO55k/G/3wh6ZiiP2E1S+34raFQZdnvpPahpwJoxhgqTZ0M+7JvJoB5vRBVMdjxxIiZIxcG/U
 O3rHyQ21LCHZoRNHxblmDfsJzcSGWOlkOWka9aRj/C+OtxYtFFHreKHjMG5v5rdVd8YJIkRJdkU
 cxGnm13PF9dJgaUf8rXvcWyrywtwoGFw4mVgDVDtMEtUKf2HrfSD+hofm8zOzENn99YXNsMkSH7
 IL3fLDE0u/trROWgxyjYJ2CLLmVi8eT6ikBl3ofHhOku5lchTiiYqXDr/NeTDMkwsZQ91pmNIjD
 372cAtBa+zFXiKgb4+h42Beoop5n+EdnVLwAXZHx8hcD76SrVoUCxCOREWry455gq5VuADjhBHS
 QzigtKdnCdtqKnP3sTnFzUVpjyKHEsPDbq8X4eQf5M
X-Received: by 2002:a05:6a20:6a08:b0:3b4:b340:411d with SMTP id
 adf61e73a8af0-3b7840eceb8mr21432443637.24.1781604555956; 
 Tue, 16 Jun 2026 03:09:15 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 63/83] target/riscv: Set mstatus.FS dirty when scalar FP raises
 exceptions
Date: Tue, 16 Jun 2026 20:05:06 +1000
Message-ID: <20260616100527.1939565-64-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Max Chou <max.chou@sifive.com>

According to the RISC-V privileged spec 3.1.6, any instruction that
modifies FP extension state (FP CSRs including fflags, or f registers)
must set mstatus.FS to Dirty.  Raising fflags bits is modifying fcsr
(an FP CSR).

Scalar FP instructions that write integer registers (FP comparisons and
FP-to-integer conversions) never call mark_fs_dirty at translation time
to set mstatus.FS to dirty.  However, they can raise FP exception flags
via softfloat functions, which modifies fflags without any mechanism to
dirty mstatus.FS.

The affected helpers:
- Comparisons: fle/fleq/flt/fltq/feq
  — raise NV on NaN operands
- FP-to-integer: fcvt.[w|wu|l|lu]/fcvtmod.w.d
  — raise NX on inexact or NV on out-of-range

Fix this issue by
1. Save float_exception_flags before the softfloat operation
2. Perform the operation
3. If any new exception bits are set, set fs to dirty

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260611105037.157773-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |   1 +
 target/riscv/fpu_helper.c | 157 +++++++++++++++++++++++++++++++-------
 2 files changed, 130 insertions(+), 28 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index eec5acea5f..7582874c35 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -676,6 +676,7 @@ G_NORETURN void riscv_raise_exception(CPURISCVState *env,
 
 uint8_t riscv_cpu_get_fflags(CPURISCVState *env);
 void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t);
+void riscv_cpu_check_fflags(CPURISCVState *env, FloatExceptionFlags);
 
 #ifndef CONFIG_USER_ONLY
 void cpu_set_exception_base(int vp_index, uint64_t address);
diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
index e6d1ffb1d6..db1475271b 100644
--- a/target/riscv/fpu_helper.c
+++ b/target/riscv/fpu_helper.c
@@ -50,6 +50,22 @@ void riscv_cpu_set_fflags(CPURISCVState *env, uint8_t hard)
     set_float_exception_flags(soft, &env->fp_status);
 }
 
+#ifndef CONFIG_USER_ONLY
+void riscv_cpu_check_fflags(CPURISCVState *env,
+                            FloatExceptionFlags pre_fflag)
+{
+    if (get_float_exception_flags(&env->fp_status) & ~pre_fflag) {
+        env->mstatus |= MSTATUS_FS;
+        if (env->virt_enabled) {
+            env->mstatus_hs |= MSTATUS_FS;
+        }
+    }
+}
+#else
+void riscv_cpu_check_fflags(CPURISCVState *env,
+                            FloatExceptionFlags pre_fflag) {}
+#endif
+
 void helper_set_rounding_mode(CPURISCVState *env, uint32_t rm)
 {
     FloatRoundMode softrm;
@@ -286,59 +302,86 @@ target_ulong helper_fle_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_le(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_le(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fleq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_le_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_le_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_flt_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_lt(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_lt(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fltq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_lt_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_lt_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_feq_s(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
     float32 frs2 = check_nanbox_s(env, rs2);
-    return float32_eq_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_eq_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_w_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return float32_to_int32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_to_int32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_wu_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return (int32_t)float32_to_uint32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = (int32_t)float32_to_uint32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_l_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return float32_to_int64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_to_int64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_lu_s(CPURISCVState *env, uint64_t rs1)
 {
     float32 frs1 = check_nanbox_s(env, rs1);
-    return float32_to_uint64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float32_to_uint64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvt_s_w(CPURISCVState *env, target_ulong rs1)
@@ -453,52 +496,83 @@ uint64_t helper_fsqrt_d(CPURISCVState *env, uint64_t frs1)
 
 target_ulong helper_fle_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_le(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_le(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fleq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_le_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_le_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_flt_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_lt(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_lt(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fltq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_lt_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_lt_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_feq_d(CPURISCVState *env, uint64_t frs1, uint64_t frs2)
 {
-    return float64_eq_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_eq_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_w_d(CPURISCVState *env, uint64_t frs1)
 {
-    return float64_to_int32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_to_int32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvtmod_w_d(CPURISCVState *env, uint64_t value)
 {
-    return float64_to_int32_modulo(value, float_round_to_zero, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    uint64_t ret = float64_to_int32_modulo(value, float_round_to_zero,
+                                           &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_wu_d(CPURISCVState *env, uint64_t frs1)
 {
-    return (int32_t)float64_to_uint32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = (int32_t)float64_to_uint32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_l_d(CPURISCVState *env, uint64_t frs1)
 {
-    return float64_to_int64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_to_int64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_lu_d(CPURISCVState *env, uint64_t frs1)
 {
-    return float64_to_uint64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float64_to_uint64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvt_d_w(CPURISCVState *env, target_ulong rs1)
@@ -619,35 +693,50 @@ target_ulong helper_fle_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_le(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_le(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fleq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_le_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_le_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_flt_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_lt(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_lt(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fltq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_lt_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_lt_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_feq_h(CPURISCVState *env, uint64_t rs1, uint64_t rs2)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
     float16 frs2 = check_nanbox_h(env, rs2);
-    return float16_eq_quiet(frs1, frs2, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_eq_quiet(frs1, frs2, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fclass_h(CPURISCVState *env, uint64_t rs1)
@@ -683,25 +772,37 @@ uint64_t helper_froundnx_h(CPURISCVState *env, uint64_t rs1)
 target_ulong helper_fcvt_w_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return float16_to_int32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_to_int32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_wu_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return (int32_t)float16_to_uint32(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = (int32_t)float16_to_uint32(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_l_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return float16_to_int64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_to_int64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 target_ulong helper_fcvt_lu_h(CPURISCVState *env, uint64_t rs1)
 {
     float16 frs1 = check_nanbox_h(env, rs1);
-    return float16_to_uint64(frs1, &env->fp_status);
+    FloatExceptionFlags pre_fflag = get_float_exception_flags(&env->fp_status);
+    target_ulong ret = float16_to_uint64(frs1, &env->fp_status);
+    riscv_cpu_check_fflags(env, pre_fflag);
+    return ret;
 }
 
 uint64_t helper_fcvt_h_w(CPURISCVState *env, target_ulong rs1)
-- 
2.54.0


