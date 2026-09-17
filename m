Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E60C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nK-0001Jb-3P; Thu, 17 Sep 2026 00:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nB-000158-4y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:13 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73n9-0007CB-2m
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:12 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so247238a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619530; x=1790224330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qe/PwE2iMATNOOIZvTWsULxmmq4VESGYWl2IC//N9r8=;
 b=BsezNvvCMFliJk+1xo1peewIJuU9NOeKjLCWwXnR3yk5R4OF6KUre1z9FaOlNqaOi2
 PTxRXP5HYxecaPrFOb1egM4X9oIo4MOzd00U322MUQdMuEbS6YqgUJC1ErcwPLN4F6FA
 E5urAYMETZl97/ykPjqRnQYbCBAKuNKpNwIcmRyvcAFGiZE+Ze+ZhmgI1jy7vSKWm1ED
 6l/73smZnAdJkZdKt3+EzoQR0kj9gLDpHw+t/DHWzmtSN4QnQD55FAXMIl/vSfFU1UqJ
 l4orZcSlnf3aKQJjenUt5uh+nEaMMLpzDE2mIp8XMRZfQvEvRpCTbRY2iAjK4jgs5jCZ
 CX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619530; x=1790224330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qe/PwE2iMATNOOIZvTWsULxmmq4VESGYWl2IC//N9r8=;
 b=kFCTjDtg/0Up5PCKo+mESgpwhpAL36Ht9dAX44ysyzE8xBAigf5KxEwp1Nt6bqhT0I
 81r/mjOaLXe+Mhy1uNjpcUiYNa4NmlD0eFH+M6dj1KaVKfqb3yO26su76IMihmL1DqVS
 yM0cRS+vp6jUahPa0tAJyPItlKOWIvxB8a3dxHdK+aviCaM9tCLIizdMlmUTQhjwBy9X
 ZuAcyWMd3IscmeOQd9NwcK7fQbhvJfeAU+GQvABWhSGXmVleznDHa2aqocwkOQL4HdYk
 ed7i1gVq1WRCCj/zfAIixoUCN/+mcisMflYExtCqg+OxWdzL4P2Td7aO0iMjDi59G1kZ
 FWYg==
X-Gm-Message-State: AFuF++m4pDMsoT3gPoR6dgpiIEdvqpt+0u2sagIlu78lp6/FWJ1e4Utm
 OkKR7SdmTJjyMmig91hQPZRz6GJ5NmS0qOb+1Y5JSX6c8pP0txrSh9fHNyE1lHLxWF0wZgfAImq
 ZK/gohq8=
X-Gm-Gg: AYBFou2L12eq/OO/Ymc0JRr3G3+ODkvFtUHvypDDghG4uJUlFzbxgmZQFrVU0Djsf3Y
 lUCFQOmD6fscH0Ysqd/nzfYbfqrUr1aRUcCtKI14mMl7bpwI+lhIWAOl1M+Jk1+RuFXfYdthDqV
 +hfkOba6DKiShuetnrluAQOm/k4OHfEyrwhUujAB1CBG+7iysHupNHdYK1eW5xoYz+jNTnKcYM7
 pK/SAxzfofLynd3dsNJAbFCJus4lsEBKORJ/YB0LQk55XggwzjExAN2ry+6K0EsPwLGc2NObzSL
 BZEoxih7VwsuP24c2NtGkEX/GPwS4yYKgCG5yT4IYYRJG7fnsPe+KC8I0Cealh0tBiekB57D5dx
 3CF3QqJvRWznwZ6zxtMEfNJTwbsoMGMRMtaeUCatBDIkq5Ih/I50VUCHB41/ID2n4m8XVzo1Vp4
 cHjoH3qilRBw4CjNOO/ES3P9oThmFMGBxAvWKuXfUuXlYNsZ9gdQPelyu+bTzwcVYBqGI7nXROT
 B9TCRsjKZgedAOghg==
X-Received: by 2002:a05:6a20:2586:b0:3d3:ad3c:49a6 with SMTP id
 adf61e73a8af0-3dd5f73ef7bmr13040228637.20.1789619529494; 
 Wed, 16 Sep 2026 21:32:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 040/101] tcg: Generic expansion of tcg_gen_nand_*
Date: Wed, 16 Sep 2026 18:27:22 -1000
Message-ID: <20260917042823.542588-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fbbc3acad83..613e844aecb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c1b99a280ac..80d174a6cb1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4a3622692c9..47381b7eaf4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -524,6 +524,16 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        gen_and(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -735,16 +745,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
@@ -1772,16 +1772,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-- 
2.53.0


