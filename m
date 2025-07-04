Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127B6C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFD-00031W-T4; Fri, 04 Jul 2025 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEl-0001IN-J9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEj-0006Ug-H1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:07 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so6166105e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646362; x=1752251162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uF28X6Q5gCFd9Ll0xLQpSOBKr1raaNTNHM4U8+GRmQI=;
 b=r0bz2AAsPDTjNjHcfDrgMuqkylPdZMsSvkPH+uyWjeo4P25ff18EJtkTqDOm+LFhpv
 syvFv0KAyp/gB/V01V2hQtxf8fh0cdnArrZYwlGz1FynLVvPVil7J4pLO8dqfyNNJCKU
 c/m2dTy0fgwJjmgwBO1G1kvsRk9GjywfdHV66vrh5x6QqiFRatXb+VFsZQSNHtWLFrHh
 8ptFUCiAchE1wOruq5O/Vg2jtFxNjktSJwe3W7Et/r96Y9yycCVpUEQdLPIZgFd7MZkO
 g4JZHSpFQf1H9fk9lSKE7t8FfQ+QMYzvn2P0RKNzQvCwS0E6YTrrd4X+TQimK9M1zGgO
 Kscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646362; x=1752251162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uF28X6Q5gCFd9Ll0xLQpSOBKr1raaNTNHM4U8+GRmQI=;
 b=RGMkvtbeVos/bzxTJd4yNAtnBUs43tITg2TurlnQm4bArycnh9HVR3Cv7UHawyDKwa
 O494KR3i51wrWtnU91gU3eDwVwlQoICR1WYjEnjSm1P4p902g6DIxic4ymkk+2sp9u/C
 UHLc94y8MIzH4kG20UYm0/4Uhr/YoS5AfDDIJu3neO76dX84IzEeDrnoyMCXqPcm2j9V
 yJyL98pWCwlWSWqT8jR98hd3X/Uqricnd59DBwUoucK86oj6bU/n7/7Fax8MHJ/zMVur
 7Am9JaxSxO4BDrBm7snm93LhU0DVujFzIy70riNTSYQVYiLpUNkqpk4PyqQWudCjg+72
 0t6A==
X-Gm-Message-State: AOJu0YxGR8e7H9rIL8VlapCsAxp3RXR9Rzz2+O8xcRBXWLmT+01nf9jU
 SJ83A47qSHjNRKLtB3krs3GtG8bS518u6LhqJ/5l6tCNrMXAR8UnImhgjCkPA8XCntJ7ay+KV5h
 ORH8/
X-Gm-Gg: ASbGncuH75e2wAd9AxLWR3iJ4qcmaMhFgkBVzkD4mxoa2veQRKIwvp9/Wq7ivqxLZ6m
 5whRG2ZT3TJb5mpZQlic8TK/pvB/FPbX3KYzdvPavCs5SxfQMx3IDildsMWZjyhQNt05T3P+6ij
 wqmieZvm+9cAjxKP5t6PUMB+g3pB9w5iP6Lg37Jvjz7hKAYAX9SuBjhAfhMIieJuSBpHIG8dkt+
 7lsKqAzak0MAWocqxkyj4IZSWujNj97tdwLg4mcA3tkQ3M1eshvTc5LuL/rx1tNUsPc+BpdQ5j6
 /koOtBin8E9T3psriA+mzUXqQYnKMXjg/SnjVM6izqzdQZEEYeZ51bk+iwOpt3KjIyzQ
X-Google-Smtp-Source: AGHT+IGvjFKH7ywj+i9X4uWUAck5U2sMnSEPoCuut7BHsC5cmrAUP7q3H0NXpJzHN5h4b3vRDJA1jA==
X-Received: by 2002:a05:600c:19c9:b0:43c:f629:66f4 with SMTP id
 5b1f17b1804b1-454b305fcb1mr37222865e9.0.1751646362446; 
 Fri, 04 Jul 2025 09:26:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 063/119] target/arm: Implement SME2 ADD/SUB (array accumulator)
Date: Fri,  4 Jul 2025 17:24:03 +0100
Message-ID: <20250704162501.249138-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20250704142112.1018902-52-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 12 ++++++++++++
 target/arm/tcg/translate-sme.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0badc8f9fa3..22e2a68b1b9 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -708,3 +708,15 @@ BFMLS_nx        11000001 0001 .... 1 .. 1.. ...01 1 ....    @azx_4x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
+
+### SME2 Add / Sub array accumulators
+
+ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
+ADD_aaz_s       11000001 101 000010 .. 111 ...00 10 ...     @az_4x4_o3
+ADD_aaz_d       11000001 111 000000 .. 111 ....0 10 ...     @az_2x2_o3
+ADD_aaz_d       11000001 111 000010 .. 111 ...00 10 ...     @az_4x4_o3
+
+SUB_aaz_s       11000001 101 000000 .. 111 ....0 11 ...     @az_2x2_o3
+SUB_aaz_s       11000001 101 000010 .. 111 ...00 11 ...     @az_4x4_o3
+SUB_aaz_d       11000001 111 000000 .. 111 ....0 11 ...     @az_2x2_o3
+SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 664fdd86aa5..4c3b9aa7d6c 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -806,6 +806,34 @@ TRANS_FEAT(SUB_azz_nn_s, aa64_sme2, do_azz_nn, a, MO_32, tcg_gen_gvec_sub_var)
 TRANS_FEAT(ADD_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_add_var)
 TRANS_FEAT(SUB_azz_nn_d, aa64_sme2_i16i64, do_azz_nn, a, MO_64, tcg_gen_gvec_sub_var)
 
+/* Add/Sub each ZA[d*N] += Z[m*N] */
+static bool do_aaz(DisasContext *s, arg_az_n *a, int esz, GVecGen3FnVar *fn)
+{
+    TCGv_ptr t_za;
+    int svl, n;
+
+    if (!sme_smza_enabled_check(s)) {
+        return true;
+    }
+
+    n = a->n;
+    t_za = get_zarray(s, a->rv, a->off, n, 0);
+    svl = streaming_vec_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int o_za = (svl / n * sizeof(ARMVectorReg)) * i;
+        int o_zm = vec_full_reg_offset(s, a->zm + i);
+
+        fn(esz, t_za, o_za, t_za, o_za, tcg_env, o_zm, svl, svl);
+    }
+    return true;
+}
+
+TRANS_FEAT(ADD_aaz_s, aa64_sme2, do_aaz, a, MO_32, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_aaz_s, aa64_sme2, do_aaz, a, MO_32, tcg_gen_gvec_sub_var)
+TRANS_FEAT(ADD_aaz_d, aa64_sme2_i16i64, do_aaz, a, MO_64, tcg_gen_gvec_add_var)
+TRANS_FEAT(SUB_aaz_d, aa64_sme2_i16i64, do_aaz, a, MO_64, tcg_gen_gvec_sub_var)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for floating-point accumulate.
-- 
2.43.0


