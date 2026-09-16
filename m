Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1A7C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNW-0006sF-E9; Wed, 16 Sep 2026 09:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN6-0006j3-3V
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pN3-0001OP-RX
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:19 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cc502a179c1so1175332a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564094; x=1790168894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5YwEqAnTwXouhUTGoTLTBaQPgwUnM4fIITNQrPPDRcI=;
 b=NfHjY+bzkUsjCFjWsxuKLLnJL8eC2mgQ1sI+t6wGn2THkftQE1DUyVRoR/FlrGJhaq
 FrCBF+9aXpfucgH4LAC81M2ymQfgWAbecGknDFZq+4rbRFRHlTKLNRQ/nXFDwFBn9QeX
 FxlM2NecxYrQzu2vtS6L/1qggszgwlW4FUrYh2MEvdIyB8QHqQW5SQaEypmVialZqAyq
 +HZ3Hx9qxfJo55Ux20muxl1nrnBBkO1GhPav9bdSRNfMHBzB5kwzhRt0/A7sUKbGstLK
 bL3mteAYbea4i90zZKgplImLfMbIF9+fHaPm/mIw9jKKJpLhnghNSdNqtAWSe/vhEAOe
 aleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564094; x=1790168894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5YwEqAnTwXouhUTGoTLTBaQPgwUnM4fIITNQrPPDRcI=;
 b=YvYpyIMrUWz17TNp80p3jo9jXP2x8lm2kNAdI1qGukC5iM/N+Oevp+TL85qdnyFfKP
 yab+JwmqByAgJ0crRV7FCSDP74Py+Bx+Rau4OPjcR8CmhncDNXTiMk87ul50IjcwDgmU
 9+Rbh19/IxzjvWJRnmYcv+w0GMBXEib53LQETFA1qpdLkOwLESDO28WsMCPmTsfwEFYJ
 H6yhPFiJ0S8oNt2JOZpYSevPP0bGq8c97lI2U8Si+HVkVUTIWlW8/jXGxst86OF+dmc0
 HzR4WP2WZkoCKS2T5U8MLVjdi18mX45b5pnLej0hqZbzRMfLzvbA3X1IYgafxEzY7hUZ
 PfeQ==
X-Gm-Message-State: AFuF++kJWOGHecScJA3Esmj6mUa/bV+S6N9TOxiZ3pFkp/nvVRrXgOA0
 jXAS3w4Ex8DJTL11hJBHG/Y5ulTm7VJMIMhlVSxmvritoPiGU1MajdFvNID7DuDREKGCuLBnh/W
 WW8Wn
X-Gm-Gg: AYBFou29esylChm76YfSTkDW5AbdnKkZhB9VXVYb4gGPfOoZH6QYn+ewnOK3cv5uoKK
 /XTrfFbD620f0iPJzxwWRCqHeti4ePZ6yxWcQMHgwFWOElq0zTEzh3CrmIqyD0SCBAiQbu7LC0L
 dthny612W9WbEgJJbT6MpYskTi9zXwsYglQ1D+Avv1Zbw55jjdzZeYQZqkqQd6EohFxu9iD5MrY
 spuv5ETPZYET0kdQvrlhbfWwef3Di8KOuoLmhAHThPMocgfCKIkGZj520S3ZR6L3Br9Ho3mRlqR
 Tkxou8TZWa//fv0U8BYUHeGdJKMoLHzY4zFifHvqp0uRQTb4k96rH9dUMinvqUxZts4bCBrdTN2
 +gsdPIZbEg1jPYG+iT31Zm0IDa5NGN5Dr1Pwl3lifRR39pKFriWwT7Wjd5Yo5NC9eJKsbWqB1ZM
 8Zl00iEl/dweqgilxQWuUFxJIbzJgeeRgZBY5QP9nJy+nfUoRWlM0EyMLuWdP4ukzQtr5MOf+YE
 eNNbZM=
X-Received: by 2002:a17:90b:33c8:b0:398:c6e1:dceb with SMTP id
 98e67ed59e1d1-39dfe036433mr12183997a91.9.1789564094006; 
 Wed, 16 Sep 2026 06:08:14 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 40/92] tcg: Generic expansion of tcg_gen_brcond_*
Date: Wed, 16 Sep 2026 03:03:15 -1000
Message-ID: <20260916130409.3382710-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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
 include/tcg/tcg-op-common.h  |  5 ++--
 include/tcg/tcg.h            |  1 +
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 46 +++++++++++++++++++-----------------
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a5b9e0da647..31d35780739 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -98,6 +98,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -120,6 +122,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /* 32 bit ops */
 
@@ -143,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +218,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 27ea86ce02a..55a2313b38c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -97,6 +97,7 @@ struct TCGLabelUse {
 };
 
 typedef struct TCGLabel TCGLabel;
+typedef struct TCGLabel *TCGLabelPtr;
 struct TCGLabel {
     bool present;
     bool has_value;
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e17caafd890..d2bbf9ba017 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,6 +5,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
+DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0ffe0a9930d..e42ee3f08a1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -326,6 +326,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -338,6 +340,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /*
  * Templated operations.
@@ -355,10 +358,17 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c)               \
     { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
 
+#define DEF4(NAME, T1, T2, T3, T4)                                      \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1 a, T2 b, T3 c, T4 d)         \
+    { gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),                  \
+                 glue(C_,T3)(c), glue(C_,T4)(d)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_TCGCond
+#define C_TCGLabelPtr
 
 #define TCGV  glue(TCGv,TEXT)
 #define TEXT  _i32
@@ -386,6 +396,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_TCGCond
+#undef C_TCGLabelPtr
 
 #undef DEF1
 #undef DEF2
@@ -453,6 +465,18 @@ static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
+                       TCGTemp *src2, TCGLabel *l)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_br(l);
+    } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op = gen_op_ttii(INDEX_op_brcond, type,
+                                src1, src2, cond, label_arg(l));
+        add_as_label_use(l, op);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -717,17 +741,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
-                                      arg1, arg2, cond, label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1527,17 +1540,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
-                                      label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
     tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-- 
2.53.0


