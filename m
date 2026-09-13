Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59208C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBU-0005JO-OI; Sat, 12 Sep 2026 22:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBP-0004dA-DN
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:07 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBN-00021O-E3
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:43:07 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso1154300a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267384; x=1789872184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AeGxJxkJ36zNT5JkbbUDkIaG4DGAM4yr/XShj+9wwTE=;
 b=OJWTrCEUV738PirlpD6EAnReNWAQSEEygfHofQoJbrQyKrYz2A4rgAtKoLFnL4NMGF
 +bLax3ZnzL1mz5v2vKzlZ9SbSXyz5j4nfWOBj8OTSFICoUQNVRGP9pOKeaUUim+S/oR3
 zUYMq/Ok1jiqhUyVlLviUWdDGyW8HIt0nuGqt11g1NwNCBHOcPI0Jkd1RgFyWjXwsMJ8
 KJyWJ6GfvqJrMMKBc1/3lfjJ6yZW/0yPtPTQmnTEFtYPiFhjL6wJX2VNi2ti0i5WIPFi
 r+Q3iCaBktf+WLSS5EPiMHYYRSG7ISWAfS6nL3omTW4wtCDkWrlJfd6UhiwqjLNw4qxY
 3Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267384; x=1789872184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AeGxJxkJ36zNT5JkbbUDkIaG4DGAM4yr/XShj+9wwTE=;
 b=nbtkwgMy2zxHBcvZ8/LxApYLEYw3OsLv0Yx1vDLsbp2tlf44ugcsJpT2QpCiJDrnOY
 hCpHEmDjzJHTPM1Kl8IEo62Se761SOPtmALZ66BTcOwwSUgAsLt8fDRxefdJdms9xMLP
 Xv9ycS6iWcpFOgemhBQ+UMz+M9xy2f4HbA9qcEtNviqcpnA4S3mENZ4YMwdMjDyfAk0x
 DVTTNJJFpptwsppDx2iF94J/Q/0wUw6ShTKBea5Its81IAMIc+chpjQKOnLJ0yeglbLi
 Mlzlv3z+N2gx2Cx6WrWNaj1429z4ycW1dDqSZLSEAglhLJzseLOBmN6AXE/Mb1XkRz7R
 Uxpg==
X-Gm-Message-State: AFuF++mLKtB31qvscRAQKGLUtMC24Jm+vCVWjNL2eDFMhG43kv/txCWm
 b/TiDzJUC+1VhTntqVrJaAMlmq5N4H9puUbWIZ9XTNvE0devOHlOIlzrrAW5KG8nLrjM/cM7ZRh
 GoyibZSU=
X-Gm-Gg: AYBFou3mJamsVVqC91HSerTAj29MmNq9gIQjUW2nsxyBEgLnSs7apr64ppwWcxVBn9w
 fws6jHQog+qZV4QpQraQQMhzb/DLIYEcxP3ed3hDIREY90gckttZDbdsXXy/xGYw2cqS9PpirZi
 JEWohVBTAnrG9FvcSNZ+Ey94iGuF1DIKu5SEMzNzaYrdqHwZj6YQe+UMlyI2Z0gx/GrAYDtalcG
 FjQhJVn7XK8XjjuZA0OZozIxjKi1ObNT50gTYRbzVD/05YIupx4z029FirGu07edkQUu2A+CCvs
 RnyGAGNkAn0av0Di5jsANLPzj1AkzWy12GEqRAluayEdR+yz750RuJGNIQtYZtTUaJsB5oqvdt9
 Gz8tAVLQgaiOR+d5N1dkIGvBs8jW+4DJ3j8HuBfDZ+T1/5tOcAwUqO+eF24YvdQXpysAUmkqIna
 6mawc2seOzJ0isFt5dLLcCfhIkIQdjB64BLnNIHhP6+g19eHR64as2XlTBwgL0FjNtGJoD55B4Q
 eVO26w=
X-Received: by 2002:a05:6a20:1604:b0:3bf:5b7a:fc8b with SMTP id
 adf61e73a8af0-3daecac7fc7mr21601366637.0.1789267383991; 
 Sat, 12 Sep 2026 19:43:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.43.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:43:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 78/86] tcg: Generic expansion of tcg_gen_add2_*
Date: Sat, 12 Sep 2026 16:38:29 -1000
Message-ID: <20260913023837.741866-79-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 67 ++++++++++++------------------------
 3 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6835d659cf1..689db3b6fe7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -160,8 +158,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 141c18061e8..f42aeb7d8f5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF6(add2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9fbe6c6b160..23e4e9cf257 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -431,6 +431,28 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_add(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        gen_add(type, rh, ah, bh);
+        gen_add(type, rh, rh, t1);
+
+        tcg_temp_free_internal(t1);
+    }
+    gen_mov(type, rl, t0);
+    tcg_temp_free_internal(t0);
+}
+
 static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                        TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1267,28 +1289,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1776,29 +1776,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


