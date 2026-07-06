Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC46C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggj0-000869-NK; Mon, 06 Jul 2026 06:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggix-0007wQ-FO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:51 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggit-0003Zv-Cq
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so20663175e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334326; x=1783939126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f6BbcDDKx2H9TudLgPlsJB+75Qouq7sCxl4giWNaOBw=;
 b=eaxoOf06wxr58dt/EwVSM3m8wxdExfIB130gEsdY15rtKr4nQx69fpgpG8Dv2bd5FI
 CdmTGjxObSyKc1l56bWn1oX7wfVAPKBxZvO9mysFpCTG+1nxCWpq+rN+UQM7ane0fXmH
 OieeKEoMcWKcgAyNgKqfx3v7dwfciXubFJtRe0tWhYyLxG8phAvcO017vz0bPSTQeXB6
 P17z8bOPDTCWYcQ1dSShoO0ha8LvIxTkzcmqXI4XAckZgHM/nfyRkBh/djZD1NU0HlO9
 cKsbcqwkGVfF2k6R1cxJNY213FDdEaOZFin16Q2L+LRHzPLwDu1BbIAnPbKVhkckWSF0
 33kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334326; x=1783939126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f6BbcDDKx2H9TudLgPlsJB+75Qouq7sCxl4giWNaOBw=;
 b=IH4Eb3bUUU7abzyakkVMerLwyM2Hkkf7xPkKFsoGiE7XhXsuKOwlNZO9zskuBg27Tu
 l0pm9ukqChgh3wgXWozymJcYr9ZhnF4drjgLjWjEuRbKkfiLVlT1g6A7FGtS91ikMHI1
 zwTB/eZqS547J9gThoJzCu79h19tTIiOtAYsyXY32mEg6U4WLGtBrNuzMUpk2LJGTuVv
 2P1nXiP8RT5WOHC3VD+1TFA9b/tBx8lCf4S5MEXJrlDp5k05/N9XyEH6eI/iKg7fnma9
 8kB3N1iT0LF9OYsgMeFmdSQBwIQWbyQWi2i5QC8ttlZzMb2EXxv8luIXU3hS5rx/GFRE
 onkQ==
X-Gm-Message-State: AOJu0Yzrjm81iWXXQl60yGhoMeQEh+dfhHMGH0yJDuYV9Z9qtbBcnzEU
 FVYt964PIzjCZKpTQCZ85nPvjMPrIcc9mD87fWoi95R2ASwFj01O+wdYPH4i5xYEicldPpUzIMP
 +3GGi2BtvNw==
X-Gm-Gg: AfdE7cmwrw/zHEsucOq9dfzY/D15X8nd8c187hkLOFNH/+jEpVFnERQcQkgs5x492YP
 s1/ZJLP+bYZUsO6gWLCkY847iYTAwQZAUynFd0KoCOzWuIrasQqVPcTEV+AeZ/loCHFx/qi5wjr
 mAUYog9cHmtBdrEMPQc2MGK0vQxNaV/kVE7TfHmD79Cm1H7GuJmIYqFZrvgZYPNIRAQEpmqqvCC
 8o7LQWE0zqw7mdD0TqoS9JppZLahX60uOSL+gTfSSIZtB7gKp1/QyRKlLpTRhZyCHbvhFkowVzv
 +oE63Jr/TJrcpFAgiWXtAeDBu+ESXtBQC+IcUaZznv1nUf/e9gj490gkoCAJ2uiUdgFFVfv3Cv1
 HifJkD0p6HrGbaFaaZmrucmG+zsjXjqMinGrvXknXs6qGDxJXydrMUX+WZnFkea7zPFwOBYxyMO
 apTxn/YN+bAvhiaQZl+AK0wq714j4WmgeAUUFOTbb7VK+0PqlcRUsdcE2ggcS/8hLydwkGP3ekf
 s6YG4OO0paNfFgiaQH7Vg==
X-Received: by 2002:a05:600c:620e:b0:493:a893:1200 with SMTP id
 5b1f17b1804b1-493d2c2fbc4mr104734635e9.5.1783334325861; 
 Mon, 06 Jul 2026 03:38:45 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/49] target/arm: Define fields for NSACR
Date: Mon,  6 Jul 2026 11:37:52 +0100
Message-ID: <20260706103752.320511-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Currently we handle cp15.nsacr with raw bit numbers in the few places
we need to work with it.  We're about to add some more uses of this
field, so define its fields with the FIELD macro and use the macros
in the places that were previously using bit numbers.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702184019.3431139-5-peter.maydell@linaro.org
---
 target/arm/cpu.c       |  2 +-
 target/arm/helper.c    | 10 +++++-----
 target/arm/internals.h |  8 ++++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 62335b8294..787e4dc7ab 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -779,7 +779,7 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
         /* Put CPU into non-secure state */
         env->cp15.scr_el3 |= SCR_NS;
         /* Set NSACR.{CP11,CP10} so NS can access the FPU */
-        env->cp15.nsacr |= 3 << 10;
+        env->cp15.nsacr |= R_NSACR_CP10_MASK | R_NSACR_CP11_MASK;
     }
 
     if (have_el2 && target_el < 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 93e3d8b575..af45234ad2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -590,7 +590,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
         value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
     }
@@ -607,7 +607,7 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t value = env->cp15.cpacr_el1;
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
     }
     return value;
@@ -4105,7 +4105,7 @@ static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         uint64_t mask = R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
         value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
     }
@@ -4121,7 +4121,7 @@ static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t value = env->cp15.cptr_el[2];
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         value |= R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
     }
     return value;
@@ -10075,7 +10075,7 @@ int fp_exception_el(CPUARMState *env, int cur_el)
      */
     if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
          cur_el <= 2 && !arm_is_secure_below_el3(env))) {
-        if (!extract32(env->cp15.nsacr, 10, 1)) {
+        if (!FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
             /* FP insns act as UNDEF */
             return cur_el == 2 ? 2 : 1;
         }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fcce3804f3..a50290383d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -135,6 +135,14 @@ FIELD(CPACR_EL1, FPEN, 20, 2)
 FIELD(CPACR_EL1, SMEN, 24, 2)
 FIELD(CPACR_EL1, TTA, 28, 1)   /* matches CPACR.TRCDIS */
 
+/* Bit definitions for NSACR (AArch32 only) */
+FIELD(NSACR, CP10, 10, 1)
+FIELD(NSACR, CP11, 11, 1)
+FIELD(NSACR, NSD32DIS, 14, 1)  /* v7; RES0 in v8 */
+FIELD(NSACR, NSASEDIS, 15, 1)
+FIELD(NSACR, RFR, 19, 1)       /* v7; RES0 in v8 */
+FIELD(NSACR, NSTRCDIS, 20, 1)
+
 /* Bit definitions for HCPTR (AArch32 only) */
 FIELD(HCPTR, TCP10, 10, 1)
 FIELD(HCPTR, TCP11, 11, 1)
-- 
2.43.0


