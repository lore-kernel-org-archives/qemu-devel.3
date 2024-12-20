Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70869E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMg-00009x-JG; Thu, 19 Dec 2024 23:11:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMI-0008Q8-K6
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:28 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUMG-0006M4-99
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:25 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso1114379a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667883; x=1735272683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=etPXGBNUHIHB3heMgrLuh2eOx7VVtNwo2nGUXXUzJtc=;
 b=zFzXk1GY/Pyl6WwV2fbNnk9P4+W2Bm37pQu8KIgpeQWdgacck9P3bFVTF8V8j0JKNu
 vrVOiKtaHO2pJAlFRXKuUOACeTKUzKfPEPts30qnI+eynkkZIpjm2pdqk06OpVpglU6M
 vCcpYogeOQ2h9pXPZ+4O/whpcDnaYbpmPjSI7IHQMQFr8RYR5UnA8ro8LeTUBoWuPvfI
 ZSmBYcj4ptlbP+prKgIwYLJCFtFa9zWUK624N05knZrRxCIoS2BVIxuaFO/PZ4v5fWoc
 Vv0dNLTOgvNYH1/i+LLrJLwo6sEpx1XZayBA2R2NIIqiLaP9XIcrVEIZRbnCRrc7144j
 ZAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667883; x=1735272683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etPXGBNUHIHB3heMgrLuh2eOx7VVtNwo2nGUXXUzJtc=;
 b=L3PkP4AHg3kLXDN2ckygyWnSUKkU4gb60/phEvgSGSeXJdnC7Moz3zGMaPhmcKCDR4
 vsPnRNHSuqsl/64ox8OdIY/uRkLdhBcprPw6m4EWEkkt/9c6qVkRyOKg7RMSecJdj8rR
 mKlw16VpivkPn/n0UjyGWczO5S88dbqtzEX7wd3F3seLFfIO4f77JIXYtjCxdR04lxD/
 LzpSYG3r5/7zYP88RJXQTnmIrBC8fPickRt8BlINV1E2D9qkmjvMJnGr5QrW/KqD5e5L
 CYtdnF8svNu9o4s3s1/gmVurMSjKlwTTpx2QbksoiVBetXNhORr2d9f9pVeCiWuZBX73
 T+UA==
X-Gm-Message-State: AOJu0Ywhx/iyogTTJDw3Ag0tdPX1obltPfkysrAZyZeRqVt5Hvfi0zi9
 sCbmzmw7HChn3dnJvqLkrS94XD+1qfv3tdMxGX6O+5y3AU6wg/4eUVYmV6xnO8Uxj8cF1Bqjqri
 2
X-Gm-Gg: ASbGnctrE7PzbX81rRKafMggJb8xUrUIC4JSCE2aphdRZoCF32ebAn+NPbgxQABIVjx
 59AW2xQWLDAfOQQV+1VQOk/uu5gLoMmfTOgTb3k4/eIDGvjNGz6hIy2lTWbi8jVTmnMMQbo2MDJ
 xHHyvu8NPCTESu5JFPDnYGfwTg6/zE3E2NKkcWyh4wPMWuHSgT7WrlfaOa8Mc6oEnjpuVbfl9sj
 tronDFZfWZuLUKSG0SttX79D8DRY/r0V5pVkcg+UB/HFSZuL6KOuexo3yZFvhM=
X-Google-Smtp-Source: AGHT+IG5tseq7Kcn+oaT/Rj96/k6woRY4VgcJ8GIZfuuASON/w9+CJuyd/irCv3+lrW9tT17JJDfnw==
X-Received: by 2002:a17:90a:fc4f:b0:2ea:5054:6c44 with SMTP id
 98e67ed59e1d1-2f452eeb641mr1914839a91.31.1734667883027; 
 Thu, 19 Dec 2024 20:11:23 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 25/51] tcg/optimize: Use fold_masks_s in fold_nor
Date: Thu, 19 Dec 2024 20:10:37 -0800
Message-ID: <20241220041104.53105-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
index baf545df24..04f0f8b9d2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2073,14 +2073,16 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
+    uint64_t s_mask;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return false;
+    s_mask = arg_info(op->args[1])->s_mask
+           & arg_info(op->args[2])->s_mask;
+    return fold_masks_s(ctx, op, s_mask);
 }
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


