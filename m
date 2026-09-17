Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2376C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:37:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pH-0005t5-3X; Thu, 17 Sep 2026 00:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nb-0001gX-VZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:42 -0400
Received: from mail-pz2-x14.google.com ([2607:f8b0:4864:3b::14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73na-0007Ib-0c
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:39 -0400
Received: by mail-pz2-x14.google.com with SMTP id
 41be03b00d2f7-cc4d2fe2056so223213a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619555; x=1790224355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RMvL2Ind42To0Mq8dyofHtdOpD+ZTxhJBlX2QqpoUFA=;
 b=CQnBYQ+yxFuGzA7pVc6FriCZlygyLDX+CL+9bHEckR0EVKKCJP8IOKM+KcfCJ2tBMj
 U+Ba/5yFF6C8ne1gW8+9174nVBzR7I8t7ad3gzGgM5JTM2seZJis5G726LTDZx786B8J
 I2SGZxnV2PZXyeRAvkcQWZq3GM4/UU7tUST5h6ghpgEaLT5Hj7T3/iwkT113nkqw8KR0
 oZLqAMbc+AX/y9LULK4nvdPueDHejgZy5tEKUDkFbhWOdReEQrrUvcQfMTqc2qfRRRD9
 7CMR/lZOsqB37jcYUtmuLm+Vgs+0/35+YdjmzBLq3PkWbUT6ee+yHSCZxrYWHf4FJUQY
 QbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619555; x=1790224355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RMvL2Ind42To0Mq8dyofHtdOpD+ZTxhJBlX2QqpoUFA=;
 b=RiW/JbT2ptXxU1IwlhmkJhZQpsMBCFjg1vhSJRLn9uWeAAybQBiuraiQwhTwHTVsGn
 AsT+UOZM1PMmRoKayOYsoTv4mKvdAVprITqIOQ4vsJHRSA/Ta9DEbNMsDnXbCK4ImhB+
 tUAEw13QB4utTgSBQ8qEr+PuLTuYqlJGRrT7AZNQ/ZitjBcBjL7okE5Cy9x8zVm49Y1C
 q3UiZgFa3WdMpgtc3aQlDJ3xWwax3GbhdXe9d1TtRQLpOEKm/5T3VcpKfB4nmWyGl6GB
 Gt1bKYvPedL7o6jys+r9LSRgzAzWJSQEFjKBiPXBKYh3h1X1V83nwKH6HXeWcTcqjb7+
 raSA==
X-Gm-Message-State: AFuF++lTsF7fpjvVWoiJI8aYUYZMKV2tPGDfCQsp5uAA/NsuSveD0cl4
 3BmK8muxOTHnS8zshU7w/TXJfNLkoKKcumkvB4s04KPhA2G22ZrwuR+pOvx2YWE9JaDjfx7bPdv
 hLtaP
X-Gm-Gg: AYBFou2uRYestjtDkb1LpeuKipg0xKh5AJOCsp6ddw76t+0K+DvZfHESe9O51HXHobm
 b83xMt0DNtULJ3JoSYOvWnRcejcP/n/BMpCklfXmqoYJ09lALbmko1gOh2ltmz9gh2Nk1KD02Mu
 Walguu4U1W5SX0Ngr6g2+L+ePEmS3fcLFVyJvSi453GhWrJZfKr9qfTx1VE4asFgh+3YdL0RUaG
 9x0xaRHEgVxIhZME1i6eFxuB3tHJkUERR5kckBmVg2jtFLMt9WONEgAXPin0afmS05CokKcO5N6
 S7kiNr2iUWu/P+kELhodZU3Oyz0jpZFuDXyFcIoAuHwkTN1lsEtfeZAdKzJZuJ7YI63yYLcBz4P
 TPVht5TRb/lQ8cLkyTlOXnSBdl/oUOGwvwo7GHBXgUEZqb8UivTRh49yuLT0nEQC4YT7ae3n9bO
 pgktry9JNXMijyCLUGUfxtUqBri7aAq8J6WB3lkMtE9ssQKTRZzL9n4OlVrQm6yltQMtIVufYlp
 Oik5v0=
X-Received: by 2002:a17:90b:582b:b0:39d:c3bb:98e7 with SMTP id
 98e67ed59e1d1-39e1e2eb37cmr12344331a91.6.1789619555049; 
 Wed, 16 Sep 2026 21:32:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 065/101] tcg: Generic expansion of tcg_gen_deposit_*
Date: Wed, 16 Sep 2026 18:27:47 -1000
Message-ID: <20260917042823.542588-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::14;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x14.google.com
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
 include/tcg/tcg-op-common.h  |  7 ++--
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 66 ++++++++++++++++++++----------------
 3 files changed, 40 insertions(+), 34 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2b65e996acc..b9118a6df08 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4, T5, T6);
 
@@ -125,12 +127,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -180,8 +181,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len);
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 57d6f07b907..a2244bedeb2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -13,6 +13,7 @@ DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
 DEF3(ctzi, TCGV, TCGV, TINT)
+DEF5(deposit, TCGV, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a4607044da1..7c5f6ae8e6b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -127,6 +127,14 @@ static TCGOp *gen_op_ttti(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
 }
 
+static TCGOp *gen_op_tttii(TCGOpcode opc, TCGType type,
+                           TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                           TCGArg a3, TCGArg a4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1),
+                       temp_arg(t2), a3, a4);
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -326,6 +334,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF5(NAME, T1, T2, T3, T4, T5) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5);
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
@@ -341,6 +351,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 /*
@@ -364,6 +375,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),                  \
                  glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF5(NAME, T1, T2, T3, T4, T5)                                  \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d, T5 e)   \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
+                 glue(C_,T4)(d), glue(C_,T5)(e)); }
+
 #define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
@@ -375,6 +391,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_int64_t
 #define C_TCGCond
 #define C_TCGLabelPtr
+#define C_unsigned
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -404,11 +421,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_int64_t
 #undef C_TCGCond
 #undef C_TCGLabelPtr
+#undef C_unsigned
 
 #undef DEF1
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF5
 #undef DEF6
 
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
@@ -612,6 +631,23 @@ static void gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+static void gen_deposit(TCGType type, TCGTemp *dst, TCGTemp *src1,
+                        TCGTemp *src2, unsigned ofs, unsigned len)
+{
+    unsigned width = tcg_type_size(type) * 8;
+
+    tcg_debug_assert(ofs < width);
+    tcg_debug_assert(len > 0);
+    tcg_debug_assert(len <= width);
+    tcg_debug_assert(ofs + len <= width);
+
+    if (len == width) {
+        gen_mov(type, dst, src2);
+    } else {
+        gen_op_tttii(INDEX_op_deposit, type, dst, src1, src2, ofs, len);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -1013,21 +1049,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 32);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 32);
-    tcg_debug_assert(ofs + len <= 32);
-
-    if (len == 32) {
-        tcg_gen_mov_i32(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i32(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
                            unsigned int ofs, unsigned int len)
 {
@@ -1775,21 +1796,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
-                         unsigned int ofs, unsigned int len)
-{
-    tcg_debug_assert(ofs < 64);
-    tcg_debug_assert(len > 0);
-    tcg_debug_assert(len <= 64);
-    tcg_debug_assert(ofs + len <= 64);
-
-    if (len == 64) {
-        tcg_gen_mov_i64(ret, arg2);
-    } else {
-        tcg_gen_op5ii_i64(INDEX_op_deposit, ret, arg1, arg2, ofs, len);
-    }
-}
-
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
                            unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


