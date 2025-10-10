Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C636ECCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpq-0006Uy-NE; Fri, 10 Oct 2025 09:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpk-0006Rc-17
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:57 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp4-0003v7-Ea
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so18560465e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101566; x=1760706366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pub1kIdE9G64B6rKPe8H449qD7Aw9ZiKf5kp7WhFjHo=;
 b=cRh8NPw5nJs52yFplFmSNnxMQlPu/6V8i6kHEqz4fOVD9r0pBw8NnzDjeGUg9ovym3
 SxC2ScqZsa0kaK7nTWwlE6pk8ugukARStruEC5Lb1xEo1Q3yAh0fg+iga257nOdL2pCL
 UWBpIXQnBgoxuYDsDiiPnlf4YFED/KHk9uEC1CWsZSpiXxgP+po8qWdCKWikTAM1EgOd
 kId9yXdy0vDsZZVDnlZeBrwlXEIZRyaRzIIjqGr3/+Gx7wx2j0mLoY8Bfb7ZWNe8C5BE
 bKlO6FwiWRD/EFJjVMLituds0vWJkx2XoKyVtCPWhPTY/beyZMk99vWHzZT+SVnwXtDe
 BWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101566; x=1760706366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pub1kIdE9G64B6rKPe8H449qD7Aw9ZiKf5kp7WhFjHo=;
 b=lyJoIrCIr92+4B3O0m8Xizj7mPNnWrzt+zhgd1cHbuGjZg4FS+0+7qTkN0CLBQ7FKZ
 Tt0BAw/pPd4bdyR4QQcwkT6XD7XL07TYnNuWtxI/A6B4O2w5J6COjHoRqAiPGMdTy6aC
 K2KzkSe/l3NBGZJ55w55szfqjUQHMk4m3Y4tx0gWBial6WI5S31pcdG8ChABAjTagamF
 rmcaGPKsCnEbUGRJpVAl9DdxGtToQdX2LfjyETIbHJNMPqo9PU0FrLS2z0BGXcaHARNL
 HzqBDK/ZHcNT2rcbpVlqJeT2im5sWsDHKDenp4Wlc41Xf4UyDXvMUGQRYTBmWnI5C7Bm
 XvMA==
X-Gm-Message-State: AOJu0YzoUQ3Jm+KEOGVmeOK8CNEOG2tsr2qtv6QWB+0rmpdD8+D9vU8l
 35jv1snjxb8onGpCrlLgeUyYFmPfBQ5jNTs9UdSURoLAbdAV36+oDmeypyYElHOjBbpNf4qpS9M
 OE2Z1
X-Gm-Gg: ASbGncun1WzbmzgPPTTuiJSNq/7M7YWKBqWOEAxYIwalBHnHer3gaOxHtNAxuhC8E4v
 qsmTEuk2Kvf7T1n1CS43qdDFKwHcuqwnJN5qb/7Vx9Z4v9zaHl22/U0VKOfoICYnK5Q2cAZao14
 UXh18RhcuNr/HA/sylg+rfAz1dgKID1c5oAO9svMzcrXZ9N4u4wb8QaP9ZJS7fGTRWIAyCTrVuc
 hoZY3kUjVcx1ffAC2Zw6cbIER/tSYLIxcJCuIP4IBmyldxr8tzZy4+aeSyjNepX5eLaWGsyXIR7
 wcPGVzwoTdhZGX+Xw/kvc7K9SxUd3HOkAqZ4eF7k87zo+vSP2FgYjAtHHlN5H3WlKtcuXAcIYhG
 8U1oJkqKPFnBkJsiCgVy1JDywADQB9Js/LTV84GY0dfSw1mi6m9JUPTmmn8ZTtA==
X-Google-Smtp-Source: AGHT+IEWS/z7xR+ZpRsMfoY2tzXt3uREviYO4Q6eyK/SeVLHAGSKrE+pKshCDgasc3Xm3GRpGWrM4A==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e38c with SMTP id
 5b1f17b1804b1-46fb42ee457mr26532935e9.39.1760101566078; 
 Fri, 10 Oct 2025 06:06:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/76] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Fri, 10 Oct 2025 14:04:43 +0100
Message-ID: <20251010130527.3921602-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Pipe GCSEnabled, GCSReturnValueCheckEnabled, and CheckGCSSTREnabled
through hflags to the translator.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h               |  3 +++
 target/arm/tcg/translate.h     |  6 ++++++
 target/arm/tcg/hflags.c        | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e55524ae107..775219364f9 100644
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
index f1a6e5e2b61..761edded525 100644
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
index 17f83f13a40..5c9b9bec3b2 100644
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
index a0e3300231f..693eab1c012 100644
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


