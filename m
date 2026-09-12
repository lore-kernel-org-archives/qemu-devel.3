Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002F4C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1p-0005LM-9I; Sat, 12 Sep 2026 06:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1f-0005B0-Re
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:04 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1d-0007MO-AH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:03 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc4bdf8acd6so536410a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209120; x=1789813920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NFhXHnkOKC+EBaMRAoUunViUGtpLxryiahZICyY0VSU=;
 b=CbH2J1BvjWzsuFmnEy/TvTvCCW0y9Xo40eg1xKISVBfK+ToJ+gU5PuUFUMi700lVbu
 r7aXKECWTbCR2zIK2T/4/T1XpBZBQMg62r/4wbqxfQ1l2PqRM1a5KiP3cZNIu4dIkKiA
 RXr2PWZ0Gx2iwUbI4ZxlLaJvISHM5jvytvmx83Su0EC2f0c068EoInxvJthZML7d6fjF
 iawDLKdhHpKr6Fu2XKDAj59ECuCnooUCt/rLtAKygExIPqiDJuQV1pHiiXqXmskL/CfJ
 rsPQkoocZhmmoU2mzRCTjR6gfRwWOy4AE3WKYbHE3Nyobt1xfmHcwMGgtx5gnjm50xpO
 eHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209120; x=1789813920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NFhXHnkOKC+EBaMRAoUunViUGtpLxryiahZICyY0VSU=;
 b=TVBDaARnIVNWVGdrzfZte54tMGzFQczpngcl0o4tUj9jueAvTuSt9qZOzLpxewI7EK
 K5cabuZWjkAmfN2K+L+T6LoHkxxFTus5L4ZEm7WVThJEx9lw2IRth+X53YJJgsF4h68+
 mgXAzIasG+KTO271ZKKzywQliEbJkIU4iAOLkilhahBdF5W5PcrUGwyhpDw8AUMoL6sw
 gmcBQbMzgRm6fI2grXSoxXPXyJ3ce4eMXgQ+VSxWWdJMkwfwDp0Z3nJ3Z+5+36q1J/24
 6eQpZiYYMxFIB9aMzllMXp++WKmfolsEk1leK4l+WYoTtb7cBQZJUT6OjjZtHV9xRtnp
 wISg==
X-Gm-Message-State: AFuF++n0gvPqLoUNZ0wgxEvh0cBZnl7iXaaqgDjU2XRFcbEH5nSPJoqj
 hnPtT7+f7EZjhFsx2MAwbLYVkArX/NlF5zbI0L1F62SMGbwDdvfE/wLDhpO9iaPTEx1MoFrSsyj
 bmxC0LXQ=
X-Gm-Gg: AYBFou0uA9v41pNay28Pmkke6q6aMCM7smwqwWli7LiTlrcR3JL/MLQoD1TP5JBabJD
 1Yz53/SsMutl/qwHV0blzCj13+ldX9k0ALzGpuk0HQtx5JVuC9T3WNP3FipsFqT2hDhw4dIq44Q
 XN1Ax6hux5j/w0QhI/X+YTBDGVCeFTdVu2fbrN2Q5BYJUmo6dls49Ro4dBt0zoaGAFe5ANvkwHJ
 rwrSmOWIPHxHYF0l0yhuRWKwR1NHtyxUZWqKNhxw4QjqF3TxW3z7TjYjolanK0alyuB1pvJ5tcG
 QTb5YApxqEySPcW5hzji/Uj9XmeqdkrWRLIRFlngEBPl8toNRYaiWi3p4jKJvZUfjklT3Xqfp1W
 8mhLSmhR32/p3zW/TJaPIE9jq6MYCzCiCsDIKQYKCCEjg5W7uI12BQil2DCWNX8ruXC8SsRM/TZ
 8A5KsnOT8GcHlj6EtoUGHxstkayoNqDl0C2uY7FdIg9VU2T9tQu1mlIu6p0Aaji3CuMmmYpmoLv
 UVVEKMeErqZH3PMRQ==
X-Received: by 2002:a17:90a:1596:b0:39d:9c5a:6cb2 with SMTP id
 98e67ed59e1d1-39d9c5a8246mr9304388a91.15.1789209119815; 
 Sat, 12 Sep 2026 03:31:59 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 33/82] tcg: Generic expansion of tcg_gen_eqv_*
Date: Sat, 12 Sep 2026 00:30:37 -1000
Message-ID: <20260912103126.598030-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x29.google.com
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
 tcg/tcg-op.c                  | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b458b1a0b64..7d225eed9b4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 54c3c51ed29..3b2807c48d9 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -20,6 +20,7 @@ DEF_RRR(and)
 DEF_RRR(andc)
 DEF_RRR(div)
 DEF_RRR(divu)
+DEF_RRR(eqv)
 DEF_RRR(mul)
 DEF_RRR(or)
 DEF_RRR(rem)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ca383e44b59..9811b26a84e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -445,6 +445,16 @@ static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
+        gen_op_ttt(INDEX_op_eqv, type, dst, src1, src2);
+    } else {
+        gen_xor(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -723,16 +733,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
@@ -1770,16 +1770,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_eqv, ret, arg1, arg2);
-    } else {
-        tcg_gen_xor_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-- 
2.53.0


