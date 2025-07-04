Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A209EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjES-0000bg-IJ; Fri, 04 Jul 2025 12:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEP-0000Wj-Vw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:46 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEN-0006GM-W6
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a510432236so784101f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646342; x=1752251142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e30X65M6p/rIEXX5wYUb7OTjH5Oe5kdo7kocx6ruKt0=;
 b=D0bJoQo5RSVnLVL6JXXJhUMnZgMUMYZBA8VNibREjEw5gyfmZ4Oz3KcnBpL91aJOW3
 UqZOyXQzWflaqs9fTWeSnEmDdaAvGbiJfdOUjLgSKWjxBwKMsoj9CTJXr11zQJValQg2
 pWqLEmuQw9/A0iMrkE2en9EGr3cf1wNVVI+pHrY0HQeiyx46kJbOxZ2+q8T7lKt470Gu
 rN1YaUCuf5Bhegu1+6uYBXjXSj56qk7Hn2haOsOu2eI2xMD9aGewkTWWK3WavYNr0jTi
 5LIke7En0KXxmqApqb/VtsUecolfcEeMcVOEpft3LhJmO3l1u4I3PC1YlBf0t6u1Dooz
 jvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646342; x=1752251142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e30X65M6p/rIEXX5wYUb7OTjH5Oe5kdo7kocx6ruKt0=;
 b=vL2eg/ZFts4vKUtqbiMnZGUN5B3vQ0GO7zheT+hJ6h3+wZvZY4fqMQx+uhDKkYwXhr
 Mvj4IxYyAKRzamAvFW5sfmNnuTsGDMUM3U/zt+3NZ9LopW1U6fCKyNwwnpJkM6UmY/Hy
 q6Pd+DkCWHkiclsF9meRGlZZ4qTkjzPAHo4jm7Jg0gOBL7G2126t9IVVE9KN/uWuRWph
 XaM7VjDALyPCMo+A1OahIplm8KivQFXkXgLZ21y3MyqUvOPfKId8j2eKdgm/nHjtp0li
 xiBxaQwBdusZdnMb5nBzDakqC/ezYCZzV23SblJNm2RHuQCzd3I6KOkAUA6MfxYak56u
 myiQ==
X-Gm-Message-State: AOJu0YzA8Blkl+lfYksYSn9qBnir9RfFsdW2mrbZs7UK8rlcOkckNG15
 OeBagmzSs4vNtaOnK0tZm4SYAhlfV59p2NFo3aiVMfh9+yTDGZkPC5dfJgLdJ+ed/jj7QwVGJv1
 UOJMk
X-Gm-Gg: ASbGncskSg4jXqhLU8uMcRifMrf8d9agn/5MkQljZhhCzusOAFmIo7mLUJGikwhlQGz
 5qsgS8R7gSXre3FIldWMAReRWYwHsMH/1FAXf0x5jH10agTNc1wF3G58YxJlJUce2mpPWUi9VHk
 5V1T8Dca5oSk3j70lhNec9RoUm3cvFEsEn4XIz9ziC2VJL4/ZDXwWcKopsLoETTdd3qFiMPKIMo
 bfjXqI7F54SzcX0i7ccM6ry3gZgHMWCJt5IWwl0ooM/Uv6tlg+Ua5hTrLMDQ4gOksAFkSpaOsc0
 RqnDChoZPaeh47zPyK6oxCDuSngI0VJIjlZRXP2HRqrXLygt972ik6W6QPlfnjZEMB3L
X-Google-Smtp-Source: AGHT+IGSRd70sM3XgjQD1nZei+IwrbLAXGgvazH/Njl/2tCzBdeRLvcYLzv9dcD3kw8nu1QH4AWZwQ==
X-Received: by 2002:a5d:5f8f:0:b0:3a4:ec32:e4f3 with SMTP id
 ffacd0b85a97d-3b4970131eamr2708221f8f.17.1751646342303; 
 Fri, 04 Jul 2025 09:25:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 043/119] target/arm: Implement SME2 Multiple Vectors SVE
 Destructive
Date: Fri,  4 Jul 2025 17:23:43 +0100
Message-ID: <20250704162501.249138-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 36 +++++++++++++++++++
 target/arm/tcg/translate-sme.c | 65 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 005f87777b8..470592f4c09 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -209,3 +209,39 @@ ADD_n1         1100000 1 .. 10 .... 1010.0 11000 .... 0    @z2z_4x1
 
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_2x1
 SQDMULH_n1     1100000 1 .. 10 .... 1010.1 00000 .... 0    @z2z_4x1
+
+### SME2 Multi-vector Multiple Vectors SVE Destructive
+
+%zm_ax2         17:4 !function=times_2
+%zm_ax4         18:3 !function=times_4
+
+@z2z_2x2        ....... . esz:2 . ....0 ....0. ..... .... . \
+                &z2z_en n=2 zdn=%zd_ax2 zm=%zm_ax2
+@z2z_4x4        ....... . esz:2 . ...00 ....1. ..... ...0 . \
+                &z2z_en n=4 zdn=%zd_ax4 zm=%zm_ax4
+
+SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_2x2
+SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_4x4
+UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_2x2
+UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_4x4
+SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_2x2
+SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_4x4
+UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_2x2
+UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_4x4
+
+FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
+FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
+FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
+FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
+FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
+FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
+FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
+FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+
+SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_2x2
+SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_4x4
+URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_2x2
+URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
+
+SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
+SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 954da18ff0d..0a6a10b63d1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -604,6 +604,37 @@ TRANS_FEAT(SRSHL_n1, aa64_sme2, do_z2z_n1, a, gen_sme2_srshl)
 TRANS_FEAT(URSHL_n1, aa64_sme2, do_z2z_n1, a, gen_sme2_urshl)
 TRANS_FEAT(SQDMULH_n1, aa64_sme2, do_z2z_n1, a, gen_gvec_sve2_sqdmulh)
 
+static bool do_z2z_nn(DisasContext *s, arg_z2z_en *a, GVecGen3Fn *fn)
+{
+    int esz, dn, dm, vsz, n;
+
+    if (!sme_sm_enabled_check(s)) {
+        return true;
+    }
+
+    esz = a->esz;
+    n = a->n;
+    dn = a->zdn;
+    dm = a->zm;
+    vsz = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, dn + i);
+        int mofs = vec_full_reg_offset(s, dm + i);
+
+        fn(esz, dofs, dofs, mofs, vsz, vsz);
+    }
+    return true;
+}
+
+TRANS_FEAT(SMAX_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_smax)
+TRANS_FEAT(SMIN_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_smin)
+TRANS_FEAT(UMAX_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_umax)
+TRANS_FEAT(UMIN_nn, aa64_sme2, do_z2z_nn, a, tcg_gen_gvec_umin)
+TRANS_FEAT(SRSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_srshl)
+TRANS_FEAT(URSHL_nn, aa64_sme2, do_z2z_nn, a, gen_sme2_urshl)
+TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_z2z_nn, a, gen_gvec_sve2_sqdmulh)
+
 static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
@@ -641,6 +672,36 @@ static bool do_z2z_n1_fpst(DisasContext *s, arg_z2z_en *a,
     return true;
 }
 
+static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
+                           gen_helper_gvec_3_ptr * const fns[4])
+{
+    int esz = a->esz, n, dn, dm, vsz;
+    gen_helper_gvec_3_ptr *fn;
+    TCGv_ptr fpst;
+
+    if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
+        return false;
+    }
+    if (!sme_sm_enabled_check(s)) {
+        return true;
+    }
+
+    fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    fn = fns[esz];
+    n = a->n;
+    dn = a->zdn;
+    dm = a->zm;
+    vsz = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; i++) {
+        int dofs = vec_full_reg_offset(s, dn + i);
+        int mofs = vec_full_reg_offset(s, dm + i);
+
+        tcg_gen_gvec_3_ptr(dofs, dofs, mofs, fpst, vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
 static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
     { gen_helper_gvec_fmax_b16,
       gen_helper_gvec_fmax_h,
@@ -652,6 +713,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
       gen_helper_gvec_ah_fmax_d },
 };
 TRANS_FEAT(FMAX_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
     { gen_helper_gvec_fmin_b16,
@@ -664,6 +726,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
       gen_helper_gvec_ah_fmin_d },
 };
 TRANS_FEAT(FMIN_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_b16,
@@ -672,6 +735,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
     gen_helper_gvec_fmaxnum_d,
 };
 TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_b16,
@@ -680,3 +744,4 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
     gen_helper_gvec_fminnum_d,
 };
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
+TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
-- 
2.43.0


