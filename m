Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8466C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFVn-0001Ph-K5; Tue, 21 Jul 2026 14:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUp-00011y-7F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:15 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUn-0006e4-HC
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:14 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso9620806a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659632; x=1785264432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hsWJfs/ZCQ+zp1pClMZhTNWi2y5w7gqtx815LkLYbP4=;
 b=jcT/K7Ztgpz594oXCYUwEvSoiBUSDlFZsl1JooIYP9rThsigUxuV7CSUvtM3HrcboV
 jUsyvNwiLcU67lIx2ZNg+vmHHoLutP9EMBO44KpJSYGmYBr73pv0mc1RPd/s5gtvYkVW
 LU0UgdsntMemu7gBxV4XjxZDgsLBBS8SYJcHkcsjWadESw+uqe3DpW9mFYIvgO9ac0IH
 r4Zz2bXjnECU5jjH2XdDyX1dUF3KIfIs2JZBHEgcGcJIICvk3V0MZrOon2JushItvt7Z
 gTCI0L1r3BIKrMovIFZy0lPQYLLAxooARAEwHcA7/VAGHlPKcKjJuDpkAS8LajTImE/E
 8v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659632; x=1785264432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hsWJfs/ZCQ+zp1pClMZhTNWi2y5w7gqtx815LkLYbP4=;
 b=iLk9caXdnNGRlPopj8KGfg3Okj9erAipVuAcyLIvCV3MLg6ksd+4c+pQItWT6y81Hs
 6W1/c4hLXmcsv12mYfkq1FLtGDElU9uVW+5MbNs7b4aQbP4vJgejua1Ju7CPulLJCMwm
 y4cR+5vVD6u36kx7yzonX0Cnj/Ea6SicSw1E+ZK+VZTQqu34El3bYD8o69wagYuCd5Ub
 hynFCD5GwlM6AQFpMoKab9PEM7Sn1VrBhab4LbAM9YpwdJi0HKioe7Vo+fNnuErGxkfQ
 K96tKCFxj79YxOb8P5b7cGCz8jwCTWyY3sGH/DHTrdoCtfhP2ASBGtDkjSkYo6erMDtl
 P4sQ==
X-Gm-Message-State: AOJu0YwUIQFS1KTISNzH2CEiPF6niz6yYkDM2r1k+stH0UXGvyJIpBCR
 +57OtFp9vTSsRqn52fUrsav7ctWT3gqlgV47FWBq9TmNptKTnI0QKJo0fF22IJOnCY25oL1UVZw
 7uA+a
X-Gm-Gg: AR+sD13VE6o4GmG+BNNLNIqpGzUHaqR4XvokCNxfuR43QcHX0FlGYD62kbUkyUKTL9c
 wd5AR62v2+FLhfNj0s8kIh8zrrloXmG7863Iax3DepoufmwpJRrLZ5H81DGJ4DyjOJunitpfaPu
 mdxu9EefG/Bmr7bT3OGmZ2V/lygiDNRgNcaqc1N1/o5rGDJ9zaMkJHYUsOdKQb1PI5sdLcbYzwu
 4d/55h3POEe5LSBHNh3nYOU4kcuLf9FIqmuflr29qgd8Wtn4mSlpIi6DxtjP7qw/Cxkdjgi/Bwh
 VfxqSm/DUQOtSZTvIO0wWhSSQcMPCCv+Ao6UvJ/Y1tKxG1MnR93LFooDX61mMHtmjZWfvr7qYLh
 XJSYMKOKHlp0Hbp7D1+w8YeALHeRkYx0iWs2D4AJco8R34eVHOg4SG9f74//Em+SVoRxwri5nbp
 RdrDaz9MYfFPg3FlK3iw==
X-Received: by 2002:a17:90b:3942:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-38e4b59469cmr19496757a91.30.1784659632113; 
 Tue, 21 Jul 2026 11:47:12 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/20] target/arm: Rename isar_feature_aa64_sve_pmull128
Date: Tue, 21 Jul 2026 11:46:46 -0700
Message-ID: <20260721184656.530230-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

Rename from isar_feature_aa64_sve2_pmull128 to match
the feature name: FEAT_SVE_PMULL128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/aarch64/target_arch_elf.h | 2 +-
 target/arm/cpu-features.h          | 2 +-
 linux-user/aarch64/elfload.c       | 2 +-
 target/arm/tcg/translate-sve.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index 2fb7dcd778..6f9d192b4f 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -127,7 +127,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
-    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b29cd49020..750be9b1b1 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1534,7 +1534,7 @@ static inline bool isar_feature_aa64_sve_aes(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) != 0;
 }
 
-static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
+static inline bool isar_feature_aa64_sve_pmull128(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64ZFR0, AES) >= 2;
 }
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index bcf2e6b9c1..40c5e1dbd3 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -193,7 +193,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_dcpodp, ARM_HWCAP2_A64_DCPODP);
     GET_FEATURE_ID(aa64_sve2, ARM_HWCAP2_A64_SVE2);
     GET_FEATURE_ID(aa64_sve_aes, ARM_HWCAP2_A64_SVEAES);
-    GET_FEATURE_ID(aa64_sve2_pmull128, ARM_HWCAP2_A64_SVEPMULL);
+    GET_FEATURE_ID(aa64_sve_pmull128, ARM_HWCAP2_A64_SVEPMULL);
     GET_FEATURE_ID(aa64_sve2_bitperm, ARM_HWCAP2_A64_SVEBITPERM);
     GET_FEATURE_ID(aa64_sve2_sha3, ARM_HWCAP2_A64_SVESHA3);
     GET_FEATURE_ID(aa64_sve2_sm4, ARM_HWCAP2_A64_SVESM4);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 52f370e47e..03d97dcaf5 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7233,7 +7233,7 @@ static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
     };
 
     if (a->esz == 0) {
-        if (!dc_isar_feature(aa64_sve2_pmull128, s)) {
+        if (!dc_isar_feature(aa64_sve_pmull128, s)) {
             return false;
         }
         s->is_nonstreaming = !dc_isar_feature(aa64_ssve_aes, s);
-- 
2.43.0


