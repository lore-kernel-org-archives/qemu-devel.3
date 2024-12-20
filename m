Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44098E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUR8-0004M0-ES; Thu, 19 Dec 2024 23:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPQ-000137-Mk
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:47 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUPP-0006q8-9M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:14:40 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21670dce0a7so17574775ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734668078; x=1735272878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwXMRrF7RgPRPzXWK+0ltvOBnUKyuGgifKCVeP7036w=;
 b=SjNF/u4hN2Bpc9PyzOojzVfB7McXW25v4qWoTlIVp9OUic+EdR+n9verzSXGJHADHR
 5dNgj1vOPTdFeV8OV0Zyb2Fag4X0jCo6OT44zR9DoKIBJ6U2L/6TkKuVSjmFp4l442b+
 aAaF/BKaSvvFMRZ+1pGNCPe91buL3LThtuIrJd/uwp87I4O1SjNNNmVRPqUXSz0ZMmWn
 HpS6ujLRxbF2fowSZ76iow9nK//hTmQWOjqozbr0KfmFmKMHkt5ReqDQYLJtS3Y4rCCv
 zoKDviIAYBAX86O0fBcqg0qzLDjClyO87Ewde1vmR59sPCt4UzneUWsySfTH2LhpLPCx
 V+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734668078; x=1735272878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwXMRrF7RgPRPzXWK+0ltvOBnUKyuGgifKCVeP7036w=;
 b=NzFVNMKB6w7HAzVvACsm8EcqC6LZtYCM1XCJbrK7tWNr3FmPZWxaQtoc1QJtKaeIm7
 f7hGruL7RAze/wDYiwT6R5btX6CCVhYKcuVrztBRajPxkr4iYcRAgBMt8mCu2Go4eSLG
 fQ/VtbM0YzGPZqrE3wdh/kLFLvtRwFndkAzBUCb7unyEn4o/wvabL7sX+5qsyNR/aZP+
 7d+2tynu0snnX/nuCerI5JhOHQ/g4hb8u2J3Ozc59MMbvFb4JyKaB9AB/CSjmYjjViSA
 L6AUdjlLezDt+2CakMHt0dtflalzBGfvvccYOITrMYnpRtEF7/fdm+sAvBiXTPRjElRg
 igYg==
X-Gm-Message-State: AOJu0YxgEkeFMcw2H3EgNvMnhJ9wc/0bkmx4btVP/tTjsceN/BdkPu31
 NGinuxShxdfViEpDPeS0XvBCFSCOtQJnYcmJG+4tx/NcGfQ6TAj0iaznGTnXGfNlGCQWM4ulFLN
 B
X-Gm-Gg: ASbGncuT2496zKT3uaD1r6bSTSF7EUriU2ff/7uFtvF0I5ki4qRFQqdhRIQtWtt88zT
 3vEH8uRPIJP0w9kEV14TAfQYM4oRPvOPrVwY9qmUfPjJhErS/JfkhTgPPavOEwBODDY9AmZ181S
 Smik7lYWYFvOOa1eQ4pYMmxaVOSE31l25Yc99riLVkdlbDO8As6qmx34D7/Fgd9vP5kpLU+VD9N
 qoxlUwr1e3FgAR6lsqT2BlsmY9e2c6kfTEft6NzNz06lCmUxT9iYHIK73Tm9XQ=
X-Google-Smtp-Source: AGHT+IFHtz8e0cRRkxetDzAZmnuPVm/CKScSq7gMAk+VWFaY8rCWwUHf1zi2VLUuUzn7JvmsccUiyQ==
X-Received: by 2002:a17:903:2c6:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-219e6f262admr18225605ad.45.1734668077958; 
 Thu, 19 Dec 2024 20:14:37 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8529e78a55dsm506952a12.80.2024.12.19.20.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:14:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 43/51] tcg/optimize: Use finish_folding in fold_sub,
 fold_sub_vec
Date: Thu, 19 Dec 2024 20:10:55 -0800
Message-ID: <20241220041104.53105-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Duplicate fold_sub_vec into fold_sub instead of calling it,
now that fold_sub_vec always returns true.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 7219415fe2..bfce2dcf60 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2645,12 +2645,15 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
         fold_sub_to_neg(ctx, op)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub(OptContext *ctx, TCGOp *op)
 {
-    if (fold_const2(ctx, op) || fold_sub_vec(ctx, op)) {
+    if (fold_const2(ctx, op) ||
+        fold_xx_to_i(ctx, op, 0) ||
+        fold_xi_to_x(ctx, op, 0) ||
+        fold_sub_to_neg(ctx, op)) {
         return true;
     }
 
@@ -2662,7 +2665,7 @@ static bool fold_sub(OptContext *ctx, TCGOp *op)
                    ? INDEX_op_add_i32 : INDEX_op_add_i64);
         op->args[2] = arg_new_constant(ctx, -val);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_sub2(OptContext *ctx, TCGOp *op)
-- 
2.43.0


