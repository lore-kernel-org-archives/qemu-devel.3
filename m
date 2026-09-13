Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79600C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aAu-0001e8-Od; Sat, 12 Sep 2026 22:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAs-0001M1-4N
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:34 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAm-0001qo-AR
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:33 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso555961a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267346; x=1789872146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v4G7k6VxQaiebUg68MK4mlzKYrCCUG9V4y/9KGqgglQ=;
 b=aG/2iycYpO0y7iNm1/nzwjklo7lo/4QjIkxC3mg3XlXYn5YqSW0Q6RUeeTvinASjW1
 AbRX8U4iTPjoSi1in5heMHzmyQhmnzfbRcGJEy7INKThaLYIcREw2bTprLGbTIAxTrvf
 C7T02vEf9cUmlOsgSTr90OfLUGYpUoJPqBkCKAe/B3Gp+Ja3cHxB7sODVKKxaDvBKTQC
 iZOytJIPsmpcS3VEGscqPAQ/nm9h0A2NhATg2vYejLRmy4OguXg2Wrd2KBiVf26jvj6L
 g38lgzGf71gJIWtCbsm3vtHqFh9RjLCfxade4KBsFgg36bYvWs4qQerMyvE/Mjtq6OVA
 idLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267346; x=1789872146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v4G7k6VxQaiebUg68MK4mlzKYrCCUG9V4y/9KGqgglQ=;
 b=GfksbrHGTvx398/YwHvmvqaB9F60hoctGYgW91n3ld8q7p/+9/OANj0UgcjfU4GfAt
 T8k9zOhWbMKKWB/iRbLI2zVzwWdXmjaiL2MLaiVMwfygKtlmXD0vVSMk1pDzYo9d71zo
 vtl9MZuqcVxWgFR7abwilsQ632QYizyeo0qB/tp/0adwjk0GPVWcaNtCzM77jb7/e+fn
 qg9Aq4BhRups11Nhx1pCq3ZYkZ2Vo7m1JAF7e3EaZnWN/ERx0kebLvlmaE3eNTWE7kWH
 vekSXqpJNV4mQ1GL8TFRkF8TDhzdUgCA1/3spa8kt2QHTWYmUdX7++KWBJLhvNk6urJQ
 l2Cg==
X-Gm-Message-State: AFuF++lolJG455rU3vP0RSky9lOySdN8AkwNYh2rSM3DTjZs4dEl9Q5b
 1einoxAD3WTv0GWJ6clHIwTouIIdyaYJQqRdPUYFEnkwmBAQrf84adCXWRHEzzYgvOaklqZUMME
 P76j0Pro=
X-Gm-Gg: AYBFou1wBnXf6Cwlm0OIHh7y0O1dJBR1xkbRDj2BFn8FGBGPWRVm2q1g06n6Uy0RezD
 B/GeYcQmBB6Nv5Uvvg1Ei0Xdzba4pdjjANzrgD1x+WAWPckdB9kJoNwrqqci0FxFVlR8KRVsbf1
 Yo78Zl6c9yObvPK2R66bhhOtKOK3/XrJ0AzMmXtGe+o4SgxkT9YtYXnnneWq1ZDK5ucnOVvvD9X
 rI2mf1fLQm0xCeu/CEjKhRR4SyM04PV85NivLuMu4OtqFLFeYuFpzcNumnLFHLJ7//J5XGK+9JP
 xvV21WPsntMmiRonBr9wxu9Sle83osDmP44YUW/j7kWFCNwlzrgNDgHjgE6d7F0SQnZzTsGAr+J
 DocC8zEBROrP6MFA4bZ6ivn2fXO3GQ6OHNkCRSTw5gUn3RAQO7BMBWOB1BfaO8p3lFC0umOImiB
 hGVQ8zIOvS8MhMpAX7HlNTYxkO6aNJKkLC+2rLCNArQ5LbhQ1RbrwL5XI73CiSUR6Y2BWBNMFOY
 3SLMWOi1Qv73HN0qQ==
X-Received: by 2002:a05:6a20:4392:b0:3d3:b02a:7252 with SMTP id
 adf61e73a8af0-3db0e499f64mr9513163637.28.1789267346343; 
 Sat, 12 Sep 2026 19:42:26 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/86] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Sat, 12 Sep 2026 16:37:51 -1000
Message-ID: <20260913023837.741866-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4e8f1473c4f..1727cd719b4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -215,8 +213,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6ce86d2005a..42e0fde523a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -27,6 +27,7 @@ DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f79722a2b84..6e1dd23e972 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -697,6 +697,12 @@ static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+static void gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                         TCGTemp *src1, int64_t src2)
+{
+    gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -765,12 +771,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1543,12 +1543,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


