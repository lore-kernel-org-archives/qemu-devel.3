Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852BAE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMT-0008Us-HX; Thu, 19 Dec 2024 23:11:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMF-0008Pe-Ob
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:24 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUME-0006LJ-CN
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:23 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso980328a91.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667881; x=1735272681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50pAv+oMelKz+SzYeaXvQfHyrSKx1AQ4ZmtRaoZUtTM=;
 b=kKy4gNfTaxIQyGmZGBlAAPkJZkQdBXTuUiJDMjDt0duvX01TRW+cwi+vBqts6gRH8L
 Jpj8a9wmU7L2MajcbWTqmnBz39nb0SrKIkqrj1dr1yrMfJen3L/XoA1HQ12P4ZkBrmkV
 tyqVBTPRRMID2SX14OFFneYUGuFvqyI7FGq6NwCAIg6PpfCwZxXluoH8pVwLDJzRkshm
 s9xB6cfrJJNsm2o032oh0kNP+KVYPQDlX20rnU1CGS5kKsW0iV71tx5WbnJj5pBkkE4f
 wbGulM3X+KDjhHUcO2O05uMt2Z7NpV0Zi/8cOKhz9WydSrftbnvnYBtI3ed0WCwJD7Ig
 k5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667881; x=1735272681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50pAv+oMelKz+SzYeaXvQfHyrSKx1AQ4ZmtRaoZUtTM=;
 b=GXsd8ncuLtKgpTn3hNJ002Dx5CxKugUC+ysT0THG1HTjJPTxHSANG2/Leow9rErB6F
 lA5IpCTC5YPjXWrczSQdXBChBq7gxsVrFpxs4zRyKX03y8HckkI3B1/DI2DVJRnwco1f
 F7XbC9AWhhiZ4ZGnLkHf22NBeQthmNFL+Y1UXe1QHcOYxFwr07mGr+CvWbYZ/w45SQzO
 64Mx51WFFZhwiwnbyp1eO62UI/MUkyzWW75H0tdcZ+umxjf/c6//Lpsj/A8FRRDku2hN
 KNec7sJ3WVpd3jaJ5hw4Q0BPrzyWNqhsSWvA9aaESwym1LdWp+fA8mmGrQPK4yUscoBr
 cvLQ==
X-Gm-Message-State: AOJu0Yx4/pXYpEmQ9hbXTAomjdijUgumaX+/LZu4mw4iRxEqtXdTZJnZ
 Vins6ouXGlyyCEzCQyjniOQ6c2OFASnphUYQREUgDfFBdMsf26WjOZPPngCir3g4fUHl34F5oCq
 h
X-Gm-Gg: ASbGncv0lICakVNNKHGd6JCtuki+SgIFM1hA3GUTOexsnjqKRdbC4ww7xHieUkDxarB
 +pRWSOEp7BQzGZWkjHAoqtgJCY684u+N1ltWcmHAHACcJ8VMVzEqOP5l+gx443zK/qoMoebRQ9e
 g5RLYPEBG/5zNE+++L3XK5OHB0qV97zyGDpI4jVBwSJcN9LiqSYeeVGrRw/+Vye4qYl0ceat1js
 WlFSB/uFxmQRX5j6MbMOlH/el4qDTpkZMEVsBinqfvheYyox21HuMyt675ymfg=
X-Google-Smtp-Source: AGHT+IHt0mAXMafq9lJqLO3M+QuO/3xYISfRgTBiUK44zqvE4aFipdy9X8jQmoHzZsou6GttaMTM5w==
X-Received: by 2002:a17:90a:c2c8:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f452ec3780mr2098079a91.28.1734667881024; 
 Thu, 19 Dec 2024 20:11:21 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 22/51] tcg/optimize: Use finish_folding in fold_mul*
Date: Thu, 19 Dec 2024 20:10:34 -0800
Message-ID: <20241220041104.53105-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e00d86ab2c..5b71a98cc7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1986,7 +1986,7 @@ static bool fold_mul(OptContext *ctx, TCGOp *op)
         fold_xi_to_x(ctx, op, 1)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
@@ -1995,7 +1995,7 @@ static bool fold_mul_highpart(OptContext *ctx, TCGOp *op)
         fold_xi_to_i(ctx, op, 0)) {
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_multiply2(OptContext *ctx, TCGOp *op)
@@ -2040,7 +2040,7 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         tcg_opt_gen_movi(ctx, op2, rh, h);
         return true;
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_nand(OptContext *ctx, TCGOp *op)
-- 
2.43.0


