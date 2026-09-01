Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07BCC624D6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONU-0001C2-SD; Tue, 01 Sep 2026 09:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONS-0001Ak-IB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:14 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ONP-0007GP-WE
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:18:14 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c252e703fa3so695026866b.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268690; x=1788873490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5U12lIw1c5aBXHBCH22nJ4Zf+RMwsV1U7ktFmfhbXnw=;
 b=obSBzV7e4LRrONU7GjrTxiJBoFCH4/Qbr9GbdUxlecZ/n7bxuNHe+6y/GZDjSE0Ix6
 pazaPNmHHDuxggm6i+HLPQsN1CzLqVqP72uS2EyfZRVjFIi9a/ilU4VPC4a2jJ2Gxl0V
 u46+/x1XylGxqmfpwAq9ZIMCnJ5uMVS1poYWwZAVWVbtDOHtO34w54ble2vfBx8VUYxm
 XP5Kn4qPbQDoDot+z8d7utJKHOrvfhiB33MGgqgNKOjI335xnaNhRW8yhr0LX5Z2vOzL
 EQEA0REYv/RYSoDPWJtuhN+0jfi8dS00SH7vPFqV4RhC9GavlT2aNXd6yuI1B1aTbr+3
 wFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268690; x=1788873490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5U12lIw1c5aBXHBCH22nJ4Zf+RMwsV1U7ktFmfhbXnw=;
 b=oEPM5oWRq7qBw+7gi7JUMazV+RG0Ip3hcuMraMIXNKV9Xbxk/D8+Ofrmivr4rZtlyI
 ZUTyfancfJt2vUgDGpahso4coZGScF4tkOngY9euI3GoVSwyWh8QGHtW7tsZ7qnyWClW
 cFDarsXPXPf2qVh7PibpRYrHFNeZ92OA7OQAb2k3jWf+RoWzeWo45yKQ5CtPP6RTRhH4
 9qZv8eo0MOaCOqwOE5A2P3y2kff7pdtt65BtVmLNdD7BQ5qfnktk+2suR/ssieEo5VVG
 Sv8MAvrfU4jORPdO/gWUZfN5L2vIzVELgdRRBdanrg95Up6F4X6pPcQeLHod/euS0n+p
 MgyQ==
X-Gm-Message-State: AFuF++nza7XJL+LkL6g8R1G7zPrEsXppR5s7YRbFy+V6SeyK1CQ50GK2
 IVBl76u0DCi36XvZkSpY/cVhGc543Wq/x9IiBzmyB5Al7L1R8VsJ8E8IDwT2s4EJbjCP9kVoVGX
 i5ryOEtU=
X-Gm-Gg: AR+sD10AM9KdS5cKuwN5rYFpgocBPs6XMvq6vKQiQiXK5YmT5Qb0IptUlYkXDbFvza0
 4zueH2tkY4HzyJuSgE+aX0Y4EhVi1Y20PzlU7SuTOyXG8K5Pl1N1VVGZmdcuGBnG6fPfQT4VZ6w
 O/bP9OP4OK0pwcReR82ZWTRgjSDY7Z23FR9b16hGDSwdFk+HNGkhte6OPNAgkEIIdC5fMD3Kksf
 K3h0eY93Vm+5nWYPeKtWwXBPrhmXiicAZWMWtsnxmlCViFGfm164mvTW6gSZJz64jsvDf+CoEdq
 2QYdxyzlWxjDPLP5VEOr19ujWJzlG6DUF8AfnUAxcxKBbNWV73UQuFFZSqRol35ocUNfbRTCoDK
 cv7VomntOAysh40S6THfuzgvsemHyrFLcUGSNi2raimCbIBRmxB93IYARS3TWNwfNQ90B5zs1dS
 Ib1XvWoul3TWLTPCxVQPlXXn9O7QWgf0r2VXag3GWO5sJcbzNlymo8xy0jlpamD4YWxP34UtgRJ
 WmirIAu8DSqPtX5Rm3G0HyvfWJ71GNpIooFfOUs+ZT41raJtMFDeHUYzFCsKv/kUiK4w4tGKqQB
 d0+/
X-Received: by 2002:a17:906:e20b:b0:c25:659:89ba with SMTP id
 a640c23a62f3a-c25b3bda164mr467767766b.9.1788268690232; 
 Tue, 01 Sep 2026 06:18:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.18.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:18:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/58] target/arm: Split decode of BFloat SME FMAX/FMIN
Date: Tue,  1 Sep 2026 14:17:10 +0100
Message-ID: <20260901131732.2263947-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
external to do_zzz_{n1,nn}_fpst.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260826174213.614571-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 ++
 target/arm/tcg/sme.decode      | 90 ++++++++++++++++++++++++++++------
 target/arm/tcg/translate-sme.c | 65 +++++++++++++-----------
 3 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 3c8d7033dea..b803fff2ffa 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1748,6 +1748,11 @@ static inline bool isar_feature_aa64_sme2p2_or_sve2p2(const ARMISARegisters *id)
     return isar_feature_aa64_sme2p2(id) || isar_feature_aa64_sve2p2(id);
 }
 
+static inline bool isar_feature_aa64_sme2_sve_b16b16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_sve_b16b16(id);
+}
+
 static inline bool isar_feature_aa64_sme2_i16i64(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_i16i64(id);
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 36fbe24faf8..e1bef9987b0 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -227,6 +227,11 @@ UMOPA2_s        1010000 1 10 0 ..... ... ... ..... . 10 ..      @op_32
 @z2z_4x1        ....... . esz:2 .. zm:4 ....1. ..... ...0 . \
                 &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4
 
+@z2z_2x1_e0     ....... . .. .. zm:4 ....0. ..... .... . \
+                &zzz_en esz=0 n=2 zd=%zd_ax2 zn=%zd_ax2
+@z2z_4x1_e0     ....... . .. .. zm:4 ....1. ..... ...0 . \
+                &zzz_en esz=0 n=4 zd=%zd_ax4 zn=%zd_ax4
+
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_2x1
 SMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 0    @z2z_4x1
 UMAX_n1        1100000 1 .. 10 .... 1010.0 00000 .... 1    @z2z_2x1
@@ -236,14 +241,38 @@ SMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 0    @z2z_4x1
 UMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 1    @z2z_2x1
 UMIN_n1        1100000 1 .. 10 .... 1010.0 00001 .... 1    @z2z_4x1
 
-FMAX_n1        1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_2x1
-FMAX_n1        1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_4x1
-FMIN_n1        1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_2x1
-FMIN_n1        1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_4x1
-FMAXNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_2x1
-FMAXNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_4x1
-FMINNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_2x1
-FMINNM_n1      1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_4x1
+{
+  BFMAX_n1     1100000 1 00 10 .... 1010.0 01000 .... 0    @z2z_2x1_e0
+  FMAX_n1      1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_2x1
+}
+{
+  BFMAX_n1     1100000 1 00 10 .... 1010.0 01000 .... 0    @z2z_4x1_e0
+  FMAX_n1      1100000 1 .. 10 .... 1010.0 01000 .... 0    @z2z_4x1
+}
+{
+  BFMIN_n1     1100000 1 00 10 .... 1010.0 01000 .... 1    @z2z_2x1_e0
+  FMIN_n1      1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_2x1
+}
+{
+  BFMIN_n1     1100000 1 00 10 .... 1010.0 01000 .... 1    @z2z_4x1_e0
+  FMIN_n1      1100000 1 .. 10 .... 1010.0 01000 .... 1    @z2z_4x1
+}
+{
+  BFMAXNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 0    @z2z_2x1_e0
+  FMAXNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_2x1
+}
+{
+  BFMAXNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 0    @z2z_4x1_e0
+  FMAXNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 0    @z2z_4x1
+}
+{
+  BFMINNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 1    @z2z_2x1_e0
+  FMINNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_2x1
+}
+{
+  BFMINNM_n1   1100000 1 00 10 .... 1010.0 01001 .... 1    @z2z_4x1_e0
+  FMINNM_n1    1100000 1 .. 10 .... 1010.0 01001 .... 1    @z2z_4x1
+}
 
 SRSHL_n1       1100000 1 .. 10 .... 1010.0 10001 .... 0    @z2z_2x1
 SRSHL_n1       1100000 1 .. 10 .... 1010.0 10001 .... 0    @z2z_4x1
@@ -269,6 +298,11 @@ FSCALE_n1      1100000 1 .. 10 .... 1010.0 01100 .... 0    @z2z_4x1
 @z2z_4x4        ....... . esz:2 . ...00 ....1. ..... ...0 . \
                 &zzz_en n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
 
+@z2z_2x2_e0     ....... . .. . ....0 ....0. ..... .... . \
+                &zzz_en esz=0 n=2 zd=%zd_ax2 zn=%zd_ax2 zm=%zm_ax2
+@z2z_4x4_e0     ....... . .. . ...00 ....1. ..... ...0 . \
+                &zzz_en esz=0 n=4 zd=%zd_ax4 zn=%zd_ax4 zm=%zm_ax4
+
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_2x2
 SMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 0    @z2z_4x4
 UMAX_nn        1100000 1 .. 1 ..... 1011.0 00000 .... 1    @z2z_2x2
@@ -278,14 +312,38 @@ SMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 0    @z2z_4x4
 UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_2x2
 UMIN_nn        1100000 1 .. 1 ..... 1011.0 00001 .... 1    @z2z_4x4
 
-FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
-FMAX_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
-FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
-FMIN_nn        1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
-FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
-FMAXNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
-FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
-FMINNM_nn      1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+{
+  BFMAX_nn     1100000 1 00 1 ..... 1011.0 01000 .... 0    @z2z_2x2_e0
+  FMAX_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_2x2
+}
+{
+  BFMAX_nn     1100000 1 00 1 ..... 1011.0 01000 .... 0    @z2z_4x4_e0
+  FMAX_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 0    @z2z_4x4
+}
+{
+  BFMIN_nn     1100000 1 00 1 ..... 1011.0 01000 .... 1    @z2z_2x2_e0
+  FMIN_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_2x2
+}
+{
+  BFMIN_nn     1100000 1 00 1 ..... 1011.0 01000 .... 1    @z2z_4x4_e0
+  FMIN_nn      1100000 1 .. 1 ..... 1011.0 01000 .... 1    @z2z_4x4
+}
+{
+  BFMAXNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 0    @z2z_2x2_e0
+  FMAXNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_2x2
+}
+{
+  BFMAXNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 0    @z2z_4x4_e0
+  FMAXNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 0    @z2z_4x4
+}
+{
+  BFMINNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 1    @z2z_2x2_e0
+  FMINNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_2x2
+}
+{
+  BFMINNM_nn   1100000 1 00 1 ..... 1011.0 01001 .... 1    @z2z_4x4_e0
+  FMINNM_nn    1100000 1 .. 1 ..... 1011.0 01001 .... 1    @z2z_4x4
+}
 
 SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_2x2
 SRSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 0    @z2z_4x4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ca88b3cdcc7..db1950f407b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -747,20 +747,15 @@ TRANS_FEAT(URSHL_nn, aa64_sme2, do_zzz_nn, a, gen_sme2_urshl)
 TRANS_FEAT(SQDMULH_nn, aa64_sme2, do_zzz_nn, a, gen_gvec_sve2_sqdmulh)
 
 static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
-                           gen_helper_gvec_3_ptr * const fns[4])
+                           gen_helper_gvec_3_ptr *fn)
 {
     int esz = a->esz, vsz, mofs;
     int overlap = -1;
-    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
     if (fn == NULL) {
         return false;
     }
-    /* These insns use MO_8 to encode BFloat16. */
-    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
@@ -786,18 +781,14 @@ static bool do_zzz_n1_fpst(DisasContext *s, arg_zzz_en *a,
 }
 
 static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
-                           gen_helper_gvec_3_ptr * const fns[4])
+                           gen_helper_gvec_3_ptr *fn)
 {
     int esz = a->esz, vsz;
-    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
     if (fn == NULL) {
         return false;
     }
-    if (esz == MO_8 && !dc_isar_feature(aa64_sve_b16b16, s)) {
-        return false;
-    }
     if (!sme_sm_enabled_check(s)) {
         return true;
     }
@@ -816,48 +807,64 @@ static bool do_zzz_nn_fpst(DisasContext *s, arg_zzz_en *a,
 }
 
 static gen_helper_gvec_3_ptr * const f_vector_fmax[2][4] = {
-    { gen_helper_gvec_fmax_b16,
+    { NULL,
       gen_helper_gvec_fmax_h,
       gen_helper_gvec_fmax_s,
       gen_helper_gvec_fmax_d },
-    { gen_helper_gvec_ah_fmax_b16,
+    { NULL,
       gen_helper_gvec_ah_fmax_h,
       gen_helper_gvec_ah_fmax_s,
       gen_helper_gvec_ah_fmax_d },
 };
-TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah])
-TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmax[s->fpcr_ah])
+TRANS_FEAT(FMAX_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmax[s->fpcr_ah][a->esz])
+TRANS_FEAT(FMAX_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmax[s->fpcr_ah][a->esz])
+TRANS_FEAT(BFMAX_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmax_b16 : gen_helper_gvec_fmax_b16)
+TRANS_FEAT(BFMAX_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmax_b16 : gen_helper_gvec_fmax_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmin[2][4] = {
-    { gen_helper_gvec_fmin_b16,
+    { NULL,
       gen_helper_gvec_fmin_h,
       gen_helper_gvec_fmin_s,
       gen_helper_gvec_fmin_d },
-    { gen_helper_gvec_ah_fmin_b16,
+    { NULL,
       gen_helper_gvec_ah_fmin_h,
       gen_helper_gvec_ah_fmin_s,
       gen_helper_gvec_ah_fmin_d },
 };
-TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah])
-TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmin[s->fpcr_ah])
+TRANS_FEAT(FMIN_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmin[s->fpcr_ah][a->esz])
+TRANS_FEAT(FMIN_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmin[s->fpcr_ah][a->esz])
+TRANS_FEAT(BFMIN_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmin_b16 : gen_helper_gvec_fmin_b16)
+TRANS_FEAT(BFMIN_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           s->fpcr_ah ? gen_helper_gvec_ah_fmin_b16 : gen_helper_gvec_fmin_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fmaxnm[4] = {
-    gen_helper_gvec_fmaxnum_b16,
+    NULL,
     gen_helper_gvec_fmaxnum_h,
     gen_helper_gvec_fmaxnum_s,
     gen_helper_gvec_fmaxnum_d,
 };
-TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm)
-TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm)
+TRANS_FEAT(FMAXNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fmaxnm[a->esz])
+TRANS_FEAT(FMAXNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fmaxnm[a->esz])
+TRANS_FEAT(BFMAXNM_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fmaxnum_b16)
+TRANS_FEAT(BFMAXNM_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fmaxnum_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
-    gen_helper_gvec_fminnum_b16,
+    NULL,
     gen_helper_gvec_fminnum_h,
     gen_helper_gvec_fminnum_s,
     gen_helper_gvec_fminnum_d,
 };
-TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm)
-TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm)
+TRANS_FEAT(FMINNM_n1, aa64_sme2, do_zzz_n1_fpst, a, f_vector_fminnm[a->esz])
+TRANS_FEAT(FMINNM_nn, aa64_sme2, do_zzz_nn_fpst, a, f_vector_fminnm[a->esz])
+TRANS_FEAT(BFMINNM_n1, aa64_sme2_sve_b16b16, do_zzz_n1_fpst, a,
+           gen_helper_gvec_fminnum_b16)
+TRANS_FEAT(BFMINNM_nn, aa64_sme2_sve_b16b16, do_zzz_nn_fpst, a,
+           gen_helper_gvec_fminnum_b16)
 
 static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     NULL,
@@ -865,7 +872,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
     gen_helper_gvec_famax_s,
     gen_helper_gvec_famax_d,
 };
-TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax)
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famax[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     NULL,
@@ -873,7 +880,7 @@ static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
     gen_helper_gvec_famin_s,
     gen_helper_gvec_famin_d,
 };
-TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin)
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_zzz_nn_fpst, a, f_vector_famin[a->esz])
 
 static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     NULL,
@@ -881,8 +888,8 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[4] = {
     gen_helper_gvec_fscale_s,
     gen_helper_gvec_fscale_d,
 };
-TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale)
-TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale)
+TRANS_FEAT(FSCALE_n1, aa64_sme2_f8cvt, do_zzz_n1_fpst, a, f_vector_fscale[a->esz])
+TRANS_FEAT(FSCALE_nn, aa64_sme2_f8cvt, do_zzz_nn_fpst, a, f_vector_fscale[a->esz])
 
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
-- 
2.43.0


