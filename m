Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92673E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26W-0004X0-AP; Tue, 10 Dec 2024 10:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26O-0004Jh-68
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:47 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26K-0008N9-Ui
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:43 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea55a2a38bso2953823b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844278; x=1734449078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fDqbz2y4ESqbqsJO0F3l9Ze9RV/p9/mXAODR+b30Yds=;
 b=nNqGnzmn3qpWT+LGVrlJWVCyZdRuwhHJ9m0SUQjOGymmb+gJKOTFUc8kzUNf5Oj4wA
 YFJWGzs+LlMFpyp7itKE4Qb63q4GQ33PDG7yrbQBYGNMc6xyZhwWOLmkg4Ug9xMGpuHf
 PY+ZJVse2ftBSeUKqol01C6gMfhSCLiPwDVXN8TQPP2TC+KxQWJYehTPbVM8gHOESTeX
 J8Ch6WXym2wvb2tDGewpYJlxFJi3LI+K5rkMthJBe8hosamG5EGrwdhsAxXzLcK5ax0k
 mlxB7rYf7DjKdAUnfbBf4nTiLittni2wBAG+Q3QllkkuftxDoa/N7AQXRmy9fIltipVr
 fKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844278; x=1734449078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDqbz2y4ESqbqsJO0F3l9Ze9RV/p9/mXAODR+b30Yds=;
 b=NXjCjgeXyL+TPG9++D53EkpKX6q0lHQorJHfcKyKF5U7DqdD/AA9HIl9cB0dCU45uj
 Rk8ToGd636O0iT0nr/q7Np7SlNv6qWEpmeI0gKzsMrUXfL5VglmAzTkaJAAodr/Th3ez
 2htkkPTv4n54u7DmIqi6W6aodqfCcr9zo2JwvBYdsYb44bDVQelbSPlnrL6lUMNf51zM
 TWtSmOoCvBbEvViMsXxI5iDOkrZUBDRE+AyzB2QDM99feAGiK3zgTcl4EszBKJfFtS8T
 IkuZ1d8mLZHC3fej9Ba1OG3mvyjbDfg0SRpIylZv5O1eo1D1magYiLFef70nia+7KQjU
 Shgw==
X-Gm-Message-State: AOJu0YyGmj2B2CI86F3g5zOuh7cgJCkTvKcxjzGlmN1pKuKXV0E3lmvJ
 Q41gW60SG11HoOjYA1ymnmgH49wVam9oE6x5OvdDZcr6iyOwmQV2L4zsKEI0ANCcLZWz4RscKBT
 W41pu0B9G
X-Gm-Gg: ASbGnct7IQxDLmlZeEtNrVFo6ZK7DHU5pHzspfFGHmjXlSyWJxYxFAiQNheD0cY1qhg
 MrqwDeE3jr4YsihXVmGOW49NwxwkJ5pmjupUeWTHqQaLROxW38Z/v+bVs9jQGRqqaTsRO8Jyo9r
 Xg2NkVoeVLEfYiUEOT7GWP9g3rft9K0HJFLTZwG+WuJPRDA8CABjuZ9SgFGP0jxqKhYByimLMU0
 ef+M4ZbqIUrXwhb4jwk7MXTQgx1BBkaPoO+1/zGhbA2jzTmnuGYvK0iHU8V5Q==
X-Google-Smtp-Source: AGHT+IG+HAoKa598+eEXio+m7wXNTOQxVZTfjC4+U42+m9+8snp8oE6GgaIebg58jmxkNu9jAlGUnA==
X-Received: by 2002:a05:6808:1825:b0:3e6:60dc:5aee with SMTP id
 5614622812f47-3eb66dd9a29mr2879441b6e.3.1733844277745; 
 Tue, 10 Dec 2024 07:24:37 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 23/46] tcg/optimize: Use fold_masks_zs in fold_nor
Date: Tue, 10 Dec 2024 09:23:38 -0600
Message-ID: <20241210152401.1823648-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cc3dc91d3f..aa5242a380 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2039,14 +2039,16 @@ static bool fold_neg(OptContext *ctx, TCGOp *op)
 
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
+    return fold_masks_zs(ctx, op, -1, s_mask);
 }
 
 static bool fold_not(OptContext *ctx, TCGOp *op)
-- 
2.43.0


