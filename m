Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB231C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJw-0001SI-Rr; Wed, 16 Sep 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJV-00011F-Dp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:40 -0400
Received: from mail-pz2-x15.google.com ([2607:f8b0:4864:3b::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJT-0000IW-Mk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:37 -0400
Received: by mail-pz2-x15.google.com with SMTP id
 41be03b00d2f7-cc4c3304784so695763a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563874; x=1790168674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZC9cjz2S7VvubAvVoEtjxyzeRaMdSDwzLQ+JpOUV5dw=;
 b=iySPQ58pLhCqjIqkUQ8fo0nq/wC/3jUWcfhYJLdilZlxdAkjz/cvGezjlmnbyIq11i
 HWkhyiEuXupqq+c2PbJhVgUog/cASD5Nj0tRepnPJYYmmiEi9ybsv5MImjkGO8qpIEdl
 2OI2egZABxnvxH8YbgCz3pf8xJwWp/d0ufd7jxmVj6rC/28+JrybqOER8bY8akoHqj8B
 1P5FcI1OLfK6uY8hm+h+lfmhsOzE7u6LGHsTCUlGbmSfXlXYEZZ4E9TfrjqGsRQd8jb+
 BLv8pHCuP5NziLPJq2s0igevShHw6DgmsxHysCuc4sH5N6Q7nxGk+G5hRDxhuZ87Jjy6
 +Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563874; x=1790168674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZC9cjz2S7VvubAvVoEtjxyzeRaMdSDwzLQ+JpOUV5dw=;
 b=o4xmkc/5IZvuhpo3YB8X+9h/9kHKkis2Gl8j6AQLNnZrl/42GOj42uu2I/zv7C/9Gr
 B16MhD/owPe575a8BgPkpYb1HDBfidNo2mPWQ8KdMRyJ+ifYygb05o5tGNH4z4UYelDe
 vYMNPuLnhjRo9i6TzLZqoFw7E39U8ENhtoKMmmONGabLGztntcDzTTjnPffaW9ViUWJh
 CGFFiL/ywJiosRgY4T+TLHXGN9in6vA05IY7Br6Q1n2v/+Y/69P3vlxmS9yZkwqUXtxA
 K3LCUMOp0WC2UaBTMUdVAC/0KmHs4U+q6dlUKx3xCmxaOVf2EiU3UpL+NZjcQF7nv4KH
 fEYA==
X-Gm-Message-State: AFuF++nCrNsoL5ihfDGFtzvaFu7UKdRCvgq1FMQOyVsjaJtU6f+tF+zq
 HoHa1qM1k/jD/+jOYNV5yKD6LIh0hhwC70xJyiTxL7OWUn5vWMOEddDRzS9ebRzHGpTrQ71ZnQj
 bbG6M6D4=
X-Gm-Gg: AYBFou05ji7cVpStltWaWDvXQd2zy44PohE9n+Tqo84tGj4SfnTXCqFoXLzKWfbe3n6
 hOC5jyQPjJMjtOv2B3cpXKmvVMlCRCbHDIGIj0Ij44vfNZraGM1JY1tTgPqYR2j+vANsmnrj1Dx
 Wa5ruWpvT1q/w+iNt3MHNQHsvxLXMc1r44iS777Zbkth49cJTZlVOyo7rY8r3XN0za+uGtav6ln
 UncUOdhej3dle8Hk5MhLmxCGgx8xfYjMBxJoRC4X9ClEMYD0cMDd24Nedvh9o0bhZRg4n1jmJFx
 8E8eWPlTJF93ms4i7/RcMgdG5VoAm/WvHIEQKji1ZZHaheOtAQihnh4pti79JEBmgTqN8fvpRlc
 Tdd+bGKvcQVODiCdQ/Of/zPXWQ3quNBh8pcEheScNEs8wKYsthQIotg3d3CEwTp8pqow/B0tIzv
 HHBtfdzRWYW35qoLmPi6cFxFxSwc7+uZj66pFXMaZX4v3zoxZNK0gY4BobjcdEo9CaeHxVCNBD0
 v3RUpv9
X-Received: by 2002:a17:90b:3c42:b0:398:c150:e7b3 with SMTP id
 98e67ed59e1d1-39e1e24fa59mr7005342a91.4.1789563873929; 
 Wed, 16 Sep 2026 06:04:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/92] tcg: Generic expansion of tcg_gen_neg_*
Date: Wed, 16 Sep 2026 03:02:48 -1000
Message-ID: <20260916130409.3382710-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::15;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x15.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index db5315a5cd5..7d4765460b2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -218,7 +218,6 @@ void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -327,8 +326,6 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg);
-
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 122a71d7c4a..77b1260a292 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,5 +5,6 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF2(neg, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ba756d4aa69..6aee0190e0d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_op_tt(INDEX_op_neg, type, dst, src);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -449,11 +454,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
@@ -1571,11 +1571,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


