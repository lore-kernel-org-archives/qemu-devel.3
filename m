Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFADC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82O-00029z-Nt; Sat, 21 Jun 2025 19:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82J-00025A-KB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:16 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-0004zO-2A
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:15 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b2f0faeb994so3237148a12.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550050; x=1751154850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/eZkFaYWj/+ztcNnzaovwx/5ni1FVW3U8adynKPbxyo=;
 b=SB+Vvt3bLfuuJa5OzJQZ6Vd2gxCh0ZfEDgpA2K7rpRJ5LXnkdRW83KdWSDGxzgf18W
 oYqsRNoygDKUoPFKwZC7dwTUsbngTGJXsrqHGgmNeWr2OGOQojYG6XxXQZIP2Vf6Zd1+
 v8N+KpikiYn2ttKV+9by5DABQc6cfQiw1TS7MpV9oCGXPlKbpwr2h48KCwGpnjdAApAw
 UvfFy+OC/siJe6EQ3K3o1NMEPAfkT9tNqvs30X0XEY/vlGaDwt0FhxGGa06/THe1k1pb
 2vUxNXZlP8/xcgifzUo/ocAOJhZuD4QgUJn/to0ZV154J0UUwMmT0qiEeq7getfYvzDf
 Eitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550050; x=1751154850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/eZkFaYWj/+ztcNnzaovwx/5ni1FVW3U8adynKPbxyo=;
 b=GrbEsR6aroEiruU6dFjvQHmDDVrXYuD6irdMvxB3ax1iZAejE6LGb5bqLDYev1xD0D
 QOmC3YAfJKF1xcxC/vuLm0J2ffOz9DV7M0ALg2USIVe2o8p5o47PTpgAuo7G20CnXoI0
 ZqVWEq2zS35yFl6ufX+jT9wMMWrZ93VcTWU9rokV5/B0gmUy7Ow43YSfjTAplBIC6mz/
 CkNN7h50bouiB1p5KOSu6alAl0XUGGJvVWGcQy8vIi9Nmc5O1l+CdgXnJ8+qb/MPKgMX
 /fHANqveyMfYB1Sqrg9/cgzF/acsIsQUbX8fcDqF88L2Em1MQRaGBB8FxTyGeg6ds4di
 Qrpg==
X-Gm-Message-State: AOJu0Yyvscym8uM/7kEKa86qpluC2fO2jIeiyY+NPMNypKMjqmggj9ls
 0NRQkiu3GYIFmqRpLFkFoPa5JD6xC66x6b7oSBt9kXWXuTrQ41sbwoypqH02SefYUFmDhmjT38Z
 1Qgce8ig=
X-Gm-Gg: ASbGnctiA/PXVmYNMJgNa1UceJQzsqn0iH/wO446BLtLuknIof7nFg7JlfcCDYPzxBO
 LvsG3C3+23MV5r7OaAFjGABcnS8imyozL/BnUzMuDf7g/FiHKBvB2LPnuUtxWBmUiueRWivFOXm
 vGvKoJ6n2jwcr08YE7zF877Ye/dhCVqK8OATJpvaQ85XTAtTlYGTYpKws1M76PgQR1TOtK1nNV9
 FtKDsC6xdY4JmFdKoKl+KeKlO5OI+zuZtvvTmurtrKoUAe1p6UdO/AP5Hh6eWXeAK7CXVvsnv9g
 BovvPN9mkkswW811H97v7fl4yRBotFS5l2zayRIGjcPCxvA3F2ATl7cUb5nk+/pwMAbs2EGBE5Y
 O2qFoXa/rcTLY6kg1WeWW
X-Google-Smtp-Source: AGHT+IEolGI9WDYQDo8TT2DvCNNAoltBNehP+Wa8lEdUpYHdN4+lJGSfZOQIGpGpGMadyyygfIWx0A==
X-Received: by 2002:a05:6a20:e616:b0:1f5:8a1d:3905 with SMTP id
 adf61e73a8af0-22026d2a7ddmr12328897637.7.1750550050001; 
 Sat, 21 Jun 2025 16:54:10 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 048/101] target/arm: Implement SME2 FMLA, FMLS
Date: Sat, 21 Jun 2025 16:49:44 -0700
Message-ID: <20250621235037.74091-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 95 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 48 +++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8127f2e641..6390594f35 100644
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


