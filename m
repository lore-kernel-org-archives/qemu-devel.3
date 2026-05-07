Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385E4CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8S6-0007nB-TJ; Thu, 07 May 2026 19:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rv-0007Gu-B6
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:12 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rq-00028q-5V
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:08 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6966d0665baso985100eaf.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197684; x=1778802484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJNAcoQI7xBxLtbuNmf3B0lU+SHpZ2YFa9Rfr29mdYk=;
 b=EVEcBJ44pabk5RDWo09MkYnFnfAZCSr84zpSDmUIpKKFGt+yrmqGCYABB3P+kr81k8
 tT5XWy4EtASj0/ZmWpzwP7AbQ+K3j/gjbQTHYDIdkm4nXl1r+0hV4Sns+Q/Pqz3kMaw5
 HJR3z9GoRzER7Ue0xnK9JKOrOsyWlduXBdznMrwtlG70f1nIHGPjjRLk2AFvbR1N1lhA
 2rVMH9tpkAhs+wTrM6HSr2A5wVTprHAWjLHRmGXP7n9QxC2E3PXA+drYmrs0r7mb3wXg
 HBRhTDwuoPZeD8d/eMx/58y23wbDTRRifJ3HYcbdM1xMtheMhfapnHRS2RoIEDjyWiM8
 dJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197684; x=1778802484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJNAcoQI7xBxLtbuNmf3B0lU+SHpZ2YFa9Rfr29mdYk=;
 b=X8+TPorq3O99qaBghFlUfrpjY6lhM5mR6Lg9IdvIGqvEtDqbAC+iPk8YXl9qgD6KNe
 suv+xDK2PoVnLCiywhu0Yx7tdmwQeTSBvmeT//spC6UIdRzSJbAEJLqPY1SNKMzgPuFm
 zzEa+p30QQfeblwxOI47MT82Q5YcQpP6krcHtvaz9MjwZQsaobNn9QU+UtkKC2/kZLAE
 3DqERo2pI336Hsh/mKxawX35PjRNMmGOykehV88yaw7dtnxV/5Wf+nQGTr6WdvhKTl+Y
 0L66BEKVFLSJxPf8qaEVdZsF5mN0bKeCdDi8z41y8aRW/trNNfnemHGbwdgOB5MdMhW3
 QNPw==
X-Gm-Message-State: AOJu0YxzGHcjODEKnam/ugAcvjVs1m4dU23m3DhBXbePxL3Oh+aNr2VT
 d8BZigitAqN6j9qZE81kMw+w2493O1mky3HEADlDe8GOhyYhzbOJViQO7lZXz4IAvN9K/kzEDyb
 fTLmX
X-Gm-Gg: AeBDievsgNAs0F0qOcVQk0JYKecbwM7wsNs8VH/FO0lHQaGUsSbjOtdIIIJsD0S/Btm
 LMh+0ZON+4pCuFOyRJDltU4tIR8OWGm+zy+E6RSKGlm3R2QDwLLpCRLQPGQ801HKQzFqLmSUyjx
 QfbkitDzy11wLA5m1zVi2MoUx0ex2eqDnGCXep3RI+3m0aA1BFKYI3IiPD7M8dHTuPi14XyWx6c
 BziU2cVVk0Aj+QnfsHZ2JHwQi0nL6vTPT1C/8BGOazU9W5oxQ6jQPV4DMownoaauCfpFgb9uM2F
 ORgHEBX1VkNRuHlF7PfzZO+S1JxpNd9U86KXvq2oUVaZW4OdkortNpfVBRIxDzO+81i7Dzf6SRE
 yd7+tCShnKEfvmdQrWm1vbKW/B4v4rOZMrIqEWBvdvOmr4PsDowodzt5B4cyaL/52bFqoGsDwOv
 11RrFswlAux750SlellRBCotjX2WvcGt+bDQDmQiHlaEwb4EChXfP3KTLCDYQ//mVtDYU=
X-Received: by 2002:a05:6820:1c89:b0:687:60d8:776d with SMTP id
 006d021491bc7-69998d6342fmr6207563eaf.54.1778197684053; 
 Thu, 07 May 2026 16:48:04 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 50/60] target/arm: Implement FDOT (FP8 to FP32) for SVE
Date: Thu,  7 May 2026 18:44:03 -0500
Message-ID: <20260507234413.643512-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/translate-sve.c | 35 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  4 ++++
 3 files changed, 44 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 95e1849a6c..908dfe0edd 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1544,6 +1544,11 @@ static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8FMA);
 }
 
+static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SF8DP4);
+}
+
 static inline bool isar_feature_aa64_sme_b16b16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, B16B16);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e23ca43f55..88e6148b83 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8372,3 +8372,38 @@ TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
 TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
 TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
+static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
+                     int rd, int rn, int rm, int index)
+{
+    bool fp8dp4 = dc_isar_feature(aa64_f8dp4, s);
+    bool ssve_fp8dp4 = dc_isar_feature(aa64_ssve_f8dp4, s);
+    bool ok = false;
+
+    /* Feature detection and enabling are complex here. */
+    if (!(ssve_fp8dp4 || (fp8dp4 && dc_isar_feature(aa64_sve2, s)))) {
+        return false;
+    }
+    if (fpmr_access_check(s)) {
+        if (fp8dp4) {
+            s->is_nonstreaming = !ssve_fp8dp4;
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
+TRANS(FDOT_sb, do_f8dp4, gen_helper_gvec_fdot_sb, a->rd, a->rn, a->rm, 0)
+TRANS(FDOT_idx_sb, do_f8dp4, gen_helper_gvec_fdot_idx_sb,
+      a->rd, a->rn, a->rm, a->index)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 06bbd7fa63..c49e992f10 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1874,6 +1874,8 @@ FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 
+FDOT_sb         01100100 01 1 ..... 10 0 00 1 ..... .....  @rda_rn_rm_ex esz=2
+
 ### SVE2 floating-point multiply-add long (indexed)
 
 FMLALB_zzxw     01100100 10 1 ..... 0100.0 ..... .....     @rrxr_3a esz=2
@@ -1897,6 +1899,8 @@ FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 BFDOT_zzxz      01100100 01 1 ..... 010000 ..... .....     @rrxr_2 esz=2
 
+FDOT_idx_sb     01100100 01 1 ..... 010001 ..... .....     @rrxr_2 esz=2
+
 ### SVE broadcast predicate element
 
 &psel           esz pd pn pm rv imm
-- 
2.43.0


