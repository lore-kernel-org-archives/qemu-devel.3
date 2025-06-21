Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27C3C7115D
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7z0-00053j-OC; Sat, 21 Jun 2025 19:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yv-00050L-3u
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:45 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7yt-0004Qi-8n
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:50:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c7a52e97so2412542b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549842; x=1751154642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uoQR56lcjZAhphgQyGDSgdvmVHPYbCeYqSZu6JrpeEQ=;
 b=zVT9xJY/aEQHpoBxI73PNSA7YAWoto5th8i9cMkej7vyWbqx5tRTuXQAFF2+Fj/MnM
 gbAyV4FFDzAIidFv8/lWQhl4v+Z6zTRzw4fAY/N7v7VT3tCtyg1l6rQX6CuokwEzGX/y
 zd46NZqv2K9EYib5/jqH1IOQD9MHErCxzuCOhtSCEAOFt5ZEOkkuXIKASjayaOvd2c9u
 VlH9op8WkRLO0SckbNm2cZgb0v9nmQ7dCV/5EOPuHyXZ/D47y2Rb7mrsChsC9eWOsIs7
 eS5EwOt6FMKlVSbuXnWtEqp7XQssHK99ElRRipUn2HF9IttALF3bHKI0mMcj013FmLh2
 4lzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549842; x=1751154642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoQR56lcjZAhphgQyGDSgdvmVHPYbCeYqSZu6JrpeEQ=;
 b=Gru/HtKpF+khEhTTh9Ey8G1NsDNRyYDbCHoSHyWlNHv1OnsZ6vYCl4ytkddOVY6FVf
 b5oP7JUof8UmlQn9s9PJBlwtwJkIIh6TKHDfccEDnF0uu/Baitb9j/sM6QNr+huQ28wV
 c3TwrGU3EGqpD3LT4zaeI18GGCrM0EElMeHlRvUkHVAYIyUGnrQ7ONs5D+XpGmdDqDt5
 O4cuAuZwsG1TtVsTT/ZDW4PCnITlkaxIf/YZi9/3WNdtBcp1o6sleqPocxFcIWjoX7rE
 F1WC+A0oT1a+mnWUlCp2XW0FJpNemgP5L5DeB650GygwR6PKybIwU0pQHdulZmhCl+/a
 yi+g==
X-Gm-Message-State: AOJu0YwsLRrIDc88xK+70BPE2CHhNvGMUzjRhSoqfMkn3CLG33mniMGX
 f9XH+/m+NB0NX4D/O8Nsn8jDf43JvcvN4j0dqrVeRWxVrhhIp79p5ljul3rWMtftkhCEqylqDl5
 TmBbd
X-Gm-Gg: ASbGnctzFrs6pAKbvf8OuU0+K6tPyConYKFYugpi4yB0Y3mVl/ZD4aSE+gRg+LjFdek
 7xKo1zFo9kAmkrLESL67HBPtmvZy09uXEBEhaV9RlwoXNaqYS8sYWmUkOK1j2XeYZaYA+i4Ys8J
 MbYkUqXxKrRyHdLAC8sIJpfZQm1HHWljdj61nngWX3B7mkyRFcM6EjK6sBxaF4cRX/99GgLGNhm
 0OnkVIDrE6D9aarPvngy4UCLuhQO5fzX9jd6rbDQmcuHMKt37Ilr9U238f4eTpFo9n+VGFm/hD6
 smmoQD7RShj2Lpxgj7ZI0W4R3iLfalLNz+DcOdOQcUcX3i3dWyALwG2wQtdB2okcJ/dYxOZ3ooj
 wBD4WONR1ntuQICo5+hR401UWEgwYABw=
X-Google-Smtp-Source: AGHT+IHWQmsCemto+F7Ei3pjhKdfWRTfrKKwBCW5mgdzakXeCU2hwiyz3XLlzhDREcSNs9mNiDgAoA==
X-Received: by 2002:a05:6a00:4f8c:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-7490da9cd1amr9981329b3a.17.1750549841747; 
 Sat, 21 Jun 2025 16:50:41 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 004/101] tcg: Add base arguments to check_overlap_[234]
Date: Sat, 21 Jun 2025 16:49:00 -0700
Message-ID: <20250621235037.74091-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 55 ++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index c26cfb24cc..54304d08cc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -58,29 +58,34 @@ static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
 }
 
 /* Verify vector overlap rules for two operands.  */
-static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
+static void check_overlap_2(TCGv_ptr dbase, uint32_t d,
+                            TCGv_ptr abase, uint32_t a, uint32_t s)
 {
-    tcg_debug_assert(d == a || d + s <= a || a + s <= d);
+    tcg_debug_assert(dbase != abase || d == a || d + s <= a || a + s <= d);
 }
 
 /* Verify vector overlap rules for three operands.  */
-static void check_overlap_3(uint32_t d, uint32_t a, uint32_t b, uint32_t s)
+static void check_overlap_3(TCGv_ptr dbase, uint32_t d,
+                            TCGv_ptr abase, uint32_t a,
+                            TCGv_ptr bbase, uint32_t b, uint32_t s)
 {
-    check_overlap_2(d, a, s);
-    check_overlap_2(d, b, s);
-    check_overlap_2(a, b, s);
+    check_overlap_2(dbase, d, abase, a, s);
+    check_overlap_2(dbase, d, bbase, b, s);
+    check_overlap_2(abase, a, bbase, b, s);
 }
 
 /* Verify vector overlap rules for four operands.  */
-static void check_overlap_4(uint32_t d, uint32_t a, uint32_t b,
-                            uint32_t c, uint32_t s)
+static void check_overlap_4(TCGv_ptr dbase, uint32_t d,
+                            TCGv_ptr abase, uint32_t a,
+                            TCGv_ptr bbase, uint32_t b,
+                            TCGv_ptr cbase, uint32_t c, uint32_t s)
 {
-    check_overlap_2(d, a, s);
-    check_overlap_2(d, b, s);
-    check_overlap_2(d, c, s);
-    check_overlap_2(a, b, s);
-    check_overlap_2(a, c, s);
-    check_overlap_2(b, c, s);
+    check_overlap_2(dbase, d, abase, a, s);
+    check_overlap_2(dbase, d, bbase, b, s);
+    check_overlap_2(dbase, d, cbase, c, s);
+    check_overlap_2(abase, a, bbase, b, s);
+    check_overlap_2(abase, a, cbase, c, s);
+    check_overlap_2(bbase, b, cbase, c, s);
 }
 
 /* Create a descriptor from components.  */
@@ -1205,7 +1210,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1269,7 +1274,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1335,7 +1340,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     TCGType type;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1415,7 +1420,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
+    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1482,7 +1487,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
+    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1550,7 +1555,8 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
-    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
+    check_overlap_4(tcg_env, dofs, tcg_env, aofs,
+                    tcg_env, bofs, tcg_env, cofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1620,7 +1626,8 @@ void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
-    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
+    check_overlap_4(tcg_env, dofs, tcg_env, aofs,
+                    tcg_env, bofs, tcg_env, cofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -3149,7 +3156,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs, TCGv_i32 shift,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     /* If the backend has a scalar expansion, great.  */
     type = choose_vector_type(g->s_list, vece, oprsz, vece == MO_64);
@@ -3769,7 +3776,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
+    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
         do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
@@ -3889,7 +3896,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     TCGType type;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
         do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
-- 
2.43.0


