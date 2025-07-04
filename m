Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62140C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjF2-00022O-4Z; Fri, 04 Jul 2025 12:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEj-0001G0-Vz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEg-0006RV-72
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso11819275e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646360; x=1752251160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bLNa56gFt9vvTDz7HW3N2VbUwwZsJwkhQJewOB2ctLk=;
 b=oW0EuGVs2efShe6YuxhAD0x/7+7vMp3VorrNVqVwjLv6X4Sef7QhOQmUWBrBXhX2WQ
 c30+c8Ro7903/NuHnib9RjhLqYW3e4W3i/+F+0DUevYJAqy3AIYfrkDiRogr1LZPV2v3
 qlyQFqKnYmmpFeNNqRXK/m9GeRk3/MbIF/RL+nuKojf9icvZghbiDikXC4i1Oj/TLfP3
 +bWrdW5mGlCoKRNxXGGawyZWnq0/4qx3WSAs+LhgkGQ8Wi6Kl0Wv8h0yioIviOcB91Nv
 0q1ZGN/KNPb5cxrhHURYOLuWD9RQuoY5z1oVFnJkR73oaUvgU1i3FY+KRtybI/+BLrPi
 yTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646360; x=1752251160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bLNa56gFt9vvTDz7HW3N2VbUwwZsJwkhQJewOB2ctLk=;
 b=R8q/DFsH9gvam69++X89fnShb3dTuzKb3KhtxjBPmBvqHoF5933DfNGcEXfpthlLoZ
 5Jvr8w7rm6s6t1BpMGdsmQ8cvBzabZooTIT1td+WqoT+w5zm3DtDXu1R7m8uh+5/SMx8
 Ep929iI+9xyGe250qCr5XCJOcjWDRu0lRmiEbCQkLRXCs8kPCoUCcQfsCXlRHdBfcRBI
 c9uzif5D6OLzCDsX3pLnFsoiVG/fBSpuMF4blTJ6g/c34xwq5N19HC/E181nzrZfHKAz
 Xs9IaUZQrLPmpms8nrsm7mELrLqVdaCUKGD/VvuEXqd5NzUi2br1WHxo3mU0EdIcMi0j
 QXhQ==
X-Gm-Message-State: AOJu0YyrIUpBqPI17hFjlU4uVlMCR86HOJb9a8SuJ/VU7vsBONDiN75V
 F0fhlyJa/MJf1gO2bDahjzRsssym5BF92oB8bbFdveWhhVEhjQoPY9FvXxvG1c8EufxB4+agtSB
 VassR
X-Gm-Gg: ASbGncsCcpVhBAY550cqTMJwhLYXWPKcPqRcY2k0lni/6DDIUXV5X6tGMyfg+6FL/yw
 Z4vmmerBy4GjEzCfpwjuq6VIcrysajf9hCs3F6kcrawuefDYqhMBQ+8ED1F+5dROk8ejUd49Czm
 /38FTBR7dcTyvO/uhLe0B2KBrJulWGU3PuoAqVzSVCgFo1LZtwtpiVDws45T60+/sgcHyfMX0Ux
 j+lFQ090zgzq/93JvzF88kqsiDUeyik/cCoqQh+KnAEzNHzh8RuQOONYk/cIERMyQVvc29QH+Md
 hF4voN2f3gS97yAEOW35DT3EU7NSjkXCeTrckKAmbbzh7un8iGfGAOaiLAwz9iIbwYwrAeOwdnW
 GQ5U=
X-Google-Smtp-Source: AGHT+IGQRP9mtBKhTcJenTWxLYvj5lA62N5NN43T79QVtuzkdY5FctCm8utAU+YWdQpsXQR2XlxCCQ==
X-Received: by 2002:a05:6000:2112:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3b49700c571mr1885763f8f.5.1751646360477; 
 Fri, 04 Jul 2025 09:26:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 061/119] target/arm: Implement SME2 BFMLA, BFMLS
Date: Fri,  4 Jul 2025 17:24:01 +0100
Message-ID: <20250704162501.249138-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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
Message-id: 20250704142112.1018902-50-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper.h        |  9 +++++++++
 target/arm/tcg/sme.decode      | 18 ++++++++++++++++++
 target/arm/tcg/translate-sme.c | 14 ++++++++++++++
 target/arm/tcg/vec_helper.c    | 26 ++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/target/arm/tcg/helper.h b/target/arm/tcg/helper.h
index b741470b517..37dd384659c 100644
--- a/target/arm/tcg/helper.h
+++ b/target/arm/tcg/helper.h
@@ -799,14 +799,17 @@ DEF_HELPER_FLAGS_5(gvec_fmls_nf_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i
 DEF_HELPER_FLAGS_5(gvec_vfma_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfma_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfmla, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfmls, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ah_vfms_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ah_vfms_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_ah_vfms_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_ah_bfmls, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_ftsmul_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, fpst, i32)
@@ -838,6 +841,8 @@ DEF_HELPER_FLAGS_6(gvec_fmla_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmla_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmla_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_fmls_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
@@ -845,6 +850,8 @@ DEF_HELPER_FLAGS_6(gvec_fmls_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_fmls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_bfmls_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
@@ -852,6 +859,8 @@ DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(gvec_ah_fmls_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_6(gvec_ah_bfmls_idx, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_uqadd_b, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 962ffae3d65..b3dd3bffc38 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -370,16 +370,22 @@ USMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 0010 .   @azz_nx1_o1x4 n=4
 SUMLALL_n1_s    11000001 001 0 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=2
 SUMLALL_n1_s    11000001 001 1 .... 0 .. 000 ..... 1010 .   @azz_nx1_o1x4 n=4
 
+BFMLA_n1        11000001 011 0 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=2
 FMLA_n1_h       11000001 001 0 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=2
 FMLA_n1_s       11000001 001 0 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=2
 FMLA_n1_d       11000001 011 0 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=2
+
+BFMLA_n1        11000001 011 1 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=4
 FMLA_n1_h       11000001 001 1 .... 0 .. 111 ..... 00 ...   @azz_nx1_o3 n=4
 FMLA_n1_s       11000001 001 1 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=4
 FMLA_n1_d       11000001 011 1 .... 0 .. 110 ..... 00 ...   @azz_nx1_o3 n=4
 
+BFMLS_n1        11000001 011 0 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=2
 FMLS_n1_h       11000001 001 0 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=2
 FMLS_n1_s       11000001 001 0 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=2
 FMLS_n1_d       11000001 011 0 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=2
+
+BFMLS_n1        11000001 011 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_h       11000001 001 1 .... 0 .. 111 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_s       11000001 001 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
 FMLS_n1_d       11000001 011 1 .... 0 .. 110 ..... 01 ...   @azz_nx1_o3 n=4
@@ -484,16 +490,22 @@ UMLSLL_nn_d     11000001 111 ...01 0 .. 000 ...00 1100 .    @azz_4x4_o1x4
 USMLALL_nn_s    11000001 101 ....0 0 .. 000 ....0 0010 .    @azz_2x2_o1x4
 USMLALL_nn_s    11000001 101 ...01 0 .. 000 ...00 0010 .    @azz_4x4_o1x4
 
+BFMLA_nn        11000001 111 ....0 0 .. 100 ....0 01 ...    @azz_2x2_o3
 FMLA_nn_h       11000001 101 ....0 0 .. 100 ....0 01 ...    @azz_2x2_o3
 FMLA_nn_s       11000001 101 ....0 0 .. 110 ....0 00 ...    @azz_2x2_o3
 FMLA_nn_d       11000001 111 ....0 0 .. 110 ....0 00 ...    @azz_2x2_o3
+
+BFMLA_nn        11000001 111 ...01 0 .. 100 ...00 01 ...    @azz_4x4_o3
 FMLA_nn_h       11000001 101 ...01 0 .. 100 ...00 01 ...    @azz_4x4_o3
 FMLA_nn_s       11000001 101 ...01 0 .. 110 ...00 00 ...    @azz_4x4_o3
 FMLA_nn_d       11000001 111 ...01 0 .. 110 ...00 00 ...    @azz_4x4_o3
 
+BFMLS_nn        11000001 111 ....0 0 .. 100 ....0 11 ...    @azz_2x2_o3
 FMLS_nn_h       11000001 101 ....0 0 .. 100 ....0 11 ...    @azz_2x2_o3
 FMLS_nn_s       11000001 101 ....0 0 .. 110 ....0 01 ...    @azz_2x2_o3
 FMLS_nn_d       11000001 111 ....0 0 .. 110 ....0 01 ...    @azz_2x2_o3
+
+BFMLS_nn        11000001 111 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
@@ -652,16 +664,22 @@ SUMLALL_nx_s    11000001 0001 .... 1 .. 0.. ...01 10 ...    @azx_4x1_i4_o1
 @azx_4x1_i3_o3  ........ .... zm:4 . .. ... ..... .. off:3  \
                 &azx_n n=4 rv=%mova_rv zn=%zn_ax4 idx=%idx3_10_3
 
+BFMLA_nx        11000001 0001 .... 0 .. 1.. ....1 0 ....    @azx_2x1_i3_o3
 FMLA_nx_h       11000001 0001 .... 0 .. 1.. ....0 0 ....    @azx_2x1_i3_o3
 FMLA_nx_s       11000001 0101 .... 0 .. 0.. ....0 00 ...    @azx_2x1_i2_o3
 FMLA_nx_d       11000001 1101 .... 0 .. 00. ....0 00 ...    @azx_2x1_i1_o3
+
+BFMLA_nx        11000001 0001 .... 1 .. 1.. ...01 0 ....    @azx_4x1_i3_o3
 FMLA_nx_h       11000001 0001 .... 1 .. 1.. ...00 0 ....    @azx_4x1_i3_o3
 FMLA_nx_s       11000001 0101 .... 1 .. 0.. ...00 00 ...    @azx_4x1_i2_o3
 FMLA_nx_d       11000001 1101 .... 1 .. 00. ...00 00 ...    @azx_4x1_i1_o3
 
+BFMLS_nx        11000001 0001 .... 0 .. 1.. ....1 1 ....    @azx_2x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 0 .. 1.. ....0 1 ....    @azx_2x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 0 .. 0.. ....0 10 ...    @azx_2x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 0 .. 00. ....0 10 ...    @azx_2x1_i1_o3
+
+BFMLS_nx        11000001 0001 .... 1 .. 1.. ...01 1 ....    @azx_4x1_i3_o3
 FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 5f513696090..3f9a80248ae 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1038,6 +1038,15 @@ TRANS_FEAT(FMLA_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
 TRANS_FEAT(FMLS_nn_d, aa64_sme2_f64f64, do_fmla, a, true, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_vfms_d : gen_helper_gvec_vfms_d)
 
+TRANS_FEAT(BFMLA_n1, aa64_sme_b16b16, do_fmla, a, false, FPST_ZA,
+           gen_helper_gvec_bfmla)
+TRANS_FEAT(BFMLS_n1, aa64_sme_b16b16, do_fmla, a, false, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls : gen_helper_gvec_bfmls)
+TRANS_FEAT(BFMLA_nn, aa64_sme_b16b16, do_fmla, a, true, FPST_ZA,
+           gen_helper_gvec_bfmla)
+TRANS_FEAT(BFMLS_nn, aa64_sme_b16b16, do_fmla, a, true, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls : gen_helper_gvec_bfmls)
+
 static bool do_fmla_nx(DisasContext *s, arg_azx_n *a,
                        ARMFPStatusFlavour fpst, gen_helper_gvec_4_ptr *fn)
 {
@@ -1058,6 +1067,11 @@ TRANS_FEAT(FMLA_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
 TRANS_FEAT(FMLS_nx_d, aa64_sme2_f64f64, do_fmla_nx, a, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_fmls_idx_d : gen_helper_gvec_fmls_idx_d)
 
+TRANS_FEAT(BFMLA_nx, aa64_sme_b16b16, do_fmla_nx, a, FPST_ZA,
+           gen_helper_gvec_bfmla_idx)
+TRANS_FEAT(BFMLS_nx, aa64_sme_b16b16, do_fmla_nx, a, FPST_ZA,
+           s->fpcr_ah ? gen_helper_gvec_ah_bfmls_idx : gen_helper_gvec_bfmls_idx)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 4b7de5016ee..51bfd767a39 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1608,6 +1608,12 @@ static float16 float16_muladd_f(float16 dest, float16 op1, float16 op2,
     return float16_muladd(op1, op2, dest, 0, stat);
 }
 
+static bfloat16 bfloat16_muladd_f(bfloat16 dest, bfloat16 op1, bfloat16 op2,
+                                  float_status *stat)
+{
+    return bfloat16_muladd(op1, op2, dest, 0, stat);
+}
+
 static float32 float32_muladd_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
@@ -1626,6 +1632,12 @@ static float16 float16_mulsub_f(float16 dest, float16 op1, float16 op2,
     return float16_muladd(float16_chs(op1), op2, dest, 0, stat);
 }
 
+static bfloat16 bfloat16_mulsub_f(bfloat16 dest, bfloat16 op1, bfloat16 op2,
+                                  float_status *stat)
+{
+    return bfloat16_muladd(bfloat16_chs(op1), op2, dest, 0, stat);
+}
+
 static float32 float32_mulsub_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
@@ -1644,6 +1656,12 @@ static float16 float16_ah_mulsub_f(float16 dest, float16 op1, float16 op2,
     return float16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
 }
 
+static bfloat16 bfloat16_ah_mulsub_f(bfloat16 dest, bfloat16 op1, bfloat16 op2,
+                                     float_status *stat)
+{
+    return bfloat16_muladd(op1, op2, dest, float_muladd_negate_product, stat);
+}
+
 static float32 float32_ah_mulsub_f(float32 dest, float32 op1, float32 op2,
                                  float_status *stat)
 {
@@ -1677,14 +1695,19 @@ DO_MULADD(gvec_fmls_nf_s, float32_mulsub_nf, float32)
 DO_MULADD(gvec_vfma_h, float16_muladd_f, float16)
 DO_MULADD(gvec_vfma_s, float32_muladd_f, float32)
 DO_MULADD(gvec_vfma_d, float64_muladd_f, float64)
+DO_MULADD(gvec_bfmla, bfloat16_muladd_f, bfloat16)
 
 DO_MULADD(gvec_vfms_h, float16_mulsub_f, float16)
 DO_MULADD(gvec_vfms_s, float32_mulsub_f, float32)
 DO_MULADD(gvec_vfms_d, float64_mulsub_f, float64)
+DO_MULADD(gvec_bfmls, bfloat16_mulsub_f, bfloat16)
 
 DO_MULADD(gvec_ah_vfms_h, float16_ah_mulsub_f, float16)
 DO_MULADD(gvec_ah_vfms_s, float32_ah_mulsub_f, float32)
 DO_MULADD(gvec_ah_vfms_d, float64_ah_mulsub_f, float64)
+DO_MULADD(gvec_ah_bfmls, bfloat16_ah_mulsub_f, bfloat16)
+
+#undef DO_MULADD
 
 /* For the indexed ops, SVE applies the index per 128-bit vector segment.
  * For AdvSIMD, there is of course only one such vector segment.
@@ -1803,14 +1826,17 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va,                  \
 DO_FMLA_IDX(gvec_fmla_idx_h, float16, H2, 0, 0)
 DO_FMLA_IDX(gvec_fmla_idx_s, float32, H4, 0, 0)
 DO_FMLA_IDX(gvec_fmla_idx_d, float64, H8, 0, 0)
+DO_FMLA_IDX(gvec_bfmla_idx, bfloat16, H2, 0, 0)
 
 DO_FMLA_IDX(gvec_fmls_idx_h, float16, H2, INT16_MIN, 0)
 DO_FMLA_IDX(gvec_fmls_idx_s, float32, H4, INT32_MIN, 0)
 DO_FMLA_IDX(gvec_fmls_idx_d, float64, H8, INT64_MIN, 0)
+DO_FMLA_IDX(gvec_bfmls_idx, bfloat16, H2, INT16_MIN, 0)
 
 DO_FMLA_IDX(gvec_ah_fmls_idx_h, float16, H2, 0, float_muladd_negate_product)
 DO_FMLA_IDX(gvec_ah_fmls_idx_s, float32, H4, 0, float_muladd_negate_product)
 DO_FMLA_IDX(gvec_ah_fmls_idx_d, float64, H8, 0, float_muladd_negate_product)
+DO_FMLA_IDX(gvec_ah_bfmls_idx, bfloat16, H2, 0, float_muladd_negate_product)
 
 #undef DO_FMLA_IDX
 
-- 
2.43.0


