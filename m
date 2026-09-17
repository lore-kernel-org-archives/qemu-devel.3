Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0A0C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ri-0005v0-0l; Thu, 17 Sep 2026 00:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qq-0003OM-MN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:00 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qo-0007vv-Jx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:00 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99cso404100a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619757; x=1790224557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/087KF7xsjcRBKjQv0Z7hl413GlOcT4aAI/LPKV8L34=;
 b=WhCaKtwZ1B36TLcshKuzZ3VQTRSyyjxpi/k77Efh9fchyz8Q9AOq8wTyW/9zGmJ+ne
 fYYpa+PQNChCxFSoSqF3LOTp2J3zhY8LeA+uSULXOhCtjEbKqH0CmLNzAEmW06E+LUqI
 psa2mnQOQOG1s3FZ9fCoSpdAat0yV4H3keGdgG+2CyqQ31Ahsed7/uCuIX+XxqTkyiYt
 JlgfHmOlVjIVAxIUZiYhQgITwQMlVfqWG9iKYweCPK+VDVC/tss1xIizF5nLj3a/OTuz
 ZpPG2fF8p3CCT7zJhM0slV60DCsoc012SP46TpVRChGUfvp77TyF+ihDSGTb4sEcZ1pM
 zqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619757; x=1790224557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/087KF7xsjcRBKjQv0Z7hl413GlOcT4aAI/LPKV8L34=;
 b=OOZUMlUhAwNyGqDlllR77r6NAFYbrIC9gyKSiTy+CMTbiscddADg2YFTNSdBqDO4jq
 o+KWKJSUhXA50ZRPH6pjSpMqVmVBG9E7NMyf4XmDvplRs64Z04wvSFvr91k62hqZy0pz
 q0pBlxSq21FIO2QI7FAhyHyibxkbkVYh5pdSA/z922SLnUw7x0O2bpU/ScS9nhs5fOUP
 H5gghUcA8jsohj4rNL5y43ZTHwe6rKFWsdkTcZNaclCGZQ1PYnxrzfykxcSiI1EF6RSi
 5IXMbUPOkHGOVpbQBhhVk193KmfB/7xO8Ef5ZaymlRv7s3fBx9GDm4N+FH8Olz0usQ1k
 WDvg==
X-Gm-Message-State: AFuF++l6AV04XQ5oZ3KmWAHcq8juQmgMNCRTNl/Q19Dq7N6a/IExvWxU
 pDXaZDIWAhp1vETLCfSyvbt8K82s9A774hnk8mJQ4NQkOEDLQz0Qan35eZKh+ZdrR/cgp91pUru
 TB/8z
X-Gm-Gg: AYBFou3rI+i30mrcWnMt56TJK10K9mhK0l1uNFwrQjWnCYNIc1Y4w8ZyIyyQw1RI3+a
 hzp7SZuxa2+fUwf5poI1mbQs/3YpNSSX0AsKAMtzon7Fv8bd51fwjS/f9OWjM4fNU8yjsiZmAxu
 KTULYAXaiP0BiSFXH9epAEgDIq7cRafqYwQhzRRy2xXlu1v928huVREvf6r0B/b/+h7d/xbZAbi
 TdcmikUG/0XWR3jfXU7ZFMiciuR0v1A1Ooykhqp/1Ne3XSo7UVWF7eQUVpfDKMoxt6YDMrwquR+
 i9jai4SQSUNjlgtMAXAlYnT3hjbgUDnIzp8pM8U0luizPBdZlHfpVxnVEJJsYQWwJDoAAJkq6nO
 DJsvKuLLfCwlrWaq8XUZ/lERl8bqvzF2Rccl2mARu5HN+L+4J3srSXkc0GdtZ9Jt7elnRm3vVb7
 6bRagnofyROMDLeQwvDbh5hhzNlsqbByMKbflQ3aetkDd2eE7aISOSsUpZzk475cD4oJo1anbdX
 rn4q34J
X-Received: by 2002:a17:90b:3a43:b0:39d:f5b1:e365 with SMTP id
 98e67ed59e1d1-39e1e559b78mr12536611a91.25.1789619757137; 
 Wed, 16 Sep 2026 21:35:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 086/101] tcg: Generic expansion of tcg_gen_muls2_*
Date: Wed, 16 Sep 2026 18:28:08 -1000
Message-ID: <20260917042823.542588-87-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 +++++++++++++----------------------
 3 files changed, 51 insertions(+), 83 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3ad966b72c1..b0ce35df411 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -156,7 +155,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 75ada0d0473..5e169258ea3 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(muls2, TCGV, TCGV, TCGV, TCGV)
 DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5219140f5fb..d58d1c81c4b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -183,13 +183,6 @@ static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
-static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
-                                TCGv_i32 a2, TCGv_i32 a3)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1),
-                tcgv_i32_arg(a2), tcgv_i32_arg(a3));
-}
-
 static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                 TCGv_i64 a2, TCGv_i64 a3)
 {
@@ -223,20 +216,6 @@ static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                 tcgv_ptr_arg(base), offset);
 }
 
-static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
-}
-
-static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -889,6 +868,56 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                      TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_muls2, type, 0)) {
+        gen_op_tttt(INDEX_op_muls2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        gen_mul(type, t, src1, src2);
+        gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
+        gen_mov(type, rl, t);
+    } else if (type == TCG_TYPE_I32) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        /* Simply extend and use host 64-bit multiply. */
+        gen_ext_i32_i64(t0, src1);
+        gen_ext_i32_i64(t1, src2);
+        gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        gen_extrl_i64_i32(rl, t0);
+        gen_extrh_i64_i32(rh, t0);
+    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t2 = NULL;
+        g_autoptr(TCGTemp) t3 = NULL;
+
+        gen_mulu2(TCG_TYPE_I64, t0, t1, src1, src2);
+
+        /* Adjust for negative inputs.  */
+        t2 = tcg_temp_new_ebb(type);
+        t3 = tcg_temp_new_ebb(type);
+        gen_sari(TCG_TYPE_I64, t2, src1, 63);
+        gen_sari(TCG_TYPE_I64, t3, src2, 63);
+        gen_and(TCG_TYPE_I64, t2, t2, src2);
+        gen_and(TCG_TYPE_I64, t3, t3, src1);
+        gen_sub(TCG_TYPE_I64, rh, t1, t2);
+        gen_sub(TCG_TYPE_I64, rh, rh, t3);
+        gen_mov(TCG_TYPE_I64, rl, t0);
+    } else {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        gen_mov(TCG_TYPE_I64, rl, t);
+    }
+}
+
 static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                       TCGTemp *src1, TCGTemp *src2)
 {
@@ -1327,28 +1356,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_muls2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_mulsh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_ext_i32_i64(t0, arg1);
-        tcg_gen_ext_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -1812,44 +1819,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_muls2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
-               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t3 = tcg_temp_ebb_new_i64();
-        tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
-        /* Adjust for negative inputs.  */
-        tcg_gen_sari_i64(t2, arg1, 63);
-        tcg_gen_sari_i64(t3, arg2, 63);
-        tcg_gen_and_i64(t2, t2, arg2);
-        tcg_gen_and_i64(t3, t3, arg1);
-        tcg_gen_sub_i64(rh, t1, t2);
-        tcg_gen_sub_i64(rh, rh, t3);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_temp_free_i64(t3);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_mulsh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.53.0


