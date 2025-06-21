Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDF7C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zI-0005EB-0G; Sat, 21 Jun 2025 19:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zE-0005BZ-7j
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zC-0004Wq-Bg
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7481600130eso3675033b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549861; x=1751154661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aqQSNjJPfJiJWB/rQi/NVdAo28lt+Z/CJCxR799djcw=;
 b=yO3se8tBrLoMr1lqqF9SDSvAna+EeT96k8yXxIEy+tOtFoDts1Ez5+/RSDIw0m9BS8
 FSc8m1tIKrPFbHfjOYumlAJGFZtGOxTtNCFg2urzkgqrWxKhvBdGJ9grJq1rweuHUSE3
 0OBjhsPiEAsAsqjT2EGe7jgGnoFpF58oIoggUqoOHIYm1pDGZJOnWViSQ8lz9GdEr7ky
 nSJiWTUbh/gA1JDh7/vH0aVpCpBymJOQBK/Ks1yOFlrM9E+FC0pJ6NECbHsMilNokI91
 IXAQr2n6Z6rhXQsGLY/QsA3cAsgFRd8ZifcJljAsXCxf4kJzRYZfPCUMRyborHMeU+nw
 Z0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549861; x=1751154661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqQSNjJPfJiJWB/rQi/NVdAo28lt+Z/CJCxR799djcw=;
 b=kc0ynZbTfU0DLYfWKL7dObUmJy3rUav01+FzCMCH63m94fVLjL6MZkDJkjpkHYv5vk
 isGUUcA5PTF0+nH8RNwmEUQyZAgPvltz2UH79R4ddX8Jy1FfygSDmQUWxAKYM8pfdp5x
 P2ECJTqwv2jaIz09LKEneEa77lsRFdRlRjSQMFJBMOJZqvdjyYB455577Vyq3JnV/xsO
 O3G9RsZHzaswaYsfn70AKvvQUoml06VR62S1RuFfuKTRwhw+0kbmi+IpdoTtQi80shTs
 0cQo7UvMl+ey53DZkvuuSP8JcQ8KyXhpO8f+CJ66YMslOieXecKd/1M24/eb6LFdRsMU
 h2sQ==
X-Gm-Message-State: AOJu0YyxOoG+S9Tzh/lBc5PF+O0su7TbWkiBAEAU80QpezO3K9kE1gmv
 NwYcEjfFf+xmdfNNnigpNL++iglIVEfcu9oQ1TYqWE1NdsCO43nBAo+WYe5eKa2cna9Pla9ziRc
 Ae6d3
X-Gm-Gg: ASbGncvKKH7knc1ywfJtQ6orgMFqwMxx9jsyYkcBqqdA6uh4HLN290Co1+oMbL/5DVt
 Mjjr198VrSfnhzHMrApMS4oAv0fdiX5XdLmUECb6F/x9ynztp7YucIJ9Zs7q7PErK3dkxK2VWLr
 bnwUKRu6aypX3TvTe3l3GC3PVWj59zpWpmT/iWPBmDfv5byiBQR7EEcqxzIzeHR5C9KnntjlvUi
 rE7Rs37YlGvyzDClzPYWvPXLXhwt+wbBtDC16YM9C3DG+bthWSNDy3+A1NnjBSu52D9ttRmN86n
 BCtaC5WVD9XZHEyjYk2QJgYDTj3fM8fHOko/NzdmmJfNHiioOCt65jXvxnDcnFGAHJFz7rdCRH6
 Zr8zCoVFXu/QwSqtVz+pK
X-Google-Smtp-Source: AGHT+IEyMiXOXgxAgxNevmSsC8MGc+T+pwuKJ1M03MsPHdTsoWNl0+32p5nT7BT140zddh0Ku+BvrQ==
X-Received: by 2002:a05:6a20:5483:b0:215:d611:5d9b with SMTP id
 adf61e73a8af0-22026e54e0amr11668434637.12.1750549860978; 
 Sat, 21 Jun 2025 16:51:00 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.51.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:51:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 034/101] target/arm: Implement SME2 FMLAL, BFMLAL
Date: Sat, 21 Jun 2025 16:49:30 -0700
Message-ID: <20250621235037.74091-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/arm/tcg/translate-sme.c | 93 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 71 ++++++++++++++++++++++++++
 2 files changed, 164 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 8aae70201c..ec12bfd089 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -751,3 +751,96 @@ TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
+
+/*
+ * Expand array multi-vector single (n1), array multi-vector (nn),
+ * and array multi-vector indexed (nx), for floating-point accumulate.
+ *   multi: true for nn, false for n1.
+ *   fpst: >= 0 to set ptr argument for FPST_*, < 0 for ENV.
+ *   data: stuff for simd_data, including any index.
+ */
+#define FPST_ENV  -1
+
+static bool do_azz_acc_fp(DisasContext *s, int nreg, int nsel,
+                          int rv, int off, int zn, int zm,
+                          int data, int shsel, bool multi, int fpst,
+                          gen_helper_gvec_4_ptr *fn)
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
+                fn(t, t_zn, t_zm, t, ptr, tcg_constant_i32(desc));
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
+static bool do_fmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         (1 << 2) | sub, 1,
+                         multi, FPST_ENV, gen_helper_sve2_fmlal_zzzw_s);
+}
+
+TRANS_FEAT(FMLAL_n1, aa64_sme2, do_fmlal, a, false, false)
+TRANS_FEAT(FMLSL_n1, aa64_sme2, do_fmlal, a, true, false)
+TRANS_FEAT(FMLAL_nn, aa64_sme2, do_fmlal, a, false, true)
+TRANS_FEAT(FMLSL_nn, aa64_sme2, do_fmlal, a, true, true)
+
+static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         (a->idx << 3) | (1 << 2) | sub, 1,
+                         false, FPST_ENV, gen_helper_sve2_fmlal_zzxw_s);
+}
+
+TRANS_FEAT(FMLAL_nx, aa64_sme2, do_fmlal_nx, a, false)
+TRANS_FEAT(FMLSL_nx, aa64_sme2, do_fmlal_nx, a, true)
+
+static bool do_bfmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm, sub, 1,
+                         multi, FPST_ZA, gen_helper_gvec_bfmlal);
+}
+
+TRANS_FEAT(BFMLAL_n1, aa64_sme2, do_bfmlal, a, false, false)
+TRANS_FEAT(BFMLSL_n1, aa64_sme2, do_bfmlal, a, true, false)
+TRANS_FEAT(BFMLAL_nn, aa64_sme2, do_bfmlal, a, false, true)
+TRANS_FEAT(BFMLSL_nn, aa64_sme2, do_bfmlal, a, true, true)
+
+static bool do_bfmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
+{
+    return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                         (a->idx << 2) | sub, 1,
+                         false, FPST_ZA, gen_helper_gvec_bfmlal_idx);
+}
+
+TRANS_FEAT(BFMLAL_nx, aa64_sme2, do_bfmlal_nx, a, false)
+TRANS_FEAT(BFMLSL_nx, aa64_sme2, do_bfmlal_nx, a, true)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a6dee08661..9850c19d90 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -261,6 +261,30 @@ SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 
+%off3_x2        0:3 !function=times_2
+%off2_x2        0:2 !function=times_2
+
+@azz_nx1_o3x2   ........ ... . zm:4 . .. ... zn:5 .. ...    \
+                &azz_n off=%off3_x2 rv=%mova_rv
+@azz_nx1_o2x2   ........ ... . zm:4 . .. ... zn:5 ... ..    \
+                &azz_n off=%off2_x2 rv=%mova_rv
+
+FMLAL_n1        11000001 001 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+FMLAL_n1        11000001 001 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
+FMLAL_n1        11000001 001 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
+
+FMLSL_n1        11000001 001 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
+FMLSL_n1        11000001 001 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
+FMLSL_n1        11000001 001 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
+
+BFMLAL_n1       11000001 001 0 .... 0 .. 011 ..... 10 ...   @azz_nx1_o3x2 n=1
+BFMLAL_n1       11000001 001 0 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=2
+BFMLAL_n1       11000001 001 1 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=4
+
+BFMLSL_n1       11000001 001 0 .... 0 .. 011 ..... 11 ...   @azz_nx1_o3x2 n=1
+BFMLSL_n1       11000001 001 0 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=2
+BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -280,3 +304,50 @@ SUB_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
 SUB_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
 SUB_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
 SUB_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
+
+@azz_2x2_o2x2   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2 off=%off2_x2
+@azz_4x4_o2x2   ........ ... ..... . .. ... ..... ... ..    \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4 off=%off2_x2
+
+FMLAL_nn        11000001 101 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
+FMLAL_nn        11000001 101 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
+
+FMLSL_nn        11000001 101 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
+FMLSL_nn        11000001 101 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
+
+BFMLAL_nn       11000001 101 ....0 0 .. 010 ....0 100 ..    @azz_2x2_o2x2
+BFMLAL_nn       11000001 101 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
+
+BFMLSL_nn       11000001 101 ....0 0 .. 010 ....0 110 ..    @azz_2x2_o2x2
+BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
+
+### SME2 Multi-vector Indexed
+
+&azx_n          n off rv zn zm idx
+
+%idx3_15_10     15:1 10:2
+%idx2_10_2      10:2 2:1
+
+@azx_1x1_o3x2   ........ .... zm:4 . .. . .. zn:5 .. ...    \
+                &azx_n n=1 rv=%mova_rv off=%off3_x2 idx=%idx3_15_10
+@azx_2x1_o2x2   ........ .... zm:4 . .. . .. ..... .. ...   \
+                &azx_n n=2 rv=%mova_rv off=%off2_x2 zn=%zn_ax2 idx=%idx2_10_2
+@azx_4x1_o2x2   ........ .... zm:4 . .. . .. ..... .. ...   \
+                &azx_n n=4 rv=%mova_rv off=%off2_x2 zn=%zn_ax4 idx=%idx2_10_2
+
+FMLAL_nx        11000001 1000 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
+FMLAL_nx        11000001 1001 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
+FMLAL_nx        11000001 1001 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
+
+FMLSL_nx        11000001 1000 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
+FMLSL_nx        11000001 1001 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
+FMLSL_nx        11000001 1001 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
+
+BFMLAL_nx       11000001 1000 .... . .. 1 .. ..... 10 ...   @azx_1x1_o3x2
+BFMLAL_nx       11000001 1001 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_o2x2
+BFMLAL_nx       11000001 1001 .... 1 .. 1 .. ...00 10 ...   @azx_4x1_o2x2
+
+BFMLSL_nx       11000001 1000 .... . .. 1 .. ..... 11 ...   @azx_1x1_o3x2
+BFMLSL_nx       11000001 1001 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_o2x2
+BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
-- 
2.43.0


