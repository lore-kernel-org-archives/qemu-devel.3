Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5ABCD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8SF-0008Ga-HK; Thu, 07 May 2026 19:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Ry-0007LP-Et
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:14 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Rv-00029u-3Y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:48:13 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-466ec4c6846so524294b6e.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197687; x=1778802487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hd4GcTCtxIy0yP6zc3Nx1kS0pnGqa1eP/vZ+uW2aMwo=;
 b=cHVfp6PsqvLTroAw98KWKY8qiuUK4A+q357dRohQXMgPxlc/HtlvNxX6CSOEMCtKKc
 hZIARsG5dsSibWs/HepKVxwFKYNxPhFvEwQCWgR/LpX0ff4ey07muvCxgoMlk728CAaf
 QqS6R8z3Rn0SdovAyHqoQsqVIo+FO5/C9K6XGymksx8/CEmEYr9XYarxCTQAmFSsxX1e
 r+8blARSDqpwnSHzJMgnnDgXOGLg2sGxrIp1Cno2ithqMU5ssqcfalDbODIcxtRixGuf
 DTCSmqO0ZDW3/Lu49DBHmKOvuLtZOVQBgmlJDzXNS2wbjeMF69N9a1z9/bKI/dlOyaYo
 /WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197687; x=1778802487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hd4GcTCtxIy0yP6zc3Nx1kS0pnGqa1eP/vZ+uW2aMwo=;
 b=TvgaV9YPEOAtpIk/fIgcw/S2hk7hA7VKZ/2Nh0kx6n8di8h+z5moWSB9y8tfhy8sp2
 prOsC2NL/bY7xa92LM+sUw7G8ahCPrK1IGs9OykMUHrvKXIAVxmYmstn24I6ANuwgIhG
 KK2+CboTIdaZu7BbXdHc97j74RLCKdsN5cb/u259Tvmcfy7T9KUKX/tTI5I7KLLvM7Kd
 /n6CV33QvDJbRtnX+VRhyAeuGVNPNGFbnjKGkN2wY3sOV5O2MFzDeCToiznr30FoO54/
 yHxJ2EGpUBv80Qa+yxETjQQr8nexE/zD96z2W3f3tWh1J1d02IiKVjtKFDsstThT2em9
 niOQ==
X-Gm-Message-State: AOJu0Yyax6xhdUh1ndSnp9e3LyagFo7JWiQv4E6BC4tYoDbxN1/L8pcE
 Y1tua9J91DiGyMiS08Hu22/jSFQwsyasj4ivzU2Rr7myQRu1vV9NhYHre5eqhtWcNI7Zdyiag1i
 KIzEq
X-Gm-Gg: AeBDievQyGywM/vE8tk1Y8TpeebgUgFIanZk4WZwTkYGdpl0/V5wlSdHosz3K1zcOU0
 pgFf9l5BZmzRVw1Ga+QR7lgWvJn4IkUMrhyDeAb7z5eRY7IVMCZlQ01dCulPvhMHFq/0oG1lZxC
 19hdWWdeSNh0LO9zSb5XZRRyhnbYAVJbOJia+IujR7aI52d2qHYvxJfO+k7AJul1I6LoDRX8iAu
 wZmD1Pe3XRKRSgZU4+EdTMTT5hARObZl+1/mEbw1rlJTO8kJZGnLyNKUP7l5e4wJMBVV0t/eltg
 quFb8bI4eJ0V9Sly4jRFjTTgzPURDO2bWe8Jok9uc117H4teekJglKew/IpgtaoC/a7YOy5A9zg
 iFsFGr/TFvfVO1CnPuj34vtX18AGEQTMpO2MnRjzH7HmicFfRDiK199zfTOO6Uo59J/tHGQ85BI
 4Qr0+bVtsK3t04TFrfpFEzGCW1AMA1lmBe0zOZlxOTXLpqkg==
X-Received: by 2002:a05:6820:1627:b0:67e:16b4:aa1a with SMTP id
 006d021491bc7-69998d624a3mr6210716eaf.54.1778197687293; 
 Thu, 07 May 2026 16:48:07 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4355736f517sm242730fac.12.2026.05.07.16.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:48:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 53/60] target/arm: Implement FDOT (FP8 to FP16) for SVE
Date: Thu,  7 May 2026 18:44:06 -0500
Message-ID: <20260507234413.643512-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
 target/arm/tcg/sve.decode      |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index ae98d126ae..9825262284 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1549,6 +1549,11 @@ static inline bool isar_feature_aa64_ssve_f8dp4(const ARMISARegisters *id)
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
index 88e6148b83..8d622f9a1c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8407,3 +8407,38 @@ static bool do_f8dp4(DisasContext *s, gen_helper_gvec_3_ptr *fn,
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


