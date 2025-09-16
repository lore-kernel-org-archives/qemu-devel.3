Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB27CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWat-0006O4-EY; Tue, 16 Sep 2025 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaW-0005uF-MO
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:20 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaP-0008Nw-Gf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b523af71683so4503486a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032584; x=1758637384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RcKPQdIEUX2PNEvjBDHi7h42HjJJAKk2WkX9D2rphHM=;
 b=E5E8W5/c3j7UslqPrnDMYfZmy16egOP+0qJv1wYTfgPoQGXzIfHIELp0XmGC2yPfcn
 0JkOuoJsqclFHcO6+OuSmfcwgzTW5Jps09HOSZVh1oGrCqq11jqbC+YtDJQa+4jrWiik
 4um3iR1yYYyO/UtJ380FF1yNCLJxtid1YM0meSTB9H8wySuG/Reen4PZmn8TcZ2p6pqL
 5ylbl7KWojrXIE938s/xb6bcghrycrPXvvGgFrGbUjUMdgdvybh7UUB+TYGgapqomuqB
 uqVctEN+mSkUbHYlKg91gfuxSinM2akcuPSMgFv9qLpLyUx3i1Zzudkn7OonRRNB/YDK
 NNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032584; x=1758637384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RcKPQdIEUX2PNEvjBDHi7h42HjJJAKk2WkX9D2rphHM=;
 b=kM8m6zLFwBIRTc/VpH1fzctsorBGEzSAf47BRcgF0COlnCpz96zb/vivdNIvTusuDV
 Z7ztxjsY5NzZ8OYGY54ZSLTf7XuhSM2YrdRREELhjijr8ly2hM4Kbd4fjPi/kwx3bBeo
 RLGE467Awv1iKWQUSKNDbC+Q2hqJVgr4QHnrH3WB0Ek+3CdSdXOsqyqwIcekOjkZIuNm
 5o1Fod7AR/ubesCvl4Sw7LCqfthTn2ks/mQcFQGb5f92xdQ/RbiqKb0x+Z1GuWlis0r0
 UXz8ylIpBYiEKG08F1KbqkO/MICZ7OUj7LVn9dckdcstkq9O88WcUPLEdUWwjnzMusys
 JFwQ==
X-Gm-Message-State: AOJu0YyirI9WrZ3at9ClDgUdSqEQKX+rZnK+NQsSkTMOf3iQA/z9boLO
 c584GVRW27iUCBPcS3c/VbC92fbTePNnkvlh3kn8N9CzTIQK+hVaesDTPlwNMzp6ISYkvi94w06
 UGztx
X-Gm-Gg: ASbGncs2EiLrVM08hBoBVG2N5aiMjb4Rn2UAMDpWchUOAVlX+vhTA57813Q+8IrokGQ
 NEEAvyS2QIYDS3v4jXd5IbKbGov8ZjFf9K2tL6/Zsv19gUgLaGFOqKKMOtBEtA/tjJVQn6DyPvV
 lnEgudWerSDpMyJOj7AAMcnPz6MJ1/4p4YJjJIhRGubGcyCIS5kKqY4ikDxV6yB7CLYFBNh4BQ6
 LWyBxCE/BwS/I1/Em3hSWze3DsiTgYVT+mUhZ201itgy9JoeBdukiBu7MAnsFoyvMM2u2IUDARC
 JZ5N6bs6Wc7OUXEJT2xgZnQGq8I44WibfTraSroRtlKYIzmuw+WG8I0zEgebvwJecZ6GmRFNUlC
 TT0R4Z5Z8FYz44ABQklbgvDQUkUHP
X-Google-Smtp-Source: AGHT+IHPi07hSEXRpiQX7L/EwHSH6nE2jPErGxU+iCmuzG2fhrGJMUWHHW4loXXBPZbIHisIvgOeLg==
X-Received: by 2002:a17:903:944:b0:267:16ec:390 with SMTP id
 d9443c01a7336-26716ec061emr102254585ad.17.1758032584447; 
 Tue, 16 Sep 2025 07:23:04 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 31/36] target/arm: Rename TBFLAG_A64_NV2_MEM_E20 with *_E2H
Date: Tue, 16 Sep 2025 07:22:32 -0700
Message-ID: <20250916142238.664316-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Install e2h in tbflags and compute nv2_mem_e20 from
that in aarch64_tr_init_disas_context.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 3 +--
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 8 +++++---
 target/arm/tcg/translate-a64.c | 3 ++-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c15d79a106..4a22b216b3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3093,8 +3093,7 @@ FIELD(TBFLAG_A64, ATA0, 31, 1)
 FIELD(TBFLAG_A64, NV, 32, 1)
 FIELD(TBFLAG_A64, NV1, 33, 1)
 FIELD(TBFLAG_A64, NV2, 34, 1)
-/* Set if FEAT_NV2 RAM accesses use the EL2&0 translation regime */
-FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
+FIELD(TBFLAG_A64, E2H, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f974996f3f..cd67c0ed07 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -150,6 +150,8 @@ typedef struct DisasContext {
     bool trap_eret;
     /* True if FEAT_LSE2 SCTLR_ELx.nAA is set */
     bool naa;
+    /* True if HCR_EL2.E2H is set */
+    bool e2h;
     /* True if FEAT_NV HCR_EL2.NV is enabled */
     bool nv;
     /* True if NV enabled and HCR_EL2.NV1 is set */
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index 59ab526375..6969d41ea0 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -258,6 +258,11 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     DP_TBFLAG_A64(flags, TBII, tbii);
     DP_TBFLAG_A64(flags, TBID, tbid);
 
+    /* E2H is used by both VHE and NV2. */
+    if (hcr & HCR_E2H) {
+        DP_TBFLAG_A64(flags, E2H, 1);
+    }
+
     if (cpu_isar_feature(aa64_sve, env_archcpu(env))) {
         int sve_el = sve_exception_el(env, el);
 
@@ -390,9 +395,6 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         }
         if (hcr & HCR_NV2) {
             DP_TBFLAG_A64(flags, NV2, 1);
-            if (hcr & HCR_E2H) {
-                DP_TBFLAG_A64(flags, NV2_MEM_E20, 1);
-            }
             if (env->cp15.sctlr_el[2] & SCTLR_EE) {
                 DP_TBFLAG_A64(flags, NV2_MEM_BE, 1);
             }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0ec309f1ea..599e7a36ee 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10304,10 +10304,11 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->pstate_za = EX_TBFLAG_A64(tb_flags, PSTATE_ZA);
     dc->sme_trap_nonstreaming = EX_TBFLAG_A64(tb_flags, SME_TRAP_NONSTREAMING);
     dc->naa = EX_TBFLAG_A64(tb_flags, NAA);
+    dc->e2h = EX_TBFLAG_A64(tb_flags, E2H);
     dc->nv = EX_TBFLAG_A64(tb_flags, NV);
     dc->nv1 = EX_TBFLAG_A64(tb_flags, NV1);
     dc->nv2 = EX_TBFLAG_A64(tb_flags, NV2);
-    dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
+    dc->nv2_mem_e20 = dc->nv2 && dc->e2h;
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
     dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
-- 
2.43.0


