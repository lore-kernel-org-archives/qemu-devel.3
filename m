Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7524C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLpR-0008H0-Lh; Sat, 02 Aug 2025 19:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmZ-0003CT-SK
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:02 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLmY-0005lb-0J
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:36:55 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30b79c7c918so94045fac.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177813; x=1754782613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9sc0ZUHCkfd2ykNLWaRo5wL6kxQj6o6jh7+7rjjEiA=;
 b=PsGb57sAvmUpp7566bDDQkCvcmi4Ba58Y6ENpMLZZi4+gtfHtJJ/sAyns0Fx8sMKkU
 SkrMa+67PAbxgOVukXv5ge4G+QsjpYYNcWOvUn9OU5ycya7aU5YO75dWkAGYSKW7BDpG
 hC+tMykWRZ+AMAkduADg83hz2d9UB4GEBV3uxa/tdGUL7qCS8k/8agAT1NNISi+gFoy8
 5lu7wFxXBtsCvgMb6JFjlNAlw1d8HZ4Tvvtwf9JBcu9GdLa8IQFTGOOMnPBsd3CYHIck
 2YtULaItXYMC5WgaHqZYTFg4QOzhFcYVJqpe2NI2MBqVklXyuMsb3mCnTaXHvzJFMQbb
 AMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177813; x=1754782613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9sc0ZUHCkfd2ykNLWaRo5wL6kxQj6o6jh7+7rjjEiA=;
 b=nJEBsHz4d/Yrvz3aFQCvSjGXPCEZzP3Un9Oab5LSNiSLL+IFSM51txdQGU+xLQ17Zd
 l6VmAL1VqzPMYV1XBFdVmAJlcx4/i+nr4KCJW989YnD2IZKFmgCemzApsZ8Am5SSLgH6
 Of8GMVHajSz1DSPR8lFKlMK69GW+vXp4IXOEH5DH0XJCIcYqOjnuzQIq7ZyLwINMI9rB
 ZQTHDUxy11piONIz/cFVuTgd4CjzYIFxKw1l0uCXCzZikRsF/XhejBtvE2DiroVDEFN9
 nlISXyVaYTJV16YgTLhfzcUXFi5hII+u1qbrSRa3w/N2KwrWhh6VPWH0Zfd1lk88mJ6b
 z5pA==
X-Gm-Message-State: AOJu0YyrPkqwKnsJ77paHZ6IhlPu6PlNaTg0RJ250rzyTiVf7liw2P/x
 ObCx5A59iH6ubMgXdzBY5LXQlguo7k4Wo8AHoovTtDZfzWrM2cnNEA1x6pkWPEjrjdyRbweByTV
 HdmINODw=
X-Gm-Gg: ASbGncuSwTwSPQ88RhxWPKD5/uBT8kkP14vuAzJEZo3lrpp9AyWqYol5gy4lDpgzFWP
 do0moXZvOoO6LOK5nuq8W38hTJUQxm2fHoWcMsIv09/ZU0GzUQXg0IGZJ2BiBI1tw/EjpLNj1ed
 sjbocD4G2PBFxCNqS1Pr2SB/+sJL3YqtgniRTQ/TksHdfxnMFY8Axph2Q8l5iDAkLiwPadS58Sv
 grenHazxET2Biw9i459IuzErShYlr/LSFO94FIjndMv/h4o+QWVmQDlZwxOxk1zAj6ajUaMIrj+
 83qT8bkHTLZqGHBpPFdRVdkvMOjWbxa9z0OWohXeJaip35HpLjM71EttbRE0i3cI0KFKgX9jX4k
 o23CC8vweSVZm/BpRbXPuS/PmYRA1dvmR/Wrt2VusgEs31AVC9NDu
X-Google-Smtp-Source: AGHT+IHPPtSoPCdMabycVwcngJY5dpHgLs3nkTKarm5M0N/WEvcIcnSd667BBvldygEpobuhIL+gxw==
X-Received: by 2002:a05:6871:e028:b0:2f5:2b87:416a with SMTP id
 586e51a60fabf-30b679b8735mr2341907fac.37.1754177812811; 
 Sat, 02 Aug 2025 16:36:52 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:36:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 48/85] target/arm: Add GCS enable and trap levels to
 DisasContext
Date: Sun,  3 Aug 2025 09:29:16 +1000
Message-ID: <20250802232953.413294-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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


