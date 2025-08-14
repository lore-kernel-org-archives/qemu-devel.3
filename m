Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C21CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXd1-0002Mo-Lh; Thu, 14 Aug 2025 09:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcY-0001zu-KB
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcR-00056r-Eu
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76e2e89e89fso1205969b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176625; x=1755781425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9sc0ZUHCkfd2ykNLWaRo5wL6kxQj6o6jh7+7rjjEiA=;
 b=WOkrIQzB0IAjYLDaN7oIXAPSeDyy83m8Y1KTUw0ksMl8iuMEmFj+rtkSlhWhzNMsys
 z5jCQqgINkI3Tzq6PhtoM9IRU4ThIWHDyjsUWtbdVvSqWT0R8201ZGd6RVTPFQlhAmB/
 TUX4QWdstFDe4yNOT8O2lv9roAnN3mUzEYZNPbaU0ULcbfIRjass2W0LKe6nrF/ha0TK
 /oeU2I5j9HKlMLVTWnwcLVdPnXPPxy/bAt1fXf2iUf18udlLwtgB7fEb+9GGJ8pOviy1
 GksbjLIteDezzcIyC8v8/bHE1ulNrRf8ct+32qZtKuoV4ilCfIkNXHCqtNdJu7Rr57MD
 A17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176625; x=1755781425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9sc0ZUHCkfd2ykNLWaRo5wL6kxQj6o6jh7+7rjjEiA=;
 b=VAxQw9umPrE1cy1YEPTRwtrZ3hhS95xdzx5VpZYmckBHlFJAOHtX3hgEV/3rMH54gK
 /3zUg5GnkeSwMVd8v63ILMoEc4L9KGC220KYQ/TDCJmtrBHpPS/dqEgFTdrVYCnywOIm
 lRi/M07KMSEmQlqK6F8O4uJxLBDodvs4ARa4TqYYl6Xu7zuUzhpKNPKkpTuGXtWJWqUq
 Pnd7R9vmFxthCJkqdrz4M8QJ6rtsEJaXjZ0GdyYfZ7PmKN+dA4ZI34aa/ASHqfnQY/ss
 OGLhWdKKRQAn6Icb6LdhCGJM16EgrqipuA9U9f3VGUSBQ+wLsNqcIo4lqpTGDLGMz+td
 uH3A==
X-Gm-Message-State: AOJu0Yy1c04fcnyS4RKXHurrvSmg+SvynEDEQX/2XTwditlrU5Wpo6N7
 LjnQIJZsG1csijB/bOPxBD85w4ZLLQy6vMYl0XlH7H0avQDczdmn82GW0UXS3TySrBGLHH3Dm7C
 +a/3N3e8=
X-Gm-Gg: ASbGncv67qbKe+SDqvOetAzJ67KIfzhEFqs0XECzHvy9O/EzOuYp1Lyr+Shj6udHwYN
 wfKsJNhTrciLEsVb+4R2Nf7YMIjcUhMvjGcdg/bD8sPDRyC4cgKksFOuyKRrAXnjPdOHv8jUTE0
 1wgq3CdvjgBXauQM/hCs6C5IdPkdC+m73ervJeWM3omUcD6Hon/koZmTWJZuU+HheX3Bl4t3sjb
 5PX63sMq7MsIGa3BR3YyOLxKAZ+vlMsMUynTkzBOKTAwS9AKdJdA/XWAmEwzkrg5HgsiLBBna3h
 cFGPVEp5sTCdVcMXGxO14DG51Qm1sOHUUM0Br1cVD0VUwOD6tdCDuyfyEarkM2lPA0QEG+oF5Z8
 HPsWWq3Rw5+tikcgZfcdK5TRB5nedlGvTBrFO74/Gg5sR8EM=
X-Google-Smtp-Source: AGHT+IGbyl2ibAjZX4aJX5cD0X2aJjoxo7/VCEseCnPTSGoYGCX+53Njtgo33ezzLhoLIOUEzZh9iw==
X-Received: by 2002:a05:6a00:180e:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-76e2fdcf721mr3912129b3a.21.1755176624532; 
 Thu, 14 Aug 2025 06:03:44 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:03:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 48/85] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Thu, 14 Aug 2025 22:57:15 +1000
Message-ID: <20250814125752.164107-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
index 1da73196f0..98360b70b8 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2918,6 +2918,9 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
 FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
 FIELD(TBFLAG_A64, ZT0EXC_EL, 39, 2)
+FIELD(TBFLAG_A64, GCS_EN, 41, 1)
+FIELD(TBFLAG_A64, GCS_RVCEN, 42, 1)
+FIELD(TBFLAG_A64, GCSSTR_EL, 43, 2)
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f974996f3f..3e63dad2b6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -164,6 +164,12 @@ typedef struct DisasContext {
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
index 59ab526375..2e3a9cf0d3 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -449,6 +449,44 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
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
index dbf47595db..7831b3dab3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10162,6 +10162,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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


