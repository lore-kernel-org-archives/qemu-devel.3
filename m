Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1B1C44512
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 17:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlVds-0000jL-KR; Sun, 19 Jul 2026 13:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVdg-0000f8-Ko
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:21 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wlVde-0003Ct-G1
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 13:49:20 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so7165664a91.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 10:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784483357; x=1785088157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvW7Iez6tG/67Zny7+UcsdudFSnXZ/jiURiYfWzXAXY=;
 b=VOZo9Op10ml/id2BLiVcz2akjkEAip5L2x/O7QTal9m6tv17/jOb6azyUVlinjjzGZ
 39NqohSZTz6GpKFvpPhGMWGSBFSWRPAoXEWWB7eb/oJ4j4VhPA5QeDdQ3oq04cghSgoF
 GlQwotuH6tgj8SIT+Ni6lHXoCWCFNHxv+6M2Oq29yFesP5rRjzOOKcdKY2/TTy0Q2ERA
 F17ju/5pscAeyjvOxymkghCGg2YYebv287i/i6OAqBAOc6BkUNwk3VlOy/tGQdMp8Ou+
 ZLPWQe9OwJK8fDGFI/MdUKEzrT7pdn2yvp5/8ZyPUOA5Z1nYxzXYihD5BJwgRVD4Z5c9
 baSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784483357; x=1785088157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DvW7Iez6tG/67Zny7+UcsdudFSnXZ/jiURiYfWzXAXY=;
 b=SPWqvJy2MBDTmeoza5UYv6+vRHE/FcfIHKM8RlAO5PS98cYNkEaJY8DKal87XFo+I+
 Rha3I+W44D8KOZgMDvHqZ1zly+JjPdrcmhJwNIQwyWEWApjJhHfATpwdLUVwb3azCtjN
 zcwC3MO/ZQuJPVN4lz/Jft4iQjCxvJOgHRrOg1YUcSpn0sd1U2BQX1K+pFQ11/fzAkYx
 fmWUPP+ZeotEwi9J5rfCVSMZj71LQPwFYgkSnNzZzZenSHauJqpy/rWHu4SiJip3Yuy0
 5xJpgHuP/quQYmRcng2qY0DWv+jfBgw0pAfuubMeSThJMzyop0wsiuxdpp9h7z3QNrYx
 5dYw==
X-Gm-Message-State: AOJu0YxKyM1MCQqVqZfGRqJsN0uFTNFL08mQilZGCzPvAPb92H8xTxYZ
 pyXOCWW8yZ0+1hWfqJeAtzitxuCARuM4uhmXsNJONHymDFwAY675gYcEf6wr1cJAWM496MyFLzm
 UjGVH
X-Gm-Gg: AfdE7ckK0ro4mIM/eWVMj3cPnjsbjKwOc/XMB19JM9b1H3jMjP9v34BVSeVJzrK8yiH
 idfIWMaIps85wn3K2dASwgzSCeewKMLTq7CM1YGfMEYDoZdDexbkSsdSodfWK5hWfj1rEU9hZSi
 IYfIAux6UdwKb1UdbwgxAQQ6esmPtyo7t79lcx5ytP8DmPJgxtb7+K+VHzlwPgYeGkI2dYjlMcz
 Vimcf+k7GQr04qJl6wyJbeSCdTWqYJ39OhMwtxlJIrehfFrU02IIXA2q+BoRDSUGaQ3WvaGj9pC
 HeO5WJNPhZ8W8kVrLTnLjQlCmYqNBR8yG20P2oLR8jj2ss83GSQQziKK1yjp9MsAp4lx/smqNGW
 lJn06Ey4501D0aivgGZ5iJriVAvSE2caG8H0gcFxqSRfzqdwuKCQl4UuAy48tJuTnWxqqY/MC3R
 p8KnGVlF4=
X-Received: by 2002:a05:6a21:4a81:b0:3c3:8298:da0c with SMTP id
 adf61e73a8af0-3c3ad972c12mr12418044637.41.1784483356748; 
 Sun, 19 Jul 2026 10:49:16 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a20c158sm30471881eec.29.2026.07.19.10.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 10:49:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 4/6] target/arm: Split decode of BFloat SME FMAX/FMIN
Date: Sun, 19 Jul 2026 10:49:03 -0700
Message-ID: <20260719174905.420725-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719174905.420725-1-richard.henderson@linaro.org>
References: <20260719174905.420725-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Split decode so that feature detection can be handled
external to do_zzz_{n1,nn}_fpst.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++
 target/arm/tcg/translate-sme.c | 61 +++++++++++++----------
 target/arm/tcg/sme.decode      | 90 ++++++++++++++++++++++++++++------
 3 files changed, 115 insertions(+), 41 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 280ead6f9c..e444397a47 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1743,6 +1743,11 @@ static inline bool isar_feature_aa64_sme2p2_or_sve2p2(const ARMISARegisters *id)
     return isar_feature_aa64_sme2p2(id) || isar_feature_aa64_sve2p2(id);
 }
 
+static inline bool isar_feature_aa64_sme2_sve_b16b16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sve_b16b16(id);
+}
+
 static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ca88b3cdcc..379764da24 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -747,20 +747,15 @@ TRANS_FEAT(URSHL_nn, aa64_sme2, do_zzz_nn, a, gen_sme2_urshl)
 TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_zzz_nn, a, gen_gvec_sve2_sqdmulh)
 
 static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
-                           gen_helper_gvec_3_ptr * const fns[4])
+                           gen_helper_gvec_3_ptr *fn)
 {
     int esz = a->esz, vsz, mofs;
     int overlap = -1;
-    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
     if (fn == NULL) {
         return false;
     }
-    /* These insns use MO_8 to encode BFloat16. */
-    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
@@ -786,18 +781,14 @@ static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
 }
 
 static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
-                           gen_helper_gvec_3_ptr * const fns[4])
+                           gen_helper_gvec_3_ptr *fn)
 {
     int esz = a->esz, vsz;
-    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
     if (fn == NULL) {
         return false;
     }
-    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
@@ -825,8 +816,14 @@ static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
       gen_helper_gvec_ah_fmax_s,
       gen_helper_gvec_ah_fmax_d },
 };
-TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
-TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(BFMAX_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           f_vector_fmax[s->fpcr_ah][0])
+TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a,
+           f_vector_fmax[s->fpcr_ah][a->esz])
+TRANS_FEAT(BFMAX_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           f_vector_fmax[s->fpcr_ah][0])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a,
+           f_vector_fmax[s->fpcr_ah][a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
     { gen_helper_gvec_fmin_b16,
@@ -838,26 +835,40 @@ static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
       gen_helper_gvec_ah_fmin_s,
       gen_helper_gvec_ah_fmin_d },
 };
-TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
-TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(BFMIN_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           f_vector_fmin[s->fpcr_ah][0])
+TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a,
+           f_vector_fmin[s->fpcr_ah][a->esz])
+TRANS_FEAT(BFMIN_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           f_vector_fmin[s->fpcr_ah][0])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a,
+           f_vector_fmin[s->fpcr_ah][a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
-    gen_helper_gvec_fmaxnum_b16,
+    NULL,
     gen_helper_gvec_fmaxnum_h,
     gen_helper_gvec_fmaxnum_s,
     gen_helper_gvec_fmaxnum_d,
 };
-TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm)
-TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(BFMAXNM_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fmaxnum_b16)
+TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm[a->esz])
+TRANS_FEAT(BFMAXNM_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fmaxnum_b16)
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
-    gen_helper_gvec_fminnum_b16,
+    NULL,
     gen_helper_gvec_fminnum_h,
     gen_helper_gvec_fminnum_s,
     gen_helper_gvec_fminnum_d,
 };
-TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm)
-TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm)
+TRANS_FEAT(BFMINNM_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fminnum_b16)
+TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm[a->esz])
+TRANS_FEAT(BFMINNM_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fminnum_b16)
+TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     NULL,
@@ -865,7 +876,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     gen_helper_gvec_famax_s,
     gen_helper_gvec_famax_d,
 };
-TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax)
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     NULL,
@@ -873,7 +884,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     gen_helper_gvec_famin_s,
     gen_helper_gvec_famin_d,
 };
-TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin)
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     NULL,
@@ -881,8 +892,8 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     gen_helper_gvec_fscale_s,
     gen_helper_gvec_fscale_d,
 };
-TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale)
-TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 36fbe24faf..e1bef9987b 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -227,6 +227,11 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 @z2z_4x1        ....... . esz:2 .. zm:4 ....1. ..... ...0 . \
                 &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4
 
+@z2z_2x1_e0     ....... . .. .. zm:4 ....0. ..... .... . \
+                &zzz_en esz=0 n=2 zd=%zd_ax2 zn=%zd_ax2
+@z2z_4x1_e0     ....... . .. .. zm:4 ....1. ..... ...0 . \
+                &zzz_en esz=0 n=4 zd=%zd_ax4 zn=%zd_ax4
+
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_2x1
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_4x1
 UMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 1    @z2z_2x1
@@ -236,14 +241,38 @@ SMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 0    @z2z_4x1
 UMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 1    @z2z_2x1
 UMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 1    @z2z_4x1
 
-FMAX_n1        1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_2x1
-FMAX_n1        1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_4x1
-FMIN_n1        1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_2x1
-FMIN_n1        1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_4x1
-FMAXNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_2x1
-FMAXNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_4x1
-FMINNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_2x1
-FMINNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_4x1
+{
+  BFMAX_n1     1100000 1 00 10 .... 1010.0 01000 .... 0    @z2z_2x1_e0
+  FMAX_n1      1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_2x1
+}
+{
+  BFMAX_n1     1100000 1 00 10 .... 1010.0 01000 .... 0    @z2z_4x1_e0
+  FMAX_n1      1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_4x1
+}
+{
+  BFMIN_n1     1100000 1 00 10 .... 1010.0 01000 .... 1    @z2z_2x1_e0
+  FMIN_n1      1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_2x1
+}
+{
+  BFMIN_n1     1100000 1 00 10 .... 1010.0 01000 .... 1    @z2z_4x1_e0
+  FMIN_n1      1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_4x1
+}
+{
+  BFMAXNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 0    @z2z_2x1_e0
+  FMAXNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_2x1
+}
+{
+  BFMAXNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 0    @z2z_4x1_e0
+  FMAXNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_4x1
+}
+{
+  BFMINNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 1    @z2z_2x1_e0
+  FMINNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_2x1
+}
+{
+  BFMINNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 1    @z2z_4x1_e0
+  FMINNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_4x1
+}
 
 SRSHL_n1       1100000 1 .. 10 .... 1010.0 10001 .... 0    @z2z_2x1
 SRSHL_n1       1100000 1 .. 10 .... 1010.0 10001 .... 0    @z2z_4x1
@@ -269,6 +298,11 @@ FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 @z2z_4x4        ....... . esz:2 . ...00 ....1. ..... ...0 . \
                 &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
 
+@z2z_2x2_e0     ....... . .. . ....0 ....0. ..... .... . \
+                &zzz_en esz=0 n=2 zd=%zd_ax2 zn=%zd_ax2 zm=%zm_ax2
+@z2z_4x4_e0     ....... . .. . ...00 ....1. ..... ...0 . \
+                &zzz_en esz=0 n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
+
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_2x2
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_4x4
 UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_2x2
@@ -278,14 +312,38 @@ SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_4x4
 UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_2x2
 UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_4x4
 
-FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
-FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
-FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
-FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
-FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
-FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
-FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
-FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+{
+  BFMAX_nn     1100000 1 00 1 ..... 1011.0 01000 .... 0    @z2z_2x2_e0
+  FMAX_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
+}
+{
+  BFMAX_nn     1100000 1 00 1 ..... 1011.0 01000 .... 0    @z2z_4x4_e0
+  FMAX_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
+}
+{
+  BFMIN_nn     1100000 1 00 1 ..... 1011.0 01000 .... 1    @z2z_2x2_e0
+  FMIN_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
+}
+{
+  BFMIN_nn     1100000 1 00 1 ..... 1011.0 01000 .... 1    @z2z_4x4_e0
+  FMIN_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
+}
+{
+  BFMAXNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 0    @z2z_2x2_e0
+  FMAXNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
+}
+{
+  BFMAXNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 0    @z2z_4x4_e0
+  FMAXNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
+}
+{
+  BFMINNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 1    @z2z_2x2_e0
+  FMINNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
+}
+{
+  BFMINNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 1    @z2z_4x4_e0
+  FMINNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+}
 
 SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_2x2
 SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_4x4
-- 
2.43.0


