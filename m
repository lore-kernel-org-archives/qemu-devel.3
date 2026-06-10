Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECABBCD98CC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYh-0003V2-1Z; Wed, 10 Jun 2026 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYc-00033h-Sr
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:35 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYb-0006Rv-4m
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45eedcdaeaaso4792586f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108011; x=1781712811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qbVjbGgrJ9jbO98suXUo/HKEmCx0k6OSrK7z6dg8J/M=;
 b=L1aX4gGukvzCdPU9iA1sta3zyLtlCexoLZARjpS5hUJfAQNWLaBkHQpRmNV8G0Ymyp
 OLlm73rtPYN3N0dYOoptYNNbaGi1V6Zs735ulxPOaZN3rsiyJN07KA1M3OIMKQosMMOc
 xzU1XMAlieFZ7ovFtli4hkCpbivxbWCPvTUpIFgFcv/4i0QERLAyk+lD4WQLoJfSlOyW
 zAlrKubo+audvKZ1S1zTOvz7GGLvGpwb1EJTv7hbsHC+dPOY/kHMV+yEYWmCavCMBbbF
 1W8kJJojkq/a8hHnZJ1HmJwe6FKZCw39EK7MO8drI2fsYfW7jrzGLYimc/7E3Na+161O
 DRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108011; x=1781712811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qbVjbGgrJ9jbO98suXUo/HKEmCx0k6OSrK7z6dg8J/M=;
 b=Zgl6BIAmZOV+15DOLy4o3o0eTTMFmyGozprED2Rvb2IWR1Gk4jiQi3kX+P3/LdVjV4
 gVn5nU2bTw/AOE2143XiF9zJMGVqsVhq0ibeEhcIiMc9wOj6/D/4Nuu8M59VA8LEVwSp
 f/RSM/i3QU/qj6uo/yhTQ/A7WdVf8a+7mV3RxdcFtulGOQKTLBoJaRosajN+lTt0DGZP
 pX2PzX7wkrDML2p0H/vEOUwKQKDXxMnN/UP07X7XObJOkS4TiAwS2qf6zMxfyUrGVv1r
 aG8fNlAxeR4SEOziRVhV4bp3OffifRNoRqGxFMSFwf+wcBQwQbLL72WTpQBb+7kGR5Iq
 b05A==
X-Gm-Message-State: AOJu0YxETsXpiWEZPTYlR/i4VanHocboQ5gSNaR+IzWdig1g0U0T5DPs
 Iz5MPZ5ktpYsrw+azCNSuHf0he9eHkomrF3Vx4lPjJWLN+Qp21Uwr/NIjljH7pqgrecyOoXFi4A
 0Cuja
X-Gm-Gg: Acq92OEG73ZULWZ8EJYiFmx4Nz/GlPmHH/4DyB7FsTNWVQaYqlvqcNXfpFxcpK7BEhz
 taPZeUOLh78wXEtqhekKGsjplLySvYAjtfsPtyitMKzOY6LRIVomAdWi/3MlrBnSDI69TGGp1Py
 5jB2CgPgYlIrLl8a+IB4FBJRa1QKAnknBEtsxFevd76I1r5WGIs4gV95GIaSEAjcRzC01zRbGJe
 0nfy02OvBZJfq8DMoiK+1ysOpo806wPpFbn0t9sXzI/TrotHwRxkQ6elWUJJHqgHiRa4/YsvMEh
 s+wKetmKKw3D/QEHnX68JAa1wqUdt4J8RsBAPOTlH8gDj6a6LKNrMuqIw0hBt3Skq//0snu1o+e
 6/Zt1OynkNflQ6h1y7y4RrOp4TF0ZS6t8kVnXR5kpuNsWbkqDcy6f6M2sWR5lvPMAgsAw8UlHQb
 ThhcS6y280Y+65P/qZOB9t361ioKIda+m71KgwxXpkeLI3K0pwDScrt9cUcCHd9lSjH4diZMKgS
 kJJUiNi2VOvs8Rp43L+0y5xHlb+LLKhzhDQ39t/Dig=
X-Received: by 2002:a05:6000:46d6:b0:45e:ea46:ce13 with SMTP id
 ffacd0b85a97d-460304f9d74mr27004453f8f.10.1781108011464; 
 Wed, 10 Jun 2026 09:13:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/71] target/arm: Implement FDOT (FP8 to FP16) for SVE
Date: Wed, 10 Jun 2026 17:11:55 +0100
Message-ID: <20260610161202.2235298-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-39-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/sve.decode      |  2 ++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index caae3e51f3..1745989bce 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP4);
 }
 
+static inline bool isar_feature_aa64_ssve_f8dp2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP2);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index c49e992f10..26b3c7697a 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1875,6 +1875,7 @@ FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
 FDOT_sb         01100100 01 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+FDOT_hb         01100100 00 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=1
 
 ### SVE2 floating-point multiply-add long (indexed)
 
@@ -1900,6 +1901,7 @@ FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
 FDOT_idx_sb     01100100 01 1 ..... 010001 ..... .....     @rrxr_2 esz=2
+FDOT_idx_hb     01100100 00 1 ..... 0100.1 ..... .....     @rrx_3a esz=1
 
 ### SVE broadcast predicate element
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 582471b380..2cc5e129e9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8426,3 +8426,38 @@ static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
 TRANS(FDOT_sb, do_f8dp4, gen_helper_gvec_fdot_sb, a->rd, a->rn, a->rm, 0)
 TRANS(FDOT_idx_sb, do_f8dp4, gen_helper_gvec_fdot_idx_sb,
       a->rd, a->rn, a->rm, a->index)
+
+static bool do_f8dp2(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                     int rd, int rn, int rm, int index)
+{
+    bool fp8dp2 = dc_isar_feature(aa64_f8dp2, s);
+    bool ssve_fp8dp2 = dc_isar_feature(aa64_ssve_f8dp2, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8dp2 || (fp8dp2 && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8dp2) {
+            s->is_nonstreaming = !ssve_fp8dp2;
+            ok = sve_access_check(s);
+        } else {
+            ok = sme_sm_enabled_check(s);
+        }
+    }
+
+    if (ok) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
+                           vec_full_reg_offset(s, rn),
+                           vec_full_reg_offset(s, rm),
+                           tcg_env, vsz, vsz,
+                           index, fn);
+    }
+    return true;
+}
+
+TRANS(FDOT_hb, do_f8dp2, gen_helper_gvec_fdot_hb, a->rd, a->rn, a->rm, 0)
+TRANS(FDOT_idx_hb, do_f8dp2, gen_helper_gvec_fdot_idx_hb,
+      a->rd, a->rn, a->rm, a->index)
-- 
2.43.0


