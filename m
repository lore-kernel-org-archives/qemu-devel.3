Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9B2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 15:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL26R-0004Kv-C4; Tue, 10 Dec 2024 10:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26C-0004Hi-NG
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:32 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL26B-0008LK-1v
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 10:24:32 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb45232717so1258075b6e.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 07:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733844270; x=1734449070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vcSRQjdo00q9esWbI416Hw22GSckeQq1ZoR9QY+R/6U=;
 b=VhwMXKVR/P7vkMSS/4yrHx79U7pGgS2053xn3Nf9qc+0cUQZIgtoGh77uL64dDdXzl
 FBhYZOit0sgw3MHsU9BCDZmiW+xv85SbsR3dv9b9efJQDGb1yEzCeeQHvPDKkGBiTg28
 WlWAR6mkU2E9U/SItmVUNNsiuWEi9gZk5VrAbUJuvd8h45T7qO4DwX1hSX8SFr/e2g0m
 JAfXd1F7MlI6reOxaqtpCn8uf00AOAI+OKu1pDtOIPC/LvkmCVW+xu/cX8UzTPuYUS8Y
 SHjHdx8DTuDBcsFZWJUxuj9mDTOuHzjOR7IMBbbGDcJjIfbLmk+IC1MvsYe/lgMzdYEF
 oMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733844270; x=1734449070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vcSRQjdo00q9esWbI416Hw22GSckeQq1ZoR9QY+R/6U=;
 b=X+1DDGhK7lVACCnO7MuTjJPkH0m2soErb4SD+Wj5J9z44tc31V+RLfIRuA1HPWn5Hf
 Nwmav6F4ylapexDNywJhLAmO5PkhZeRHZc2pk5esM/f59J/Fwp1Qh28HMSAncMa3YH/h
 1wb06RLEyymuHx2fcHD9kHrW+L4yYx1o8RiPYTUc+Qcg7Ub2QQ4NZDTvH85SMZe+WgKZ
 GPti7YBlJdsjC4xvD3+x6k8sqku1Gq/BWHB+0xGUQGAcPBE3fN8Es2KNoD+kLS+PO/Kf
 J4jKxctfrjGz9O+iTGe5QV1e5qSCtgFqNiP4EbrUpSYSZoareAZIjONG4NemRRgjsTwl
 JMbg==
X-Gm-Message-State: AOJu0YxN5ACJNvdzjK63h8FUtJA8z2k/vbPOrQyzNRylLa+H+wTj31lF
 WmdGCZjGqENFdvqg3O1xhQXxd0x6puHfmRN/J4s0TSZ7Ze2NVYsIFTRgC6yrnaRWOOygz+Py/V4
 h+zGgB9nF
X-Gm-Gg: ASbGncs8G2NNidoeJxCsXVSP+mh6hSSCPB9tAwW5HuZ4BFEjkCVM6QjvcFb7ipCevwh
 AlWLpS1/TY9uC21PMxta6NjZL6UmMNlYTe7GFfX3OyktM9QX/F7xww3JfxnYWuzCurlf3RqHwSq
 geVwATs4uvzWEHPQ4CPY4jN+yu+xhT4VuH5aVRQziAKB3eicpeWILQq7IhxoXW84kbKzea9V1lZ
 tVgIaFqJeZca4fFGAtFKpgG6E7nFedFvfUolg5YyVUCJfwBbgFhQfElj4fvew==
X-Google-Smtp-Source: AGHT+IHUSWBuSzOfvJPVbrHaRN4qHA4Q4Sql8oehhWhy6Gz5Wus6txjdE33wwaH4h/C92lhr/rB5BA==
X-Received: by 2002:a05:6808:1dc1:b0:3eb:4b4c:80d8 with SMTP id
 5614622812f47-3eb4b4c8b38mr5286666b6e.0.1733844269891; 
 Tue, 10 Dec 2024 07:24:29 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb076b9168sm2776435b6e.14.2024.12.10.07.24.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 07:24:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/46] tcg/optimize: Use fold_masks_zsa in fold_exts
Date: Tue, 10 Dec 2024 09:23:32 -0600
Message-ID: <20241210152401.1823648-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210152401.1823648-1-richard.henderson@linaro.org>
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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
 tcg/optimize.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index a0ccf7f3f2..5d10e704a7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1759,7 +1759,7 @@ static bool fold_extract2(OptContext *ctx, TCGOp *op)
 
 static bool fold_exts(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask_old, s_mask, z_mask, sign;
+    uint64_t s_mask_old, s_mask, z_mask, a_mask = -1, sign;
     bool type_change = false;
 
     if (fold_const1(ctx, op)) {
@@ -1795,13 +1795,11 @@ static bool fold_exts(OptContext *ctx, TCGOp *op)
     }
     s_mask |= sign << 1;
 
-    ctx->z_mask = z_mask;
-    ctx->s_mask = s_mask;
     if (!type_change) {
-        ctx->a_mask = s_mask & ~s_mask_old;
+        a_mask = s_mask & ~s_mask_old;
     }
 
-    return fold_masks(ctx, op);
+    return fold_masks_zsa(ctx, op, z_mask, s_mask, a_mask);
 }
 
 static bool fold_extu(OptContext *ctx, TCGOp *op)
-- 
2.43.0


