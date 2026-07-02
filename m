Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4AEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLI-0007Dl-SX; Thu, 02 Jul 2026 14:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMLA-00078p-6H
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:50 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfMKo-0005LU-6Q
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47248615e4dso2169278f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783017625; x=1783622425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YFqJvpFQHOGI/dLuR6HhX7nMZqellpP4I0RPKcZ6D1k=;
 b=KAyaI72+OYWHxrZJG1T2Dpj+MzLzqmRBRGV+gWYlN94liHZ1ihH6lYi4G3v7gphyFY
 9ZHVOmx9bb8ZwpFQvA1HB32obp+BSspNsshDPqx/TUH3bLjsx7g9q16jmjK4tm/Yr5H3
 QsWvntXdCaB+m4lfMneP2TIE24NnDhJENRH7S5Q4vp3yNVywrq5yCJSyavETiMqtMK+J
 KRfITfMyOgNzCkj+yeHfQ9XVPeyhtU7hNIX7HKvWNvzurV4aWvnGG6MQ1jML27kCFlFE
 oHAr4t8usb+sLFwRqJtWB3SCR/NALnH0youbIMyALhH45f3Ys/6wK43G50aw7vYEb8hE
 5KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017625; x=1783622425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YFqJvpFQHOGI/dLuR6HhX7nMZqellpP4I0RPKcZ6D1k=;
 b=jIbhjg7cXyie5uU841/BIfxll95Cdxn8N9rJyaKWIiRgvYhvHJzE7+sEPqLyS/J9mk
 jfX9Scw425P0mSYOl6+HjAnFEYXfVCRt6CCatyZGRQK7pCMlWcR2nYPnPyKlkchL4u+K
 hScxKCfoUur2hOO9vPEVnxc7oaX0xthHbaKpia34axBVUBLi96o9/UuuraC1OoYyob+d
 uq+gzwwGuy4YS246eMoqn8FNeg9uzGLYugKJk9DLazBzidj45n22N04tsy73qOhRgO2+
 oWt5LCZ90Qesx3A1KyQtsvUZgtBnpIL+SAl10k0do51GjzrDA661cARL+pdsp/So8XU/
 eIsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uYlMV0DT28ZVeToSBwiyRTIl1JadHMMJ/lwfOaaLCocqspSFrEPJiuYv+zYnr90saefj/5fjV6pLH@nongnu.org
X-Gm-Message-State: AOJu0YxzEiHkGaKRUYo6c6XuQ054dsHUQjGc4L/6/xfVPbYlwUVPMfiQ
 eiEVqiCklXyrGRmiZsAgU9q7AkIfrop298xVdWwteIVyL0zZSozs6TIH1nreGR0cYEo=
X-Gm-Gg: AfdE7cnBTS9uHUe3aKKBLlGsLHGJXSM0DtdckKNXKjbvv/L2d43ZBg9fU6hWNXksvne
 fUZX2TpEjHD4uZpNS8VuWSoY821rQKMuRdVopMtH9XvxowizOCQCDmteH4zUS10Ft1LacCBMcbU
 iltb7UuFDxn2p6bLh0PC2pxpFk8OsYR/ulgpf5zPOZDTA6o6gvxGn6X0o8XAg/ncUl9xKgqInY3
 Rcga3jJaD59h9ZnBtkHvpGBWs3Cn5Ps9oz1JLkkX+VVIUDPeO3M3Sk8hr6R56FqmSD43vkxNbPf
 zWrpt85UcOS0WtKIFj+UQkDm/S2Ci5RHPA1ZeT5x62N9Bi7TuvU0ccD1RJJXrU3lPe15P7fDmuC
 veGS4Sa959zFXqJ9JwROItvOUZCwe60V0h5V0Uy4LOgyZTy4B6THgenu9tZjkjzmMqLoDc5qO2k
 D+77b8W7Q3/OZaMEGyE6EV9hh+lPPbehUTXOT/uZ6OMOZZX+0FB5tD07RBmC2fdef0V6m+hIusE
 xrpwraLSoXVCrYBwR6Uf4pP9maHN9O0
X-Received: by 2002:a05:600c:6d14:b0:492:3763:aeb9 with SMTP id
 5b1f17b1804b1-493c2b7cb1cmr79691755e9.21.1783017624667; 
 Thu, 02 Jul 2026 11:40:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a4a09sm11628213f8f.13.2026.07.02.11.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 04/11] target/arm: Define fields for NSACR
Date: Thu,  2 Jul 2026 19:40:12 +0100
Message-ID: <20260702184019.3431139-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702184019.3431139-1-peter.maydell@linaro.org>
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
---
 target/arm/cpu.c       |  2 +-
 target/arm/helper.c    | 10 +++++-----
 target/arm/internals.h |  8 ++++++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 86aae36ae5..35360d0c0e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -777,7 +777,7 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
         /* Put CPU into non-secure state */
         env->cp15.scr_el3 |= SCR_NS;
         /* Set NSACR.{CP11,CP10} so NS can access the FPU */
-        env->cp15.nsacr |= 3 << 10;
+        env->cp15.nsacr |= R_NSACR_CP10_MASK | R_NSACR_CP11_MASK;
     }
 
     if (have_el2 && target_el < 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a234aa031c..af98bda3f5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -587,7 +587,7 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         mask = R_CPACR_CP11_MASK | R_CPACR_CP10_MASK;
         value = (value & ~mask) | (env->cp15.cpacr_el1 & mask);
     }
@@ -604,7 +604,7 @@ static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t value = env->cp15.cpacr_el1;
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         value = ~(R_CPACR_CP11_MASK | R_CPACR_CP10_MASK);
     }
     return value;
@@ -4082,7 +4082,7 @@ static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
      */
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         uint64_t mask = R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
         value = (value & ~mask) | (env->cp15.cptr_el[2] & mask);
     }
@@ -4098,7 +4098,7 @@ static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint64_t value = env->cp15.cptr_el[2];
 
     if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
-        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
+        !arm_is_secure(env) && !FIELD_EX32(env->cp15.nsacr, NSACR, CP10)) {
         value |= R_HCPTR_TCP11_MASK | R_HCPTR_TCP10_MASK;
     }
     return value;
@@ -10033,7 +10033,7 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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


