Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EDEC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONa-0001El-VJ; Tue, 01 Sep 2026 09:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONY-0001DP-AJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:20 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONW-0007K6-AV
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:19 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so715295866b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268697; x=1788873497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ck+G1J8XeMofV26XYg3w08XT7q7hGF82RVGXpKaMHQE=;
 b=TBuAwzz4Vw/adC1Eo1GSOtSI+LMYhBI9LycEVTg3EDXycb1sYueOeUgPAkJYnhvchm
 W0n/Y3VTSrESZn1flhA+2+w+RLGpHWhhcf/6+nQNUFqGmcOGnR/EAItO8BT5f5WL8LcP
 97zbFNKInYazoBUYXKSCpRy0z2z1twt0EkOjnAIcrby/LKi8UUnjAX/deXePhgQG7dw+
 nyYSnE2Zt1DL4lXHl4A26h9O6JjYQznOsHroga9d8k/v6zRWtrW7ZjCX7jaa3seKtH4d
 rn6qnj5eaXL6MxWSuMR4r+U1FvuOuwf0Tt1nk9s8b11CfhC6S1+ZiTxaCFJyAGa7y8ZA
 uFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268697; x=1788873497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ck+G1J8XeMofV26XYg3w08XT7q7hGF82RVGXpKaMHQE=;
 b=SZmMpDOcExCf2AmUG4OtcT4Mp2OvBgZoj71evPF6rkiDv6o/8sZdkWQMSJZY+wOSbT
 nrIOKdmP74zvDMTu3HYcerTGgG5dM3gMLOpU+gseRcpn9bnTwJgb1RfjOBlbmDevFkmG
 4+m6UuNJJdSZ/xZzD5vcKn4UKvioHFf8IGa2d/HdrT4EeXdZ5EgD0phFcqGtQuBoK5dR
 Ykn+HBYFazgOXwMRn0z04+Q3kiKPDxGH1BC7P2wo2ZSQuEbRYcsl0BcaLxo/tk2/HyDn
 BMK4jvEnvEKm15n4JOtSpG1sZSrtgJAJ4sxhSd12SyXBdCMuWA0Ow14yLnm0r5sLRF7X
 4XiQ==
X-Gm-Message-State: AFuF++ldWIC2594FBIhA25j2vWV97H34jLioVDRFqqn8vVYViuANAF6s
 8tLPm58NIdwdf3vXVjyUQ1cz95562EcLD6bSoyfQNHrQlFF3ez5jbcR6CbPgPWLxsB47vMyH3t9
 IHZfXvgw=
X-Gm-Gg: AR+sD11726bXWRleCnlSaQ4MzLB3vaoDM1S7zjwoMmKkV82affc1884/eBMpFy+7hDf
 evv2tEp3K/qc2nW34CX+ZyQe7qU1ke2Uz6YWa6o7bX/xpGvpogzkmaZUhSJjFU3CsXdcIxY1Hlm
 W7TDeZGGs3HcyCX/DjlIFx1BNX+qm8jJy4cZTtFDPRG+Q6gUm8IS28yCvMQmc8FGl8sOFZeXZqa
 Pr9dUICXN7GtaXJJnVTa+FMBifcOs7YfvSxAner/gsdDs5rLDi5fipmTFpc+VmJ0CMfY2VFvnag
 u+xAslkxGMMCuij8e0EQ9lxiPNGaQBznehNYUfiaJoZZHphaT9iLcAzQ/VETOXg5kuy+K1JKqHS
 Cldhk6WhP98hBlQXuDMuUfs2ljhOfmJA224PC1Tjg7KpneAc9T3c+2opKlGO7muZvqqCIEM0GFE
 NosJtEGwws1Pob8piRAV6DUF6tVgvjqrG/2UDub6opBIRofMZrx75gbgMgl6fzAe9ihY+h57+AE
 gNrTzbrNsouqOtO7g6o/sm6ZXAnPVn+KLVld/EyzXixLalpLKj8k1weEoDtGwSkZJJWQn0=
X-Received: by 2002:a17:907:8b95:b0:c19:6104:e5e4 with SMTP id
 a640c23a62f3a-c25571fecb8mr2220603166b.20.1788268696859; 
 Tue, 01 Sep 2026 06:18:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/58] target/arm: Split decode of BFloat SVE FADD, FSUB, FMUL,
 FMIN*, FMAX*
Date: Tue,  1 Sep 2026 14:17:17 +0100
Message-ID: <20260901131732.2263947-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Split decode so that feature detection can be handled
external to gen_gvec_fpst_arg_zpzz

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 38 +++++++++++++++++++++++++++-------
 target/arm/tcg/translate-sve.c | 32 ++++++++++++++++++----------
 2 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index bdc2b7f0c04..07dac681acf 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -159,6 +159,9 @@
 @rd_pg4_rn_rm   ........ esz:2 . rm:5  .. pg:4  rn:5 rd:5       &rprr_esz
 @pd_pg_rn_rm    ........ esz:2 . rm:5 ... pg:3 rn:5 . rd:4      &rprr_esz
 
+@rdn_pg_rm_e0   ........ .. ... ... ... pg:3 rm:5 rd:5 \
+                &rprr_esz esz=0 rn=%reg_movprfx
+
 # Three register operand, with governing predicate, vector element size
 @rda_pg_rn_rm   ........ esz:2 . rm:5  ... pg:3 rn:5 rd:5 \
                 &rprrr_esz ra=%reg_movprfx
@@ -1163,14 +1166,35 @@ FRSQRTS         01100101 .. 0 ..... 000 111 ..... .....         @rd_rn_rm
 ### SVE FP Arithmetic Predicated Group
 
 # SVE floating-point arithmetic (predicated)
-FADD_zpzz       01100101 .. 00 0000 100 ... ..... .....    @rdn_pg_rm
-FSUB_zpzz       01100101 .. 00 0001 100 ... ..... .....    @rdn_pg_rm
-FMUL_zpzz       01100101 .. 00 0010 100 ... ..... .....    @rdn_pg_rm
+{
+  BFADD_zpzz    01100101 00 00 0000 100 ... ..... .....    @rdn_pg_rm_e0
+  FADD_zpzz     01100101 .. 00 0000 100 ... ..... .....    @rdn_pg_rm
+}
+{
+  BFSUB_zpzz    01100101 00 00 0001 100 ... ..... .....    @rdn_pg_rm_e0
+  FSUB_zpzz     01100101 .. 00 0001 100 ... ..... .....    @rdn_pg_rm
+}
+{
+  BFMUL_zpzz    01100101 00 00 0010 100 ... ..... .....    @rdn_pg_rm_e0
+  FMUL_zpzz     01100101 .. 00 0010 100 ... ..... .....    @rdn_pg_rm
+}
 FSUB_zpzz       01100101 .. 00 0011 100 ... ..... .....    @rdm_pg_rn # FSUBR
-FMAXNM_zpzz     01100101 .. 00 0100 100 ... ..... .....    @rdn_pg_rm
-FMINNM_zpzz     01100101 .. 00 0101 100 ... ..... .....    @rdn_pg_rm
-FMAX_zpzz       01100101 .. 00 0110 100 ... ..... .....    @rdn_pg_rm
-FMIN_zpzz       01100101 .. 00 0111 100 ... ..... .....    @rdn_pg_rm
+{
+  BFMAXNM_zpzz  01100101 00 00 0100 100 ... ..... .....    @rdn_pg_rm_e0
+  FMAXNM_zpzz   01100101 .. 00 0100 100 ... ..... .....    @rdn_pg_rm
+}
+{
+  BFMINNM_zpzz  01100101 00 00 0101 100 ... ..... .....    @rdn_pg_rm_e0
+  FMINNM_zpzz   01100101 .. 00 0101 100 ... ..... .....    @rdn_pg_rm
+}
+{
+  BFMAX_zpzz    01100101 00 00 0110 100 ... ..... .....    @rdn_pg_rm_e0
+  FMAX_zpzz     01100101 .. 00 0110 100 ... ..... .....    @rdn_pg_rm
+}
+{
+  BFMIN_zpzz    01100101 00 00 0111 100 ... ..... .....    @rdn_pg_rm_e0
+  FMIN_zpzz     01100101 .. 00 0111 100 ... ..... .....    @rdn_pg_rm
+}
 FABD            01100101 .. 00 1000 100 ... ..... .....    @rdn_pg_rm
 FSCALE          01100101 .. 00 1001 100 ... ..... .....    @rdn_pg_rm
 FMULX           01100101 .. 00 1010 100 ... ..... .....    @rdn_pg_rm
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f65c2b0af53..0ad0aff0504 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -412,10 +412,6 @@ static bool gen_gvec_fpst_zzzp(DisasContext *s, gen_helper_gvec_4_ptr *fn,
 static bool gen_gvec_fpst_arg_zpzz(DisasContext *s, gen_helper_gvec_4_ptr *fn,
                                    arg_rprr_esz *a)
 {
-    /* These insns use MO_8 to encode BFloat16. */
-    if (a->esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     return gen_gvec_fpst_zzzp(s, fn, a->rd, a->rn, a->rm, a->pg, 0,
                               a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
 }
@@ -4426,65 +4422,79 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
  */
 
 static gen_helper_gvec_4_ptr * const sve_fadd_zpzz_fns[4] = {
-    gen_helper_sve_fadd_b16,
+    NULL,
     gen_helper_sve_fadd_h,
     gen_helper_sve_fadd_s,
     gen_helper_sve_fadd_d
 };
+TRANS_FEAT(BFADD_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fadd_b16, a)
 TRANS_FEAT(FADD_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fadd_zpzz_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve_fsub_zpzz_fns[4] = {
-    gen_helper_sve_fsub_b16,
+    NULL,
     gen_helper_sve_fsub_h,
     gen_helper_sve_fsub_s,
     gen_helper_sve_fsub_d
 };
+TRANS_FEAT(BFSUB_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fsub_b16, a)
 TRANS_FEAT(FSUB_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fsub_zpzz_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
-    gen_helper_sve_fmul_b16,
+    NULL,
     gen_helper_sve_fmul_h,
     gen_helper_sve_fmul_s,
     gen_helper_sve_fmul_d
 };
+TRANS_FEAT(BFMUL_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fmul_b16, a)
 TRANS_FEAT(FMUL_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fmul_zpzz_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve_fmin_fns[4][2] = {
-    { gen_helper_sve_fmin_b16, gen_helper_sve_ah_fmin_b16 },
+    { NULL, NULL },
     { gen_helper_sve_fmin_h, gen_helper_sve_ah_fmin_h },
     { gen_helper_sve_fmin_s, gen_helper_sve_ah_fmin_s },
     { gen_helper_sve_fmin_d, gen_helper_sve_ah_fmin_d },
 };
+TRANS_FEAT(BFMIN_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           s->fpcr_ah ? gen_helper_sve_ah_fmin_b16 : gen_helper_sve_fmin_b16, a)
 TRANS_FEAT(FMIN_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fmin_fns[a->esz][s->fpcr_ah], a)
 
 static gen_helper_gvec_4_ptr * const sve_fmax_fns[4][2] = {
-    { gen_helper_sve_fmax_b16, gen_helper_sve_ah_fmax_b16 },
+    { NULL, NULL },
     { gen_helper_sve_fmax_h, gen_helper_sve_ah_fmax_h },
     { gen_helper_sve_fmax_s, gen_helper_sve_ah_fmax_s },
     { gen_helper_sve_fmax_d, gen_helper_sve_ah_fmax_d },
 };
+TRANS_FEAT(BFMAX_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           s->fpcr_ah ? gen_helper_sve_ah_fmax_b16 : gen_helper_sve_fmax_b16, a)
 TRANS_FEAT(FMAX_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fmax_fns[a->esz][s->fpcr_ah], a)
 
 static gen_helper_gvec_4_ptr * const sve_fmaxnum_fns[4] = {
-    gen_helper_sve_fmaxnum_b16,
+    NULL,
     gen_helper_sve_fmaxnum_h,
     gen_helper_sve_fmaxnum_s,
     gen_helper_sve_fmaxnum_d
 };
+TRANS_FEAT(BFMAXNM_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fmaxnum_b16, a)
 TRANS_FEAT(FMAXNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fmaxnum_fns[a->esz], a)
 
 static gen_helper_gvec_4_ptr * const sve_fminnum_fns[4] = {
-    gen_helper_sve_fminnum_b16,
+    NULL,
     gen_helper_sve_fminnum_h,
     gen_helper_sve_fminnum_s,
     gen_helper_sve_fminnum_d
 };
+TRANS_FEAT(BFMINNM_zpzz, aa64_sve_b16b16, gen_gvec_fpst_arg_zpzz,
+           gen_helper_sve_fminnum_b16, a)
 TRANS_FEAT(FMINNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
            sve_fminnum_fns[a->esz], a)
 
-- 
2.43.0


