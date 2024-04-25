Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBA8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY6-0008N4-1T; Wed, 24 Apr 2024 20:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXr-0008Gd-5p
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXm-0006Hf-Dl
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e411e339b8so3317675ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003252; x=1714608052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DDHWgjyo2VgO58BUrIJ7Ba+V+lHv8+24gGeXKyuyNL0=;
 b=YCit2llKLxzQiFLcSNb7ru0TGYXwfrEFFBO5Bq7BXgDo5SeH4o5siqPHZZgI1WK9A8
 98v/A6lgK2c5SYWWg5VwLHWmBswnv0lB0A1/RqBoC8zUFmQjWV3AxxUWwq8gguv3fmWw
 j7BmHkH2D9rvyCwPIklyeLDpUYLR6eQsLw+JDfQ7gBewiUjA7cmviWLckDmGPr1z+FNo
 G7mVLGUgtNhdiKsU3IrRMLaFtRLpFmJgtIlYc+/dWYZL/JdcCjapB0MNhjeDc+CZAu37
 pSqagb9k3FcNfg5RtvZ/Fha3YvCHRkn6zuPHwV5ZGdES0SIs2VnKeXHWL6Yk9jWHAddw
 01/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003252; x=1714608052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDHWgjyo2VgO58BUrIJ7Ba+V+lHv8+24gGeXKyuyNL0=;
 b=vKHQvgSJsDDZpFXsgsF/Wtl1lL5/+IERMYc5q2ifFdtPbbnN5CAzSp4Y0G2aDSGD/p
 7zLc2rlvLNiBhTDtsfVxV+EW5UZyN4EKc5T/PBoSfQYCS/vehTergE3aeC4QEX+pUZ+O
 SFRhxItLwhYv7RlEYACeN8Q7xwqtr2SJM8KWds4xLrT+OoG/0xJUXXS4vdLE8yoBfVow
 H2QFimVrib6ph8YnxItF6cUy8gIOCycSgYw/x5bZ9NQBhnrFTxdhVl+91DusmEmxg3qy
 23+ekA61s+E1SrzxzxiNoZm/SjBPTzbrB//ps6zc2nrbkVFOE4EUi2c7tyP0TsQRADY/
 JwVg==
X-Gm-Message-State: AOJu0Ywpiymn5syU6zWpDuSpbYmuWKb5MuDkxTRFiUDuHbxKIwm/RawN
 9SYpICoz/yvZ5hZaREmH+rUPUXialUWEhXJul92heXeocOB3qcTY2BNTaHBkXXdo6haHGNbcvld
 a
X-Google-Smtp-Source: AGHT+IGitze3xNLPwVxQA/BDdERfZn5c+CcyqtnbPUAUjX4t582QHkehCjb5DY1pfBHvYR1N5Nu7bg==
X-Received: by 2002:a17:902:d2c2:b0:1e2:bdfa:9c15 with SMTP id
 n2-20020a170902d2c200b001e2bdfa9c15mr5383672plc.41.1714003252613; 
 Wed, 24 Apr 2024 17:00:52 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/45] target/hppa: Introduce DisasDelayException
Date: Wed, 24 Apr 2024 17:00:06 -0700
Message-Id: <20240425000023.1002026-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 60 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5714e2ad25..7a92901e18 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -50,6 +50,17 @@ typedef struct DisasIAQE {
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
@@ -65,6 +76,7 @@ typedef struct DisasContext {
     DisasCond null_cond;
     TCGLabel *null_lab;
 
+    DisasDelayException *delay_excp_list;
     TCGv_i64 zero;
 
     uint32_t insn;
@@ -682,13 +694,38 @@ static void gen_excp(DisasContext *ctx, int exception)
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
@@ -4695,6 +4732,19 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
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


