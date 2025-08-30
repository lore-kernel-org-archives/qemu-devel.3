Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603DECA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNxb-0004Kg-4S; Sat, 30 Aug 2025 11:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQc-0007Fg-1i
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQW-0004qG-5d
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:02 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-248a638dbbeso24948195ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532812; x=1757137612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HuwdkVAoFOF4p8jzvARF3HMw2ObDHUzQ6j1si9mXITU=;
 b=eyBzWfhKPxIczEtF3+4yDtj1EUFDdSYBAD5BAh1U/3yt3FNLoP/0p/c2beMLu0hVIq
 QFR+pdfS197EcxR2UbqcVVN3H0Ad07rtnSj92Esm5DprAyORTzdcYi9+hOm3LMR8c1De
 fVRdtbEhonJYz9p/FOHyL8WzjgfVm3Ig+f7HHAEk0eqLsP362aNJO8d6tqGKo7iZgcWe
 Pb4dsN+CxH01B7yge+4NTYFYImsn15DDQbwglNu0LRvzM3S9OMZ+/fiaFq3UrOYbTDbA
 PI5s0suaKHmoXl3U+FoKmapXh58iyiGC+ivrKTpAZa+ChYyey0SaeCgBEbL1JHv/ksO5
 iAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532812; x=1757137612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HuwdkVAoFOF4p8jzvARF3HMw2ObDHUzQ6j1si9mXITU=;
 b=E9MzIqIbKJ/qO7qjRvHpa5/bgGsKQyW1bSDN0PdwBLhHD4/iw2awZhs948tkQM9Gh1
 gS01CEMbt9obnFv+v8+iLf55Hw5DES5UdF9LhHmxQnAQmFpgmuHmAjj05pA4BJ7777aA
 DpyT1t8SkP+Cb8YQ/tjm4tSEW3/bboapVspL8l1SCAXHEe71IS6tHYCwXid3J/WmbAhj
 x8fbAbGjttQHnBslIAclTZaAAhpMHmI7cEZTFq1oj4egG/E4cIA7GGEhRlIXON32R0QM
 k5eBwg7/DvXSFAZq7MW5ow1HiGlAfZAlzgJM5jZxpS6FVDothNjEWDYPFG4nC13kdS+5
 kC3w==
X-Gm-Message-State: AOJu0YzKHAQyzAiFKbqaq3nJxrzKBQGEQg2r4oCDD90eUXzGnSkE9d0o
 n2NpO/eh07ZrakniDSyF8m7Jhw2nx5eE54iGb/pmh3mHLZb79ERlbkvdmyMYhYXnPFRy0EcsZ4H
 TnjCrNWQ=
X-Gm-Gg: ASbGncsM7H+dTDVlWEtsHC2Li+Y+iHxn1e4tONK3LRD4AWhFUN8ShOr2VK2tnX4V0iR
 xe2vGvGoCIUzqVBqm6KkPUc347dNWZtrArNWYGyvUrL4jLq72CHQvxCzQboGdPIzTg7W524zX8D
 nzp2/AJv4yYX2LMeZrotFFkTRWp7GGluUA8JwTQFQPkmrAN5jG14z6BK1iW2yELJfnzDHuPlDjo
 N+pJECY1S8Vzoch5gHLqr6XrahXjxQ8295EorveZDc3zEoRNwgOOZ983ZHPsGkNu9TX+92U/Pc1
 AdqXkdSzDH4nkgIPaMsiCtB377BbNopb94VdSQyF9yWZjbHE+FY89cyvVVVJity1BnX3zW3FD/5
 Qy+w9kt57AsxqFihkwQnsKYDSA8ZwjpOcdHG1y0Kumc8cyfWhBQj2YGAW+c5MWuc=
X-Google-Smtp-Source: AGHT+IFZPAYvcIzw5ieQI+B2fDaL6/E5mbmtcwUrNAOgjwZdU5IEp2ul7W0VYB4c6/PUVXt/RnrJDg==
X-Received: by 2002:a17:902:e88a:b0:249:17d2:ca04 with SMTP id
 d9443c01a7336-249448f2c1cmr13569215ad.23.1756532811973; 
 Fri, 29 Aug 2025 22:46:51 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 48/84] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Sat, 30 Aug 2025 15:40:52 +1000
Message-ID: <20250830054128.448363-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index 58696dcfaa..6568bca5f9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2908,6 +2908,9 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
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
index 37bedc3780..4139b0345f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10313,6 +10313,9 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
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


