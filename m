Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DA9C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7g-0008Sg-1v; Sat, 12 Sep 2026 22:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7L-0008OP-8V
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:55 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7I-0000yd-MA
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:54 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 41be03b00d2f7-cc4c08393dfso605756a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267131; x=1789871931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dEKgyvvhOe6l9gny/OdrKsgsIYL0yotMQQWTmZEkRN4=;
 b=V58wTUngqHHJJpzJmOsZTsQellrgWzX877DcQv0/uMObDZ+KW9ZSIx4DY0kxs/egNP
 ZxCgQU0HBLKy2MC1o4LjIA7TaruF0cJfoLeOuzDvr/aITwnODzP271q3s00Xorvd90oP
 /jZ9ybnDTZqV+l75+pFnphQyfpUBTff3lY0GoVDa4jWU7/J5GpfEoyF79hUfL8m+BVxI
 EEVLSzfoPUB5AM3BllXsqfh/SbRBFNW0Z3p226hsUX2yGRaYwyuaVk5G4OyCRi0WK8YS
 MQgpoCuVmvtD6ml0GoIOhh79Y4ybFDRPhPGOeEk2Epli1EucvXQ5+2HCIvMRangkTYqI
 6EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267131; x=1789871931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dEKgyvvhOe6l9gny/OdrKsgsIYL0yotMQQWTmZEkRN4=;
 b=lT+urjUDMsHgn/p+SzgWSkW9IrquDUZCLu87iPFM24Ge/0DBcKWsH3hEKjA45a5huQ
 Jd8SQcNaY85bpbQwR5dj4tfvZcXmyN/HhAGz4inr/T540FG+eACPRMrG8BXN98XqQNfC
 hNTW6OE6kjWcgSLAXD/aNMB/IQAfG/0PKIYg2PulkgCtiLriz2TxSvo9lW/CvGdnJyzo
 smprprXvH/cluoJZbKUxjl+TkyEKM1UAg4SRIQTuluVKfogDk5c8ONQJ6NxpZ94RPRiA
 N47GedfhPcKiCIHY5yCcfc4KRTK6enXh1zRUorwXJ4sT4Rgbw8i7DN43iu43m492qDLS
 6Zsw==
X-Gm-Message-State: AFuF++m7GRFv6VxF/m2suqo0vJfrDCnL+7rRJVgB9get8dShZ3TiCUUt
 k/zRXMzib56flEg+SGW7VAcfjAuBUFifJ/4BW7/LqYsKcjufJscQaKhnH+nHrDHNKKWu6oEDGSu
 n7YOiaQc=
X-Gm-Gg: AYBFou3A6v7fr/TtLnMudGmkzro4OR8o0tQdewTX91gZwCoovwHKTETzVF/GKkf8gEC
 sNoIFTDovtBwBygLTpumkn7kmYhffPaMGo7CCe7iXtzCi98AcCm4HhrTeczqQheUlVaGdcG8vJX
 236InPWhYofA4FQovyFXj3nXtB5evTmPqDjxw4rgnnuhAW4eKdRBaNy2Ve/F75/oJK/dAzKRqgU
 4+sHA6I/rryrHiwTSpU5C+Ih22ler2qPHwuGozKx8WbUaQB6lsAaaLu1JnSb3lCIciXlHqBFfxP
 pqHBNeasmfhUHqDmdrwEh3TxzY5So3rpc3zPGk9rC7/X+IufYaQ1MQ1UH7u+IB8apq3ngYB5JpN
 YVemCzpp29cUrQ46wDfBALBRix/sfowgreoDinUqk3aMmGFn/dUOtZo1MoND0b7d6bFgd+YosrK
 wMRxJTZQv/TT2ABAi4b5Q/vYykwuNb6Yj7LLZ4NBRcB4VYXNs3fpYNhqSnfxEqhxTgBdJQRSfp1
 C/GIsI=
X-Received: by 2002:a05:6a21:700d:b0:3d2:2afa:d7d with SMTP id
 adf61e73a8af0-3db0e40edd0mr10270360637.18.1789267131231; 
 Sat, 12 Sep 2026 19:38:51 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/86] tcg: Generic expansion of tcg_gen_neg_*
Date: Sat, 12 Sep 2026 16:37:21 -1000
Message-ID: <20260913023837.741866-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
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
index 11cf157d3ae..e47b9ff913e 100644
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
index b66738674a0..aea89088a1e 100644
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


