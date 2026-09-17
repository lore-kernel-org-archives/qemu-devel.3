Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE9BC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kY-0003P5-TN; Thu, 17 Sep 2026 00:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k6-0003Co-Sk
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006nt-Ig
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:02 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso394457a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619328; x=1790224128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CRD0I52WWAnGnNUF8/F6bG30rfo2CUDMcZ7gqQmB5vg=;
 b=nGVrMv1rSqNGMa1NKBZz83Ta1kQu6+MVeZ65ZFYAI6mbjPQv+tDVnSMcWNnXwEMcKD
 dJVeCPlC+XkOAspdoA8gGatwaYPvMSiCGhIpxHRdZ67hdL0p9THySTKyKf5Or+/zkaTo
 DNnHpTDCZZD9/UpyhnCwbv/5pOlyRpXd8UG51sJCbzQbOCkz0B0C+clWt08oI2ItHM2H
 0pYkQThn0qlpabdMlO45Xc5mCLjX6ytKX2AcsOU8tVH+vw3+yBz9j4yCc5wcyoW2jksX
 A3xP2q9pJdh+P+/Pr1R4q4ncckeLY4gC3Xe+MQ4xHB7tqTUivnBvAWKf7HE5dPgdXtMN
 sKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619328; x=1790224128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CRD0I52WWAnGnNUF8/F6bG30rfo2CUDMcZ7gqQmB5vg=;
 b=FcVx0viPpcqb6yMM0gKRGaBJfrxHLP25Enx6VrHN5ny1yWjDR8UZ9nlqSaI+6FR7ST
 9o9wGFIO7lSgvY9hvnUKebH7GI9OIAjdM16hCU8fp7dQICXXI8eyVGuFWD0JL7JxWZPt
 Hpk9L8bkC4vLXvkXWd9EopyF6MWq1ws6tdLPqNJKJMD9x9vHAZaCqeTpHaU63tqopkNZ
 litRc89widh6qwbQfkThvryR6S7F2/5DwDBKv+jasULnZukDvT5T41zV0qQAKE6gF0R4
 HTDnUybumayFBJQTZhpPt3t3LCKg5dPdWI1RakkjwauYIvX5Enl3Dq7Bx4UvWVB1VxvF
 FlcA==
X-Gm-Message-State: AFuF++mTQtLxJxIzek7xJ0+VJNv1IWL5iVh0XpRlL9UwC53Wxfkp0IfZ
 XD5IpoB4nFLcUgRYhqModiuJY1eImwEEgIrlgtb8Ku/4qVh2VeYc8iNTvGe1zGlNASl0o/uw49d
 iDGSeqMM=
X-Gm-Gg: AYBFou0JOSr8T6830C56Za3od743pnSeVVKI49qODS79SL3kCsV4On1XghfVgGv3K7c
 0M/kD4Xo2jeSkR6Z6xRAnGQg0j8dnKWETZDN+ImWgS2AMedIj3hX6d/9fva6KtVWOYdi9etRYML
 jofiVFQo1DTx2dm7hzCnN0APg5EnOH7Rv0NOlWaS3XFpmg7pp4VSjCmksdTGlP7qg3pDwwL4iR4
 VKrLyBgQX3cIsgyW3qo8vtL8xVbqwnfpwgNqnduW59dkim5/yy7+MLYDRGVwJJTyA46T4NRbgBc
 vUGcaF60/AVwdD7D39w2V4b7DDEWLhZwszRiYUheFth2shbPUaKzAzEW0vpKBXoMbZbKnd148dK
 zZ+kzFAqEMvVaHwVNKSEKOxx3SxIrgNMitVbd0FZE6cWv8y2HQqKNbug4rVJQvteRq50S5tU9ig
 q0I4rupr/A2pGKz+B7m7Yv7YDqY3vr4zKHErX4gI9uRWfAOsSnRopB0sDdbuCPbsbvHawLdWGbS
 G/pVbhQnlnnABu/Eg==
X-Received: by 2002:a17:90b:2247:b0:398:c6e1:dceb with SMTP id
 98e67ed59e1d1-39e35df407emr3291783a91.9.1789619327584; 
 Wed, 16 Sep 2026 21:28:47 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 020/101] tcg: Generic expansion of tcg_gen_xor_*
Date: Wed, 16 Sep 2026 18:27:02 -1000
Message-ID: <20260917042823.542588-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4d61eaba122..6365f67494e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 513505e35fa..47d3e6f6990 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,3 +11,4 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(xor, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0b7fe14c7a9..2b796f3cc62 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -462,6 +462,11 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -506,11 +511,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-- 
2.53.0


