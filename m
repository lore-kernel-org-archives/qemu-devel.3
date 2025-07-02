Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55124C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwU3-0004vu-Cn; Wed, 02 Jul 2025 08:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTy-0004sV-Ew
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:34 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwTo-0007Cp-4D
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:22:33 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2e9071e3706so2767477fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751458939; x=1752063739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BENvMcJ/CrRAcx3dIG/qU4Ltg1Ex80eRTSFUmTUQVxM=;
 b=p8uqF8zutcnyMIQFGaYatKxrsycpjtXhcZk9Ao+uVUqxx3IRq1mLNMVR2tJq6uOb6C
 DAcenoA+T1rdNRZyCjsMmm7MCG3BTHcxh9cuNByYrzGqwHmnW0du/5Yi1LBw2mNYmVFd
 2yHqr/glpY7iWWFSNsK4fqcudzrP9+xN4stqLZWLp0vyfBS1LzD/IetpTeygtJzzYb/S
 9MYGx7E9BQLRiKBtU5Kf4pGzTHAIvRiVPAjVwbj9Qm+0DGziOKgu56hUDkOQomOAVK7e
 J/IiY6TlkcFZV7imzZj44BzYoLO+QGX2jrq400Wf2p/Ac7TdN6P03EdCoIY+PpMKWxcj
 IonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751458939; x=1752063739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BENvMcJ/CrRAcx3dIG/qU4Ltg1Ex80eRTSFUmTUQVxM=;
 b=hnworLWNpaIN1Cs4bUjb08JFAd6fSnZV0ZQ1ykrW0v/YfwEj1tSNw4DceuOdVS3zrS
 vy2Hbi89OF4nWF+C0TOMaydQmzoTPWstaEFMydQGrwBKV0QrElbdODKFk6Qc3zA32uIn
 KmP+qbv8rvUauPT8p+zyjPZOAzckKTyA7DSJvwfXqxNo/pGcZDsME7is4YOD03/o1CZE
 KJvUW7kqeop77FAaXJjoELtu1Hbc2F4M7AhkYGrt373oiwB0fV5X72IsS37nat3SUCIt
 oMKL5+MbYUJekLvOF+CKHOux7lHt8wKSvWy/VLByp+GO14thGng4CnshDSRPVdkCnI7y
 qC+Q==
X-Gm-Message-State: AOJu0YzvWXvik7FYG1KDhmZX2IIhqLM1tLw59L4Vd4x/IdwdGpkKFiVo
 p2XGV0LoDTVnEc1/IM9A0IDbw4gMe/rQ12eOrw++PEU060dYkebHFWFf3Px5Qah8oSsKYD/aT8J
 ec0Fd/IQ=
X-Gm-Gg: ASbGnctYClGwVJtnKfYaZ9KWtL9IloQ913QCOwasTC+A7/l9uo11DTK0yHJqGTDcq8N
 czkCl4AEc49UwZ5jysKMpVY5AgT57xp43gHLxkYgDj0jpv16+BNzY97GA0HctgUTP/nBV7dDB0/
 cXng4D+TvFseb6jzC6njrAJ2Ca7K3hJGBQO9zPVgtd6/kptGZ4ypV+utBruyFlYqEd2dy9nl3R0
 JSO2Yb+/8j1gbXb+Efqzw0EeMiMyT/pEOYr2APghO1Owh2aXoiMwz6tqT+yWuNOGNJBWD0hMtvY
 vpFi/3bRsIiWmyYr+C8rZilC2B6RQKnPuuiuobBu4iwXaz1ii14jODHJXZVDB4OF1PeDeQ==
X-Google-Smtp-Source: AGHT+IHfAP1st1cHfz8zrrkAdw8e8FGvPXkMnFGZ18bfqlsdY9tZv/oqLmHjgCxcNXnHsP4dZ5g8yA==
X-Received: by 2002:a05:6870:6e0f:b0:2cc:4613:76f0 with SMTP id
 586e51a60fabf-2f5a8a937abmr1683049fac.17.1751458939317; 
 Wed, 02 Jul 2025 05:22:19 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1bd3sm3785013fac.28.2025.07.02.05.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:22:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 03/10] target/arm: Fix 128-bit element ZIP, UZP, TRN
Date: Wed,  2 Jul 2025 06:22:06 -0600
Message-ID: <20250702122213.758588-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702122213.758588-1-richard.henderson@linaro.org>
References: <20250702122213.758588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


