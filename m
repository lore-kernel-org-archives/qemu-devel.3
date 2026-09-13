Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0638C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBW-0005Qz-0o; Sat, 12 Sep 2026 22:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBR-0004pW-1Z
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:09 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBO-00021x-Me
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:08 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2caced6038eso21445345ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267385; x=1789872185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0kQRdVVf5CpbpgSvl1b4B5/GMPMO4cFPunvvMj90i00=;
 b=iZS1D6RvLE8mg4WhBqN1X5/rOF18tmUHzE2qXlX7ZGHpSAbnbAwIXGe3qmzQ/vEWM6
 XUBGdjUROxnHxXDDB7xOHzdiEY2pGkC0ub1UybUfo9LrBTIcnwelI4g8+iNL+DkGjSWI
 qa6sFJIAO1HfaDF1XN7rhtMD4HCpfJ1QdmrrZ/IDfz+4vf2/go1dFTkFzNnJI0IvRymH
 cQvORcuvFOIIGKjyZvr05NyKTwdH3L6NEqnyi4WruLhEw+B9VSJTxfopdH5ZNZc4cYma
 +oZbQmM02TOie9GFE40eRcTt8HkHKEOOP+zJ0YHqb3H3uvZqO50PF2xN7E/vn4jRQSxF
 PpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267385; x=1789872185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0kQRdVVf5CpbpgSvl1b4B5/GMPMO4cFPunvvMj90i00=;
 b=YY/0VFn6B3+PsT2KzSTSXDgsYR0OP742Lr7RMovG2JQMNclYg4eGBHnoSXF6ti01RC
 QbXLznYKgClHmLMBaLHm2CWL4JuKguVe8yItfKAq+t+iqRyKtrI0tYEmiIGZbRYXYYU1
 6Y+TPbhYFyLo71qvBM3wx30G7gj9Mb/mNYCUkzp3OtVPod6xm+q0W2ePzkug6tSBRf1d
 umT6HLI47wn9GyF6TNxfcnuy7xdWQnX4tYhxsl2YvAAd2/TvRlHCh8uxIXaPfXi6Ouot
 mrRHaM7qYc4mZFqSYGDqFIdFn1XiecBdzKxsdZILpHefGOm8eOCMwJzvgO1IkvhgOomK
 W/CA==
X-Gm-Message-State: AFuF++lHXMj6JfjS7JrenYpTYrshWbwSjihvJYWiTohRNhk5A2duzX7N
 mVQmXh+btvkWDB8NowJ4qmdFqaZf8MCe8LC761qGl0duz4cvSdvwryGu3RsTlOqE7YduYAb11U/
 oQF3AFQM=
X-Gm-Gg: AYBFou3CXzSJo7K7RaFJeOFn8pWQl+GTArfeBFmNuDXAuW8rca7XzLvXVqYnmuqIisy
 KdMFhiMRVnXyOSowX7/KCXcHifc23PNt5c/sCrIrOlHVgx0Mv6sCIKThmZp30xOAmFNwfQZCsx+
 Tz9d7Z9sUIXyQvApesrEUeB1CzRSJeJyb2IcCz3/XRjln57fqTDqhNQf4FndWvBe8ZiqwAd3rgs
 r7UaWofxzEktZA0RNVqOKBvr9Ltjo8jmYGtNvWFzJi5KM0zJqtC+QCeh9/syESAu1d9S2H24786
 V0EeKq0gwBPOwJsdq7Gd0dflFEtPzMo/kVX3aePgJdDqwYN/KzAx+mN1mJhSLdkud3ldZpOmYiL
 Ow6wIce/XqB5XtaBKKBxdrPaK78lZOrVQ20/f6Bk+XMGuZytb8PlLOiOwOlGoYp3FGng7anRIny
 EeH9xf7K+1wNYjw4SAsTnoSyMgluKkNM4PYDNXc/9GJMv5eMuFuTy0e0a91YWyvSAQ5B444qP67
 QPv8lI=
X-Received: by 2002:a17:903:38d0:b0:2cf:6e5d:23e9 with SMTP id
 d9443c01a7336-2dd5f16b17bmr7744675ad.14.1789267384953; 
 Sat, 12 Sep 2026 19:43:04 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.43.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:43:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 79/86] tcg: Generic expansion of tcg_gen_sub2_*
Date: Sat, 12 Sep 2026 16:38:30 -1000
Message-ID: <20260913023837.741866-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 67 ++++++++++++------------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 689db3b6fe7..e087737ccb2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -158,8 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f42aeb7d8f5..5a472a910c6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -62,6 +62,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 23e4e9cf257..26c92f5b27a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1228,6 +1228,28 @@ static void gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_addi(type, dst, src1, -src2);
 }
 
+static void gen_sub2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_subbi, type, 0)) {
+        gen_op_ttt(INDEX_op_subbo, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_subbi, type, rh, ah, bh);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_sub(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, al, bl);
+        gen_sub(type, rh, ah, bh);
+        gen_sub(type, rh, rh, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    gen_mov(type, rl, t0);
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
     if (src1 == 0) {
@@ -1289,28 +1311,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_sub_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i32(rh, ah, bh);
-        tcg_gen_sub_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
@@ -1818,29 +1818,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_sub_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i64(rh, ah, bh);
-        tcg_gen_sub_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


