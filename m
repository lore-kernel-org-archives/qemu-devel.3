Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC1CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 17:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzg7Z-000209-39; Wed, 24 Apr 2024 13:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7R-0001ye-Or
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzg7P-0005Mf-S2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 13:09:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e2b1cd446fso265435ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713978554; x=1714583354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T0/wwsmOrIFP2k0lfcZhLa1SDoLg5xmY78unAbAeB00=;
 b=H7sImLsv1v8mHhJEgDamGcp/w1GmWIzqCpeKm5BxXmvM2ZW7DAO2+bbRg26EDStnfC
 rsYRRVbkBZBJus5H7/C0MkEoDPJxLPOe9/jnfcZBv81SpwocczasBfbNkrV+AMYDgND4
 H062sECC9+6qQn/EFFMcPYbh3oggSpL8vb8/yzNi4e7fWQ33QMdSLc/aqDasfzZakuW4
 0fAzrlI/h2Y8XEoiBOk2iz2+CxI9PMKDc8A9XuhLD4pesawJ5lwr2cfDCQECjYMTaTRv
 sQqqOBdq9rrsLnroQA7mr5JLgExuRxO9l1g1wve8xDJGjqdxtqohGsPgrOw5YJNu1cQ9
 XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713978554; x=1714583354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T0/wwsmOrIFP2k0lfcZhLa1SDoLg5xmY78unAbAeB00=;
 b=G94VHNqzlBiBmaPx6tFcvTyxOZrX2xRXJaWHesbAr6U2A7m5ECDjYYch6AdhScrfFh
 SbyZ+Dhchggez8g1dp2AQVOOJbWEAS/bjojo78rkQUcRAesdsMv4FbDu0t5NirTuMAFf
 2dZkWhft3teAFsLwE5knaOZVaK5myWPyrWhN4Pf38Sldlt+8rZiIuM0Pt0ogmjT6KW+J
 /VQSoQiHkXzDXWxAIoiRQOSJAAFESbkcPhBCvp7Ww4pXPs8p+DTyrNb5rY4aJs7FlqAQ
 QDQBQCz0kL1QugESTY9p/46SpVRnbSLc5VNvs2i3t9auiRoTpcoW1B7UALqnyD+l3F0w
 gsYQ==
X-Gm-Message-State: AOJu0YyY27BwdgVd+FF3Oo0pXX6b17IDXTrMxs9agpahU/qgby7TzZ1j
 I2K2znxDx/ec+RsGSEFchB0Tt9uN4+qdieQ7twOniCOlwQ4AGbACkJ510cSdTl4ffaLson5cjvU
 K
X-Google-Smtp-Source: AGHT+IH4yayLi5d/dSHHjT7FVFY+A2gphbGYUG7hxuH44xiwskJqpRxbqh4ErcbbpzqivnuWSKgkOA==
X-Received: by 2002:a17:902:784f:b0:1e6:1a7a:98df with SMTP id
 e15-20020a170902784f00b001e61a7a98dfmr2657901pln.66.1713978554565; 
 Wed, 24 Apr 2024 10:09:14 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 u8-20020a170902e80800b001e0b5d49fc7sm12215489plg.161.2024.04.24.10.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 10:09:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] tcg/i386: Simplify immediate 8-bit logical vector shifts
Date: Wed, 24 Apr 2024 10:09:05 -0700
Message-Id: <20240424170908.759043-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424170908.759043-1-richard.henderson@linaro.org>
References: <20240424170908.759043-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

The x86 isa does not have this operation, so we need an expansion.
Use the same algorithm that we use for expanding this vector
operation with integers: perform the shift with a wider type
and then mask the bits that must be zero.

This reduces the instruction count from 5 to 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 61 +++++++++------------------------------
 1 file changed, 14 insertions(+), 47 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index c6ba498623..6837c519b0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3769,49 +3769,20 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static void expand_vec_shi(TCGType type, unsigned vece, TCGOpcode opc,
+static void expand_vec_shi(TCGType type, unsigned vece, bool right,
                            TCGv_vec v0, TCGv_vec v1, TCGArg imm)
 {
-    TCGv_vec t1, t2;
+    uint8_t mask;
 
     tcg_debug_assert(vece == MO_8);
-
-    t1 = tcg_temp_new_vec(type);
-    t2 = tcg_temp_new_vec(type);
-
-    /*
-     * Unpack to W, shift, and repack.  Tricky bits:
-     * (1) Use punpck*bw x,x to produce DDCCBBAA,
-     *     i.e. duplicate in other half of the 16-bit lane.
-     * (2) For right-shift, add 8 so that the high half of the lane
-     *     becomes zero.  For left-shift, and left-rotate, we must
-     *     shift up and down again.
-     * (3) Step 2 leaves high half zero such that PACKUSWB
-     *     (pack with unsigned saturation) does not modify
-     *     the quantity.
-     */
-    vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
-              tcgv_vec_arg(t1), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-    vec_gen_3(INDEX_op_x86_punpckh_vec, type, MO_8,
-              tcgv_vec_arg(t2), tcgv_vec_arg(v1), tcgv_vec_arg(v1));
-
-    if (opc != INDEX_op_rotli_vec) {
-        imm += 8;
-    }
-    if (opc == INDEX_op_shri_vec) {
-        tcg_gen_shri_vec(MO_16, t1, t1, imm);
-        tcg_gen_shri_vec(MO_16, t2, t2, imm);
+    if (right) {
+        mask = 0xff >> imm;
+        tcg_gen_shri_vec(MO_16, v0, v1, imm);
     } else {
-        tcg_gen_shli_vec(MO_16, t1, t1, imm);
-        tcg_gen_shli_vec(MO_16, t2, t2, imm);
-        tcg_gen_shri_vec(MO_16, t1, t1, 8);
-        tcg_gen_shri_vec(MO_16, t2, t2, 8);
+        mask = 0xff << imm;
+        tcg_gen_shli_vec(MO_16, v0, v1, imm);
     }
-
-    vec_gen_3(INDEX_op_x86_packus_vec, type, MO_8,
-              tcgv_vec_arg(v0), tcgv_vec_arg(t1), tcgv_vec_arg(t2));
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t2);
+    tcg_gen_and_vec(MO_8, v0, v0, tcg_constant_vec(type, MO_8, mask));
 }
 
 static void expand_vec_sari(TCGType type, unsigned vece,
@@ -3821,7 +3792,7 @@ static void expand_vec_sari(TCGType type, unsigned vece,
 
     switch (vece) {
     case MO_8:
-        /* Unpack to W, shift, and repack, as in expand_vec_shi.  */
+        /* Unpack to 16-bit, shift, and repack.  */
         t1 = tcg_temp_new_vec(type);
         t2 = tcg_temp_new_vec(type);
         vec_gen_3(INDEX_op_x86_punpckl_vec, type, MO_8,
@@ -3874,12 +3845,7 @@ static void expand_vec_rotli(TCGType type, unsigned vece,
 {
     TCGv_vec t;
 
-    if (vece == MO_8) {
-        expand_vec_shi(type, vece, INDEX_op_rotli_vec, v0, v1, imm);
-        return;
-    }
-
-    if (have_avx512vbmi2) {
+    if (vece != MO_8 && have_avx512vbmi2) {
         vec_gen_4(INDEX_op_x86_vpshldi_vec, type, vece,
                   tcgv_vec_arg(v0), tcgv_vec_arg(v1), tcgv_vec_arg(v1), imm);
         return;
@@ -4155,10 +4121,11 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 
     switch (opc) {
     case INDEX_op_shli_vec:
-    case INDEX_op_shri_vec:
-        expand_vec_shi(type, vece, opc, v0, v1, a2);
+        expand_vec_shi(type, vece, false, v0, v1, a2);
+        break;
+    case INDEX_op_shri_vec:
+        expand_vec_shi(type, vece, true, v0, v1, a2);
         break;
-
     case INDEX_op_sari_vec:
         expand_vec_sari(type, vece, v0, v1, a2);
         break;
-- 
2.34.1


