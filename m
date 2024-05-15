Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0ACC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8O-0006vH-3Q; Wed, 15 May 2024 05:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B85-0005pG-DO
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B80-0001dE-Kc
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34de61b7ca4so4613999f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766051; x=1716370851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VevRD2WCCARN2+zS8+VlIzPJ5JnBZBdwZruWq63OXg=;
 b=AVmeuSbgxZTgFy4hyW8mrjn4goMb3lR0/l8Z7KU5r7Lsw8JlJDH9dz+r5VkqyVOfLS
 WtxLpUHP/dLIRDIH9i+8z9zxqGgz3FW/t6h5CwFhJm/Xg+fRvJcUXPTEtVjg/ckYzqzj
 LPFDZM0FjStEYrfQMHSui9rAkL0UlpgePgi+kuDYntIw/7dLFDeEwlWk0DVbSDOuXi9w
 UJg9yHkAJyb66At7G4s+Ld4WxYIpB/HoNeb5Ug3vmzREpM3qdUcC1gditTMzkbf28Qjg
 6R2lfPIMhPFbwQ9bzOOh8PGM9fltMw0mriyEBwckTB5oL7OcT8Vdl+JU75vXe/PpSrJn
 MMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766051; x=1716370851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VevRD2WCCARN2+zS8+VlIzPJ5JnBZBdwZruWq63OXg=;
 b=qLTwW/8WBcZXZrMYQod1z9hHkkSnQR7sdMHjnqINezuKrEjguN85VJvkB59zFUCCQO
 i5+UhMNqQYE0ZnduudL+DxYlulc0Vb9N7J0ILUX62M+Rc6kHmAjOYt6fxw2TD7oM+DQ9
 JSqHHiwUv0XlsCv3KeggqZPryx/KkvicOANO5QHNO5A7Ct/q7ua5hiAqS+v1WiA4oL4P
 ztpYYSDy6CbAuMPWeSGI2b+kn3UVvZMXJkLkn3Tm04IGwzCHOCcTijzVEL//MN0YkhDM
 7hCimRyERcurnXjU7wV9ZnrBG4c5QuQpQzTt6tDCzCEv0zUkoz9Q974Xj+kkF3x7VEHJ
 9ydg==
X-Gm-Message-State: AOJu0Yx7b0GQFXNmSRrbR7qejoTh6nV7NKlRpyI/Te1ztQiFamaXF4Zt
 dIT0TVdgBUA+0PDk3ofCYmxxVQFhQn0ui9DMRdd860ecfPAn5j7FmqgXdYCBUj3aXR6T2s6hnCQ
 rTp4=
X-Google-Smtp-Source: AGHT+IH64dnBF/TTWZG8acwspkapYdoea3I3dfNDQxgq6VHCOz1Y3Y/AMG4mp3bUflqklhNjl/ek1A==
X-Received: by 2002:a5d:488a:0:b0:34c:f30f:d7a1 with SMTP id
 ffacd0b85a97d-3504a96ab69mr17431137f8f.61.1715766050979; 
 Wed, 15 May 2024 02:40:50 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 09/43] target/hppa: Delay computation of IAQ_Next
Date: Wed, 15 May 2024 11:40:09 +0200
Message-Id: <20240515094043.82850-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 220665d98e..9189e0350b 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1807,6 +1807,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
     if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
         install_link(ctx, link, false);
         ctx->iaoq_n = dest;
+        ctx->iaoq_n_var = NULL;
         if (is_n) {
             ctx->null_cond.c = TCG_COND_ALWAYS;
         }
@@ -1863,11 +1864,6 @@ static bool do_cbranch(DisasContext *ctx, int64_t disp, bool is_n,
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
 
@@ -4631,8 +4627,6 @@ static void hppa_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->iaoq_f = (ctx->base.pc_first & ~iasq_f) + ctx->privilege;
     ctx->iaoq_b = (diff ? ctx->iaoq_f + diff : -1);
 #endif
-    ctx->iaoq_n = -1;
-    ctx->iaoq_n_var = NULL;
 
     ctx->zero = tcg_constant_i64(0);
 
@@ -4684,14 +4678,8 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 
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
@@ -4742,7 +4730,13 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


