Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A88DC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAks3-0005an-Bv; Sun, 27 Sep 2026 05:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrJ-00026y-CT
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:49 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrH-0008Fg-KC
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:45 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so1378939a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500062; x=1791104862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+P7QrvtukKLtZx0xbEEzDI2xgJw/ZlA5B95MfZKMeYo=;
 b=sfacH+QRft8lQfnYJTNRfTdVC2SFTjlVLlbm9+3N2PnByWVW4ofzLGLJ3cVUXtN+Cn
 eiBNW5H9n04LUPz+K/OdoJ3Uq9rRVotghAHaya/D7LgqS0O72yclmIUnLG+LSl4TbgUo
 xeipoaWkHZC1Kfw0Xz4QFEHTQM8DUgd1sr14Zc8jnxxMc39nUHccje1gAu+sbJ1cEui8
 PP2FFKWONd7nS6FtPUVDR+OtGdB5u1q1Sn4lg1596jxeGAyL84SmZLVJDfSPrc2N3GmA
 cDWh8/fNG0BvbN4jYlTgPJmfREM5XRthDzRQ9ekbyJD0G0YRoZSsUjGlo4YAGk3x6uAS
 QbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500062; x=1791104862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+P7QrvtukKLtZx0xbEEzDI2xgJw/ZlA5B95MfZKMeYo=;
 b=W9vEOp7OERT9knyI6Tf9rMmiQZmqIf33slDVMLX5tUkALK7HDGAYm3HraOXL0p9aqo
 2UlGmvtN6SkWb2id7Y92qFEKYnh18z4GPk75DgprO3vg4L1/tMbdwj9p1ZesDywjh7YA
 PTMku+oJ530oXp7uRICzw9GukvfCjV1Y43ep7Vlx41vBSDP1tXSgMe70zOxDTbJvILQ0
 HV3gCi1vXwJHxveMl8/kkMIL8z8keiuYAO85+9mo/KSEfWLKQfM/gw+8v0DY7cDVwPHl
 dRAiPHZyN/kDLRpyXaRJS4udtiXgahzRpc3cCld38XY+vRsqYotTGIIjvCYyqiEH4074
 8TyQ==
X-Gm-Message-State: AFq9FYL2pgYjHaKHb7t4JtonA0rgvTRXqI9Ilv1xxg785ViSTpZgMlPf
 u/IgdrtoA2g+capfArWytkQTPR/N+sTMW62K1Lc1rdUa0UWwuw3EDLckkfbX1tdIOTwJWqJLdU4
 CfV9r
X-Gm-Gg: AYBFou3GRAj4Azwq+RLFbePf+EEUTr8uFqEo+st8p4j+S/waCAWS9srM1JnHk1ymbuL
 Wmu9eJ7o0pMZP1qqSqWZ0zqYqY90oDoCcDbzugJKp8BuGQxpsGCDTVBWP0JAasYt332PFhEXt+o
 HP0/yZHcG7t6XQMA/eINJLLu8rXJQWCcg+tLgixYuiqmHSidqSYU4mVF9XoXGuc05RypHqiiJW+
 1PIGPKHQ63yyJHRv6B8M6zQRVK1/l6qz6XI2p9tNhHVxKyNMadOrw0PN151qiL0kS9DgDC7yRhq
 JGfIiPzrEye/eSWyNli0k4cB592UyJBjfdON4rHdqmBmifHObfKsk6xwqLbVJMifeAYjRWktqX4
 r3xFu5NKry8eiFUvKaWd0mzsgyjtnLOyB+adAVBuyKJCBoEzyTf9z6Yyn1M6S8OjXbdbmUAXUsT
 CAV4wRvbxdM/QFSAA5tPE8D2UtJ6UcYuAS+zUo1sIBtH11CLxUrf8W1JLfzgPoqC+vFLJ7Ysvo2
 LnEH72B952YtUn/syBg59NeRAMDNA==
X-Received: by 2002:a17:90a:ec8e:b0:3a0:345a:3620 with SMTP id
 98e67ed59e1d1-3a098df852amr7940099a91.45.1790500062161; 
 Sun, 27 Sep 2026 02:07:42 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 082/101] tcg: Generic expansion of tcg_gen_mulu2_*
Date: Sun, 27 Sep 2026 01:59:52 -0700
Message-ID: <20260927090011.10724-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 tcg/tcg-internal.h           |  7 ++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 72 ++++++++++++++++--------------------
 4 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 267ef111ae3..41a4d52d497 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -157,7 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 13c4be5a5c7..09899cb3091 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -126,6 +126,13 @@ static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
     tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
 }
 
+static inline void tcg_gen_op_tttt(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                   TCGTemp *t1, TCGTemp *t2, TCGTemp *t3)
+{
+    tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1),
+                temp_arg(t2), temp_arg(t3));
+}
+
 static inline void tcg_gen_op_tttii(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGArg a3, TCGArg a4)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 14bdabb2f15..b24122173a2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF4(negsetcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7b8e158c2e4..f107e3a85ea 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -778,6 +778,37 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                   TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_mulu2, type, 0)) {
+        tcg_gen_op_tttt(INDEX_op_mulu2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_muluh, type, 0)) {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(type, t, src1, src2);
+        tcg_gen_op_ttt(INDEX_op_muluh, type, rh, src1, src2);
+        tcg_gen_mov(type, rl, t);
+    } else if (type == TCG_TYPE_I32) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        /* Simply extend and use host 64-bit multiply. */
+        tcg_gen_extu(t0, src1);
+        tcg_gen_extu(t1, src2);
+        tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        tcg_gen_extrl(rl, t0);
+        tcg_gen_extrh(rh, t0);
+    } else {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_muluh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        tcg_gen_mov(TCG_TYPE_I64, rl, t);
+    }
+}
+
 void tcg_gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_nand, type, 0)) {
@@ -1186,28 +1217,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t0, arg1);
-        tcg_gen_extu_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
@@ -1693,25 +1702,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_muluh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_muluh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


