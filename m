Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA60C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aAs-0001OI-Nz; Sat, 12 Sep 2026 22:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAq-0001CD-8c
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAn-0001r3-P8
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2d715f4a587so30663105ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267348; x=1789872148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vH++rYFpP5AU7CTVrDXJy/WyJH39xervxkMUik3yuUg=;
 b=Ruxzz4i0+h4rQRr+7I+k1YKMHb36U+ySUSWkjQln68N1wCK+6jVy3DBP7rGhvbvBB6
 Iq5Y7Ndnf0Jg3sTzuuqulTxf+tglBeljFYOQdsp7FBT5CsiCLPKxDbcKNHR5d/o3CfhP
 gZMJTB7sP4XxyYxNIH4x9N/HsYd4VRLKnwL/aFE4cAz+d180ZQbFaBI4zp0JiociMDyn
 yTAhvY8gyBfJ9c8YcdXZk/cDjgJT96EnTZf9Ct18weMSC6+N+0f9WACR7ZQAsfsjJKFW
 TP+2AyG6hgm3XjiBrAH2QCHd7MXJf9LB6rG7KN1pwGR9LZ7+oOFD10hImaso6ZlanezU
 Py5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267348; x=1789872148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vH++rYFpP5AU7CTVrDXJy/WyJH39xervxkMUik3yuUg=;
 b=iYUzyXsaYZtCn03hJw9FjBTpEp7/9SqCC9WnBbn6OD6cFxC3I/znkWad4r2+a2NS3s
 cCeuAZ7tumGghiAUN35AFj0yT8AbtewBcMlSx2CfxIW5ZFU4pcHspOMIGpDkpiLpbZnK
 2SW6AVk07+x8Bi7c6WpvcwhP+ojI/IVA+pz3Qn6ubbtUQLs9b0ja4zmdfhvmHEQhsj3f
 ggby2K1OsdHeKBMBwQjBX5LD161noumX65twgBFSrVx0bknKxRlvKlmQeUpr2MClI4Kq
 3QhBRpB/Vj9b1/3IVkg0u9kmw73AJW5Y9Npk7mUK1sR3mnJcyxRpFBeEqContG56ut34
 ErVQ==
X-Gm-Message-State: AFuF++lmv9aeFZOEvLzO9KM868EE1MGcBNd0DK3iJXl2E3XGsdu02mLl
 zDkEvlNoI5q0YoOjuhORytX8/mTOtYMpi40adaMPqR+wdBjyZ4cDg4kB/HGnx4MiacNC5TkKtOM
 TzsioUyI=
X-Gm-Gg: AYBFou31QUDZEhcbX/wDy/CV4obP8wF+Yf9UOFV3fOp9PKWLYnBHEp8T5DR0ilSvClq
 8hbAsqXXgdxK6c3KcI5feQ+nobwlA0ov4bVfbUr59SS9D3bvWfYRpqXZC9xjfVogJYtde4HSrBt
 kekMZvvDvHLNFXleZTopLSdElmPSVAtxvXKaxvLDhpV8lIowEOYDEbp6fxnWJ/j5oDvD0z0BNo7
 A2Wa/v3HW6CZCEMHc4uJprJDYotD+V/LRDL399rp79poDKQ5Of47jn4gi1PZK7DOkRHJqQfFfFc
 hcQir5UQobMZnx5GipgWjBl4MQOAAI8NlL7dkpKSW4dqDMMfKUlm/QxpUBqfQHWLevpH2M0Rx/g
 F2mzUJTeOkRA/N2TBI3QQropGyE1TG9Sa96OBzLHJrGXlypLargnLzQLRAWmWqdfdaoKV79GcPa
 NKjPHAmZvtRYer8HhrnLYbq60r18aq/5rtg8LmgrslNh8shuuB6kkJCeZ5IzSw3YsDLT2vYbqWQ
 CW9zSw=
X-Received: by 2002:a05:6a21:a96:b0:3d3:afeb:880 with SMTP id
 adf61e73a8af0-3daed895710mr19844266637.28.1789267348217; 
 Sat, 12 Sep 2026 19:42:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 42/86] tcg: Generic expansion of tcg_gen_negsetcondi_*
Date: Sat, 12 Sep 2026 16:37:53 -1000
Message-ID: <20260913023837.741866-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 42fa516550e..ba208c0bca3 100644
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
index 8bbbf39f13a..a620c8ad69a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -18,6 +18,7 @@ DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(negsetcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 681e78f93a3..331a43b28d4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -590,6 +590,12 @@ static void gen_negsetcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_negsetcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                            TCGTemp *src1, int64_t src2)
+{
+    gen_negsetcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nor, type, 0)) {
@@ -783,12 +789,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1543,12 +1543,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


