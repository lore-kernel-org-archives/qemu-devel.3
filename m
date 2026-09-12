Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17480C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1h-0005BP-6r; Sat, 12 Sep 2026 06:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Q-0004oF-7p
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:51 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1O-0007IL-Au
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:48 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1792600a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209105; x=1789813905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WIuplCcu6Be2RGY/HzxUOBYkWqAVNB/7xHweuIxL+PI=;
 b=cfg1ULiGyjha/oDDRjtg3DQUZhbJfpRKVCNJjNyU5sMX1kl9DerO+izUmZR2p2eCj3
 qM8/7fKXQWDJU40x2LY8yTncKTZw9merdJTOqQZ5DOMbJeG3auWEorAvIqo8VAfHegEk
 aS7Gc4N3sz8dOk3b28kD3ZMMdfJE00R33m+nBALLEg0dWyv+OLwmyMnJKyACvTU0V2PU
 3dUuCnPDYnoPg9rx5ec1PitLDwl4lypUlvBWC9oHY/QOC/5iaDqira9t6H7qqlpuIQMo
 Iv+FAz//sR/1NM3ibMGWyvZwt8PF5RzSuxcp8TBhC4EgnXarLn3j3/6oFNxhM92707Ok
 ifRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209105; x=1789813905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WIuplCcu6Be2RGY/HzxUOBYkWqAVNB/7xHweuIxL+PI=;
 b=QRwU6u4QDLtqfK2VOIzjiTNO+cK/pEYQ0rk2LTXcfvdq2gzBYVJTwzjorLySDmLXuT
 nyKZ7fexVOuwgtWvKyxRRTNM1WWA4rEFU/eRj90PQVTo7kGcDTKp+HxouC1RwXUYQs/P
 NnhWzSNaJXW3zRyHGKtDOd3UU+wuDaa9IUjuNoIqGgsrYacINJSflilCOtvGw2XSp5Bz
 rnk5K4jp17P6ZO37JFCXbLlajZURmj9FFjrep2rZiF+f8Q5aTBeiLnRa8CztJENyS5vw
 E54HukMEj6lT5WgUMu2ikV4vNqgCNlBycaDfeoq1tbm0kHfDg1XJT6YD7tXvki6iOscI
 CJ9A==
X-Gm-Message-State: AFuF++nmVUjO1YpfCXl+1WWJ/x/P5yNvtSfhdgB7Qd097Y7LyPKsFDqM
 QjuZdMGjOOTpi1+/rJc4jmWaZqAQSALbpT5UdBU/Jxs8vYi1T0XaQPxqFw6/2f7onvhKOBJ4qcP
 hKX53G7Q=
X-Gm-Gg: AYBFou1v1eE0cRG/MJ2mvN52ytqcJc2wk2XbYEzNVCJQpUopo+pMTn6BcsV8djMf2fi
 vVL2LcVuc/0i1lqvBNNhzIN3mBTPisrk7O/mkK1eTZtWdn3yWZrxxTgvHj4XbpH7pSt0o97y8ZY
 ORULe8lkcXJLbTgJxPaVQILZ6NhbJWt2eqg/bzLx78hcYaGmZizjZ1/nhFrei2bs8zA4sAnJVhB
 f9df3JMuPS4aL9lsMN6dh+TcMz0Q8xPWHjIIdzUcyizR6DDfDVVD95ibrw1bvH4Gz96jwhiVpTp
 9tOwNQj67eHSX5LlSZ624/Bo1ed9s5G1+Kx5//LBwDkmix8rXwnqGV2tGBdBiAmxr/Uxd29RY0n
 prqf8huy4tvaTi9s31gc5RPr4N3Z12D89H/0ENHlWUKWwKg9xozdGA/k5ahthRgP6Xe6xWrzvkn
 XSxZO04o9GkQzBKzI99O4guy2wtYoLWhlGUAlvipfW0urS1isgEfW+4dNeAqUgf2DN6ZPX81jKv
 eEheIw=
X-Received: by 2002:a17:90b:278c:b0:398:e6b6:acc2 with SMTP id
 98e67ed59e1d1-39d9c1b4d9amr14326427a91.12.1789209104852; 
 Sat, 12 Sep 2026 03:31:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/82] tcg: Generic expansion of tcg_gen_sar_*
Date: Sat, 12 Sep 2026 00:30:21 -1000
Message-ID: <20260912103126.598030-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1e2d30b7125..79ef28c0196 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -310,7 +309,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 0c40df31fe4..356c2fd3147 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -10,6 +10,7 @@ DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(or)
+DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
 DEF_RRR(sub)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7feec9c0cc5..7e3672e4b9f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -557,11 +562,6 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-}
-
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-- 
2.53.0


