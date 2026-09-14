Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F309BC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CIF-0001lO-7j; Mon, 14 Sep 2026 15:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CIC-0001ek-C2; Mon, 14 Sep 2026 15:24:40 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CIA-0002Pj-25; Mon, 14 Sep 2026 15:24:40 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hkFTH6nhhzBqZm;
 Mon, 14 Sep 2026 21:24:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789413876;
 bh=eTORqgHRjvLB7Zq5ZRd5F5B/wCOqFwPXotdNGYO5WvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m74jP/Z94JKQc6CMxVff2h0kDv8vyWTL2kpnOEzWQKT8GzNeRV2L0SOp1OAMbj1ZO
 5op3GmSUW62H2T7/Jev94oClgdmFuRSMmgA1VDj7jc5g5sOMu4t3B1qxKAmC5y4T4d
 C8ieZ7ZLNkzKVE//K2IU9cBvWCGVDhOQCngDJKwm/CiT6qKyvQhravQdi+OWT7ISfW
 JlYkXQeLPXFWY+53L4HbuM7Vaekyf8zNLhpUBo3kyiCrDyDetn5K6RIReB+JZgglbI
 uGXESVl8zVVRXrnnb5cEaIJOAfPnN9w1DyI2vIw60uNQXyqErl2vS2RzuwAemjmY6p
 t1Yady6F8DvWg==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hkFTH1qQTz801x;
 Mon, 14 Sep 2026 21:24:35 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 1/6] target/arm: enforce Armv6-M NVIC limits
Date: Mon, 14 Sep 2026 21:23:17 +0200
Message-ID: <20260914192323.29250-2-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
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

Armv6-M supports no more than 32 external interrupts. Its ICTR and Active
Bit Register locations are reserved, and Cortex-M0 implements two priority
bits.

Reject Armv6-M NVIC configurations with more than 32 external interrupts.
Add a check-tcg test that verifies the reserved register behavior and
priority masking on the microbit machine.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/intc/armv7m_nvic.c                   |  5 ++
 tests/tcg/arm/system/meson.build        |  6 +++
 tests/tcg/arm/system/test-armv6m-nvic.S | 70 +++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 tests/tcg/arm/system/test-armv6m-nvic.S

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a7651f831e..b1d27dfb32 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2728,6 +2728,11 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (!arm_feature(&s->cpu->env, ARM_FEATURE_V7) && s->num_irq > 32) {
+        error_setg(errp, "Armv6-M NVIC cannot exceed 32 external IRQs");
+        return;
+    }
+
     qdev_init_gpio_in(dev, set_irq_level, s->num_irq);
 
     /* include space for internal exception vectors */
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 4c77b9c3d6..5286997670 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -39,6 +39,12 @@ tests += {
                '-T', files('test-armv6m-undef.ld')],
     'qemu_args': ['-M', 'microbit', qemu_base_args],
   },
+  'test-armv6m-nvic.S': {
+    'cflags': ['-mcpu=cortex-m0', '-mfloat-abi=soft', '-nostdlib',
+               '-Wl,--build-id=none',
+               '-T', files('test-armv6m-undef.ld')],
+    'qemu_args': ['-M', 'microbit', qemu_base_args],
+  },
   'semiconsole.c': {
     'cflags': cflags,
     'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
diff --git a/tests/tcg/arm/system/test-armv6m-nvic.S b/tests/tcg/arm/system/test-armv6m-nvic.S
new file mode 100644
index 0000000000..ecb29eaa3d
--- /dev/null
+++ b/tests/tcg/arm/system/test-armv6m-nvic.S
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Test Armv6-M NVIC register behavior. */
+
+.syntax unified
+.cpu cortex-m0
+.thumb
+
+#define SRAM_BASE 0x20000000
+#define SRAM_SIZE (16 * 1024)
+
+#define NVIC_ICTR  0xe000e004
+#define NVIC_IABR0 0xe000e300
+#define NVIC_IPR0  0xe000e400
+
+#define semihosting_call bkpt 0xab
+#define SYS_EXIT 0x18
+
+vector_table:
+    .word SRAM_BASE + SRAM_SIZE
+    .word reset + 1
+    .word 0
+    .word failure + 1
+    .rept 44
+    .word 0
+    .endr
+
+.equ exc_reset_thumb, reset + 1
+.global exc_reset_thumb
+reset:
+    /* ICTR is reserved and reads as zero on Armv6-M. */
+    ldr r0, =NVIC_ICTR
+    ldr r1, [r0]
+    cmp r1, 0
+    bne failure
+
+    /* The Active Bit Register is reserved and behaves as RAZ/WI. */
+    ldr r0, =NVIC_IABR0
+    movs r1, 1
+    str r1, [r0]
+    ldr r1, [r0]
+    cmp r1, 0
+    bne failure
+
+    /* Cortex-M0 implements the two most significant priority bits. */
+    ldr r0, =NVIC_IPR0
+    movs r1, 0xff
+    strb r1, [r0]
+    ldrb r1, [r0]
+    cmp r1, 0xc0
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


