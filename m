Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8963CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIU-0007Dw-O7; Tue, 02 Jun 2026 23:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcIQ-00075H-HQ
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcII-0003mj-4p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:29 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8423f236418so1544334b3a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457364; x=1781062164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJE7TRFniC+M2fUEMxAGKEKlXN64hizgjGGYuWEgBfc=;
 b=TR5eHxKpT3dF6vwUoHgZKlOvrGAq1/UtbDepbiU1RUvS1mderfRldRhwB+j4oFWOtG
 nfniNJTFmYIRy/MxxzIugRriT0+3CzhiVB9Cx3j8E8+WMG1N6/w2API0Kuot4x0iHb7O
 9VgIDi6nuUrwuIIbXsWgkmmscc8inJ0IbyX9p0FYY8ECl2qVI7CTb7UiG1d1Zb+QGAIy
 Z/XzSC+n5b8kLLbrlshZvVgY3q0ipmqE2LoUJgXxb2cnZ1EqbONrq/59ALX6udnD4Jsp
 eWQ/GMVUXfjk4j/+Oa3eNZDuuNxq62XNFoHGe3UBAKqDvhMiZjPPaW9RcHUjIUYyRhLY
 6uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457364; x=1781062164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RJE7TRFniC+M2fUEMxAGKEKlXN64hizgjGGYuWEgBfc=;
 b=X76ridetBau2pptNBOTPuisJRuBM0ESmmlVoY5NibPiqaDvgizLHqanbxa34ajuddh
 hed3XRfFRszc3oFTAyfYO1iftqieKMigeALAhl+/f3EtBS2kJisOJnqAtnOj3N/P68Qm
 LwqJgwxhgb79c8E2Rpstq7Qkl0tAViwEzInvjpgU2gJwd5AD7TZ0s5cNhx3bLGC/T5EJ
 cQOPgyswOahQXLk7Ko0cDfhvaxLZ65MStG2P9awDVbRFOYTZtAxDrFIhimiPcLKbWSut
 Gxji1OLiWzbSBKco82YtIISb/Qnutk+rNQw17FY5IEiKhU7OggX+BKUKsSuF4CjkRFV/
 Z5MA==
X-Gm-Message-State: AOJu0YxaC4TX1jjmaxgULnUnDUKcsXIvpJqgFlrkxf/2CiQsMZZH7VBj
 Rmbosd6V2Pzg8MiE/qVF16kGmlh0so83TqWqt1b8bMHKMGVa/3p46J/vHkoXdd3sRNr+mvZ2AUt
 6ha5x0VQ=
X-Gm-Gg: Acq92OHJ2NQo2kaf2nXHCzqiZ9swkRYqtGKOwemKmvc3he/08UxhYuFtkD8TpfQ3zpO
 sboIOk33MFduw9ZxRusBsEPvgoKRETLrZyeYMoDZ4BBSQ0O72M7FGMbqqT0jUW5gN+IhTIIWj6B
 +AsPJh7HSHfhDWFhzrg6pzOnkn3wXefikpSUgO+mck+OyJpW7uW25Kdj9m5FC3Fix9lp+5nJ4oy
 UyKUI0qEsO5XxQrsWxyTB8TzPlI7kpEcs+JL5vwqKiBmOTT2JuRGq6nsNJ1mKD3n9qDilbUOBeP
 HACa/2K+V9Mz6+fpEKpJoWD/2MIhpxgfq0T524fRjtCVpE4RhY/6oCBNgIRIFryXHpZOOwlsgog
 yRlQ3WpiHythAkubPymzHQoiDj5fUq6pUIlX7FZSoS0PvapwWSVvVjo+OgNvHplq0tcFk5So6Jf
 FJ/CtNL6jee4VTSNzUlkO6jwLrrf8390QlJ/cfTEg=
X-Received: by 2002:a05:6a00:2d8f:b0:842:6fec:12aa with SMTP id
 d2e1a72fcca58-84284e2308amr1588631b3a.8.1780457363885; 
 Tue, 02 Jun 2026 20:29:23 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 38/45] target/arm: Implement FDOT (FP8 to FP16) for SVE
Date: Tue,  2 Jun 2026 20:28:47 -0700
Message-ID: <20260603032855.106930-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
index a5a0359a95..fa0f3d23b2 100644
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


