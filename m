Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1093C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklG-00038V-Cg; Sun, 27 Sep 2026 05:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkc-0002VQ-1b
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:55 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkV-0007T4-7F
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:45 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so1201510a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499641; x=1791104441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hvn27ue+vsGN68JJoevWdWrdd95AhTo2/sIokc1MUok=;
 b=xJyFw0x6KeoQEaMbc/GOk8wEtImDSWSRBvX+R3uFB+ZKFIUagKAZoTZq8KPLrVFn0J
 FGU4cY7OHddoL3grZep4Em4K4RdwdbvM+64TQc91wSqee4cfbuvcqyU8zQEB4JzYtAQO
 bfQZswNs6rXpnz/gFGhNd3EOflaakShJ+TJKnnThCEvXw+7E4dmSm3fEuRJQmEzs0k2e
 KOlQ0eMlwtG5peVx25nwkNZw1h4U73mI9+mDA+uGLrFltS2S1diFEK8twQ2KItwfYTiQ
 sttOHdUS1rHrRCkvE5vDAoFaQG6g1dOq7SE2ftLUTwk8XVgu5lNm4HiWp3HelaUT9ZOP
 HOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499641; x=1791104441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hvn27ue+vsGN68JJoevWdWrdd95AhTo2/sIokc1MUok=;
 b=V/lzcjpw9STxOEy8zDt60yrSFoF7gUxRtlVRUOTgxjkj1J2x2V5FTg/pgXuuJN9akL
 0abTYvGZcI65Rv0RgA+Lt5JusRXva41XvDgcPVRn9ZenvqNBA/G/4nHU7u4AQZ7gA0Xx
 PxUM2lg+gVFz9IutlVl5wdLqCslAZ/2azltnwCUFkuLErX57sqwRxs+/qiVEQq7EJ/0K
 FINM2NrqwgAdsjxwCYk0MiAXO7yCMakiFmKkTQpigsSMXpWbVmiiZuW26n3NvzhbJ8Ir
 4xMbE/344gvxM+a0vJBl4o/jtM13ZILevJUOH7t8m7+IS/nlLBC7BXWA2YRMl47Mp0ls
 5mzg==
X-Gm-Message-State: AFq9FYITpZ8Y+sMN93seeEHTgN21jThvYmcONG9a6gJdmNQPZy7csOOY
 ZqFh6JJu4ufA7u3cW4/tYOmGWaYNkNcja5HTxwRQkkArL5eTd/ALFse45+6+WuouLDmCtOJjuC5
 mIzhW
X-Gm-Gg: AYBFou1QxAH7sMCy/flnWZQzZcJs4804QTk6q3FsZLiSjPcm0qFGvrarEQcSadqvVe1
 m93J0LpUh5J3LsZ9oGlAJDwiK+DAJOZge3/fuEHb6ogYY2VT4XasbYcpMc/x9pk04R9hJ1/WREV
 xSAes4Y5c05/CXfjP8PaYFpfo4rAlSrebb/XDjbkOZxULEx6NsilYiMX24nkpAftEVY606n7sfi
 VJT/cIJ20TGz4iQhR6+BwECg1c5S/9/gkPADHz9+3mHeAekMSIsBpxz8dKzdiecTKt0GuW92+yL
 OH5A9X0TZmp/a6zcoiejZ7Sx/t7bsM9Pys65XXGibbla/yiOoI6MI3FO24rZfq+25dnbA4OOYT0
 5kxslRIeQgSfbH0PPRkO2CNlYQdnJVdC8zLlSLeNh9Gk88riKYiRWKin2gd2zpUWLWeNzmNTdl8
 WLpEYj4RXhHMBQ8xQe1hlwP0TlUkYrxVkXLF5KseFSACDleiBUPuOMJQer/AnLS9juvykNoDvIp
 lQz3DI7BLNfEqQoSUScuc4aO3y59A==
X-Received: by 2002:a17:90b:4cc2:b0:3a0:e22b:1b2a with SMTP id
 98e67ed59e1d1-3a0e22b1d7fmr2198114a91.32.1790499640672; 
 Sun, 27 Sep 2026 02:00:40 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 028/101] tcg: Generic expansion of tcg_gen_andi_*
Date: Sun, 27 Sep 2026 01:58:58 -0700
Message-ID: <20260927090011.10724-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 -
 tcg/tcg-internal.h           |  6 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 84 +++++++++++-------------------------
 4 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6b66f050cab..1af9f58df1e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -211,7 +210,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 0da1a9c440c..76c8f026a64 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -114,6 +114,12 @@ static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
     tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
 }
 
+static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                     TCGTemp *t1, TCGArg a2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2108082ce63..f7e7f4d2a1c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
+DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7832e99dccd..2baddbcfd38 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -382,6 +382,30 @@ void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
 }
 
+void tcg_gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_movi(type, dst, 0);
+    } else if (src2 == -1) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (is_power_of_2(src2 + 1)) {
+            unsigned len = cto64(src2);
+            if (TCG_TARGET_extract_valid(type, 0, len)) {
+                tcg_gen_op_ttii(INDEX_op_extract, type, dst, src1, 0, len);
+                return;
+            }
+        }
+        tcg_gen_and(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -485,36 +509,6 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i32(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i32(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz32(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-                tcg_gen_extract_i32(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,36 +1487,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i64(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i64(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz64(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-                tcg_gen_extract_i64(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


