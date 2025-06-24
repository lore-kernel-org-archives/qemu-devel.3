Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBE0C7115B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 01:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTsJn-0000ch-4u; Mon, 23 Jun 2025 21:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJk-0000c2-IR
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:20 -0400
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTsJf-0005qA-J5
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 21:19:20 -0400
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6fb0a05b56cso101321706d6.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 18:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750727954; x=1751332754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuydYiohJjAYeAfLOI6h5c9kv5DQU5vOeyLn5vjXhmM=;
 b=dscb4V1d5P4Bq9xhM2S3jvDQC4sq+8PxdUX42O72lC04pTs5oT/o059wxzmGqsC60P
 uKnNfB/6j/14Z45jjJZps6AR1/wW24n98CZ8rIhMShAlsXhYfzL8nePRO1BWY2u59EI2
 X8nR1gW/Ke2QCokshKsLY1R0/RinvFcRULgrFk2Nc62lMrgUVCmBNhheqS3I4kmRT4Zp
 VSS04jGZRUqopphFWliEfoe0uOmm04A061tk0RAKWraSDhKxbL1q2OkU3+qQR5BlWVXT
 1hn+LOWC8LXprCMev8KrNcz1hUCmk4nFF+iWI/NwSQpOaHc2/gvzNAPZyqX8nMUzw8ot
 OcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750727954; x=1751332754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuydYiohJjAYeAfLOI6h5c9kv5DQU5vOeyLn5vjXhmM=;
 b=uisq5k2NLWcs1WrMjn65oZQtnGhLZmQi+y2XI/oJbP0S6FDyckuwp+foacP9z3jUsQ
 79abvSrwU2HNYxA0if3R7pHPPJ1HAwsW528AJ4d8PNKE20Erv0gPzG6/rQPaWnstpk+7
 k10uX0r3KsM+552Ey12bElatnOSySKPGr0yC2kV7NDLrRwqBjx7hwPy/2v2fRKmDF4Nn
 KHU2Kfp76JkdYvzQtxr/vgyi/KcMfy391TPLssS2qJjpX5nLlig+jVWKnRG+wDzaT0z6
 NJrHvuWD8Y59zLKDQ/XW2Gumwkm2flXTYVSEpcA9OgoCq0V8qZG7ikWpPw8oQp06Vunl
 dfRw==
X-Gm-Message-State: AOJu0YyHnakDKGBamIQ8XoffQ2CQ/RTbz2fOBbngCW6StjyhE/TTwwxG
 PSmXGTMRsh4TUs8ZOCDTtH+3vSWV9SGzoIEvCvkowYsYovcJa5v2oKE40ZIXWLvDbRXZTTacIld
 RrzaTb0M=
X-Gm-Gg: ASbGncvsEY+tSSj+9ymgPF62eAPqsWSej7tfPZfCzQX90nm8WReWarJ85WAMIJrJ9B8
 oojJ2az5uCiOx/ADBvsdd6fHNuMq3kV6k0wOolTZQ7zEf+K5CND+soGMMX/b2vsTA1UDxMx4hap
 +RSMgmGwd6wt7a2azrwBc/v7x2SDNSk7Yt+vjzNhcRdRIc8L28NvpQslEmPwm//sxSnH76eDVry
 ntdbQC2CfC1ITogEn1y2aWCdmwy4H92l//vvL8qxSEYd5YNw7eQCPCL66sX8OtS35IdZ6xwcxwn
 BfUEjg/dtyuCCY9oPxY7/d6QFu+xyZM9O5jo17YMz085Bfg9xqMHIXO60jqDtn2eRrbWPmMkP53
 wL3SRTEeMVaVIdLyncKXQ
X-Google-Smtp-Source: AGHT+IEWakOlwHPqgwj6Cxzo5fJvbaewbRy3QG3FJEsU5+ghanBRQHGaghDL8spyduW4Xw/apY9xng==
X-Received: by 2002:a05:6a00:4f8c:b0:732:2484:e0ce with SMTP id
 d2e1a72fcca58-7490da9cd1amr32981876b3a.17.1750727943274; 
 Mon, 23 Jun 2025 18:19:03 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749b5e08d28sm412080b3a.28.2025.06.23.18.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 18:19:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/11] tcg: Add base arguments to check_overlap_[234]
Date: Mon, 23 Jun 2025 18:18:52 -0700
Message-ID: <20250624011859.112010-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624011859.112010-1-richard.henderson@linaro.org>
References: <20250624011859.112010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f35;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf35.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 61 ++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index f5edadb992..0e6b42476e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -57,30 +57,39 @@ static void check_size_align(uint32_t oprsz, uint32_t maxsz, uint32_t ofs)
     tcg_debug_assert((ofs & max_align) == 0);
 }
 
-/* Verify vector overlap rules for two operands.  */
-static void check_overlap_2(uint32_t d, uint32_t a, uint32_t s)
+/*
+ * Verify vector overlap rules for two operands.
+ * When dbase and abase are not the same pointer, we cannot check for
+ * overlap at compile-time, but the runtime restrictions remain.
+ */
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
@@ -1206,7 +1215,7 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1270,7 +1279,7 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1336,7 +1345,7 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
     TCGType type;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1416,7 +1425,7 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
+    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1483,7 +1492,7 @@ void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
+    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1551,7 +1560,8 @@ void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
-    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
+    check_overlap_4(tcg_env, dofs, tcg_env, aofs,
+                    tcg_env, bofs, tcg_env, cofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -1621,7 +1631,8 @@ void tcg_gen_gvec_4i(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs | cofs);
-    check_overlap_4(dofs, aofs, bofs, cofs, maxsz);
+    check_overlap_4(tcg_env, dofs, tcg_env, aofs,
+                    tcg_env, bofs, tcg_env, cofs, maxsz);
 
     type = 0;
     if (g->fniv) {
@@ -3150,7 +3161,7 @@ do_gvec_shifts(unsigned vece, uint32_t dofs, uint32_t aofs, TCGv_i32 shift,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     /* If the backend has a scalar expansion, great.  */
     type = choose_vector_type(g->s_list, vece, oprsz, vece == MO_64);
@@ -3770,7 +3781,7 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     uint32_t some;
 
     check_size_align(oprsz, maxsz, dofs | aofs | bofs);
-    check_overlap_3(dofs, aofs, bofs, maxsz);
+    check_overlap_3(tcg_env, dofs, tcg_env, aofs, tcg_env, bofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
         do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
@@ -3890,7 +3901,7 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     TCGType type;
 
     check_size_align(oprsz, maxsz, dofs | aofs);
-    check_overlap_2(dofs, aofs, maxsz);
+    check_overlap_2(tcg_env, dofs, tcg_env, aofs, maxsz);
 
     if (cond == TCG_COND_NEVER || cond == TCG_COND_ALWAYS) {
         do_dup(MO_8, tcg_env, dofs, oprsz, maxsz,
-- 
2.43.0


