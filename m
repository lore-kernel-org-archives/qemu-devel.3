Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C866CC52D7F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 06:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd1g5-0002Av-Lw; Sun, 11 Aug 2024 02:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1g4-00026J-6Z
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:40 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1g1-0003La-SB
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:39 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3db14cc9066so2379633b6e.3
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723356216; x=1723961016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kWnw21B5/msj5JNhDBa2OCjipT/LJ9pbKxvm18kEXiE=;
 b=o8/qsg41tAIiWBa75ivI4uPb9mpYitJpbsrYoHPsHJFWmJwQV+jnkZwtii+GjhMEPk
 ++TkLH4hq6mNnnCMsos7ZBq9crVfaUIM1MakHOGHWZ1AczPuoHozzwEKFxDt54Al6N9b
 C+AcXLEMo2Iyc9zwlsFtm6tzh2VCXwfVy5UX4zTwEECYA0EooZq2DY2d4Ls32vxuURGo
 RCvdJiBMryMJ8uu3JetKEHwUJ1m1Ky1mZWFAzf7iiaKPtXQOcvI1sRylKTdgE5cqaM3w
 phfxMx85QoQMDkpdjvrss/vK+n5yjVDogG3X5kFrjV7DhoZJhmeoIU/o8KToJJFOhtpX
 11Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723356216; x=1723961016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWnw21B5/msj5JNhDBa2OCjipT/LJ9pbKxvm18kEXiE=;
 b=pHh8vce7bvGqsjs2GUt6NeEDWyazTigRnmgXcD5TRW31o1NYpkVUJMEDaXVuB4A4dJ
 SdtIpjZ4HPBy2KwRKSfUImYYSMuHuHbPZgSApuN1evcVmy3x24fq/O8T5qm/YOJbfk/C
 8On1CD/qlBgDmYCNav5l+2qyfa09T9OYpJMCKnVVRJYooqDEyZjTX3x6E/3y8ZygXU97
 xDQB0GGTA66XtCY5RZdvdWUkhcT32asqmGowqo5JKe2jazL/gxoqwFvqerSzuvwBgt7l
 9jXUVs27RtDFa3VXwZ3dFbtZ8aqExUSSNWI3xNz5xC/5rtLfoAwyx83D/VE4PtESOB5g
 S9CQ==
X-Gm-Message-State: AOJu0YyUTbj+HZaHrYPrkxC/w9R9cGzqscePqdQOvFUEFYpqL//L37rc
 v3KULcZlr4JC7DgKj4zxktDHEE+8X2WVm/D21hm4YplVMyS5/+4aOdxXRQlc6/xyfs5DDSciP5q
 iVa1VLA==
X-Google-Smtp-Source: AGHT+IHUB6dWsJRodGHPC+piJKv9PRnZfL8FK3/X8wClIGaiMu+teeUOCqby1tvwOSlMTi9rhzvsQQ==
X-Received: by 2002:a05:6808:3993:b0:3d9:30a2:f8f9 with SMTP id
 5614622812f47-3dc415e3fd2mr9159975b6e.0.1723356216337; 
 Sat, 10 Aug 2024 23:03:36 -0700 (PDT)
Received: from stoup.. ([172.58.106.160]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd060b5388sm835591b6e.43.2024.08.10.23.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 23:03:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 3/4] target/m68k: Implement packed decimal real stores
Date: Sun, 11 Aug 2024 16:03:12 +1000
Message-ID: <20240811060313.730410-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240811060313.730410-1-richard.henderson@linaro.org>
References: <20240811060313.730410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2488
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/helper.h     |   1 +
 target/m68k/fpu_helper.c | 100 +++++++++++++++++++++++++++++++++++++++
 target/m68k/translate.c  |  27 +++++++++--
 3 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 2c71361451..21af6adb39 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -127,6 +127,7 @@ DEF_HELPER_3(chk, void, env, s32, s32)
 DEF_HELPER_4(chk2, void, env, s32, s32, s32)
 
 DEF_HELPER_FLAGS_3(load_pdr_to_fx80, TCG_CALL_NO_RWG, void, env, fp, tl)
+DEF_HELPER_FLAGS_4(store_fx80_to_pdr, TCG_CALL_NO_RWG, void, env, tl, fp, int)
 
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_3(ptest, void, env, i32, i32)
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index dd80943153..6f37a165e2 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -886,3 +886,103 @@ void HELPER(load_pdr_to_fx80)(CPUM68KState *env, FPReg *res, target_ulong addr)
         res->d = floatx80_div(res->d, fexp, &env->fp_status);
     }
 }
+
+static floatx80 floatx80_scale10i(floatx80 x, int e, float_status *status)
+{
+    floatx80 t;
+    if (e >= 0) {
+        t = floatx80_exp10i(e, status);
+        t = floatx80_mul(x, t, status);
+    } else {
+        t = floatx80_exp10i(-e, status);
+        t = floatx80_div(x, t, status);
+    }
+    return t;
+}
+
+void HELPER(store_fx80_to_pdr)(CPUM68KState *env, target_ulong addr,
+                               FPReg *srcp, int kfactor)
+{
+    floatx80 t, x = srcp->d;
+    int len, exp2, exp10;
+    uint64_t res_lo;
+    uint32_t res_hi;
+    int64_t y;
+
+    res_lo = x.low;
+    exp2 = x.high & 0x7fff;
+    if (unlikely(exp2 == 0x7fff)) {
+        /* NaN and Inf */
+        res_hi = (uint32_t)x.high << 16;
+        goto done;
+    }
+
+    /* Copy the sign bit to the output, and then x = abs(x). */
+    res_hi = (x.high & 0x8000u) << 16;
+    x.high &= 0x7fff;
+
+    if (exp2 == 0) {
+        if (res_lo == 0) {
+            /* +/- 0 */
+            goto done;
+        }
+        /* denormal */
+        exp2 = -0x3fff - clz64(res_lo);
+    } else {
+        exp2 -= 0x3fff;
+    }
+
+    /*
+     * Begin with an approximation of log2(x) via the base 2 exponent.
+     * Adjust, so that we compute the value scaled by 10**17, which will
+     * allows an integer to be extracted to match the output digits.
+     */
+    exp10 = (exp2 * 30102) / 100000;
+    while (1) {
+        /* kfactor controls the number of output digits */
+        if (kfactor <= 0) {
+            /* kfactor is number of digits right of the decimal point. */
+            len = exp10 - kfactor;
+        } else {
+            /* kfactor is number of significant digits */
+            len = kfactor;
+        }
+        len = MIN(MAX(len, 1), 17);
+
+        /*
+         * Scale, so that we have the requested number of digits
+         * left of the decimal point.  Convert to integer, which
+         * handles the rounding (and may force adjustment of exp10).
+         */
+        t = floatx80_scale10i(x, len - 1 - exp10, &env->fp_status);
+        y = floatx80_to_int64(t, &env->fp_status);
+        if (y < i64_pow10[len - 1]) {
+            exp10--;
+        } else if (y < i64_pow10[len]) {
+            break;
+        } else {
+            exp10++;
+        }
+    }
+
+    /* Output the mantissa. */
+    res_hi |= y / i64_pow10[len - 1];
+    res_lo = 0;
+    for (int i = 1; i < len; ++i) {
+        int64_t d = (y / i64_pow10[len - 1 - i]) % 10;
+        res_lo |= d << (64 - i * 4);
+    }
+
+    /* Output the exponent. */
+    if (exp10 < 0) {
+        res_hi |= 0x40000000;
+        exp10 = -exp10;
+    }
+    for (int i = 24; exp10; i -= 4, exp10 /= 10) {
+        res_hi |= (exp10 % 10) << i;
+    }
+
+ done:
+    cpu_stl_be_data_ra(env, addr, res_hi, GETPC());
+    cpu_stq_be_data_ra(env, addr + 4, res_lo, GETPC());
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 59e7d27393..fb5ecce0c3 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     int done_mac;
     int writeback_mask;
     TCGv writeback[8];
+    uint16_t insn;
+    uint16_t ext;
     bool ss_active;
 } DisasContext;
 
@@ -671,6 +673,7 @@ static inline int ext_opsize(int ext, int pos)
     case 4: return OS_WORD;
     case 5: return OS_DOUBLE;
     case 6: return OS_BYTE;
+    case 7: return OS_PACKED; /* store, dynamic k-factor */
     default:
         g_assert_not_reached();
     }
@@ -1010,11 +1013,25 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         tcg_gen_qemu_st_i64(t64, tmp, index, MO_TEUQ);
         break;
     case OS_PACKED:
+        if (!m68k_feature(s->env, M68K_FEATURE_FPU_PACKED_DECIMAL)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            break;
+        }
         /*
-         * unimplemented data type on 68040/ColdFire
-         * FIXME if needed for another FPU
+         * For stores we must recover k-factor, either from an
+         * immediate or the low 7 bits of a D register.
          */
-        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+        switch ((s->ext >> 10) & 7) {
+        case 3:
+            tcg_gen_movi_i32(tmp, sextract32(s->ext, 0, 7));
+            break;
+        case 7:
+            tcg_gen_sextract_i32(tmp, DREG(s->ext, 4), 0, 7);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        gen_helper_store_fx80_to_pdr(tcg_env, addr, fp, tmp);
         break;
     default:
         g_assert_not_reached();
@@ -4940,6 +4957,8 @@ DISAS_INSN(fpu)
     TCGv_ptr cpu_src, cpu_dest;
 
     ext = read_im16(env, s);
+    s->ext = ext;
+
     opmode = ext & 0x7f;
     switch ((ext >> 13) & 7) {
     case 0:
@@ -6042,6 +6061,8 @@ static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     CPUM68KState *env = cpu_env(cpu);
     uint16_t insn = read_im16(env, dc);
 
+    dc->insn = insn;
+    dc->ext = 0;
     opcode_table[insn](env, dc, insn);
     do_writebacks(dc);
 
-- 
2.43.0


