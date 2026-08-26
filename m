Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A136EC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHdx-00005y-4d; Wed, 26 Aug 2026 13:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHdv-000052-6n
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:31 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzHds-0004nO-P0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:42:30 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-8487214ad2bso1588763b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787766147; x=1788370947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DWCIzduTnIm/W3WV2rk4cBKBAcF8NJBxjO9vrqzDujQ=;
 b=PlVDiviRVv6hn/17DgUF2GmVSgagdLRCF/X7i+h6Z0yQCOsDKd9LD/rAC2Z9t+8sHk
 nC14Jvf7cmRN87dewxuXsb95/ZFX+I6CeQVsSn3mDhNx20qErnObSx0yqpcO1/uEvaaZ
 kUzHCU0pHtu7VsX+u9zhwOpr2vyXzzszWkQMOgCxCmQUMiCMoQawOWHLTQwDXptHYwho
 nr7V/8neS7QCCAOJz+7/xrG4gmi3WZE2jsZnr2u0n5/z8CtJg7qxzxQ1iWY6s3Nsml/a
 d6n3jeuSGftJbs9ppiaQGqxNI2DrHvcPXL6rzE8iqBXbgR4e00weO0qbCWoyUyP7EOiN
 oHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766147; x=1788370947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DWCIzduTnIm/W3WV2rk4cBKBAcF8NJBxjO9vrqzDujQ=;
 b=fH8zIp2/eFRQcOgeTMMhFQ0o+2hYpe/i/xlUpoBmtuj2D8635+UHT293TNOSuQ0xxR
 p/qU/6Y3JXNQ8p56PsIgF1J/XDyuW1XwPLHqNHGvQ7fmyXYKZeh1JnqkNGMljv6+Vp8b
 PgrTzZPHfazvrfo1s/Av+o6xKH6hupBwe+jCZQGAdGvqegLMTKLby+G3ZdPXQqip8dTb
 cI/BYPcXkNO04PjLJ/xyXw4WQJzq/EFwEokDHAm6/+ttzi0ft6wmIPRgZBaMH51CL+Y1
 2cfYSn/b2aRLUMXzPYKb9FaKeS8bOJgZhWXbPDPruwZB8Sa3gg7pmP9/rhmTPADpsExK
 kpGg==
X-Gm-Message-State: AFuF++kRaVBmlcrpNpow9S9nHAZKc25nrEwlHeDM1TjMgE7t/z/pZpoj
 El33nlbi8Gby2/FVYv6fKonIuLMYsPwJBkF/Nzo8B8+/wh0YApdiqzb6YNgj2Vexr61mU8jNOLC
 xngCPTjQ=
X-Gm-Gg: AR+sD13Fvj4J/gabESdgrHmo6N9ilYGgmYF0MrArh6ikEKWl2iBEWvfwzx0ShgPZYG6
 BOKXAzoggIHJfKcjmnm+tZxTAbFGHz0n8V042k++oTI8FHB8W2mwEIOZ8T7B0ebl32PJde28E3K
 NOJWrvDE36ceC20esZtMRcmnJtSjSV5iYKv7l9KwrZhPFxjMrtMcTLewuF0KkgmyW/WIWlf2PPe
 qJxqHqY8qqRggAA1vjup4ZvHg/dEhgvhOrSGQMlbECHSX1aC8VbbYLY97ROoDqlby4gTJFTuBSu
 ubum0ATzDMGlFUBgrjacoN99emQcv3jYEyovJ0Dg2DMkkVcnDIASPXSb4OwFtCPsmeMlHbtTrrt
 M/OMVeiGgCqjKTND1jRLFHNaMXpe53/0ZqZ5GG3t+4nd4TwGmooQWtK1exJ1oA63NB+TqtgauI9
 Wqzqwb9RwjtKb8CjD8W+LgIc1xButtgzV2PNmv349M+T/L06nB61aNHDerKf2ILZ8U9XWZDjFHb
 c6UgcGBeOFy81o7qw==
X-Received: by 2002:a05:6a00:4149:b0:852:5f99:1866 with SMTP id
 d2e1a72fcca58-8536e922f5fmr17206220b3a.0.1787766147163; 
 Wed, 26 Aug 2026 10:42:27 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1bec66020sm1260072a12.21.2026.08.26.10.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:42:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 10/25] target/arm: Split decode of BFloat SVE FADD, FSUB,
 FMUL, FMIN*, FMAX*
Date: Wed, 26 Aug 2026 10:41:57 -0700
Message-ID: <20260826174213.614571-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826174213.614571-1-richard.henderson@linaro.org>
References: <20260826174213.614571-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Split decode so that feature detection can be handled
external to gen_gvec_fpst_arg_zpzz

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 32 ++++++++++++++++++----------
 target/arm/tcg/sve.decode      | 38 +++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 18 deletions(-)

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
-- 
2.53.0


