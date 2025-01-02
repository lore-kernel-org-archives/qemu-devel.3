Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FE9E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbD-0006xM-72; Thu, 02 Jan 2025 13:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb8-0006wh-Vq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:07 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPb3-00057C-IU
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:04 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-216728b1836so140666255ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841219; x=1736446019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mfYhRcO8ooYK2mFwpAUUxtFElf3SPjCLt6DLQ9PUcak=;
 b=h1qA6kBXZWQUjCnhinpB/hCPG7dsEp/hjmBCDJyVztjMk8EeBAploOSJoWXUX8dVOi
 20S1pEKekZM2XkDWvbKfCC/5mMjE1EosL54TjjK/qCCqKrbkMhzedK2jK29r3g1i7F2B
 KTNjNP2F0AImWE831rAwwweUYyE8UwDA9SnJcSPt0Ft26eVbg+qqkaaFXlTqpiEs1oX0
 0n4SEcjbdjS5gaT2dYaZQIMgvKQgDCfAN6OVtf2b5v54Fap3LpIHDYN227SNcGTg4ye5
 gwcnJ4o+ZOnU9mEasZE/4L1TGAUnCfX726Je23O2gk/KK6Z/OJMhiM6gdp0MVw0r8BNg
 RtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841219; x=1736446019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfYhRcO8ooYK2mFwpAUUxtFElf3SPjCLt6DLQ9PUcak=;
 b=Gp3+pTDO1HtV9TCDyHyc1unk+ZF4EY8bJu8IXcl8K6sIvvWWehTAAObuiFqVQE32xc
 KbP/RRBOndewa0qey9W/xcE0zWNWl1duDVQRzSqha4I5184hJ0V4FIUoPPLqbr8zbrx4
 ZcO3qB+JgXK0N1yrWprcrAjdhWMc7aa6Mq0/R5J3LHdTSKkSFlwy5F7iQg9zJqeGpSXN
 mtYLejBNJDDFmPHkCvdaGuSqMWQJtbbOhQ60LXuHmu0YmTmKX+JZ6GqrsansiaIGhNJB
 nGv9WGrFPahbkb5rgqGbiJilbxw9Jke+CsvJJNqANxgEOOxIcNza2Z+MvX/IqzCNCXz5
 Lvww==
X-Gm-Message-State: AOJu0Yx48PIihlhCNVgMyz5/+5h3DytQv8QcsN5ZkfpahHCl7jhvSfnx
 IS0LuCCZA0mj6EgRwaVqLlnC7aoIcmDaGYqC99Jp2gJ00C8m+WXb5Gv+keVwDqDnm2NLdFHzXNP
 e
X-Gm-Gg: ASbGncvgH/1DuhNHWVrPi98Vj8ujCtilM8blNC9eqd+AJz+1qg74j/McK2xe9yXBzTk
 bQ+P+po1RlBZHt/P3O9576RkARQNvGvMApDIr578pk1PyUebJs7cRGob4z3RjCostT7xDZlaI9h
 GtwCdk8cGIgTuDQrwIKCKyssKpd47pyFrlCg3Qec96EEUkrleN/V763fyz5Y/rfPONR8mw8OnlY
 F5Hdvb3mXy9W0wM0Qo+mINe6zFyJzPb2V8LywQsGyeH6aGIMLl2MO6kD2rQkw==
X-Google-Smtp-Source: AGHT+IH74mGgbUkcHeXrNpq5SharXpcVqjxgMZeKgxIcVM5coUh7nWwVR12HKb8itfO0ZMgg3jBm4A==
X-Received: by 2002:a05:6a00:414a:b0:728:e745:23d8 with SMTP id
 d2e1a72fcca58-72abdeb53f3mr72284664b3a.24.1735841218964; 
 Thu, 02 Jan 2025 10:06:58 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.06.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:06:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/73] tcg: Add TCGType argument to tcg_gen_op*
Date: Thu,  2 Jan 2025 10:05:44 -0800
Message-ID: <20250102180654.1420056-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This covers the balance of opcode generation.
At this point, TCGOp.type is initialized.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  13 ++---
 tcg/tcg-op-ldst.c  |  26 +++++-----
 tcg/tcg-op.c       | 119 ++++++++++++++++++++++++---------------------
 3 files changed, 85 insertions(+), 73 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 8099248076..072b36d85c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -92,12 +92,13 @@ TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
  */
 TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
 
-TCGOp *tcg_gen_op1(TCGOpcode, TCGArg);
-TCGOp *tcg_gen_op2(TCGOpcode, TCGArg, TCGArg);
-TCGOp *tcg_gen_op3(TCGOpcode, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op1(TCGOpcode, TCGType, TCGArg);
+TCGOp *tcg_gen_op2(TCGOpcode, TCGType, TCGArg, TCGArg);
+TCGOp *tcg_gen_op3(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op4(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op5(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
+TCGOp *tcg_gen_op6(TCGOpcode, TCGType, TCGArg, TCGArg,
+                   TCGArg, TCGArg, TCGArg, TCGArg);
 
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index a318011229..0d8fe3b4f5 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -87,14 +87,15 @@ static MemOp tcg_canonicalize_memop(MemOp op, bool is64, bool st)
     return op;
 }
 
-static void gen_ldst(TCGOpcode opc, TCGTemp *vl, TCGTemp *vh,
+static void gen_ldst(TCGOpcode opc, TCGType type, TCGTemp *vl, TCGTemp *vh,
                      TCGTemp *addr, MemOpIdx oi)
 {
     if (TCG_TARGET_REG_BITS == 64 || tcg_ctx->addr_type == TCG_TYPE_I32) {
         if (vh) {
-            tcg_gen_op4(opc, temp_arg(vl), temp_arg(vh), temp_arg(addr), oi);
+            tcg_gen_op4(opc, type, temp_arg(vl), temp_arg(vh),
+                        temp_arg(addr), oi);
         } else {
-            tcg_gen_op3(opc, temp_arg(vl), temp_arg(addr), oi);
+            tcg_gen_op3(opc, type, temp_arg(vl), temp_arg(addr), oi);
         }
     } else {
         /* See TCGV_LOW/HIGH. */
@@ -102,10 +103,11 @@ static void gen_ldst(TCGOpcode opc, TCGTemp *vl, TCGTemp *vh,
         TCGTemp *ah = addr + !HOST_BIG_ENDIAN;
 
         if (vh) {
-            tcg_gen_op5(opc, temp_arg(vl), temp_arg(vh),
+            tcg_gen_op5(opc, type, temp_arg(vl), temp_arg(vh),
                         temp_arg(al), temp_arg(ah), oi);
         } else {
-            tcg_gen_op4(opc, temp_arg(vl), temp_arg(al), temp_arg(ah), oi);
+            tcg_gen_op4(opc, type, temp_arg(vl),
+                        temp_arg(al), temp_arg(ah), oi);
         }
     }
 }
@@ -115,9 +117,9 @@ static void gen_ldst_i64(TCGOpcode opc, TCGv_i64 v, TCGTemp *addr, MemOpIdx oi)
     if (TCG_TARGET_REG_BITS == 32) {
         TCGTemp *vl = tcgv_i32_temp(TCGV_LOW(v));
         TCGTemp *vh = tcgv_i32_temp(TCGV_HIGH(v));
-        gen_ldst(opc, vl, vh, addr, oi);
+        gen_ldst(opc, TCG_TYPE_I64, vl, vh, addr, oi);
     } else {
-        gen_ldst(opc, tcgv_i64_temp(v), NULL, addr, oi);
+        gen_ldst(opc, TCG_TYPE_I64, tcgv_i64_temp(v), NULL, addr, oi);
     }
 }
 
@@ -250,7 +252,7 @@ static void tcg_gen_qemu_ld_i32_int(TCGv_i32 val, TCGTemp *addr,
     } else {
         opc = INDEX_op_qemu_ld_a64_i32;
     }
-    gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, copy_addr, addr, orig_oi,
                                  QEMU_PLUGIN_MEM_R);
 
@@ -319,7 +321,7 @@ static void tcg_gen_qemu_st_i32_int(TCGv_i32 val, TCGTemp *addr,
             opc = INDEX_op_qemu_st_a64_i32;
         }
     }
-    gen_ldst(opc, tcgv_i32_temp(val), NULL, addr, oi);
+    gen_ldst(opc, TCG_TYPE_I32, tcgv_i32_temp(val), NULL, addr, oi);
     plugin_gen_mem_callbacks_i32(val, NULL, addr, orig_oi, QEMU_PLUGIN_MEM_W);
 
     if (swap) {
@@ -590,7 +592,8 @@ static void tcg_gen_qemu_ld_i128_int(TCGv_i128 val, TCGTemp *addr,
         } else {
             opc = INDEX_op_qemu_ld_a64_i128;
         }
-        gen_ldst(opc, tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+        gen_ldst(opc, TCG_TYPE_I128, tcgv_i64_temp(lo),
+                 tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_gen_bswap64_i64(lo, lo);
@@ -710,7 +713,8 @@ static void tcg_gen_qemu_st_i128_int(TCGv_i128 val, TCGTemp *addr,
         } else {
             opc = INDEX_op_qemu_st_a64_i128;
         }
-        gen_ldst(opc, tcgv_i64_temp(lo), tcgv_i64_temp(hi), addr, oi);
+        gen_ldst(opc, TCG_TYPE_I128, tcgv_i64_temp(lo),
+                 tcgv_i64_temp(hi), addr, oi);
 
         if (need_bswap) {
             tcg_temp_free_i64(lo);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 44ab916a4d..83f96153b1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -37,34 +37,35 @@
  */
 #define NI  __attribute__((noinline))
 
-TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGArg a1)
+TCGOp * NI tcg_gen_op1(TCGOpcode opc, TCGType type, TCGArg a1)
 {
-    TCGOp *op = tcg_emit_op(opc, 0, 1);
+    TCGOp *op = tcg_emit_op(opc, type, 1);
     op->args[0] = a1;
     return op;
 }
 
-TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGArg a1, TCGArg a2)
+TCGOp * NI tcg_gen_op2(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2)
 {
-    TCGOp *op = tcg_emit_op(opc, 0, 2);
+    TCGOp *op = tcg_emit_op(opc, type, 2);
     op->args[0] = a1;
     op->args[1] = a2;
     return op;
 }
 
-TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3)
+TCGOp * NI tcg_gen_op3(TCGOpcode opc, TCGType type, TCGArg a1,
+                       TCGArg a2, TCGArg a3)
 {
-    TCGOp *op = tcg_emit_op(opc, 0, 3);
+    TCGOp *op = tcg_emit_op(opc, type, 3);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
     return op;
 }
 
-TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
+TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
                        TCGArg a3, TCGArg a4)
 {
-    TCGOp *op = tcg_emit_op(opc, 0, 4);
+    TCGOp *op = tcg_emit_op(opc, type, 4);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -72,10 +73,10 @@ TCGOp * NI tcg_gen_op4(TCGOpcode opc, TCGArg a1, TCGArg a2,
     return op;
 }
 
-TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
+TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
                        TCGArg a3, TCGArg a4, TCGArg a5)
 {
-    TCGOp *op = tcg_emit_op(opc, 0, 5);
+    TCGOp *op = tcg_emit_op(opc, type, 5);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -84,10 +85,10 @@ TCGOp * NI tcg_gen_op5(TCGOpcode opc, TCGArg a1, TCGArg a2,
     return op;
 }
 
-TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
-                       TCGArg a4, TCGArg a5, TCGArg a6)
+TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGType type, TCGArg a1, TCGArg a2,
+                       TCGArg a3, TCGArg a4, TCGArg a5, TCGArg a6)
 {
-    TCGOp *op = tcg_emit_op(opc, 0, 6);
+    TCGOp *op = tcg_emit_op(opc, type, 6);
     op->args[0] = a1;
     op->args[1] = a2;
     op->args[2] = a3;
@@ -107,132 +108,138 @@ TCGOp * NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
 # define DNI
 #endif
 
-static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
+static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGType type, TCGv_i32 a1)
 {
-    tcg_gen_op1(opc, tcgv_i32_arg(a1));
+    tcg_gen_op1(opc, type, tcgv_i32_arg(a1));
 }
 
-static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
+static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGType type, TCGv_i64 a1)
 {
-    tcg_gen_op1(opc, tcgv_i64_arg(a1));
+    tcg_gen_op1(opc, type, tcgv_i64_arg(a1));
 }
 
-static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGType type, TCGArg a1)
 {
-    return tcg_gen_op1(opc, a1);
+    return tcg_gen_op1(opc, type, a1);
 }
 
 static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
-    tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
+    tcg_gen_op2(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
 }
 
 static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
-    tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
+    tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
 static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
                                 TCGv_i32 a2, TCGv_i32 a3)
 {
-    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
+    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1),
+                tcgv_i32_arg(a2), tcgv_i32_arg(a3));
 }
 
 static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                 TCGv_i64 a2, TCGv_i64 a3)
 {
-    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
+    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1),
+                tcgv_i64_arg(a2), tcgv_i64_arg(a3));
 }
 
 static void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
                                  TCGv_i32 a2, TCGArg a3)
 {
-    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
+    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
 }
 
 static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
                                  TCGv_i64 a2, TCGArg a3)
 {
-    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
+    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
 static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
                                     TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
+    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
+                tcgv_ptr_arg(base), offset);
 }
 
 static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                     TCGv_ptr base, TCGArg offset)
 {
-    tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
+    tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(val),
+                tcgv_ptr_arg(base), offset);
 }
 
 static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                 TCGv_i32 a3, TCGv_i32 a4)
 {
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4));
 }
 
 static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                 TCGv_i64 a3, TCGv_i64 a4)
 {
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
 static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                  TCGv_i32 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4);
 }
 
 static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                  TCGv_i64 a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4);
 }
 
 static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    return tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, TCG_TYPE_I32,
+                       tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
 static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                      TCGArg a3, TCGArg a4)
 {
-    return tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, TCG_TYPE_I64,
+                       tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
 static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                 TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
 }
 
 static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                 TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
 }
 
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4, a5);
 }
 
 static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                   TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4, a5);
 }
 
@@ -240,7 +247,7 @@ static void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                 TCGv_i32 a3, TCGv_i32 a4,
                                 TCGv_i32 a5, TCGv_i32 a6)
 {
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
                 tcgv_i32_arg(a6));
 }
@@ -249,7 +256,7 @@ static void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                 TCGv_i64 a3, TCGv_i64 a4,
                                 TCGv_i64 a5, TCGv_i64 a6)
 {
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
                 tcgv_i64_arg(a6));
 }
@@ -258,7 +265,7 @@ static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                  TCGv_i32 a3, TCGv_i32 a4,
                                  TCGv_i32 a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
 }
 
@@ -266,7 +273,7 @@ static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                                  TCGv_i64 a3, TCGv_i64 a4,
                                  TCGv_i64 a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+    tcg_gen_op6(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
@@ -274,7 +281,7 @@ static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                      TCGv_i32 a3, TCGv_i32 a4,
                                      TCGArg a5, TCGArg a6)
 {
-    return tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+    return tcg_gen_op6(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                        tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
@@ -283,7 +290,7 @@ static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
 void gen_set_label(TCGLabel *l)
 {
     l->present = 1;
-    tcg_gen_op1(INDEX_op_set_label, label_arg(l));
+    tcg_gen_op1(INDEX_op_set_label, 0, label_arg(l));
 }
 
 static void add_as_label_use(TCGLabel *l, TCGOp *op)
@@ -296,7 +303,7 @@ static void add_as_label_use(TCGLabel *l, TCGOp *op)
 
 void tcg_gen_br(TCGLabel *l)
 {
-    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, label_arg(l)));
+    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, 0, label_arg(l)));
 }
 
 void tcg_gen_mb(TCGBar mb_type)
@@ -314,25 +321,25 @@ void tcg_gen_mb(TCGBar mb_type)
 #endif
 
     if (parallel) {
-        tcg_gen_op1(INDEX_op_mb, mb_type);
+        tcg_gen_op1(INDEX_op_mb, 0, mb_type);
     }
 }
 
 void tcg_gen_plugin_cb(unsigned from)
 {
-    tcg_gen_op1(INDEX_op_plugin_cb, from);
+    tcg_gen_op1(INDEX_op_plugin_cb, 0, from);
 }
 
 void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 {
-    tcg_gen_op2(INDEX_op_plugin_mem_cb, tcgv_i64_arg(addr), meminfo);
+    tcg_gen_op2(INDEX_op_plugin_mem_cb, 0, tcgv_i64_arg(addr), meminfo);
 }
 
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
 {
-    tcg_gen_op1_i32(INDEX_op_discard, arg);
+    tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
 void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
@@ -1467,7 +1474,7 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
 void tcg_gen_discard_i64(TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op1_i64(INDEX_op_discard, arg);
+        tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
     } else {
         tcg_gen_discard_i32(TCGV_LOW(arg));
         tcg_gen_discard_i32(TCGV_HIGH(arg));
@@ -3156,7 +3163,7 @@ void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_LOW(arg));
     } else if (TCG_TARGET_HAS_extr_i64_i32) {
-        tcg_gen_op2(INDEX_op_extrl_i64_i32,
+        tcg_gen_op2(INDEX_op_extrl_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
         tcg_gen_mov_i32(ret, (TCGv_i32)arg);
@@ -3168,7 +3175,7 @@ void tcg_gen_extrh_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_mov_i32(ret, TCGV_HIGH(arg));
     } else if (TCG_TARGET_HAS_extr_i64_i32) {
-        tcg_gen_op2(INDEX_op_extrh_i64_i32,
+        tcg_gen_op2(INDEX_op_extrh_i64_i32, TCG_TYPE_I32,
                     tcgv_i32_arg(ret), tcgv_i64_arg(arg));
     } else {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
@@ -3184,7 +3191,7 @@ void tcg_gen_extu_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
     } else {
-        tcg_gen_op2(INDEX_op_extu_i32_i64,
+        tcg_gen_op2(INDEX_op_extu_i32_i64, TCG_TYPE_I64,
                     tcgv_i64_arg(ret), tcgv_i32_arg(arg));
     }
 }
@@ -3195,7 +3202,7 @@ void tcg_gen_ext_i32_i64(TCGv_i64 ret, TCGv_i32 arg)
         tcg_gen_mov_i32(TCGV_LOW(ret), arg);
         tcg_gen_sari_i32(TCGV_HIGH(ret), TCGV_LOW(ret), 31);
     } else {
-        tcg_gen_op2(INDEX_op_ext_i32_i64,
+        tcg_gen_op2(INDEX_op_ext_i32_i64, TCG_TYPE_I64,
                     tcgv_i64_arg(ret), tcgv_i32_arg(arg));
     }
 }
@@ -3320,7 +3327,7 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
         tcg_debug_assert(idx == TB_EXIT_REQUESTED);
     }
 
-    tcg_gen_op1i(INDEX_op_exit_tb, val);
+    tcg_gen_op1i(INDEX_op_exit_tb, 0, val);
 }
 
 void tcg_gen_goto_tb(unsigned idx)
@@ -3335,7 +3342,7 @@ void tcg_gen_goto_tb(unsigned idx)
     tcg_ctx->goto_tb_issue_mask |= 1 << idx;
 #endif
     plugin_gen_disable_mem_helpers();
-    tcg_gen_op1i(INDEX_op_goto_tb, idx);
+    tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
 }
 
 void tcg_gen_lookup_and_goto_ptr(void)
@@ -3350,6 +3357,6 @@ void tcg_gen_lookup_and_goto_ptr(void)
     plugin_gen_disable_mem_helpers();
     ptr = tcg_temp_ebb_new_ptr();
     gen_helper_lookup_tb_ptr(ptr, tcg_env);
-    tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
+    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
-- 
2.43.0


