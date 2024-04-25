Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0060DC19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmbf-00066j-4g; Wed, 24 Apr 2024 20:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmax-0005Fi-7J
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:13 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmat-0007tv-Lb
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:04:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e40042c13eso2910555ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003446; x=1714608246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5vBkU+37mGqQK6oTkMHCKqIJ4geVz8b/nkIOKlsoblU=;
 b=rwrBS0nKNdyvOC1d7q8+NdNUSsShR508MPyUYn9FORWrde6KQShmU1JqflmtUYzhrc
 AT2ZlNZCJhKqc7TUfENn/fRoL1Hka+DCxgS9+pivv6StK2f9NyAk1aAsx1tejMaX0w3N
 ly8sCWKHuztYBfJQPWgX4vDITpJd/AYAOUSV7keZ7SQ/iC0VeBIfq+aV7oo8vKKlEng7
 pqmvVnCU3AVXeo+HqPFbay1wrQrw7k8anehzPNohMtnEEji1TNZnlBY21/JTbe0qKmj4
 LlyzHmmTrveIDm32QejmrzWyJdLNaAWtzr11sjNy/Cn8gFBK1Ngl36dnF5K/15Her1bC
 /zGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003446; x=1714608246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vBkU+37mGqQK6oTkMHCKqIJ4geVz8b/nkIOKlsoblU=;
 b=o3z9jesgCN8i0J0f+ypxBnFM0VrmaIowj+BlHk8fFSAVNJV3ViFIZK2aqXTsSzyRKf
 2oTDVw7nJlSE7u1K3kKSJw4ZEaReDTEiBkkOy5JEPCv7rno0hIroDeOs1utNy/fhW9cf
 kOl0+YDWcGxQ0k/L5tJBUXPYiBN0kLhOmfD9Kc7m7Q098klJPfcXcxz6QXdAjAfmdRiU
 bFmhTZx7lFjBT2dAj1uARX+p2VNXHZGkly0kkhYoGCK3LqtTtQ6kWP7dZ+8GGdQ9blQv
 OkdLedWhlUmMXAQz15scXC90KRCiM5BmDDmmgQigquX/0fzEn/dKBCb3eYHLyAuxPxJ3
 bHFg==
X-Gm-Message-State: AOJu0YycmTghI9w2p46yt3zfsNKZXLYvlsr5M5RSRlgiEPdhlEcEbemP
 N790ePFpuDkRLrHVoAEWGylDattjeAcFzYtiBE564B3Ya/Mchro+oazT/0Wb1nR5R4JSphiT8b0
 8
X-Google-Smtp-Source: AGHT+IFZ4V/kxHAL1r/j8dPqYMC0LoFqSVshiDmdj2f8Uq7VzXC3jmZltCfCnoeWDKA+LK/kl8/JyA==
X-Received: by 2002:a17:902:ea94:b0:1e4:3df0:38a5 with SMTP id
 x20-20020a170902ea9400b001e43df038a5mr3982013plb.65.1714003445872; 
 Wed, 24 Apr 2024 17:04:05 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 y20-20020a170902ed5400b001e0648dfd68sm12483717plb.296.2024.04.24.17.04.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:04:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 42/45] target/hppa: Implement PSW_T
Date: Wed, 24 Apr 2024 17:00:20 -0700
Message-Id: <20240425000023.1002026-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index b3f3f070d3..42c413211a 100644
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
index b2cc81c685..7ad7aa675d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1872,6 +1872,23 @@ static bool do_fop_dedd(DisasContext *ctx, unsigned rt,
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
@@ -1881,6 +1898,9 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
 
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
+        if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+            return true;
+        }
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 nullify_set(ctx, 0);
@@ -1897,7 +1917,9 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
         nullify_over(ctx);
 
         install_link(ctx, link, false);
-        if (is_n && use_nullify_skip(ctx)) {
+        if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+            /* done */
+        } else if (is_n && use_nullify_skip(ctx)) {
             nullify_set(ctx, 0);
             store_psw_xb(ctx, 0);
             gen_goto_tb(ctx, 0, &ctx->iaq_j, NULL);
@@ -1959,7 +1981,9 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
     n = is_n && disp >= 0;
 
     next = iaqe_branchi(ctx, disp);
-    if (n && use_nullify_skip(ctx)) {
+    if (do_taken_branch_trap(ctx, &next, is_n)) {
+        /* done */
+    } else if (n && use_nullify_skip(ctx)) {
         nullify_set(ctx, 0);
         store_psw_xb(ctx, 0);
         gen_goto_tb(ctx, 1, &next, NULL);
@@ -1989,6 +2013,9 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
 {
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, with_sr0);
+        if (do_taken_branch_trap(ctx, &ctx->iaq_j, is_n)) {
+            return true;
+        }
         if (is_n) {
             if (use_nullify_skip(ctx)) {
                 install_iaq_entries(ctx, &ctx->iaq_j, NULL);
@@ -2004,20 +2031,22 @@ static bool do_ibranch(DisasContext *ctx, unsigned link,
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


