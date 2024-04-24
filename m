Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D7DC19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmXy-0008JV-GQ; Wed, 24 Apr 2024 20:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXW-0008AP-Uj
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:45 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXS-0006AO-AI
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ed691fb83eso403101b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003231; x=1714608031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mQ9zdVg0xUYM0d85EqWf/ZeSMSQay0WcihJzo1lOuI4=;
 b=dSMMUOooLFpm1qDTpa/UuCDr7oo7sJWdtJ1j8S7Ttb2UpRM2Fs6CAlp6IErJWQtvxE
 5ntrBXkrVOj1bnCuc3lI3tLQLK1Da6j1IDxTkpOSXLB+359IIdZ4qfHID7/YGM9s0rat
 KFp3ndx/NcfGBq2+6ZfTdQYHJh82Rz6QdgDTFiAUqrqsSrhWYkPVBe+rV34tScYv+/uc
 7xS4n+X8lztwCWARNAsX/3WS65DTh0pIK64IXTmmvdrXDM8ijWM/QyAaH6UFL6CcnWnt
 FfYp9zhc0vSUBkc7ikGzcrL0X9IEQQ4GFPzRT6bI/DzRRicE7uIgca6QTcVGUAFVCC1g
 rcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003231; x=1714608031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQ9zdVg0xUYM0d85EqWf/ZeSMSQay0WcihJzo1lOuI4=;
 b=vjlXLU1pXevodQ5Ej+7byN9bUXl+3qd6ACQLlWajt6o6D5SHq0VsRItYzo2etaoblk
 vZeEErKzWH2mr14MaDJgnThSd9itiZcVJX9FaRKKkcucqiqFpqbC1w5OChxxGmJE0XHf
 CtN3SLhfhJgDH9lIAt3Lmn+CWbm+d7ndOefthZv479hDwGZP3+T8Lnv7vUG+lQP91LC2
 7o1k7CNf1YR99XzabzKXGqJfNKSf6sW/aJNGNChrRHTfe4WWnjBz09YIGT7FIFcyjqej
 syGovzYfy876FAXWbe4tldzFPOUuK1/161By64vcIaBEmj5yRHtSdcg1ONzy8gw/JCy8
 hBkw==
X-Gm-Message-State: AOJu0YwLcYjbMD+6wbcIjkT4CenxxG60gB/d2u0mrbtQf8GhbKeF79hV
 aBQRU2+0SFhSbqZwYW8mPHdtTI39yFUDwZyG61rN7wFjqJR2PzyiKMEsYbTDifwQAOkxoQ/jdXP
 w
X-Google-Smtp-Source: AGHT+IHg0FbOvwtruPqd3twnLpXLODehcd6AsyQlV9KfuxSMojxJE8vVTkspbSWZAGh8F/HjhKg/0g==
X-Received: by 2002:a05:6a20:5b12:b0:1a9:c33f:224f with SMTP id
 kl18-20020a056a205b1200b001a9c33f224fmr3828042pzb.16.1714003230122; 
 Wed, 24 Apr 2024 17:00:30 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/45] target/hppa: Pass displacement to do_dbranch
Date: Wed, 24 Apr 2024 16:59:42 -0700
Message-Id: <20240425000023.1002026-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index cb874e1c1e..cbf78a4007 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1765,9 +1765,11 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
 
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
@@ -1814,10 +1816,7 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
 
     /* Handle TRUE and NEVER as direct branches.  */
     if (c == TCG_COND_ALWAYS) {
-        return do_dbranch(ctx, dest, 0, is_n && disp >= 0);
-    }
-    if (c == TCG_COND_NEVER) {
-        return do_dbranch(ctx, ctx->iaoq_n, 0, is_n && disp < 0);
+        return do_dbranch(ctx, disp, 0, is_n && disp >= 0);
     }
 
     taken = gen_new_label();
@@ -3913,22 +3912,6 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
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
@@ -3938,6 +3921,8 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 #else
     TCGv_i64 new_spc = tcg_temp_new_i64();
 
+    nullify_over(ctx);
+
     load_spr(ctx, new_spc, a->sp);
     if (a->l) {
         copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
@@ -3967,7 +3952,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
 
 static bool trans_bl(DisasContext *ctx, arg_bl *a)
 {
-    return do_dbranch(ctx, iaoq_dest(ctx, a->disp), a->l, a->n);
+    return do_dbranch(ctx, a->disp, a->l, a->n);
 }
 
 static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
@@ -4021,7 +4006,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
         save_gpr(ctx, a->l, tmp);
     }
 
-    return do_dbranch(ctx, dest, 0, a->n);
+    return do_dbranch(ctx, dest - iaoq_dest(ctx, 0), 0, a->n);
 }
 
 static bool trans_blr(DisasContext *ctx, arg_blr *a)
@@ -4034,7 +4019,7 @@ static bool trans_blr(DisasContext *ctx, arg_blr *a)
         return do_ibranch(ctx, tmp, a->l, a->n);
     } else {
         /* BLR R0,RX is a good way to load PC+8 into RX.  */
-        return do_dbranch(ctx, ctx->iaoq_f + 8, a->l, a->n);
+        return do_dbranch(ctx, 0, a->l, a->n);
     }
 }
 
-- 
2.34.1


