Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABD6C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraue-00047f-Ti; Thu, 28 Aug 2025 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauK-0003f4-PM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauI-00065U-LQ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso5033665e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380905; x=1756985705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tiT8sfxtJED9cTlqO78ECD4NGjv4tcXWJ2sLdQU3sWk=;
 b=M1TZY0g2mag97MRNDlBFmC/zt/44D2vnqJpWaBrXCbCuuqL5c13HJqf9m753cZEXeo
 2UMrmFb4wASrtbvkulbFUIJe+7r5+MGy+x22H1LIL3thKeMrfJYuMf16TKdXZetKcbPA
 xwk1BaJeUeT8BYW+ArW5sEHrsjujvtRDAum1MCkxkSeVGafLu2AVzZ0t0rC6PbHutRCI
 tXFeIIW/7ENR9a7CMLNyPnQg20k3J5IQ8iRHNkF1Ca+QOpupdFMsr8g+DhC4V0NvX7uU
 wcaHZb4gtC8ZS5p1/hJqcaqrHy5KEvR8q2cu5lQKg2eItVf+sodmcGqnCJD6WBqWg7GD
 heZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380905; x=1756985705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiT8sfxtJED9cTlqO78ECD4NGjv4tcXWJ2sLdQU3sWk=;
 b=mWPhipmWI6fsASwB5X7CsSho2zHNDhSKdGRZ3LLv8MaDTYNMeZ+BO3QJq2ZOY9yZUH
 p9mKZe2Caou4ipPcR+7DQyX3Vg5h9B/5QXb1Sj95FaqeBIRbBzpC4LVbxxWQVZe98fcg
 eC8ai697y1dGByC4J9Rws9r5/m+3g+58QHWhqxpW0mM2vx2B9K2UkeB1Mqk2PNg9z5T5
 Vu6bkYOiVUqViriN0HBJv2ErMvpv4Vbibwtvm6Dn4wY+x3nw4p2nz3KtGGCKMA2z50AK
 MNkb/Xib2ZWTVmftsKvT7BzGK90Aj6mRgAlsucRsNjWfNuFtZSS9ZQ4JcPiyNbpO8tAK
 YquQ==
X-Gm-Message-State: AOJu0YxsHI8WyRpRtpNZgW2bl2kaFZ0lX2LfVzY6TsX57bqgOli2P9H9
 QOpokPc6XIC1LPuI9NtLV8tpKkjgScgtSoESXjwX4oXnmXEfizEvDQtivlBe5kc0lKcGOtNd6rJ
 rgWwY
X-Gm-Gg: ASbGncuAdOXaQ9ui4i1Z7VwycN8uO+dozLiiZMclqmm/f62gFxgBUBAtgcKQbcZJSBT
 EoRJemzUmIxHN/+P0cgc+6CgNWrCL+/iwj/gF0xy0HyiwkYEUn6Z1RXhLXGvxejqLo+0UtDL/z0
 DN+Aq8ArrqBnovy7Vh/lfcGdeESKqo6AEZtzFuhBYdlpdhMsk3lhHONInNyMCscN/FKAv7kfDaU
 vnakoBzJVV6MypMURKplcaGtZnXvAzY+GPgcMfHZQHvqUeEAYCMFE2EXpavYnfXLRSrS8zU5OqR
 PpgpY+V376mmyXYG/7A5skdujo4EFbiKRENlwFyfXOFRWAzZbvD3yVCLncKT8W/vDNS6vEU+4di
 6P8HyTje4nE/5yhUQwkQEZbSFlVS48Q+mxt2C3HU=
X-Google-Smtp-Source: AGHT+IEsacV+FU5y7uwiod9ThU1ZmO+ISmEy1goZptPbNcODJojaSBvMWq8Wvnik7HqxebJpCnbJJg==
X-Received: by 2002:a05:600c:a49:b0:453:66f:b96e with SMTP id
 5b1f17b1804b1-45b517ad6b4mr196731645e9.11.1756380904833; 
 Thu, 28 Aug 2025 04:35:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.35.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:35:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] target/arm: Rename isar_feature_aa64_atomics
Date: Thu, 28 Aug 2025 12:34:26 +0100
Message-ID: <20250828113430.3214314-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: <qemu-devel.nongnu.org>
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

This is FEAT_LSE -- rename the predicate to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250815122653.701782-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  2 +-
 linux-user/aarch64/elfload.c   |  2 +-
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index d48754bcf27..451b37b5b39 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -406,7 +406,7 @@ static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, CRC32) != 0;
 }
 
-static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_lse(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) >= 2;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 482c0df2d7f..0bec43d8c38 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -151,7 +151,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
-    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_lse, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE_ID(aa64_lse2, ARM_HWCAP_A64_USCAT);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 259aa70a36d..0ba537268cd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3237,7 +3237,7 @@ static bool trans_LDXP(DisasContext *s, arg_stxr *a)
 
 static bool trans_CASP(DisasContext *s, arg_CASP *a)
 {
-    if (!dc_isar_feature(aa64_atomics, s)) {
+    if (!dc_isar_feature(aa64_lse, s)) {
         return false;
     }
     if (((a->rt | a->rs) & 1) != 0) {
@@ -3250,7 +3250,7 @@ static bool trans_CASP(DisasContext *s, arg_CASP *a)
 
 static bool trans_CAS(DisasContext *s, arg_CAS *a)
 {
-    if (!dc_isar_feature(aa64_atomics, s)) {
+    if (!dc_isar_feature(aa64_lse, s)) {
         return false;
     }
     gen_compare_and_swap(s, a->rs, a->rt, a->rn, a->sz);
@@ -3743,15 +3743,15 @@ static bool do_atomic_ld(DisasContext *s, arg_atomic *a, AtomicThreeOpFn *fn,
     return true;
 }
 
-TRANS_FEAT(LDADD, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_add_i64, 0, false)
-TRANS_FEAT(LDCLR, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_and_i64, 0, true)
-TRANS_FEAT(LDEOR, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_xor_i64, 0, false)
-TRANS_FEAT(LDSET, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_or_i64, 0, false)
-TRANS_FEAT(LDSMAX, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_smax_i64, MO_SIGN, false)
-TRANS_FEAT(LDSMIN, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_smin_i64, MO_SIGN, false)
-TRANS_FEAT(LDUMAX, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_umax_i64, 0, false)
-TRANS_FEAT(LDUMIN, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_fetch_umin_i64, 0, false)
-TRANS_FEAT(SWP, aa64_atomics, do_atomic_ld, a, tcg_gen_atomic_xchg_i64, 0, false)
+TRANS_FEAT(LDADD, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_add_i64, 0, false)
+TRANS_FEAT(LDCLR, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_and_i64, 0, true)
+TRANS_FEAT(LDEOR, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_xor_i64, 0, false)
+TRANS_FEAT(LDSET, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_or_i64, 0, false)
+TRANS_FEAT(LDSMAX, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_smax_i64, MO_SIGN, false)
+TRANS_FEAT(LDSMIN, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_smin_i64, MO_SIGN, false)
+TRANS_FEAT(LDUMAX, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_umax_i64, 0, false)
+TRANS_FEAT(LDUMIN, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_fetch_umin_i64, 0, false)
+TRANS_FEAT(SWP, aa64_lse, do_atomic_ld, a, tcg_gen_atomic_xchg_i64, 0, false)
 
 static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
 {
@@ -3759,7 +3759,7 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
     TCGv_i64 clean_addr;
     MemOp mop;
 
-    if (!dc_isar_feature(aa64_atomics, s) ||
+    if (!dc_isar_feature(aa64_lse, s) ||
         !dc_isar_feature(aa64_rcpc_8_3, s)) {
         return false;
     }
-- 
2.43.0


