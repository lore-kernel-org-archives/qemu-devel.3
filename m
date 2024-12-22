Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65385E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOlu-0002vK-GM; Sun, 22 Dec 2024 11:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlE-0002Yy-UT
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:57 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOlD-0002xJ-As
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:24:56 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21644aca3a0so36717845ad.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884693; x=1735489493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yLoYd7LYlkkdyNtb51Sc6VhwN2eeW+RxhkgiIYD3vM=;
 b=pXOYd8VLfy4SHYNlWyGYkEaRR1phCt7/hVueowTmBTqxY+N9551CdHzrz1nmH2o7v7
 l0FDaq0seffcRtPsJFhN0UnNMGjRXOO5l8waKOYde0VQXQvaiusqQ6FI1bYXAC9Rnv8U
 VcyV3ANGCKo9xK19hmudEnrGN30Tlk6/tGjDtnSli4/n67YF4Crck9cT4BWrspJRgzYq
 mKZ66We+JxzkUV4LCUcp8LIPeDQIrzcprHzZvdKOBjsNzeLqbAQGHTY8NnKtWZf5IqvN
 syZXqXqScjm3Kdq0bXJr8hc3gxOc7U85Ya20VVcHZHaiLW5Ib1HYJeTYOVkRtHU5cQ7O
 n4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884693; x=1735489493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yLoYd7LYlkkdyNtb51Sc6VhwN2eeW+RxhkgiIYD3vM=;
 b=PIVHCQzcIdTjHYrZbaFletILClfwJUiC0qgnJ93HJ2uIFwQ40WWMA0jlzcQt5j88dx
 wjraoZst95wqo544HDV+pvpfFwLCdUrQeNNqplbdKeDzWZCJzyIiR6RfvBnTxNyRRMgI
 tJJ6YDC0GeAadmf2hqP4U91tO3bvCGax3f74PcCNW/jbose1jgK28AUTKj/u4kPb0Q1d
 gJJIre2FPFeiPhXFSey1dWfq4k0VCGI27ehmrOrGqCHEPM9SPatLpB/6Vm8cm4jEuAVn
 fNnjxQu5VxeLpSOJFhWmaJfspKG7sZ+B3kA6yvG93MqjoxEAeai12IxWW6CZdJw1fiuu
 ss7g==
X-Gm-Message-State: AOJu0YwSMytQKtQ5Ajr9AE5zJxQMDY4Xa1YTODCN8lVkBPl1ioKYYwTc
 XUOX4uhC2xlxNJ47je0Tg7htr5UnG1jcTPCChKUqNt4vdDxqZGtkazofmnZgGrslevyUAb60Tjl
 xW1o=
X-Gm-Gg: ASbGncs4UcOx2msxU84w9OEUujiG+tS6215YC8VLw8SljovGfNs6yfrD1lhddkyuo0w
 v22DwQa1yMZchYGizSZ7ink3M4MZyr1v7csXgWBaVDUR5ypPefEjRmUyhgN1gCPVfPnyh1nqD8B
 6zWLZBB2gVASX+/TbdW+VI8dD50UrViErKmatYvZfzTYfJ9YH+9YI+O4WXnTShjdu7ZZeqwGiVw
 UfMWRySQL3l09dml1D2Yo+E0om9VDPZFmpu55xUC5G8GBcn98w7ksfhO+/OZLY=
X-Google-Smtp-Source: AGHT+IFSXKO1tP+uKpttRTsBt/qtD2RQedyw8gBiKFlRAawotquFTW6jJBFdhG2z1kl1Ff1N5T0o/g==
X-Received: by 2002:a17:902:d2ca:b0:216:1543:196c with SMTP id
 d9443c01a7336-219e6ebb776mr104820525ad.27.1734884693006; 
 Sun, 22 Dec 2024 08:24:53 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc971814sm58461385ad.79.2024.12.22.08.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:24:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 08/51] tcg/optimize: Use fold_masks_zs in fold_and
Date: Sun, 22 Dec 2024 08:24:03 -0800
Message-ID: <20241222162446.2415717-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
Sink mask computation below fold_affected_mask early exit.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 26d1c5d4a1..8119447c89 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1280,7 +1280,8 @@ static bool fold_add2(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2;
+    uint64_t z1, z2, z_mask, s_mask;
+    TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
         fold_xi_to_i(ctx, op, 0) ||
@@ -1289,27 +1290,28 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
         return true;
     }
 
-    z1 = arg_info(op->args[1])->z_mask;
-    z2 = arg_info(op->args[2])->z_mask;
-    ctx->z_mask = z1 & z2;
-
-    /*
-     * Sign repetitions are perforce all identical, whether they are 1 or 0.
-     * Bitwise operations preserve the relative quantity of the repetitions.
-     */
-    ctx->s_mask = arg_info(op->args[1])->s_mask
-                & arg_info(op->args[2])->s_mask;
+    t1 = arg_info(op->args[1]);
+    t2 = arg_info(op->args[2]);
+    z1 = t1->z_mask;
+    z2 = t2->z_mask;
 
     /*
      * Known-zeros does not imply known-ones.  Therefore unless
      * arg2 is constant, we can't infer affected bits from it.
      */
-    if (arg_is_const(op->args[2]) &&
-        fold_affected_mask(ctx, op, z1 & ~z2)) {
+    if (t2->is_const && fold_affected_mask(ctx, op, z1 & ~z2)) {
         return true;
     }
 
-    return fold_masks(ctx, op);
+    z_mask = z1 & z2;
+
+    /*
+     * Sign repetitions are perforce all identical, whether they are 1 or 0.
+     * Bitwise operations preserve the relative quantity of the repetitions.
+     */
+    s_mask = t1->s_mask & t2->s_mask;
+
+    return fold_masks_zs(ctx, op, z_mask, s_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


