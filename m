Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48ED7C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8c-0008PW-Dg; Wed, 15 May 2024 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8G-0006K4-N5
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8E-0001hM-QI
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:08 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34d7d04808bso5054090f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766065; x=1716370865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtI0L2FbvT0+cE+JqntZXXoDx+OIT8JGAxtjntkSnko=;
 b=MbEIwlkUfdugcFc7ETvedqtp0N/GphYjoD9Wx4dC04736yOlGUii8BnQoIZRWuBGKS
 OTBI1RpAzzfXJaVdUcSdwcnXRQXiLt3gdMyis6jmzT7sGkDoGsnIMQXf0AnrVm1L4jyu
 QQsOhJGkKCNsRdvcwyt2N6NnG9nt+Ws7HczVmWOKjevd8elhLs+a7f7eVEqjGVrJWIgu
 qN+GajlSpWHcfTt3koPqMGlxdlsNmJgyuLPAzSc4oTIorW9Pa/7D8F1OiQmkg7Tm8QVH
 dY6RbhlpLpgMROuk5e31YuIWaB+KXoo3pV6f5vbnK9gDuJSWjEYot/s/2iIMYFBCecLm
 zYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766065; x=1716370865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtI0L2FbvT0+cE+JqntZXXoDx+OIT8JGAxtjntkSnko=;
 b=UMxjofwkD2vXdk7wMkKhDCg1s3XcGSaIWdSHFxXi8erhZJrPjhKXQDVXwUtfaBsypA
 gqQUJnXKCH72jjmOiu71gKHA8rcIB5JP4tUrjYvCzh5WV2xY+z7nV+yGOc7EEh0lG14A
 Ps3ADyE0ETJ0nEW5tJ1ZFwodMKg1Ka8w2OeR73eAYk1iN6IK6+nDOf98jO/9PxwoDO/e
 w2Pl3GZxng09gA6J/P0CI/4+mQLxDRAD8ve/9TDIjrlyar62kCxyoOiBn77i/ojnxS74
 QvR8GjOtU7MamOYrfilPUOHnGMrdvgV0sYNi+QdoYSLccZS/OQwsJ4w0NNomD+E1DDqm
 NSWw==
X-Gm-Message-State: AOJu0Yy1dst1401nld82b1SopoTvO0m3I3vEXKzqdiF3TJ9fu+CPHp3L
 XLLO+l1NNn7kWYI8y2JBvfEu7HMVq91iBoVBMzr0jDr+yVyClpIk4IRughXzrrnNRBdACdainOy
 cQZw=
X-Google-Smtp-Source: AGHT+IGNT7J0qzv4KPH4c5dMBSKbUDkuKSviwlhqYw1sC2Hx4RKoeUQEzq8a7pw4yEQhKaGGgTxh2w==
X-Received: by 2002:a05:6000:4d1:b0:346:59e9:65b6 with SMTP id
 ffacd0b85a97d-351c87e79c6mr5501622f8f.6.1715766065409; 
 Wed, 15 May 2024 02:41:05 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 28/43] target/hppa: Introduce DisasDelayException
Date: Wed, 15 May 2024 11:40:28 +0200
Message-Id: <20240515094043.82850-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

Allow an exception to be emitted at the end of the TranslationBlock,
leaving only the conditional branch inline.  Use it for simple
exception instructions like break, which happen to be nullified.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 60 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 81a75ddf95..706537ea59 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -51,6 +51,17 @@ typedef struct DisasIAQE {
     int64_t disp;
 } DisasIAQE;
 
+typedef struct DisasDelayException {
+    struct DisasDelayException *next;
+    TCGLabel *lab;
+    uint32_t insn;
+    bool set_iir;
+    int8_t set_n;
+    uint8_t excp;
+    /* Saved state at parent insn. */
+    DisasIAQE iaq_f, iaq_b;
+} DisasDelayException;
+
 typedef struct DisasContext {
     DisasContextBase base;
     CPUState *cs;
@@ -66,6 +77,7 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
+    DisasDelayException *delay_excp_list;
     TCGv_i64 zero;
 
     uint32_t insn;
@@ -684,13 +696,38 @@ static void gen_excp(DisasContext *ctx, int exception)
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
+static DisasDelayException *delay_excp(DisasContext *ctx, uint8_t excp)
+{
+    DisasDelayException *e = tcg_malloc(sizeof(DisasDelayException));
+
+    memset(e, 0, sizeof(*e));
+    e->next = ctx->delay_excp_list;
+    ctx->delay_excp_list = e;
+
+    e->lab = gen_new_label();
+    e->insn = ctx->insn;
+    e->set_iir = true;
+    e->set_n = ctx->psw_n_nonzero ? 0 : -1;
+    e->excp = excp;
+    e->iaq_f = ctx->iaq_f;
+    e->iaq_b = ctx->iaq_b;
+
+    return e;
+}
+
 static bool gen_excp_iir(DisasContext *ctx, int exc)
 {
-    nullify_over(ctx);
-    tcg_gen_st_i64(tcg_constant_i64(ctx->insn),
-                   tcg_env, offsetof(CPUHPPAState, cr[CR_IIR]));
-    gen_excp(ctx, exc);
-    return nullify_end(ctx);
+    if (ctx->null_cond.c == TCG_COND_NEVER) {
+        tcg_gen_st_i64(tcg_constant_i64(ctx->insn),
+                       tcg_env, offsetof(CPUHPPAState, cr[CR_IIR]));
+        gen_excp(ctx, exc);
+    } else {
+        DisasDelayException *e = delay_excp(ctx, exc);
+        tcg_gen_brcond_i64(tcg_invert_cond(ctx->null_cond.c),
+                           ctx->null_cond.a0, ctx->null_cond.a1, e->lab);
+        ctx->null_cond = cond_make_f();
+    }
+    return true;
 }
 
 static bool gen_illegal(DisasContext *ctx)
@@ -4697,6 +4734,19 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     default:
         g_assert_not_reached();
     }
+
+    for (DisasDelayException *e = ctx->delay_excp_list; e ; e = e->next) {
+        gen_set_label(e->lab);
+        if (e->set_n >= 0) {
+            tcg_gen_movi_i64(cpu_psw_n, e->set_n);
+        }
+        if (e->set_iir) {
+            tcg_gen_st_i64(tcg_constant_i64(e->insn), tcg_env,
+                           offsetof(CPUHPPAState, cr[CR_IIR]));
+        }
+        install_iaq_entries(ctx, &e->iaq_f, &e->iaq_b);
+        gen_excp_1(e->excp);
+    }
 }
 
 static void hppa_tr_disas_log(const DisasContextBase *dcbase,
-- 
2.34.1


