Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B073CC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CJB-0002R3-NB; Mon, 14 Sep 2026 15:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CJA-0002Qq-5Y; Mon, 14 Sep 2026 15:25:40 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CJ8-0002dF-BC; Mon, 14 Sep 2026 15:25:39 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hkFVS2yXQz7vHr;
 Mon, 14 Sep 2026 21:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789413936;
 bh=tbh+Br5kxKIjFAp5cHgNYrIJK3nC03h/+dmIwaKU+/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WxvwY0cV5NLTjVUanVpQCUptZEY7am8X/lNJ8g3h5FCyWKi8uk61zkQ9iDgJ8j3ek
 yfggIxY6z3mFiej1KhnS08SdfCvzpzorFOKb1OwzW6C7OSVaz86CPj2ugkMbjzrlbb
 aRhUR3BLG3D0ubgZ0caQPAiQ1XVeNTD0oezra1Mi0YUzGh/WmOocGsDley8iwQpsaY
 hmPjoCYXR/ixik3Xx18Y3W7MhCih6OzT383EGGgDEhxZ5b/EsqneHA1TTxg7HcfJT8
 EaZrI5MAewbciL6zpomoqNzH197SsxrbE1MkK5VQqO3W/X4kj0cXWKk3ck2bXcMzMz
 s/4w40VFp2+SQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hkFVS1Qfcz80JX;
 Mon, 14 Sep 2026 21:25:36 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 2/6] target/arm: model Cortex-M0+ privilege extension
Date: Mon, 14 Sep 2026 21:23:18 +0200
Message-ID: <20260914192323.29250-3-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an ARM feature bit and a cortex-m0plus CPU type that enables it. Permit
privileged writes to CONTROL.nPRIV when either the Main Extension or the
optional privilege extension is present.

Update the microbit Cortex-M0 test to verify that writes to nPRIV are
ignored.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 target/arm/cpu.h                           |  1 +
 target/arm/tcg/cpu-v7m.c                   | 11 ++++
 target/arm/tcg/m_helper.c                  |  4 +-
 tests/tcg/arm/system/meson.build           |  6 ++
 tests/tcg/arm/system/test-armv6m-control.S | 66 ++++++++++++++++++++++
 5 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S

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
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 48b31d5eac..ac99c93ec3 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -76,6 +76,15 @@ static void cortex_m0_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR6, 0x00000000);
 }
 
+static void cortex_m0plus_initfn(Object *obj)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    cortex_m0_initfn(obj);
+    set_feature(&cpu->env, ARM_FEATURE_M_UNPRIV);
+    cpu->midr = 0x410cc601;
+}
+
 static void cortex_m3_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -325,6 +334,8 @@ static void arm_v7m_class_init(ObjectClass *oc, const void *data)
 static const ARMCPUInfo arm_v7m_cpus[] = {
     { .name = "cortex-m0",   .initfn = cortex_m0_initfn,
                              .class_init = arm_v7m_class_init },
+    { .name = "cortex-m0plus", .initfn = cortex_m0plus_initfn,
+                                .class_init = arm_v7m_class_init },
     { .name = "cortex-m3",   .initfn = cortex_m3_initfn,
                              .class_init = arm_v7m_class_init },
     { .name = "cortex-m4",   .initfn = cortex_m4_initfn,
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55b..f8461a4d66 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2775,7 +2775,9 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                            !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0 &&
+            (arm_feature(env, ARM_FEATURE_M_MAIN) ||
+             arm_feature(env, ARM_FEATURE_M_UNPRIV))) {
             env->v7m.control[env->v7m.secure] &= ~R_V7M_CONTROL_NPRIV_MASK;
             env->v7m.control[env->v7m.secure] |= val & R_V7M_CONTROL_NPRIV_MASK;
         }
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 5286997670..e92a83a8d5 100644
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


