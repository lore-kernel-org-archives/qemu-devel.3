Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFE9C79FA0
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3InN-0002Gq-Ar; Sun, 06 Sep 2026 15:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InL-0002GQ-KC; Sun, 06 Sep 2026 15:44:51 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3InJ-0006xP-Qh; Sun, 06 Sep 2026 15:44:51 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdLJ82r05zBqYq;
 Sun,  6 Sep 2026 21:44:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723880;
 bh=fJ9WIbvmvcM55ywkVJtXJoWaxupz0l9kfHNKwPQMQAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jAt4fB+bCXwzY5LAhDogl7r50YfbHFejZ0X0+qdTNKekylblrV/ZnxilclxQYNoLG
 LVcQfDI5z7iIK+rBmTHvECkrVdHFPAvX047eabjGVWG0eqHvbpls4860ZaUKW5WFFV
 wdYoSM2QxmSstubRgps8BpVa6v+mzM/ZSz8GIyCqSGl2Iza6j8FlfY1zu19JMVNekt
 RLyYJho+hFJvGrDGpfMt+ILdQFjHe6qTOjOFbT340sqN6iQZydpTHqitIBJGEeMOOM
 oJJfu1SEldkBxZWr/z/7YTYsU0Nckx7eIpiqE9iisW6YgUb9pGg/IUHAu4KMm5XYoA
 hsKwYEcnd3oyw==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJ81XYJz7wHs;
 Sun,  6 Sep 2026 21:44:40 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 02/36] target/arm: allow Armv6-M to set CONTROL.nPRIV
Date: Sun,  6 Sep 2026 21:44:01 +0200
Message-ID: <20260906194438.93046-3-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Armv6-M implements CONTROL.nPRIV even though it does not implement the Main
Extension. The M-profile MSR helper currently gates writes to nPRIV on
ARM_FEATURE_M_MAIN, preventing Cortex-M0 CPUs from entering unprivileged
Thread mode.

Allow privileged code to write nPRIV on every M-profile CPU. The translator
already ends the translation block and rebuilds the execution flags after
an M-profile MSR, so this does not require explicit TLB maintenance.

Add a check-tcg test using the generic microbit machine. It verifies entry
into unprivileged Thread mode, that unprivileged code cannot clear nPRIV,
and that an exception handler can restore privileged Thread mode.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 target/arm/tcg/m_helper.c                  |  2 +-
 tests/tcg/arm/system/meson.build           |  6 ++
 tests/tcg/arm/system/test-armv6m-control.S | 85 ++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/arm/system/test-armv6m-control.S

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 33c9e7c55b..0cd51c52ba 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -2775,7 +2775,7 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
                            !arm_v7m_is_handler_mode(env))) {
             write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK) != 0);
         }
-        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
+        if (cur_el > 0) {
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
index 0000000000..4142618a94
--- /dev/null
+++ b/tests/tcg/arm/system/test-armv6m-control.S
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test Armv6-M CONTROL.nPRIV behavior. */
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
+    .word svc_handler + 1
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
+    /* A privileged write can enter unprivileged Thread mode. */
+    movs r0, 1
+    msr control, r0
+    isb
+    mrs r0, control
+    tst r0, r1
+    beq failure
+
+    /* An unprivileged write cannot clear nPRIV. */
+    movs r0, 0
+    msr control, r0
+    isb
+    mrs r0, control
+    tst r0, r1
+    beq failure
+
+    /* The privileged handler restores privileged Thread mode. */
+    svc 0
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
+
+svc_handler:
+    movs r0, 0
+    msr control, r0
+    bx lr
-- 
2.55.0


