Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4379FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QPC-0002mi-It; Mon, 13 May 2024 03:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP8-0002k5-8N
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QP4-0001Js-UM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:25 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34da35cd01cso3731035f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586441; x=1716191241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DRvEbVFABG0rQ6mtoE7EPY1IsVsNamdAxtlX4BxsiVU=;
 b=ta4I31Tp79zrIyVXar2dtj8scpCYF3YIL5QHZef8T9S8EoC9L4bAQa5DW5Ykoy32c5
 G7MngUMSdpjBxIdtHn2FR5JAwUpzFRk4YvDp/h2pLXkqfvR2lqdUrYyHhhmBq2KA5HfV
 IoUTwh9hzammJg4mrSfL56OY5FqqEpx/iWstJeCQvwO+bUzQbnCzzvAEoZPa1ve5ALN2
 8I38yd1b8pQPWGN064AdbxQla6rPI1JVoxcWtXT+cbR3PPLF8HYaM/0E2ZxPd7wQkeyk
 VZKdZEB79SVtshwNpvIXptaS3EuaCidyeHDWhROOyd6Uo5Osfg5U9EzHGV4hIR2G3QL3
 4dMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586441; x=1716191241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DRvEbVFABG0rQ6mtoE7EPY1IsVsNamdAxtlX4BxsiVU=;
 b=JL/yp9LX41jqK4EN8iuOBtiK3jGDAVSkURn1w0C+pZpP7DOwTQVQm7iFAyl1xyqnuw
 QsrThJbCqNJFPVUOiTEX6v+mJxFqQC34qdmhQeGYHt2FzAtVTrc+u1Lq+noQxeZz17Cr
 BuByqb1PswktebKp4pktr0vMjalNzMQBmS9rdLzljCBhWdiHhRoD1RPKFZMeGJLiME/d
 QSa9qMFOm/G7lokpSw2NPxdz2USt/C6torq+MeJxGOEIn+2LUiZk3g04cfGC8URt0tu1
 bngLHuCdE9IqKpyJP8b7+J70FO/BoVfz4v/Aa+QjwDM+JiRrIMfjYkqvwew7buVKB0iz
 PRRQ==
X-Gm-Message-State: AOJu0YzlSAtquiUfAGkDi+AGFJYaskqqHCmog2AveQt5Nf41AYYTsaH0
 qN8y3ir7aBFyh4O9HHpPuYXYwd0crI7wLxRJ1qMQCvPerxmlylLyeMzEPypMXncJiIs054qoH4P
 7Aiw=
X-Google-Smtp-Source: AGHT+IFT6dh/6W19yMvg3Xn0bdjsyExHe/qmts3FM+WfAe4DB40oTXA2uNbmupm+bBfrK2EblaQ+cw==
X-Received: by 2002:a5d:5262:0:b0:34d:b634:9033 with SMTP id
 ffacd0b85a97d-3504a9691acmr7570268f8f.51.1715586441498; 
 Mon, 13 May 2024 00:47:21 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 03/45] target/hppa: Move constant destination check into
 use_goto_tb
Date: Mon, 13 May 2024 09:46:35 +0200
Message-Id: <20240513074717.130949-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Share this check between gen_goto_tb and hppa_tr_translate_insn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6d45611888..398803981c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -662,9 +662,10 @@ static bool gen_illegal(DisasContext *ctx)
     } while (0)
 #endif
 
-static bool use_goto_tb(DisasContext *ctx, uint64_t dest)
+static bool use_goto_tb(DisasContext *ctx, uint64_t bofs, uint64_t nofs)
 {
-    return translator_use_goto_tb(&ctx->base, dest);
+    return (bofs != -1 && nofs != -1 &&
+            translator_use_goto_tb(&ctx->base, bofs));
 }
 
 /* If the next insn is to be nullified, and it's on the same page,
@@ -678,16 +679,16 @@ static bool use_nullify_skip(DisasContext *ctx)
 }
 
 static void gen_goto_tb(DisasContext *ctx, int which,
-                        uint64_t f, uint64_t b)
+                        uint64_t b, uint64_t n)
 {
-    if (f != -1 && b != -1 && use_goto_tb(ctx, f)) {
+    if (use_goto_tb(ctx, b, n)) {
         tcg_gen_goto_tb(which);
-        copy_iaoq_entry(ctx, cpu_iaoq_f, f, NULL);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, b, NULL);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, b, NULL);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, n, NULL);
         tcg_gen_exit_tb(ctx->base.tb, which);
     } else {
-        copy_iaoq_entry(ctx, cpu_iaoq_f, f, cpu_iaoq_b);
-        copy_iaoq_entry(ctx, cpu_iaoq_b, b, ctx->iaoq_n_var);
+        copy_iaoq_entry(ctx, cpu_iaoq_f, b, cpu_iaoq_b);
+        copy_iaoq_entry(ctx, cpu_iaoq_b, n, ctx->iaoq_n_var);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -4744,8 +4745,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     /* Advance the insn queue.  Note that this check also detects
        a priority change within the instruction queue.  */
     if (ret == DISAS_NEXT && ctx->iaoq_b != ctx->iaoq_f + 4) {
-        if (ctx->iaoq_b != -1 && ctx->iaoq_n != -1
-            && use_goto_tb(ctx, ctx->iaoq_b)
+        if (use_goto_tb(ctx, ctx->iaoq_b, ctx->iaoq_n)
             && (ctx->null_cond.c == TCG_COND_NEVER
                 || ctx->null_cond.c == TCG_COND_ALWAYS)) {
             nullify_set(ctx, ctx->null_cond.c == TCG_COND_ALWAYS);
-- 
2.34.1


