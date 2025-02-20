Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D953C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 16:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl9J4-0006p8-EI; Thu, 20 Feb 2025 11:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9J0-0006kr-PY
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl9Iy-0008C0-KE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 11:21:42 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43998deed24so11070475e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740068499; x=1740673299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OICoRsS+JpsWnLQTNlne2RHW3SM4MiTLocAzFfGQq2Y=;
 b=f/U12zd8FmrDKttlHrfy/TaEKvo6AVVgJtxqezkEijDZOtzDqWJ7PDegD7Bz2jPhDe
 wjRSkUqIR8JHmUMZeCNPYL9lkIUYlTmHp/G1v/eGYb+nzG5drsj8fWgONYptk5OHuAKf
 YPXFnjk273EeQCCqNFVrSKE6Kh0R6JLQdaWsmPS6E0Vkyu26HP6rWpKgNRA3fKL/vSCk
 fODUcgz72ozeR70POkLPf5nAzmqZ0vgWkNk8tsC0/HOSjhFkMc+OK9Oo2eBBSSGvlqX2
 ZNzdON7jf3I73gJh0Sv6FCbNrS9fuOGTDGROqxF48qR/ckcAcOVFkYr/p3O9C9k3nZzf
 2b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740068499; x=1740673299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OICoRsS+JpsWnLQTNlne2RHW3SM4MiTLocAzFfGQq2Y=;
 b=SgQ5Kip+GMBBz2kQCFwcHrx3mPwWDxlDhgpVi2mEhr6nG9m1xXUT8OmmXCmyNQTHMm
 8PeJBbG5LYwAkuv9VLHzUgxInR+t61WhWeu+/76gU4azg3ELx0qpM9s2N2lPzmrohnAS
 WLgyWPgr6FUOyj9HU+sCpajBHQBXAXphTzbF+KylZZuEXuI3ooiKfowKJA/F0egPmg65
 QhlGgBoT1QHX/xJh23m3ek7IzX6rn7kTnSMMWkRVgcBcNybey0Zl6wlAsQZbGc05BOxl
 RFmUodYKCqpng9IPgqzp4h6d9e4CIWiZTXG/wspEMRMekgSWURjYy0QQqH8HFDwo85Rd
 bs/A==
X-Gm-Message-State: AOJu0YyZZfOqEKYa/ob8ijKnaTKevVV8Y93NGiWukaPVLwAVjnpsRt4s
 cASjVagnovh9TY+F09fxFlAnDu0B+gVD+ULjfv2dCb82MBiJ0NhrIoo9/79U+2Bgyt2wzLnHfBT
 4
X-Gm-Gg: ASbGncuTOhlny0FXMpqiOYoFM2P+GsZrBw7FAZKzoolitwMp0ZV2LoACr0CLTu4xWg4
 vqD64QjzMf1axEzXyAwllt9+OrJJZ5LieYpUcv8dm7kJLc4dpnkwpU4+vuS9VqqYow9V9tq8fxg
 kVmhrIfukcvbBoq5KF9moZHA3Lc9zdVYCEKdovKoNtTzWKGMtzI5+8HsAOmzQBhLisaYV5aQ7Q5
 r98/TOARthJMEiGlTksShKElLpuSliikADPD10B0PGnRdPiEYR94VU0nqa6t2Ig6oscTg0VRage
 nAC/NBWfqbLY2aBGvOBM0w==
X-Google-Smtp-Source: AGHT+IFGN+IMBmNC5VRsmKuqGbd4sMvxTS8Z2+dE60gd5v+RyMFvXbbFHyo+tLJ7JFQilcWJE3Ivyw==
X-Received: by 2002:a05:600c:1e11:b0:439:86fb:7326 with SMTP id
 5b1f17b1804b1-43986fb7498mr141172845e9.22.1740068499167; 
 Thu, 20 Feb 2025 08:21:39 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399d55fc1asm48806415e9.35.2025.02.20.08.21.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:21:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] target/arm: Use CP_ACCESS_TRAP_EL1 for traps that are
 always to EL1
Date: Thu, 20 Feb 2025 16:20:51 +0000
Message-ID: <20250220162123.626941-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220162123.626941-1-peter.maydell@linaro.org>
References: <20250220162123.626941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-11-peter.maydell@linaro.org
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
index 535870f69a6..aacb53d31a2 100644
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
2.43.0


