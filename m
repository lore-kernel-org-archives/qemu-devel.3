Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BA7C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5H-0001nr-2q; Sat, 12 Sep 2026 06:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L50-0000Ig-RF
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:31 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4w-0008O7-L2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:30 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-85469b35611so186781b3a.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209324; x=1789814124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PJRJBXUvIUib7ZDX99FPFTDrJALDcOHjUW2ioYzB9UY=;
 b=b7Am+dLPuQF4TlECLngssA8RhZYUpyq84sbfNXqTi5DuMhsXwTf98DEAM6O7R6Dww6
 WcvcBoiGcjXMDFdmN27Xu2aAerf4IreRwM384V2fPoohSerUqv3y8+MWMxLCShg2af58
 9y8ggWeyjl6YDGyo3/N0nd1i8SxjqfxH8KqB/BjqLiW/aII0vAj6Z2wX3tIpCYGfEVot
 SvqEwPQgXNiyrCBkZDoI9kq6d2ZLqDG893IMTa8yRVe51p1r9BvGYDhL8jX0t3zSVVSF
 8jqYsTTRT34vfuGXiG6Dp6BrulIzTUz6kbj/yzSpyfT6Skr4AsGWSnaspDGL50kvmZRX
 HoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209324; x=1789814124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PJRJBXUvIUib7ZDX99FPFTDrJALDcOHjUW2ioYzB9UY=;
 b=dV/gNPPcC0gPX9pTl4D64UuDeL1CtvVToTodLdbOtKt7dVAtBVUShW38+6IWf/0E4D
 TQgqBPsDwMuFyX6b9WOld77ZowFF7Fu19jWq5R2NLryIXJ6OnwPEwbMV8xsK2eoCNIJZ
 4zsMu3fdJUA+AjqcVVN37TvWajpZGRnuU4EThZCazgTtH/azs0uMsPBb2KNQeSpORT4j
 QKdb/F8Wg20fhhCh0ldw354ilvct7fW1UsX405O30TlMLMhjpxZ0A0D4vVbk8c1MFEW8
 Akqq3BUbuJFNZOrjV+V22A0dX+JSHInK8aqVTRVaF7ndXsaMqYEGTTsDHUyOnkEoE2Yo
 tmhQ==
X-Gm-Message-State: AFuF++ns5nLlsWnJIrRY6jGF+ECu7h7QNN0t4UMNGm46g3S8RTJIZgKM
 SzLMGuEQZbQe2ghNjiI/bur7K7wF+39Qve8NLdaAIyXeQs2V5cnnY+4JKbik50Qd/jCm375jAk+
 CJkKhPYw=
X-Gm-Gg: AYBFou3D4bR+GPJIyVcudBC6GC6m7WG2A+0MPVeyE0i70mY/Q2oIScL2BD08TuuBCdt
 SVZHcQcVhjpauT0rkm/3a1WJmv5mx3mOX/s60U2t2yKnCdweJAwps3ONW5N+vn/EKNEqwrdDc8C
 kqQPr7S6GaL//Q4SS3Rf5zB6/WsIq4FcA38f/5Z1mMityRzz9UjS3frJwhc3HYfpw1PC0sIxMRG
 fzbYRR+tn4vpRunC3tAFGFnYYNE4w4BHgAPp2EXzjYjxuc6Nd+3KWQoHRtRKlP4gyovlcrCxEW1
 BLiE3pLFVDdJm13+YUmBbOACbD9EZfnQwW4TyfaZHdXJjZaguEHVVKHd7HN0cc+y01TPn8DjpIh
 0L0zc8bhG2I3A+TbsD3cws7dGJAgUkD6ZCa3nfhKJMHImRbPx5oxQ7fQ9/0994zQqpE+twCON0J
 mVRo1Awj7beNzA1+vsa/imyZ6XzTgEy8NXq6rOQwuWxwxCo8JOWQTXr50cJfI2F2Igt0M22/689
 khcpjoo
X-Received: by 2002:a05:6a21:48d:b0:3d3:ad3c:49a7 with SMTP id
 adf61e73a8af0-3db0e41e850mr4683499637.21.1789209324181; 
 Sat, 12 Sep 2026 03:35:24 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/82] tcg: Generic expansion of tcg_gen_rotri_*
Date: Sat, 12 Sep 2026 00:31:01 -1000
Message-ID: <20260912103126.598030-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 49 ++++++++++++++---------------------
 3 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7a0b87e13cc..265582c5a27 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -196,7 +195,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index f77598c5531..76263510228 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -21,6 +21,7 @@ DEF_RRI(clzi)
 DEF_RRI(ctzi)
 DEF_RRI(muli)
 DEF_RRI(ori)
+DEF_RRI(rotri)
 DEF_RRI(sari)
 DEF_RRI(shli)
 DEF_RRI(shri)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index abf6b64c3e5..f7531d321ca 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -848,6 +848,25 @@ static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1,
+                   tcg_constant_internal(type, src2));
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                   tcg_constant_internal(type, width - src2));
+    } else {
+        /* Do not recurse with the rotri simplification. */
+        gen_op_ttti(INDEX_op_extract2, type, dst, src1, src1, src2);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -1026,21 +1045,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, tcg_constant_i32(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(32 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1815,21 +1819,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, tcg_constant_i64(arg2));
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(64 - arg2));
-    } else {
-        /* Do not recurse with the rotri simplification. */
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, arg1, arg1, arg2);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


