Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627F6C83F0C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEv-0001gi-Ri; Fri, 04 Jul 2025 12:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEj-0001G1-Vh
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:06 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEf-0006Qu-Kg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so12228025e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646359; x=1752251159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JtN1RfLtfnRsgJNTbmFjiT7GeIX2OZIYj/H6GzYnMHg=;
 b=o8hhXpaOv3gsGTGxiW1Vl9ldZ91PijpaXHqJ+ZVsb+stgsffnxmf086xp8Mw310sQU
 p2711LUc8U8r5tGpgvMlHeYOB/Q+lUQIZZF6Jatj0fYBzjiI11E05ZtdtgNEAtkhxzy9
 f0HWG/XEV8xlIelSLejE0yMHRW4zo4mUDt+aW6nPS68kDVIPY8oCUnczceZeGr+xBcE4
 TFcuHCwgU22E+JKfY3fpIavxTqN4xvAgEt9t/1XRPapsy6D0g2WfpYRjCa2qrcGn5+uV
 wnjLJgEwOAaPDFgN3WMhYMXxKDArI7Us5/xm2tVhKXxO/5TcHCrxOi3dZHHs3gFsiOG/
 pVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646359; x=1752251159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JtN1RfLtfnRsgJNTbmFjiT7GeIX2OZIYj/H6GzYnMHg=;
 b=lapxOOLMCEzBsGdz6LeVMjQJRebohPcq6FXNADBiJSIjRQ8+KErfNy+o7mptSvGGDZ
 NeOMJR1JlSD0T9oFFHPTQScaDxB35X8neHZGiRA6JPkJ35/YAgFGzFN4brTnlYj5U5Et
 X+NLsqc3hpbbMSqhR2TK90wvSPdUQ6cY6QsjOrJjvi4xwkyBgyVte4Vy4yrSTddzfndt
 v4DspdtPEUYlHuuP4kiBvc6I4LP+5OYnfV92jR+E0ijDIFYNraCPHtycVM4eXq412msB
 aTQ67QFKC3OpYNeIhBn1ksn5b+vu/qop6Q5ah8loZQvR40ZBzBBb6IKvX6puADpowpxF
 ZEIw==
X-Gm-Message-State: AOJu0YzWIN+J4c1jPExtJTeWuARPvh6PuXhi+eCajg/JWJB04/Erdeob
 ZVgI81Z/BroEuYA5F0K7tcVzf74zUlYMbk+K6XXhfSuJoTTyt2Q7IV8ZpfoyJuE/OXROTuyW5MW
 ayseV
X-Gm-Gg: ASbGnctdX0pOQ/rXGQQ7qKzr5lxlA7WmYHjiP+zZNMEyrnezl0ec+3HSBbJ05zBe3VP
 Yv31i0vlO6rh7q4x7Eaqsgl/H0wM3zlzRbs+sYIH5QtGpASL7ZpdjLOYyAK0aWA9AL1NCQ+N6Sr
 /sOQ2jHOI22DczuDLIDQRMSQGc18BnePwD8c4SFjaFoRl9K1yES1BMSrUlOZIopkAgfQ2yDzhaK
 Oe8PUFSMz/V8coFQvmGkjDhw52j2eyN3lO2DlFjwZAWwi88vgFRlCakD52u4iR735WRXxiC4Gn+
 bjO7tJSWAV5+0HaRr2NDo/IK9CDMSE05TcpXyXIWHi96HKkUj4C37XZnXyUHsGr7Juk9tbyuiEm
 srEs=
X-Google-Smtp-Source: AGHT+IE2JfbN6bZdRTjqoPPXiqBxvO+QSY1jZv1Jm34rUYUAdEBUG7mte2R7wUT2qRdh9HI022BTkw==
X-Received: by 2002:a05:6000:470f:b0:3b2:fe46:9812 with SMTP id
 ffacd0b85a97d-3b497015268mr2286051f8f.19.1751646359438; 
 Fri, 04 Jul 2025 09:25:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 060/119] target/arm: Implement SME2 FMLA, FMLS
Date: Fri,  4 Jul 2025 17:24:00 +0100
Message-ID: <20250704162501.249138-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-id: 20250704142112.1018902-49-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 48 +++++++++++++++++
 target/arm/tcg/translate-sme.c | 95 ++++++++++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 934e4a802ea..962ffae3d65 100644
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
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 070cebc5738..5f513696090 100644
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
-- 
2.43.0


