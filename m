Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB830C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8E-0001ZP-Kq; Sat, 12 Sep 2026 22:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7t-0000B6-59
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:30 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7p-00016f-54
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:28 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so1638290a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267162; x=1789871962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IupEUQ+T+DRiQeEVTjdJGpYAkuAwPpNxHoHAHetG1BY=;
 b=BE86HL56lVxIBq0D7WZXPhp2I/SyYhk6EBrnUGRi+X6t92C09Qx5FaT8h4c8cnATgK
 Bf57vma1W1iEteRFuJiZWsPNmhR88YyGZFkCt6a4q+TcUNzxzRWRX9QPLSI3RFhO80Hs
 tuZ+/YdR61ZONCPzmbWRa1sVnhZDJ5i5lMJGeSaXCZbHP6D6WpHKsG/g0WmFMjyvxOIZ
 E6WaMYMompHPgcFr8fPtbueAgDSP0BUQQn2vEyyuV2AO2WKe5Q+BMgfDP3ibQtCTrY21
 JfiYKzUKzQh8z6cUzHMTfW4J+dneoBggp8sCx4drdaxp6fiWHtHQIYVJA9gsFY/y5Gca
 K1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267162; x=1789871962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IupEUQ+T+DRiQeEVTjdJGpYAkuAwPpNxHoHAHetG1BY=;
 b=VG2BTBnlrnI6bBioFkeeA6jU7UebsosJkYSYFXlcz80VdpPKkVmZer11CHb76k6AEo
 IgmCt7COpiE0dzh3LwJ59BtZvLXgjByzchnWyKlxWQFY6E3aHro6s3N9apmNp8XapdAN
 qI4vAbchuqhLRDUS6/NnyCmGtB9qOapNH0fAjnSF4CMohUwuXRdLyQSyUE6DdpHXI/Fv
 YC2MlcCZx7f5/cocNGbn6Km3EynC7VdJYmGMH8JdnKLGyY6mmGAzGIP8I1prxqY33pBm
 GiZvJHd7gPDEVmZSS+gDGoesiMArrhK0VCrtcJEZYYowx6yo41kzg1wRZlOFpqQo4eU9
 /4fA==
X-Gm-Message-State: AFuF++kYNc2RstTDFIrQtrcFu68yJ3gIXaxcQqJbHmOIqmiS+6wyG/qh
 vo227l1X93NcDWP9GRFAtTVqcCiti8BT4jzFqAe9vvbp6NfuTITilj1aeEeSOt2fKF59hdFcGdZ
 XbIaafMU=
X-Gm-Gg: AYBFou2nYTl6j166NvgDdQ1rwae0LRgjOfV75zz4d6dY9DemphHhzMWtr/SWn0wO94z
 L7oZJCnGOW9gsgcpUfJFr0MdChZWEWLzeq7M2wQ/4JYVss42t0F7TrrwVyJRXStlBy1Dh4kdRgP
 6rwBBoR/rnCgvmVD24vr0CeQ2hQM4HBKoNN8Ih7hadvpGxm/m+kEguPeIU58pnodm08LJrmdcsR
 oLijYYi2VtsddEpLGmIZwF1qJv9EcYqfQCtq9Zu3V2Oxx9ddyhVNH+J8SsF5VY3cHhZ7Qvl41L4
 VBY2b6rBUzQW3YuqWleLX3vXUkdYeqnVIwi0pR7rTQ0C1M5Dm0HByyEGyqhbumJp/+Fqn4o32rP
 4ojZMgZQzkXg+6mC30K44QiwbBI/SVuaLNLn7FDW1xL+JO4LJrJnymkZth0H47c60juMK/0iwov
 urqPth4LztxgyhpdWyQ1CMqy5fhc/Nan7Zksg7Mn63VepQZbAf7BU+8+lCSa2LCGupTh0t+U+Ov
 RGWlRA=
X-Received: by 2002:a17:90b:3ecc:b0:39b:4877:ae90 with SMTP id
 98e67ed59e1d1-39d9c352654mr18067819a91.22.1789267162066; 
 Sat, 12 Sep 2026 19:39:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 37/86] tcg: Generic expansion of tcg_gen_brcond_*
Date: Sat, 12 Sep 2026 16:37:48 -1000
Message-ID: <20260913023837.741866-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
index 974681a29a1..2817089b62c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -98,6 +98,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    void glue(glue(tcg_gen_,NAME),TEXT)(T1, T2, T3, T4);
 
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
index 7669dc1c2db..de1a81d8e45 100644
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
index 1bbe6992e34..70e2443f562 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -326,6 +326,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     static void glue(gen_,NAME)(TCGType, T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     static void glue(gen_,NAME)(TCGType, T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    static void glue(gen_,NAME)(TCGType, T1, T2, T3, T4);
 
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


