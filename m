Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D73FC88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5c-0003S7-OR; Sat, 12 Sep 2026 06:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4y-0000CT-T1
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:30 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4u-0008NJ-Pc
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:28 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so186969a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209323; x=1789814123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0oS1/eFGVqpoGzeUmREjnEqA5r/sM9lJ0iZCchPgAtM=;
 b=jMGYKsztEAYTT8Ym06/E8LAzL2Yc1xf//l1fc24nbtbOfCZW2pIqgVLWSleoU/XGJY
 CzAiCBMO3Ji5Xbg04IRp6vpVcRAruIOMQQOcs/gGWVLi5NnNijuXIEEec7d55MQx8lMT
 aRZA/cfeZILpJ/4Zx+fNScSOt70mXCZnqT3OMM5NmjJaZVKz77SglX1nKb/uwhs+aP9e
 HgiuTd0ueIj012mSEclnZCFioYm322ZtK6mOM1x+HfsLxGdh0g68R5GyAg0z7jq2UTqe
 giHVMqR4v/rPfxp8o2m2hr0onsIBiDrr0QJrNN6wRR/LfJFeOF2bunciMq853P/Wh3+g
 +HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209323; x=1789814123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0oS1/eFGVqpoGzeUmREjnEqA5r/sM9lJ0iZCchPgAtM=;
 b=L5d7GyEO3Ykh12ce7RqU6JLO99xVG8GZpYy9KYeTjQqXn70EpM/XEby7FzKJoH3Zxk
 q+UADtymm0fI84Eq96UU7OGGVRIBk5M1cEVQ1ZXYcQXLIaBQrSc5bW7I6RHNYOEgAKoS
 c5a1sFTSLrmeGxH2NjI9QuU82OTVHd/JLwU3PMOgVGsHj7drO8uzOLEy5WNnWiWG1/4w
 slmGc7Niyqgoc0JkWkrfTJrMW6/SgALN+ngGF/ng3ig3an2G9xdfcBqYAPES7fSH4vfz
 8RFL5LNyf3ppCApI6jQ6VWCOrmrIeCavDXfj2RgqxdF1Ttv48esEGZoHBnNzjiKcpdO+
 tLfA==
X-Gm-Message-State: AFuF++l+/APG4gT1TVngot/e8wdQpGfAOydGYuhUAvgXSkgqqQkcL7Vq
 1fFr9CRJXDYBPq3ea36rgRG49cqDTsuynUOxodLGLWF/NzC0HJEOotL2Qyqhvbow8GZ7KjcLOFm
 PxNpD+3g=
X-Gm-Gg: AYBFou1NdSRVyjYVIDa9ChI8IvhmYKIaQxu4zOMB66U32spVcPNw3d1bo+/gZkj5ckv
 94ssLZE5bor8VGDSWfkzYzloUY1xS3sBTPltiJXpLtKpzKHt2BWvwi80r07eeN2f0vINLUOVLu1
 VHfWu3RFXPSJWcwWkr8gfnPXS4TzpqIeaPk7RDc1M4UQlM1qlOBgHxLPYLFa4fxu84IQkBz75JW
 vRtne4hGiPtjjuVaKYZ9BHuoNx85QrHZovTPDaKJCEfMlwjBltNxWWqz3iy6gtztSHTdnEeVRdd
 PewWAMUzpKxrVP327gnQRN0m9+UWQzT838/bSvHxuGhVbykoCI+vyXxxkxjtJ5P35K9OsLWzeze
 cXjqRzxkRNX3mNa5Q/gUCIGNFXGAKG37fDoDcLQkB/SzfO2TvzvIyLpcH2VbYeRCQeE+87WWV1U
 fA8///rnXr3CRhubnazN1g4abfnjkRELnXvXDqeqoiWLoFuIPZ2daV086Tmn6jkXP7cf5h6mwRo
 NW6H/SywfEIrBoEZUM=
X-Received: by 2002:a05:6a20:914d:b0:3d0:ba81:79b7 with SMTP id
 adf61e73a8af0-3db0e12bacfmr4109413637.12.1789209323245; 
 Sat, 12 Sep 2026 03:35:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/82] tcg: Generic expansion of tcg_gen_rotr_*
Date: Sat, 12 Sep 2026 00:31:00 -1000
Message-ID: <20260912103126.598030-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 tcg/tcg-op.c                  | 63 ++++++++++++-----------------------
 3 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 94f880a81e7..7a0b87e13cc 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 61d00fa493d..f77598c5531 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -42,6 +42,7 @@ DEF_RRR(orc)
 DEF_RRR(rem)
 DEF_RRR(remu)
 DEF_RRR(rotl)
+DEF_RRR(rotr)
 DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 677e93736f5..abf6b64c3e5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -827,6 +827,27 @@ static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_shr(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shl(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -1005,27 +1026,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shl_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1815,27 +1815,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shl_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


