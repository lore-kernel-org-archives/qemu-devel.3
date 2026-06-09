Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FC1CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX27e-0002fU-6j; Tue, 09 Jun 2026 15:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX225-0003fI-HW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:50 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21u-0004C4-FY
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bf237e1433so66141565ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032901; x=1781637701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/rXv4ZUmhuRJixg/8L/HLonLKmwBZED3FxY/c1Iy/o=;
 b=L3HcsmEwxxWBJYGbs0po7cK0t194mfKSU1yDsQWpEL//PTa/kc5nWS34v/K3KBkcnk
 7PAF7ssqt/bh432VmzumCmxvTSBnU3iQnzZ6/md1DXv+SZTIF9YxC+BNpWIy1RuglRSe
 kJkVUEbSLAnzMDJ3t9t1SwSfItO3w2b8Tr00T8Kt4LKDqvI9jJ1q4c77A0oTd43J4Ke/
 TMcCh7QTbMVrQ70wGLpBnvF6+Rbnll2ddcLiTge3AvFSgTtR0eYbt6PYXVZ/pWEKlFbw
 MOMliYNCtrXxjGVFlTSx7mmQazRi2oTKhReooK886QjvUqGYsjZ3k5NLNiWPJ20o7tFG
 CzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032901; x=1781637701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e/rXv4ZUmhuRJixg/8L/HLonLKmwBZED3FxY/c1Iy/o=;
 b=fXi5PhK2vE7zb4iu8LB7J+Hqrea7w4t/yt+IimVjQZFYjznhjBQZG8GRTpeQaSGpps
 JT/qulDwmXdrCACiWJY2HRTOBpMSCwtd1zVZKqZaYAV+TQEHFc+DG/3S8tNsib91+IdF
 lV0F+oXxDiiWapIJ/Nz9Bw65MgiZPUFCDHrmpC1mUZP1ypAN5lI1FIKGS/bb0DnsErLe
 oFpoO6YzU9vv+aZAwdBKG9LahO8P69ga+ICTRLR8dLtiZWhxv/g5bijjhcLCaAhTXAOj
 xVxCXvhmtBK78qSq1HKf+hV6c9otqi7X4K1hdRMbssFbj5ZAXKTwln7q0Gb/GxF+YlcK
 7hsA==
X-Gm-Message-State: AOJu0YwH9blG0iI2zeN+perEz28Vlfyp1GYCfyBViX16dd0THFLPcF7R
 b+ML/3Rj8LDM3z5CrU8Q8G4pOdjEyYtb+EPT/PpQwzYMDq+wk90EWSmbRIW66y4Ae8np8o6o7AH
 l7nEAhXY=
X-Gm-Gg: Acq92OFFaacTFqBMYgnHg6PmGlk15/vOGozLm/SF49SvmrOPi39X8AOG/GLZAv/UqTB
 LP224o562P0PpwIdLnrUYUU1bkWYxof78yH/xSluVuYu1greICJi4hug6S9+ehtKK+NxBzPEYXS
 pUvTFarWUMQZ5gacn4iD4AQf4jt9OmMG3DfVS7JNZBGQfgG71q+7dNiwmYYhXMIFxw6q7hEB28r
 q0LU9i0MzCzWEoCKku6ysFm56c8TYKiae4UtNngknzuoq6vQy4HIuYiRfl//8r63SXT6U1/mq0E
 fROIpIAQQi8KdTJASTsmYboFnopciPCkWdQeGMSHTJs9IRPqDRT8myjkURSgpfxmvuhihExNnQm
 dFKxgytKApPM+B8xTdGbrIotIvckKcHaKrxzduQNYeazcktgEYnCHhFrTMd6vu/7D1Gd6GrpWS6
 I/5Xe4gVxp19DtH4/+yid9IHTGqksO2Imv9+4jOIKQMj9JllXO1g==
X-Received: by 2002:a17:903:f8b:b0:2c0:cf44:3b3b with SMTP id
 d9443c01a7336-2c1e847d71dmr270081905ad.24.1781032900865; 
 Tue, 09 Jun 2026 12:21:40 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 38/45] target/arm: Implement FDOT (FP8 to FP16) for SVE
Date: Tue,  9 Jun 2026 12:21:02 -0700
Message-ID: <20260609192110.752384-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index f6184b80de..4629a3cf3e 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1565,6 +1565,11 @@ static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
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
 
-- 
2.43.0


