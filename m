Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36165C0219C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 19:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80B-0007CQ-1P; Thu, 06 Feb 2025 14:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg803-000771-Vb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:24 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg800-0000RV-Vq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f2cfd821eso24835335ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871839; x=1739476639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoQR56lcjZAhphgQyGDSgdvmVHPYbCeYqSZu6JrpeEQ=;
 b=Q5Enlsa0ucZqxBa9nSzreoxxXHqWL3PSElgcVAHZRwEOHPpBc65ExIU9oTTI1XXpty
 Fi4Gi21NCXToGpC6RgdYrhLEuhUn3nq3jsljroBwhx4UQzwbQWotnbkqnjxVKrt2j7AI
 1kq/hojK42H4wmv7reIUOwOeDdjfQ+UhQfo7iVYjxZj9CajIwMjAmxCqoXgbux1zXUvA
 hQe+00q/IAIKL5HU0RAj6lOJSuvOoi1PNWdoiKot5mQYExJYxvJ/31xsvkb9EsGhzyy5
 XixuUviUE6MRtzABH6f8GloLLSvVypiRLE/5WR0ER3hdicffKXdHtHujBaYfgEjIgvp+
 vKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871839; x=1739476639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoQR56lcjZAhphgQyGDSgdvmVHPYbCeYqSZu6JrpeEQ=;
 b=fA5uILmt+pSkfQPEYhR2YVhcv3LqlWiqZG1+O2/N/fdZUegEIQfjFX4k5Jlv3eJ9Ih
 1p7g2cwjnWQuOPP7w53Oww0qSnJh9HRgAMnBwyAZN+1jWjAWI3M+ozb0wOtxVtnZwWXK
 crJEZd+O076A0sBkL3odUJYUSnsDY4dC5+MXwdsHFmCobQ+pePIFf0c8UdeZxUQS25J0
 PMMWgeilf1OIt3pnhiVv/igVV00O4X6+Qi1KLH4/fs/TwVnJwBJj/1EWLooPXC+NTcOr
 3jXzncbnTB9wHwaX4nEm5hBAAwjch4nMFOssC/n8akzMIx29EM7nOv9DIGHqEuYABFCQ
 lzXg==
X-Gm-Message-State: AOJu0YyYRsMZDzHKf84ySQuONEq2SumejR0P0w5U9yGI+IUJ4QqKahGS
 xuCusexf0WwSBYuApr0XZNXIfcdDGgVVO05+RHWiCn4p3al0VNUswf0kjCth+V6cmtAFTrBW7Jp
 O
X-Gm-Gg: ASbGnct4EtDPWO32i1/Dom51NipdW++8lBn2ITwukTwAtcv7AcZaSbIDWNy9dzBAM4t
 ZJ5oHkWBRY7Pkqbx+ydMaerOh7YHBpBmRtlW6pJzYT3InkNArlWL1jLnSYCP8gRzZXP6j/RfPbt
 EhDYmvVGKqx+6zK0/RfJsvSb6k61fI/OfeFWtfSlQhSE1knTKo7oS2qFJwqDXyXL4vOpl7NEmkr
 Q771WyIvlBdf/TqV8LuKyOHuJvg0Uym1eeZ4Jz19R4V7PiCjAwbK1ka/U07vlJfkAdpThjhCssX
 p8Vd3yuMuKiNfAcYc/fuxx8HuekvNEe7oUURvTvgDzXCzU4=
X-Google-Smtp-Source: AGHT+IGHicfBGNh/sbFN43nWffgzgpSw6u4qO6tDBN/EViWA/cx0snrhzwjOME6bQXVKsoswLo+TNg==
X-Received: by 2002:a05:6a21:3511:b0:1e5:c43f:f36d with SMTP id
 adf61e73a8af0-1ee03a45cd8mr1371365637.18.1738871839580; 
 Thu, 06 Feb 2025 11:57:19 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/61] tcg: Add base arguments to check_overlap_[234]
Date: Thu,  6 Feb 2025 11:56:18 -0800
Message-ID: <20250206195715.2150758-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


