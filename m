Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE528C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80D-0007Dq-Uz; Thu, 06 Feb 2025 14:57:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg805-00078w-QP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:25 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg802-0000S1-HA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:25 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2f9c69aefdbso2645674a91.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871841; x=1739476641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cf3tZ+uL08zlh8bFAF0MJI9Fv9UayGjAADjcJixVgA=;
 b=EMLwhjvsWOE9dNaLZkbLFAsz4XhGzwx6W2vpVASdu5TOklAAvFExRVkczng79fmFFa
 6DDsE8enloDCt/ZhhzOcoVNhoSNoZZJsUpZYrWKqXEc0DF8PUzfHtmn5Q7I2Lxwj39+k
 wuCE/mq0x6/ddPoQIbCtOaZOKUtjKxoQ6ry6x1a7i5rXM4O6Y7WMMhpnetjw9YQ3yX/g
 TqQFLqiKth6Wq+GBMUKFTLpWb02A6xmkN4dSFKA+LGvhnraYLrc1XnlH8Jy1z5+AF/+b
 d9ki159Y7xiavz43Rr4KyKhnCyTFbXmAuu7Ic6ar3CotIEuT6euEA6DT1X3Mg1kRa2EZ
 Peqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871841; x=1739476641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9cf3tZ+uL08zlh8bFAF0MJI9Fv9UayGjAADjcJixVgA=;
 b=Vo85e1S/QpIGZYvbJPZ3raSWmJfK1sjJwHW4dwufFeqIHyBNZvBRgxqG4Yx9WPOrUp
 cNmNXraBEvF2K5Ux1ZUgvqugde0CoPeZXqZD6UHtK+/bv25QI+26OEVf0TUzg9sNAX8T
 5YMw4V79GI1QXgSf3wYVeFgSYO7CnN9JR6ur5LKGA/Rgx/lOTvmI8zxmYXs6a8JWNX0p
 QmuBnSmJMsisqBgcR3Jq2WYGXR56o3ATCBL9RwfCkpXnNJqCHHgE0EaJSkGFeTCZxVOa
 5+XWDLUgUcu5Vv3QaxXaS4j7h3Iwv5bdbxxvd+uEgXAFCRRYPumAi+JboTvcJUXe/vKr
 9o8A==
X-Gm-Message-State: AOJu0Yyp6Zlnb/AdmuHUBll2OF8bngN53ToVk/+osCU4p7lswFiAf10B
 IGQEXDjzWDbo78pzpCsuhuJcfS9KA7ah0SEE5liaM69+33wmt62V6HjlbCwa6QyGbfru0Xa6ykt
 t
X-Gm-Gg: ASbGncuJ2YeeNB06+1vYLjZ8N4hESaUBKC4HOVO7+Q3hhpCRHqC9MwZtzqWdf3TB3Nq
 1O/SMDeCZ5b3S9xCncTsVrQpdssbPTq+fQAB18/HB1HLuypXOmdJ3ES4fz6FYkVSbKk0Cnw02Zc
 MwQYaYC95RNPQWhmWGLgxRx3mkubz8j6iEAIvdRJ00N4prei4WVw3h/aJ+u7ETJ0QdOOitJQgkz
 BXtPNPcUqwANpf8i1ytm6fAewMCc/1h6kWgOJ+cQhkmeyijBQleQE69WgXJcy+rKHeERefJiDZu
 Ix/gS1yAUWwggBeftEskidoCVnRFJevOgXRHnm5WglNNp8Y=
X-Google-Smtp-Source: AGHT+IFdfIS8cIyn5PI/aNOMZCdyYzgyK1rTwVuc5xr0Uuo7SNQJrUaack+Mhj/NI59YgueGdw0Jxg==
X-Received: by 2002:a05:6a00:ac8a:b0:725:d1d5:6d86 with SMTP id
 d2e1a72fcca58-7305d51c766mr721898b3a.19.1738871841178; 
 Thu, 06 Feb 2025 11:57:21 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/61] tcg: Split out tcg_gen_gvec_3_var
Date: Thu,  6 Feb 2025 11:56:20 -0800
Message-ID: <20250206195715.2150758-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec-common.h |   4 ++
 tcg/tcg-op-gvec.c                | 102 +++++++++++++++++++------------
 2 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 877871c101..6e8fccad01 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -236,6 +236,10 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, int64_t c, const GVecGen2i *);
 void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
+void tcg_gen_gvec_3_var(TCGv_ptr dbase, uint32_t dofs,
+                        TCGv_ptr abase, uint32_t aofs,
+                        TCGv_ptr bbase, uint32_t bofs,
+                        uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
 void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 08019421f2..3e53e43354 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -178,9 +178,11 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
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
@@ -189,9 +191,9 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     a1 = tcg_temp_ebb_new_ptr();
     a2 = tcg_temp_ebb_new_ptr();
 
-    tcg_gen_addi_ptr(a0, tcg_env, dofs);
-    tcg_gen_addi_ptr(a1, tcg_env, aofs);
-    tcg_gen_addi_ptr(a2, tcg_env, bofs);
+    tcg_gen_addi_ptr(a0, dbase, dofs);
+    tcg_gen_addi_ptr(a1, abase, aofs);
+    tcg_gen_addi_ptr(a2, bbase, bofs);
 
     fn(a0, a1, a2, desc);
 
@@ -200,6 +202,14 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
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
@@ -789,8 +799,10 @@ static void expand_2s_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
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
@@ -799,13 +811,13 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
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
@@ -953,8 +965,10 @@ static void expand_2s_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
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
@@ -963,13 +977,13 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
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
@@ -1114,8 +1128,9 @@ static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
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
@@ -1124,13 +1139,13 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
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
 
@@ -1432,8 +1447,10 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
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
@@ -1441,7 +1458,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
+    check_overlap_3(dbase, dofs, abase, aofs, bbase, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1454,8 +1471,8 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
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
@@ -1466,23 +1483,25 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
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
@@ -1493,10 +1512,17 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
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


