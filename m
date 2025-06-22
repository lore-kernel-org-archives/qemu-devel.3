Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8CBC7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 21:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTSLR-0007SZ-RZ; Sun, 22 Jun 2025 17:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLM-0007RU-PW
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTSLL-00059E-7i
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 17:35:16 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-748f54dfa5fso2397143b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Jun 2025 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750628112; x=1751232912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BENvMcJ/CrRAcx3dIG/qU4Ltg1Ex80eRTSFUmTUQVxM=;
 b=snn7Z2HKO2RK7aWRvO3ThQ2eGH/Od6yt25U3RJCL5pT44dhoTEJ17ia54ZIUIOmSbY
 3wiPZzMBishCIkA6t5LasVrV4QUBrasVOfPexCeB/L7s9IuZPaJQLhM8E/ipyj2x5rfO
 jvocc3n6eZu9BVM4hmtLtAl0A7jM7RClvhz21kALvmppGVXa4QEahKhn2NdG2QAhODjb
 FU4zKb/vTN86VbT4uaX/5cu8uGroVqlKTE3Zspo3J3fh1tYIb3m8EnbPWAOj641Gb6wa
 +51JRvk1At5NwfrojaUxT0DCuFF0Wbqwcyo6KWKJFkXMuDhPCJS7Os9aILficliUzb9X
 8SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750628112; x=1751232912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BENvMcJ/CrRAcx3dIG/qU4Ltg1Ex80eRTSFUmTUQVxM=;
 b=E7jB8neyvgevtDEecuX9JHK6eTmmDlmm1NB0o7c7kk3RNsfjAKgLt/yn2pt/oTqOzG
 xl/jDKE798yBsZqgga9m0ADW4W9TdkNXsRwJIOkqAxr0YWgogjE7fzEsWVefbiQo2BXx
 jNnpjrVTWTkIzmbMY18YfcovXqwy3K98HSRxSvLJtDzh64oFIl1kSKQm2XEXlh4ODC/w
 nwGEyvQ8bt1M5IKCqMPZGyBx5hMh7MMtO314/RSEw/+A+pYnTRpZXd92oLpJL1fFRDbR
 93nkgxh2WmYEP3B6TWNd5WHJOc99VfI0QFbpTMzaeXoZzovdfmVts4uxJ5uqs9gmYbwY
 Vgig==
X-Gm-Message-State: AOJu0YxXPTp13bmLlsIYpgDNH8u0cm6r1STFLpqZ8Eo7QV6Uk1iYr9sS
 cZO8IQXXPYy19VWMS6sMbZ8S3axM59dPwWGWfdqtfXILVAZyii7IsnW+F/iR5JyAamAiRXPQVYF
 wg9Sq5+U=
X-Gm-Gg: ASbGnct9TS+nDjh2PRbjdtQZwvbpw2awGmzTIo8ojom0SU0OZk5T5QXgFfxQoTuoHqi
 o6QiLi5cHMae5OwakuXxphUKgs8b7kS5PvGZ57rK9oayF9K2mz1/8Jr4qeBbfs2VKkHgLS0xJnV
 qNP9l4ujTq+BmzsOu7JNKjagBs4hYrkO7xkEimmXlblUTSsymdg+tsTqjJ4Jvu+bUzaQOI09E70
 X8jPgvSK8p1JcdJhQf5T8L642OLfMGAcYHpi8k1MsiHhgdmaxchNbVx9HPg6V+VBc2fIW9dlYaf
 JOEZT3kmaYXkS0FKb4TbmoiX3y132XK64W0uaWDVkMGGnodS9Ftd/i6YeAG0SYb7zvrlXkEheHH
 nQwIdM3tezXdWDQ2DYH+P
X-Google-Smtp-Source: AGHT+IFu5DeUwoY0lxd4ROH38wfdULG5gOmq4L48NevPVf02WfCNdHI6cLo03xsyZHRw4H9+lxYUhQ==
X-Received: by 2002:a05:6a00:4b56:b0:748:e1e4:71ec with SMTP id
 d2e1a72fcca58-7490da69762mr15236322b3a.12.1750628112419; 
 Sun, 22 Jun 2025 14:35:12 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a69f3e2sm6479842b3a.159.2025.06.22.14.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Jun 2025 14:35:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH v2 3/3] target/arm: Fix 128-bit element ZIP, UZP, TRN
Date: Sun, 22 Jun 2025 14:35:09 -0700
Message-ID: <20250622213509.277798-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250622213509.277798-1-richard.henderson@linaro.org>
References: <20250622213509.277798-1-richard.henderson@linaro.org>
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

We missed the instructions UDEF when the vector size is too small.
We missed marking the instructions non-streaming with SME.

Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 43 ++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f3cf028cb9..588a5b006b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2352,6 +2352,23 @@ TRANS_FEAT(PUNPKHI, aa64_sve, do_perm_pred2, a, 1, gen_helper_sve_punpk_p)
  *** SVE Permute - Interleaving Group
  */
 
+static bool do_interleave_q(DisasContext *s, gen_helper_gvec_3 *fn,
+                            arg_rrr_esz *a, int data)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        if (vsz < 32) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                               vec_full_reg_offset(s, a->rn),
+                               vec_full_reg_offset(s, a->rm),
+                               vsz, vsz, data, fn);
+        }
+    }
+    return true;
+}
+
 static gen_helper_gvec_3 * const zip_fns[4] = {
     gen_helper_sve_zip_b, gen_helper_sve_zip_h,
     gen_helper_sve_zip_s, gen_helper_sve_zip_d,
@@ -2361,11 +2378,11 @@ TRANS_FEAT(ZIP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(ZIP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            zip_fns[a->esz], a, vec_full_reg_size(s) / 2)
 
-TRANS_FEAT(ZIP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a, 0)
-TRANS_FEAT(ZIP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a,
-           QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
+TRANS_FEAT_NONSTREAMING(ZIP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a, 0)
+TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a,
+                        QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
 
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
@@ -2377,10 +2394,10 @@ TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(UZP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 0)
-TRANS_FEAT(UZP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 16)
+TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 0)
+TRANS_FEAT_NONSTREAMING(UZP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 16)
 
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
@@ -2392,10 +2409,10 @@ TRANS_FEAT(TRN1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(TRN2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            trn_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(TRN1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 0)
-TRANS_FEAT(TRN2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 16)
+TRANS_FEAT_NONSTREAMING(TRN1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 0)
+TRANS_FEAT_NONSTREAMING(TRN2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 16)
 
 /*
  *** SVE Permute Vector - Predicated Group
-- 
2.43.0


