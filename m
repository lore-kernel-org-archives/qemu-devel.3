Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA895CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY2Q-0000we-QT; Fri, 22 May 2026 18:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1L-0006qL-B3
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1E-0002k4-Uf
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:06 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso54712315ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487619; x=1780092419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eytuaCbSA78hWc4iV5jWqOyRZ8ZpfJdBOHvcB/QX7E=;
 b=uqNxaLlOrlsKPVS9/MQ1ebP1UgqywLqgqhig+3zh1s8gyviS0Cwcafypm6LB3M/uTU
 U40G0oabu0vajP4EMYnsLYcOHpIBguaEJ8Gv4cfAThARgJY7fbcE28l4zXixC2hWDlQE
 9SjMM+2u31UR034a+4w4V6zrZvUh7v06wyYWvOyJHqNer+D86p7H/Onz6lED/YMUUTbH
 LgdGt8twvl3mRvrluuD4sikxT58Re3DgUkIVmuiAWmrMpgl0b5jhgnyfzOEr9BQCqbHJ
 Ax2hG40HwIMJ4dcWAYBpg1FAnyZJSIi0g8Ch/RuAYG90+yTuIPt1pS+MQ5wlEXRoDZKC
 nLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487619; x=1780092419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8eytuaCbSA78hWc4iV5jWqOyRZ8ZpfJdBOHvcB/QX7E=;
 b=kPyX/d/TvUCdwktvY8Fn7CTRBDonEmcvY6Lj9n0IWiDm9JLiBIqnI7aEncBoICXGza
 ZD74SjLnCZiJchsh+v7QkUBoseLJ4TG0io1tttZutHjDoHPozESypXZUJQDP4hDelkyB
 Ugxsh7uHlUY1Z784GX/PUY792ly96kPHLJDxc2TC9w85x9UX2a554+QdZoYvTPdalo5r
 kZmnG3Dh2pKEXy2zXl9Plk+Y3NfMBA/QRFbK/WoVP0tysSgMu2l9jrfqaxJulQCI5oSm
 2sKNzVpvgAW/OEv1rPHNCHfUqEoshPrE0TSe9OL39CyXOcZ0ssn5mzbN7VUkVU3tPFQJ
 oG9g==
X-Gm-Message-State: AOJu0Ywb5jJpqZ+PoaSJyN/C7VR3XRnDnr+mXnlWHnUUFGiu3sJAGmE6
 afpHD41TZS8O1b+DsK49GqIQD+ceUkyOD/JRh/FkrwUI4CskmZVCKjA8OIIdXA+Hoine9i5AodX
 OA/w/
X-Gm-Gg: Acq92OGiptRHiNKNHqMLMXHLEClqNZSiTjjAQ8wXE6cy707Sf0vFWdG7v9ItnL2bIBT
 S4EVCmi2Cnepsy5xvyLC6WrAAAYpB8SJicOn1yqldnRb6/78q68RFh6tCmh/dGJIIbueC9kwc4i
 oF5NpvtoVVIVLX59qQ1NsHHxzQmx3mNpbTEjHsQYhOCTwOwr4o8GyKOJHsIi35Wj76/gyYRRuKt
 OrAYmenJo/4uj/MFpbw34md0rJq9KjPTq1gR3Shcc6nYW0SpmAbjDUUJepBlkRIeyWzzTmGwaWf
 KF485nfaS7DRQ4A+dVXyChTrPeX1nlhV7ktPXXxkZVEMFsswxwiDz5/FtnrsiuBNxB5+MCpJAfs
 VAJMbLP4G5jFRieMub50Mmsbg7OOeczHX31Rr63039g0rkcp7m8FxhQgP4S1BSd4Laww6jirmbA
 uaDFnjkAcL3fP5jOfTXdYZLdQyQxtC
X-Received: by 2002:a17:903:41ca:b0:2b7:aba0:ac10 with SMTP id
 d9443c01a7336-2beb066295cmr62433645ad.11.1779487618820; 
 Fri, 22 May 2026 15:06:58 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 54/64] target/arm: Implement FDOT (FP8 to FP32) for SVE
Date: Fri, 22 May 2026 15:02:56 -0700
Message-ID: <20260522220306.235200-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
index f74e888580..af7f115f4c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8390,3 +8390,38 @@ TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
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


