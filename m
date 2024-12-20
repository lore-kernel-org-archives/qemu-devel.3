Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9D5E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 04:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOUMV-0008VJ-01; Thu, 19 Dec 2024 23:11:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM7-0008MS-GZ
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:15 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tOUM6-0006IK-0f
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 23:11:15 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so1115334a91.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 20:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734667872; x=1735272672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e83Kh8y33SsGtp3mBjjq9S+0kBQxVM7UcwxTwkf4goA=;
 b=FqGhC9IQTSb+lCy5X1v9uNYawfosSiIV4QhBMWwta49UW6817RzPkPvkoRenWAt/9n
 2PplIaGL+sFF2AFdOE5vHLa8sO/EzT0qKhpfLArCNNv9GBfl+qqTlV1N69WboRTmcM39
 IPrjUeb6NFqafXvVZP5kJR1Hsg0VDiJOSk+ME3wMNolOudK3c3PjmVDWOYFrx3FrrmWR
 PYB3W0AABbfC/T4o1ghtZ1VI1Up9dpq2LE98sR3tvRQGvK/QlE3NZiLQ3kaAuMyk9o/o
 rgyizQPEXCBqCy3efG54XrYKkbkpOmFnu6wRtGaFrI0Z59MOyExSKiWtLFlfqNiKHzBi
 VqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667872; x=1735272672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e83Kh8y33SsGtp3mBjjq9S+0kBQxVM7UcwxTwkf4goA=;
 b=RQRPdL5ZxYnDur3QtWNzywoTn/aCtng8FIQk/2mcE/dpesqT7jlUON14tUfg9BJ+00
 /1x1R/Y4S1ojXA+eM+kqjflgo1UjkESTu4hbw8kak/X9fdmBwnCZuOmbpqjHuPNN/4Fx
 wPIAMZOrd4O4ZpE0t6cDfSDPGHW43EMERbSWRZLqxybaIMd1EQGjakLiHyuebN4kR4/b
 R0vEoquSsfr2dAe4fbhc2SKj+lUFLtV1ZcTgz2NIA4XYpx06iBRY0BhEyDJbXx34fcpR
 29YiMVZmeUsdLKE6LdjGs9YWFR+rF6RLBtFZQPo4xm0AfP6aMR8hp9u0sJ4RdJ1LGJOO
 Zx/g==
X-Gm-Message-State: AOJu0Yxg3cV3Rvtb9HwYlNojZ/yUJM3GgBo19LjBY3auKoWO8TEz2REr
 89kGmfOS+ToVn04xdL9W8i4gLH5zQ05c12Rdss2PORnlUUOVc3xoyGor/+hs74Pjm32WmU2dzxY
 S
X-Gm-Gg: ASbGncs469RgKAfKUsuM5SBlpqYmDdfTgnDxCzH2AmLpcSEt94+aKvoO6uspq2P778/
 Go1kJ8mKBQBosm1e29M7ZinUgclUryPmVxeEu57W8y637xKmrY8nj4f8GEtHq0juOA2xd5YdArt
 1z6jYcOZw5ttCay6lDa/mnThfynYukFq8s3qAIAj37o33rhm0WK28uM8PVPE9cEGarkySzedfZA
 NK7wrSmI/N0Ql/zJdugRhup2vyFxfbSHcD3eI+UvjZuThihvuUc1ZZJRSeQk8E=
X-Google-Smtp-Source: AGHT+IEWPQG6KFnFxtWgqNYw96/PRJMPiSLGLlawbaAA+ieHUeRo0Wqd95R6OgDakwAOb7dc3q4p7A==
X-Received: by 2002:a17:90b:2b8e:b0:2ee:3cc1:793b with SMTP id
 98e67ed59e1d1-2f452ec6ed2mr1985899a91.26.1734667872223; 
 Thu, 19 Dec 2024 20:11:12 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee26fc22sm4165260a91.51.2024.12.19.20.11.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:11:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/51] tcg/optimize: Use fold_masks_zs in fold_count_zeros
Date: Thu, 19 Dec 2024 20:10:22 -0800
Message-ID: <20241220041104.53105-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220041104.53105-1-richard.henderson@linaro.org>
References: <20241220041104.53105-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

Avoid the use of the OptContext slots. Find TempOptInfo once.
Compute s_mask from the union of the maximum count and the
op2 fallback for op1 being zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b8e9ded821..270051acd1 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1583,10 +1583,12 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
 
 static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z_mask;
+    uint64_t z_mask, s_mask;
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
 
-    if (arg_is_const(op->args[1])) {
-        uint64_t t = arg_info(op->args[1])->val;
+    if (t1->is_const) {
+        uint64_t t = t1->val;
 
         if (t != 0) {
             t = do_constant_folding(op->opc, ctx->type, t, 0);
@@ -1605,8 +1607,11 @@ static bool fold_count_zeros(OptContext *ctx, TCGOp *op)
     default:
         g_assert_not_reached();
     }
-    ctx->z_mask = arg_info(op->args[2])->z_mask | z_mask;
-    return false;
+    s_mask = smask_from_zmask(z_mask);
+    z_mask |= t2->z_mask;
+    s_mask &= t2->s_mask;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_ctpop(OptContext *ctx, TCGOp *op)
-- 
2.43.0


