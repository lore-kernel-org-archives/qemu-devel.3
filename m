Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532EAE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUPi-0001cb-FX; Thu, 19 Dec 2024 23:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPO-00010u-Dj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:39 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPM-0006pU-Ta
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:38 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-728f337a921so1602974b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668075; x=1735272875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IWo/oKWpUsKxvLdqkhmOJJROWpNHlQx02FmK6Y4F68=;
 b=J6voWO2lWqdzHmsiCapVspq6Sj7RThGn7YIPHzF7FUIteCwg/WxRM05ygvtM+3hj1c
 +2EQ7jLT3XGLYry+HFBCL8iM0rgDmQ3BDEXFdnbel3vyXbmGFDRsicD3+Oqc4Adqb4eV
 GlhU17k3WWk2ly7S2wLh3GZ6VL8GkU3m+AFdyTgcnK+BI7p9weIFMnAYWclelL7UNy1C
 B8E4isRMmUh4rMpgi7UA91TxvAKsOAoB6rRWbX3rcBigwJJg3U1cIGyefMPLZPAQ3SLN
 b5vzx5GSjDiMoi1FX9ohwJ3W6ODeUKdebIBK1BCA/sBfIPdVS7wHvFYNSDmL7a9QBvEO
 +GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668075; x=1735272875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0IWo/oKWpUsKxvLdqkhmOJJROWpNHlQx02FmK6Y4F68=;
 b=KWlf0ZVQBqVTLZTSc5Xqr5DAun2VvXlUO1ZfmMl/mQD9ykhKYLqSrYF/s56pnaSV96
 4LkkUGfqFAqho2BjUQzWMcrhgy3eaHzj7sD3UAsaBEfFKY6i1Z+tQIPVF9PimiLIJuYs
 cU42wjVOa3pWvpsm4gon91MQM94s5C8hezX6h6YRGhACnyLktFyIyDbML1sNBzONwkFm
 uIpWQ+3m+iTqlASG9Gvl69wJZH9++aXpfGJyfXHotR5jup5tn2k4XyT+o0YvJ4pkX8W+
 u1JimFGLTzeiyuaqQylPgLk3fyBLCTJNE+yA4gJZG1GfCPunmCIQ+QjcGh3k94ON/psH
 CCiA==
X-Gm-Message-State: AOJu0Ywkdd4FdCGUhSBKnQYCJ/DPIPAzV5KhK8EGmzS4ALvxjlSvCsV6
 67kG2RGxMBiAmaIpg4ZjAiD9BlbwGSF0GyomFEwX0iEdaSLrKbdlI+hVqM5kWlk2wu5ZqTfI2wN
 f
X-Gm-Gg: ASbGnctzGZuVAhzTUzdywO9/vn3i7tVBlw7P2VKShPWnA8+KIBqQNkWk9Gjg+HJ9rbb
 n8JHaKqY9euwgTQ13KprlkHBUvyJamp6cqZB+kEd9Y+3NihG6r10DUGsNrZA7b1Fp1hXFh8/b+C
 QTzJmBBhAodbBNdh8vgaNgg1qo8Iz82cPigRGJdM3BONsWDXo9enC+rd+iaY3z8xgzbgly8nHST
 0nbtFuqvd8eQFRqQ4CeSV/oapafWNJoV2+3a65RnYyWMlFbwrTCuX2YzLX1IkA=
X-Google-Smtp-Source: AGHT+IGF5mpU3r+t4yPkVucNczxw9L7KD35WSrAxQ0eQLhdp04EXuW7leKGXQuvhOQlR+gcTjTehMw==
X-Received: by 2002:a05:6a20:9d93:b0:1e1:ccfb:221 with SMTP id
 adf61e73a8af0-1e5e0846935mr2794862637.44.1734668075650; 
 Thu, 19 Dec 2024 20:14:35 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 41/51] tcg/optimize: Use fold_masks_zs,
 fold_masks_s in fold_shift
Date: Thu, 19 Dec 2024 20:10:53 -0800
Message-ID: <20241220041104.53105-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 8735dc0c9c..da48aadd12 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2554,6 +2554,7 @@ static bool fold_sextract(OptContext *ctx, TCGOp *op)
 static bool fold_shift(OptContext *ctx, TCGOp *op)
 {
     uint64_t s_mask, z_mask, sign;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
         fold_ix_to_i(ctx, op, 0) ||
@@ -2561,18 +2562,19 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
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
-        ctx->s_mask = smask_from_smask(s_mask);
+        s_mask = smask_from_smask(s_mask);
 
-        return fold_masks(ctx, op);
+        return fold_masks_zs(ctx, op, z_mask, s_mask);
     }
 
     switch (op->opc) {
@@ -2581,23 +2583,22 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
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
         sign = (s_mask & -s_mask) >> 1;
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


