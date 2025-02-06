Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F665C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:07:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg84f-0000Ux-Hk; Thu, 06 Feb 2025 15:02:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Y-0007pD-Jq
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:07 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83Q-000180-2P
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:00:54 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2fa19e1d027so947876a91.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872050; x=1739476850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VWUpY40SaAZ4kS1G9k/Y8ApoV0O+gEOwL6g/8hv230=;
 b=cDlvP7lEQg03TJG1kKn6f0rpyiexwW+rZoj6w2iBOIVfbbMH3hALFOPgv50F4Pyo5x
 BNqocPZzgmAi8Tuxe5khx/u+mCzCIyVng2rwvjpPQqC759+CyTGQ5+h6f3YOAtxb6gPH
 XNJ/uGFqGdPlWNdcU7h2uNI+NInvoAIilIXWnEFmgMtco2vzoQJ5FiA+eGwj4HunDDZi
 aayeJpNesTZs0nHBhuuOYjwa0k1YHy8uIU63x9jiMZ6I4FgdTg63D53rvIvGbWZJbmal
 DVHpcyyK3ck1WBqsw1U8islJ7N+mV2+AxmKbiUTNkMAf+kHKE8wML4K3ASyUh+obyaUS
 lt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872050; x=1739476850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6VWUpY40SaAZ4kS1G9k/Y8ApoV0O+gEOwL6g/8hv230=;
 b=cuJ5yJCCh8MhomGO1wJdtonGE97PvHoT0FQ9k1YIlmBp2pyrzGc+KEwE7n2MzzQF08
 iBwHFvVDS2h1I9MFgJJaBKThwtto8ygSHszzruSEum1eLaWr5smH6vPx7vC1ND+lFda2
 NVME2CyAf1eilouCXawOmZLV5TVG3ook0PQc2tlclEqa58oz/qYecxjZDtjBavIv1wHY
 QFM2z4KbwCJZeAF9xiGKnMYP/B+/ic9vp6ympNlOJ8unzatgkwSO5RTzWE6FpWlwXCQL
 7NbJd0Qfyp/EagAf2n5IqeTKFV5CEmj0B7TOJaEqondaDN/D+IWAP5aQcjx0S8br8pvW
 sDEQ==
X-Gm-Message-State: AOJu0Yy77PYEbQeXejatxs4+/195PgG+y0YBMX1HAFmdggILniuxVPN6
 QsyKCYLgyRiVLZoesbt6CSgvmV4gaHmrNH0EOaMfF9uEFVqnaJUwHQmtkKKlB1wU3ruir9RV4Ip
 X
X-Gm-Gg: ASbGncu7NhVY6mtglq0UbJjF32+7+GGWualXNMn9msEEfdn9yDIGTgBCrJoI7LEb4Yn
 K5pBecN2jK5p0dCZZA+sp+hdZrRJm1WOBl4v13iDawIrMiFC9tNR7NjGB1dN8sGwb+R/HM2aWzf
 Ru8+cQWogRq3b5FLOfdPuU4nTCxQA4aV1yLnbLb7L33HM1vcnLtQY8ccEY8Labz/EKo9JRfeEvv
 PbRFy8mZZIldGgMwLaD+j1J7EcMzUxDApuTJKVO3NLq5cnrUSWWP07AeXjb+CB3eUfg9IOIH0k3
 TgZf2Fy8CSRk0yQl94ODcR3rnj3TNG25ZrWzSX88Q6A0DUo=
X-Google-Smtp-Source: AGHT+IEEpcP7z7r3X3UmsXpFxQOHox3s/v04SJOGj/RHmVxUpNBp2SPn6h9Sq2WMmFcBtFBt7PD1SA==
X-Received: by 2002:a17:90b:23d7:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-2fa24063b84mr605667a91.12.1738872050069; 
 Thu, 06 Feb 2025 12:00:50 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:00:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 44/61] target/arm: Implement SME2 FADD, FSUB, BFADD, BFSUB
Date: Thu,  6 Feb 2025 11:56:58 -0800
Message-ID: <20250206195715.2150758-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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
 target/arm/helper.h            |  2 ++
 target/arm/tcg/translate-sme.c | 44 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_helper.c    |  2 ++
 target/arm/tcg/sme.decode      | 25 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index ac2372bbe7..4fa0730716 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -717,10 +717,12 @@ DEF_HELPER_FLAGS_4(gvec_fclt0_d, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfadd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fsub_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_bfsub, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmul_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 5dce2dfd15..f41b4343e4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1005,6 +1005,50 @@ TRANS_FEAT(BFMLA_nx, aa64_sme2_b16b16, do_fmla_nx, a, FPST_ZA,
 TRANS_FEAT(BFMLS_nx, aa64_sme2_b16b16, do_fmla_nx, a, FPST_ZA,
            s->fpcr_ah ? gen_helper_gvec_ah_bfmls_idx : gen_helper_gvec_bfmls_idx)
 
+static bool do_faddsub(DisasContext *s, arg_az_n *a, ARMFPStatusFlavour fpst,
+                       gen_helper_gvec_3_ptr *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        int n = a->n;
+        int zm = a->zm;
+        int vstride = svl / n;
+        TCGv_ptr t_za = get_zarray(s, a->rv, a->off, n);
+        TCGv_ptr ptr = fpstatus_ptr(fpst);
+        TCGv_ptr t = tcg_temp_new_ptr();
+
+        for (int r = 0; r < n; ++r) {
+            TCGv_ptr t_zm = vec_full_reg_ptr(s, zm + r);
+            int o_za = r * vstride * sizeof(ARMVectorReg);
+            int desc = simd_desc(svl, svl, 0);
+
+            tcg_gen_addi_ptr(t, t_za, o_za);
+            fn(t, t, t_zm, ptr, tcg_constant_i32(desc));
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(FADD_nn_h, aa64_sme2_f16f16, do_faddsub, a,
+           FPST_ZA_F16, gen_helper_gvec_fadd_h)
+TRANS_FEAT(FSUB_nn_h, aa64_sme2_f16f16, do_faddsub, a,
+           FPST_ZA_F16, gen_helper_gvec_fsub_h)
+
+TRANS_FEAT(FADD_nn_s, aa64_sme2, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fadd_s)
+TRANS_FEAT(FSUB_nn_s, aa64_sme2, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fsub_s)
+
+TRANS_FEAT(FADD_nn_d, aa64_sme2_f64f64, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fadd_d)
+TRANS_FEAT(FSUB_nn_d, aa64_sme2_f64f64, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_fsub_d)
+
+TRANS_FEAT(BFADD_nn, aa64_sme2_b16b16, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_bfadd)
+TRANS_FEAT(BFSUB_nn, aa64_sme2_b16b16, do_faddsub, a,
+           FPST_ZA, gen_helper_gvec_bfsub)
+
 /*
  * Expand array multi-vector single (n1), array multi-vector (nn),
  * and array multi-vector indexed (nx), for integer accumulate.
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e5a4f56ef7..e41386861e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1469,10 +1469,12 @@ void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
 DO_3OP(gvec_fadd_h, float16_add, float16)
 DO_3OP(gvec_fadd_s, float32_add, float32)
 DO_3OP(gvec_fadd_d, float64_add, float64)
+DO_3OP(gvec_bfadd, bfloat16_add, bfloat16)
 
 DO_3OP(gvec_fsub_h, float16_sub, float16)
 DO_3OP(gvec_fsub_s, float32_sub, float32)
 DO_3OP(gvec_fsub_d, float64_sub, float64)
+DO_3OP(gvec_bfsub, bfloat16_sub, bfloat16)
 
 DO_3OP(gvec_fmul_h, float16_mul, float16)
 DO_3OP(gvec_fmul_s, float32_mul, float32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 0d592bb467..91df2068cf 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -515,6 +515,31 @@ FMLS_nn_h       11000001 101 ...01 0 .. 100 ...00 11 ...    @azz_4x4_o3
 FMLS_nn_s       11000001 101 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 FMLS_nn_d       11000001 111 ...01 0 .. 110 ...00 01 ...    @azz_4x4_o3
 
+&az_n           n off rv zm
+@az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
+                &az_n n=2 rv=%mova_rv zm=%zn_ax2
+@az_4x4_o3      ........ ... ..... . .. ... ..... .. off:3  \
+                &az_n n=4 rv=%mova_rv zm=%zn_ax4
+
+FADD_nn_h       11000001 101 00100 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_s       11000001 101 00000 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_d       11000001 111 00000 0 .. 111 ....0 00 ...    @az_2x2_o3
+FADD_nn_h       11000001 101 00101 0 .. 111 ...00 00 ...    @az_4x4_o3
+FADD_nn_s       11000001 101 00001 0 .. 111 ...00 00 ...    @az_4x4_o3
+FADD_nn_d       11000001 111 00001 0 .. 111 ...00 00 ...    @az_4x4_o3
+
+FSUB_nn_h       11000001 101 00100 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_s       11000001 101 00000 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_d       11000001 111 00000 0 .. 111 ....0 01 ...    @az_2x2_o3
+FSUB_nn_h       11000001 101 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
+FSUB_nn_s       11000001 101 00001 0 .. 111 ...00 01 ...    @az_4x4_o3
+FSUB_nn_d       11000001 111 00001 0 .. 111 ...00 01 ...    @az_4x4_o3
+
+BFADD_nn        11000001 111 00100 0 .. 111 ....0 00 ...    @az_2x2_o3
+BFADD_nn        11000001 111 00101 0 .. 111 ...00 00 ...    @az_4x4_o3
+BFSUB_nn        11000001 111 00100 0 .. 111 ....0 01 ...    @az_2x2_o3
+BFSUB_nn        11000001 111 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
-- 
2.43.0


