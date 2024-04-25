Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8572C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYI-0008QQ-B6; Wed, 24 Apr 2024 20:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXr-0008H6-AK
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:01 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXo-0006Hw-Dv
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:58 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2a2da57ab3aso420587a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003254; x=1714608054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GBEVyO91JxsJKf4oQcLpJPbZqHPDZDlu1iUToY/k/Bk=;
 b=JJHpycFhRYMopTI2pbvSk/HMj27fMpFAhwYqwQOZqICsrrzkLmZGdXh40gjjvnFvRG
 oJUsRHZyFb1VmuSUBzbWx1Ry3vnbEQNLBqgbdlmIwJ3iEnNbSfWW7Abcg96WrtI2K059
 +c5y7msNnDUceT3L3AUXeLOjDGrXuHmQy4r+rfkWEKizIowWgITRT37oMe30Q5nZ1b3Q
 /HNP2PyW46ggI4qLYpxzGneJTNlyPxYKRZCZllHqMoyAGtLpr4R276o17BNjgWVbuJe4
 yIC2sp11ZprU7f9uWYCCFxkaRJXcJpYv7fxumWOJ7eKDWrekhVqUV605rY6BeIC4fY6j
 pnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003254; x=1714608054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBEVyO91JxsJKf4oQcLpJPbZqHPDZDlu1iUToY/k/Bk=;
 b=wohCwK5IgILkOswAi6gt4k5nHq+MeOr0gDlPaQkJ82I4FAuRfz7Ja/OKqqk/0OZVJp
 ZooS6pVa04l6Dh47JKk/Xyu2gxV+vlOfggisXzGVoq/k+05hfAp6cqpxpKL9U/YyxL8I
 gy75EGE+/Xm917zgDaOIKf0zPthqFZEtToFuplOwaliSlB4nhI5ANVnJZx38fpCKOw0W
 MQ8wSNHqywG1x3e0UVRrLX7QBvUTLpE1uhAT7Ji6TUIAJAWcl3JCuleOMhUJSWsvVfMI
 mEtGcbMJ6s6UChQXTLv6Uea8rJvrRoVHXz1pNI/8I3FUudSogx6bGe5RcSSby5lCXoIy
 PjbA==
X-Gm-Message-State: AOJu0Yz0JOVJxPqOGIjIwicNs5CV/St0X3YbR3EoYMElKLqpqvGM+msl
 2fvk+ovnY0TEMqZ/vDyG2eYU9bwKS2JPygH6/XvtyH2Hf0pZjcHmVM4StFsT8UG+v9YiK1DdGe/
 t
X-Google-Smtp-Source: AGHT+IH7Y4pQv53i6Srbsh6kZDb9I+VL/Cm7SHWp9l5eEiqXInqF8L+Mlg7SqEIepQMV7Iw2exWYyw==
X-Received: by 2002:a17:90b:1081:b0:2af:58fa:f73b with SMTP id
 gj1-20020a17090b108100b002af58faf73bmr2745779pjb.48.1714003254526; 
 Wed, 24 Apr 2024 17:00:54 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/45] target/hppa: Use delay_excp for conditional trap on
 overflow
Date: Wed, 24 Apr 2024 17:00:08 -0700
Message-Id: <20240425000023.1002026-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
 target/hppa/translate.c  | 21 +++++++++++++--------
 4 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index 3d0d143aed..c12b48a04a 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -1,5 +1,4 @@
 DEF_HELPER_2(excp, noreturn, env, int)
-DEF_HELPER_FLAGS_2(tsv, TCG_CALL_NO_WG, void, env, tl)
 
 DEF_HELPER_FLAGS_3(stby_b, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tl)
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 1aa3e88ef1..97e5f0b9a7 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -134,13 +134,13 @@ void hppa_cpu_do_interrupt(CPUState *cs)
         switch (i) {
         case EXCP_ILL:
         case EXCP_BREAK:
+        case EXCP_OVERFLOW:
         case EXCP_COND:
         case EXCP_PRIV_REG:
         case EXCP_PRIV_OPR:
             /* IIR set via translate.c.  */
             break;
 
-        case EXCP_OVERFLOW:
         case EXCP_ASSIST:
         case EXCP_DTLB_MISS:
         case EXCP_NA_ITLB_MISS:
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a8b69fd481..66cad78a57 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -42,13 +42,6 @@ G_NORETURN void hppa_dynamic_excp(CPUHPPAState *env, int excp, uintptr_t ra)
     cpu_loop_exit_restore(cs, ra);
 }
 
-void HELPER(tsv)(CPUHPPAState *env, target_ulong cond)
-{
-    if (unlikely((target_long)cond < 0)) {
-        hppa_dynamic_excp(env, EXCP_OVERFLOW, GETPC());
-    }
-}
-
 static void atomic_store_mask32(CPUHPPAState *env, target_ulong addr,
                                 uint32_t val, uint32_t mask, uintptr_t ra)
 {
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 080a52e5e4..5b0304d0d5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1134,6 +1134,17 @@ static void gen_tc(DisasContext *ctx, DisasCond *cond)
     }
 }
 
+static void gen_tsv(DisasContext *ctx, TCGv_i64 *sv, bool d)
+{
+    DisasCond cond = do_cond(ctx, /* SV */ 12, d, NULL, NULL, *sv);
+    DisasDelayException *e = delay_excp(ctx, EXCP_OVERFLOW);
+
+    tcg_gen_brcond_i64(cond.c, cond.a0, cond.a1, e->lab);
+
+    /* In the non-trap path, V is known zero. */
+    *sv = tcg_constant_i64(0);
+}
+
 static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
                    TCGv_i64 in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf, bool d)
@@ -1176,10 +1187,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 orig_in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2, orig_in1, shift, d);
         if (is_tsv) {
-            if (!d) {
-                tcg_gen_ext32s_i64(sv, sv);
-            }
-            gen_helper_tsv(tcg_env, sv);
+            gen_tsv(ctx, &sv, d);
         }
     }
 
@@ -1280,10 +1288,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
-            if (!d) {
-                tcg_gen_ext32s_i64(sv, sv);
-            }
-            gen_helper_tsv(tcg_env, sv);
+            gen_tsv(ctx, &sv, d);
         }
     }
 
-- 
2.34.1


