Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AFCC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmY7-0008Nr-UO; Wed, 24 Apr 2024 20:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXU-00088h-B3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXQ-00069y-9i
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:00:34 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2a58209b159so389516a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003231; x=1714608031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vx4Crlv1lb77eV2HoyqdyEXNFf4xuelX5wyOlguT8YE=;
 b=pXU1Ybqsnd+ITC99TXMMhhTdSYu/aq4Fh8SKzDoI57t+AHSALJ1FGfS6QxI5MppGFq
 lUr/bOul2USYKDrLn9D82HbdnEnNKTknqq1fnKpPT+H/nciN3LmctC3oxOU5fyNXCuAj
 Kef2XCi+Qr3V/Vn/sHRNPKZ/8YvKcRZZAg0sgeNaH6bCyOANSWfGBLLuJ2hnyi4ODCmb
 KgOKhEEnCDFK+nemx4y0eOHQstDmp4WoTU7yBDlOWXcX3/asIbygduyCRWAVfd9SOjUa
 LZHdudY7d1ziIQHTg5XshBqzHENszBvc+pWNkLbZdo1fTcPdMMKcMf65OBiTKJpyx4K5
 xBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003231; x=1714608031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vx4Crlv1lb77eV2HoyqdyEXNFf4xuelX5wyOlguT8YE=;
 b=eqJ98uR4wS3BeXCKoUpXJ44IY7v6lhSp6raMzryYRndMOo+kNMhfSzkH8lCd8NwFnx
 f3jSS/UADgV4WPBtbzWOouMCIT5D4kKNu98lnTJeJetMOLtXVrPb6Fn8bWMdlu4VoeYu
 UQzAFpqvs57nBlBo9k8ABYlfv5QsEnao+LCFDTqx+S2ABGIx+qtgnNl+ZI+zBZIkiv7X
 XKZmx5GkdHYHpGycWo55wa+Ag+azL15GOmdOV51kh/Fh64RZVss5WRRB5tnz7ho5F6vC
 QbG2/8FYKOy/ynAd3gqE3oMwoc/dBKGUho2YuloKH42xtYrORkZKQKgsjMSgwj6uoUC1
 grOA==
X-Gm-Message-State: AOJu0Yz9BrGcza0AfZyAvRFV7huvR1FvNYccNaVsKxJTpp8YncR88ZZM
 mHnWVYxgM5KJo+MCTO7bFhrQDIg8x1IDerlQVrCJDS9/utQA3xyndRxYH2+Dqzcz8t5HjXy/Y/L
 B
X-Google-Smtp-Source: AGHT+IFVF/CGefarNH2I4TzadIzGWNMgwu4jDdZAWibaLBu/0maMaT9FHHi2SKnASosHaglxjzqRTw==
X-Received: by 2002:a17:90a:c404:b0:2ab:de86:d667 with SMTP id
 i4-20020a17090ac40400b002abde86d667mr3736416pjt.48.1714003229321; 
 Wed, 24 Apr 2024 17:00:29 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.00.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/45] target/hppa: Move constant destination check into
 use_goto_tb
Date: Wed, 24 Apr 2024 16:59:41 -0700
Message-Id: <20240425000023.1002026-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
index 42fa480950..cb874e1c1e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -661,9 +661,10 @@ static bool gen_illegal(DisasContext *ctx)
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
@@ -677,16 +678,16 @@ static bool use_nullify_skip(DisasContext *ctx)
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
@@ -4743,8 +4744,7 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
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


