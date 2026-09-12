Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A583C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L23-000698-ED; Sat, 12 Sep 2026 06:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1g-0005BU-Tm
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:05 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1e-0007Mv-VB
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:04 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so9502335ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209122; x=1789813922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XvhBIsCLclU/WC54qjgy5DYlefKGKKxdhmhhdbdetfE=;
 b=pQAm2sF7hGR2uXFo2Zq8Bajj1c55xkDw2DoLMdXVVIByUmNLHUYe2O+xmw/x8smqAB
 OBLXyWK5CfhmoJBKjYQsaTcBNYuvRC4JXevm5I583RfVcSZMpTO5OARM7K4HFTIXesnX
 aNiywWOSy3i7mioYTjzhQ+Bu9oeFKOD+OSGwEikkR8F1IkTYa4f8aEZgBXehmFXCwzuC
 BrakAQWvSItpwlZsabdg4OB+R4Bt+yemkMMSTQtKZUKibZ/NYC8lbj6oi/vgt+nhwK/M
 8oPE8g8J4MUSkgpB2AcMPZxR20j7GEiNLtUYdQOCviTDLlJ7nGS8UxHX91W393P4O400
 Ld7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209122; x=1789813922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XvhBIsCLclU/WC54qjgy5DYlefKGKKxdhmhhdbdetfE=;
 b=dJ2V2BbjSNzXLwA6e9qVnn+2fqvQN45raQBolef4kCDYjhn4ZCfL/Qh0qt5RSi6yLZ
 bHoV6VavB0laikoU2jC0rWVMDj5WLk5W8h4U4PFiZeOf5zjBUQ3p2nmR8fHlwzcipgdY
 NqoPjQqJ+Vm3MAFcU7kE/sX5KN3478/BGxo686HwSBHNA7h75PWIhGHlHUjFRAWXcnzm
 GhkS33SS1GyiSgqfH0QqzRDadAB2fei1O/jcLIhNMPsC0Cz23eIpdDmGs1rUvJszN/hX
 tdEFYGz94ePNT+An05yoN+m1+oRzRt/pOkTTfOAQpvmjg6tUJzldXPCyuEVyH6Lxw8ku
 tR4w==
X-Gm-Message-State: AFuF++lejvuKGVqog4NRFzJiJe7gh0DLoQGEQ6nh96z6ZqCQI/9DU8S1
 cqgZBPGOoVleSB2Sv/PCxKAXTpkyll6YTuiyRWt0RMBB4La9WQMIV/xVFzUllIxtmfvArptAyKy
 bUK3Um5M=
X-Gm-Gg: AYBFou0a9UVyXfQ6hkmQ5jIEWbSnQm3SCrwE/k2lwCz2SWtbM8m6sZX2lM9l02vTtbl
 pRFx3cJ2DhRD/zHWVbRSjBTSgi6rrTwabKycyRpuI0Uu/VfD6p1HXzDQKRmO/DkhYINJj00DB46
 LTeJdG59WaH+k4aFu9ow7ibHMQFFBAGlTY0raAADGADGmmBlh8Y/a7+oPvJEJwAeeo1kI6IYmhS
 PoUbwsdXUY/murLjBZ4YF+sTBaqL766tHKvh+2qcVKfq+EaHbjAT5dTnhq9SuFGPmbG4ZWqZGhd
 pB+sD4FFMJznKeQYOVdC0CC85Sh+ibXs4T/yHCfWD/VcQoSEJHQnWRj/yK0N8lL/YHLorwsNCIh
 WcHMD7FkP07n6MJzVuHkBMuTsRQmXHJoYNQyZS+MQClGXNytlzFtqxbwWXzCfEfYBaDXcVpBv9K
 mJDsLBGNqp+ZlzdvYQsZFSw3gjHEMJKDst1YOEhJV8whNBG3weMVv8HxAjN6J83T5r9ySVSYX3Y
 dUZrVID4Qxt9+cmjQ==
X-Received: by 2002:a17:90b:588d:b0:398:bacb:1137 with SMTP id
 98e67ed59e1d1-39d9c3771a8mr14290906a91.19.1789209121579; 
 Sat, 12 Sep 2026 03:32:01 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:32:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/82] tcg: Generic expansion of tcg_gen_nor_*
Date: Sat, 12 Sep 2026 00:30:39 -1000
Message-ID: <20260912103126.598030-36-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                  | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6ee12cc2dbe..b48e85f0b9c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -196,7 +195,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 276c0059ec2..055e98672d6 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -23,6 +23,7 @@ DEF_RRR(divu)
 DEF_RRR(eqv)
 DEF_RRR(mul)
 DEF_RRR(nand)
+DEF_RRR(nor)
 DEF_RRR(or)
 DEF_RRR(rem)
 DEF_RRR(remu)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1caedda8931..87fb5fb5f51 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -508,6 +508,16 @@ static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        gen_or(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
@@ -743,16 +753,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1770,16 +1770,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


