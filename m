Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7F8C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYH-0008QG-Ie; Wed, 24 Apr 2024 20:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXa-0008Af-Bi
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:49 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXW-0006C0-LX
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:40 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso320287a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003237; x=1714608037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tPC7wSbqYey/nztPRCYsOGiA7aZBGXEi4HjvhSZ7eFQ=;
 b=n3fwOiNz4XgKciSYQAQW9/3EZbXn6x6KdyS+1JDM8a2y9ALtjUEymAlvPzF2lIUSiv
 k9qYvtB8bo2E3k3mDdWpvXNnL4mtuCgrqMqpGmWilNlMD0GJgz+jTJjpREqE7JeISzil
 OR+fabsBId6GRyWaUEyCiJCJDwhx/k6zDsgi5GEhK05aTX2gszbsi9/LC45xmxhu8iFn
 5AqjjE6eYG1cGQtX4Zt1BMQFo4RI9UqCVxS0QnkRqZw9eXXUfa0h4FMwAA7/aN6ywwCe
 p3GT9rWkXO9lnkPHImxJh4QKkeT5geTpER/Bd+v4At5CRJyk1eNeX8pdg0mwvSwpVVVB
 zFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003237; x=1714608037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tPC7wSbqYey/nztPRCYsOGiA7aZBGXEi4HjvhSZ7eFQ=;
 b=sg2MMKs79E9trrm6709JW94HA8GOGCRj2hMEpoF5qQQwPfgUmviaCQg6qxAcWuA+YS
 2s3cYOx4G4OqkNZOy2K/9aLz2bXDgZbhrjXVvn50NYiX78lQN9euS8a4amMSM2MMDLnU
 IZsvUXPgfgJyEOPBiNyytB0vdMUnMhurLEyN1Ol5AEAVcdyh/shGWgBuY5vKUx6TOumo
 26kwwZum2FYohsNX0vhlXcR4gtZkX9Ya6JGBq/oG2MJfUiVGzhfl2FvZvHiJRdMDdt+e
 VdCp1mDB4fms8S2Pbe7oy8AfEoQdpbYR3hAdIjVtK+a57CB3kv3ZDUQ6SOXVoepumiAJ
 XXHg==
X-Gm-Message-State: AOJu0Yz010BjfwxwVEhkvFtVXvMtNcduOfRuK4W3KTMVMkORYkcUgdJz
 E+XreWDOrWEfV9GjjMCgEWs9zLp4T9rZNqMN+Sdhn8f4haRverSKeoD5n/iHC2XxPc7EMLNnnS+
 z
X-Google-Smtp-Source: AGHT+IHBAwF23KEVnUwUWYD4wJSjMJ5PmFPtFe/Pxiu4V38FhgRWIo32IXz2/+BuKLG5fU8B4FzhMA==
X-Received: by 2002:a17:90b:1e0e:b0:2a2:ea20:2074 with SMTP id
 pg14-20020a17090b1e0e00b002a2ea202074mr4537364pjb.23.1714003236750; 
 Wed, 24 Apr 2024 17:00:36 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/45] target/hppa: Simplify TB end
Date: Wed, 24 Apr 2024 16:59:49 -0700
Message-Id: <20240425000023.1002026-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Minimize the amount of code in hppa_tr_translate_insn advancing the
insn queue for the next insn.  Move the goto_tb path to hppa_tr_tb_stop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 109 +++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6a73b1d409..138250b550 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4698,54 +4698,31 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         }
     }
 
-    /* Advance the insn queue.  Note that this check also detects
-       a priority change within the instruction queue.  */
-    if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
-        if (use_goto_tb(ctx, ctx->iaoq_b, ctx->iaoq_n)
-            && (ctx->null_cond.c == TCG_COND_NEVER
-                || ctx->null_cond.c == TCG_COND_ALWAYS)) {
-            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
-            gen_goto_tb(ctx, 0, ctx->iaoq_b, ctx->iaoq_n);
-            ctx->base.is_jmp = ret = DISAS_NORETURN;
-        } else {
-            ctx->base.is_jmp = ret = DISAS_IAQ_N_STALE;
-        }
+    /* If the TranslationBlock must end, do so. */
+    ctx->base.pc_next += 4;
+    if (ret != DISAS_NEXT) {
+        return;
     }
+    /* Note this also detects a priority change. */
+    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+        ctx->base.is_jmp = DISAS_IAQ_N_STALE;
+        return;
+    }
+
+    /*
+     * Advance the insn queue.
+     * The only exit now is DISAS_TOO_MANY from the translator loop.
+     */
     ctx->iaoq_f = ctx->iaoq_b;
     ctx->iaoq_b = ctx->iaoq_n;
-    ctx->base.pc_next += 4;
-
-    switch (ret) {
-    case DISAS_NORETURN:
-    case DISAS_IAQ_N_UPDATED:
-        break;
-
-    case DISAS_NEXT:
-    case DISAS_IAQ_N_STALE:
-    case DISAS_IAQ_N_STALE_EXIT:
-        if (ctx->iaoq_f == -1) {
-            install_iaq_entries(ctx, -1, cpu_iaoq_b,
-                                ctx->iaoq_n, ctx->iaoq_n_var);
-#ifndef CONFIG_USER_ONLY
-            tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
-#endif
-            nullify_save(ctx);
-            ctx->base.is_jmp = (ret == DISAS_IAQ_N_STALE_EXIT
-                                ? DISAS_EXIT
-                                : DISAS_IAQ_N_UPDATED);
-        } else if (ctx->iaoq_b == -1) {
-            if (ctx->iaoq_n_var) {
-                copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
-            } else {
-                tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
-                tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
-                                 gva_offset_mask(ctx->tb_flags));
-            }
+    if (ctx->iaoq_b == -1) {
+        if (ctx->iaoq_n_var) {
+            copy_iaoq_entry(ctx, cpu_iaoq_b, -1, ctx->iaoq_n_var);
+        } else {
+            tcg_gen_addi_i64(cpu_iaoq_b, cpu_iaoq_b, 4);
+            tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
+                             gva_offset_mask(ctx->tb_flags));
         }
-        break;
-
-    default:
-        g_assert_not_reached();
     }
 }
 
@@ -4753,23 +4730,51 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     DisasJumpType is_jmp = ctx->base.is_jmp;
+    uint64_t fi, bi;
+    TCGv_i64 fv, bv;
+    TCGv_i64 fs;
+
+    /* Assume the insn queue has not been advanced. */
+    fi = ctx->iaoq_b;
+    fv = cpu_iaoq_b;
+    fs = fi == -1 ? cpu_iasq_b : NULL;
+    bi = ctx->iaoq_n;
+    bv = ctx->iaoq_n_var;
 
     switch (is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
-    case DISAS_IAQ_N_STALE:
-    case DISAS_IAQ_N_STALE_EXIT:
-        install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f,
-                            ctx->iaoq_b, cpu_iaoq_b);
-        nullify_save(ctx);
+        /* The insn queue has not been advanced. */
+        bi = fi;
+        bv = fv;
+        fi = ctx->iaoq_f;
+        fv = NULL;
+        fs = NULL;
         /* FALLTHRU */
-    case DISAS_IAQ_N_UPDATED:
-        if (is_jmp != DISAS_IAQ_N_STALE_EXIT) {
-            tcg_gen_lookup_and_goto_ptr();
+    case DISAS_IAQ_N_STALE:
+        if (use_goto_tb(ctx, fi, bi)
+            && (ctx->null_cond.c == TCG_COND_NEVER
+                || ctx->null_cond.c == TCG_COND_ALWAYS)) {
+            nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
+            gen_goto_tb(ctx, 0, fi, bi);
             break;
         }
         /* FALLTHRU */
+    case DISAS_IAQ_N_STALE_EXIT:
+        install_iaq_entries(ctx, fi, fv, bi, bv);
+        if (fs) {
+            tcg_gen_mov_i64(cpu_iasq_f, fs);
+        }
+        nullify_save(ctx);
+        if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
+            tcg_gen_exit_tb(NULL, 0);
+            break;
+        }
+        /* FALLTHRU */
+    case DISAS_IAQ_N_UPDATED:
+        tcg_gen_lookup_and_goto_ptr();
+        break;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.34.1


