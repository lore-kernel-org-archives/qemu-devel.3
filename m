Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9159BE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPe0-0008AY-3K; Wed, 11 Dec 2024 11:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdA-00059Y-KM
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:14 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPd6-0001Lw-I5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:06 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46677ef6910so61747821cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934723; x=1734539523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlPqq3SkO/OL532CbnGb++BEeuAMvtHyeW45jNWCD1U=;
 b=heck10/n1Iry1Ls2o43bwN80LJXnH1c/+mPEvFr4jDX5acLLU9As6KOk991nLmToY2
 C9QEg19In0V3fytKEC3Df0xMLVInazsVtreVYw5/fE4z7ZiDSzbed0yfDPK9wkF/FRMx
 k1T4rrVuYmmbjIJhpASJ8UMVDkId3kSnr7XQj244AC/Q6ZZ3FIpsSDqcE6nX0P6x0I8Y
 gbtair6v2VoB7+hm4cHDUidTGuBxsZKNbxa48oB6gmwLamp9SH3Ow+CqAEy74EiDxi5P
 vBSZYNgfSigk21MhEMX5zAfbRsdabaI5jqMu/PmTaPV/lh+fM8HMJifGDXz94vzfEXtg
 PgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934723; x=1734539523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlPqq3SkO/OL532CbnGb++BEeuAMvtHyeW45jNWCD1U=;
 b=WQvxTmcUByWig4ovBpA7NpKNoXUvU7JE+Sh8cmCIYmB+lA6kRr7DvR/qSKO3yQxGNJ
 DhF56+Agd0NtuECFlaxB/NgKw6P4wNtuppJtLQLTmO7Iq8fClysDEYlB5Y4I18chZvA6
 gR8FV7FkburuNamCSW5oq/gkvL5z50/NNpQhlgoSennFX6lMXidGHKHi7shQw1cPlapM
 pFP1y9oWv6hl8sJRss5BzZdBEpCzNAM3nVIw8cw9u3TTmY/26PyaRuPyrpUsEIIM7Ap0
 i5zpIeZzTgRasb1gBWphToK7HjZ21Kp5/q2Ueliv5VgABAgIFTsfIk851uzQG9nFAJgl
 InIg==
X-Gm-Message-State: AOJu0YwwrccN1MN8tsDGFRLl9MX0lLwm11jFo4zbnSQT5jERAEivqU21
 JKjGFR4bOl0jH/D/nJF5w2SfactmyMqQvE1i/mFk6CXJJrs8GGe8Hbl6xIub/2NhT2dJ9FdWluf
 ZEGMm7zLG
X-Gm-Gg: ASbGncv2zc8VrkLJUy27y+E0sKQZu5MdcPfpIPiJ02MhpTPh/qwQwLnlXoUXUjDnobk
 LCCuLlf08Y/aOd/t/qMOgY1gltbQWX/qkteUvBj255oXeOKH9fwvNwiqGqFvfdtAlWhxKEblV2S
 sOPf2rlhoVJ1E7oJMdC9XTYPVkExu33gWC1LC/rjso1q9pMau5bQV5ko1clQsf04sDuEoBqPxGN
 puUAoRaP6cgqsdOfiBSX7vYT3hRlVC1Epo2u0P0ODH8IGkIQT+0o4kUviGP2g==
X-Google-Smtp-Source: AGHT+IF5rTMtIdjW3H9s98Td43Gk6vezxDMGIyl7SmRNvdaHpNdV4JQ0vhL0/O5OdoKcClzNTIBaWA==
X-Received: by 2002:a05:622a:1f13:b0:467:45b7:c49f with SMTP id
 d75a77b69052e-4678936e119mr70651751cf.40.1733934723555; 
 Wed, 11 Dec 2024 08:32:03 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 21/69] target/arm: Introduce fp_access_check_vector_hsd
Date: Wed, 11 Dec 2024 10:29:48 -0600
Message-ID: <20241211163036.2297116-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82a.google.com
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

Provide a simple way to check for float64, float32, and float16
support vs vector width, as well as the fpu enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 135 +++++++++++++--------------------
 1 file changed, 54 insertions(+), 81 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4e47b8a804..4611ae4ade 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1260,6 +1260,28 @@ static int fp_access_check_scalar_hsd(DisasContext *s, MemOp esz)
     return fp_access_check(s);
 }
 
+/* Likewise, but vector MO_64 must have two elements. */
+static int fp_access_check_vector_hsd(DisasContext *s, bool is_q, MemOp esz)
+{
+    switch (esz) {
+    case MO_64:
+        if (!is_q) {
+            return -1;
+        }
+        break;
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return -1;
+        }
+        break;
+    default:
+        return -1;
+    }
+    return fp_access_check(s);
+}
+
 /*
  * Check that SVE access is enabled.  If it is, return true.
  * If not, emit code to generate an appropriate exception and return false.
@@ -5420,27 +5442,14 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
     MemOp esz = a->esz;
+    int check = fp_access_check_vector_hsd(s, a->q, esz);
 
-    switch (esz) {
-    case MO_64:
-        if (!a->q) {
-            return false;
-        }
-        break;
-    case MO_32:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        return false;
-    }
-    if (fp_access_check(s)) {
-        gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                          esz == MO_16, data, fns[esz - 1]);
+    if (check <= 0) {
+        return check == 0;
     }
+
+    gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
+                      esz == MO_16, data, fns[esz - 1]);
     return true;
 }
 
@@ -5768,34 +5777,24 @@ TRANS_FEAT(FCADD_270, aa64_fcma, do_fp3_vector, a, 1, f_vector_fcadd)
 
 static bool trans_FCMLA_v(DisasContext *s, arg_FCMLA_v *a)
 {
-    gen_helper_gvec_4_ptr *fn;
+    static gen_helper_gvec_4_ptr * const fn[] = {
+        [MO_16] = gen_helper_gvec_fcmlah,
+        [MO_32] = gen_helper_gvec_fcmlas,
+        [MO_64] = gen_helper_gvec_fcmlad,
+    };
+    int check;
 
     if (!dc_isar_feature(aa64_fcma, s)) {
         return false;
     }
-    switch (a->esz) {
-    case MO_64:
-        if (!a->q) {
-            return false;
-        }
-        fn = gen_helper_gvec_fcmlad;
-        break;
-    case MO_32:
-        fn = gen_helper_gvec_fcmlas;
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        fn = gen_helper_gvec_fcmlah;
-        break;
-    default:
-        return false;
-    }
-    if (fp_access_check(s)) {
-        gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          a->esz == MO_16, a->rot, fn);
+
+    check = fp_access_check_vector_hsd(s, a->q, a->esz);
+    if (check <= 0) {
+        return check == 0;
     }
+
+    gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                      a->esz == MO_16, a->rot, fn[a->esz]);
     return true;
 }
 
@@ -6337,27 +6336,14 @@ static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                               gen_helper_gvec_3_ptr * const fns[3])
 {
     MemOp esz = a->esz;
+    int check = fp_access_check_vector_hsd(s, a->q, esz);
 
-    switch (esz) {
-    case MO_64:
-        if (!a->q) {
-            return false;
-        }
-        break;
-    case MO_32:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    if (fp_access_check(s)) {
-        gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                          esz == MO_16, a->idx, fns[esz - 1]);
+    if (check <= 0) {
+        return check == 0;
     }
+
+    gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
+                      esz == MO_16, a->idx, fns[esz - 1]);
     return true;
 }
 
@@ -6383,28 +6369,15 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
         gen_helper_gvec_fmla_idx_d,
     };
     MemOp esz = a->esz;
+    int check = fp_access_check_vector_hsd(s, a->q, esz);
 
-    switch (esz) {
-    case MO_64:
-        if (!a->q) {
-            return false;
-        }
-        break;
-    case MO_32:
-        break;
-    case MO_16:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            return false;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-    if (fp_access_check(s)) {
-        gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
-                          esz == MO_16, (a->idx << 1) | neg,
-                          fns[esz - 1]);
+    if (check <= 0) {
+        return check == 0;
     }
+
+    gen_gvec_op4_fpst(s, a->q, a->rd, a->rn, a->rm, a->rd,
+                      esz == MO_16, (a->idx << 1) | neg,
+                      fns[esz - 1]);
     return true;
 }
 
-- 
2.43.0


