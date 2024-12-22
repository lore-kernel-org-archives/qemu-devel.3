Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2640E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOox-00058P-3Y; Sun, 22 Dec 2024 11:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoT-0004oW-Tl
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:18 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoS-0003ib-9A
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:17 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-72764c995e5so2110254b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884894; x=1735489694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PX5Dl1hPMaEJqac+jWE42VLP1j3W8vlrf8LICpuBVgo=;
 b=a1WqJpeiu5095KzbRWvSi7Q71sFLyQD1NYFMDN/xms1Na+PZ1ZF004VsWA419VdaOM
 s1bPOHT6147yZbP7YjOrW34FuXPcwvK2YaBztJ1gpTAWf9oO79sbib7DZDHq7opswtST
 tu1TT4NKZU9luzc8OKrMSs5+Ll9kiktNxeOWSX7jle16pvRccmgzroC0Fbww32Tu39ns
 Y5ztmoyk1wnejhhYYWwunxh30+H/rsIuTjjxMBZ1pOcgpq3gIYlFbVGGs3bFb5lEDx+Q
 42iUdGFF4DbEndEoPOqQxfXkTc5Clh7zmRHEAlbSw8UqLUTMXA8V220lLdCcuIRvmARI
 uG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884894; x=1735489694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PX5Dl1hPMaEJqac+jWE42VLP1j3W8vlrf8LICpuBVgo=;
 b=GHhkc04g/cYp8/YB30YwwwrZihWejHqQDUbCfho4OLQxk8tUlpaMeh9PxiuEO3SEP0
 nF/FKzGd6tTZKmPxWzGDCGXwrPt4Cq+LQj3mi6+tQIgqKRHHqBICoqG7btclLxpJ8iWp
 76VumtHuyYOvWkCdOrMjtpX+X6jAxlt8Xot4foYyDGY9bNA5LejceAHmyiBi4k7j+KiT
 qAZEMDKWFaEyyK4Lywp3YdCL2cVl1wPcXvE2qZ0dhWqTZ15vwo/lZk/jS1EOyZlo+l/1
 a+F0V+U5FLOJG7NKjZnh5cfoLL6IRAvR5tPap4+0CyS5hq9G5Br1OuspDmhZxI0uvdya
 ohkQ==
X-Gm-Message-State: AOJu0YyTwL01AWUo0yNkXfj+frX1ffIAFdgIOHCpenYAY4HDa/NaPzgJ
 8DqzXdqips9D70ZSoqxeoDe0ytlkhLi3c3CEAB9HJuvw8sgRVg+T8BPovBYZ1h7ClE0fF6JletJ
 WA5Y=
X-Gm-Gg: ASbGncsh/X7/d7Q6aBejKPBFAscS3RmJIhTBouBd6sT1zlON7RyuDZVgDQb48igGclV
 CpBPmG9Vpu7lqygk8vWv4HDlKk7fpVSDor6bac1AX41rBa0UeL+8C67bh+eNIqUHqUR3tNglaaX
 cJRJQvf5WSYv8q202wYla1cR42yPGw9gYGmhVljsQwi3pyMR083HV0hRxnIIcj807GKAYLP85oU
 JtDAdY8HH7jx4swnsuhX3nSv95TG0C+3h5Eg6sFEAturmB2eDMtP7ktVLdxRvE=
X-Google-Smtp-Source: AGHT+IFlYPGY7Nk+OxDLAfjlTxGT1JpRMZUPOWD8sn+s/cB6m/hwWwViFtA2qy1Exft118xjBKN9jQ==
X-Received: by 2002:a05:6a20:6a1d:b0:1e1:aba4:2095 with SMTP id
 adf61e73a8af0-1e5e07f9019mr19253069637.32.1734884894136; 
 Sun, 22 Dec 2024 08:28:14 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 40/51] tcg/optimize: Use fold_masks_zs,
 fold_masks_s in fold_shift
Date: Sun, 22 Dec 2024 08:24:35 -0800
Message-ID: <20241222162446.2415717-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 tcg/optimize.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6bd73f6afa..052b5a060e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2514,6 +2514,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask, z_mask, sign;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_ix_to_i(ctx, op, 0) ||
@@ -2521,17 +2522,18 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask;
-    z_mask = arg_info(op->args[1])->z_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    s_mask = t1->s_mask;
+    z_mask = t1->z_mask;
 
-    if (arg_is_const(op->args[2])) {
-        int sh = arg_info(op->args[2])->val;
-
-        ctx->z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
+    if (t2->is_const) {
+        int sh = t2->val;
 
+        z_mask = do_constant_folding(op->opc, ctx->type, z_mask, sh);
         s_mask = do_constant_folding(op->opc, ctx->type, s_mask, sh);
 
-        return fold_masks(ctx, op);
+        return fold_masks_zs(ctx, op, z_mask, s_mask);
     }
 
     switch (op->opc) {
@@ -2540,23 +2542,22 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * Arithmetic right shift will not reduce the number of
          * input sign repetitions.
          */
-        ctx->s_mask = s_mask;
-        break;
+        return fold_masks_s(ctx, op, s_mask);
     CASE_OP_32_64(shr):
         /*
          * If the sign bit is known zero, then logical right shift
-         * will not reduced the number of input sign repetitions.
+         * will not reduce the number of input sign repetitions.
          */
-        sign = (s_mask & -s_mask) >> 1;
+        sign = -s_mask;
         if (sign && !(z_mask & sign)) {
-            ctx->s_mask = s_mask;
+            return fold_masks_s(ctx, op, s_mask);
         }
         break;
     default:
         break;
     }
 
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


