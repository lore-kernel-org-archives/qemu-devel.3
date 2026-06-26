Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8DFC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9jO-0003Ie-EE; Fri, 26 Jun 2026 12:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd9jA-00038k-Qo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:48:30 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd9j5-00086C-2N
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:48:26 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-37cae11ba85so1082351a91.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782492501; x=1783097301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bbeQ4XtAXcgQ2gdqbNRCKayzWt8LQO4Nyk9/MULghts=;
 b=If7W0xp1JHrsk+ITrBRLyaOM2BDK4daU/UascCCLR0RNBhW9rpBvmhoexE2zJMcUoP
 o6xjBK60JAHrLuj4Twy++iG2RfGysac1aZNk/8Pdt3FQvlZAjVnxOmtZQj/V/PAhBqXS
 Ir8sY4357GBvjWVeYUee1//Q9YgzEte4fMrF2R9Z0bc8y/HU+VhfWYTgHwj9uVNGrUzq
 FTYozrBEBbHn/VLRRfTzJpbfFDU737DDVLvcQ1NUykVKyjd4lvDjdW7SnG6Lo1BCNcj9
 jUswZau2ek4vviiH63+5UOPduBGxNF+9Tn1y+L/K9XhN/P0IkRsU8JM38WjUK272fxdp
 OqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782492501; x=1783097301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbeQ4XtAXcgQ2gdqbNRCKayzWt8LQO4Nyk9/MULghts=;
 b=HsvWSHkVvIxWyzB2JqOFHLXIolkZrAR8VYPxUSqNZjqtSCJ96mDq/e8ohr11r9pwey
 P/gZqjNwhkYfY1PMLDkeLZZN9aVQDGdPa2qHMlfvBv2/9IWPgWE7xu4v4afEtYYhCJ/j
 YQtb40QacY6uKe5PribgmXx7F26IbR++qhY3Yy3vTS7AuN270D5i7uU5XPRY8EW5L/0O
 5YYXH1mP7B6E9AtA+lzYzJzzV1GJJ2WmJ19rLJ6FV+5h0sleh6PkSO5SCITpt/A/brt5
 +EHw7IPPss70hhAdlu/UMBZXC95KeUdeS1BqKjp2r1Yl9Y54HT8QK09pJIZTL7Exk0mG
 tINA==
X-Gm-Message-State: AOJu0YyK5Rn2Q3zGyOiMCByc3vMaIZiEpdpEc3QmsR97N4xmkYdUXElq
 fiZYYh+pmcY3U/ej0DFHjboQtIHpxQM8UwxLrLykSGO/BC84jU26wn5T2nWxZETsEXzE7Cu3doN
 utfIk
X-Gm-Gg: AfdE7cmOTLDq2la0p+jt5zkxFpwunNvpRA8glhyF/kP4EGLDHUBBXcIWHQGcU1FnOXz
 vX5j2xrMIvCU0bReKSE54ko1wURaNGsY0DRwecbetrb4XA1Um67PxcrUFR/Z+X4w17rmi7zQdr4
 a7buU8i20YCwzhQvw9GQmV5MDarm4wBHt5bRFGqiD9azzDxFUZAZ3lw0xQnn1RdkZH98hcDNUqZ
 GtrhHAQDQLYekaXr5SDdsREoDLXuQVxcg8afyfLZftyLwY9Vs+Qzgv6CHJq1QTwgSuXctszSyRd
 rJWASBJuNHjXE6aS5L7KFBYqnaOQxhbp0m/KLV3NoIAv/teWuPDEq0mwOi2Wx9ejUirv9vFTjQs
 wsgsfGzAqF02Oo6xsSMOHIYdBsmYmIhs6JQdn6+x789ixKXyEp5OihEtjZFFfQVL8EAfrE1wIxg
 8AUpR2YlJJc6r6ZDl5tWUQrXfkGagZ+xR8OqGzleMK4oPY7d+L1r9soX2Le+eA
X-Received: by 2002:a17:90a:9f89:b0:37f:9ce1:cdaa with SMTP id
 98e67ed59e1d1-37f9ce22201mr572541a91.32.1782492500924; 
 Fri, 26 Jun 2026 09:48:20 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37e1c93272fsm1138520a91.14.2026.06.26.09.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 09:48:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2] target/arm: Implement and enable FEAT_SSVE_FEXPA for -cpu
 max
Date: Fri, 26 Jun 2026 09:48:19 -0700
Message-ID: <20260626164819.770787-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

v2: The enable test for this is (FEAT_SVE || FEAT_SSVE_FEXPA).
    I thought maybe writing it all out like this is clearer than using
    TRANS_FEAT_STREAMING_IF with a one-off combination feature test.


r~

---
 target/arm/cpu-features.h      |  5 +++++
 linux-user/aarch64/elfload.c   |  1 +
 target/arm/tcg/cpu64.c         |  1 +
 target/arm/tcg/translate-sve.c | 21 +++++++++++++++------
 docs/system/arm/emulation.rst  |  1 +
 5 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index c3eeecbea9..bdeb72bd77 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1580,6 +1580,11 @@ static inline bool isar_feature_aa64_sme_mop4(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMOP4);
 }
 
+static inline bool isar_feature_aa64_ssve_fexpa(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SFEXPA);
+}
+
 static inline bool isar_feature_aa64_ssve_aes(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, AES);
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 9b93969850..cea286cce0 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -174,6 +174,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_f8mm8, ARM_HWCAP_A64_F8MM8);
     GET_FEATURE_ID(aa64_f8mm4, ARM_HWCAP_A64_F8MM4);
     GET_FEATURE_ID(aa64_ssve_aes, ARM_HWCAP_A64_SME_AES);
+    GET_FEATURE_ID(aa64_ssve_fexpa, ARM_HWCAP_A64_SME_SFEXPA);
     GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
     GET_FEATURE_ID(aa64_sve2p2, ARM_HWCAP_A64_SVE2P2);
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2cf335c956..7151c509f9 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1384,6 +1384,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
     t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 79e8e16b24..fc4cc8c479 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1369,12 +1369,21 @@ TRANS_FEAT_NONSTREAMING(ADR_u32, aa64_sve, do_adr, a, gen_helper_sve_adr_u32)
  *** SVE Integer Misc - Unpredicated Group
  */
 
-static gen_helper_gvec_2 * const fexpa_fns[4] = {
-    NULL,                   gen_helper_sve_fexpa_h,
-    gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
-};
-TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
-                        fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)
+static bool trans_FEXPA(DisasContext *s, arg_FEXPA *a)
+{
+    static gen_helper_gvec_2 * const fexpa_fns[4] = {
+        NULL,                   gen_helper_sve_fexpa_h,
+        gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
+    };
+
+    if (!dc_isar_feature(aa64_ssve_fexpa, s)) {
+        if (!dc_isar_feature(aa64_sve, s)) {
+            return false;
+        }
+        s->is_nonstreaming = true;
+    }
+    return gen_gvec_ool_zz(s, fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah);
+}
 
 static gen_helper_gvec_3 * const ftssel_fns[4] = {
     NULL,                    gen_helper_sve_ftssel_h,
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3ef5b53e8a..a12471aafe 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -175,6 +175,7 @@ the following architecture extensions:
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
+- FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8DOT4 (SVE2 FP8 4-way dot product to single-precision instructions in Streaming SVE mode)
 - FEAT_SSVE_FP8FMA (SVE2 FP8 multiply-accumulate to half-precision and single-precision instructions in Streaming SVE mode)
-- 
2.43.0


