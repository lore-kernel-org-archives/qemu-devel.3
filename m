Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313A3C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONa-0001EK-Hl; Tue, 01 Sep 2026 09:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONV-0001CK-JJ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:17 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONT-0007Iw-DR
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:17 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so786087866b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268694; x=1788873494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SwN7fvVZ8M13AiEa1TXkKrudgvk3fc/1walmMso5UkI=;
 b=loVp/0a35aHhnypkok3xzb2gAYuRugnhNb5A4Aq9uRXonOoQNBpsGXhQKbwV0NUN5N
 2R20lWL2mlBgJo+gkhgaNjsFYSPI5p3mMSPwHrUVb5i/psU8ijK/LipyV7nkRn+/f339
 QYHIqdCSs9bKBIAGumX+Y5EVrZmU3o6oy+BOOiZvbgRcZQ6GXPQOh8ysz+fJjGSuKdUq
 WH/rOyS4J2XO9hFHtvpa1enOAb161mlhwbSxcpLYWhXRwHD85yyYhtbkuGdLW47V8Vax
 ieQC5TqyUFoj6J2UzyJOT4E7iv4Ch16a447WpTOl/IG4Alo6FYzhg330e94O8rhAFMSm
 +JLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268694; x=1788873494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SwN7fvVZ8M13AiEa1TXkKrudgvk3fc/1walmMso5UkI=;
 b=Vs2Jw+d/gEX/gCsTZolrmsms576rC9wyYakCyEQLsRFMg8u+LF7wiIvDxSyuoFKHf/
 8n7k9EbRqBiq17A+biadl2bvR/x2QAB47zCIx/8LeDByejsy0x0doE4YBMxULUBawIKd
 EA2/TOmAK+3yGoOiCxYT1DJ3NlGA7VzqMvyueMm6e9ahUI8i/Z0QRN/Y4WDbJ/ZQZH2N
 pzyilbxQbKMRgrFYuDPScEliTqWrcoSvbtXRZSdgKi12UtC/LqEFOGzQVAfXL/rpQKWu
 xNu7kcX4IwKkEmVa4EBZ0QHKcZ0D9hy1Q2m+lLekJj6UdmzcTNsXrNwdXqpFx9SQgxds
 DXOg==
X-Gm-Message-State: AFuF++nUDVgipnGsTo4HjVEx1nIdrBToShlQMfI7pORFFBIYzzyMF5+S
 zNNXfuynCZ/QubTe4utTqjAj7OzgaT6u2fB3OnC2RhxDWfYGX2WMDMuppvnJ9SRRidR4DxYxGz4
 PAdyme2I=
X-Gm-Gg: AR+sD12rm2i0s5QQGW2Xs4pLJyKqlOSnrO/t6Hwh+oolEHQHY33QCMEWtveyB0SUqdT
 TYWsmGRRkFKdPNJl1+aV16KQYJ0hqP+SJLwHH0zCzghUbgIT7bYfPQ3L1n0mN9oNeFsg46gOCL+
 OT3zYmrE4S//I3sv+RVAWQl1MfWYZ/XfEucWJZ+BZ6so/Pbi7yxCnUjPaviGnexjCTW7HGpGQWW
 7V5ZEMBul8DZ398dl5Wa1QUfRhF2D0wMjcRBGf4de934O6iHccLfOHgvPGtyzjT2tYKfdD2ZmmS
 Vg2MMPL0sFengskP3SDXNqhZhDHjP9I5qycig7t8pz7p3Qy9V1zmF0T6XzIAhbI8u0gSN157/km
 H4HLz43D2aIG3g60v15ovSJjL7FERhnDCmT5tNFTMzTIEw5Ja96BgnLe2szjwKxN92NbbZsGJ/T
 dYpwV1b6og1t7L+6HZiHn/p2lG68Z/vsaus4k/NiGNb4PCrYTdCEqIR3BjB85DeavLyZWSgnJH1
 bztp/SPNjM8xcZgNOUyUuTDKxSO/b4EKlok039UHP9CE7OcEzJhLsfHnCrt19bKW2h+lg==
X-Received: by 2002:a17:906:2449:b0:c20:ff26:336e with SMTP id
 a640c23a62f3a-c25b3c9aac4mr479743266b.14.1788268693972; 
 Tue, 01 Sep 2026 06:18:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/58] target/arm: Remove DO_ZPZZ_FP_B16 from translate-sme.c
Date: Tue,  1 Sep 2026 14:17:14 +0100
Message-ID: <20260901131732.2263947-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

Expand the macro at each use site.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260826174213.614571-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 59 ++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7e0b47412ba..347eeb4602e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4438,14 +4438,6 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-/* Similar, but for insns where sz == 0 encodes bfloat16 */
-#define DO_ZPZZ_FP_B16(NAME, FEAT, name) \
-    static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = { \
-        gen_helper_##name##_b16, gen_helper_##name##_h,         \
-        gen_helper_##name##_s, gen_helper_##name##_d            \
-    };                                                          \
-    TRANS_FEAT(NAME, FEAT, gen_gvec_fpst_arg_zpzz, name##_zpzz_fns[a->esz], a)
-
 #define DO_ZPZZ_AH_FP_B16(NAME, FEAT, name, ah_name)                    \
     static gen_helper_gvec_4_ptr * const name##_zpzz_fns[4] = {         \
         gen_helper_##name##_b16, gen_helper_##name##_h,                 \
@@ -4459,13 +4451,54 @@ TRANS_FEAT_NONSTREAMING(FTSMUL, aa64_sve, gen_gvec_fpst_arg_zzz,
                s->fpcr_ah ? name##_ah_zpzz_fns[a->esz] :                \
                name##_zpzz_fns[a->esz], a)
 
-DO_ZPZZ_FP_B16(FADD_zpzz, aa64_sme_or_sve, sve_fadd)
-DO_ZPZZ_FP_B16(FSUB_zpzz, aa64_sme_or_sve, sve_fsub)
-DO_ZPZZ_FP_B16(FMUL_zpzz, aa64_sme_or_sve, sve_fmul)
+static gen_helper_gvec_4_ptr * const sve_fadd_zpzz_fns[4] = {
+    gen_helper_sve_fadd_b16,
+    gen_helper_sve_fadd_h,
+    gen_helper_sve_fadd_s,
+    gen_helper_sve_fadd_d
+};
+TRANS_FEAT(FADD_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fadd_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fsub_zpzz_fns[4] = {
+    gen_helper_sve_fsub_b16,
+    gen_helper_sve_fsub_h,
+    gen_helper_sve_fsub_s,
+    gen_helper_sve_fsub_d
+};
+TRANS_FEAT(FSUB_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fsub_zpzz_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fmul_zpzz_fns[4] = {
+    gen_helper_sve_fmul_b16,
+    gen_helper_sve_fmul_h,
+    gen_helper_sve_fmul_s,
+    gen_helper_sve_fmul_d
+};
+TRANS_FEAT(FMUL_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmul_zpzz_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP_B16(FMIN_zpzz, aa64_sme_or_sve, sve_fmin, sve_ah_fmin)
 DO_ZPZZ_AH_FP_B16(FMAX_zpzz, aa64_sme_or_sve, sve_fmax, sve_ah_fmax)
-DO_ZPZZ_FP_B16(FMINNM_zpzz, aa64_sme_or_sve, sve_fminnum)
-DO_ZPZZ_FP_B16(FMAXNM_zpzz, aa64_sme_or_sve, sve_fmaxnum)
+
+static gen_helper_gvec_4_ptr * const sve_fmaxnum_fns[4] = {
+    gen_helper_sve_fmaxnum_b16,
+    gen_helper_sve_fmaxnum_h,
+    gen_helper_sve_fmaxnum_s,
+    gen_helper_sve_fmaxnum_d
+};
+TRANS_FEAT(FMAXNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fmaxnum_fns[a->esz], a)
+
+static gen_helper_gvec_4_ptr * const sve_fminnum_fns[4] = {
+    gen_helper_sve_fminnum_b16,
+    gen_helper_sve_fminnum_h,
+    gen_helper_sve_fminnum_s,
+    gen_helper_sve_fminnum_d
+};
+TRANS_FEAT(FMINNM_zpzz, aa64_sme_or_sve, gen_gvec_fpst_arg_zpzz,
+           sve_fminnum_fns[a->esz], a)
+
 DO_ZPZZ_AH_FP(FABD, aa64_sme_or_sve, sve_fabd, sve_ah_fabd)
 
 static gen_helper_gvec_4_ptr * const sve_fscalbn_zpzz_fns[4] = {
-- 
2.43.0


