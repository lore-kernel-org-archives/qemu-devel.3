Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EF5C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBM-0004DU-5E; Sat, 12 Sep 2026 22:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBJ-0003ti-DT
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:01 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBH-0001zo-IM
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:01 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-381b831d535so4174298a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267378; x=1789872178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L7RLDnNxBd36zZ/dxKGqsx4PjT6QesImn0dDwC0zLws=;
 b=lmpoE5H5rHcN+j6Vo43Ski7R3juZ4tnXtRSmgJkKFc3dtbLXjZ7mU7NLbhU/WB1qM0
 tX9vlqPifbPeF7qoDf8kYjlHiEx+mAMBhVwngk8aKlkzVPXCyf/HUk29sczVNR2YHPaG
 y0pqm1PXp9i4RDDq5YBfJiR6jL3OcLPKl6WgU3SQsxZzIyytbhSX+5gG7OPpmD8O4tDB
 sgbNo9SLZIGfnzDpM8Wh9FpXPJ4R2FvGfMS4da8qAiyoXgJQuX5Vpuwg0oH8HuzK00In
 T5vPfPMlyVaPvDsA19kq8Az+5Mg+zDhG6dQUsHqOMuhjjjeoXe03z+zMbl4lbotEnyOw
 Rh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267378; x=1789872178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=L7RLDnNxBd36zZ/dxKGqsx4PjT6QesImn0dDwC0zLws=;
 b=Gs2/8qlS6RRdLgso4eBM1HmeQ0uE1Ce8z1189fPsnvIhhOCATaQByW46/N0G3SBXev
 78ZkYQCBseqIR1RSjCYx94G+7TzXU8arXhv77s86cIo+NWolP3fKtP0DV98I5zZCr3/a
 l6qj8S2iJhnqmzyzuW3JAc0exvgiIqmt4X0gOm77b+KjCko+YRehN0S1kcS2XPPJc1tb
 uTKUPDR/m68qnJj0b3JNAVOwLRl+qzD1lB5bIatJZcvCMZhVDeH5T4PM1Vy/cT8/HjTD
 DsSIlfZ8DJoGkzpFbHnBi3pRVU+FYpFWIL0bbiIovPL8cMJXRws+XmpaO507c78GdtvL
 jUtA==
X-Gm-Message-State: AFuF++lM1f5NIGj3YWMocgWuR9aXuCM2iI7nhIwU1tDK+trpgLW7HyRa
 BPHfs+R+0UT0xTOjbF9pndNQkbeh0Ojz6ndAlTOtSR7fkNenKnK3mplKmN1d/aEsEZtfbfk5HAK
 H8kMq
X-Gm-Gg: AYBFou3X4Dbj6FcaAEEqiFcdHG3lkNRp/AWHj68CL2i1bETR8kIxBHI9WF2AlC27jcP
 dIiLlha6O2C2hAOS2oS108CRMA0Q5a74Vq5tXVVSi7l4t1TdCnBUua0uUKS+cDMwYgzK7+7ka2z
 wrAvDC8ZsMG+8S4+S7X9oV+sYjn/wwW9UFiJBb407xIljPpGTgHbQTfh6DwV5fwq5DLZguygCrN
 LUUR0RFPB2b9vQQ2YF6ovsj0FhGmhUQ5WodgDtM5VYfS0sD/KDmFDzfVQebWLWba3xKdMT/vDM/
 ghG9R2PuwSSQhtHPG12lwLPmo+lOtzk5U3KCZEJjZfqEXsuvelyyHMUjk2y83r/TPaDKdoRlOA2
 MJaOC3ZWE9EY7DwGmXXPNG9vdeEqXsBstuJtYrqpXvQ+3lX/z9WvPg1UXKmQ8zwP95n9UqZzdCJ
 IHjs1MeetCX7CKDhhGPFVXUXYyGv64h7+8zTqeU+b/Y1X9kO62BwX+zVYDybISBOcGHk07CX9i3
 3uSzA8=
X-Received: by 2002:a17:90a:da8f:b0:396:6344:3b63 with SMTP id
 98e67ed59e1d1-39d9bbee490mr19189683a91.2.1789267377290; 
 Sat, 12 Sep 2026 19:42:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 71/86] tcg: Generic expansion of tcg_gen_umax_*
Date: Sat, 12 Sep 2026 16:38:22 -1000
Message-ID: <20260913023837.741866-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8ffd722d9a1..e040ce444ef 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -186,7 +185,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 70f1fc48a26..1405dff32aa 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -59,6 +59,7 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dc472328300..401c7a16f1d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1170,6 +1170,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1476,15 +1485,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -1989,15 +1989,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


