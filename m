Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68143C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg83s-0007vD-L6; Thu, 06 Feb 2025 15:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Q-0007Xh-F6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:53 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83O-00017E-2f
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:52 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f9cd8ecbceso2433126a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872048; x=1739476848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+S3P4mkx2mPY+X8cRH+yRYO9IDrCwJbn1ng5ws73VY=;
 b=i9VDnQ6fTrLD4Dgq8cydkVMQ8TWb3jGKaQXnEww6IT1+cbrzMU+SdbI1KrfeOjTLqX
 shK7wjf4jji0HaWHwG6uNPrbz7XHHvypaQEd3KglN+0SKOrOrj6G+NX588L2Z35ftfTe
 yOhGGz6US0CP+Cu3iZAIM1VNvcPCG0eh0/lULxNIrKo67MvMOKnBUFeaU8Vud4iH+Itw
 t9Z689Dmnyk0nHx4kynsZVE0qIcQG5wMd4Cp9qcajwfcdslIy3/KJJOOzKObsZ9hw9W3
 Ghcgx2oUit0vPOkysFAQfQc5DEn5p2pboISj+uWrMLkjG51rEhDdyXM+vZtbxoPsp+D7
 p+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872048; x=1739476848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+S3P4mkx2mPY+X8cRH+yRYO9IDrCwJbn1ng5ws73VY=;
 b=SVB6WlcLOAmiYtgm+5FdJJ14vWTb6EHRM2kxXmR54luJ9fhm5N+DUco3sMeBablFMB
 OSpq6dy0doKm9OrPRBqZBtWUfYV/G5RYz3jlMpaBXHApL5inDc8ebGNZ7sCx4iic6B/R
 09mOfPY+PBFfpiFY9nKir4OAbQntCXSYuH4z3vFUwp4yfeBeebAKQDpf0BIEmnk5usgI
 tr+J5gqLXkZVtoP6/OIN3t/40B9OwLAWZpcSLNnpW38q7mknVH1PDAd1w/wAdR0EVVHD
 nK4mNpsivWOoSdMruEBELugB1gYl+/ys0upPMc5iHlRe6tuEXhPx3KMDSqfDdPJ3Bk0/
 Y75g==
X-Gm-Message-State: AOJu0Yzy1lsXsdqh1u20wwyYytoEaFw222Hi++nFOJpehK2mW+WEQmhe
 Sij7qCfH479YWU6iqp8QdeFVtTvqK+kX8YSuRMOfh/+jxnzjD12dM5BRBMAAOAkpkwbCnMzfd3W
 j
X-Gm-Gg: ASbGncufoU2UyjLuAy6TYAwGX++kszWr0LD0y5CZ3auvfIBsRBTdA7gmPs04qYxb6py
 B5SMGnjteuYV+PwVC2c9revaL4ms7GTb4zVhLqCZ3/VC3/gzFkrO8D8tqSCF+ebzgBBCBULJvHT
 rjMj++bhTY58Jml5p6o0sP3KRVpKHBcfjQUbRv/76PhnM/2G9TWWv9bs9MpG2Sz440iLCPj1nkV
 KHu5IMmuQjeRry84KIf7NsTq307pj5sY8C0qZaR48fYRb43blWQn3wRvM1rpM0epWD0TDc03SmX
 iasZb9ElLJZAohrjNoVz4maMoZ4w4Ax3WUCth+saZQ75hhc=
X-Google-Smtp-Source: AGHT+IH5IJyY/1kmqIbK96Qf37SCppCTgFfg8iZAyXI28ms01VU4V4+/n/jn/mEANG4+WOwKm8ZT/A==
X-Received: by 2002:a17:90b:2ec5:b0:2fa:2252:f438 with SMTP id
 98e67ed59e1d1-2fa2450cf33mr537659a91.30.1738872048447; 
 Thu, 06 Feb 2025 12:00:48 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 42/61] target/arm: Implement SME2 FMLA, FMLS
Date: Thu,  6 Feb 2025 11:56:56 -0800
Message-ID: <20250206195715.2150758-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 95 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 48 +++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 9c0989baff..1989dedab5 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -761,6 +761,47 @@ TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub
  */
 #define FPST_ENV  -1
 
+static bool do_azz_fp(DisasContext *s, int nreg, int nsel,
+                      int rv, int off, int zn, int zm,
+                      int data, int shsel, bool multi, int fpst,
+                      gen_helper_gvec_3_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg);
+        TCGv_ptr t, ptr;
+
+        if (fpst >= 0) {
+            ptr = fpstatus_ptr(fpst);
+        } else {
+            ptr = tcg_env;
+        }
+        t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < nreg; ++r) {
+            TCGv_ptr t_zn = vec_full_reg_ptr(s, zn);
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm);
+
+            for (int i = 0; i < nsel; ++i) {
+                int o_za = (r * vstride + i) * sizeof(ARMVectorReg);
+                int desc = simd_desc(svl, svl, data | (i << shsel));
+
+                tcg_gen_addi_ptr(t, t_za, o_za);
+                fn(t, t_zn, t_zm, ptr, tcg_constant_i32(desc));
+            }
+
+            /*
+             * For multiple-and-single vectors, Zn may wrap.
+             * For multiple vectors, both Zn and Zm are aligned.
+             */
+            zn = (zn + 1) % 32;
+            zm += multi;
+        }
+    }
+    return true;
+}
+
 static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
                           int rv, int off, int zn, int zm,
                           int data, int shsel, bool multi, int fpst,
@@ -896,6 +937,60 @@ static bool trans_BFVDOT(DisasContext *s, arg_azx_n *a)
                          gen_helper_sme2_bfvdot_idx);
 }
 
+static bool do_fmla(DisasContext *s, arg_azz_n *a, bool multi,
+                    ARMFPStatusFlavour fpst, gen_helper_gvec_3_ptr *fn)
+{
+    return do_azz_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                     0, 0, multi, fpst, fn);
+}
+
+TRANS_FEAT(FMLA_n1_h, aa64_sme2_f16f16, do_fmla, a, false, FPST_ZA_F16,
+           gen_helper_gvec_vfma_h)
+TRANS_FEAT(FMLS_n1_h, aa64_sme2_f16f16, do_fmla, a, false, FPST_ZA_F16,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_h : gen_helper_gvec_vfms_h)
+TRANS_FEAT(FMLA_nn_h, aa64_sme2_f16f16, do_fmla, a, true, FPST_ZA_F16,
+           gen_helper_gvec_vfma_h)
+TRANS_FEAT(FMLS_nn_h, aa64_sme2_f16f16, do_fmla, a, true, FPST_ZA_F16,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_h : gen_helper_gvec_vfms_h)
+
+TRANS_FEAT(FMLA_n1_s, aa64_sme2, do_fmla, a, false, FPST_ZA,
+           gen_helper_gvec_vfma_s)
+TRANS_FEAT(FMLS_n1_s, aa64_sme2, do_fmla, a, false, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_s : gen_helper_gvec_vfms_s)
+TRANS_FEAT(FMLA_nn_s, aa64_sme2, do_fmla, a, true, FPST_ZA,
+           gen_helper_gvec_vfma_s)
+TRANS_FEAT(FMLS_nn_s, aa64_sme2, do_fmla, a, true, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_s : gen_helper_gvec_vfms_s)
+
+TRANS_FEAT(FMLA_n1_d, aa64_sme2_f64f64, do_fmla, a, false, FPST_ZA,
+           gen_helper_gvec_vfma_d)
+TRANS_FEAT(FMLS_n1_d, aa64_sme2_f64f64, do_fmla, a, false, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_d : gen_helper_gvec_vfms_d)
+TRANS_FEAT(FMLA_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
+           gen_helper_gvec_vfma_d)
+TRANS_FEAT(FMLS_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_d : gen_helper_gvec_vfms_d)
+
+static bool do_fmla_nx(DisasContext *s, arg_azx_n *a,
+                       ARMFPStatusFlavour fpst, gen_helper_gvec_4_ptr *fn)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                         a->idx, 0, false, fpst, fn);
+}
+
+TRANS_FEAT(FMLA_nx_h, aa64_sme2_f16f16, do_fmla_nx, a, FPST_ZA_F16,
+           gen_helper_gvec_fmla_idx_h)
+TRANS_FEAT(FMLS_nx_h, aa64_sme2_f16f16, do_fmla_nx, a, FPST_ZA_F16,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmls_idx_h : gen_helper_gvec_fmls_idx_h)
+TRANS_FEAT(FMLA_nx_s, aa64_sme2, do_fmla_nx, a, FPST_ZA,
+           gen_helper_gvec_fmla_idx_s)
+TRANS_FEAT(FMLS_nx_s, aa64_sme2, do_fmla_nx, a, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmls_idx_s : gen_helper_gvec_fmls_idx_s)
+TRANS_FEAT(FMLA_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
+           gen_helper_gvec_fmla_idx_d)
+TRANS_FEAT(FMLS_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmls_idx_d : gen_helper_gvec_fmls_idx_d)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 49a45612fd..30fa60f9a0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -373,6 +373,20 @@ SUMLALL_n1_d    11000001 011 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
 SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 SUMLALL_n1_d    11000001 011 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 
+FMLA_n1_h       11000001 001 0 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=2
+FMLA_n1_s       11000001 001 0 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=2
+FMLA_n1_d       11000001 011 0 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=2
+FMLA_n1_h       11000001 001 1 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=4
+FMLA_n1_s       11000001 001 1 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=4
+FMLA_n1_d       11000001 011 1 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=4
+
+FMLS_n1_h       11000001 001 0 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=2
+FMLS_n1_s       11000001 001 0 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=2
+FMLS_n1_d       11000001 011 0 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=2
+FMLS_n1_h       11000001 001 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
+FMLS_n1_s       11000001 001 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
+FMLS_n1_d       11000001 011 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -475,6 +489,20 @@ USMLALL_nn_d    11000001 111 ....0 0 .. 000 ....0 1010 .    @azz_2x2_o1x4
 USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
 USMLALL_nn_d    11000001 111 ...01 0 .. 000 ...00 1010 .    @azz_4x4_o1x4
 
+FMLA_nn_h       11000001 101 ....0 0 .. 100 ....0 01 ...    @azz_2x2_o3
+FMLA_nn_s       11000001 101 ....0 0 .. 110 ....0 00 ...    @azz_2x2_o3
+FMLA_nn_d       11000001 111 ....0 0 .. 110 ....0 00 ...    @azz_2x2_o3
+FMLA_nn_h       11000001 101 ...01 0 .. 100 ...00 01 ...    @azz_4x4_o3
+FMLA_nn_s       11000001 101 ...01 0 .. 110 ...00 00 ...    @azz_4x4_o3
+FMLA_nn_d       11000001 111 ...01 0 .. 110 ...00 00 ...    @azz_4x4_o3
+
+FMLS_nn_h       11000001 101 ....0 0 .. 100 ....0 11 ...    @azz_2x2_o3
+FMLS_nn_s       11000001 101 ....0 0 .. 110 ....0 01 ...    @azz_2x2_o3
+FMLS_nn_d       11000001 111 ....0 0 .. 110 ....0 01 ...    @azz_2x2_o3
+FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
+FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
+FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -628,3 +656,23 @@ SUMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 10 ...    @azx_2x1_i4_o1
 SUMLALL_nx_d    11000001 1001 .... 0 .. 00. ....1 10 ...    @azx_2x1_i3_o1
 SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
 SUMLALL_nx_d    11000001 1001 .... 1 .. 00. ...01 10 ...    @azx_4x1_i3_o1
+
+%idx3_10_3      10:2 3:1
+@azx_2x1_i3_o3  ........ .... zm:4 . .. ... ..... .. off:3  \
+                &azx_n n=2 rv=%mova_rv zn=%zn_ax2 idx=%idx3_10_3
+@azx_4x1_i3_o3  ........ .... zm:4 . .. ... ..... .. off:3  \
+                &azx_n n=4 rv=%mova_rv zn=%zn_ax4 idx=%idx3_10_3
+
+FMLA_nx_h       11000001 0001 .... 0 .. 1.. ....0 0 ....    @azx_2x1_i3_o3
+FMLA_nx_s       11000001 0101 .... 0 .. 0.. ....0 00 ...    @azx_2x1_i2_o3
+FMLA_nx_d       11000001 1101 .... 0 .. 00. ....0 00 ...    @azx_2x1_i1_o3
+FMLA_nx_h       11000001 0001 .... 1 .. 1.. ...00 0 ....    @azx_4x1_i3_o3
+FMLA_nx_s       11000001 0101 .... 1 .. 0.. ...00 00 ...    @azx_4x1_i2_o3
+FMLA_nx_d       11000001 1101 .... 1 .. 00. ...00 00 ...    @azx_4x1_i1_o3
+
+FMLS_nx_h       11000001 0001 .... 0 .. 1.. ....0 1 ....    @azx_2x1_i3_o3
+FMLS_nx_s       11000001 0101 .... 0 .. 0.. ....0 10 ...    @azx_2x1_i2_o3
+FMLS_nx_d       11000001 1101 .... 0 .. 00. ....0 10 ...    @azx_2x1_i1_o3
+FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
+FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
+FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
-- 
2.43.0


