Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B5EC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8C-0001Qm-2f; Sat, 12 Sep 2026 22:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7a-0008RV-Gh
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:12 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7U-000119-Nu
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:07 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so509269a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267141; x=1789871941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i/kSemgbjuQLa/y/pedR7giUqFTZ1PVVkH59W6qBodo=;
 b=NJsXCrggAARK3TXs+bYP98ZBBicePJqsqFLDxtENv4AQZeg9C7ebgYxeay01AAo5ui
 W8mRz7U+JDFB6C+UmSL7yy0tBwOrRRZAIxxfwY4GgVpwLrgBK7cXgiSBgjoqMYgEEC52
 +RtbFc29HT/BOTVPIcUGlpewYl2cZJ7et45GaunIzCu7kzd6gV9/1XN6X5kqfHTohzyE
 5oVfLrKeFeEYznBj1TwlsSvI56NyYR7RQU0XmV3piSvlwCp13TcH0jglf/196AZYK+/y
 cd586t3mSYk2+K9QDMMnI/ajADtuFGS4CwsjbHVFVINlPDjXS4b9sqGQnA+V38sGTgD9
 1U4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267141; x=1789871941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i/kSemgbjuQLa/y/pedR7giUqFTZ1PVVkH59W6qBodo=;
 b=AcGISLwzEskA5fDRUj5yVdEE11tBexgFhVwEiwgLQPNI8GL5Z/S0Kma7FJMhouEzrT
 QQmfWhyUsm8WVyxv3302N2klH6UBl7MW46PvQFiilpLdFR0C75DIzfwaTMLEqMRTvwmF
 SfVwUa0pOlTEhOU+EVrQgBMSKXC63KRVFYF28852OsuMdAiYLQFFvK6828LZWtpEo1YL
 WwcXGjtBGFAfAQBMdzcIkKXx4K00SppgrYdJzVTznSXkS979F18ste4w3fqteBDhdObm
 LibL9vo/zhNILNI44jWi761WlLBn35SLjRtkV/yhtVCuI0sw6R9yBAUmDSwAlsV2OEUc
 0Nxw==
X-Gm-Message-State: AFuF++mG289OEE0gMpUXoink3TF2lB8dkPziomNSgwK5rnlwXY+b5iJ8
 Zt89H2DTqatMVPXKSezcjZ8AOiUbDr9ndlog/7H2cUFjyruophUYuQ/klTDp4zAzhtvjQcAmtsy
 zB+HvfwU=
X-Gm-Gg: AYBFou33wfSJUzOs6zo9lRtGPck2N2ViZxrHiDYzhtK9Jx2mzieubv5FeS6Ffyf/fyZ
 027zJ5XWLs4ub1llpoMU7gne7WUCk+FfXy4LRXPKVHmgWJ8Ll8oOaN7pgJIJXIWrB8voDjPR0u1
 57QEKaf5PbzrdtBHnHcJgmJlWJzl4QtV24W22ari4JNddH/Fi59AmDKW4uNvQuwQ+RVNrtiVgn1
 KIPn5NOLSKDQRwucrmmZzPp9Pzwq7Rog4Wkdbw6yOyMc2w85y2CxQaRVrlDAONrlbmiXlTbzoLn
 DQiCpdg+6O+a06hkfck5BeevGAhdobxtcSsMRXnY3+BvPv4CcIL5J6URQZ4sfsauN2L5zvALQ+j
 lVwlWOp4Cj5fGdoMp5qMgJQweIZe8aRsg+vjnHlOoLOgMxIeGflOlCrhSkJVJgL/t5Y6VIEbnCW
 afdIWg0g0J48AiDUule7M9ICBrCLq+v5+cQLvVdq9hoZEGv6PjmvGY0QGpCg1TEh1LS7fa+t8Yi
 19MDrI=
X-Received: by 2002:a17:90b:4fcf:b0:398:e96a:8999 with SMTP id
 98e67ed59e1d1-39dbc697718mr9688936a91.16.1789267140635; 
 Sat, 12 Sep 2026 19:39:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/86] tcg: Generic expansion of tcg_gen_mul_*
Date: Sat, 12 Sep 2026 16:37:29 -1000
Message-ID: <20260913023837.741866-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 69d02396a5a..36f99dcad1c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
@@ -311,7 +310,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 247d35bdc14..b318ddd74e2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 91e7f488738..50b43da4006 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -433,6 +433,11 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+static void gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -635,11 +640,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
-}
-
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


