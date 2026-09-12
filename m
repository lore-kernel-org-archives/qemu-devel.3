Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD4C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1k-0005ER-3D; Sat, 12 Sep 2026 06:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1P-0004oD-7y
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:51 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1N-0007I7-Fn
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:46 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so578117a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209103; x=1789813903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=btMajdXeq2Pm3455LMStRrxLDtjil4Dtt64blTZw/bs=;
 b=MsIU1MDGPAe2poh9Wji7t6M9xnBJ6RBv4HXSnxm85HnOdfGTOgCsmrj67M3nAdWT71
 3Rx1MYbG0DMuMlbDJBn9gY+hB4htSOVn1FU8h8X/rJgsSAPhCj/3Hf7tlwwbphxvpUZX
 c1sDsjgZZhyEH6vSMG5LBXkaRjeNXIz+KqXCtN+9PKLGyGZGl5QWH1gQ47nX5Xb4YnUH
 cGfEfV6gcRcbMEmtfPIJVgJM65rrhLiywyFVOrEFjQdYY7r1EHmGkx2vMyKWqZkvFnci
 LXYhw3dZs0eowNxre0uAWfypV3bQ4MoRbuyktCjlJgx5rK0tPiLOWiakOc4dPr6SOe2V
 r/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209103; x=1789813903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=btMajdXeq2Pm3455LMStRrxLDtjil4Dtt64blTZw/bs=;
 b=fd9+Jv/U0fpNYieUpu+ySbq9pJF6tINJx8E3/GS14bb/d4Z4pazYFVQhCx8qdBf4fZ
 nBP8WW2KM7Uw0zet0RpV5QRJhFW8xpXoJ/25sxzsFWrQF/bBXtFBbysK6DzWvZ7CjpNC
 zpCg5mtBFuNXO97pv65ap+MlCFIrgNJnKKwTfgo4k08DMtb2Zm3C9UFJkFd/eSlfPP21
 dNwI+c1m+HqFo2khd/MsKGO9eVCRZaPD4JBOl3BpEkMIjYsg1xjo0nuEe+uwS69xSLb8
 v7dgUkeO1VTiH5gVxzLioaQFWJIgptf3XM08skAUoGPIsFferDxw9xoL7GW+LZmINeLO
 pdSw==
X-Gm-Message-State: AFuF++nvBaHOavjunRKKzAnjBMG0IDcvT0T0dcQiYI28WPaf2ZEQimTu
 nKoJndoSuz4pGnNGwCYQ106vWniVx1XRKsBez6cABi+o7XOZX9VtXG+GlsXjKEKmnqqVztRRYgy
 hcVnvYUQ=
X-Gm-Gg: AYBFou1no01yUaGYgQufu29PPzDWQ407bXVxZdKNzBsoErMTqLC0fenCSS56hiTQ7y/
 WYqn8PeT+m0a2XkF7PxU1k2I1fnjQM0XgGeaqYNevXINNye7BohwBoOXIQrR9J8HAnz9wZAuSro
 mHITbWXtDTSGI0FZvAT9KRQld2LDVjkvjZ569c15CKV53I6LpLsn9ECXsDLFrvb7TUuLAVBpX/e
 DvvfjcbcZ3vBddeO6xTDrjdGcbNvPDDq5H7DciLpUxmHk4EK1x7AOJ2ImJ/75bdG/Rl3WcFaNOs
 4l6xSbT9jqsO4wxBmU9x+3iqMF5SY7vBR6ZVL1tvPsnsuSianKVbhez2lnyHIIANFWuGWdO09HC
 OarMDt6B/mbej96dn8u9eRw/xB2eCp0buiZb7jHi0/JkF+/cS3FzDdfFTvr+LEp8GeWRtKrAw3y
 WGQEuxFTrzkpysdX6gJexbcnDOg0wN3ezNNRC+ECzgljtXBgugmEivR/6WtKEDKp4vP74ciJtZ2
 iJ0YtM=
X-Received: by 2002:a17:90b:574b:b0:39d:985b:4274 with SMTP id
 98e67ed59e1d1-39d9bc66ac4mr13615532a91.5.1789209103017; 
 Sat, 12 Sep 2026 03:31:43 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/82] tcg: Generic expansion of tcg_gen_shl_*
Date: Sat, 12 Sep 2026 00:30:19 -1000
Message-ID: <20260912103126.598030-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
index 04fc920acf0..76c0519f26a 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -312,7 +311,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 35301c12fef..f2c37dbdbe8 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -10,5 +10,6 @@ DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(or)
+DEF_RRR(shl)
 DEF_RRR(sub)
 DEF_RRR(xor)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6949a02736e..406bccd6066 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -527,11 +532,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-}
-
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-- 
2.53.0


