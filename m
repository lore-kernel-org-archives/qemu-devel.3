Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924E2CD4F3C
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPc-0007rd-CN; Sat, 16 May 2026 20:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOZ-00078m-OD
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOT-0004mn-IP
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:14 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c8021c8c42fso341200a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977806; x=1779582606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h37zckXYDzucFKJfi7Vv2YlpkD6qilhmC3tWvPQ5Lng=;
 b=Tkr9olVLaM3oYjb+75Oa9uMcFBZvxj6wrvMEYTdrS+lu6EuLcYjINuACLfkGjQZTMx
 jtjrwIpyvSiQf0SWoTDkftLRhPVbBDCe9wXE9t3zRu9gRxyC2LvMmqyyB/me5e4wDa7+
 UY2L3l5kR5ap3u7dhxC7Qfw2hR0UIWg2pQU6qvr6fBED1T/wxJrL2OhgLjy8GazHJSTA
 AuVVzgnJbSEZWD4MpukmVITe4JClLG9sfRnX6d5r6yg01oPYv5q2n4+ndNss5SK+z34s
 I6ITrwa9lfQeJ9byZdeZAOSv0mlf16nbTRkAIw6UDIEdodN/yvchi7/6zeFHVnBL455y
 utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977806; x=1779582606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h37zckXYDzucFKJfi7Vv2YlpkD6qilhmC3tWvPQ5Lng=;
 b=BhCY6beKu4B0CxiW/qGu77wQtlhgI/vGb4kkhmEuNyRRs252lg+E2XoVvtDJeyaLJi
 3bAh6VSZi1u5LAT2kW3+Dbl6N4sHprnh//61Msby8N4N3hRYoJD8K6VtmY8OMhm8T5YB
 oj9f498PZg+egHV6UKMOCJ+uT+3aX6ZR49DSMfq/p0H0Pn6xH9pJam4v29TPZgrRF/bq
 A0CCQhuh9aIJrxCOlaW+mmG3LofHqMy2NerJgeKVE+xEOZFjne8xKPrZoLJoX383T6E7
 HSqsi8vIzAi4t8gNyFAh1KV1Qk0gEOPDRSCxagG9RDmdAziexPevw0S38y4PkFuAznuC
 q3Bw==
X-Gm-Message-State: AOJu0Yz6pcZsK6P8O7NhR3yIteqkl+zkObTbp+eMt75/JZSRNXxLHgC5
 Dd5bqsWaWVyx/EzXRclcTnAK97IV7qdh0AEX2aznFy4ZoIN1L+DCwoVwjr2gm7/bbD9qLs5nJDX
 i7GQq
X-Gm-Gg: Acq92OHABT33zC4GvguHnwTU47rInhJ43WzFsFtGjTOdbai4UO0vL0etDrC1FO0gz9u
 WPTQR/Z5jJaEW+wJjf6zsxCjCYsDxLhvisb8IF71IDWEWaXavFL6SXAVJ0aBO6lAze8Xxtf7Vh/
 bGmgTzxruueoz/xQyQo//70i0E0CB9lj9Ej0CpoW++dcMOcI76gi5MT5rAuF5bCwwm6pnMiHwWY
 VxHzWbYkoBbtnnHUh5UrN4k5hM4MVIj4LT+Q6UItDdZ7V65+CkcflleXQZHkPPa8SanryFo6/u2
 thieOqctKf41o/wByHKV9DJUy+WDJ2dZuM+TnmtsvOvqyiIk0mn2xPaWPPnKZdqWHdw2iEGS5Bm
 44qdUHfBEy0+QMIdd86yab5x4dJauE+zW0Tuw+OoIxfZYjFnjnmauFJbaj6/Irq36y1r+YDXQFk
 MkKlwCd27YbCmPL06EG6tE2Hqr9pKic1SgHsdRfQM=
X-Received: by 2002:aa7:88cb:0:b0:837:b5b6:1b97 with SMTP id
 d2e1a72fcca58-83f33c24142mr10791609b3a.12.1778977806001; 
 Sat, 16 May 2026 17:30:06 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 04/63] target/arm: Implement FEAT_FAMINMAX for SME
Date: Sat, 16 May 2026 17:29:03 -0700
Message-ID: <20260517003002.321430-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
index 21a1f941dd..21b91b1503 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1593,6 +1593,11 @@ static inline bool isar_feature_aa64_sme2_f64f64(const ARMISARegisters *id)
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


