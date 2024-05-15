Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A1CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8D-0005va-2C; Wed, 15 May 2024 05:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7y-0005ic-BF
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:50 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B7w-0001c4-Hm
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:40:50 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2db17e8767cso94025541fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766047; x=1716370847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BrG3Zn76z7rLtlJmzfLPoC6MrTK5dndaUipWNrjLnI=;
 b=vOH3ASc2BM7ggTTh4LTZ3sD7DItOH7ZyHEXdm0/oTdNZhUnh9n1TC701+b5O4lQB9y
 mAhpnobVW4/BoSXMh1tkwWnP8FakpJaYatvVILZLN9a/0k+2Naq0CWiTeyn3PNKNrxhk
 1UTbanrdyU3eyBXXxGYIBalEN8GA0J7gFqgwaldrAk/Xry8NarmDfoFnimcl8v02Q+tl
 XZqWLwq1YeHmNFJg3VGiHNlLkaVSxj6LS11zjv0YwpIj9NVkt1QJepG4Oq+sUlIM6bga
 afGeYbpc/2mdRiumgLiYJERfY7yi8h011VS9dsGTtA/1zu4QKMP28b4QGHqwPPztDPEw
 rPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766047; x=1716370847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BrG3Zn76z7rLtlJmzfLPoC6MrTK5dndaUipWNrjLnI=;
 b=P1tLjTXcQssl17UjLy+Ts+X21uWv9+W6kcJ5jwtIRVybMbdE+9p3jyE5EkqWKFyWtE
 C7+skeq4xtMc3Me6bAUxoQDXCaH3Av8xBbW5vRH5vB80BeBFFs4htM4iM/G+/rHYtT06
 63S9HOwo2kNrmVetad0DZoHlD7AGXMnQkqKfe//AjCgO9EEgZFgW/LBf2Qv8VSoaDnyn
 c6KhFR7uugo6tXXJIBrUVd8YmEYUSIG27B85rq7P+Al1lHUvH9NYQDrNGaSdflkuNm/M
 UZiYCqj0V3KgqjZwA5Xp4zCsPKDDNy20GgpToisiIlxPACX7Fl5PNQUJJl3RFkbCHzRK
 MMWA==
X-Gm-Message-State: AOJu0YxVArbf7QC2MBp4E5gBcUFwR03hpnplXGGPEf4kgp/1XpMXjZP2
 VquYg7NpGNLFZio4Hwtq7zGs233iWvMeIe5nmF7SHh0/UiWJlDgxb6tx9i3BCNbj1LE510OC7Rk
 r8qE=
X-Google-Smtp-Source: AGHT+IEWSu1DZHX94M2Nw/DvDykxtELviB+K5bDDK97nke3Vjx3LIAKEWE0PLLl7rMksXBR97Jnw6w==
X-Received: by 2002:a2e:701:0:b0:2e5:87c1:e840 with SMTP id
 38308e7fff4ca-2e587c1ed54mr58589911fa.41.1715766046646; 
 Wed, 15 May 2024 02:40:46 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:40:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 03/43] target/hppa: Move constant destination check into
 use_goto_tb
Date: Wed, 15 May 2024 11:40:03 +0200
Message-Id: <20240515094043.82850-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22e.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
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


