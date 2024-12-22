Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838BEE7718D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlz-00030X-QF; Sun, 22 Dec 2024 11:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlX-0002eI-Jv
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0003Cz-2R
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:15 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso31421435ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884709; x=1735489509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hWcsFdWHMNsqmzeIjMIP3d8ROfJVABrtxubsRYeHio=;
 b=bkmvbxZVnQ/j4Efq69bq/mQ0XFuuIk4jkzaQnRh3icSGIoGcq226WnvDZv8cncfp+F
 1IE6CLAqNzgOCU9xGjt+z6zfqIZiRLgBhXNE7k2vHj+IE+yg7QefgQHf/tZwJ5vBNf3V
 8QigDaZlIoY53ng2eibG1lSmIVBKRRz6AXi5wbkQHZ8zxspiSk+9Pqpl4P1upz7ab2mi
 fBkeQqxn+XevIvtt4AzqKd7+a0KdZR/bRnfMabB497qKim9YUzn9NjYh0Epfx12rek8O
 Le5biqNp2GdbyQ2OF0AeKRuMj3j98csoJVyqQokyQx4CTE97x5xaTdjGtxvhpSYahDtS
 vjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884709; x=1735489509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hWcsFdWHMNsqmzeIjMIP3d8ROfJVABrtxubsRYeHio=;
 b=bv6hC1dW1urzavUnrNpuNB502dBOErKte0wo+OtJy0rmRE071EiwbFohaJAi0JsOi7
 usU6ivUyPS8rfOxpuZPITupxAh+ILkJvHhNGzK/UNWVgFN/0kRN7ItUTk5eN4kb3+ajo
 y4MtTKM+/30gwqzcszEj/lrUPnlNlw4edRRmewoG1YulnhfpXhqgs2dlInuyVjMC9jAe
 QuGnBTFMIHlFua9CH+rn00fmRg2QGJ0ex8TlxzFjJDePRyOue5E06HctNz9FncYIbN+9
 HJVKnuqila7EcRmDFCEYQ6X7oNYCsb6ynuuhAaklRBom+kQYCGpEmTPT647cHFDAFfTB
 PtOA==
X-Gm-Message-State: AOJu0YyrjNz9JJvudCHs/mk5EZRls8Fv0IyENUwrZumkt1Lu3CtPdJZv
 avG5Rg/PQyl5ApOH7x3t1EE13h69BUlxVCCKcAjqPHiOFAEQ6rQbe3T4VvZZukiHKb7SZHnf7PB
 EWpM=
X-Gm-Gg: ASbGncuFe1M/HsBt/xZ4icedQs7Cr90Qp4mYqH48/4OpNB49wkWSA2s4UswZb3ATm9G
 sTZPQXhs/Wc/933w6qFRc3n+ZLzsM43/ODUoXw0XlYzJTZF+qvlITUsSO14cFXB/bC25PS6VKnP
 slfQAL3pikstLGvLprgRQ0gy+9RaLjw8z/hMlwjhEf/kxYQhbtWzdPwDJmMLqJ+Z8s5QWRuxNYO
 ZyEdZX7wYjdj2ZjVEtKuJFoN1UY3Cln9kREVUjgrzqzob/zRaGgfrQYFFS5wQI=
X-Google-Smtp-Source: AGHT+IG+JDbOBZCK+JA5SPIuCKvcuc4AdwkAjcSmXvlPGPNAJ7jUj7Jz5vDlYLOPP6mYpehty39Jqg==
X-Received: by 2002:a17:903:2a8c:b0:215:9091:4f56 with SMTP id
 d9443c01a7336-219e6e9f997mr146443195ad.14.1734884709376; 
 Sun, 22 Dec 2024 08:25:09 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 34/51] tcg/optimize: Use fold_masks_z in fold_setcond
Date: Sun, 22 Dec 2024 08:24:29 -0800
Message-ID: <20241222162446.2415717-35-richard.henderson@linaro.org>
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
 tcg/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b401287ce1..b6911faca2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2350,8 +2350,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
         fold_setcond_tst_pow2(ctx, op, false);
     }
 
-    ctx->z_mask = 1;
-    return false;
+    return fold_masks_z(ctx, op, 1);
 }
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
-- 
2.43.0


