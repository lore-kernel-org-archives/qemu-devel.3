Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46025C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QSZ-0005HR-5H; Mon, 13 May 2024 03:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QSW-0005EA-Jc
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QST-0001yl-7Q
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:50:56 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34f7d8bfaa0so2921723f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586651; x=1716191451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXJrXEo5lvj8nKkiVWwei0sGVNNJi1pj05AdZLYlOuA=;
 b=Knr9wDdZFJS1hOl1g7yUAlBt1SYoMm/ngxKB8ZDoabfLixRJLwb7fnnFYRlvVsf0up
 BnxFybrCQu885oPiEDItVdNmMlUSy5e9HGHNYPDLUIZ/d/fBCMVjnO8Ewhp3wo4yDQfS
 AcIGr+I1QekWmZJUWJ9UASHCpaW5fYvnGAo9HvhIj5A+6zSBzwIeFIVy64+lIwL9oxhY
 BDMa4FpHpH05ByCstdZhf08Tgj32xBr65BLPM6kjwzAIFyREUb72+trsR90ZK+PDlMpo
 wR6T+f82L3LvlNqvBAj7ZGoORr73utw34BJo3qYICwleXwbTu3TTQK4lELPwfW3Tq4rQ
 89oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586651; x=1716191451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OXJrXEo5lvj8nKkiVWwei0sGVNNJi1pj05AdZLYlOuA=;
 b=nUyyEG8y1D7FlUEsrsTtAvxn7WXMqT8cQAf84/PpgkyWpA06frZIS+dgGV++8W2GXI
 wEiFzsX2VFCqpGQhGO+WDtoa05t9z94BUCFEgahDpANmHi6Fiyue60kWg+12H8elImtl
 75gvyVko9g1Oj/LzvB+IXd10ZReXiINMwwaDofeckTwNH7q+NxVN8IBQ3b9zYx2QvN7Y
 dYnGt858nCRGmads2aJEOkr++Z9xXQycF+HU8VnJK0vWnQVK+elvSyA2VtxQCq8LYIPT
 XyJQm/ngq1YAZewmLY8RsXGnsvuGl3CIIz7Fnrscp7MunVN/cYY8WMauBnY+d/5s8YLy
 6pNg==
X-Gm-Message-State: AOJu0Yzm/gygs+cusfwhKtsvB9jAVIMkqS1YCnIm8sP+LY6RN7UnuDrr
 WfPaMdVJJHrUP8SXOBOpPz9UnMeWtTudIv40ziHqdmLlX95aJuQC7Kl9i0IW9ZV+vAxojbF5mud
 kv9w=
X-Google-Smtp-Source: AGHT+IEy1eM5gQjJ9nVtgG/VVDukr7JjpYwiouKvmDReuIdoSEkFMB3C7PT33ZhdfyIv/RVWs87idg==
X-Received: by 2002:adf:ed8d:0:b0:34d:b993:fe6e with SMTP id
 ffacd0b85a97d-3504a20a400mr6013029f8f.0.1715586651394; 
 Mon, 13 May 2024 00:50:51 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a50sm10374262f8f.30.2024.05.13.00.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:50:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 42/45] target/hppa: Implement PSW_T
Date: Mon, 13 May 2024 09:47:14 +0200
Message-Id: <20240513074717.130949-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

PSW_T enables a trap on taken branches, at the very end of the
execution of the branch instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.c       |  4 +--
 target/hppa/translate.c | 55 +++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index f0507874ce..2a3b5fc498 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -76,10 +76,10 @@ void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
         cs_base |= env->iaoq_b & ~TARGET_PAGE_MASK;
     }
 
-    /* ??? E, T, H, L bits need to be here, when implemented.  */
+    /* ??? E, H, L bits need to be here, when implemented.  */
     flags |= env->psw_n * PSW_N;
     flags |= env->psw_xb;
-    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P);
+    flags |= env->psw & (PSW_W | PSW_C | PSW_D | PSW_P | PSW_T);
 
 #ifdef CONFIG_USER_ONLY
     flags |= TB_FLAG_UNALIGN * !env_cpu(env)->prctl_unalign_sigbus;
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 79e29d722f..2290dc8533 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1873,6 +1873,23 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
     return nullify_end(ctx);
 }
 
+static bool do_taken_branch_trap(DisasContext *ctx, DisasIAQE *next, bool n)
+{
+    if (unlikely(ctx->tb_flags & PSW_T)) {
+        /*
+         * The X, B and N bits are updated, and the instruction queue
+         * is advanced before the trap is recognized.
+         */
+        nullify_set(ctx, n);
+        store_psw_xb(ctx, PSW_B);
+        install_iaq_entries(ctx, &ctx->iaq_b, next);
+        gen_excp_1(EXCP_TB);
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return true;
+    }
+    return false;
+}
+
 /* Emit an unconditional branch to a direct target, which may or may not
    have already had nullification handled.  */
 static bool do_dbranch(DisasContext *ctx, int64_t disp,
@@ -1882,6 +1899,9 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
+        if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+            return true;
+        }
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 nullify_set(ctx, 0);
@@ -1898,7 +1918,9 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
         nullify_over(ctx);
 
         install_link(ctx, link, false);
-        if (is_n && use_nullify_skip(ctx)) {
+        if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+            /* done */
+        } else if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
             store_psw_xb(ctx, 0);
             gen_goto_tb(ctx, 0, &ctx->iaq_j, NULL);
@@ -1960,7 +1982,9 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     n = is_n && disp >= 0;
 
     next = iaqe_branchi(ctx, disp);
-    if (n && use_nullify_skip(ctx)) {
+    if (do_taken_branch_trap(ctx, &next, is_n)) {
+        /* done */
+    } else if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
         store_psw_xb(ctx, 0);
         gen_goto_tb(ctx, 1, &next, NULL);
@@ -1990,6 +2014,9 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, with_sr0);
+        if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+            return true;
+        }
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 install_iaq_entries(ctx, &ctx->iaq_j, NULL);
@@ -2005,20 +2032,22 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
     }
 
     nullify_over(ctx);
-
     install_link(ctx, link, with_sr0);
-    if (is_n && use_nullify_skip(ctx)) {
-        install_iaq_entries(ctx, &ctx->iaq_j, NULL);
-        nullify_set(ctx, 0);
-        store_psw_xb(ctx, 0);
-    } else {
-        install_iaq_entries(ctx, &ctx->iaq_b, &ctx->iaq_j);
-        nullify_set(ctx, is_n);
-        store_psw_xb(ctx, PSW_B);
+
+    if (!do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+        if (is_n && use_nullify_skip(ctx)) {
+            install_iaq_entries(ctx, &ctx->iaq_j, NULL);
+            nullify_set(ctx, 0);
+            store_psw_xb(ctx, 0);
+        } else {
+            install_iaq_entries(ctx, &ctx->iaq_b, &ctx->iaq_j);
+            nullify_set(ctx, is_n);
+            store_psw_xb(ctx, PSW_B);
+        }
+        tcg_gen_lookup_and_goto_ptr();
+        ctx->base.is_jmp = DISAS_NORETURN;
     }
 
-    tcg_gen_lookup_and_goto_ptr();
-    ctx->base.is_jmp = DISAS_NORETURN;
     return nullify_end(ctx);
 }
 
-- 
2.34.1


