Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481ABE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XW-0007DY-AC; Fri, 13 Dec 2024 12:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X7-0006zp-EB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X5-0001WR-LF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:57 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361a50e337so14505035e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111174; x=1734715974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PYN5citoB0ZF3IJroQ8ZdrrceU/Nk4XKS8mCIww2hmM=;
 b=Px7eehZs/njKPA+3nFtv7joWN7QZeBy+SAY0NVwzX9TTUyWhMIw8SuwCBsQKboLIF2
 XWmWH0NPWo2kIxCiSN5hXmyKh9fo20pCaW9SvvssSU30G7uZD+eifn09IIO9yi1ao5Sy
 pMciNShmskSkdeL1NShun6swb0lC42VPQKr7qVV8f23dw2HACLrLxDXnBuzq0wVcwUZW
 DoTt7tm4LMOTTIC+/aulsHhm0dw76wjI1uxjDX69mJcEmKO4tDEr3gDgqcSkNCce6HMZ
 KyGV/U1qkpACYbU1EeOUETkdL30OuCPk+Yl5p1VsXoIN7wMmDM9PIq0Q3zz3p5JIg3J5
 pU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111174; x=1734715974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYN5citoB0ZF3IJroQ8ZdrrceU/Nk4XKS8mCIww2hmM=;
 b=rqgbIYrO39G7DMJnGulVSG3q17jDfTPHI+McMLdllu2AzgUl8W9OYZJuI03cQF8ciV
 YJ3mrM7Us41PFnYuoiWMpv332fEZv/c6KDfzA5xjx1tg/hQwWkXuvfSB1A1vRzVrkdSB
 vdZBgs/EL/+OsefK90QNr2cKm5H7MbApoiClFkgV6K48mM8Z9JUEJ4mgGHaxw12/HgdG
 Tsr9mkiMfnfhPaDbcVll70JaeG6VEe5yCYOJacVDM8ASnSeTVJY2Sq5vORqAnM9biKBs
 YqCjmAcvsZaQA260ofCwggtcYhm/0yo76MeycORPh6HR0ZIFoy2q8QMiiciQE9L3WB9b
 QA8Q==
X-Gm-Message-State: AOJu0YzsV7pidvxuVKef4Lu3zun07ms82X90FQNuCSOm6BHQ5sddut11
 J6mWPkqhiDTm8VnG5b6vcuW2QLCx3JsiBPGB8T9iPn98+srlZShrNNcydcd8x4RtgosoKxKNhEY
 g
X-Gm-Gg: ASbGncvjdQN4md3TLEfMajFXNAK+6Z9O2kEx6R0QtYtKPfRBnj5hOqaLKqEon1lu/BO
 12V9Acii3MFN7tJeaUE5aihzhgdmsUPnw42aHwp4UxQTsdN+SQ49u8Iq6ZXW6mfUb2jWgO3BaSp
 VdjPh+rXFdBQ63fH0Cmb/TZB3FLkDbopEuAR1Cj63zVJeD2DxakENyeFt+LRpbMaqCE3EIQbQfc
 nemuKNgPgp0+RDXSNqpBNvTMiqgpxW2K//9WlHNGMnzrkPG9LlaUdlitUkWSA==
X-Google-Smtp-Source: AGHT+IGrzL7VNJEbPAbsPV75NG2duj+JG/PBHFCEuWXeNIUDOQFzWscVmZtYh1ZsEUI3bAn1VWsuqg==
X-Received: by 2002:a05:600c:511c:b0:434:a7e3:db66 with SMTP id
 5b1f17b1804b1-4362aaa9683mr23756105e9.26.1734111174017; 
 Fri, 13 Dec 2024 09:32:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/85] target/arm: Introduce fp_access_check_vector_hsd
Date: Fri, 13 Dec 2024 17:31:25 +0000
Message-Id: <20241213173229.3308926-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Provide a simple way to check for float64, float32, and float16
support vs vector width, as well as the fpu enabled.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-22-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 135 +++++++++++++--------------------
 1 file changed, 54 insertions(+), 81 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 4e47b8a8041..4611ae4ade9 100644
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
2.34.1


