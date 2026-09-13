Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596EAC88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBI-0003me-O9; Sat, 12 Sep 2026 22:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBF-0003Wx-Lz
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBD-0001yg-P2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:57 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-398e9698a70so2294633a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267374; x=1789872174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dhCzJvWtDJszKUf/B5CG/G12B+nZJX7Lxqt9+EJ+6vk=;
 b=m3aY4xwsLLO8pV0rx3kZxlZSy2F8dlhZ1aDvop37YZUOI4/UvACJzY58dCWfj5zy0T
 sY5zKQj5kaAPDcVIHdTYH7o0dzlS/XodNWD5ejdQKaNDMqgKJa1m1nHgkLHBIm56iRhI
 r95fLQuZyuwLVrvw6bWmA3g4oIen5g0KdmAGCPGE3MkePimC1EJ7BFQezXioAHXktb49
 D/nfuhLpCK2TgOAmVLQ6HqszbM6mBOgPP+FkCEROfQPPBx9SNmEh+hAGDP+NQFPVD8cc
 XvgjT4L7830sDvomGLLfbHkCx/2h2WUhm9RzGTwS0liURevzbc0O1yMLVMaqwkQBiUPs
 tz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267374; x=1789872174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dhCzJvWtDJszKUf/B5CG/G12B+nZJX7Lxqt9+EJ+6vk=;
 b=LoWHoNSnsr1gbmNGnHzqAAeZ17TyNT8ft/iMSnVmXW7AKLe8Z+7MkOTPbEXheJ/O4G
 zqAbbHti6opTIQRvjn/ZRz7i1N50nzdjSD9qUcBZTB2moEuz1W8pHK3BN37KwqEWw9za
 V3+c5asY0v/G61wl3VjPEHg9Z30QDYX3quaadVFVZRQCef0dWEslev4M6DpmjbhX3OXZ
 HecjDU2plk3kartQjd7u8UIKz5nT8KCEiUwYd1Fsy0opEJuZW/K5QDq1aMd/WNsd1B8G
 coUhVapMNmdFmuxDxzlFukvlfEN58X+/cv39t2QCZ19KnPKakj0yiYnXmSdJQBx2cEGK
 q+Vw==
X-Gm-Message-State: AFuF++mmUn7+1l+x65B1dMvwTQMZQ2k0sOn0BaCNEAPkxyQ6ZlvHAIB6
 BS+7HqRSFt37DoVBbQ2YHAs5R9JX6eBXIJ9k9Rrmt92OHxwhfVjMenWLwSC7QkQpTLX4VU6Cbaz
 BiU7o8Zk=
X-Gm-Gg: AYBFou1OOkqlx7qH6g4YIgppI+Y8GWQLxYy3DSEulag+SZKrRXkQtdo4G4W/dQ5TiPB
 QT0G9PCNVUUa8DfwzfqrIiuwEUlgN6UlI8GXh6hyT2x/laCX7+nocBM8l0zLn5cjh1Cclar8dJJ
 /IFUJVniyTBjZBXWvci42tYonqg0Bii6pJASghlepDIJizzebGouRYeyBlCNu3SErZQtGKvMlKc
 8BdfNqE7V73SAzMq5pc8rKCSe0x+b5MWZQA7wrhG9EGqvQPdZBhLUso5mg5qvS6GsKT307ms+kX
 KP1fhtufDdq0RcntUskeg2W2M3yX+EiZOFbfQiPUwUrIsW//ZiQNVA7RsFLmpJ3qOqEosTs1KiN
 Ik7ZsKlFYM/ltEo4W6bhRYzfQLlrxJSr1MWTo3ZABemu1YWPHvNY+2XRmNT6ke2JJSOKcam6P0D
 cvD6caUqP6AYiY2ryDf0vSqNj5QKaSskJG38K3bLANUMDGnkf3j76Hn7AtuTM8zT6UJ/dqr/yCZ
 Vb78Dk=
X-Received: by 2002:a17:90b:440e:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-39d9bc0ff30mr19372759a91.4.1789267374303; 
 Sat, 12 Sep 2026 19:42:54 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 68/86] tcg: Generic expansion of tcg_gen_smin_*
Date: Sat, 12 Sep 2026 16:38:19 -1000
Message-ID: <20260913023837.741866-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index 7fad859a284..5ee14e28439 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -189,7 +188,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c31c819ebdc..2ccdddc8eeb 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 90accdb7714..dbccb7af811 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1133,6 +1133,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smin, type, 0)) {
+        gen_op_ttt(INDEX_op_smin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1449,15 +1458,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
@@ -1989,15 +1989,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_smin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-- 
2.53.0


