Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D17CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OH-0000Bd-5G; Thu, 07 May 2026 19:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OD-00008g-BN
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:21 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OB-0000ys-Ow
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:21 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dea1272943so885848a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197458; x=1778802258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9icdZxYx+oMiDyU4sbRQtkDtk863yHoHjjLPL4BYJo=;
 b=RoZdHPNZ/M6101hp3ZMVYPM62R/UOJDlv+Twt23pWX8p1QDUF4+ZwxwDc/jndoWqI1
 /szGC9B1W2G9a+bVh/gs2stwp1Vz/tAj7PshMruEpZJTfDV99CFrr+vVH0VEeWmi8Bjy
 AjjfFw27hU6M0anCCGE0Fx4lzF69xPPFczWgZyUYjJbgDYyaqC/GJ9mqjVF1JFPFyDS8
 pFn6NwhuBajwWAgTAoiNWULCCrUlsQtErPR8H79zUsOSjKf7V694Znfm6l6D5PJRvhR3
 +4ieXYGsrQ2DOtGr5NYv07DNlV49Ui+f14A94VsehHx2+AqTWnfkgiMVe1T/bstIFC3k
 d/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197458; x=1778802258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f9icdZxYx+oMiDyU4sbRQtkDtk863yHoHjjLPL4BYJo=;
 b=pCS+nJvW6OLPauF5FblcYbxPxw2pXIkPHUM3+V4A3s3wJHhKju8rLpXXU48icTrDOe
 CGgKy5ieDCe/3GFOM/CsvhXS8XuLLUfKaPT+co0XrSifzJEO9liyQSzxAaBJfrDF+A2L
 kelRzKgfeRMW+09odxgFjF7Q2x3xmYjKegZtOg7cW0eu6gQsTEXUQWa3EIxGhI8RXlbp
 nIOmrmibSo7JZ7HGMIYZRtYoc2YW/7GOrkSwWh9+ZGCtDW2JRCylDNwPTLn+bpy3gAYh
 GrbexbRUmTyjogj7NYw8P8VW8O3NNb9MwAgf86CpkqXYR2uZP1RRiMsyK/IlwFIEkUjf
 Dnrg==
X-Gm-Message-State: AOJu0YxX7/m084zRbbyWN5EkUiKDoP0X5NTdsHrnf6IbVyyztPON5AHD
 ++5jjH3X0POcy5g+OYSoJ7HacmX9MZLK6teGplcY4o4D7n7bvfDh4vc+7G4KRi/LsE4df8lT9Mt
 OcGDC
X-Gm-Gg: AeBDieuO0R9CxdjShjOOXTD09O9qGs1yxhk5pgk+JqX8ewaJ7SV6twvDY1qd9JNsptn
 btrkA9fm+N0+Ad26TA8nPGZ57O9IZTVzG/BemDrjxst+Q/I93lZSpCosyYcgJbhFrssUBjhOnhl
 ZGwFBFXXB63bbnDJ3vy11OGu6Zr+bcUNEfP0B2dCSNTgbCijNZhl/Prsd3khMekEzrkk9K9GmBP
 AVFZDBii6ZTV3Qg+9cxVki1hYBUFvUmk1nWqHe1yN/w+xMIGYoFJubngduxx1+OdVenBfxeIuDV
 /6SuysYro5g3CVvMf+YuSuCd8//oQjWsoChQ3XNa5aZdjKygB0MAbpwwn0pETHTnOOexyh2W9k3
 U3zRxb6WTdK5/wQjUTwot9CHAsK2vNflK6AscF+5JMkllf+qmUE8TJ7j4XS+J+/zg4lqjBJ5oEc
 cqMwmlsGqVoUstHL659dAXkchq1nKk27Xl/v15WzN4Re1Naw==
X-Received: by 2002:a05:6830:d8d:b0:7d7:c96c:c5d6 with SMTP id
 46e09a7af769-7e1dee2eb3bmr6459062a34.1.1778197458590; 
 Thu, 07 May 2026 16:44:18 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 03/60] target/arm: Implement FEAT_FAMINMAX for SME
Date: Thu,  7 May 2026 18:43:16 -0500
Message-ID: <20260507234413.643512-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Since there is no bfloat16 variant of FAMINMAX,
check for missing function pointer in do_z2z_nn_fpst.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++++--
 target/arm/tcg/sme.decode      |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 21d0be73cd..fe5d3a1635 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1587,6 +1587,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_sme_f64f64(id);
 }
 
+static inline bool isar_feature_aa64_sme2_faminmax(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2(id) && isar_feature_aa64_faminmax(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 08254b088e..a67501226f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
@@ -742,9 +743,12 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
                            gen_helper_gvec_3_ptr * const fns[4])
 {
     int esz = a->esz, n, dn, dm, vsz;
-    gen_helper_gvec_3_ptr *fn;
+    gen_helper_gvec_3_ptr *fn = fns[esz];
     TCGv_ptr fpst;
 
+    if (fn == NULL) {
+        return false;
+    }
     if (esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
         return false;
     }
@@ -753,7 +757,6 @@ static bool do_z2z_nn_fpst(DisasContext *s, arg_z2z_en *a,
     }
 
     fpst = fpstatus_ptr(esz == MO_16 ? FPST_A64_F16 : FPST_A64);
-    fn = fns[esz];
     n = a->n;
     dn = a->zdn;
     dm = a->zm;
@@ -812,6 +815,22 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnm[4] = {
 TRANS_FEAT(FMINNM_n1, aa64_sme2, do_z2z_n1_fpst, a, f_vector_fminnm)
 TRANS_FEAT(FMINNM_nn, aa64_sme2, do_z2z_nn_fpst, a, f_vector_fminnm)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[4] = {
+    NULL,
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[4] = {
+    NULL,
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN_nn, aa64_sme2_faminmax, do_z2z_nn_fpst, a, f_vector_famin)
+
 /* Add/Sub vector Z[m] to each Z[n*N] with result in ZA[d*N]. */
 static bool do_azz_n1(DisasContext *s, arg_azz_n *a, int esz,
                       GVecGen3FnVar *fn)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 6bb9aa2a90..9dec7318a4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -286,6 +286,11 @@ URSHL_nn       1100000 1 .. 1 ..... 1011.0 10001 .... 1    @z2z_4x4
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_2x2
 SQDMULH_nn     1100000 1 .. 1 ..... 1011.1 00000 .... 0    @z2z_4x4
 
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_2x2
+FAMAX_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 0    @z2z_4x4
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_2x2
+FAMIN_nn       1100000 1 .. 1 ..... 1011.0 01010 .... 1    @z2z_4x4
+
 ### SME2 Multi-vector Multiple and Single Array Vectors
 
 &azz_n          n off rv zn zm
-- 
2.43.0


