Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A07D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWz-0001TK-PL; Sun, 01 Dec 2024 10:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWu-0001Ow-LL
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:36 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWs-0004Fk-Ui
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:36 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71d502644e2so1418868a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065594; x=1733670394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=idkRc83+8k6kQAE/UEu1d/YkVql+qpZ6btFzhSMVuCI=;
 b=S9x1/0bd9mzsmKYqIM0c8vfsNC1u+S3+LlnhWgN6dEEEV4yTaY/09mRj+jXOzaniDm
 Bx+7hfNa3sK69erVbRGHVDsSoDMx7R670TXw4s01TghzBdruook6qBdY0VfvMd6VfI/U
 XXY+3mEsewQbScp3KLi3/ln8wrbkswEKXDkW2HPPLTp/DUEKb1YEdy9UXLXheZPresQd
 1E98i10lmI0VYcVL2KvnUdcmcLQXCIfGyVZw1h2SkMBIZtegtkTTJ+4hX0hn6kYUEd1H
 Qozy6PAo4sFnjO7tYMXHa1r3ICjZYcXP2Vdj06g/X2j1kh7hBatOXSzVatM3a5x+AzdU
 WaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065594; x=1733670394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=idkRc83+8k6kQAE/UEu1d/YkVql+qpZ6btFzhSMVuCI=;
 b=jDXBcs/IRpm8QftO/gN92GqP6LTDelhuI4Iy/QRENm72iW8HS9RiL0kMtdATlnSSvq
 39omt+XqLtluoFEb8TtCETLqHGWIiQuXdjY9Z4nxA+btAB8J34ZQ4nF+qBlclwEusS6J
 UhylciB4L58xHjvplRDXhbR7Au2cUEbfFuUXMPuEmfUysRKlxSZo4VOEkkn3PTAxIObi
 DNV1h8GU0559ctBNBW+/LZy3minrRdrxuSffN0XPjWs4uB4KaCWbVbP2wdHLpjwXq8gG
 gI6SKuldZz7Wk1raB79sS6EZJUaa/khFscAKihHth7lTBL3n+J3GzAkVmqOeXaOgEr1r
 KHcA==
X-Gm-Message-State: AOJu0YyAH1owPxXvvkpu5OWQz9gBNpnY6dtBzjvAqL5yIxjbF5l6KNUm
 q6TzyI8Gmtna/fCo4Wv6/wzuNc0U62Cm3oDmeUnRLA4cDO77RoHseuhAkp7tuGWWAj+HPnMyRSr
 1PhE=
X-Gm-Gg: ASbGncsXWCmCRdImnj8hR2DRgr6ZWenE6PBZg39NLMjQFlm46PzzLt2cJGt7C9Qi8v/
 wXXS9qNuuKJnA2lTsbcAgZjS94sjjlJ2Z/IHIN7Roa5Q1RD3DSdny/vWGjqaBfoFmPZ+DsMByoH
 /ky23ECYlHcF45TxgPPE+Rf9Nqwohj7qeuYKd/fO+ycJTE12IoLeWtscH0dA+fj+DiJUUCeBn3e
 UV7IDXwaB0G8fYk2ackcZork2tO6r3lQZv6pvx5fUup97EANsBwKQDWCe3bV1CsmBZDNwxxn1M7
 k4RS56jGF7uBvNlsT+RhD89lJq56KHiSWXe8
X-Google-Smtp-Source: AGHT+IE9eWFstbQlGWP89F3dvfiHBr6HoitI4xsQapd+TdgbcWX2q5dsEXitD6fyMXUpSZn9n/bHbg==
X-Received: by 2002:a05:6830:4982:b0:71d:5a8a:1a29 with SMTP id
 46e09a7af769-71d65cb2cc0mr14825248a34.14.1733065593785; 
 Sun, 01 Dec 2024 07:06:33 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/67] target/arm: Introduce fp_access_check_vector_hsd
Date: Sun,  1 Dec 2024 09:05:20 -0600
Message-ID: <20241201150607.12812-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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


