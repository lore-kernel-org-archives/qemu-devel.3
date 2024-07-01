Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14306C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZx-0002Uh-8B; Mon, 01 Jul 2024 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ9-0000jt-LO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:44 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ7-0005SN-GQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso45173311fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850058; x=1720454858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0DUSrmAchhl9dxnhXDfumSKasw+WhgPIfpoDjJK7jzk=;
 b=wPPNzpyNG7sL6sMpxW/WB8M77DbgkWKpykFJMrrfttV6/FTGoLr1yBISlSGoNExr2h
 RXICnnpvKuGzay1aLb+m++JuVy4ppUyxvN+Ca+/YYT3VGyIjudHia2tqZsocAkwIvWoQ
 wOLBKMV2wQkzgxRjITxEaP9JwJyUj1nSvaZJBtV156W6+Y0l1JXEJLu5RL4XO+co/+MS
 9w4L7QtjWCoSpEdbLUVRmiriqueP8pogR6Bbvj3vook7Ud2yvSNAo0yHTYeYdsGFpMoE
 zfCv426NXTSvUE1sE3qYSh90Y2dzphCCjz3FV6GLLtUgNhB3TCgxZC+bqHpf4rFiQAXT
 W5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850058; x=1720454858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0DUSrmAchhl9dxnhXDfumSKasw+WhgPIfpoDjJK7jzk=;
 b=sjvL9/sp9oadouztUF60IcJ27bzZ/Ku/XCJzQd9LsNElMlDbbiUpe9P0EQOioEUKSC
 32PsR3d84I8202iBz21YuH+AAVIlHO+Ox0uNeowRdcDXvcb7OpdDxOqiyhIb7EmmX6IZ
 MMg7T9VTqo+QRd3u9rOhbN6Vd0cdbUmoABlw7XMOPd7FzW0L573uoReXFbzhyHxBZNn/
 Fok9YBxxioDQUiWp3W30N3WoR85jPpandECdNbq2bRxBZY/tPRxq8tYM1cDEUdA0UN5D
 P8Fa3q9T4Y4Q+z74eDy0Oq5cGriL+TFWTobkcFT//wNAjUiuigZ6xmCv325TRFYqgNMx
 4bUA==
X-Gm-Message-State: AOJu0Yw0LQXs2Rl4Ubt5VHvDSCLzFq2vXbrbxTC6ktvRnmqrx2ivl6u4
 xnHXSt8ecWWDyclEfG6dlsTOpZhW6/uP24pU8BG506pKSm1n4pHppkqAPWNc6Lw/NvOjRY+oO6I
 /Cec=
X-Google-Smtp-Source: AGHT+IGsXlTGVaxvT3gzL/1r4v3b4CSIqj6iktSGVtnoQoVmUoTwuegI3LDEq2zDTaUjxz0wRdh6VQ==
X-Received: by 2002:a2e:9997:0:b0:2ec:5430:7f7c with SMTP id
 38308e7fff4ca-2ee5e707c8fmr43763071fa.53.1719850058594; 
 Mon, 01 Jul 2024 09:07:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] target/arm: Add data argument to do_fp3_vector
Date: Mon,  1 Jul 2024 17:07:16 +0100
Message-Id: <20240701160729.1910763-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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
Message-id: 20240625183536.1672454-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 52 +++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2697c4b305b..57cdde008ef 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5290,7 +5290,7 @@ TRANS(CMHS_s, do_cmop_d, a, TCG_COND_GEU)
 TRANS(CMEQ_s, do_cmop_d, a, TCG_COND_EQ)
 TRANS(CMTST_s, do_cmop_d, a, TCG_COND_TSTNE)
 
-static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
+static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a, int data,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
     MemOp esz = a->esz;
@@ -5313,7 +5313,7 @@ static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
     }
     if (fp_access_check(s)) {
         gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
-                          esz == MO_16, 0, fns[esz - 1]);
+                          esz == MO_16, data, fns[esz - 1]);
     }
     return true;
 }
@@ -5323,168 +5323,168 @@ static gen_helper_gvec_3_ptr * const f_vector_fadd[3] = {
     gen_helper_gvec_fadd_s,
     gen_helper_gvec_fadd_d,
 };
-TRANS(FADD_v, do_fp3_vector, a, f_vector_fadd)
+TRANS(FADD_v, do_fp3_vector, a, 0, f_vector_fadd)
 
 static gen_helper_gvec_3_ptr * const f_vector_fsub[3] = {
     gen_helper_gvec_fsub_h,
     gen_helper_gvec_fsub_s,
     gen_helper_gvec_fsub_d,
 };
-TRANS(FSUB_v, do_fp3_vector, a, f_vector_fsub)
+TRANS(FSUB_v, do_fp3_vector, a, 0, f_vector_fsub)
 
 static gen_helper_gvec_3_ptr * const f_vector_fdiv[3] = {
     gen_helper_gvec_fdiv_h,
     gen_helper_gvec_fdiv_s,
     gen_helper_gvec_fdiv_d,
 };
-TRANS(FDIV_v, do_fp3_vector, a, f_vector_fdiv)
+TRANS(FDIV_v, do_fp3_vector, a, 0, f_vector_fdiv)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmul[3] = {
     gen_helper_gvec_fmul_h,
     gen_helper_gvec_fmul_s,
     gen_helper_gvec_fmul_d,
 };
-TRANS(FMUL_v, do_fp3_vector, a, f_vector_fmul)
+TRANS(FMUL_v, do_fp3_vector, a, 0, f_vector_fmul)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmax[3] = {
     gen_helper_gvec_fmax_h,
     gen_helper_gvec_fmax_s,
     gen_helper_gvec_fmax_d,
 };
-TRANS(FMAX_v, do_fp3_vector, a, f_vector_fmax)
+TRANS(FMAX_v, do_fp3_vector, a, 0, f_vector_fmax)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[3] = {
     gen_helper_gvec_fmin_h,
     gen_helper_gvec_fmin_s,
     gen_helper_gvec_fmin_d,
 };
-TRANS(FMIN_v, do_fp3_vector, a, f_vector_fmin)
+TRANS(FMIN_v, do_fp3_vector, a, 0, f_vector_fmin)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[3] = {
     gen_helper_gvec_fmaxnum_h,
     gen_helper_gvec_fmaxnum_s,
     gen_helper_gvec_fmaxnum_d,
 };
-TRANS(FMAXNM_v, do_fp3_vector, a, f_vector_fmaxnm)
+TRANS(FMAXNM_v, do_fp3_vector, a, 0, f_vector_fmaxnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[3] = {
     gen_helper_gvec_fminnum_h,
     gen_helper_gvec_fminnum_s,
     gen_helper_gvec_fminnum_d,
 };
-TRANS(FMINNM_v, do_fp3_vector, a, f_vector_fminnm)
+TRANS(FMINNM_v, do_fp3_vector, a, 0, f_vector_fminnm)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
     gen_helper_gvec_fmulx_h,
     gen_helper_gvec_fmulx_s,
     gen_helper_gvec_fmulx_d,
 };
-TRANS(FMULX_v, do_fp3_vector, a, f_vector_fmulx)
+TRANS(FMULX_v, do_fp3_vector, a, 0, f_vector_fmulx)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmla[3] = {
     gen_helper_gvec_vfma_h,
     gen_helper_gvec_vfma_s,
     gen_helper_gvec_vfma_d,
 };
-TRANS(FMLA_v, do_fp3_vector, a, f_vector_fmla)
+TRANS(FMLA_v, do_fp3_vector, a, 0, f_vector_fmla)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmls[3] = {
     gen_helper_gvec_vfms_h,
     gen_helper_gvec_vfms_s,
     gen_helper_gvec_vfms_d,
 };
-TRANS(FMLS_v, do_fp3_vector, a, f_vector_fmls)
+TRANS(FMLS_v, do_fp3_vector, a, 0, f_vector_fmls)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmeq[3] = {
     gen_helper_gvec_fceq_h,
     gen_helper_gvec_fceq_s,
     gen_helper_gvec_fceq_d,
 };
-TRANS(FCMEQ_v, do_fp3_vector, a, f_vector_fcmeq)
+TRANS(FCMEQ_v, do_fp3_vector, a, 0, f_vector_fcmeq)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmge[3] = {
     gen_helper_gvec_fcge_h,
     gen_helper_gvec_fcge_s,
     gen_helper_gvec_fcge_d,
 };
-TRANS(FCMGE_v, do_fp3_vector, a, f_vector_fcmge)
+TRANS(FCMGE_v, do_fp3_vector, a, 0, f_vector_fcmge)
 
 static gen_helper_gvec_3_ptr * const f_vector_fcmgt[3] = {
     gen_helper_gvec_fcgt_h,
     gen_helper_gvec_fcgt_s,
     gen_helper_gvec_fcgt_d,
 };
-TRANS(FCMGT_v, do_fp3_vector, a, f_vector_fcmgt)
+TRANS(FCMGT_v, do_fp3_vector, a, 0, f_vector_fcmgt)
 
 static gen_helper_gvec_3_ptr * const f_vector_facge[3] = {
     gen_helper_gvec_facge_h,
     gen_helper_gvec_facge_s,
     gen_helper_gvec_facge_d,
 };
-TRANS(FACGE_v, do_fp3_vector, a, f_vector_facge)
+TRANS(FACGE_v, do_fp3_vector, a, 0, f_vector_facge)
 
 static gen_helper_gvec_3_ptr * const f_vector_facgt[3] = {
     gen_helper_gvec_facgt_h,
     gen_helper_gvec_facgt_s,
     gen_helper_gvec_facgt_d,
 };
-TRANS(FACGT_v, do_fp3_vector, a, f_vector_facgt)
+TRANS(FACGT_v, do_fp3_vector, a, 0, f_vector_facgt)
 
 static gen_helper_gvec_3_ptr * const f_vector_fabd[3] = {
     gen_helper_gvec_fabd_h,
     gen_helper_gvec_fabd_s,
     gen_helper_gvec_fabd_d,
 };
-TRANS(FABD_v, do_fp3_vector, a, f_vector_fabd)
+TRANS(FABD_v, do_fp3_vector, a, 0, f_vector_fabd)
 
 static gen_helper_gvec_3_ptr * const f_vector_frecps[3] = {
     gen_helper_gvec_recps_h,
     gen_helper_gvec_recps_s,
     gen_helper_gvec_recps_d,
 };
-TRANS(FRECPS_v, do_fp3_vector, a, f_vector_frecps)
+TRANS(FRECPS_v, do_fp3_vector, a, 0, f_vector_frecps)
 
 static gen_helper_gvec_3_ptr * const f_vector_frsqrts[3] = {
     gen_helper_gvec_rsqrts_h,
     gen_helper_gvec_rsqrts_s,
     gen_helper_gvec_rsqrts_d,
 };
-TRANS(FRSQRTS_v, do_fp3_vector, a, f_vector_frsqrts)
+TRANS(FRSQRTS_v, do_fp3_vector, a, 0, f_vector_frsqrts)
 
 static gen_helper_gvec_3_ptr * const f_vector_faddp[3] = {
     gen_helper_gvec_faddp_h,
     gen_helper_gvec_faddp_s,
     gen_helper_gvec_faddp_d,
 };
-TRANS(FADDP_v, do_fp3_vector, a, f_vector_faddp)
+TRANS(FADDP_v, do_fp3_vector, a, 0, f_vector_faddp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxp[3] = {
     gen_helper_gvec_fmaxp_h,
     gen_helper_gvec_fmaxp_s,
     gen_helper_gvec_fmaxp_d,
 };
-TRANS(FMAXP_v, do_fp3_vector, a, f_vector_fmaxp)
+TRANS(FMAXP_v, do_fp3_vector, a, 0, f_vector_fmaxp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminp[3] = {
     gen_helper_gvec_fminp_h,
     gen_helper_gvec_fminp_s,
     gen_helper_gvec_fminp_d,
 };
-TRANS(FMINP_v, do_fp3_vector, a, f_vector_fminp)
+TRANS(FMINP_v, do_fp3_vector, a, 0, f_vector_fminp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnmp[3] = {
     gen_helper_gvec_fmaxnump_h,
     gen_helper_gvec_fmaxnump_s,
     gen_helper_gvec_fmaxnump_d,
 };
-TRANS(FMAXNMP_v, do_fp3_vector, a, f_vector_fmaxnmp)
+TRANS(FMAXNMP_v, do_fp3_vector, a, 0, f_vector_fmaxnmp)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
     gen_helper_gvec_fminnump_h,
     gen_helper_gvec_fminnump_s,
     gen_helper_gvec_fminnump_d,
 };
-TRANS(FMINNMP_v, do_fp3_vector, a, f_vector_fminnmp)
+TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
-- 
2.34.1


