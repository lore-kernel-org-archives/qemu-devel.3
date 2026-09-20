Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7368CC982D8
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8Ph5-0006Uf-Qx; Sun, 20 Sep 2026 18:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x8Ph3-0006UT-CB; Sun, 20 Sep 2026 18:07:29 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x8Ph1-0002Aj-7w; Sun, 20 Sep 2026 18:07:29 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hp0pM3bx6zBslm;
 Mon, 21 Sep 2026 00:07:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789942043;
 bh=VEmOJkJyO/s5qSziUaPjylGnPLKCmUrLGFOE4pVid7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Kin4TYb/9OORqE+iphmNAqMk2R3UrYHP7Dgjl3UGYeOpmj8If/5+FC+6A6eCuj6nU
 jC7YHOciExmkZrwlfsAY2oWWBml61UrX9hMZV8MLZEyZjuvKWbMAm9d0PXMXS6CU17
 4AuoKA6p8IS9WivCoKE0u56OIjwgM7u7Osxa64oGVS9Z4hHIFcBHWb3zyMRu7N5+2j
 NSHa593q5pku1+grTog9JZy+Htp9SaMdQm4ZFBtZiyh2/pBcKuePZn9jaXv2ODFrVX
 0uw+Ac6wAhZ4WP1JjnHFTu4PqM6OLJYsOMgO6AkleXEHyS8eRskH5/v8Ip8FB7jNKT
 KPoP3Zn0OftWg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hp0pM1xydz7tDT;
 Mon, 21 Sep 2026 00:07:23 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Alex Bennee <alex.bennee@linaro.org>
Subject: [PATCH v2] target/arm: model Cortex-M0+ privilege extension
Date: Mon, 21 Sep 2026 00:07:06 +0200
Message-ID: <20260920220722.73501-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFEAcA_=sRZboB1GyGDxEa4vTZe5YS4GwJV9aK=6h-fONgLVkQ@mail.gmail.com>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-3-gilles.grimaud@univ-lille.fr>
 <CAFEAcA_=sRZboB1GyGDxEa4vTZe5YS4GwJV9aK=6h-fONgLVkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
Changes in v2:
- Removed the Cortex-M0+ CPU type definition from this generic patch; it will
  be added separately in the upcoming RP2040/Pico series.
- Added the implication ARM_FEATURE_M_MAIN -> ARM_FEATURE_M_UNPRIV in
  arm_cpu_propagate_feature_implications().
- Changed the CONTROL.nPRIV write condition in m_helper.c to test only
  ARM_FEATURE_M_UNPRIV (Main Extension CPUs acquire it via the implication,
  while an Armv6-M CPU without Main Extension can expose the feature
  independently).

 target/arm/cpu.c                           |  4 ++
 target/arm/cpu.h                           |  1 +
 target/arm/tcg/m_helper.c                  |  2 +-
 tests/tcg/arm/system/meson.build           |  6 ++
 tests/tcg/arm/system/test-armv6m-control.S | 66 ++++++++++++++++++++++
 5 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 77aa78f00e..98c416cf96 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1465,6 +1465,10 @@ static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
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
index e3f931dba2..66606b3444 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2168,6 +2168,7 @@ enum arm_features {
     ARM_FEATURE_VBAR, /* has cp15 VBAR */
     ARM_FEATURE_M_SECURITY, /* M profile Security Extension */
     ARM_FEATURE_M_MAIN, /* M profile Main Extension */
+    ARM_FEATURE_M_UNPRIV, /* M profile Unprivileged/Privileged Extension */
     ARM_FEATURE_V8_1M, /* M profile extras only in v8.1M and later */
     /*
      * ARM_FEATURE_BACKCOMPAT_CNTFRQ makes the CPU default cntfrq be 62.5MHz
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55b..65dcf97ade 100644
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
index 4c77b9c3d6..d0a92cc4d0 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -39,6 +39,12 @@ tests += {
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
index 0000000000..42ce42db2b
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
2.55.0

