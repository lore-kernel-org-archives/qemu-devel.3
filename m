Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 06:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sd1g2-00020g-ND; Sun, 11 Aug 2024 02:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1fz-000202-RV
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:36 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sd1fy-0003LQ-0B
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 02:03:35 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db51b8ec15so2216459b6e.1
 for <qemu-devel@nongnu.org>; Sat, 10 Aug 2024 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723356212; x=1723961012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DmwpPh0HuvQouOcnmqzDiaoQNQqQeUssp+FOFv7Ick=;
 b=cNS0RPzBWcQGUMQ9Qa0+C8HnY4ljW4vqwQd8xjUvTWp53upJlBHUR492xqZ2SHjvYM
 6UdI7GuMb/GCPgIxKFK+MzPZbWes4/PhtI9JkdMZ9C0FJDBHt7fh0Q8Q5hvs+Rvv5zv1
 kxyyS3XSrEPmXupxUV5VsXVXKcQe7ppB9b72Me1wUm/eFRx49OQoFrBBa/JMNIVa4jAw
 cQxpSs6GaeRj62eQ/fV+JXAQGP6RNTnE+8yBjGHyuATVp1gm8mU22KLCxKrYgGu35Qc1
 zgHzOnL+xU65el6lUU8O/Zj3ESZfrgucZSwuWsJGXfyOTd+z2cuyn1++54v01LljFETO
 cYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723356212; x=1723961012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1DmwpPh0HuvQouOcnmqzDiaoQNQqQeUssp+FOFv7Ick=;
 b=AwrKJs1uTBEckQlLz3yFQcMljKJAjpwj3AwTcalwIgUA1rVk0XjIOEiMfCmd+0Jky6
 K+EspR5JeDMhMuCAzJj7DvSXWZ1VhOeCaZogPeJASUtFs/eElS70vLYH+l8e3RDPYhnX
 9D+DjA8tdZSeDuXGDIT9eL9iHKduO87MN9Lhsy6BuMOxDt3hWl2dyLg87tVCpGSc9flF
 /eKncnEmrsZpkMfIdRTmk24OYAvPKsS8lVMWAQQuF5QZkcTFR6MBJjuQtSvPDkPtdEkp
 zoCoyCOXay4Rc+b8r7B1fpm9B6lZceJqGN+K3N2RL0MvjWGxG9AEhgqegmeQSx4mLEG1
 3yXw==
X-Gm-Message-State: AOJu0YwYQK1Vn+0SMCC4Fy9l72DQB7KGUV9vqywtIvaGYwUNypS3WZah
 6ZE8M5h0cjX0wIedxfb2v7nMtI+5tUHhB6NaqyOycbEQovgr1n8Osj9F2CTDUVrA1EQsUeSuTaL
 DUHvDYw==
X-Google-Smtp-Source: AGHT+IEAP00RJ15mKxZ9sN47LohN4fTLgAnX/FSxQ2BSXaSF//qZUJrGJVpJydTc8CvJJ51YM5bpBw==
X-Received: by 2002:a05:6808:14c4:b0:3d9:2baa:9fd3 with SMTP id
 5614622812f47-3dc417a7de8mr2439840b6e.20.1723356212448; 
 Sat, 10 Aug 2024 23:03:32 -0700 (PDT)
Received: from stoup.. ([172.58.106.160]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd060b5388sm835591b6e.43.2024.08.10.23.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 23:03:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 2/4] target/m68k: Implement packed decimal real loads
Date: Sun, 11 Aug 2024 16:03:11 +1000
Message-ID: <20240811060313.730410-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240811060313.730410-1-richard.henderson@linaro.org>
References: <20240811060313.730410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/helper.h     |   2 +
 target/m68k/fpu_helper.c | 137 +++++++++++++++++++++++++++++++++++++++
 target/m68k/translate.c  |  22 ++++---
 3 files changed, 151 insertions(+), 10 deletions(-)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 95aa5e53bb..2c71361451 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -126,6 +126,8 @@ DEF_HELPER_FLAGS_4(bfffo_mem, TCG_CALL_NO_WG, i64, env, i32, s32, i32)
 DEF_HELPER_3(chk, void, env, s32, s32)
 DEF_HELPER_4(chk2, void, env, s32, s32, s32)
 
+DEF_HELPER_FLAGS_3(load_pdr_to_fx80, TCG_CALL_NO_RWG, void, env, fp, tl)
+
 #if !defined(CONFIG_USER_ONLY)
 DEF_HELPER_3(ptest, void, env, i32, i32)
 DEF_HELPER_3(pflush, void, env, i32, i32)
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 8314791f50..dd80943153 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -749,3 +749,140 @@ void HELPER(fcosh)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
     res->d = floatx80_cosh(val->d, &env->fp_status);
 }
+
+/* From m68k float.h, LDBL_MAX_10_EXP. */
+#define FX80_MAX_10_EXP  4932
+
+/* 10**0 through 10**18 */
+static const int64_t i64_pow10[] = {
+    1ll,
+    10ll,
+    100ll,
+    1000ll,
+    10000ll,
+    100000ll,
+    1000000ll,
+    10000000ll,
+    100000000ll,
+    1000000000ll,
+    10000000000ll,
+    100000000000ll,
+    1000000000000ll,
+    10000000000000ll,
+    100000000000000ll,
+    1000000000000000ll,
+    10000000000000000ll,
+    100000000000000000ll,
+    1000000000000000000ll,
+};
+
+/* Form 10**exp */
+static floatx80 floatx80_exp10i(int exp, float_status *status)
+{
+    static floatx80 cache[FX80_MAX_10_EXP + 1];
+
+    floatx80 ret;
+
+    assert(exp >= 0 && exp <= FX80_MAX_10_EXP);
+
+    ret = cache[exp];
+    if (ret.high) {
+        if (exp >= ARRAY_SIZE(i64_pow10)) {
+            float_raise(float_flag_inexact, status);
+        }
+    } else {
+        FloatRoundMode old_round = get_float_rounding_mode(status);
+        set_float_rounding_mode(float_round_nearest_even, status);
+
+        if (exp < ARRAY_SIZE(i64_pow10)) {
+            ret = int64_to_floatx80(i64_pow10[exp], status);
+        } else {
+            int e0 = exp / 2;
+            int e1 = exp - e0;
+            ret = floatx80_mul(floatx80_exp10i(e0, status),
+                               floatx80_exp10i(e1, status), status);
+        }
+
+        set_float_rounding_mode(old_round, status);
+        cache[exp] = ret;
+    }
+    return ret;
+}
+
+void HELPER(load_pdr_to_fx80)(CPUM68KState *env, FPReg *res, target_ulong addr)
+{
+    uint64_t lo;
+    uint32_t hi;
+    int64_t mant;
+    int exp;
+    floatx80 fexp;
+
+    hi = cpu_ldl_be_data_ra(env, addr, GETPC());
+    lo = cpu_ldq_be_data_ra(env, addr + 4, GETPC());
+
+    if (unlikely((hi & 0x7fff0000) == 0x7fff0000)) {
+        /* NaN or Inf */
+        res->l.lower = lo;
+        res->l.upper = hi >> 16;
+        return;
+    }
+
+    /* Initialize mant with the integer digit. */
+    mant = hi & 0xf;
+    if (!mant && !lo) {
+        /* +/- 0, regardless of exponent. */
+        res->l.lower = 0;
+        res->l.upper = (hi >> 16) & 0x8000;
+        return;
+    }
+
+    /*
+     * Accumulate the 16 decimal fraction digits into mant.
+     * With 17 decimal digits, the maximum value is 10**17 - 1,
+     * which is less than 2**57.
+     */
+    for (int i = 60; i >= 0; i -= 4) {
+        /*
+         * From 1.6.6 Data Format and Type Summary:
+         * The fpu does not detect non-decimal digits in any of the exponent,
+         * integer, or fraction digits.  These non-decimal digits are converted
+         * in the same manner as decimal digits; the result is probably useless
+         * although it is repeatable.
+         */
+        mant = mant * 10 + ((lo >> i) & 0xf);
+    }
+
+    /* Apply the mantissa sign. */
+    if (hi & 0x80000000) {
+        mant = -mant;
+    }
+
+    /* Convert the 3 digit decimal exponent to binary. */
+    exp = ((hi >> 24) & 0xf)
+        + ((hi >> 20) & 0xf) * 10
+        + ((hi >> 16) & 0xf) * 100;
+
+    /* Apply the exponent sign. */
+    if (hi & 0x40000000) {
+        exp = -exp;
+    }
+
+    /*
+     * Our representation of mant is integral, whereas the decimal point
+     * belongs between the integer and fractional components.
+     * Adjust the exponent to compensate.
+     */
+    exp -= 16;
+
+    /* Convert mantissa. */
+    res->d = int64_to_floatx80(mant, &env->fp_status);
+
+    /* Apply exponent. */
+    if (exp > 0) {
+        fexp = floatx80_exp10i(exp, &env->fp_status);
+        res->d = floatx80_mul(res->d, fexp, &env->fp_status);
+    } else if (exp < 0) {
+        fexp = floatx80_exp10i(-exp, &env->fp_status);
+        res->d = floatx80_div(res->d, fexp, &env->fp_status);
+    }
+}
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 445966fb6a..59e7d27393 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -963,11 +963,11 @@ static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
         tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
         break;
     case OS_PACKED:
-        /*
-         * unimplemented data type on 68040/ColdFire
-         * FIXME if needed for another FPU
-         */
-        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+        if (!m68k_feature(s->env, M68K_FEATURE_FPU_PACKED_DECIMAL)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            break;
+        }
+        gen_helper_load_pdr_to_fx80(tcg_env, fp, addr);
         break;
     default:
         g_assert_not_reached();
@@ -1142,11 +1142,13 @@ static int gen_ea_mode_fp(CPUM68KState *env, DisasContext *s, int mode,
                 tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
                 break;
             case OS_PACKED:
-                /*
-                 * unimplemented data type on 68040/ColdFire
-                 * FIXME if needed for another FPU
-                 */
-                gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+                if (!m68k_feature(s->env, M68K_FEATURE_FPU_PACKED_DECIMAL)) {
+                    gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+                    break;
+                }
+                tmp = tcg_constant_tl(s->pc);
+                s->pc += 12;
+                gen_helper_load_pdr_to_fx80(tcg_env, fp, tmp);
                 break;
             default:
                 g_assert_not_reached();
-- 
2.43.0


