Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CDC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhm-0002T3-H7; Wed, 02 Jul 2025 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgO-0008Pg-CS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:25 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg5-00019b-DK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:24 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ea2fee5471so3668514fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459699; x=1752064499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BetRDS8kkp6nmhqyj4FBx1q2luREYqTuIuf/DGCbtB0=;
 b=MBdyGqAKjRsENZIVkGWh/KHNHsxdQaaOKetrqr//iMJvAU5IqfKN2wQrFNM97NB/Tl
 xbStDLqySRftfLsaC6L8HU/rcu2GvtOmeJeaT7iDPBvW/5RK2PU7Ytjr1OdNMkVBOaDV
 8FbP2Aoa9tFdn8GE8ewfNKcGT/lQSvJT/LrEqBY0ojz8slkxZdEf1R0QYDQWNIInlznU
 A38cKkty07e+VeKXbk3G3XBTFs9BjOnmPuBfUE+vjhI8clz/r96dYtNQctoXWt/NkKK/
 t5szB1qBixZxlIxbOZQhb9NJfkDQWkaMHPAFCqu5YGCMRNB9nnqrw7xc346XU3nuWItX
 sY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459699; x=1752064499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BetRDS8kkp6nmhqyj4FBx1q2luREYqTuIuf/DGCbtB0=;
 b=sFfQedqH/Ocb1SV2uIA48evoRUQNjFXRSrnpP2X4vJdFwRxeyiZ7xU/D1tv23mFAQI
 vsgawRiNX4vSjb2yMGaieRpI+Y3JF8ZNPSpYkKVe9e97Lp/2ImEUJnqCkHDR9VxCovDs
 VOB7eUPhIniqWcyx3L/oMpOQXqQM2vFPmebOJPLlOMgzcqqH7By+HOuk6EB+Pc5SM2UF
 GJbr5X3dLYcVthVhPEWeF1DbOpuGXAyLeKCf4uCFUf7CQbDAVkMwF+LBv++R0wrUvePX
 zSi9y8FCaYVxuLHPQAg91VtX17XN84pcBIyyZivjDw+5mkmRdhk7GqxEciIw8CW8TRZJ
 On2g==
X-Gm-Message-State: AOJu0Ywq57XMXp8asC+5Tj8n+UQb09RL3s5znOzV7xTLIDwBzi1wD3nS
 lH+wrWuLP9LruULoX3FX3XdyspLSTMmtVpV/OZrIX6o0Vsdo+RQEm0hIdOV7Ze6in9p4df39hc0
 ixbcTabw=
X-Gm-Gg: ASbGncsGJFMyU3h7HRdlTgKjb01yxXHtKyXlbU64l/BTKHaW38At+DJu5/BsOeBGOK/
 R6c2DqJoU2tLjLp6g5unk4RICmhVKfZWRzWaZqaPCv8nRpazvq17q23qWwtMOjHXzaadUA0oObi
 000YQASDaUvDlSfSZOnhYDdkDvwjLN4gQTaPC/BsW5AczG50h8pA+Bn8zz/Vc+24GP03FYFmGIB
 GsvMzD3T09ykFRG6nIQQKVRo53wwC10w2uPSVfxW8uEO/yLJvk6gaJvsjgIFccOet8Yegg2XUvw
 Rg+i64DkPHHAwjnephiiFVyuLYeFsyKzk4ctwu30AFVItb8a1bn6VmLNtA74hGnGzThs2A==
X-Google-Smtp-Source: AGHT+IFUkLZC0lsNzK33YDVQVBeBJPBo4k/xOIkF9KsziqlOJT5VWebDaB5A65X6G6dc6bJo4AO2Xg==
X-Received: by 2002:a05:6870:469f:b0:2da:b440:5b1 with SMTP id
 586e51a60fabf-2f6472a5f71mr1780832fac.5.1751459699525; 
 Wed, 02 Jul 2025 05:34:59 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 38/97] target/arm: Implement SME2 FMLA, FMLS
Date: Wed,  2 Jul 2025 06:33:11 -0600
Message-ID: <20250702123410.761208-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 070cebc573..5f51369609 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -815,6 +815,47 @@ TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub
  */
 #define FPST_ENV  -1
 
+static bool do_azz_fp(DisasContext *s, int nreg, int nsel,
+                      int rv, int off, int zn, int zm,
+                      int data, int shsel, bool multi, int fpst,
+                      gen_helper_gvec_3_ptr *fn)
+{
+    if (sme_smza_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int vstride = svl / nreg;
+        TCGv_ptr t_za = get_zarray(s, rv, off, nreg, nsel);
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
@@ -963,6 +1004,60 @@ static bool do_vdot(DisasContext *s, arg_azx_n *a, gen_helper_gvec_4_ptr *fn)
 TRANS_FEAT(FVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_fvdot_idx_h)
 TRANS_FEAT(BFVDOT, aa64_sme, do_vdot, a, gen_helper_sme2_bfvdot_idx)
 
+static bool do_fmla(DisasContext *s, arg_azz_n *a, bool multi,
+                    ARMFPStatusFlavour fpst, gen_helper_gvec_3_ptr *fn)
+{
+    return do_azz_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                     0, 0, multi, fpst, fn);
+}
+
+TRANS_FEAT(FMLA_n1_h, aa64_sme_f16f16, do_fmla, a, false, FPST_ZA_F16,
+           gen_helper_gvec_vfma_h)
+TRANS_FEAT(FMLS_n1_h, aa64_sme_f16f16, do_fmla, a, false, FPST_ZA_F16,
+           s->fpcr_ah ? gen_helper_gvec_ah_vfms_h : gen_helper_gvec_vfms_h)
+TRANS_FEAT(FMLA_nn_h, aa64_sme_f16f16, do_fmla, a, true, FPST_ZA_F16,
+           gen_helper_gvec_vfma_h)
+TRANS_FEAT(FMLS_nn_h, aa64_sme_f16f16, do_fmla, a, true, FPST_ZA_F16,
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
+TRANS_FEAT(FMLA_nx_h, aa64_sme_f16f16, do_fmla_nx, a, FPST_ZA_F16,
+           gen_helper_gvec_fmla_idx_h)
+TRANS_FEAT(FMLS_nx_h, aa64_sme_f16f16, do_fmla_nx, a, FPST_ZA_F16,
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
index 934e4a802e..962ffae3d6 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -370,6 +370,20 @@ USMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
 SUMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
 SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 
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
@@ -470,6 +484,20 @@ UMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
 USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 0010 .    @azz_2x2_o1x4
 USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 0010 .    @azz_4x4_o1x4
 
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
@@ -617,3 +645,23 @@ USMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 00 ...    @azx_4x1_i4_o1
 SUMLALL_nx_s    11000001 0000 .... . .. ... ..... 101 ..    @azx_1x1_i4_o2
 SUMLALL_nx_s    11000001 0001 .... 0 .. 0.. ....1 10 ...    @azx_2x1_i4_o1
 SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
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


