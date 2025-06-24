Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4788C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJb-0000Zf-6o; Mon, 23 Jun 2025 21:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJY-0000YE-BD
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:08 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJW-0005ne-9b
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-748ece799bdso3336533b3a.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727945; x=1751332745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eh7a9DeY1ZSbJLViP7gxIdUrcoetx4rJhwuJcaL9wQ=;
 b=J4lzuFzGWNMhKXK3D2++gkWn/TaJYVekCS+9Rx7WUFjI+3leqpVB3hH6BE9j6IQD3n
 mQV1c+Blucr0wqNkkVR73QGVgBFWq967ZEIZcUSFHxLWinI5Zb6/H5b6+sxMFP5riilj
 0ONnxEBl70bV8jR4QwI7xb3qNMWhkRfOzmUM7c5WVQSP/D9Oqahiq33lw5GO6zgtdaAx
 xah5bst8naeiJui1Wq30ebT/EuUyIFfIbLh8kSiUdCD8pRJ7k38P3ZM1iPz/MK0jDVea
 n3U67HTRU3hfaKLu0ceYd/3nnckUso8p9VZXvf8NfdkW+c/0CuT9IvEcZGgqyPKA4kkQ
 cC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727945; x=1751332745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eh7a9DeY1ZSbJLViP7gxIdUrcoetx4rJhwuJcaL9wQ=;
 b=MRY3UDzck+Zagab69RnmKe3ZyaoEsTtzuDHLZRsSayyoomcXB/Ca1TLN7zunsUbsRL
 C9smX0mcQeUP+jPh1U/8xfBExGlnXKcpgvbcDeDMGmynw6yCM8hT5BiggwOrvD/UU3WG
 Q3tkn4GOaoRQxmOIJBs0lCsbMpvk3UVpVZIzYBtIE3w/3W8Ib5zZHMDu0QeuDx5CjEtA
 zejymNXkY+n0U06SHGFsgqW87SaA3p8+5YWVYMMsBDShNZgPW+x0GpqGMVmRcG2MwKxY
 eUngTJ6/1CR98LYMU88DWwc6GIuri7vG39U0SeYYPFhupU5MvN+jp8f2Bsi52QFQmZgg
 jjbg==
X-Gm-Message-State: AOJu0YxQre5L5dT1pRox4wCJIbVmlUyHFVJOFZ2VGYwqUvdgb++rLyuy
 RQFlQhztwhagmoUQwWS5fZYrfWYzWxHdlpUrobL/TiNRZpkTGzarkk/VWXw9523U45k2DRDRqtB
 bJWRECq4=
X-Gm-Gg: ASbGncv7kXqWBhWl4U4qdT2hlFZMnnFdv9S3v4M3suZeBoPV6XvXod6g3kA7hbmunI0
 SoPjE/jUL62FMJXYboi11JdFz2UqatqYXWWlUfPSEEQKII0eUt76+bEbZJMk9KvG1X5an5b1wFM
 tr/m0mUmchuC0vj6umkf31RaAOI71cV64eFb6glvQMZPaobi5ukRH3fYc0FNomfb5LG1FywxO74
 fG7XTFVoyaK+qyvhc5ScFFrh4wsiQaucc4OpdxZn6SxcCC17jgPNCbn4oI4Komhbeu51uQKdKlZ
 7B5n/O59Nimktx92bKhKgOkPwhs+z/arDmdrusr4CFPVH5usNu7/ATx9Khqn9hr9vwj9h37S+Lf
 Kp2JyYyFkLRR6SGOXzNqY
X-Google-Smtp-Source: AGHT+IFdMlRSH7QPzbaDkYTWE2JxP3ebEOAX8BLuocBNBAMVLbRW5sVs74JSOzEyKDoDOpLe936JGQ==
X-Received: by 2002:a05:6a21:9987:b0:21f:8d4f:9e3b with SMTP id
 adf61e73a8af0-22026e60126mr22797455637.7.1750727944661; 
 Mon, 23 Jun 2025 18:19:04 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/11] tcg: Split out tcg_gen_gvec_3_var
Date: Mon, 23 Jun 2025 18:18:54 -0700
Message-ID: <20250624011859.112010-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, OBFU_UNSUB_UL=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |  33 +++++++++-
 tcg/tcg-op-gvec.c                | 102 +++++++++++++++++++------------
 2 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index f00af047c4..29bcedb737 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -241,13 +241,42 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, TCGv_i64 c, const GVecGen2s *op);
 
+/*
+ * Expand (dbase+dofs) = op(abase+aofs, bbase+bofs),
+ * length @oprsz, clearing to @maxsz.
+ */
+void tcg_gen_gvec_3_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        TCGv_ptr bbase, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen3 *op);
+/* Similarly, expand (env+dofs) = op(env+aofs, env+bofs). */
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *op);
+
+/*
+ * Depending on op->load_dest and op->write_aofs, expand
+ *    (env+dofs) = op(env+aofs, env+bofs, c)
+ * or
+ *    (env+dofs) = op(env+dofs, env+aofs, env+bofs, c)
+ * or
+ *    (env+dofs), (env+aofs) = op(env+aofs, env+bofs, c)
+ * or
+ *    (env+dofs), (env+aofs) = op(env+dofs, env+aofs, env+bofs, c)
+ */
 void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                      uint32_t oprsz, uint32_t maxsz, int64_t c,
-                     const GVecGen3i *);
+                     const GVecGen3i *op);
+
+/*
+ * Depending on op->write_aofs, expand
+ *     (env+dofs) = op(env+aofs, env+bofs, env+cofs)
+ * or
+ *     (env+dofs), (env+aofs) = op(env+aofs, env+bofs, env+cofs)
+ */
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
+
+/* Expand (env+dofs) = op(env+aofs, env+bofs, env+cofs, c). */
 void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                      uint32_t oprsz, uint32_t maxsz, int64_t c,
                      const GVecGen4i *);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index ec926bdcd7..862cecf1bf 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -182,9 +182,11 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
 }
 
 /* Generate a call to a gvec-style helper with three vector operands.  */
-void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                        uint32_t oprsz, uint32_t maxsz, int32_t data,
-                        gen_helper_gvec_3 *fn)
+static void expand_3_ool(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs,
+                         uint32_t oprsz, uint32_t maxsz,
+                         int32_t data, gen_helper_gvec_3 *fn)
 {
     TCGv_ptr a0, a1, a2;
     TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
@@ -193,9 +195,9 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     a1 = tcg_temp_ebb_new_ptr();
     a2 = tcg_temp_ebb_new_ptr();
 
-    tcg_gen_addi_ptr(a0, tcg_env, dofs);
-    tcg_gen_addi_ptr(a1, tcg_env, aofs);
-    tcg_gen_addi_ptr(a2, tcg_env, bofs);
+    tcg_gen_addi_ptr(a0, dbase, dofs);
+    tcg_gen_addi_ptr(a1, abase, aofs);
+    tcg_gen_addi_ptr(a2, bbase, bofs);
 
     fn(a0, a1, a2, desc);
 
@@ -204,6 +206,14 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
 }
 
+void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, int32_t data,
+                        gen_helper_gvec_3 *fn)
+{
+    expand_3_ool(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                 oprsz, maxsz, data, fn);
+}
+
 /* Generate a call to a gvec-style helper with four vector operands.  */
 void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t cofs, uint32_t oprsz, uint32_t maxsz,
@@ -794,8 +804,10 @@ static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
-static void expand_3_i32(uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz, bool load_dest,
+static void expand_3_i32(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs,
+                         uint32_t oprsz, bool load_dest,
                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
@@ -804,13 +816,13 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 4) {
-        tcg_gen_ld_i32(t0, tcg_env, aofs + i);
-        tcg_gen_ld_i32(t1, tcg_env, bofs + i);
+        tcg_gen_ld_i32(t0, abase, aofs + i);
+        tcg_gen_ld_i32(t1, bbase, bofs + i);
         if (load_dest) {
-            tcg_gen_ld_i32(t2, tcg_env, dofs + i);
+            tcg_gen_ld_i32(t2, dbase, dofs + i);
         }
         fni(t2, t0, t1);
-        tcg_gen_st_i32(t2, tcg_env, dofs + i);
+        tcg_gen_st_i32(t2, dbase, dofs + i);
     }
     tcg_temp_free_i32(t2);
     tcg_temp_free_i32(t1);
@@ -958,8 +970,10 @@ static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
-static void expand_3_i64(uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz, bool load_dest,
+static void expand_3_i64(TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs,
+                         uint32_t oprsz, bool load_dest,
                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
@@ -968,13 +982,13 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 8) {
-        tcg_gen_ld_i64(t0, tcg_env, aofs + i);
-        tcg_gen_ld_i64(t1, tcg_env, bofs + i);
+        tcg_gen_ld_i64(t0, abase, aofs + i);
+        tcg_gen_ld_i64(t1, bbase, bofs + i);
         if (load_dest) {
-            tcg_gen_ld_i64(t2, tcg_env, dofs + i);
+            tcg_gen_ld_i64(t2, dbase, dofs + i);
         }
         fni(t2, t0, t1);
-        tcg_gen_st_i64(t2, tcg_env, dofs + i);
+        tcg_gen_st_i64(t2, dbase, dofs + i);
     }
     tcg_temp_free_i64(t2);
     tcg_temp_free_i64(t1);
@@ -1119,8 +1133,9 @@ static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
-static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                         uint32_t bofs, uint32_t oprsz,
+static void expand_3_vec(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
+                         TCGv_ptr abase, uint32_t aofs,
+                         TCGv_ptr bbase, uint32_t bofs, uint32_t oprsz,
                          uint32_t tysz, TCGType type, bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
 {
@@ -1129,13 +1144,13 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         TCGv_vec t1 = tcg_temp_new_vec(type);
         TCGv_vec t2 = tcg_temp_new_vec(type);
 
-        tcg_gen_ld_vec(t0, tcg_env, aofs + i);
-        tcg_gen_ld_vec(t1, tcg_env, bofs + i);
+        tcg_gen_ld_vec(t0, abase, aofs + i);
+        tcg_gen_ld_vec(t1, bbase, bofs + i);
         if (load_dest) {
-            tcg_gen_ld_vec(t2, tcg_env, dofs + i);
+            tcg_gen_ld_vec(t2, dbase, dofs + i);
         }
         fni(vece, t2, t0, t1);
-        tcg_gen_st_vec(t2, tcg_env, dofs + i);
+        tcg_gen_st_vec(t2, dbase, dofs + i);
     }
 }
 
@@ -1437,8 +1452,10 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
 }
 
 /* Expand a vector three-operand operation.  */
-void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
+void tcg_gen_gvec_3_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        TCGv_ptr bbase, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
 {
     const TCGOpcode *this_list = g->opt_opc ? : vecop_list_empty;
     const TCGOpcode *hold_list = tcg_swap_vecop_list(this_list);
@@ -1446,7 +1463,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
+    check_overlap_3(dbase, dofs, abase, aofs, bbase, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1459,8 +1476,8 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_3_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
-                     g->load_dest, g->fniv);
+        expand_3_vec(g->vece, dbase, dofs, abase, aofs, bbase, bofs,
+                     some, 32, TCG_TYPE_V256, g->load_dest, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1471,23 +1488,25 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
         maxsz -= some;
         /* fallthru */
     case TCG_TYPE_V128:
-        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
-                     g->load_dest, g->fniv);
+        expand_3_vec(g->vece, dbase, dofs, abase, aofs, bbase, bofs,
+                     oprsz, 16, TCG_TYPE_V128, g->load_dest, g->fniv);
         break;
     case TCG_TYPE_V64:
-        expand_3_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
-                     g->load_dest, g->fniv);
+        expand_3_vec(g->vece, dbase, dofs, abase, aofs, bbase, bofs,
+                     oprsz, 8, TCG_TYPE_V64, g->load_dest, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_3_i64(dofs, aofs, bofs, oprsz, g->load_dest, g->fni8);
+            expand_3_i64(dbase, dofs, abase, aofs, bbase, bofs,
+                         oprsz, g->load_dest, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_3_i32(dofs, aofs, bofs, oprsz, g->load_dest, g->fni4);
+            expand_3_i32(dbase, dofs, abase, aofs, bbase, bofs,
+                         oprsz, g->load_dest, g->fni4);
         } else {
             assert(g->fno != NULL);
-            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz,
-                               maxsz, g->data, g->fno);
+            expand_3_ool(dbase, dofs, abase, aofs, bbase, bofs,
+                         oprsz, maxsz, g->data, g->fno);
             oprsz = maxsz;
         }
         break;
@@ -1498,10 +1517,17 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_swap_vecop_list(hold_list);
 
     if (oprsz < maxsz) {
-        expand_clr(tcg_env, dofs + oprsz, maxsz - oprsz);
+        expand_clr(dbase, dofs + oprsz, maxsz - oprsz);
     }
 }
 
+void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                    uint32_t oprsz, uint32_t maxsz, const GVecGen3 *g)
+{
+    tcg_gen_gvec_3_var(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs,
+                       oprsz, maxsz, g);
+}
+
 /* Expand a vector operation with three vectors and an immediate.  */
 void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                      uint32_t oprsz, uint32_t maxsz, int64_t c,
-- 
2.43.0


