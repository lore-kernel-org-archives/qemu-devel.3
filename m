Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FDBC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8E-00068Q-Qq; Wed, 15 May 2024 05:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B83-0005oO-FP
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7x-0001cC-T4
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ff5e3dc3bso36854085e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766047; x=1716370847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oC+Q8BvM2mb+Wj5yO6tGqI0fDdQydJH7QvUSzYQl9rE=;
 b=kEsGhl7gjfTGZIBoA5WrdnkMjjXxnULHFhCuKee3FGCj3FT6OBl+X9t77ptcbOFKO+
 iC5YIi0ZKUGs1cvx+alf24prHTlSUenVuMcaVVS5vvwMJb4zLwkHwCCBTH7a45/HVO/9
 /q96IN+Woj+8fEj4W6eBcVVYEwT1p3s8EpfJ/JmGJgP/6Jzyze1JBJRWVVoctND5Csj2
 j0TEyUMa5P9k1+wrLXOcYbXxrmGhnq88dAtgnIPWvGW/57fHzV8K+J0EKXI16QEv7Iso
 i+v+6+lthNBTjEXG/xo2MC+hwmyhuvKemOzp7kwAjZIf7taQj0xkMfGP5HIxhBgPZ3l4
 IXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766047; x=1716370847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oC+Q8BvM2mb+Wj5yO6tGqI0fDdQydJH7QvUSzYQl9rE=;
 b=h6GihPkR7S7x1keBlI5ZFNUZ1xQgokItWnKSGlCFlDZMvZ7gnRcoc1C1wcVQDQ1F6i
 hryn6aW/wnNsY0dpkLAvy+93hXDOuy1CWIfmYNgaiI9qIRIx6+QvBAcWp28/xSWmHlmT
 CtBtRFviL5tYoRK7Zh89q0roaguevJLQpo5LXsLchnMJWI4CW2SIrgp4u+p1PuKr+5md
 kFVHwQDi1jn/5QHDISbTO27BOps9ONtpbOPlvgDj/Oq/qzLRiPYtkebeD7E7mo+khH3d
 t4wyhMfLi4QL6jMlvFZCuDv/nqxzeohihNP/F6KlzelbjCEv8+SjpJ4CWaXnxpVB9vFB
 oZaA==
X-Gm-Message-State: AOJu0YxWi1Sv9QVe5+0912KJMe7QlLQ00bRKg0uCbcWj6MJCsticah1d
 G04naFMbh278nuBwIcJnxsu6nxULyFbN46hpgu0oN61vLVUw9DEbFexmMVyCEntevPYafvj0nQP
 wUpQ=
X-Google-Smtp-Source: AGHT+IGqqag2iNXEzZg5PWwG1FRQAmr1KYH10MgdPP797llXkNwMY+CY05a9Ig8xcz3JHSxgDOHbQQ==
X-Received: by 2002:a05:6000:4407:b0:350:5960:35ac with SMTP id
 ffacd0b85a97d-35059603661mr8743591f8f.21.1715766047403; 
 Wed, 15 May 2024 02:40:47 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/43] target/hppa: Pass displacement to do_dbranch
Date: Wed, 15 May 2024 11:40:04 +0200
Message-Id: <20240515094043.82850-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

Pass a displacement instead of an absolute value.

In trans_be, remove the user-only do_dbranch case.  The branch we are
attempting to optimize is to the zero page, which is perforce on a
different page than the code currently executing, which means that
we will *not* use a goto_tb.  Use a plain indirect branch instead,
which is what we got out of the attempted direct branch anyway.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 398803981c..4c42b518c5 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1766,9 +1766,11 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
-static bool do_dbranch(DisasContext *ctx, uint64_t dest,
+static bool do_dbranch(DisasContext *ctx, int64_t disp,
                        unsigned link, bool is_n)
 {
+    uint64_t dest = iaoq_dest(ctx, disp);
+
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         if (link != 0) {
             copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -1815,10 +1817,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     /* Handle TRUE and NEVER as direct branches.  */
     if (c == TCG_COND_ALWAYS) {
-        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
-    }
-    if (c == TCG_COND_NEVER) {
-        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
+        return do_dbranch(ctx, disp, 0, is_n && disp >= 0);
     }
 
     taken = gen_new_label();
@@ -3914,22 +3913,6 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 {
     TCGv_i64 tmp;
 
-#ifdef CONFIG_USER_ONLY
-    /* ??? It seems like there should be a good way of using
-       "be disp(sr2, r0)", the canonical gateway entry mechanism
-       to our advantage.  But that appears to be inconvenient to
-       manage along side branch delay slots.  Therefore we handle
-       entry into the gateway page via absolute address.  */
-    /* Since we don't implement spaces, just branch.  Do notice the special
-       case of "be disp(*,r0)" using a direct branch to disp, so that we can
-       goto_tb to the TB containing the syscall.  */
-    if (a->b == 0) {
-        return do_dbranch(ctx, a->disp, a->l, a->n);
-    }
-#else
-    nullify_over(ctx);
-#endif
-
     tmp = tcg_temp_new_i64();
     tcg_gen_addi_i64(tmp, load_gpr(ctx, a->b), a->disp);
     tmp = do_ibranch_priv(ctx, tmp);
@@ -3939,6 +3922,8 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 #else
     TCGv_i64 new_spc = tcg_temp_new_i64();
 
+    nullify_over(ctx);
+
     load_spr(ctx, new_spc, a->sp);
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -3968,7 +3953,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
 {
-    return do_dbranch(ctx, iaoq_dest(ctx, a->disp), a->l, a->n);
+    return do_dbranch(ctx, a->disp, a->l, a->n);
 }
 
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
@@ -4022,7 +4007,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         save_gpr(ctx, a->l, tmp);
     }
 
-    return do_dbranch(ctx, dest, 0, a->n);
+    return do_dbranch(ctx, dest - iaoq_dest(ctx, 0), 0, a->n);
 }
 
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
@@ -4035,7 +4020,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         return do_ibranch(ctx, tmp, a->l, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
-        return do_dbranch(ctx, ctx->iaoq_f + 8, a->l, a->n);
+        return do_dbranch(ctx, 0, a->l, a->n);
     }
 }
 
-- 
2.34.1


