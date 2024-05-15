Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD771C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8S-0007M4-1t; Wed, 15 May 2024 05:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8I-0006QV-HA
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8F-0001hW-E5
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34e0d8b737eso4457048f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766066; x=1716370866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIMB9DvpLVvL8O/ArHYL+McDtTeWMTKUufERzC06JL4=;
 b=HP58Fpspw7D/1dbIgRU7RJnkX+UxyhFGj6OWRB9zFtlfrPlbGILWaVe0EYfb42Vih6
 MOr0psid/Z0DKe7ASmROdzZ4YELmysb5hAEKCEkp0/Y3MUmiiLCZkoYI7lbwsuqf4/C+
 fIyEjzq2ZrHzO/qwcVL3gc3SzylppXJHW/w/O5IyWAZdfrqJQ4974Wbj8pijjOAra9Mz
 eBmWKlH+KYJAXEBYhLB9tyQAi3yVyC9tKR4lZv8cCmuNPf4J4BoIKYWmWNgoocv6Zvsp
 Bsh3INNVBZZqn/OaWXWLXapMwPcAJ3gaY7LXD16m2Q4CK59zuIsLlhpwSJfJF6oULmm2
 GySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766066; x=1716370866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xIMB9DvpLVvL8O/ArHYL+McDtTeWMTKUufERzC06JL4=;
 b=lCN0o9d5aixC2vDEAgSbIrDDg0RMHfu12nCxL3P/xbKinM+PuFLBr96K5zS5gDj4ZR
 IwI9i7N8U78ke2ExA5fO1eD5eD7OUIx/zmIOXeE4DDhREmwlnK7V3oryfewSEW3/pxjg
 nEQHwJh8ODpb5B/2y7v8NDu7pdTe6pGeqbtEU/mjeoHfz7O6zDes8DfuZ9ROD3JKU12n
 LAXs3J7dUUvlORiuzHZr/WmemPCM1351JkpM5025AvvlVZBc18J46Tm69vIzN9R/D4iO
 8e+lIcdafy0rf0j8aqC2aH93aZiB5/HW6Eyrppsr5j0oUJE+XH7/Q5ryQSrTggN7I+mm
 0VTw==
X-Gm-Message-State: AOJu0YyNDGl2rsrGSDvzD6fkzERdDcOVdLGHu6YtILj6yN7Qnp1OC3B5
 rMTHhNg7xj//3MYMHc6MsiWtQTW0oXMKLwHlOOBgBquv3zDUBPbHhUMPGYMyU/BvU4SV/HecLhe
 Ah0U=
X-Google-Smtp-Source: AGHT+IGUVwDWq1hYSerosRez+R6sTIUNVNCuKLBQLbhGZsQQ4qngKDPfFVzAyyHoinmDkUxG8uH6Tw==
X-Received: by 2002:adf:f0c1:0:b0:34d:10a9:3a22 with SMTP id
 ffacd0b85a97d-35049bbf691mr11948821f8f.32.1715766066023; 
 Wed, 15 May 2024 02:41:06 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 29/43] target/hppa: Use delay_excp for conditional traps
Date: Wed, 15 May 2024 11:40:29 +0200
Message-Id: <20240515094043.82850-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
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
index 706537ea59..ae291124f2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1117,6 +1117,25 @@ static TCGv_i64 do_sub_sv(DisasContext *ctx, TCGv_i64 res,
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
@@ -1175,9 +1194,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     /* Emit any conditional trap before any writeback.  */
     cond = do_cond(ctx, cf, d, dest, uv, sv);
     if (is_tc) {
-        tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
 
     /* Write back the result.  */
@@ -1196,6 +1213,10 @@ static bool do_add_reg(DisasContext *ctx, arg_rrr_cf_d_sh *a,
 {
     TCGv_i64 tcg_r1, tcg_r2;
 
+    if (unlikely(is_tc && a->cf == 1)) {
+        /* Unconditional trap on condition. */
+        return gen_excp_iir(ctx, EXCP_COND);
+    }
     if (a->cf) {
         nullify_over(ctx);
     }
@@ -1211,6 +1232,10 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
 {
     TCGv_i64 tcg_im, tcg_r2;
 
+    if (unlikely(is_tc && a->cf == 1)) {
+        /* Unconditional trap on condition. */
+        return gen_excp_iir(ctx, EXCP_COND);
+    }
     if (a->cf) {
         nullify_over(ctx);
     }
@@ -1225,7 +1250,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
                    TCGv_i64 in2, bool is_tsv, bool is_b,
                    bool is_tc, unsigned cf, bool d)
 {
-    TCGv_i64 dest, sv, cb, cb_msb, tmp;
+    TCGv_i64 dest, sv, cb, cb_msb;
     unsigned c = cf >> 1;
     DisasCond cond;
 
@@ -1273,9 +1298,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
 
     /* Emit any conditional trap before any writeback.  */
     if (is_tc) {
-        tmp = tcg_temp_new_i64();
-        tcg_gen_setcond_i64(cond.c, tmp, cond.a0, cond.a1);
-        gen_helper_tcond(tcg_env, tmp);
+        gen_tc(ctx, &cond);
     }
 
     /* Write back the result.  */
@@ -1441,9 +1464,7 @@ static void do_unit_addsub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
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


