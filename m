Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1C6E77183
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL280-0006hy-6Y; Tue, 10 Dec 2024 10:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26d-0004np-CH
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:25:00 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26b-0008Qk-Qo
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:59 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3eb5a870158so894394b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844296; x=1734449096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f6P3xyzuUO6ajbsFv/D5weUMav3zZ6/9YwAqMDo4N8Q=;
 b=ybUxyOdl1hfr51PtOePA3Wo9rxHWfbs0fkg0AjnPaYvxuw3SV2X/qwT0b8k+nlGeej
 9uO6/AT+L0rrYqHvvnsHVg44t0jixkiWL31ybrRVoBTe9fd/6MBIReYVqePrVpp1C0nr
 GKJ6pF2cnLOkE6sQlrQVpr/eLaTjeTdDfoKfQR6KofZztQS12F49zGdjEbBVKJv4hMIs
 XWltBQ/baDQDuT6/mrENYNvo5T9mfncVZPPK/j1ZNsYVg8uiHP1eolxDhgnx7U2N5yNT
 Vn16UolNqq2cfn6ZRCxIjBETBEYAxAYsFAi1Xi1t63kwQm6q9jtc9fLlztlxseBuxjPL
 mGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844296; x=1734449096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f6P3xyzuUO6ajbsFv/D5weUMav3zZ6/9YwAqMDo4N8Q=;
 b=iwD9ZzkOpSMWReOINcp07Kt2aPxvOEPVpwbT9x07iSjlqgI+JPXpDJ/aII2zfP0B1N
 4uJ61avAqoLDSflU12vGaVpfapOfb81+zn80CK7kxAhDOCHyGJn4WkJuGHvC7ab3S+ff
 SEdyiKuYa5HJ80W2QLvvy3MYoDoSeN+gGOiy1U9V59MKCEnXNhnHlvGpYPEkrqh3rI5b
 /n+xBPxrOW0Ey89XmfJ85alc8lMTle48BOFdTvrHHDW1YBY2uUtyAq/DabgvPWQI8dgt
 EGZpLoWLewuIuknbTfZv2iT00wm39+JElCAEg0raPHj1Km1hC8VJp48CJgBJKi7KdNWA
 nfRA==
X-Gm-Message-State: AOJu0YyJfxNtURqSj59bYTDhf5qsgq/OUcTg094IA49ygZiQi/V0Oj46
 ytZRj2FCX8IkjhADiM2h5UxYWsnE0u7w8SyRL3/bmI1BsDbA7dJ6ETvfZ8VdBuarDls/4i/QQ4u
 sOGVBREzT
X-Gm-Gg: ASbGncu1H4TucH1ecatvowfa2anzXGQLCDU83MYiHHrnGViKXJL5l0q4DzNgcDyIk9w
 UNPSqtMkfmMfpXQUy/zjaZVr7P6bf678xfPrZYKSJsfrdb45tupFDaq9E4zJXGQzMrX3lnLu62k
 rcymIH7mJJ0w8hN7QCzY+Vs8P5OZ8jQNWT29fZJnnAhRmkHyNUI12AertaihVTOAiJy1cE+nI4M
 jr/gKGhLiWZoADFE0qe70qX2rOUhtKq5OrAlPIsX1qi3GzLcSdkciGOrjK8eQ==
X-Google-Smtp-Source: AGHT+IHgRueGUFbhkW5HCogU0sRzGYb/SOOWkxLDetsvvmIvWfgPI0F6xdYKYQr4X2H1jQCJkYpzVw==
X-Received: by 2002:a05:6808:2110:b0:3e7:df63:15bc with SMTP id
 5614622812f47-3eb19c7771dmr12152193b6e.12.1733844296666; 
 Tue, 10 Dec 2024 07:24:56 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/46] tcg/optimize: Use fold_masks_zs in fold_tcg_ld
Date: Tue, 10 Dec 2024 09:23:54 -0600
Message-ID: <20241210152401.1823648-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6412d5df37..4cccb3b0cf 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2636,33 +2636,35 @@ static bool fold_sub2(OptContext *ctx, TCGOp *op)
 
 static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask = -1, s_mask;
+
     /* We can't do any folding with a load, but we can record bits. */
     switch (op->opc) {
     CASE_OP_32_64(ld8s):
-        ctx->s_mask = MAKE_64BIT_MASK(8, 56);
+        s_mask = MAKE_64BIT_MASK(8, 56);
         break;
     CASE_OP_32_64(ld8u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 8);
-        ctx->s_mask = MAKE_64BIT_MASK(9, 55);
+        z_mask = MAKE_64BIT_MASK(0, 8);
+        s_mask = MAKE_64BIT_MASK(9, 55);
         break;
     CASE_OP_32_64(ld16s):
-        ctx->s_mask = MAKE_64BIT_MASK(16, 48);
+        s_mask = MAKE_64BIT_MASK(16, 48);
         break;
     CASE_OP_32_64(ld16u):
-        ctx->z_mask = MAKE_64BIT_MASK(0, 16);
-        ctx->s_mask = MAKE_64BIT_MASK(17, 47);
+        z_mask = MAKE_64BIT_MASK(0, 16);
+        s_mask = MAKE_64BIT_MASK(17, 47);
         break;
     case INDEX_op_ld32s_i64:
-        ctx->s_mask = MAKE_64BIT_MASK(32, 32);
+        s_mask = MAKE_64BIT_MASK(32, 32);
         break;
     case INDEX_op_ld32u_i64:
-        ctx->z_mask = MAKE_64BIT_MASK(0, 32);
-        ctx->s_mask = MAKE_64BIT_MASK(33, 31);
+        z_mask = MAKE_64BIT_MASK(0, 32);
+        s_mask = MAKE_64BIT_MASK(33, 31);
         break;
     default:
         g_assert_not_reached();
     }
-    return false;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
-- 
2.43.0


