Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8570DC5AC7C
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws18P-0006ph-Jq; Thu, 06 Aug 2026 12:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18K-0006nm-R5
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ws18G-0000Jz-Gs
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 12:39:52 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cfff5f88dbso35402385ad.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786034387; x=1786639187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GrbyJ2r1hxRgJ5HumO1lxxfAhm91/uPN2Af2Cbfu+1g=;
 b=Aqa4Ao379S+JynEKAh8YzqHEkwcJ9gAeLNGzK3Y660bURi6UMPZWeaj+2FF5cLi0N7
 vI9idhaQcY+iZN6vY6EgC+eB4uUiqZuyDEc4DhNnsvQQPKETx8evTUjY2mHmSXf8yU1U
 JlZBMFwGSsyqoSx9RgWem7FrDbq44Yn1zjlG5Yie0w+aovIotSHuyxRgGaaUSoKW8NYn
 41X3oRlItAEjyjKBDOyUgYFY01Q+GnIUWqtlD3cDEkp/2BjQOBfEdsXy7uCsKeOictTQ
 SzCKI0wigmXYcgicPJYZrHr5GMrgWRGKuEWTuBWteBET4Q1NK7quaoOKtx/Xs5V7qfGy
 gjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786034387; x=1786639187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GrbyJ2r1hxRgJ5HumO1lxxfAhm91/uPN2Af2Cbfu+1g=;
 b=HEKYeGniEYhtzEqgDJYp4Jdd1g+NZ11OfgEKtczJdE9SGMNYU7LC1uFAYYB5QS3jBY
 xGdYy5K9td3J9+BwrCNcHnBJtB12dogUI09AzhIEyAGxPs4KdvpLCyQKRdXJtw8kPgJS
 g5VXBtUSNk7FQOJtG+tpDw2+Rk/d9+iPOActTzOizofJ/diUjRyNpFAov2rUGyQrrsmf
 I9gPg/p4QOmdRG774GUiWwvokrijlZqOMA2qLTnGPViuhNSeZogu2Q/kYZ2dw8eLH/UB
 U9MxoiRO1rTW78ZeOvFlhX+h22nbkCN4rgrXf5BTtNTc25zgHypWbXxjtORqyTc21uJx
 ZdWA==
X-Gm-Message-State: AOJu0YwDZAdQXvryFE1VvJK6lCfRX4dUj0SXDSH2HAg1nLPkzM9u4quz
 zWbOZZwqQXcegwJdNvzGOpN6T0kwD8aXi8Fsyv2t6J6tQi5ZqdmWOUL3/Zje0N8hEjEkLthTi3Q
 cFIvf
X-Gm-Gg: AR+sD12OTssmC0F7vbHa6QyBwOtzFXBpEpBCd1IZBQcH3YKAb1xa3GEjko83xxXfnUJ
 tTy4szZaE8Af9CBREdlRzRttvZPML/kZ1EslztO14zqm/jpGSTEjRO8S8dw3EBQPIbg2kic6Qb1
 Lqdgc2yKS+f8gbpv0RX5fDZulVS9tYHY0x1EEjq2GUkkk0Wn+SPETGZWFXGbhHcEXLKfaJqtKYW
 jWuk4uh47wQZqJQ+k0qVUqlyp3L35dD8Fy6xLlvv9YPKKY0z+veLlhjAqV2dGtwNzRQtEUezv5N
 FuWxRKYCfFazLMZ+91lbAej7Pg8I0cw8iuMDITD2YeYIca4tK+rGTldea2CHSTviIRE9QdA/j9x
 R9IGT/KvqngI4+SF4uoHfJO4cMEVg9V6Zl2d97ggwddVZCE/7mh5rCpKMOhmhDNL2v+Bot89ERD
 RgCyDhZygTOF9+oahtA5/rtfxfeY9/WByDnptP3wK75PSrHpvAEvCHD2C9HgVt0S2jezMFg3Jvx
 vCWdKnMwyyOc00YlwiA
X-Received: by 2002:a17:903:17c3:b0:2c9:e86e:aa0a with SMTP id
 d9443c01a7336-2d0ca165189mr191239495ad.0.1786034386673; 
 Thu, 06 Aug 2026 09:39:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4ec8c7sm34280735ad.80.2026.08.06.09.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 09:39:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 7/7] target/arm: Separate cpu types max-v8 and max-v9
Date: Thu,  6 Aug 2026 09:39:39 -0700
Message-ID: <20260806163939.328201-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806163939.328201-1-richard.henderson@linaro.org>
References: <20260806163939.328201-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Do not include v9-only features in "max-v8".
Do not include the prohibited v8 features in "max-v9".
In tcg mode, define "max" as "max-v9".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h        |   2 +-
 target/arm/cpu-max.c          |   2 +-
 target/arm/tcg/cpu64.c        | 408 ++++++++++++++++++++--------------
 target/arm/tcg/stubs32.c      |   2 +-
 docs/system/arm/emulation.rst |  11 +-
 5 files changed, 253 insertions(+), 172 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5e7f41a50d..2ced0b1c2c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1809,7 +1809,7 @@ void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
 void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp);
-void aarch64_max_tcg_initfn(Object *obj);
+void aarch64_max_v9_tcg_initfn(Object *obj);
 void aarch64_add_pauth_properties(Object *obj);
 void aarch64_add_sve_properties(Object *obj);
 void aarch64_add_sme_properties(Object *obj);
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index cfcc46eb9d..e6872c1c8d 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -220,7 +220,7 @@ static void cpu_max_initfn(Object *obj)
          * '-cpu max' for TCG: we currently do this as
          * "A57 with extra things"
          */
-        aarch64_max_tcg_initfn(obj);
+        aarch64_max_v9_tcg_initfn(obj);
     }
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 556fa9fa3c..5eeb6712da 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1156,13 +1156,11 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
 }
 
 /*
- * -cpu max: a CPU with as many features enabled as our emulation supports.
- * The version of '-cpu max' for qemu-system-arm is defined in cpu32.c;
- * this only needs to handle 64 bits.
+ * -cpu max-v8: an ARMv8 CPU with as many features enabled as
+ * our emulation supports.
  */
-void aarch64_max_tcg_initfn(Object *obj)
+static void aarch64_max_v8_tcg_initfn_aa64(ARMCPU *cpu)
 {
-    ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
     uint64_t t;
     uint32_t u;
@@ -1226,203 +1224,148 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, CTR_EL0, DIC, 1);
     cpu->ctr = t;
 
+    /*
+     * Below, note the revision from which the feature is OPTIONAL.
+     */
     t = GET_IDREG(isar, ID_AA64ISAR0);
-    t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* FEAT_SHA512 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* FEAT_CRC32 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* FEAT_LSE, FEAT_LSE128 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* FEAT_RDM */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* FEAT_SHA3 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* FEAT_SM3 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);      /* FEAT_SM4 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);       /* FEAT_DotProd */
-    t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);      /* FEAT_FHM */
-    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* FEAT_FlagM2 */
-    t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* FEAT_TLBIRANGE */
-    t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* FEAT_RNG */
+    t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* v8.0: FEAT_PMULL */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* v8.0: FEAT_SHA1 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SHA2, 2);     /* v8.1: FEAT_SHA512 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, CRC32, 1);    /* v8.0: FEAT_CRC32 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 2);   /* v8.0: FEAT_LSE */
+    t = FIELD_DP64(t, ID_AA64ISAR0, RDM, 1);      /* v8.0: FEAT_RDM */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SHA3, 1);     /* v8.1: FEAT_SHA3 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SM3, 1);      /* v8.1: FEAT_SM3 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, SM4, 1);      /* v8.1: FEAT_SM4 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);       /* v8.1: FEAT_DotProd */
+    t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);      /* v8.1: FEAT_FHM */
+    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* v8.1: FEAT_FlagM2 */
+    t = FIELD_DP64(t, ID_AA64ISAR0, TLB, 2);      /* v8.3: FEAT_TLBIRANGE */
+    t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* v8.4: FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR0, t);
 
     t = GET_IDREG(isar, ID_AA64ISAR1);
-    t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
+    t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* v8.1: FEAT_DPB2 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED); /* v8.2 */
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
-    t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* FEAT_JSCVT */
-    t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* FEAT_FCMA */
-    t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2);    /* FEAT_LRCPC2 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);  /* FEAT_FRINTTS */
-    t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);       /* FEAT_SB */
-    t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);  /* FEAT_SPECRES */
-    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* FEAT_BF16, FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
-    t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
-    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
+    t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 1);    /* v8.2: FEAT_JSCVT */
+    t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 1);     /* v8.2: FEAT_FCMA */
+    t = FIELD_DP64(t, ID_AA64ISAR1, LRCPC, 2);    /* v8.2: FEAT_LRCPC2 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 1);  /* v8.4: FEAT_FRINTTS */
+    t = FIELD_DP64(t, ID_AA64ISAR1, SB, 1);       /* v8.0: FEAT_SB */
+    t = FIELD_DP64(t, ID_AA64ISAR1, SPECRES, 1);  /* v8.0: FEAT_SPECRES */
+    t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 2);     /* v8.2: FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* v8.0: FEAT_DGH */
+    t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* v8.1: FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* v8.6: FEAT_XS */
     SET_IDREG(isar, ID_AA64ISAR1, t);
 
     t = GET_IDREG(isar, ID_AA64ISAR2);
-    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
-    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
-    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
-    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
-    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
-    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
+    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* v8.6: FEAT_RPRES */
+    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* v8.7: FEAT_MOPS */
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* v8.7: FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* v8.6: FEAT_WFxT */
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v8.7: FEAT_CSSC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* v8.8: FEAT_ATS1A */
     SET_IDREG(isar, ID_AA64ISAR2, t);
 
-    t = GET_IDREG(isar, ID_AA64ISAR3);
-    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* FEAT_FAMINMAX */
-    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* FEAT_FPRCVT */
-    SET_IDREG(isar, ID_AA64ISAR3, t);
-
     t = GET_IDREG(isar, ID_AA64PFR0);
-    t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
-    t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* FEAT_FP16 */
-    t = FIELD_DP64(t, ID_AA64PFR0, RAS, 2);       /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
-    t = FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);      /* FEAT_SEL2 */
-    t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* FEAT_DIT */
-    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* FEAT_CSV2_3 */
-    t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* FEAT_CSV3 */
+    t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* v8.2: FEAT_FP16 */
+    t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 1);   /* v8.2: FEAT_FP16 */
+    t = FIELD_DP64(t, ID_AA64PFR0, RAS, 2);       /* v8.3: FEAT_DoubleFault */
+    t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);       /* v8.2: FEAT_SVE */
+    t = FIELD_DP64(t, ID_AA64PFR0, SEL2, 1);      /* v8.3: FEAT_SEL2 */
+    t = FIELD_DP64(t, ID_AA64PFR0, DIT, 1);       /* v8.3: FEAT_DIT */
+    t = FIELD_DP64(t, ID_AA64PFR0, CSV2, 3);      /* v8.0: FEAT_CSV2_3 */
+    t = FIELD_DP64(t, ID_AA64PFR0, CSV3, 1);      /* v8.0: FEAT_CSV3 */
     SET_IDREG(isar, ID_AA64PFR0, t);
 
     t = GET_IDREG(isar, ID_AA64PFR1);
-    t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);        /* FEAT_BTI */
-    t = FIELD_DP64(t, ID_AA64PFR1, SSBS, 2);      /* FEAT_SSBS2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, BT, 1);        /* v8.4: FEAT_BTI */
+    t = FIELD_DP64(t, ID_AA64PFR1, SSBS, 2);      /* v8.0: FEAT_SSBS2 */
     /*
      * Begin with full support for MTE. This will be downgraded to MTE=0
      * during realize if the board provides no tag memory, much like
      * we do for EL2 with the virtualization=on property.
      */
-    t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* FEAT_MTE3 */
-    t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* FEAT_RASv1p1 + FEAT_DoubleFault */
-    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* FEAT_SME2 */
-    t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* FEAT_RNG_TRAP */
-    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
-    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
-    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
-    /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
+    t = FIELD_DP64(t, ID_AA64PFR1, MTE, 3);       /* v8.5: FEAT_MTE3 */
+    t = FIELD_DP64(t, ID_AA64PFR1, RAS_FRAC, 0);  /* v8.3: FEAT_DoubleFault */
+    t = FIELD_DP64(t, ID_AA64PFR1, RNDR_TRAP, 1); /* v8.4: FEAT_RNG_TRAP */
+    t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* v8.0: FEAT_CSV2_3 */
+    t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* v8.7: FEAT_NMI */
+    /* v8.7: FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
     t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
-    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
-    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* v8.7: FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1); /* v8.7: FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);   /* v8.7: FEAT_MTE_PERM */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
-    t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* 16k stage2 supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* 64k stage2 supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
-    t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
-    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
+    t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* v8.1: FEAT_LPA: 52 bits */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* v8.0: FEAT_TGran16K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* v8.0: FEAT_S2TGran4K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* v8.0: FEAT_S2TGran64K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /* v8.0: FEAT_S2TGran4K */
+    t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* v8.5: FEAT_FGT */
+    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* v8.5: FEAT_ECV */
     SET_IDREG(isar, ID_AA64MMFR0, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR1);
-    t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* FEAT_HAFDBS */
-    t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* FEAT_VMID16 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* FEAT_VHE */
-    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 2);     /* FEAT_HPDS2 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* FEAT_LOR */
-    t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* FEAT_PAN3 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* FEAT_XNX */
-    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* FEAT_ETS2 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* FEAT_HCX */
-    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* FEAT_AFP */
-    t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* FEAT_TIDCP1 */
-    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* FEAT_CMOW */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HAFDBS, 2);   /* v8.0: FEAT_HAFDBS */
+    t = FIELD_DP64(t, ID_AA64MMFR1, VMIDBITS, 2); /* v8.0: FEAT_VMID16 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, VH, 1);       /* v8.0: FEAT_VHE */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HPDS, 2);     /* v8.1: FEAT_HPDS2 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, LO, 1);       /* v8.0: FEAT_LOR */
+    t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 3);      /* v8.1: FEAT_PAN3 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, XNX, 1);      /* v8.1: FEAT_XNX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, ETS, 2);      /* v8.0: FEAT_ETS2 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, HCX, 1);      /* v8.6: FEAT_HCX */
+    t = FIELD_DP64(t, ID_AA64MMFR1, AFP, 1);      /* v8.6: FEAT_AFP */
+    t = FIELD_DP64(t, ID_AA64MMFR1, TIDCP1, 1);   /* v8.7: FEAT_TIDCP1 */
+    t = FIELD_DP64(t, ID_AA64MMFR1, CMOW, 1);     /* v8.7: FEAT_CMOW */
     SET_IDREG(isar, ID_AA64MMFR1, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR2);
-    t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1);      /* FEAT_TTCNP */
-    t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* FEAT_UAO */
-    t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* FEAT_IESB */
-    t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* FEAT_LVA */
-    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 2);       /* FEAT_NV2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* FEAT_TTST */
-    t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* FEAT_LSE2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* FEAT_IDST */
-    t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* FEAT_S2FWB */
-    t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* FEAT_TTL */
-    t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* FEAT_BBM at level 2 */
-    t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* FEAT_EVT */
-    t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
+    t = FIELD_DP64(t, ID_AA64MMFR2, CNP, 1);      /* v8.1: FEAT_TTCNP */
+    t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);      /* v8.1: FEAT_UAO */
+    t = FIELD_DP64(t, ID_AA64MMFR2, IESB, 1);     /* v8.1: FEAT_IESB */
+    t = FIELD_DP64(t, ID_AA64MMFR2, VARANGE, 1);  /* v8.1: FEAT_LVA */
+    t = FIELD_DP64(t, ID_AA64MMFR2, NV, 2);       /* v8.3: FEAT_NV2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, ST, 1);       /* v8.3: FEAT_TTST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, AT, 1);       /* v8.2: FEAT_LSE2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 1);      /* v8.3: FEAT_IDST */
+    t = FIELD_DP64(t, ID_AA64MMFR2, FWB, 1);      /* v8.3: FEAT_S2FWB */
+    t = FIELD_DP64(t, ID_AA64MMFR2, TTL, 1);      /* v8.3: FEAT_TTL */
+    t = FIELD_DP64(t, ID_AA64MMFR2, BBM, 2);      /* v8.3: FEAT_BBML2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, EVT, 2);      /* v8.2: FEAT_EVT2 */
+    t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* v8.4: FEAT_E0PD */
     SET_IDREG(isar, ID_AA64MMFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR3);
-    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
-    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
-    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
-    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
-    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
-    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
-    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);     /* v8.0: FEAT_TCR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);   /* v8.0: FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* v8.2: FEAT_FPACC_SPEC */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* v8.8: FEAT_S1PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* v8.8: FEAT_S2PIE */
+    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* v8.8: FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
-    t = GET_IDREG(isar, ID_AA64MMFR4);
-    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
-    SET_IDREG(isar, ID_AA64MMFR4, t);
-
     t = GET_IDREG(isar, ID_AA64ZFR0);
-    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* FEAT_SVE_BitPerm */
-    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* FEAT_BF16, FEAT_EBF16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* FEAT_SVE_B16B16 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* FEAT_SVE_SHA3 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* FEAT_SVE_SM4 */
-    t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* FEAT_I8MM */
-    t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* FEAT_F32MM */
-    t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* FEAT_F64MM */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BFLOAT16, 2);  /* v8.2: FEAT_EBF16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, I8MM, 1);      /* v8.1: FEAT_I8MM */
+    t = FIELD_DP64(t, ID_AA64ZFR0, F32MM, 1);     /* v8.2: FEAT_F32MM */
+    t = FIELD_DP64(t, ID_AA64ZFR0, F64MM, 1);     /* v8.2: FEAT_F64MM */
     SET_IDREG(isar, ID_AA64ZFR0, t);
 
     t = GET_IDREG(isar, ID_AA64DFR0);
-    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* FEAT_Debugv8p8 */
-    t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* FEAT_PMUv3p5 */
-    t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* FEAT_HPMN0 */
+    t = FIELD_DP64(t, ID_AA64DFR0, DEBUGVER, 10); /* v8.7: FEAT_Debugv8p8 */
+    t = FIELD_DP64(t, ID_AA64DFR0, PMUVER, 6);    /* v8.4: FEAT_PMUv3p5 */
+    t = FIELD_DP64(t, ID_AA64DFR0, HPMN0, 1);     /* v8.5: FEAT_HPMN0 */
     SET_IDREG(isar, ID_AA64DFR0, t);
 
-    t = GET_IDREG(isar, ID_AA64SMFR0);
-    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* FEAT_SSVE_FP8FMA */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* FEAT_SME2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* FEAT_SME_F8F32 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F8F16, 1);    /* FEAT_SME_F8F16 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* FEAT_SME_F64F64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* FEAT_SME_I16I64 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* FEAT_SME2p1 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* FEAT_SME_LUTv2 */
-    t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* FEAT_SME_FA64 */
-    SET_IDREG(isar, ID_AA64SMFR0, t);
-
-    t = GET_IDREG(isar, ID_AA64FPFR0);
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* FEAT_FP8 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* FEAT_FP8 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* FEAT_F8F16MM */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* FEAT_F8F32MM */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* FEAT_FP8DOT2 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* FEAT_FP8DOT4 */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* FEAT_FP8FMA */
-    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* FEAT_FP8 */
-    SET_IDREG(isar, ID_AA64FPFR0, t);
-
-    /* Replicate the same data to the 32-bit id registers.  */
-    aa32_max_features(cpu);
-
 #ifdef CONFIG_USER_ONLY
     /*
      * For usermode -cpu max we can use a larger and more efficient DCZ
@@ -1431,20 +1374,149 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
     set_dczid_bs(cpu, 7); /*  512 bytes */
 #endif
-    cpu->gm_blocksize = 6;  /*  256 bytes */
 
+    /* v8.2: FEAT_SVE */
     cpu->sve_vq.supported = MAKE_64BIT_MASK(0, ARM_MAX_VQ);
-    cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
+    aarch64_add_sve_properties(OBJECT(cpu));
+    object_property_add(OBJECT(cpu), "sve-max-vq", "uint32",
+                        cpu_max_get_sve_max_vq, cpu_max_set_sve_max_vq,
+                        NULL, NULL);
 
-    aarch64_add_pauth_properties(obj);
-    aarch64_add_sve_properties(obj);
+    /* v8.2: FEAT_PAuth2 */
+    aarch64_add_pauth_properties(OBJECT(cpu));
+
+    /* v8.4: FEAT_MTE2 */
+    cpu->gm_blocksize = 6;  /* 256 bytes */
+
+    /* v8.6: FEAT_LPA2 */
+    qdev_property_add_static(DEVICE(cpu), &arm_cpu_lpa2_property);
+}
+
+static void aarch64_max_v8_tcg_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    aarch64_max_v8_tcg_initfn_aa64(cpu);
+
+    /* Replicate the same data to the 32-bit id registers.  */
+    aa32_max_features(cpu);
+}
+
+/*
+ * -cpu max-v9: an ARMv9 CPU with as many features enabled as
+ * our emulation supports.
+ */
+void aarch64_max_v9_tcg_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    ARMISARegisters *isar = &cpu->isar;
+    uint64_t t;
+
+    /* Armv9.0 is based on a minimum of Armv8.5. */
+    aarch64_max_v8_tcg_initfn_aa64(cpu);
+
+    /*
+     * Armv9.0 does not support AArch32 except at EL0,
+     * therefore indicate EL1 through EL3 are AArch64-only.
+     */
+    t = GET_IDREG(isar, ID_AA64PFR0);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL1, 1);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL2, 1);
+    t = FIELD_DP64(t, ID_AA64PFR0, EL3, 1);
+    SET_IDREG(isar, ID_AA64PFR0, t);
+
+    /* v9.0 prohibits FEAT_DoubleLock. */
+    FIELD_DP64_IDREG(isar, ID_AA64DFR0, DOUBLELOCK, -1);
+    isar->dbgdevid = FIELD_DP32(isar->dbgdevid, DBGDEVID, DOUBLELOCK, 0);
+
+    /*
+     * Below, note the revision from which the feature is OPTIONAL.
+     */
+    t = GET_IDREG(isar, ID_AA64ISAR0);
+    t = FIELD_DP64(t, ID_AA64ISAR0, ATOMIC, 3);   /* v9.3: FEAT_LSE128 */
+    SET_IDREG(isar, ID_AA64ISAR0, t);
+
+    t = GET_IDREG(isar, ID_AA64ISAR2);
+    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
+    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
+    SET_IDREG(isar, ID_AA64ISAR2, t);
+
+    t = GET_IDREG(isar, ID_AA64ISAR3);
+    t = FIELD_DP64(t, ID_AA64ISAR3, FAMINMAX, 1); /* v9.2: FEAT_FAMINMAX */
+    t = FIELD_DP64(t, ID_AA64ISAR3, FPRCVT, 1);   /* v9.5: FEAT_FPRCVT */
+    SET_IDREG(isar, ID_AA64ISAR3, t);
+
+    t = GET_IDREG(isar, ID_AA64PFR1);
+    t = FIELD_DP64(t, ID_AA64PFR1, SME, 2);       /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* v9.3: FEAT_GCS */
+    SET_IDREG(isar, ID_AA64PFR1, t);
+
+    t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
+    SET_IDREG(isar, ID_AA64PFR2, t);
+
+    t = GET_IDREG(isar, ID_AA64MMFR3);
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
+    SET_IDREG(isar, ID_AA64MMFR3, t);
+
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* v9.4: FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
+    t = GET_IDREG(isar, ID_AA64ZFR0);
+    t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);    /* v9.2: FEAT_SVE2p1 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* v9.0: FEAT_SVE_PMULL128 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, BITPERM, 1);   /* v9.0: FEAT_SVE_BitPerm */
+    t = FIELD_DP64(t, ID_AA64ZFR0, B16B16, 1);    /* v9.2: FEAT_SVE_B16B16 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SHA3, 1);      /* v9.0: FEAT_SVE_SHA3 */
+    t = FIELD_DP64(t, ID_AA64ZFR0, SM4, 1);       /* v9.0: FEAT_SVE_SM4 */
+    SET_IDREG(isar, ID_AA64ZFR0, t);
+
+    t = GET_IDREG(isar, ID_AA64SMFR0);
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* v9.4: FEAT_SSVE_FEXPA */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* v9.4: FEAT_SME_MOP4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* v9.5: FEAT_SSVE_AES */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* v9.2: FEAT_SSVE_FP8DOT2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* v9.2: FEAT_SSVE_FP8DOT4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SF8FMA, 1);   /* v9.2: FEAT_SSVE_FP8FMA */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F32F32, 1);   /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, BI32I32, 1);  /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16F32, 1);   /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* v9.2: FEAT_SME */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* v9.2: FEAT_SME_F8F32 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F16, 1);    /* v9.2: FEAT_SME_F8F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* v9.2: FEAT_SME_F16F16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* v9.2: FEAT_SME_B16B16 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* v9.2: FEAT_SME2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F64F64, 1);   /* v9.2: FEAT_SME_F64F64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, I16I64, 0xf); /* v9.2: FEAT_SME_I16I64 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SMEVER, 2);   /* v9.2: FEAT_SME2p1 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, LUTv2, 1);    /* v9.2: FEAT_SME_LUTv2 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, FA64, 1);     /* v9.2: FEAT_SME_FA64 */
+    SET_IDREG(isar, ID_AA64SMFR0, t);
+
+    t = GET_IDREG(isar, ID_AA64FPFR0);
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E5M2, 1);   /* v9.2: FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8E4M3, 1);   /* v9.2: FEAT_FP8 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM4, 1);    /* v9.2: FEAT_F8F16MM */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8MM8, 1);    /* v9.2: FEAT_F8F32MM */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP2, 1);    /* v9.2: FEAT_FP8DOT2 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8DP4, 1);    /* v9.2: FEAT_FP8DOT4 */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8FMA, 1);    /* v9.2: FEAT_FP8FMA */
+    t = FIELD_DP64(t, ID_AA64FPFR0, F8CVT, 1);    /* v9.2: FEAT_FP8 */
+    SET_IDREG(isar, ID_AA64FPFR0, t);
+
+    /* v9.2: FEAT_SME */
+    cpu->sme_vq.supported = SVE_VQ_POW2_MAP;
     aarch64_add_sme_properties(obj);
-    object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
-                        cpu_max_set_sve_max_vq, NULL, NULL);
+
+    /* v9.1: FEAT_RME; v9.5: FEAT_RME_GPC3 */
     object_property_add_bool(obj, "x-rme", cpu_arm_get_rme, cpu_arm_set_rme);
+
+    /* v9.4: FEAT_RME_GPC2 */
     object_property_add(obj, "x-l0gptsz", "uint32", cpu_max_get_l0gptsz,
                         cpu_max_set_l0gptsz, NULL, NULL);
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_lpa2_property);
 }
 
 static const ARMCPUInfo aarch64_cpus[] = {
@@ -1462,8 +1534,8 @@ static const ARMCPUInfo aarch64_cpus[] = {
     { .name = "neoverse-n1",        .initfn = aarch64_neoverse_n1_initfn },
     { .name = "neoverse-v1",        .initfn = aarch64_neoverse_v1_initfn },
     { .name = "neoverse-n2",        .initfn = aarch64_neoverse_n2_initfn },
-    { .name = "max-v8",             .initfn = aarch64_max_tcg_initfn },
-    { .name = "max-v9",             .initfn = aarch64_max_tcg_initfn },
+    { .name = "max-v8",             .initfn = aarch64_max_v8_tcg_initfn },
+    { .name = "max-v9",             .initfn = aarch64_max_v9_tcg_initfn },
 };
 
 static void aarch64_cpu_register_types(void)
diff --git a/target/arm/tcg/stubs32.c b/target/arm/tcg/stubs32.c
index 78f819ef6f..939cea7189 100644
--- a/target/arm/tcg/stubs32.c
+++ b/target/arm/tcg/stubs32.c
@@ -28,7 +28,7 @@ void aarch64_host_initfn(Object *obj)
     g_assert_not_reached();
 }
 
-void aarch64_max_tcg_initfn(Object *obj)
+void aarch64_max_v9_tcg_initfn(Object *obj)
 {
     g_assert_not_reached();
 }
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 9930974a50..3400de6b76 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -229,7 +229,16 @@ to the `Arm Architecture Reference Manual for A-profile architecture
 When a specific named CPU is being emulated, only those features which
 are present in hardware for that CPU are emulated. (If a feature is
 not in the list above then it is not supported, even if the real
-hardware should have it.) The ``max`` CPU enables all features.
+hardware should have it.)
+
+The ``max-v8`` CPU enables all of the listed Armv8-A architecture
+extensions but none of the Armv9-A architecture extensions.
+
+The ``max-v9`` CPU enables all of the listed extensions except for
+those that are prohibited by the Armv9-A architecture: FEAT_AA32EL1,
+FEAT_AA32EL2, FEAT_AA32EL3, and FEAT_DoubleLock.
+
+The ``max`` CPU is an alias for ``max-v9`` under TCG emulation.
 
 R-profile CPU architecture support
 ==================================
-- 
2.43.0


