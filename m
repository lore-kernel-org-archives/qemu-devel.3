Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F0AC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:07:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoA-00054S-77; Sun, 27 Sep 2026 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkno-0004RD-6E
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknk-0007cB-2w
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:07 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0df0bb2d6so607743a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499843; x=1791104643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6IArgRhkFR8m8dNT/pQ73PxvnVdM+ob1CUoY2TWlzOc=;
 b=snbpJq/EQwTkzuAZ/wn2EZPgwfA1kP41q57E3gJ5Y9q5RinotCWTf1cGPEwnhtMpla
 N3ijJMTFZWmjiJ/FmXo4zzJm/Me51nIY/sIsItVDpyxtdDzMcJbDATAU9bEfd6/TGova
 D/BYERlAo7opefHHdbrqiOgg9jXgo+hhYFY3KB7DkDHLU8KRQKITJspaTBRa7hpp7xIu
 wXPZ90QWCcFFkHiEUGOrjNSsJHq14f0FRE0WZ348uIVetjHlyAhrDE+QcSPNj+CQSzfF
 54S3Bz6Lb9HwO+W1wn/6tI/Dz6zZsLMFNWks/Dg2IzSIOeYhKTf5+KWiyK0WJBJXR17z
 Y7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499843; x=1791104643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6IArgRhkFR8m8dNT/pQ73PxvnVdM+ob1CUoY2TWlzOc=;
 b=ia6JNY1tm04iSNzcVqRqTNN4SH8/y+G4Qnu60/nsu6/JwsvWzVDIlzKL/nQHfkImHQ
 vSSXzElUNDvpTmw1Az39Pq1n/XFy5ig6/EtX6pUqyg5ru5/aSbkjDQQcFJPRKUbKvL28
 xFNC4tnS8SRSeZSzOaCIZUtbh23xIbWfdRVQnFa6fEuWatPvTexOt7/8g6448MzyGfW9
 zzMx7lmpUyXsQjlrgVLns11E2DswMjP2D8DNNzdSanlU6RLs4msdWq8o8KgDVqqHsjkJ
 WKcLvbbBDaumVcSixTFuyN73gfnoDULk/mQTtRdk/Rml1Pr6+06M/wX9mPusROQ6pLIh
 iDmA==
X-Gm-Message-State: AFq9FYIkhAhnnKde4lK/5X3rTcZkHlViZ5W67HD1h6gz6bI7Tu4xR1oE
 KfBr6X4s6RAurATxIzkZgluUs+SMRXwdmF/TnpI4Dgh3shMj94oHDEQbblfscvM+ubq9Phk66n/
 eMDYk
X-Gm-Gg: AYBFou2Juv3Fs3F1IaAvldZTgjiaDkv0Inawpt7ENnWCgt/yXQ3nJ9MWhLk9aqXzxOi
 IhLV9kagxBzBuKWi+K9UZ8mzlcgJENarC+KpjyerkDmtlQ68KcmxPba+6fxyCnsuUe1kQQbaZv7
 RT+q6/nQrTDZn6E/lrIOvGax2h4+gWZkD9q2ba5IeH9O4qPiJaZ0BiZ4dzCKBM8VB7+6RQu1Ep2
 UNvY/a0q7MmGzY2lGYBVs89FbWsZsNG0cizBFlEOC1f+M4lqcpwSsM3QQxWCS+4axHVPRPadQba
 zXDD/wBbtRDe/cwxdvTiDGXGxZAmw1FPVTGvIsndfE6iQ5ILJfjLLMgI3kRtK6+5KmX84K9WMUu
 j+A3zeD5C/EirEPE18Lequg/nRoBpmcNVLEyOQcIwKClOqZSVu47Jl0/Xfzl2/+qVnQDm0vl2+p
 RhzLpKtpBXKaLVqzpl9dtpbWpSjZBwXEOQ/SHQx/v8jFbvGYhtk7A3KdwcCQqYRMugFCUMXIvYj
 /qAiLHyFSKJ0CHyjBp5bvMypYJt9w==
X-Received: by 2002:a17:90b:582c:b0:3a2:b70b:9cd4 with SMTP id
 98e67ed59e1d1-3a2b70bb0a5mr169972a91.12.1790499842648; 
 Sun, 27 Sep 2026 02:04:02 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 048/101] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Sun, 27 Sep 2026 01:59:18 -0700
Message-ID: <20260927090011.10724-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 19 +++++++------------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e752dc977f8..7dd50bfae77 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -211,8 +209,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 1ab2c69cbe1..846b781c836 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(negsetcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 82917d148a3..a12ed17f3da 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -531,6 +531,13 @@ void tcg_gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+void tcg_gen_negsetcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                         TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_negsetcond(type, cond, dst, src1,
+                       tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -721,12 +728,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
-                             TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1481,12 +1482,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
-                             TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_negsetcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


