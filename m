Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7E4C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg80r-000864-IJ; Thu, 06 Feb 2025 14:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80P-0007Ig-B2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:45 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg80K-0000Zz-SG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 14:57:43 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa0c039d47so1607489a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 11:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738871858; x=1739476658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQCjgYiJ38m/dRuOCrueWQOvHfQiGoL/F0IUorE2POg=;
 b=bQIBIpcR5BQBU7pmWcM/u2DNZD68+t4gdm6IVWIqLKE77pcqLs1XmkcH3iW/luRmhP
 J3a3dUez9HODzATjsFkmsdmT9hfkw8cUmzgjZhXlyUTpBXrXKJn+AxcFKLerkPsaf8oE
 1sPO5ljQI4/WwpTGZzhw7Nu0u8VFMI/3QPJX2MXo488gNQ+lRJnmPJI1EKad9rb789aA
 WbBobEWeRBmXfRjKjSAvf5fySEv2y8CswR8MTVLxVF14xTd0jD/rrJIOpZClflQkrRm0
 +hZ/+NI1mqYArNLSqKjL3e9P5eNlGv2SSD8A28UoZmxsnuguEGxIxf+ESeuNsEGYMgXH
 oK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738871858; x=1739476658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TQCjgYiJ38m/dRuOCrueWQOvHfQiGoL/F0IUorE2POg=;
 b=SLy0ld7Aa9uOj37iGK0hMPvIl7as/13YT8QUJSJEXqUjJpQV5QEtEMLeXzyo+4h6XW
 NyRq4EMsicPtUASBmYaabRjWbLH14DTyBgrdXTRVc5EXeIZ9Xbg3CpP9aJRaYswp8ZdI
 7d2Fn87dUrb87fTMDq2WpUu6cJaVLZsTITUz9H9Cu9LsJbDNTBqSVcU4UFoQSLyUo9d8
 v2kMrsWSwpO6reQ5uH1/XTdSVJ29+sNM/H8WBFGQhyCOwwDgAZOa22XSsC7r7cEKwW42
 64JxEd3gYFKcdLzdqmESvXegaDJVTyxTix9asNYgoldXMFSCrB23v0KYMhBto4WM0wEW
 Q10Q==
X-Gm-Message-State: AOJu0YxSJQANuSYkFzeV/TixeGttGCbswlcU/LTXcFEhpGuEkWOEeLI6
 +bDdLOGBowIcaL9E247GELi3cqRidrN/e0twgoezQmCNfY5QJIIglG8p+nQezGhqPwVVsW1rslI
 J
X-Gm-Gg: ASbGncu2qV7bUB9iXO8JJEoPsK5eoqrndDk3QKS03AtZfq5yiMSSSye8S2dE2T12+Lb
 UHkt2TTRrujRcSjvJotf2gr0xwnVpZTozMMMHO9FyBEXf1kXcvZ3K7KSVBPsmk9yGBCMl9fIHmJ
 NsfKuKGw1n06wlwQ1yEIgB3kaiGhPV4lK/mFKxE1GIHrZYxstDHgierNMdbYHvU4hk+wszcwOGx
 zNRjjE4srqNmwd8jPR8n/O3I5IIKBNmQ6kkh7Ds8SdzAeQ0MWdjZN3gbapnpE14OT3Y5vuOLBeW
 z3UzbiCUVEnHpJxmZztlzA4XB4D+MB/52mkzb3yg6aziu/U=
X-Google-Smtp-Source: AGHT+IHm9BJOYqkJ9m4jn26b8TZ7ivvOshdZUBAKbfPY4HqFdxvSmhFAB6M2dDYiE5jD7HG1OlgS0Q==
X-Received: by 2002:a05:6a00:1f1a:b0:725:a78c:6c31 with SMTP id
 d2e1a72fcca58-7305d4135demr1005204b3a.3.1738871858455; 
 Thu, 06 Feb 2025 11:57:38 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048c16370sm1666993b3a.152.2025.02.06.11.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 11:57:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 29/61] target/arm: Implement SME2 ADD/SUB (array results,
 multiple vectors)
Date: Thu,  6 Feb 2025 11:56:43 -0800
Message-ID: <20250206195715.2150758-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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


