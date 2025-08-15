Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35147CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWx-00018G-Jj; Fri, 15 Aug 2025 08:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWd-00015H-R2
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWb-0007YW-KW
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:15 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e39ec6e05so984832b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260832; x=1755865632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FXjkQXdB1cnyWfZEPDVzu1UrhqtJ/eTeah1TtiZRU90=;
 b=LMMghVizyXkvNyZwbawBZ53hWrR8FtZ3hEL5DbiueazekpY3NqUrTBA88Dbvta6INx
 xTgJa6dsh4dxkXJjuFqFCj92W3B9ejahcf97flKo6grWAxKSrZCN+cNwx8ES5xgI+NzH
 k6YKfqROBCUX+RQJITwNnTHg7GXwa90E8Kyn1VBVMbhIF6NDFybm9TPa1r6orbrsp/Yh
 wUBf74kMpc0okxdVkMDJ+LhXGGtxPitYGPXfzY4CaE11xIdJuVx3KjrStNXihBhKwvGq
 6cEyt9Kue4U4+woxw2dMScJx/t+HN2eagfdYgql+LDy5bbtZf6tN9UxlNDI2q60DLXIC
 sDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260832; x=1755865632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FXjkQXdB1cnyWfZEPDVzu1UrhqtJ/eTeah1TtiZRU90=;
 b=HivOkOXuG9XPaZkTRYjKHcFw5wRSqpDEraWoSNzwloBIFatDhpt5TEcjBJPipg2URk
 CjaoZNCaTjOUL0Dfvy3FZufe9ZzQP42skapifldsVt9bxknPgRe5+bgCxs9qolPXbpRu
 SUc33c4MrmnCat70NL/v8st+A6HoBk13jtYYoB16lreqB6yYwd+QuFuW1FJaqOTpgnxI
 kDGVXw8T8EkHrG7GFrVlQSCQ4nNkmYox7I9S8317XfXNvHc9isY29DeSmyAjuG6ouN6L
 +g7cefnMsVzv5NbGP83cLkIYPaOhZhD24MLVpnYwFsEK9KBEoe2lPry066j89I2KDF6Q
 BhwA==
X-Gm-Message-State: AOJu0Yx1lXWFjnj9YRat4JYu4PhZqLbxTsHysN26w37OWNpVvk69A2nJ
 lNp+N8AAUTrdk5DnB6l9DRQEQYC5qUZwAg1JriBVRTZ4W6kvmIIZHYNAbciVX0n9pbKQBqYYQjV
 eI+/tS90=
X-Gm-Gg: ASbGncvPdPtjZMDobNajWMpkXaJdY5iaHIPdAU5/hYSL1bVaWsDX7ZGEqin9pX8sbjU
 ye6KZWaVRS8E6kuE+FzQh4MsnXn4+baVJzq+Uc694tZo8h1sqxDY+YGTOGESPEsIqTpNeBGruv8
 n9fHMrslNjdMviqVYmkAuW/B7PBSIk1LAAq+9KNEFRGr/KFy/UZEQd941ZkYGhKBWl8g92r/8Iq
 iDgd8tXD+385FKSvYch95BfQpk3Sir9inyAigV5SqbHhh1WqnyIWkpm3UsDmxK159Op725sJOOl
 waleckRaaDxFnpIJ0pzzw72g95KpQcMgDWHk46Ta4Gz8Abpz21a+bAj/zcZ7noz4Yd0q7kMZbLQ
 FATv0x7rfq8PpuIKIyTN6jKw9t7N5c8D/VJAZUBuv9W6vrkE=
X-Google-Smtp-Source: AGHT+IHJlxynQAfzlFLMK7JnTwv38RazmkxXnPZakLvFfdjC1wafSR0T0XR/alMAfGA2+b/DeIfKYA==
X-Received: by 2002:a05:6a00:b84:b0:76b:f063:a3cb with SMTP id
 d2e1a72fcca58-76e44818e50mr2591486b3a.19.1755260831797; 
 Fri, 15 Aug 2025 05:27:11 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.27.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:27:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/arm: Rename isar_feature_aa64_atomics
Date: Fri, 15 Aug 2025 22:26:51 +1000
Message-ID: <20250815122653.701782-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
References: <20250815122653.701782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

This is FEAT_LSE -- rename the predicate to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      |  2 +-
 linux-user/elfload.c           |  2 +-
 target/arm/tcg/translate-a64.c | 24 ++++++++++++------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 5876162428..e3d4c3d382 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -406,7 +406,7 @@ static inline bool isar_feature_aa64_crc32(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, CRC32) != 0;
 }
 
-static inline bool isar_feature_aa64_atomics(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_lse(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ISAR0, ATOMIC) != 0;
 }
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..9f36ec06a4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -862,7 +862,7 @@ uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_sm3, ARM_HWCAP_A64_SM3);
     GET_FEATURE_ID(aa64_sm4, ARM_HWCAP_A64_SM4);
     GET_FEATURE_ID(aa64_fp16, ARM_HWCAP_A64_FPHP | ARM_HWCAP_A64_ASIMDHP);
-    GET_FEATURE_ID(aa64_atomics, ARM_HWCAP_A64_ATOMICS);
+    GET_FEATURE_ID(aa64_lse, ARM_HWCAP_A64_ATOMICS);
     GET_FEATURE_ID(aa64_lse2, ARM_HWCAP_A64_USCAT);
     GET_FEATURE_ID(aa64_rdm, ARM_HWCAP_A64_ASIMDRDM);
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index dbf47595db..d0639e29cf 100644
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


