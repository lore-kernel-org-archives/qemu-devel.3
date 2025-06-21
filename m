Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E101C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zI-0005EG-3Q; Sat, 21 Jun 2025 19:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zC-0005BB-PV
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zB-0004WL-7F
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso2302366b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549860; x=1751154660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TQCjgYiJ38m/dRuOCrueWQOvHfQiGoL/F0IUorE2POg=;
 b=iC2P9sgde07I4Qk6MsNh8BifoQ1aeJWFyfAA5oouBviLueblok4clp4kcOiprn2oRJ
 w/xFMffSWlZ50opNJMFbRkpv+nL2qMyMhW07tyPaVTHfxzCCEmjowywiJNovfkdR9GjR
 MzFnP0//0x6k/lHNhN/kMdHhhMH9NgE/YIN9A2/MAR7+p5PyqBNOHTYoLpCCh2jDh8QA
 p5kUqTIwvNSYGit1l2nY0lQkxFVB8kBQZBpSJoiTa6Zyv1eun8+wA5VMQwiY987Sbs9C
 Ju8kdmBcSVLcnEL5LWykrz09SjFYsfVjacc1OPjmBhvnSIGnByZJDcZkJm/IlM+ps9GK
 3Psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549860; x=1751154660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQCjgYiJ38m/dRuOCrueWQOvHfQiGoL/F0IUorE2POg=;
 b=uHzwjcwfR/8LykM/dCR5xGDr+sEGz+sIN+8N8LIfP2zk2G1txTz7p+U1B7BViVIVXp
 ZhXr5Fsqhbd5BXtrw9xELuoyGxZstEz0yIpmxNsxAKUNYiU6OKbH5vha+bRgpaU6Ocz2
 keEUxOwAPW2IiJfMtj0LVQJCoJQeM6I0kM8AS/V8+KN0+CDnyhpxpZn2r5uWD5dETI98
 S5WvIm+CS/TBhimkhXdpkpstceoCWhL8szRJNhLXzumE8j5uMZp/WI+u/eT3PlKOgB0r
 yowXHafKpMsxq82Jme4UbgRQpfDmM8z3bCZL2wXnOmMFTuRy4vFCpWQcAAvJw0Z4bGhu
 yG+Q==
X-Gm-Message-State: AOJu0YwWcM3hFbZ7rym6J6fLKyxav2a1/3q6AR89wQGO3V5uJ0YLkPTu
 L8U97/osb9nfXoXhL4gdp0qfGTWlCCF51J41Z3500FApQ0ldX/pM+X8FWhzgW06HkMWPU9F1P6l
 s31Mt
X-Gm-Gg: ASbGncv7+CbUU/uHW6uGomzogzkl1Xe+jc8XdytTNucr2LdJNqZfPc7PAmWnz71Vzji
 YRiESr8btLYSAoPzvaCJYtNs6OIKlaTVZ2q5rNx553O8/FGz5+zYQMI5hAHkyIltN/bdVRqVPeT
 vuV4CZiJjcVPDElqThCftognu9f7xiPSOeKBoVRKNYv7rd3H1/67Y9YF4Q0/TPTHFmamtQB2HTN
 CFMnypNyV6orZg73aljwx7+kwfUAqPi043ywr9Fa3fRd8aiQBLCbq1e8Lf0qs+g3+Kg3qgrke9n
 pQLJU6xJ03/Fv3vzZubU6Pq/jTgDPeKZk1ttPRhsemECwwode7NHc4phOtJXy+aJZ/Y/wYnVOgr
 9trXTCxYDIjPWMHQacW2T
X-Google-Smtp-Source: AGHT+IEabrhKQXptLGwMZx9gMTXcQ53FldK3LUni9IlzyRij2fLPqXmLAWdYRiey2gEyf41T/vfciA==
X-Received: by 2002:a05:6a00:3d53:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-7490da6e841mr10096975b3a.11.1750549859715; 
 Sat, 21 Jun 2025 16:50:59 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:50:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 032/101] target/arm: Implement SME2 ADD/SUB (array results,
 multiple vectors)
Date: Sat, 21 Jun 2025 16:49:28 -0700
Message-ID: <20250621235037.74091-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/arm/tcg/translate-sme.c | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 20 ++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 09a4da1725..8aae70201c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -692,6 +692,7 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
 
+/* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
 {
@@ -720,3 +721,33 @@ TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_n1_d, aa64_sme2_i16i64, do_azz_n1, a, MO_64, tcg_gen_gvec_sub_var)
+
+/* Add/Sub each vector Z[m*N] to each Z[n*N] with result in ZA[d*N]. */
+static bool do_azz_nn(DisasContext *s, arg_azz_n *a, int esz,
+                      GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zn = vec_full_reg_offset(s, a->zn + i);
+        int o_zm = vec_full_reg_offset(s, a->zm + i);
+
+        fn(esz, t_za, o_za, tcg_env, o_zn, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 8b81c0a0ce..a6dee08661 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -260,3 +260,23 @@ SUB_azz_n1_s    11000001 0010 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_s    11000001 0011 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 SUB_azz_n1_d    11000001 0110 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=2
 SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
+
+### SME2 Multi-vector Multiple Array Vectors
+
+%zn_ax2         6:4 !function=times_2
+%zn_ax4         7:3 !function=times_4
+
+@azz_2x2_o3     ........ ... ..... . .. ... ..... .. off:3  \
+                &azz_n n=2 rv=%mova_rv zn=%zn_ax2 zm=%zm_ax2
+@azz_4x4_o3     ........ ... ..... . .. ... ..... .. off:3  \
+                &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4
+
+ADD_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 10 ...    @azz_2x2_o3
+ADD_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 10 ...    @azz_4x4_o3
+ADD_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 10 ...    @azz_2x2_o3
+ADD_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 10 ...    @azz_4x4_o3
+
+SUB_azz_nn_s    11000001 101 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
+SUB_azz_nn_s    11000001 101 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
+SUB_azz_nn_d    11000001 111 ....0 0 .. 110 ....0 11 ...    @azz_2x2_o3
+SUB_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
-- 
2.43.0


