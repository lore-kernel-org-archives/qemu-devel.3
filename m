Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7895CE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOls-0002us-LJ; Sun, 22 Dec 2024 11:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlR-0002bG-Jl
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:18 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlP-0003Bb-N5
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:25:09 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so39760345ad.0
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884705; x=1735489505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHMMCbrUVSen8mtbKytkDiC9qapK9hvp01hmIO9UtbI=;
 b=vgeEprtI1hGF6jV8uoNRev5/ZcMv9PzeHcY3pmD/Ylnt5BOkXpg+IYW2dm13oFUuNm
 z0VBno/wLc0EVq9aWr863xT+f5kiKuoSEAK77EPgyaLdF/NipsxXxhqiUABPtuVodCPz
 vKuR8V7nDi6BTRwH23Vr4/oQd7I5tvAiY72c14PDZSzpGX5zV39CjtVVt0bSSijDvO0p
 A1UfqzvLFj5LUddeYqRy8yWmLfrj4miblQs5AbkzS55QpDJdC3RI7ndMSsuwgptsyEuR
 cF5ApZ0FZE585AEnUgAxouZng6z41QL10t38+/k8pX5V38E13zOrRBlVCfo+jCs488hY
 r67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884705; x=1735489505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHMMCbrUVSen8mtbKytkDiC9qapK9hvp01hmIO9UtbI=;
 b=I7Wjq9t8nrdoJ4/OPzeZHlEZ3NB8LyjTbTGLwS9cob326znn+dPGsBxdk1j8eYWmTu
 7W+gGwSqFhvkuTKhFdB48kfnG2sgEc5O/ZslL9XlnlaDkpnb4dm0oa9awE2UVN89Cwte
 tMpvzdAK+WbrYLc6aIbKbHrV2PqZB7SEFrnopQr9WbHXTrgOFnsCV4KIhycxYgSuuSdy
 adbmhKsWsC6c/t51ngcIlEpaVfvvtekcLabaEMjoERWscjy2xEHhCqtYgS7QGAUVS/L8
 tcJNCVoY87rwFFnBbah79Apyo+mfwREPLETU/yZ5akD0qrzNuMV37nkKy1fUEY8bSw5n
 Fzaw==
X-Gm-Message-State: AOJu0YzZ9PuytKoCwnUGbm08j7AtNdJvczDbRw+71OcCrJo3gVFKM7Ec
 8i/vFmlgLrBW5Q1HTjCEPkrkxjauGidcL602LD7khd8uEZ3+3I6TvjiQRtBcLFVUlu8Eu96MGKc
 DupU=
X-Gm-Gg: ASbGncvQZtbVFF8IwIXuqKxGMb+yL4aTml7Hc4yhe4Dd6MuP8dVSer6bAeNvxT8FHOV
 mDMY4wVzu2juj9hvVqBBrjiJ3nkgujNzH0cWSYMVfDzq8um3vavtAuB3x3IMapbZfB3CEjY0Ycg
 5BEW277rwIjZPV4j57xoPnXj5cKZY6/zLkDNe51aOf+yq+BaGyvtwt9nV0FeqvpXQx08ZTiUELM
 FTgHJJ3dVwScG/dHVi7YpG3m05P56W0R0lHEvgnT5r4D6h6JRWDEBZOlJDGVQQ=
X-Google-Smtp-Source: AGHT+IGqzlh7r+rNzIykgpQubOjpHr4wSjr/b+PvlgVJZqkZ/EdO/ULRinS+vd7S2llI0MJBvwBPKA==
X-Received: by 2002:a17:903:41c3:b0:215:8fd3:d1b6 with SMTP id
 d9443c01a7336-219e6d6a221mr154542285ad.23.1734884704696; 
 Sun, 22 Dec 2024 08:25:04 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:25:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 27/51] tcg/optimize: Use fold_masks_s in fold_not
Date: Sun, 22 Dec 2024 08:24:22 -0800
Message-ID: <20241222162446.2415717-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 tcg/optimize.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 4196de9e16..e0cb9bf6bb 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2056,12 +2056,7 @@ static bool fold_not(OptContext *ctx, TCGOp *op)
     if (fold_const1(ctx, op)) {
         return true;
     }
-
-    ctx->s_mask = arg_info(op->args[1])->s_mask;
-
-    /* Because of fold_to_not, we want to always return true, via finish. */
-    finish_folding(ctx, op);
-    return true;
+    return fold_masks_s(ctx, op, arg_info(op->args[1])->s_mask);
 }
 
 static bool fold_or(OptContext *ctx, TCGOp *op)
-- 
2.43.0


