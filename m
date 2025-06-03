Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416BFC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMiZ-0000r7-EA; Tue, 03 Jun 2025 04:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiX-0000qf-Lg
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:53 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiW-0005Tw-3p
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a36e090102so3022160f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938190; x=1749542990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERsN3wV+fcXb2xmdBpByK0N2LC/9kgwvDEhvl3/V1A0=;
 b=GXn1HlOO8y5GQOwY9wRq5g5bPy6dMZbagP3YoL3WT6iueJ0Ph4v34LUPX6FXl/6y7e
 pnJBcJxYtTTUxIk8Mrl/1AimfPAXD9JADfeByR3VLGTel2/Q39oKkLEfaMa9Wk0lJQ/8
 FGY0StIYngdq1xZC3Rs1xoo5gqkf0BGpgwlHObmsoR/+vzJeOnhU7jbVIhMoT2CP+Z52
 ZlFsqGwLYe/hpOgcyIIJ3+l7JqRlVcTLr/m6FP/C59sKL2+dmGyl9Phlgwj8RNzJZFaX
 VIh3szbzqZEDljsg/Xaka6OQtswV03JllJWEdR+zO9oMEXtgYV+vObO65W1GVaq9jcAm
 gKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938190; x=1749542990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERsN3wV+fcXb2xmdBpByK0N2LC/9kgwvDEhvl3/V1A0=;
 b=E5O1wjVsl8BRISvBZi8GbcmQSfezZZQClLDokAXAnYLpYvWdyDiEAibr2vHx2KO9t3
 kvIRfaW7jaeABZBxLQYE5RZDYz2GbrWc6FlTSuYZwuG34xoYOnjxNJtjOlFv9cwCSKkI
 JqC38lvFfDmU9ujZJ0gt8puZGIaakl4D0GD42bpcGB1XFdehSftL6yWdGIQy7pgRZ0XZ
 fvDdXLkw0Y6dePJH5IWfNCO4Fe8mHBDjAz9yzz7oKAfTA1dl9hAwZIr56KeInQm9pVjI
 lmO7NVOssiGYum1zOm/8/Wz0ZpUFAOPYozwEqW6QCygOC5iNN4UwEZQwRflTckXjFAZ6
 Cthw==
X-Gm-Message-State: AOJu0YxNTM1E3d+CsijzXL4lU5kqxkRIeN3ZOHpEGhSDeZwZJRyVblZi
 ygQ5iI6NP8tZ0EhZh5rohxFmOafZNpgAef0oJ8Jgma6OBMbNqzxQ6amFQbcrQbqv/ZcQ+/EVjZB
 yLEqgi0k=
X-Gm-Gg: ASbGnctJfvyR+UCmdepNA2djA2QuJi4BEWxSx54C+Xcp5CyUAbJ5YBCS0dilqWn7R3r
 fu6T0wjuEAKeus/p03s2aKWiznO+VSBnX4TfrPJBSMxu+JA6arUuD/TB1lzkCAhZa4tWNqLKvta
 u1j3z1diuSrKZvo6HLx1r2CDnAKDSUxUz/p6/iqOJ/FXL2yGbbSUw61+hhpqRSu6D2JRTsvcgm5
 ZnmUGcWh/kLk2H9SS5FdFvqX1/sKwtPgDv+2n+PjisPhJ+q9yZHRBK559FNhK0Y7pSf2fyUBmmd
 cO10bVofXyqAZ2D4zHYtaxfmKRZZpMJXG983Hfsh9eKR/DAcY8B7KfzLa3whYuVNqEibrGzduE/
 bh/JV1YgPJ6NB
X-Google-Smtp-Source: AGHT+IFpIF9yxFdE6ckBItrApMy8/2hbNV3svvDMW8i7EEL+vk237VHLDPB+08JeW/HJKjmIv09s9Q==
X-Received: by 2002:a5d:5889:0:b0:3a4:d53d:be22 with SMTP id
 ffacd0b85a97d-3a4f7a7dd8cmr12562304f8f.58.1748938190455; 
 Tue, 03 Jun 2025 01:09:50 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:09:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 04/27] tcg/optimize: Build and use o_bits in fold_and
Date: Tue,  3 Jun 2025 09:08:45 +0100
Message-ID: <20250603080908.559594-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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
 tcg/optimize.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 49ef039932..d9ccbb36e2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1422,7 +1422,7 @@ static bool fold_addco(OptContext *ctx, TCGOp *op)
 
 static bool fold_and(OptContext *ctx, TCGOp *op)
 {
-    uint64_t z1, z2, z_mask, s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2_commutative(ctx, op) ||
@@ -1434,18 +1434,9 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
 
     t1 = arg_info(op->args[1]);
     t2 = arg_info(op->args[2]);
-    z1 = t1->z_mask;
-    z2 = t2->z_mask;
 
-    /*
-     * Known-zeros does not imply known-ones.  Therefore unless
-     * arg2 is constant, we can't infer affected bits from it.
-     */
-    if (ti_is_const(t2) && fold_affected_mask(ctx, op, z1 & ~z2)) {
-        return true;
-    }
-
-    z_mask = z1 & z2;
+    z_mask = t1->z_mask & t2->z_mask;
+    o_mask = t1->o_mask & t2->o_mask;
 
     /*
      * Sign repetitions are perforce all identical, whether they are 1 or 0.
@@ -1453,7 +1444,10 @@ static bool fold_and(OptContext *ctx, TCGOp *op)
      */
     s_mask = t1->s_mask & t2->s_mask;
 
-    return fold_masks_zs(ctx, op, z_mask, s_mask);
+    /* Affected bits are those not known zero, masked by those known one. */
+    a_mask = t1->z_mask & ~t2->o_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_andc(OptContext *ctx, TCGOp *op)
-- 
2.43.0


