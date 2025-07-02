Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D764C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgO-0008PB-B8; Wed, 02 Jul 2025 08:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwg5-0007va-OV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:05 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfm-00013Z-AT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:02 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7382a999970so3517815a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459682; x=1752064482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQf/TObpoRHlubh31JKaROZXrhMyeMqBNp1Pj+KLbEk=;
 b=UfXZI1/rLu4h0yp9//OiiWGtCfTl7ozxRH73T+nt6UCvy8wPoDwS1zdJaZjxe2y/8x
 s7urvzXxVTyps7YBb/9PIaLq251ZWjUI87xNIuBThVKQ8FtVDhAaX+Ui+Vk138wLi9RC
 xl6vaepB4vHQqgZ7659H7FVVxds5VT+bSkfl0pOQaswHtrBC9KGk1F4gdXU+6C2WOhqT
 AOsT2ghNyCJkEzMLp4mtewPSNOmC/wRvY9epTZnsovnW2jZRiC8OmsDbJgDWu8kjtddc
 5rB74xvg8du1/IHyF2wUCQpJqYAHNFb/WLNoxnSI9CW7ovRcKwm/YrqBeOaqOYfnMCrp
 QUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459682; x=1752064482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQf/TObpoRHlubh31JKaROZXrhMyeMqBNp1Pj+KLbEk=;
 b=acYmgAUR2bsq69jY3qZ4Up9al1PMGNT1t750BxyPzgReUHd6qjwlHJymI30H+jleNk
 o7TN2Lh7Cl+ht7h6h9F8WGvL9ayBQS32VZhxPmFQtE16DHPn0md0g36b6RjSB4Mvm9Fz
 rtEno3h+/3ORw64oQpUGN62ZMd6g6aOENI0kEAf0AoKvqxdUu1YpPo8pNjCeE9DAlceF
 Q4r4C2EgSbLeUIyLHWHTkpSgU2Ah+JiN9XHS6vK1JAw3K3d/zeM1R/Ypo2/AEA9xWU/k
 YgqS1oQdX0+qDnjCnPkIH5CR8TZ8McDRrK+9FlKynE+nMKUn0R/yz1KGZnHsmd/az+eL
 LFmQ==
X-Gm-Message-State: AOJu0Yw/2skLiRUuoYy7fTlar+QU5I/15MLrhYXPtm+eyiNFeQPxu/aq
 ILTIupXvBxfxdBuxvrzPZaYVGO9h90V4otWMokvaCuxs4SKAUEP0uI6+rdpPC3aV9uxEOrlafSQ
 Xg/OtYvY=
X-Gm-Gg: ASbGncv3mdOskzTtL3ag5K47WzYOsFY5GQYs79zk5fo8Cqs5iumSbLuQNgdqo9rpV/8
 GxrshWRekhvtSDdpPti6bdFEzcgX+ulNgn2Wgb6AfkCVg+Mab06XvuMzc/s/0OIXX4tipvY2Zfr
 GEUig5EBsRPw/Vxv+GHWzX7J1/lpQuaWpQSB1Ltvr6mQ1+o3p4f2SAo7Hv4MsPG//EjgXQEGg5a
 EBBC+4nP5W10z4RwEq1W9Y2pvDdiyODslpCdi9s72DEYAUgby1eCTGOldK7XFgUjg1Y8CU8k1ER
 8+p2xrTTG/vF9lixjWsDLsGj+oKJkm+CShw5hlrEUhF0x+bmlzjmKykf1cVv0QmaxTNusQ==
X-Google-Smtp-Source: AGHT+IEorCa+V57z8Kn9f2adQ0hERoNjoX+gRtGWj9efoSYOOhKjsyPWiBy6cNZ9Gr76zIDW4yzj/w==
X-Received: by 2002:a05:6870:d394:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-2f5c7be7b23mr1948709fac.36.1751459681993; 
 Wed, 02 Jul 2025 05:34:41 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 23/97] target/arm: Implement SME2 ADD/SUB (array results,
 multiple vectors)
Date: Wed,  2 Jul 2025 06:32:56 -0600
Message-ID: <20250702123410.761208-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 20 ++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 4bb880d9ef..aabdb96675 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -775,3 +775,33 @@ TRANS_FEAT(ADD_azz_n1_s, aa64_sme2, do_azz_n1, a, MO_32, tcg_gen_gvec_add_var)
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
+    t_za = get_zarray(s, a->rv, a->off, n, 1);
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


