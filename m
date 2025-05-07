Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A585EC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 16:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCi6k-0003yw-LM; Wed, 07 May 2025 12:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCi6h-0003yc-H3
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:58:56 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCi6f-0008C6-Rc
 for qemu-devel@nongnu.org; Wed, 07 May 2025 12:58:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5fbed53b421so67377a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 09:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746637130; x=1747241930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2QrzeBqfTjupWsGeaorzNfjBe9sOSt/y01h6JPPSi/M=;
 b=pHN1x0pJf9Yvc284PnxwAFhPUqG19Tuzv07y0gt3uRBwXxVjy/NAFtwkpyj8TSYrBr
 1mO7Z9kKsR2y26vEOmR9E/aj7sW3Mx6SVRoBVVHzOX3Gv6wDapkN4KiTsIhsIcVqLMcM
 ooO0jCXp4MlnYZXKwio3Wu/MLA/92dMRQJB6b+K7kQEpNJwG/wVMMzTYx/znCxpr+3+X
 2obepTUkTwCnoTCmimHmHMSUwtRNC2WIopJixih3cb0Sy/q7jqPAWqQeAjNWaLb8DR91
 IMLYJKgKG4Mms0bzCd1MTJRCzLAXuH1/1wShGlNONypPHaisori/lJGFo2Ptm52mNPLm
 vlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746637130; x=1747241930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QrzeBqfTjupWsGeaorzNfjBe9sOSt/y01h6JPPSi/M=;
 b=imNAbC0vn5yKBh4arDa1wKYd2e7c9206dYBjZnY64XWiddbd2y18kShPBDJcwHq1cq
 E2RWFjkUSDynoZT/m0Ps7vsy8tEGpKblDe3fH/GwiMwVktByEb0vcQEaKfEoQPSdra0U
 tJiWodNduhyx9ooEUcny7p0cuZEv4sHAY8Zdk+Hj1N8ncV1RkbMASvQNl0I7ok5OR4B1
 2HtIngpJnWeHgwdxU+Yuebb2naJgucV25PR0gpTIg6cjhsYgilqCiVOBH2dvf1f0L75U
 moeoLkMe8fRoG7+dRNtRx+OC7KCGG7nmJsu/LpOVC6v7N8yUjPCM2PAgdp7coH2WLzbE
 3j4w==
X-Gm-Message-State: AOJu0Yz4DFjxWhVmn9Nu/Vc0gibNHJkgND3zrop1UvNAIjjbqyhVGHnW
 g3iH3m5tsyLur3gnDPfiDSjsBmbTOOx/Ci48PsiVGNuSNj+P8zj4cGJn8uuHGhU=
X-Gm-Gg: ASbGnctlE73yU0f/2ZvIB8OgtflaY0Um4c+sWF8DtrHPTRF/UIc8mI1tOR+MhYcH5+Y
 cBb2VF0MF6rmo7+2vwFQMlirYrMsFRCEccB23ibnNAynymIBflyLEIX3/2PVXnbAnA6SUQR2VaZ
 CnM5PzreiSuZRBfp8agsODWdwb2BCiYglR9hLzPNr2dE8CuMBokdQWxkLETzR3F80WNxfLmNbI9
 o3PIE+RaC0MvfNhuDeOfp3z55hmy7mH0yI6OV8xa5FxhSwH++p1AY0UN8YS/cR9XtZoWcm//Hj2
 n3jiyHsRSMiSw3PAP899u/c7aXI94fWqnEpX8SLF6xE=
X-Google-Smtp-Source: AGHT+IEjwlDEel/UMA/0VRJvb9numA+npiWUK9YDRGd3llkqVdKjJ9Bg5ww0EB2enP8MElvpx3qdBA==
X-Received: by 2002:a05:6402:4343:b0:5fc:3e6e:f048 with SMTP id
 4fb4d7f45d1cf-5fc3e6ef1bbmr92825a12.0.1746637130393; 
 Wed, 07 May 2025 09:58:50 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77b8fe2fsm9977563a12.57.2025.05.07.09.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 09:58:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 43D715F858;
 Wed,  7 May 2025 17:58:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] target/arm: allow gdb to read ARM_CP_NORAW regs
Date: Wed,  7 May 2025 17:58:40 +0100
Message-Id: <20250507165840.401623-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Before this we suppress all ARM_CP_NORAW registers being listed under
GDB. This includes useful registers like CurrentEL which gets tagged
as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
registers. These are registers TCG can directly compute because we
have the information at compile time but until now with no readfn.

Add a .readfn to return the CurrentEL and then loosen the restrictions
in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
be read if there is a readfn available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Julian Armistead <julian.armistead@linaro.org>
---
 target/arm/gdbstub.c |  6 +++++-
 target/arm/helper.c  | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index ce4497ad7c..029678ac9a 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -282,7 +282,11 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     CPUARMState *env = &cpu->env;
     DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
-    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
+    if (!(ri->type & ARM_CP_NO_GDB)) {
+        /* skip ARM_CP_NO_RAW if there are no helper functions */
+        if ((ri->type & ARM_CP_NO_RAW) && !ri->readfn) {
+            return;
+        }
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
                 arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e88630..7ea1307c20 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4993,6 +4993,17 @@ static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 #endif
 
+/*
+ * Normally the current_el is known at translation time and we can
+ * emit the result directly in TCG code. However this helper exists
+ * only so we can also expose CURRENTEL to gdb.
+ */
+static uint64_t aa64_currentel_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    int el = arm_current_el(env);
+    return el;
+}
+
 static const ARMCPRegInfo v8_cp_reginfo[] = {
     /*
      * Minimal set of EL0-visible registers. This will need to be expanded
@@ -5031,7 +5042,9 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     },
     { .name = "CURRENTEL", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 4, .crm = 2,
-      .access = PL1_R, .type = ARM_CP_CURRENTEL },
+      .access = PL1_R, .type = ARM_CP_CURRENTEL,
+      .readfn = aa64_currentel_read
+    },
     /*
      * Instruction cache ops. All of these except `IC IVAU` NOP because we
      * don't emulate caches.
-- 
2.39.5


