Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF29C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCW-000434-Ju; Thu, 30 Jan 2025 13:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCI-0003tw-LC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:30 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCF-0000X5-SJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:26 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso8568725e9.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261402; x=1738866202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CkHxBykkh+MkSMFpl2gMe093xK0SZ26idFhO7kRCAU=;
 b=NjIReg6bioSEKiNfHY+RDlSS6S3o6YdBfcUE2tVLvQcjed0Yw3IDQ3vaOGStnzLGRB
 vbpueu7j0FTwkNas8rHC5fnctrbqbohrKQpbB2BYyJ9D6tSJzjSPU0Kai9ODeZq5+zlF
 l/d0/1WLuyys0j13Nd8OO4aofSe0/IiExxMLG3cJogvtkvFYH9Rj3VOB8VthyFk2Vxrx
 do0RDAOreuytzvIwPcMkiV8gU1p528+OYAjDMKUWypOJFhKusMapgvPoILB0hrQx401d
 bM3qn1VAfcEyzhuuMT1S7jEvSwdFPaTLIj3U82UpEbvfvEALAXYjyQ3aU+hPZZo8P976
 HzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261402; x=1738866202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CkHxBykkh+MkSMFpl2gMe093xK0SZ26idFhO7kRCAU=;
 b=BngZomyeZekgT8aDiecV4FtUaG4LGHV8iIjjj5IxwJRbXZ7jcWisL0qdPchXbGjv0B
 dZ9g2VxjRKKSfv/D58w7FOraZHOvZpbtyArOVCVMWwshGLfZkT7s5F2BkGCrJwoIP6jM
 SEIK1NKZZpcTFStiEnAtFu9KZyCCmwOdZWe93O17FbcjuGlfXv1QiQyGJpnRHG+YgRN5
 lwIROjLwHSpSyxi/NXIJBzxnTOoIuMjbhH4nirQy1Hz7BAYvady+sSvQRRqeJdHGv7Oh
 Imd+FQ0IyZDKreAi7+vTAhu/SzGBFL1F+kiwzIPrfozCBOBbdryzIuvr45u5tFRs6Cby
 Flmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnf8+yD+nsnQFTXiDmgCMaJqudsiyvQ1sq+7BxijCI/epVQzERR9MaDSbKvPsPhXwuUXq0kxDALIkv@nongnu.org
X-Gm-Message-State: AOJu0YwMXK46lodgI3Wjv2dTU0CEs0elWQgb5nvTi7ElkHHeEogLpWgL
 TL6eQvUQ8gAh5UqQcKYCvkZHu3OZqixidv+IvAYoVipsA0R8Q6+3WL5gd3nRnYY=
X-Gm-Gg: ASbGnctj+8OX/pcBMSHmwfHp0d7C51xp4He6sWjA0iVLXDxzRrCOv7QauCjcPnn5u3W
 ZA81eicOb7+ZSYx6vwjB9dkHO10zBW0JPr9mkxmEd2pfsR0al92FJJK8/bwrzpko3idwfHzs8yM
 DyqBOGZwYrqHmVvo/mgpTess6w28qRDr1PJgey3JEIhKr9yZfbwBL6SHNz9H1Wjf8KopZnWPGoa
 OZwrlZHDOSEOgL4tRTjFDaPX5ZzvaDKn354jewgAXy/ubUxHXEm9dVBw8pTKFZBUHkq65GlJaRC
 O/8tyDL3hkiLUw73CWh+Aw==
X-Google-Smtp-Source: AGHT+IEJ2ODNjHam3bz1ESlW1/hTzD8Wq66vV2VuMFkU5yxxcDllToWcDqGGfaoFfFhi5PcQTZHSpg==
X-Received: by 2002:a05:600c:3155:b0:434:a5bc:70fc with SMTP id
 5b1f17b1804b1-438dc3ae116mr78395615e9.8.1738261401931; 
 Thu, 30 Jan 2025 10:23:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 10/14] target/arm: Use CP_ACCESS_TRAP_EL1 for traps that are
 always to EL1
Date: Thu, 30 Jan 2025 18:23:05 +0000
Message-Id: <20250130182309.717346-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

We currently use CP_ACCESS_TRAP in a number of access functions where
we know we're currently at EL0; in this case the "usual target EL"
is EL1, so CP_ACCESS_TRAP and CP_ACCESS_TRAP_EL1 behave the same.
Use CP_ACCESS_TRAP_EL1 to more closely match the pseudocode for
this sort of check.

Note that in the case of the access functions foc cacheop to
PoC or PoU, the code was correct but the comment was wrong:
SCTLR_EL1.UCI traps for DC CVAC, DC CIVAC, DC CVAP, DC CVADP,
DC CVAU and IC IVAU should be system access traps, not UNDEFs.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c |  2 +-
 target/arm/helper.c       | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index c3c1eb5f628..36bffde74e9 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -875,7 +875,7 @@ static CPAccessResult access_tdcc(CPUARMState *env, const ARMCPRegInfo *ri,
                                           (env->cp15.mdcr_el3 & MDCR_TDCC);
 
     if (el < 1 && mdscr_el1_tdcc) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_EL1;
     }
     if (el < 2 && (mdcr_el2_tda || mdcr_el2_tdcc)) {
         return CP_ACCESS_TRAP_EL2;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 058a5af3aaf..d1e26ec9d06 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -881,7 +881,7 @@ static CPAccessResult pmreg_access(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t mdcr_el2 = arm_mdcr_el2_eff(env);
 
     if (el == 0 && !(env->cp15.c9_pmuserenr & 1)) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_EL1;
     }
     if (el < 2 && (mdcr_el2 & MDCR_TPM)) {
         return CP_ACCESS_TRAP_EL2;
@@ -2159,7 +2159,7 @@ static CPAccessResult teehbr_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                     bool isread)
 {
     if (arm_current_el(env) == 0 && (env->teecr & 1)) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_EL1;
     }
     return teecr_access(env, ri, isread);
 }
@@ -2239,7 +2239,7 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
             cntkctl = env->cp15.c14_cntkctl;
         }
         if (!extract32(cntkctl, 0, 2)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
         break;
     case 1:
@@ -2278,7 +2278,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
 
         /* CNT[PV]CT: not visible from PL0 if EL0[PV]CTEN is zero */
         if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
         /* fall through */
     case 1:
@@ -2319,7 +2319,7 @@ static CPAccessResult gt_timer_access(CPUARMState *env, int timeridx,
          * EL0 if EL0[PV]TEN is zero.
          */
         if (!extract32(env->cp15.c14_cntkctl, 9 - timeridx, 1)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
         /* fall through */
 
@@ -4499,7 +4499,7 @@ static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
     if (arm_current_el(env) == 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_EL1;
     }
     return CP_ACCESS_OK;
 }
@@ -4589,9 +4589,9 @@ static CPAccessResult aa64_cacheop_poc_access(CPUARMState *env,
     /* Cache invalidate/clean to Point of Coherency or Persistence...  */
     switch (arm_current_el(env)) {
     case 0:
-        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
+        /* ... EL0 must trap to EL1 unless SCTLR_EL1.UCI is set.  */
         if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
         /* fall through */
     case 1:
@@ -4609,9 +4609,9 @@ static CPAccessResult do_cacheop_pou_access(CPUARMState *env, uint64_t hcrflags)
     /* Cache invalidate/clean to Point of Unification... */
     switch (arm_current_el(env)) {
     case 0:
-        /* ... EL0 must UNDEF unless SCTLR_EL1.UCI is set.  */
+        /* ... EL0 must trap to EL1 unless SCTLR_EL1.UCI is set.  */
         if (!(arm_sctlr(env, 0) & SCTLR_UCI)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
         /* fall through */
     case 1:
@@ -4651,7 +4651,7 @@ static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
                 }
             } else {
                 if (!(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
-                    return CP_ACCESS_TRAP;
+                    return CP_ACCESS_TRAP_EL1;
                 }
                 if (hcr & HCR_TDZ) {
                     return CP_ACCESS_TRAP_EL2;
@@ -6073,7 +6073,7 @@ static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
                 }
             } else {
                 if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
-                    return CP_ACCESS_TRAP;
+                    return CP_ACCESS_TRAP_EL1;
                 }
                 if (hcr & HCR_TID2) {
                     return CP_ACCESS_TRAP_EL2;
@@ -6372,7 +6372,7 @@ static CPAccessResult access_tpidr2(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el == 0) {
         uint64_t sctlr = arm_sctlr(env, el);
         if (!(sctlr & SCTLR_EnTP2)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
     }
     /* TODO: FEAT_FGT */
@@ -7172,7 +7172,7 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
             if (hcr & HCR_TGE) {
                 return CP_ACCESS_TRAP_EL2;
             }
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
     } else if (el < 2 && (env->cp15.sctlr_el[2] & SCTLR_TSCXT)) {
         return CP_ACCESS_TRAP_EL2;
@@ -7292,7 +7292,7 @@ static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
     if (el == 0) {
         uint64_t sctlr = arm_sctlr(env, el);
         if (!(sctlr & SCTLR_EnRCTX)) {
-            return CP_ACCESS_TRAP;
+            return CP_ACCESS_TRAP_EL1;
         }
     } else if (el == 1) {
         uint64_t hcr = arm_hcr_el2_eff(env);
-- 
2.34.1


