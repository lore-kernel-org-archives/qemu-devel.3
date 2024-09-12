Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27441EE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZlw-0002kH-9e; Wed, 11 Sep 2024 22:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlq-0002OT-Pc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:22 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZln-00047Y-Tv
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-205659dc63aso5781535ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108879; x=1726713679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsgoXBUqhY92I8o0jSWWzMlp4jXjECIud5nMmIrPt6I=;
 b=zj0zM2wouUbn5tEzjBHcweljzO0zai7gHPOh7WKaN3x3Bqf2ERWF4QZf1BJScvhrAh
 TGS4PapknbY+c6AF0q5DXDbFB61lbDB6xxqGG+vfK78Kh1HpjfsKG5nvEpG1vt8hnwSd
 Lw+ssETk6MGWYaTC7tGZ6PJZdbbMDnmdCGCYovYlooMke3/fzWhSGqJF6vV/t10l4KVE
 RIsSMX6YK6tLmIQ/oEM4MORFJvl/9vNxqoTUz9878Lf774/n4O8E7j9hyM/ilqGvipTo
 SI+ndr0DE3OSBiHpi0JbjaKIa6t5VRhVtNsPqe/29vpE+Ueu4Mwmcz181tDzstj/H9TD
 wJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108879; x=1726713679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsgoXBUqhY92I8o0jSWWzMlp4jXjECIud5nMmIrPt6I=;
 b=D1Oq/WOfcUfCRAJLuz/EHLBoySOT8CuHvzW4Tv6kbJ21wxTUDjrxjbeVKy5NLJym/9
 xtr8fKx4YUvyk+9zuggtWD0TH5W79PKi9Ues81ciwe01HMPZsnTn/kytSy0tdSGz2QVe
 9zcyCCOSgleTA3xCQmtpXZ+O9qWmo374Q9wIJjZw8g4JQmT4EzSmp4ZtddqpOT9oqdkd
 d3d5oQd4/hb323p82wRrQ3vi+q4Zc84Jrv+bsZHmaiBpm5oNDMo0pCZXysQMH4k1NwQ+
 /Pl1VFBg7ELuFMm3X2THtuavbCUoxZmnUFwFE7WBIpFrY8f91wm/wqJy+ef+PdYVEHgf
 jGRw==
X-Gm-Message-State: AOJu0Yz2Bx1JYwqTDbuyV+Bj0/Rm2SI16sVTV1G6axHjoGtKgU2T6hfW
 Co/j20WemY+3Jv2jZq7PAGBmruXd/lKW8a+L1GIs8ZH8Epu+ElKQiHxjVcFHO1hjm/rU0WiL00C
 H
X-Google-Smtp-Source: AGHT+IE0woZJtAydXjkhfSoDwSeoFG06JP4UWD4Yt3oaXJPkQ3ero7Al7c6RKuFPPr3o3Djja/vOzg==
X-Received: by 2002:a17:903:1d2:b0:206:fea3:b9f6 with SMTP id
 d9443c01a7336-2076e3d580amr19157765ad.25.1726108878342; 
 Wed, 11 Sep 2024 19:41:18 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 02/29] target/arm: Replace tcg_gen_dupi_vec with constants
 in translate-sve.c
Date: Wed, 11 Sep 2024 19:40:47 -0700
Message-ID: <20240912024114.1097832-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Instead of copying a constant into a temporary with dupi,
use a vector constant directly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 128 +++++++++++++--------------------
 1 file changed, 49 insertions(+), 79 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9e2536dfe9..49d32fabc9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6081,9 +6081,9 @@ static void gen_sshll_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t imm)
 
     if (top) {
         if (shl == halfbits) {
-            TCGv_vec t = tcg_temp_new_vec_matching(d);
-            tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(halfbits, halfbits));
-            tcg_gen_and_vec(vece, d, n, t);
+            tcg_gen_and_vec(vece, d, n,
+                            tcg_constant_vec_matching(d, vece,
+                                MAKE_64BIT_MASK(halfbits, halfbits)));
         } else {
             tcg_gen_sari_vec(vece, d, n, halfbits);
             tcg_gen_shli_vec(vece, d, d, shl);
@@ -6138,18 +6138,18 @@ static void gen_ushll_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t imm)
 
     if (top) {
         if (shl == halfbits) {
-            TCGv_vec t = tcg_temp_new_vec_matching(d);
-            tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(halfbits, halfbits));
-            tcg_gen_and_vec(vece, d, n, t);
+            tcg_gen_and_vec(vece, d, n,
+                            tcg_constant_vec_matching(d, vece,
+                                MAKE_64BIT_MASK(halfbits, halfbits)));
         } else {
             tcg_gen_shri_vec(vece, d, n, halfbits);
             tcg_gen_shli_vec(vece, d, d, shl);
         }
     } else {
         if (shl == 0) {
-            TCGv_vec t = tcg_temp_new_vec_matching(d);
-            tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-            tcg_gen_and_vec(vece, d, n, t);
+            tcg_gen_and_vec(vece, d, n,
+                            tcg_constant_vec_matching(d, vece,
+                                MAKE_64BIT_MASK(0, halfbits)));
         } else {
             tcg_gen_shli_vec(vece, d, n, halfbits);
             tcg_gen_shri_vec(vece, d, d, halfbits - shl);
@@ -6317,18 +6317,14 @@ static const TCGOpcode sqxtn_list[] = {
 
 static void gen_sqxtnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t mask = (1ull << halfbits) - 1;
     int64_t min = -1ull << (halfbits - 1);
     int64_t max = -min - 1;
 
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, d, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, d, d, t);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_and_vec(vece, d, d, t);
+    tcg_gen_smax_vec(vece, d, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, d, d, tcg_constant_vec_matching(d, vece, max));
+    tcg_gen_and_vec(vece, d, d, tcg_constant_vec_matching(d, vece, mask));
 }
 
 static const GVecGen2 sqxtnb_ops[3] = {
@@ -6349,19 +6345,15 @@ TRANS_FEAT(SQXTNB, aa64_sve2, do_narrow_extract, a, sqxtnb_ops)
 
 static void gen_sqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t mask = (1ull << halfbits) - 1;
     int64_t min = -1ull << (halfbits - 1);
     int64_t max = -min - 1;
 
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, n, n, tcg_constant_vec_matching(d, vece, max));
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, tcg_constant_vec_matching(d, vece, mask), d, n);
 }
 
 static const GVecGen2 sqxtnt_ops[3] = {
@@ -6389,12 +6381,10 @@ static const TCGOpcode uqxtn_list[] = {
 
 static void gen_uqxtnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
 
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_gen_umin_vec(vece, d, n, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const GVecGen2 uqxtnb_ops[3] = {
@@ -6415,14 +6405,13 @@ TRANS_FEAT(UQXTNB, aa64_sve2, do_narrow_extract, a, uqxtnb_ops)
 
 static void gen_uqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const GVecGen2 uqxtnt_ops[3] = {
@@ -6450,14 +6439,11 @@ static const TCGOpcode sqxtun_list[] = {
 
 static void gen_sqxtunb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
 
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, d, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, d, d, t);
+    tcg_gen_smax_vec(vece, d, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, d, d, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const GVecGen2 sqxtunb_ops[3] = {
@@ -6478,16 +6464,14 @@ TRANS_FEAT(SQXTUNB, aa64_sve2, do_narrow_extract, a, sqxtunb_ops)
 
 static void gen_sqxtunt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const GVecGen2 sqxtunt_ops[3] = {
@@ -6551,13 +6535,11 @@ static void gen_shrnb64_i64(TCGv_i64 d, TCGv_i64 n, int64_t shr)
 
 static void gen_shrnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     uint64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_shri_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_and_vec(vece, d, n, t);
+    tcg_gen_and_vec(vece, d, n, tcg_constant_vec_matching(d, vece, mask));
 }
 
 static const TCGOpcode shrnb_vec_list[] = { INDEX_op_shri_vec, 0 };
@@ -6609,13 +6591,11 @@ static void gen_shrnt64_i64(TCGv_i64 d, TCGv_i64 n, int64_t shr)
 
 static void gen_shrnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     uint64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_shli_vec(vece, n, n, halfbits - shr);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, tcg_constant_vec_matching(d, vece, mask), d, n);
 }
 
 static const TCGOpcode shrnt_vec_list[] = { INDEX_op_shli_vec, 0 };
@@ -6658,14 +6638,12 @@ TRANS_FEAT(RSHRNT, aa64_sve2, do_shr_narrow, a, rshrnt_ops)
 static void gen_sqshrunb_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    uint64_t max = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, d, n, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const TCGOpcode sqshrunb_vec_list[] = {
@@ -6690,16 +6668,15 @@ TRANS_FEAT(SQSHRUNB, aa64_sve2, do_shr_narrow, a, sqshrunb_ops)
 static void gen_sqshrunt_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    uint64_t max = MAKE_64BIT_MASK(0, halfbits);
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const TCGOpcode sqshrunt_vec_list[] = {
@@ -6742,18 +6719,15 @@ TRANS_FEAT(SQRSHRUNT, aa64_sve2, do_shr_narrow, a, sqrshrunt_ops)
 static void gen_sqshrnb_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = MAKE_64BIT_MASK(0, halfbits - 1);
     int64_t min = -max - 1;
+    int64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_and_vec(vece, d, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, n, n, tcg_constant_vec_matching(d, vece, max));
+    tcg_gen_and_vec(vece, d, n, tcg_constant_vec_matching(d, vece, mask));
 }
 
 static const TCGOpcode sqshrnb_vec_list[] = {
@@ -6778,19 +6752,16 @@ TRANS_FEAT(SQSHRNB, aa64_sve2, do_shr_narrow, a, sqshrnb_ops)
 static void gen_sqshrnt_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = MAKE_64BIT_MASK(0, halfbits - 1);
     int64_t min = -max - 1;
+    int64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, n, n, tcg_constant_vec_matching(d, vece, max));
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, tcg_constant_vec_matching(d, vece, mask), d, n);
 }
 
 static const TCGOpcode sqshrnt_vec_list[] = {
@@ -6833,12 +6804,11 @@ TRANS_FEAT(SQRSHRNT, aa64_sve2, do_shr_narrow, a, sqrshrnt_ops)
 static void gen_uqshrnb_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    int64_t max = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_shri_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_gen_umin_vec(vece, d, n, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const TCGOpcode uqshrnb_vec_list[] = {
@@ -6863,14 +6833,14 @@ TRANS_FEAT(UQSHRNB, aa64_sve2, do_shr_narrow, a, uqshrnb_ops)
 static void gen_uqshrnt_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    int64_t max = MAKE_64BIT_MASK(0, halfbits);
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
     tcg_gen_shri_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const TCGOpcode uqshrnt_vec_list[] = {
-- 
2.43.0


