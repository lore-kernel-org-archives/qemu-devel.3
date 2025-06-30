Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79263C8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGSE-0000iw-UE; Mon, 30 Jun 2025 11:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRb-0000QF-Sk
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:19 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRX-0008Cs-Ic
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:17 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73adf1a0c48so1185284a34.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297345; x=1751902145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+9e/WZAdV+G8EPFJA5xZ6p8rk/j+mp0LoyagvYRyY4=;
 b=y4TIj4qNTYfEUhD/WRoviXWU1DzdA+5fvRnlcjDre+b2h1PYOob0PqbC6+OMBpPYXA
 KLRiD2yzrPHvy/1AUxb7AgpyeHpGmWNstzY5fgLWZ3e7m7UokgNU2rjkJuXh2IeKXOE/
 eIFfgtEuh7hh/meE9CZhKVRNRmBi0dDYZdXe0ptoQioZ5DjN6hMNN7aNIejotkAQg16P
 iYkSl/DRrnF+364h2EQiV/bRSoHIhGv6+BRB9nr3AM8ApsjxCSz+yrxAsx/jwLd2/z1v
 o4QJlkQzcLuhbueG8RNPIEKWw5q7d3YFc4BonGdEBedKzhwgIiYrYelKVmTdWCKsbj9f
 8RTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297345; x=1751902145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I+9e/WZAdV+G8EPFJA5xZ6p8rk/j+mp0LoyagvYRyY4=;
 b=PCfx9iNYe9HHdJqft1n0Q4zlXxG1ULkhXnqFwZyA7ZhHdanLOjf73xqWpKXQL2a5DY
 +UadC5+kel1kb6dqgs+eC8ZTH+9CBsMWVnMRg6xRQ4MDksvkL+rZ1nzEStxNCHcXI6dL
 hoxP3P0nJiP79o3CnaurwWhBeIfR9UgFd2FTLqXChXaPYqjBwAzcOr0clFWPaWk4jslO
 J9LRbUc8ikbIPxRWN03ArKvoqYccdLLNYSqeWEAp3AB7/3xtM2+Xv0SlS0LIHE4kMAfO
 EIp9xBxrAvD8Tc/Iig9IKh3ESfPsRWdwRG4JiCPFBJTYVV83WR9v7HT23/mvKOwx8sa4
 4l5g==
X-Gm-Message-State: AOJu0YwrNukffE/trYXTWptvQAh4XFEwOzKKq1dFzWPA8M/TB6+S2dbh
 eCXI3q7iadiADqxzWr7jsiwqLz/6ox40TQQiQHyKDMadiNNRRw5K6dlpzLxR+vacBL3Hk3RZY5r
 JCpBa
X-Gm-Gg: ASbGncsg4uGLgJkLhkn+7DolbH5kEX89pGe+mOdxDWmo2oK0oDnB5feiH+tF0ROez0g
 j9/PIQHDtqPwTCHvtGeYGREZNrKkfPp8105g/b8X8+zL4lOKTntDSIE/EzZbwePOpJ1R3pFzk2u
 7yukynt38CPN3W6n/u+te9X65osuXwoSLlnjhoi5IBOwbr5vNEAnZLw9NIXO91MVaicOOurRiLl
 T4q6vdGsrdHWJ0ASxnWv4YuCvKCxRJfY6sAdNPHwGXD7QGccRBmbQY76+ZL+LyV3VmTz7VOw56A
 0YqOhBBwOPAw5bxixikDwEpDxCNiEeRLmh6oswYH0a/NCGSp+FbLX5TSmYAsEnqy8prC1g==
X-Google-Smtp-Source: AGHT+IFKE/5FMQWgOxKibGHMmT2qP/sZbZLNCE8z/aJRmysU9Tqn0ETLaLxLx3YN5BQvN7k5uJ/T4Q==
X-Received: by 2002:a05:6830:3c8f:b0:72b:a06b:dd71 with SMTP id
 46e09a7af769-73afc3b9d16mr9167736a34.5.1751297344789; 
 Mon, 30 Jun 2025 08:29:04 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/29] tcg/optimize: Build and use z_bits and o_bits in fold_nor
Date: Mon, 30 Jun 2025 09:28:34 -0600
Message-ID: <20250630152855.148018-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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
 tcg/optimize.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 758f7b142e..29d1f29124 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2231,16 +2231,22 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
 static bool fold_nor(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_not(ctx, op, 0)) {
         return true;
     }
 
-    s_mask = arg_info(op->args[1])->s_mask
-           & arg_info(op->args[2])->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+
+    z_mask = ~(t1->o_mask | t2->o_mask);
+    o_mask = ~(t1->z_mask | t2->z_mask);
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


