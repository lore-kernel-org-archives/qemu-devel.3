Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC358C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoF-0005M5-T4; Sun, 27 Sep 2026 05:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknt-0004cK-K6
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:13 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknn-0007cW-7K
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:13 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccd5cf02so1090244a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499846; x=1791104646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hb+rXhqtzT9CZBMm5Uy/Qe+O6p5AG9JFGI6NBB6fLNg=;
 b=M1zvIOaIkilgsBUCZEAN+spuI/xMReRf8/lMcygrA3Z1nZmxra8s4+qyeqpp1rNxZu
 1glNgvWo5JFb1PwXQKk1bq44tD8QS9Cg2H3VmwNwaNWnD7LH4j5WDHnlXvq1y1lvQ4gs
 i/aa3QRbN6T9Um5Lxx2Haf9CMOqeW8jLvQuDRxUmunsVvacQUj59VKcERxxTk5fgsj74
 9I2Drp3IRlliibqfBcFX1EchyiS+limbUQBK+372GuUqfw1EwY90W/u4A8iSDaiFoUwQ
 4D/3554FvFeQ5ir2zKkn614lQP0AGIGBj9eX2ZfriqC0+XRfCJZVWjJuckVzyAJuYWU+
 C8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499846; x=1791104646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hb+rXhqtzT9CZBMm5Uy/Qe+O6p5AG9JFGI6NBB6fLNg=;
 b=VN5NiHnDCQrRQYG+fXoROABMdwMZdksf3lRdhhRL5UPf5wCvsXV8Hfoviv/h16QWQY
 bXbiAjHh82Cki/NvnjT8gPav3aYLMj0z5iAkT74roVqAi10EVzB/Afd1EOt7M56DcDfa
 AuIIgh3Kpy44x4q2KOWSC+JEOtSZPaHXRlnD00EBhant6Jy7SwgCRMTvLDFgDD+6MjQr
 i6bAh40wVXjNDM0vbf6OjSeLjvvcNU6m2DHrvWCgOFNuqzns1kT1NHali14CKEMLtzHx
 qeL3T8v6HvF+Ob2xBlWwpf050m0h7kPlUb1as2g1vT3IIA7ytN0IME0Ia7WR32zu45vO
 MBOA==
X-Gm-Message-State: AFq9FYKcaI+GqunabXCuYsr1iGnXQX5PYMfotsrriD9iGbsreJ8zg/69
 D0LZUBDHz+KprOLEoL1p8So2LUQX8kV5jEPqE+C02V8A+SUKh5IOiEAXwDrLwgaoiMXVeC6GZzO
 J9bcL
X-Gm-Gg: AYBFou0lfT6+BTLmVMQIcvzXjYdVpSSUQeUd9+BeAz22aLL+tLktxp9qDUjlVSpIxAf
 EhfPEZl6LKrdASSEYHS+APhoqT82NNC3xxnN9Bz7hctmKPd5Kg3e2a+uu8UIoe1j74tyPVGIEYv
 Ep7XKcoPj+DVlOOMEp6dpVgRCTJ4ruvRi2qZSl3oeYI3JbalWxRwvfupgS2o+Z+9eVJWGvmIqo9
 hNQvgQPG4vdAzqbPc2WKGkrOPOLaMFxPfxaBaj2Es/rdZvvL1MYQYsj47N2gf7hyK3hrDTtdcVe
 PFS8HPlmFR950gwPPIWU4myd0+vistDq69Nzbf3AkK2eKlwZCuwQE6KWUrr4xfMpksNenhPVhWe
 aNAXT6sVJwy9sC4eXEq1Cd+bGJdhavF4bQgAueu47wXk5x5kqIEo5Z2HRw9j/El5YHYZrbLpKII
 Y9QifItdHKzJ4HUPtYax441aEE18R8FnVvU38e2S9Xh8QepfZnWFInmCYG2FFUKUu3jtf9MscY+
 M1kWU9hnnMQb1lv623QeOu+LnprsNXnAMvc+3ja
X-Received: by 2002:a17:90b:2ec4:b0:3a2:b59f:639b with SMTP id
 98e67ed59e1d1-3a2b59f6deamr369711a91.54.1790499845409; 
 Sun, 27 Sep 2026 02:04:05 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 049/101] tcg: Generic expansion of tcg_gen_movcond_*
Date: Sun, 27 Sep 2026 01:59:19 -0700
Message-ID: <20260927090011.10724-50-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  7 ++---
 tcg/tcg-internal.h           | 11 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 58 +++++++++++-------------------------
 4 files changed, 33 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7dd50bfae77..c6b8af46de4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -100,6 +100,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4);
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4, T5, T6);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -123,6 +125,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 /* 32 bit ops */
 
@@ -146,8 +149,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -209,8 +210,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 0de8516447f..cd5028104a8 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -134,6 +134,14 @@ static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                 temp_arg(t3), temp_arg(t4));
 }
 
+static inline void tcg_gen_op_ttttti(TCGOpcode opc, TCGType type,
+                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                                     TCGTemp *t3, TCGTemp *t4, TCGArg a5)
+{
+    tcg_gen_op6(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                temp_arg(t3), temp_arg(t4), a5);
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
@@ -158,6 +166,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
 #define DEF4(NAME, T1, T2, T3, T4) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4);
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4, T5, T6);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -171,5 +181,6 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 846b781c836..a1c1e9b9186 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
+DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a12ed17f3da..35cffc6447a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -225,22 +225,6 @@ static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGv_i32 a4,
-                                 TCGv_i32 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
-}
-
-static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGv_i64 a4,
-                                 TCGv_i64 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -312,6 +296,11 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
                      glue(C_,T3)(c), glue(C_,T4)(d)); }
 
+#define DEF6(NAME, T1, T2, T3, T4, T5, T6)                              \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f) \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c),  \
+                     glue(C_,T4)(d), glue(C_,T5)(e), glue(C_,T6)(f)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
@@ -352,6 +341,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF2
 #undef DEF3
 #undef DEF4
+#undef DEF6
 
 /*
  * Generic expansions for templated operations.
@@ -488,6 +478,18 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
     tcg_gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
 }
 
+void tcg_gen_movcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                     TCGTemp *c1, TCGTemp *c2, TCGTemp *v1, TCGTemp *v2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_mov(type, dst, v1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_mov(type, dst, v2);
+    } else {
+        tcg_gen_op_ttttti(INDEX_op_movcond, type, dst, c1, c2, v1, v2, cond);
+    }
+}
+
 void tcg_gen_mul(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_mul, type, dst, src1, src2);
@@ -1037,18 +1039,6 @@ void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
     }
 }
 
-void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
-                         TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i32(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i32(ret, v2);
-    } else {
-        tcg_gen_op6i_i32(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1962,18 +1952,6 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
     }
 }
 
-void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
-                         TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_mov_i64(ret, v1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_mov_i64(ret, v2);
-    } else {
-        tcg_gen_op6i_i64(INDEX_op_movcond, ret, c1, c2, v1, v2, cond);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


