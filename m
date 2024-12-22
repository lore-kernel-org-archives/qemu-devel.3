Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BC4E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOly-0002zd-Rg; Sun, 22 Dec 2024 11:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlY-0002fx-UV
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0003DW-OB
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-216728b1836so27148535ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884712; x=1735489512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOK1W28MXShqpCuXbYvbzRblX4YwEbVma4mzsJO0bMk=;
 b=Qxa7HyRAAoEW10ptDqIq7g1XQ3O3ILk9jpqGL5bGlRS7bwhBNB1hmbaLLsEtXNewXO
 /DTgXthZ1p1VqMlGeY0QJyFuAiwUOl5c1pyfBz2oE+bZ085eqa2LC+dHSlCTbC/oZSFA
 EZ80Bp1a4adaYnPlg3E0z4d8TX4VGTOtviIQje3i5Gz00/N2ox2pV+/KO4DoASqS1XIq
 aLrq5axv3llW8IYf/xLgcYRT94hTx97RbtGJ9OZQ/dVegdDwOnc2G0XR89q/7WPTsvqg
 VBWn92FWbOC6YEnFhj7t4ur2cQGmTyjXwFg4ZwtEROvv6q+PPT/k8Eux3MQLzj7r8HCP
 84SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884712; x=1735489512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOK1W28MXShqpCuXbYvbzRblX4YwEbVma4mzsJO0bMk=;
 b=lit2qKATmj8Tz1xEy0IXS/MXowtFyjXojvZsf36fHcIJGlMU1lO6DztwphTTO46lPU
 JIOzXfAGqX7tji0vTukjJa7BjAEz9Azgebe0jkZ4MI2BFHIEkL9ZuoF2KAYirrDQ5n2l
 EhreOw/tlu65l7AXrBama+H3AWz2OYuooA6sIKyU82qvf829J004u0/LLfuPhXYXSaov
 SRqWJt3uEN/YFZ0OXUssdR9bQFNb1stbmxJ157AuKIylSIG2jfv4f00N88Ja4CK98hgj
 Fc+uzdMw1MyOiZSs7qDHCtzHknZcXwAvalsxjiH3+OklLYu9PnekFu1JXsz2b8S54f5O
 vRIw==
X-Gm-Message-State: AOJu0Yzm99Wr1+hsP/iQaGwicBe2rrPfV9w0TOcolm7xcwfEas5X/qP9
 ERv4bSD63nLr4fwGXSUZTdt5bXiBNNrlcuwVaPONxw+m6x784fin2XkU2RRDDZ1seBY6dNg32O7
 LseI=
X-Gm-Gg: ASbGncu7BPGdrVb96tpvd5PgIKGY53QAWo1RfGjwBhW2Cgp15U8AB3zTOvASVPaOHu7
 1pjnR6hl78siCjaIAwacWI/Vm25xlbIO1CcWWqm6jTOlbTSaQY1CAe/UtbLuZGs0AVZBA3vAObc
 vR8EZm8h8UC8nQJc3uTJYa9XmYq/ON2vZLfCp8G003pGNFEdJ945gEFONFChzaJALtXAi13+UaO
 llKNlxsQ24o8XCzz6Lc2GQ50TUoE1PMoYlVJWuvWnTWCpxdAN0cS94YjRmZ19c=
X-Google-Smtp-Source: AGHT+IEFGwPUvJ55YSWK+wkSvRh1lsEpdO5YjjcWq0pIfa98z0+241ZEov3DVG3+tmYAUJu2rmOsQA==
X-Received: by 2002:a17:903:946:b0:215:a2e2:53fe with SMTP id
 d9443c01a7336-219e6f2f10cmr179599245ad.40.1734884712473; 
 Sun, 22 Dec 2024 08:25:12 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 39/51] tcg/optimize: Use fold_masks_zs in fold_sextract
Date: Sun, 22 Dec 2024 08:24:34 -0800
Message-ID: <20241222162446.2415717-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Avoid the use of the OptContext slots.  Find TempOptInfo once.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3f601e43a7..6bd73f6afa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2490,31 +2490,25 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
 static bool fold_sextract(OptContext *ctx, TCGOp *op)
 {
     uint64_t z_mask, s_mask, s_mask_old;
+    TempOptInfo *t1 = arg_info(op->args[1]);
     int pos = op->args[2];
     int len = op->args[3];
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t;
-
-        t = arg_info(op->args[1])->val;
-        t = sextract64(t, pos, len);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t);
+    if (t1->is_const) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                sextract64(t1->val, pos, len));
     }
 
-    z_mask = arg_info(op->args[1])->z_mask;
-    z_mask = sextract64(z_mask, pos, len);
-    ctx->z_mask = z_mask;
-
-    s_mask_old = arg_info(op->args[1])->s_mask;
-    s_mask = sextract64(s_mask_old, pos, len);
-    s_mask |= MAKE_64BIT_MASK(len, 64 - len);
-    ctx->s_mask = s_mask;
+    s_mask_old = t1->s_mask;
+    s_mask = s_mask_old >> pos;
+    s_mask |= -1ull << (len - 1);
 
     if (0 && pos == 0 && fold_affected_mask(ctx, op, s_mask & ~s_mask_old)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    z_mask = sextract64(t1->z_mask, pos, len);
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_shift(OptContext *ctx, TCGOp *op)
-- 
2.43.0


