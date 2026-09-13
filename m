Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33028C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7z-0000UU-PU; Sat, 12 Sep 2026 22:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7N-0008P3-U7
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:58 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7L-0000zN-0F
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:57 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso2146531a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267133; x=1789871933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/yeASfmDE5OqtjonSINVeRNEHZOcZQzTelCdl0b+qv8=;
 b=LsRUPrJVft/ot1ka4ZdwWfpdIHtIYHNQ2X1An6al3GNhCd+Qe9vWrmxoWO8DiQqBaR
 pISA+oZkk0xJMTW5gtNh7egUaxl8h/rKwektOMhv4NDhCGrWFFc6TBfQGy+fOMayj53f
 FoUeXKEBU6qUHaStHlmxZ7QcipQ8R9cLYImbDYoFKNf5UfZnZtepWxThj0mNNRXqX1M/
 rbgQStsXbN70Zf3MKexrgdQT3qzSVnWPltyTIPCt890RaV628ka/eW8IcKg/VnrvDJTJ
 811HDCfUIcoMylhFLB7iEdsDj9gcWm+w6NLZdj8tppH62JLvK4ekUn+C5UV6fDB08l69
 8uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267133; x=1789871933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/yeASfmDE5OqtjonSINVeRNEHZOcZQzTelCdl0b+qv8=;
 b=GeIlMWurFMzYG9qyUFgt8jagwfmmj6KsMGM/s1LucVYE9irQrQEAHYIFlmn/kj89gq
 FvQ5bmp++Px4l4WEoJNQz9ghW+z8XUT2XmaBBi3fNgwP7AMh2kzLYlolB4vUtYdkyDPJ
 XAakNUkiypVe5B08W2bLxgMm0rhgdV/eMcDMNorhfaTYZTi+M6GJTToEOrphmoI70RQC
 2lW1a1dz03tJrF15RPV6RxApdkROKSzAMnacKkb0xwR9cCTS/FGE/rJA5rxaSeRQVGQX
 7Y0F5LKslCn+qKQ6hZlc6qkmQroweuHWz4ItoqxguXTnH6nxvp90Fz5SdLZTGIX546ml
 GItw==
X-Gm-Message-State: AFuF++kz/s5T0ahmKWn9IWqRWBQwFIFTqmyyU1etlB+YsyPDRiC8QTru
 EM+MEjiM6Rfn0fQ9dqVUDm3lC23R58LQnw/93HycoM507khpqfZVaLRkx4EOT8gYr/KCIyK9hbk
 VfjP0gpg=
X-Gm-Gg: AYBFou3/0+g+O9ZoPQO3AWSflU/n97DF8tJA7mtZCAbPKEwjQFQ5VWpSFkfgo6AMRDv
 9BKti7yoREdHw35hMNaoIZRfKzieX5jQrzLNWZxP79WHgWPdPPhba2fW6G1kHG0Jl4BZ9Haavyf
 UZ1BzzZQZIycNMJhYaNMD/Dw2coZofE8onUVJn55CGn9n3A0yGmwtpKecptreAslqqRZf1cEvRj
 MX4WJ0+hatcxHsQcA+bb7wD41oWASLBDJUoKLalWbgVq2ynpEat2Q47v8hYj3SZu54BI6BSK/aO
 G28+W+dpGtzb5t0Rw9ETqqVHCJbtHd9xv/OHJwcwQKeaNgG37KECNQcqRxnYUQOMPlCEjhRrOww
 AT94yeVrbU2MV15luYolsdSuZ3pmPeY81CTDeGkIMoNqSlh6+RkmtVXHwycSV0UGpUzQ0RIA57r
 Rxq3OkpErxUX4VQS/K4WIuWzWfg8LoIIAaj+vq6ofC2gyXdvVHG6l0kLnI6crL61g2A7wWLd6ZG
 u/Mhso=
X-Received: by 2002:a17:90b:35d2:b0:396:41d1:cbc7 with SMTP id
 98e67ed59e1d1-39d9bc0dca0mr19423241a91.3.1789267133380; 
 Sat, 12 Sep 2026 19:38:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/86] tcg: Generic expansion of tcg_gen_and_*
Date: Sat, 12 Sep 2026 16:37:23 -1000
Message-ID: <20260913023837.741866-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
index 4fb6f5f6e14..74a917f984b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -317,7 +316,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 9084171d6fc..a2ae864ac17 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,6 +2,7 @@
 
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6ebf7fff4fa..6e1b1c04fdd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,11 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -454,11 +459,6 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_and_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_and_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_and, ret, arg1, arg2);
-}
-
 void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-- 
2.53.0


