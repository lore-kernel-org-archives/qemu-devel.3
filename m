Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8D2E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBAN-00037W-UO; Tue, 24 Dec 2024 15:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9w-0002mF-3v
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:40 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9u-0002Z5-JL
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:39 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2163bd70069so55718015ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070737; x=1735675537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf5EKd0lXfaCbRbQXllEv2ceVywi3b3Vv26rFZxb6RY=;
 b=ng+ETRGZ/vMlNpAxuI9FwL6DX0sIRSEJx8/dQvJOTTdbuoNwWNFQfluhS4W8Jl6RgO
 IrxZO+bLw9Zg1BUgeBOv3RvThsOwT/1t5DJIMFrYg5rk6wVZoFZNIbT2SJMeYZ72Jgtp
 r3RTX3Uhr3K6hzXFRhaje8ZmDvnfBHqfZKPee320FgtjlKmLIgWqaLCksoCvzxi02BJw
 qUClGQ9xryXzabw3HP524PQ2UPKSrSRuBlU23WAA3lS6TYHLuyB8vLbUeQUrTdwTSyaT
 1vXgTeZjDbS91YfN3gPEg32rkW2xO7kBlsVSDNE+734xp3Wk8LDCgel3xU+Lve/kN8YW
 vyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070737; x=1735675537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sf5EKd0lXfaCbRbQXllEv2ceVywi3b3Vv26rFZxb6RY=;
 b=I0CHAlUHyOiCT/rCGOj4W76Hl/gAAbLXo7UNF8StQRwh93f12LjABsJzCAXO+kSRoA
 LPKN1iQWlF7KQz7xyqUqbGChkniP/5wMlzA2SPN2GBIk0uqW7pjDUeMxvkK/twC7bRrv
 8sSPcHEfPDemXGK7jpq29oI7dSK2OTtgm0flD7+Kf94i4iOev5zUy90KzRcue6FJzcvK
 VEtTR2eOawWBMDu5gjc1nqIg9I2GF1WvJbMmcpXg3X/fFjL6sYTozbYTqRT1zx3Ymtfo
 YZqKrqAsBZ3hX9032SchappBBYL+SHSHPVOhVQLfNbLpxW6Cb9zrOpu/yPSQjqSCeNMc
 3NwA==
X-Gm-Message-State: AOJu0Yz796HbG6g8gloeMMI1Nu7CJhE9qMpdlFEYgiWcm1Yx2aHFLBij
 RFBXz6FoLasuhM0FEMvh1ph+Mg860QaW+cnQnStuPMItKqP47Q5m7byVdtXTiWYhji4pdJod9hI
 6MeE=
X-Gm-Gg: ASbGnctasYs1biBC1lqEuaoPBj0/9Sn3Tp/xCIcHWVVrJ2gOj7fS/j7ZVa0V4OhUX6a
 mCGc4IlGOpIbljqio8KCQz/6/x1tcqQ+JNqo5cJLYVmefNApPAnz/7QkiLcVxpe68erVXVIXaqU
 /WBnVzNssgTW6au4wROUyAmrL+EX2LS7qu2NTfFV64XVHzOmvmvMfgU4b0QQuAeprxm8MAQY2/P
 QP7UUhx9O4rNigXNiiFl/zVGaqUTxfjFzBC0pisSX5PCGvdi12KxIQxije3dIhs6Vi73kA7cnEx
 U9BNStSpGenf90ooHbAXEa/v0A==
X-Google-Smtp-Source: AGHT+IFDnUMJqjX/QnJt8oK905r1lE3ZtFYUmT6krWzZ4IsyVc7O7IwOJoaDdsZLTqYa9WRa3/GZjg==
X-Received: by 2002:a05:6a20:c907:b0:1e1:a829:bfa2 with SMTP id
 adf61e73a8af0-1e5e05ac3bfmr27799976637.19.1735070737356; 
 Tue, 24 Dec 2024 12:05:37 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/72] tcg/optimize: Use fold_and and fold_masks_z in
 fold_deposit
Date: Tue, 24 Dec 2024 12:04:25 -0800
Message-ID: <20241224200521.310066-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
When we fold to and, use fold_and.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2f5030c899..c0f0390431 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1625,14 +1625,17 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
+    TempOptInfo *t1 = arg_info(op->args[1]);
+    TempOptInfo *t2 = arg_info(op->args[2]);
+    int ofs = op->args[3];
+    int len = op->args[4];
     TCGOpcode and_opc;
+    uint64_t z_mask;
 
-    if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
-        uint64_t t1 = arg_info(op->args[1])->val;
-        uint64_t t2 = arg_info(op->args[2])->val;
-
-        t1 = deposit64(t1, op->args[3], op->args[4], t2);
-        return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
+    if (ti_is_const(t1) && ti_is_const(t2)) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0],
+                                deposit64(ti_const_val(t1), ofs, len,
+                                          ti_const_val(t2)));
     }
 
     switch (ctx->type) {
@@ -1647,30 +1650,26 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting a value into zero at offset 0. */
-    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
-        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
+    if (ti_is_const_val(t1, 0) && ofs == 0) {
+        uint64_t mask = MAKE_64BIT_MASK(0, len);
 
         op->opc = and_opc;
         op->args[1] = op->args[2];
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
     /* Inserting zero into a value. */
-    if (arg_is_const_val(op->args[2], 0)) {
-        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
+    if (ti_is_const_val(t2, 0)) {
+        uint64_t mask = deposit64(-1, ofs, len, 0);
 
         op->opc = and_opc;
         op->args[2] = arg_new_constant(ctx, mask);
-        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
-        return false;
+        return fold_and(ctx, op);
     }
 
-    ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
-                            op->args[3], op->args[4],
-                            arg_info(op->args[2])->z_mask);
-    return false;
+    z_mask = deposit64(t1->z_mask, ofs, len, t2->z_mask);
+    return fold_masks_z(ctx, op, z_mask);
 }
 
 static bool fold_divide(OptContext *ctx, TCGOp *op)
-- 
2.43.0


