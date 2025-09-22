Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FEECAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0ldh-0006nA-0E; Mon, 22 Sep 2025 14:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lcJ-0005IH-PK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:31 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc1-0004SE-Sq
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7761b83fd01so4390937b3a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567008; x=1759171808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ROsdZXnuVlBnAHIkqUiLa3UAcOkiroUyijSvpIgKCW8=;
 b=YqCHjY/IyF8tidCZ4J8N2yIENUAFcwStOsXmjKBBTUStI8SgbeDAdJ/FMg4PCnwPT4
 RP//63SKBZfGKJD0/8322dZvZo/ZD8IS4VpdpiRvftEQWyUtJrbKddyKexRz6ICkwP1R
 eylbJHK9MeW7xw/wYqLzz3dKm032szZs4GbjeQb/dRnIvPC1I/FvJ4/95uFrHk93axPF
 KDSMdvxRfM/sH6ihFoSSvOk0f59U3LDErq19uaR0aMz2UTiARWd6qGLIkIiJ6m9biUoF
 eAgkWXDK3cwVqMx/kHxxZyZRU4CfF9KWT+o/wFUXDKbBj+Z+U7d8o5Vl5Kir7NByIIe/
 E8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567008; x=1759171808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROsdZXnuVlBnAHIkqUiLa3UAcOkiroUyijSvpIgKCW8=;
 b=iRQD06So/68R2mA6+XpUFuHTkYU+m+UmQBEQk4gXv7nKLKfHfBL3Pr8YJ8CMrKDXHE
 u3MShYR/iXZJBGZs5VgYKZA9hZU9V6UEDAyPytQIuW9zw71yrcOJlJpfEOf8cwpooGpP
 jE+nPXz/1dKCiyNaMSzlzdW4a01w09m1qzHveDB351iu6oqwd6GqqckGasBu2Sce6znk
 KpMYJUhs8QD4c0JOmLUTzt2xiWv9PokVvusZ5qD0QcmAifZW6utx5Lgcul1GB1DmryLk
 Sdhil1nzq22NnNCe9Bfq9U68glIW4amBHnw+L5/HSNoyfcvp7dd3sqeLjtDx0WSt7krH
 +wyQ==
X-Gm-Message-State: AOJu0YyKI9wvnbdhsh2JHXAaflaHdw+F4nZezhi9HYMeSsodF2eSI6IM
 m+4Q2QC9zQnAl7BQqU6rqyAc0J3A6CWg5wg8WPf5AdC7wAdzTUwfGGAqerwiR/XqS2D7qXp/EW4
 OaqtU
X-Gm-Gg: ASbGncux1EHdTl0K6cAsh75LA7QyRTai5/H0m853f7jUxSoqzIQTo966wruwHUQEjVZ
 A/aQrd7MmJNKnaSd0iEIyNAFMr5RsxVXhaejRNicJc+2voIzuPVxwZDyoDBd9mNCaYztNilP0PU
 q5se335zGqTtrh2SSnOc3XLF24qaEocUvnC3GHSONceIYTKn8Ux9nPiKMxql3AjBv739n2ESPAP
 PBPbvWQjRgwqGaaSMJR9G4lTGl72E+npC5A5YuoTXUy6/Q19iOfww/ZpgqJCkox1IWLjOTP2UWE
 80S9rkhTcglNR6JdMQlPN1lmFkwpRVGxlkwdsUXCxTl0SiwPrveEcDuHk6URuQDf894jwSo/jeA
 MDBiyTROhJf5JxKuJhp1yBCBlGyD0DTGqoDA6pv8=
X-Google-Smtp-Source: AGHT+IGps36nUI7xj837toxZMFQ22H6m9MglXwz75LX7CO/MaMYihYeURnwAe73udOhf8cLSygJyBA==
X-Received: by 2002:a05:6a20:748f:b0:243:c6d1:7770 with SMTP id
 adf61e73a8af0-2cfece8b624mr113058637.43.1758567008183; 
 Mon, 22 Sep 2025 11:50:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:50:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 35/76] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Mon, 22 Sep 2025 11:48:43 -0700
Message-ID: <20250922184924.2754205-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 14a08d2f99..6a214557ac 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2879,6 +2879,9 @@ FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
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
index 6728e362b6..d5c41fbb3a 100644
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


