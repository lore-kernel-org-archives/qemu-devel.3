Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4227C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYD-0008Or-Nn; Wed, 24 Apr 2024 20:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXZ-0008Ad-Gs
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXU-0006BI-VM
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:39 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ab88634cfaso396050a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003235; x=1714608035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oF8t7cQPLARGajCa4VkThGHVsE7qiWEOEtD6odytNQQ=;
 b=gCjuLkBkx7pIGDwqcboPjPDXZCsWoVcwzWbeKgmhfx4KZ+wHSXTd5VgxSFbH2kzIix
 eQgZWJOufQAk9H2lsp4bX1nA/k9tGf2noDEmHdoKXVBG9w8Ck8uQW/rDUFC7ZTOYYsc3
 SSVMEp2GfNrH+zv3kHcEPfHNL+4Dx2/irvTd67rqiLeQrXOcwxtKLLXC2G8ucMUBEdnV
 zw8vZDNovEX6lke9bhRLJjx75MmBgl1CfGhfZDdQ5uyZeGQk2PVANTF3dYyNox7TD9EA
 exiYHS0xnOYAsMJdefI5PbJP//I4uZu7lNLbk/nvG5cmQsyIiO1xSeJqxJdZqeNn4z1/
 9w9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003235; x=1714608035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oF8t7cQPLARGajCa4VkThGHVsE7qiWEOEtD6odytNQQ=;
 b=KDdfQf7B2Sz4sFt9Epxi+VHke9jEtfqAmezGjr+dlm+y7Hk4udUwsrO9PT9VZehY5T
 6cJ7IgmS8rWk0vP3pddxr0kk6SWF/OJ9JKuyG2A7FeF1yPTIYXp/S8NImt9vpwsvND5U
 A1GVl+Iz50qXAwct2Sc6WYF/Rsak2WywKdZO3PKh3KqJpgLBh9QrTXMP70RmtlIzyS3t
 a3M2SE2eLQTib1BOep/q/fTfUY75aOw2nvrEy8CqG+g0CCRpOlUzBSv7p7jUuCLn105z
 xiqnrEfgr4Kgl+vF+Jt9ap4fHxpE42KNGWnmQicAiuZT37WFGxm6tCzeac5/nSubvZ2y
 Nynw==
X-Gm-Message-State: AOJu0YwAm6O4uEHJQEDrR4RgHMODxtNnPHUGaYZ8IyMuSQZXAOZK4oJS
 nREZbjR2xIdeNKKRFN0ZK/SJTdtgBJtNOwCez3iBnJ0tCyoy9cPGgpmViZ6caVmt+Qce7W5wi55
 z
X-Google-Smtp-Source: AGHT+IGXd9918aBvz51jXdQO2bfqIIUY/NxnPO8WCCgX1TCNKZe1Jf0BxmV9gpIu6d8wdvvp+8LXaw==
X-Received: by 2002:a17:90a:4a03:b0:2a6:c395:1b95 with SMTP id
 e3-20020a17090a4a0300b002a6c3951b95mr4225371pjh.11.1714003234891; 
 Wed, 24 Apr 2024 17:00:34 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/45] target/hppa: Delay computation of IAQ_Next
Date: Wed, 24 Apr 2024 16:59:47 -0700
Message-Id: <20240425000023.1002026-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

We no longer have to allocate a temp and perform an
addition before translation of the rest of the insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 195a0e7e79..ac181180a6 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1805,6 +1805,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
         ctx->iaoq_n = dest;
+        ctx->iaoq_n_var = NULL;
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
@@ -1861,11 +1862,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
             ctx->null_lab = NULL;
         }
         nullify_set(ctx, n);
-        if (ctx->iaoq_n == -1) {
-            /* The temporary iaoq_n_var died at the branch above.
-               Regenerate it here instead of saving it.  */
-            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
-        }
         gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
     }
 
@@ -4629,8 +4625,6 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
     ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
 #endif
-    ctx->iaoq_n = -1;
-    ctx->iaoq_n_var = NULL;
 
     ctx->zero = tcg_constant_i64(0);
 
@@ -4682,14 +4676,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
         /* Set up the IA queue for the next insn.
            This will be overwritten by a branch.  */
-        if (ctx->iaoq_b == -1) {
-            ctx->iaoq_n = -1;
-            ctx->iaoq_n_var = tcg_temp_new_i64();
-            tcg_gen_addi_i64(ctx->iaoq_n_var, cpu_iaoq_b, 4);
-        } else {
-            ctx->iaoq_n = ctx->iaoq_b + 4;
-            ctx->iaoq_n_var = NULL;
-        }
+        ctx->iaoq_n_var = NULL;
+        ctx->iaoq_n = ctx->iaoq_b == -1 ? -1 : ctx->iaoq_b + 4;
 
         if (unlikely(ctx->null_cond.c == TCG_COND_ALWAYS)) {
             ctx->null_cond.c = TCG_COND_NEVER;
@@ -4740,7 +4728,13 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
                                 ? DISAS_EXIT
                                 : DISAS_IAQ_N_UPDATED);
         } else if (ctx->iaoq_b == -1) {
-            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
+            if (ctx->iaoq_n_var) {
+                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
+            } else {
+                tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
+                tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
+                                 gva_offset_mask(ctx->tb_flags));
+            }
         }
         break;
 
-- 
2.34.1


