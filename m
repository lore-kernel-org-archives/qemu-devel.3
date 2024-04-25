Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AF1C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY3-0008Lo-UQ; Wed, 24 Apr 2024 20:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXr-0008Gl-81
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:01 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXm-0006Ho-SQ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e50a04c317so2386935ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003253; x=1714608053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5wlGs/id23E87HIx9ekP/PHGIDt2Ux5/Yk7Een8ixEg=;
 b=PvyYCeUcAgz47cqA4rXWN0N8o9Z4hwhGEFvBYTKMfiId1BsmS+g9X1+/NtFYc0AE4W
 zRWexKvUkoyQaw/1PqLpEu5hSsc1m+3X+I6tyBN21Wl5Ud9bd/74XkJeX6HzNFtkb2jg
 FAzYXYaggcJdl0tv8+DyXbcbo5Klf70MuDqvbwEwQ5xUaXjiRTJaVguh2zEBJutngNGU
 SSKqgPuaGTlkKcozA+kXfWh7PfhL06kd5Miyzgxyydjew1zZggbBd3J/AtW9B2Ai3NEZ
 z7CU0MmHBiKibZwqNRqkvSQ9Bg5qRN4pz2YfjDiHfO4u9BSfj8i09dbfUiGEKpDy4wbW
 L4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003253; x=1714608053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5wlGs/id23E87HIx9ekP/PHGIDt2Ux5/Yk7Een8ixEg=;
 b=V9aX89vFc+ww344FQI4FhTHdnHL3byrQ73iO17QRYdDh+j6dmQHrZ++Q4suz0Gdk/G
 NvlsfvF2La3eRW0RFrRx8TA2cl3KjCmet8GzP/Ju5CJ85VetldfYUmBDtwS+Qnvhe3hu
 QejOzavbbMXV72NtIEo4cWDD3D4iEsD9qlq2yW5sOSD6QqTgCAEEkNQfb0hczkmE679r
 2TLJAqUuPKHcVJLLkBO86QuPW2OFESHlDCEdfD/8WzgA0kvCGx0TUc6van/+hMFLXVOt
 K4ECG5hk7QS638vAYuYZuJsf8sDcPvu+OS/9/r4wbKRZMuGHYEQ42FGVNSJzoNCf/TNn
 8acA==
X-Gm-Message-State: AOJu0YxQCLrTEa3msDiyxpMmw0dEEv8G10ikXmTIxhRas5Pf81OAQO/8
 /0AZOdec2NiQozXmglGLV6Je5lkTeByzdT6XAVM2d+QCaBVkxuj+HbUQCA2aojnYfRckcCShfIA
 S
X-Google-Smtp-Source: AGHT+IGipyRnGp7mvnjp68EKYK/ZVgWBDxICB1Ym8NlxAB3hrSNL8HkcAqx8VXxOXSJ8ocYSSBmztg==
X-Received: by 2002:a17:902:ec8a:b0:1e3:e6cb:a33c with SMTP id
 x10-20020a170902ec8a00b001e3e6cba33cmr4958074plg.65.1714003253530; 
 Wed, 24 Apr 2024 17:00:53 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/45] target/hppa: Use delay_excp for conditional traps
Date: Wed, 24 Apr 2024 17:00:07 -0700
Message-Id: <20240425000023.1002026-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/hppa/helper.h     |  1 -
 target/hppa/int_helper.c |  2 +-
 target/hppa/op_helper.c  |  7 -------
 target/hppa/translate.c  | 41 ++++++++++++++++++++++++++++++----------
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 5900fd70bc..3d0d143aed 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,6 +1,5 @@
 DEF_HELPER_2(excp, noreturn, env, int)
 DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
-DEF_HELPER_FLAGS_2(tcond, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index a667ee380d..1aa3e88ef1 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -134,13 +134,13 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         switch (i) {
         case EXCP_ILL:
         case EXCP_BREAK:
+        case EXCP_COND:
         case EXCP_PRIV_REG:
         case EXCP_PRIV_OPR:
             /* IIR set via translate.c.  */
             break;
 
         case EXCP_OVERFLOW:
-        case EXCP_COND:
         case EXCP_ASSIST:
         case EXCP_DTLB_MISS:
         case EXCP_NA_ITLB_MISS:
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 6cf49f33b7..a8b69fd481 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -49,13 +49,6 @@ void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
     }
 }
 
-void HELPER(tcond)(CPUHPPAState *env, target_ulong cond)
-{
-    if (unlikely(cond)) {
-        hppa_dynamic_excp(env, EXCP_COND, GETPC());
-    }
-}
-
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
                                 uint32_t val, uint32_t mask, uintptr_t ra)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7a92901e18..080a52e5e4 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1115,6 +1115,25 @@ static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
     return sv;
 }
 
+static void gen_tc(DisasContext *ctx, DisasCond *cond)
+{
+    DisasDelayException *e;
+
+    switch (cond->c) {
+    case TCG_COND_NEVER:
+        break;
+    case TCG_COND_ALWAYS:
+        gen_excp_iir(ctx, EXCP_COND);
+        break;
+    default:
+        e = delay_excp(ctx, EXCP_COND);
+        tcg_gen_brcond_i64(cond->c, cond->a0, cond->a1, e->lab);
+        /* In the non-trap path, the condition is known false. */
+        *cond = cond_make_f();
+        break;
+    }
+}
+
 static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
                    TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
@@ -1173,9 +1192,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     /* Emit any conditional trap before any writeback.  */
     cond = do_cond(ctx, cf, d, dest, uv, sv);
     if (is_tc) {
-        tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
 
     /* Write back the result.  */
@@ -1194,6 +1211,10 @@ static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
 {
     TCGv_i64 tcg_r1, tcg_r2;
 
+    if (unlikely(is_tc && a->cf == 1)) {
+        /* Unconditional trap on condition. */
+        return gen_excp_iir(ctx, EXCP_COND);
+    }
     if (a->cf) {
         nullify_over(ctx);
     }
@@ -1209,6 +1230,10 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
 {
     TCGv_i64 tcg_im, tcg_r2;
 
+    if (unlikely(is_tc && a->cf == 1)) {
+        /* Unconditional trap on condition. */
+        return gen_excp_iir(ctx, EXCP_COND);
+    }
     if (a->cf) {
         nullify_over(ctx);
     }
@@ -1223,7 +1248,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
                    TCGv_i64 in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf, bool d)
 {
-    TCGv_i64 dest, sv, cb, cb_msb, tmp;
+    TCGv_i64 dest, sv, cb, cb_msb;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1271,9 +1296,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
 
     /* Emit any conditional trap before any writeback.  */
     if (is_tc) {
-        tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
 
     /* Write back the result.  */
@@ -1439,9 +1462,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     }
 
     if (is_tc) {
-        TCGv_i64 tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
     save_gpr(ctx, rt, dest);
 
-- 
2.34.1


