Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AACFE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOm3-00032L-Vl; Sun, 22 Dec 2024 11:25:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlW-0002du-BT
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:20 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlQ-0003Bs-27
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:10 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21654fdd5daso31032385ad.1
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884705; x=1735489505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/dcJQr0rdJI2Xiobzyir7j9GYDvdzEIMpyigbQ7PkI=;
 b=b3ZpPYsZkp30yZh8gPyyAmfchT3wyUhJNtlp7SzLC932glCSBS6AVbZirQ6Zsk6N6F
 RZXGkpVniaDm7xMFaIwwV+xxYLudBXgbF/XYPzuUhkF6DibMRveP1MJRaXNXXO7R5FTG
 5tL7VorI0xwuHyGYAmYuKur4deud3ZUBRdPSIHhE7IncHtgpnt/Zn7hG1EwJH1K4OIP/
 dc2AGd29kGBlQBmNIQmUt0H0EHYHR1smaHe7CtPmcBQKE4rPK6ID6Nv8kaWQLVech99Y
 VJBZwXi7ea1Sn6iBNSwJ23h4GiU1RZu5eMb5faoT2CSo5Pawj+ItZhrTQcYUR9/zEo7F
 HFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884705; x=1735489505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/dcJQr0rdJI2Xiobzyir7j9GYDvdzEIMpyigbQ7PkI=;
 b=Scb1r9PnaVLmVQ/389alK8VdBYGE6QhhZq+r4qdhEyM1kVQBYxO8mXN/Rq4dzg+OLk
 ocq9t038exDw0Kz2XnP/u59qBetNxNkxzffPol6fuoLRVOX4TxjzY3qJRrWCLJIFW2h6
 aYmHXvlleT1zOBwz6blXgIbJ1WTE1bW8bLaPOomp8uEv6fHiRi6lpce0QnUdgUY3xv7G
 MUJNI0Aj+y/JWNdDOiIBpuz/qSnrUFkAcEv4dDcl4p6pjqzusEBbRUcWj+eDUSdAuCat
 ND1bTvF5LFm9OnWwEkXhP9mN40sJtH8b8Ue8y6S7AR4cuv8JsMHSCpICaf7wRQv7viSR
 3Q/g==
X-Gm-Message-State: AOJu0YzLUPKRfRyNPXsBixGbK7xMEGmgfyatkzGdMjjHNA2M/fZsvx90
 +jrnpS2F7wUsXEUKQwnWl+JMoWDe0jAJ6xsWCBaf9lTC++WcJAbWKVPlrpQGLLA0cTahaiS42dr
 UZAw=
X-Gm-Gg: ASbGncuwMalY+1fWu38j9MTRX51kI69DQ6Mmc9wci3Foi52P/SbIi6ltmlHkgzhPxgF
 /RPjPqvn4nllh4LG7hF2ZumeFc/7WbvGuBdSUD5nWnspgk/4bxiqd+PVMD8TQjCSf4sPpCpkbyX
 n6s+xThBFxWhNiAuag+jY2a8pJlFjtp9mFmaGJxJE1n9XDI3qF2etk7UlRwIk4YjCKKPM+6OQzP
 kMXwylFos0eBU5qI/jzWlaOoW5OOFlO7l5afylxoKZ5CAH6mRICYycCe7HB+Zs=
X-Google-Smtp-Source: AGHT+IHyNeKgF8uf7+S5RCxz88KqEQCg4swOnI/rfK8U7H6ytB2oFZil375FWd0K/Qyhk04o/+C/Tg==
X-Received: by 2002:a17:903:2346:b0:216:3eaf:3781 with SMTP id
 d9443c01a7336-219e6f2eb9amr150603135ad.43.1734884705266; 
 Sun, 22 Dec 2024 08:25:05 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 28/51] tcg/optimize: Use fold_masks_zs in fold_or
Date: Sun, 22 Dec 2024 08:24:23 -0800
Message-ID: <20241222162446.2415717-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/optimize.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e0cb9bf6bb..060d7153f8 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2061,17 +2061,20 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
 {
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1, *t2;
+
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_x(ctx, op, 0) ||
         fold_xx_to_x(ctx, op)) {
         return true;
     }
 
-    ctx->z_mask = arg_info(op->args[1])->z_mask
-                | arg_info(op->args[2])->z_mask;
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
-    return fold_masks(ctx, op);
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z_mask = t1->z_mask | t2->z_mask;
+    s_mask = t1->s_mask & t2->s_mask;
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


