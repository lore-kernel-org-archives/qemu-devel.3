Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB53CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBM-0005Q9-RQ; Wed, 08 Oct 2025 17:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAK-0004Nz-C1
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:47 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9H-0006jw-E6
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:44 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so194544a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960595; x=1760565395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMk8zdLebXgz2q5eQ22qMhBeUAIlZk56wd1eur3ogN0=;
 b=b3SV6KkZoAwH+TOpzrs8GnaUyxDFuqqkQrhmXYGnFGOXFiezYdQ7EGQEOuKeyytigh
 bsXi6SQAXvQSYGkTjhi4tKJcxKyBN174qrVH/UKHttjeuvKE02Vdw8qd59LDZhNlNStK
 mCyjRbYEthFD+66Gjjd4Lz7er4kNpliqGuiU0UJJEh5S3wsbM1475qGsSY8FleO4odmW
 xGj7kB9xjsL3OWsDvFSIJ4puvg1Dlr3NZ9vEzNS9E7q5yrlzFp211qjqSGS2yPDK8yGF
 WHLgUYKnjArZN+shtBYm55VBWsjenXL0JyqfTddl2aN69LkCYjpkWMcS7sdh6vUGOf/P
 QC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960595; x=1760565395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xMk8zdLebXgz2q5eQ22qMhBeUAIlZk56wd1eur3ogN0=;
 b=eUPRqd/jDfPrf2jDqy61VlN0bRtztNefiZTAeZL2qEDA7AIthe4JulX5vRx1fqgj/q
 rIuJFFX8p/VJQsaJDeY2FnNwhOnHxHfNzCNr4k/7BFXjnIeB+XSfVqcfwObHPjw3H1X3
 QEPmyUcwsl6+EulD/cKGOJeUsWjyjqii2Of9WL6/c6ht7j1lruYzbSIQZzPL1Pc0tApz
 4G2JQV7aHs0+h1TFg5yvFNoG4y4pKw8sNsdgrfDjrPHzq7rquVXWQgzhQrU5BYDQL5Qv
 jxtOzWFbC7AJSv1Y1ReVIuc1b8J2/R/8W9d/FxYO7hNB+/yqEZJmM80Av16aDmH9yMN6
 xhew==
X-Gm-Message-State: AOJu0YwYxfVgfN/Cc+4yiUq3d3z4AFfR++08JDytVfa8NpuZKZzhd5gk
 x5e7R8RxcjzCGII7hT5hEqrIZy06wknSJw4esKeK09GSaJkbvvh8YhQpzNCIbxwxpSef/g7nb0M
 VLTOoxWo=
X-Gm-Gg: ASbGncumE8JHVkwTlje2rTxIIJphkOlxDV3Iw5v8eSBZYupb3DB08ySeZ4nI73MSXOx
 8/W2Ho62ehy6hS/gpDAFlamRbgEzP4PEpgHUdWDAm55f8w5umwCYb9MLpgMoCsylrzA0myoPTjO
 BeIRxBPjg7C+KyQIkTwRnw3qb4e9qDu55czu7M/oXVQtyg84cD6EeYBs0CULKoQ2pQYYizJgDi/
 3jTo4jMVltf2O5CXFc2O4e+vZbp/7LtJ51edAbgcolAJLAFRBpE1rvXxUSw0MT1owqtTaTmK1L0
 eMnJomr5ygKSrOJAeB1eEqJU4NmX3RFKej9VjsQ43mUMYwu2Fw7Q7dgakb4TTqr1FETnJPaIF1w
 iNShJpJSEy18WizJWqIBUBO0FCO0Ty0/1vYIsM8s4zauCUkyrgt8wING7SW7Lf/RV2JM=
X-Google-Smtp-Source: AGHT+IGgjBhu6r/Szg6nQjSyhxxrjs3NIwH/Ipuztt2HqwoEs6qY46r4FIg/VrWqWYMNIiqzfSdaRw==
X-Received: by 2002:a17:903:298c:b0:265:982a:d450 with SMTP id
 d9443c01a7336-290273ffbf1mr65301245ad.40.1759960595234; 
 Wed, 08 Oct 2025 14:56:35 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 32/73] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Wed,  8 Oct 2025 14:55:32 -0700
Message-ID: <20251008215613.300150-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Pipe GCSEnabled, GCSReturnValueCheckEnabled, and CheckGCSSTREnabled
through hflags to the translator.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               |  3 +++
 target/arm/tcg/translate.h     |  6 ++++++
 target/arm/tcg/hflags.c        | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e55524ae10..775219364f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2475,6 +2475,9 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
 FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
+FIELD(TBFLAG_A64, GCS_EN, 41, 1)
+FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
+FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f1a6e5e2b6..761edded52 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -166,6 +166,12 @@ typedef struct DisasContext {
     bool fpcr_ah;
     /* True if FPCR.NEP is 1 (FEAT_AFP scalar upper-element result handling) */
     bool fpcr_nep;
+    /* True if GCSEnabled. */
+    bool gcs_en;
+    /* True if GCSReturnValueCheckEnabled. */
+    bool gcs_rvcen;
+    /* GCSSTR exception EL or 0 if enabled */
+    uint8_t gcsstr_el;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 17f83f13a4..5c9b9bec3b 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -451,6 +451,44 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         DP_TBFLAG_A64(flags, TCMA, aa64_va_parameter_tcma(tcr, mmu_idx));
     }
 
+    if (cpu_isar_feature(aa64_gcs, env_archcpu(env))) {
+        /* C.f. GCSEnabled */
+        if (env->cp15.gcscr_el[el] & GCSCR_PCRSEL) {
+            switch (el) {
+            default:
+                if (!el_is_in_host(env, el)
+                    && !(arm_hcrx_el2_eff(env) & HCRX_GCSEN)) {
+                    break;
+                }
+                /* fall through */
+            case 2:
+                if (arm_feature(env, ARM_FEATURE_EL3)
+                    && !(env->cp15.scr_el3 & SCR_GCSEN)) {
+                    break;
+                }
+                /* fall through */
+            case 3:
+                DP_TBFLAG_A64(flags, GCS_EN, 1);
+                break;
+            }
+        }
+
+        /* C.f. GCSReturnValueCheckEnabled */
+        if (env->cp15.gcscr_el[el] & GCSCR_RVCHKEN) {
+            DP_TBFLAG_A64(flags, GCS_RVCEN, 1);
+        }
+
+        /* C.f. CheckGCSSTREnabled */
+        if (!(env->cp15.gcscr_el[el] & GCSCR_STREN)) {
+            DP_TBFLAG_A64(flags, GCSSTR_EL, el ? el : 1);
+        } else if (el == 1
+                   && EX_TBFLAG_ANY(flags, FGT_ACTIVE)
+                   && !FIELD_EX64(env->cp15.fgt_exec[FGTREG_HFGITR],
+                                  HFGITR_EL2, NGCSSTR_EL1)) {
+            DP_TBFLAG_A64(flags, GCSSTR_EL, 2);
+        }
+    }
+
     if (env->vfp.fpcr & FPCR_AH) {
         DP_TBFLAG_A64(flags, AH, 1);
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a0e3300231..693eab1c01 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10344,6 +10344,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
+    dc->gcs_en = EX_TBFLAG_A64(tb_flags, GCS_EN);
+    dc->gcs_rvcen = EX_TBFLAG_A64(tb_flags, GCS_RVCEN);
+    dc->gcsstr_el = EX_TBFLAG_A64(tb_flags, GCSSTR_EL);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.43.0


