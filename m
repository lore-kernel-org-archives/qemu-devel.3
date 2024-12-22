Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891C1E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOls-0002ur-JD; Sun, 22 Dec 2024 11:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0002bA-6c
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:16 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlM-00032c-17
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:06 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so3324335ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884703; x=1735489503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvuX1N9asvoaUrVFs/iIciZyDLibu0peq1RS16B2DH8=;
 b=kPz0SC2JeCIVDN5zZ8MviWYaSr72xMO5nTBx0aLWpIPPV2QtOQdX578O+EjyYQLg6p
 BWdDluEiaSoOOpwdKKJ2iDmDL5d1y/AOJWi6F+lGJgIDJJpN9Imeuy26jQZfjTQtceiu
 u+BOswPMPttQrcR8HvEsRFbsZpKtQX/ca2sn6qwkCBPF3Ge/xmY84k2axvNtAHZtTE6v
 4psqFcqe6kiwe/VHza9ItpZAuga8c3hCG8Xn48nWOlGrX7qH6g9mX/E/yMLxTv+2YmV7
 1NngjtoLk/gRi0zUPInG13V2BcJFpy8ZlgCe08/BiwrvU38L3S0N+J4LfK497FacGUEp
 wj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884703; x=1735489503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GvuX1N9asvoaUrVFs/iIciZyDLibu0peq1RS16B2DH8=;
 b=eqM1zbz+KM1flCQ/t48/LZXZZKUGWuDGRgvZXnbprbYQivA93DDbfifCDDFucFHOyJ
 5LWNdqphMewxpzolsL9Nb/GNQTwHcdH3jNCbwoD3ZR2/kAan15upVH0bicN8i8mI4V4M
 aeG9LSUSHiSnG8CKxDaFHQ7tzJVM/oFb2nEDFeKNsARXC+9nLTT1IykWfJvLy8sWvNW/
 +MzgRz2tZv8QzoFsbV4eLDDruJyyRvHq69Pma+A1Ypi/rfdoesaQ/j/uYPkx9IsXur+5
 Tjj19N4cN6z2ztQztFZosYbFyg1gXfpGXnwz+X1X5VKFnOc/m9PQDvS7RIxif/MNBvHn
 J4aA==
X-Gm-Message-State: AOJu0Ywhg8F6IFQOTrqRveKCptlK13/b8ZYp7Aeix0d7DiciWnYqpSCJ
 iRg51HcDoIglp90rgWZlX/kAJrV2ykwSI8vGXx0O2D8N5HBbsK9rr2Q9rPK5MF+kVE56+v/TWGs
 C5R4=
X-Gm-Gg: ASbGnct96/auYF+t4YrKyLilDKlZsE40H/N9e7DtsiUlSwzcCumzaF96vjP1HlR4XIA
 Q3UFsKiBl5EMmGt3AtrWbpuhStLlAF35+WuboB1JI4VMUg54tdaQ9h3tqN+mFfIfr0eqF0I9Z9D
 k3qcxCGDuzf1IS3VoICPiBpQx0CFhSpI8EQ9qICrhMqtvlOHUkzkjfkgUA73j17DULkFUInMX9v
 BHaUMpGtH+r4eKGECz8FBnUTOrgh6I1gT1iJ0ZGdG1eRMiKnE7ytjSwTujZU5M=
X-Google-Smtp-Source: AGHT+IEzjh55uPg5G+mkIkQDqiOwrGoC1Tek3gcXCJrIUfJA/jXUZSoV8NFBOL27svrvI+gxr0B2sw==
X-Received: by 2002:a17:902:c951:b0:215:a039:738 with SMTP id
 d9443c01a7336-219e6e8928emr142125015ad.5.1734884702777; 
 Sun, 22 Dec 2024 08:25:02 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 24/51] tcg/optimize: Use fold_masks_s in fold_nand
Date: Sun, 22 Dec 2024 08:24:19 -0800
Message-ID: <20241222162446.2415717-25-richard.henderson@linaro.org>
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

Avoid the use of the OptContext slots.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 93e0f30249..c634c20ce7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2011,14 +2011,16 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, -1)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_neg_no_const(OptContext *ctx, TCGOp *op)
-- 
2.43.0


