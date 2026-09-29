Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C56CCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUes-00071N-Ie; Tue, 29 Sep 2026 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeq-00070Z-Ow
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:56 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUeo-0008A5-UZ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:56 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so2179415f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676113; x=1791280913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P+ReVphF7fTWfvP4LtHPd8Ji5ciEmgrVQmDpQlfR+LQ=;
 b=WGhEqAq8eNTDm2SD1vImDqGlbUJT5nf8KdRfjn/g5rqd/6NqBypduv5mTOKLeIKSbJ
 zcMguH+AyOZOtUw8QMdG56NKTJgOT19TOhZEX3rOnA2GebNcZEyQjTLVQEI8g2wUa8Ph
 fRLqeHW/pkHkCJiRktGavwMxVVp+U2ZW6nYOxkf45eVSMn24wA7VSz8y/65agn0Vm/3k
 Rt8/EPCdbjbX2Xsl3jHU9gExky5xtMHSA3Zq9iIf9nNqDT+L/CszU6ntn0P4UyhDljrd
 HRYLLQKx3/C5AQoEj7JdJehBy5Pf1tCqDF//FeSc43jdGSkhKMAHl1vf9xCnJgxzgbbj
 WmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676113; x=1791280913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=P+ReVphF7fTWfvP4LtHPd8Ji5ciEmgrVQmDpQlfR+LQ=;
 b=vqbcCT8Xvx8YDLoBfkA6KM/KMCRtoGXHS7CgU5qv8TIXefwV+ZGPsabwKgmIoMjLab
 hGyJ7LVBC5CWQIMfn3v5mbCOLaVIQMFx9qdtpeMyqDt8IgE+bcm1SyaWlxVm+QFu7Nf5
 mz8/HSEBqUOWOJkqZrsNn0i77p/bIczpt4W3nvY43QI1V0xb/XmUbf3RTuG8v59nLWxr
 agsptH63L6Wm0KIOJM/v5OSvwhlnTipACHAIzvfUruO3tgiRl6XqEGoiKQwHgmf0ozFj
 ohF1u47vYgYOn+rQA9z44d5IPm5d2vtVIz8umLSlw2u0sqkbQJ4ZYxvETs3EQ0PVooeK
 aRDQ==
X-Gm-Message-State: AFq9FYJ9ceTzqDJ7PjXxLGB1N1aVets0UCOSk5BJe19lgESEB1vcsk7q
 tvx79fDBzZdXGjIEQTU3NntPBsiEXp7D++1F02ZMtPxe3ssRcJuCBQu8mJaFt86IE5bVwcLQHLP
 Idn23
X-Gm-Gg: AYBFou3Ppkhnk6vpHwq9tCB6xTexUb1IG3qiBe4/Zv+WgULqUMheyqmFz15D+7L8P9k
 fFGlQQurHxY5hYwgcn5GchIdpZPEJlKsbyUItBQeYyOc0sYAyx9C8ElWPOhClPL2TIZFwO50j3a
 xTMTwH4EJRsDy/dNBAXAXZkztKV41SPIbeHW7cArIGOG2rg2ASl/eJaB6O9093YLGL/aCll2Ya/
 cv7IOWFa88OpFFUt7mfRwaTKJ+BMTeLanbNBhbj7XHFTpj0xKaqeeRmEwG9DkVKeQ/6jHkk+Cac
 b81wjDiDD90XpIkjNsTkIIWy+osYwPojOGjbX13ot4XN2u0kVRoNxf/bPh+iGswtAcNcLrEibUB
 EuP5+1usyPnF5FiBW6wXfR8QXUu9UgV3fwPsVnscIcd5L4isRrCZ/cQVRxcsjl0HfqdpSeXh9EQ
 zSASX8IkVMsAglITrdMtFH0Y/zqw+zcOFcv9UxqToYeTi7GefAqzRWmFc+Q7/hN9QZis+1u/W+2
 egYEU+i7W4h0qWIygZpLDsLbg+wT9YF13nxFZIlAIwXgSqhU3eMzSAsOxl+0l07uizZi1Bn8SSF
 pmI=
X-Received: by 2002:a05:6000:22c3:b0:48a:f26d:18b3 with SMTP id
 ffacd0b85a97d-48af26d19bcmr3331592f8f.42.1790676113330; 
 Tue, 29 Sep 2026 03:01:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/37] target/arm: model Cortex-M0+ privilege extension
Date: Tue, 29 Sep 2026 11:01:07 +0100
Message-ID: <20260929100133.2598676-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

The Armv6-M Unprivileged/Privileged Extension is optional. Cortex-M0 does
not implement it, while Cortex-M0+ may implement it. The RP2040 Cortex-M0+
configuration provides the extension.

Add an ARM feature bit that represents the optional privileged/unprivileged
extension. Make ARM_FEATURE_M_MAIN imply ARM_FEATURE_M_UNPRIV (handled in
arm_cpu_propagate_feature_implications) so that privileged writes to
CONTROL.nPRIV are allowed when the Main Extension is present (or when the
optional privilege extension is present without the Main Extension).

Update the microbit Cortex-M0 test to verify that writes to nPRIV are
ignored.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c                           |  4 ++
 target/arm/cpu.h                           |  1 +
 target/arm/tcg/m_helper.c                  |  2 +-
 tests/tcg/arm/system/meson.build           |  6 ++
 tests/tcg/arm/system/test-armv6m-control.S | 66 ++++++++++++++++++++++
 5 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 090470da40a..be2316bec1c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1467,6 +1467,10 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
         set_feature(env, ARM_FEATURE_PMSA);
     }
 
+    if (arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        set_feature(env, ARM_FEATURE_M_UNPRIV);
+    }
+
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M)) {
             set_feature(env, ARM_FEATURE_V7);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5c8ea5a7ed2..f07cadb45c7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2184,6 +2184,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_M_UNPRIV, /* M profile Unprivileged/Privileged Extension */
     ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
     /*
      * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55bc..65dcf97adef 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2775,7 +2775,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                            !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_UNPRIV)) {
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 89734f95605..80c5461e620 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -45,6 +45,12 @@ tests += {
                '-T', files('test-armv6m-undef.ld')],
     'qemu_args': ['-M', 'microbit', qemu_base_args],
   },
+  'test-armv6m-control.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-Wl,--build-id=none',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/test-armv6m-control.S b/tests/tcg/arm/system/test-armv6m-control.S
new file mode 100644
index 00000000000..42ce42db2b6
--- /dev/null
+++ b/tests/tcg/arm/system/test-armv6m-control.S
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test that Cortex-M0 does not implement CONTROL.nPRIV. */
+
+.syntax unified
+.cpu cortex-m0
+.thumb
+
+#define SRAM_BASE 0x20000000
+#define SRAM_SIZE (16 * 1024)
+
+#define semihosting_call bkpt 0xab
+#define SYS_EXIT 0x18
+
+vector_table:
+    .word SRAM_BASE + SRAM_SIZE
+    .word reset + 1
+    .word 0
+    .word failure + 1
+    .rept 7
+    .word 0
+    .endr
+    .word 0
+    .word 0
+    .word 0
+    .word 0
+    .word 0
+    .rept 32
+    .word 0
+    .endr
+
+.equ exc_reset_thumb, reset + 1
+.global exc_reset_thumb
+reset:
+    /* Thread mode starts privileged. */
+    mrs r0, control
+    movs r1, 1
+    tst r0, r1
+    bne failure
+
+    /* Cortex-M0 does not implement the optional privilege extension. */
+    movs r0, 1
+    msr control, r0
+    isb
+    mrs r0, control
+    tst r0, r1
+    bne failure
+
+success:
+    movs r0, 1
+    b exit
+
+failure:
+    movs r0, 0
+
+exit:
+    movs r1, 0
+    cmp r0, 1
+    bne 1f
+    ldr r1, ADP_Stopped_ApplicationExit
+1:
+    movs r0, SYS_EXIT
+    semihosting_call
+
+.align 2
+ADP_Stopped_ApplicationExit:
+    .word 0x20026
-- 
2.43.0


