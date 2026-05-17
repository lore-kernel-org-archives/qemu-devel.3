Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20336CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSy-0001Wf-5x; Sat, 16 May 2026 20:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS9-00071f-NA
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:34:01 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS5-0006qS-Qz
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:56 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso1283658b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978032; x=1779582832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JulMb7JBgH2EgAoTHRzYHxSimKKsWGbaNst37ZkVAE=;
 b=MBveLbrIbXv50/ykQz0TdiuxzpO7NxPh3jOYbN2SGmRKJGJgV3OPu6z5KrtcB+OZxT
 qg3sJN8kOgkxbk0fU+MKYIgaxQjKyBTS3xHxZnI6kLrxf5jUO0prRaVyrYwXHCwFGWnj
 MEXVcvxTMTX8xjBjoKJfK2wSWrSO6RZzI4EGsQxVTQvTraVUoHkDuNZ8vRk8thKzRKVR
 O8IAYR/ZHOTksH1aPbJtdq765mn8DF2aftwAc488YfTyEzLWP8nB9Mj53zNBWUG8DQD1
 ydJFtK8ZBysCKFTPeDhc3/6k3bZA3sKd33KbZJT/bt80qPvp6ZZ6A/AD77R7nEi+Crnb
 s13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978032; x=1779582832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7JulMb7JBgH2EgAoTHRzYHxSimKKsWGbaNst37ZkVAE=;
 b=oRjT9SX1PExGQ3NyTTedHM3TQBCMVlt4n02MHW80PFBopyQJeBNC8V5qiYNIcWDr0S
 0sMmTabZAeSyQXTcUH9+m6bYNTLTDIDIKVHrdc/YFsb4SS4nLXBPBWQFHlIR28J8odaI
 k2ySMHXRTqm59kk2fPMXk4BZTGgKPuf99nKD5JtOdXZrYeVlfNaQvt23I9AbHNRGyh1D
 Dg9KlFhGxGDEimbeBy81DSLYKdvAimKYJL7u58UH+WZrJa1K4HLl/EhGuc2W2Z1e2tTY
 MBi1lQakfH1iPXEXN3G4mysoBGrGWJi7GFkOQLXoIjePvyLWBY2YC4LCj1E3S4C8Coa6
 FFmA==
X-Gm-Message-State: AOJu0YwWtLZC9k2csDrH21rVN3C19x9JR5uEfO8I1E4F6NhnqwVC10Ow
 J2xOHsyUscNBI1zu+YMLUkHk+Fx0/zjfu6TrljzbpRiZSucKcUe1006EzJLrMme2oNNddW5fRXi
 cxwGT
X-Gm-Gg: Acq92OGt7CsljlrXULVPFfhEto+54xJwDfboYwCxscDtArQSsckdXq7AQKZnuMD6Np7
 04OMieq0VdbUTcUhrZtntBAd0KpjchW4t+u32eDoDXgrU65NaAhAd+NL/wuo+7jF7nXN//NoxXj
 8FyGQuVSDZ817r1xXXM2/dZb8q/kyiZpG6TQlRAvTU0wrTjQVWYXUJSRA/ujWJsFHF23aldoyJP
 8iBt1Fdr4QaWeBSVBZUNSZZBVppbBXrS7QNyRNsPH6wgcwsYvNjSH4dS7eefohqEDZXi/1ogrd1
 fxt8csGAt0z8qHRbIJDZKsKCf6g9Cq5Kg8OigEjK/TiJrGw80Y6SlhOkRrWjadwXT/olmA2jaTX
 kZiTo/RtALwfRbS+gB1qMxD9Z+yOPNusMZuqtUKGFrcsUjLtUQm4A7wSWJC33YrsGX4bwJI6LTI
 1LA1G89Iml/MbxxybRlBtQJAckcOaK
X-Received: by 2002:a05:6a20:7f92:b0:3a2:ce0a:a629 with SMTP id
 adf61e73a8af0-3b0be709b97mr13918809637.12.1778978032066; 
 Sat, 16 May 2026 17:33:52 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 51/63] target/arm: Implement FDOT (FP8 to FP32) for SVE
Date: Sat, 16 May 2026 17:29:50 -0700
Message-ID: <20260517003002.321430-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index fbce0386ef..17d6acc14d 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1550,6 +1550,11 @@ static inline bool isar_feature_aa64_ssve_f8fma(const ARMISARegisters *id)
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


