Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20734E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlx-0002yO-MD; Sun, 22 Dec 2024 11:25:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0002bC-6l
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlL-000308-KO
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:06 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-215770613dbso22805265ad.2
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884702; x=1735489502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ups559X2JSn0eiwBpjRnVVsSX3OoK0AYX8hamX615ho=;
 b=U8jfovs3HD6OWKJ3TpkRITcfOLDPLoKuzhMmI5YUJR2+7g4lsYNus6qVUoLfoI23n+
 D2QPQK8gXP2tl7NukXbhV7spxNYdiZmIM5bV6tTpAUBAQhJ+q6gtXWN3yFGv0skkRSYi
 gn/7iRYyz9tynj6dYUAia6sE+SS01Cb0UGS2jdjoSAlvBErJWmP6l6wqfj8f1VwijKGU
 PrB2E/IFJwa7zzKyzu8lPlskfCz9qbImGD29T5zfm0S7FNY7b0pZVY2SEw12CamajywZ
 FNF/0oNTxnGjLgKcSA0VVq6B6cajki/IskCztGbFniiWMWRlqB0TGt0+EDkCKx2RhlpK
 0c6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884702; x=1735489502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ups559X2JSn0eiwBpjRnVVsSX3OoK0AYX8hamX615ho=;
 b=Tw4YVBfPuqq2nFvoLwVwNwa69ZSy3PVbY5CeBKXLGO19FV56q3k7Y0CVpfgR0XLhut
 M8+EZmo/6qnUJlqQ5ZM788o9QYMdyCdNmOOnvKlx6v0aieuL4uhF03qZBnXsiph6RfRT
 xVhk6oTBWgdDaVojYLM2MA8psYWZYjiaN7NBkRgGVkQoN0o/1iqL0RfdMDcxMoiM6WxU
 KS7ATpoERkG3f0iH7g2Xm24Q7DNouNmXbkwY3cpqaZ8ccme2o8SiA+qordvIPEWYPkDR
 cJPr77mIZ9MHCP3jSAFQ4HLY2+xHZpXkZduoYZv/UW3S+oEH6U69B0nc3nyiMli/kf17
 HH+A==
X-Gm-Message-State: AOJu0YyCK+JOVC2tQK3hKyRPwHzn+emDy7N4T7n90QlAYJJW+F3VdjFI
 0vgxTLm8d5XjrRYiIMVRtc6pTuhhNJajZA24qzOtqiGnUSuAohkUEqALDZSB/VNLvaYJIezZIq2
 O/PA=
X-Gm-Gg: ASbGncsOXdyO/tlMl4xi88aW526MwkmtyFUw+0EL4muc3XJYqdwgcHppiMjrnIIYJpd
 Lw3vcI+1iWLtNrC7tgzQbMO6j8ss/kOV6gH53wbfzgKcJPBt3tcXyB0Aj3C5BmZWbmeq0O6i/N7
 Nt510kFwFhDlzH/0tdB0Tghr09fjlzd5/zeIZGi8WPtXdR1IFQjPhYH7QnE6PCSF6MN9IXJeInM
 5GPkd158CDSVEe2Th0FSUXqJ70lnOGjqtAuKHrbH98KRbV2APza5my1zH2bE/8=
X-Google-Smtp-Source: AGHT+IFgX+iOn0GbgahR/YB/Y/52nLlwxQ/Z8SD5HB+hsCz2uFE7hxruSE3nYkJpch2I8Ye7gGccYA==
X-Received: by 2002:a17:903:2acb:b0:215:6b4c:89fa with SMTP id
 d9443c01a7336-219e6e85aacmr130268435ad.8.1734884702183; 
 Sun, 22 Dec 2024 08:25:02 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 23/51] tcg/optimize: Use finish_folding in fold_mul*
Date: Sun, 22 Dec 2024 08:24:18 -0800
Message-ID: <20241222162446.2415717-24-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 5493d76ceb..93e0f30249 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1952,7 +1952,7 @@ static bool fold_mul(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
@@ -1961,7 +1961,7 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
         fold_xi_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
@@ -2006,7 +2006,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         tcg_opt_gen_movi(ctx, op2, rh, h);
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
-- 
2.43.0


