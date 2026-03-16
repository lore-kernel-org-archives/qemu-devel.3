Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562EBF4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PF-00019Z-8t; Mon, 16 Mar 2026 06:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PD-000129-Bo
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PB-0003eB-Io
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4855dbfc129so20113915e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657756; x=1774262556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XYRJLl5EMUK6R3j4Nm05BR4Id89lXxBiwStHyfVM6Vk=;
 b=JoDowGxdwBS3FhuohIEA54N209cKZqpUbn2YB0sp9ete0By4itpyqQ3W1wgPO0rEaP
 W6oksdvrSrjoc3STHSFI4ls/nxwXlN5BCkuQYgEX82JFMhCe/bql/YjBR9wbb6wCg4fM
 tNmEYyXXeNM5KXVzPGH4wmR7bseJW1uIjjd3JL6+mb5xCoZbsupiwlm6lZnmlLVg4ZJt
 JF1mdVGtKz2St2zP8NwCODgKdvWuAN2OEI7dwe0ZCDajg2FGEvQdWu2TCtrG7zAr7Nzq
 39ebaWcgB55E9v8wRPReIeCl/wIFUaZtuKksLI0nzZ29BnQkJ49DyA7V6Nz03i4wY6CU
 sq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657756; x=1774262556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XYRJLl5EMUK6R3j4Nm05BR4Id89lXxBiwStHyfVM6Vk=;
 b=LcMPp1+L+uGcVPzZRb+ZPCamfghBm/OREI4Eg95rSGl2k0mBpCJRrZ67hyrNmRRRqr
 1VJoW3Z4mVN2Z/3GJcNAskqSkx7Zj+tGP5i+csNdScBiXjg082Y9j+EeaeiK2BZxoNxQ
 RrhMcWyAyvUEzmGPqDYNIiY/5+ZYV3q3Fs846AmJ/1V3MbZugCwruUqxrD8FnvDCZIxD
 TwOI9yDEHq3svy3l01d88vhav4CggUbGsFwXzx18zX87Xs8RBhDSwG5+bKPmpdHloA+p
 MBvH8crPnxeUj9Lyk0mKipYmhjDIAojjK7XV+m6RCaqeZhkrKgDpa33966dSsxzUPR9M
 9CKw==
X-Gm-Message-State: AOJu0Yz8R+ppLQJiP5MVTXf6wGB4DPjST1UB+GrKjCo0wod1q/crtvbf
 W2ZdIlHbahEkYEt3vSDhbq7Kfl/mbKTxmTW3L0duRcR1wH5Oy4Ph9h8qoQhePJp6U4SCica9dRv
 PLMGO
X-Gm-Gg: ATEYQzz3AAxcDKdd9qCGer7o6mWin+bjAkK3xFBv3BJZWxCtfOLguUkTwmNjcCJJxf/
 9p3uUIl/IZUXk2coQD5kJR1n7zx9OAB7iMOLCkIs+C8hcPd4l5aGWcr7DHgycWpEjt8ix/uKOMi
 kCi/gQRJ/oxhaR10/NM0IrPaK+aq4oDW+3+5OOayB6ZsY4nKn6D51vY4r8jv5pWEMYku8KDMcsS
 cVdh8qZZ2Wo7RozsV7xHlkvUMCWLvwNpJy2GjWc8t2oIMbrLqsKcvWe+TygoxPrBdYncvNW0ZGv
 0dD4jtRaaOsuNVb3ILwbiO2j04Q5z1uEOFHVA0VqZYGLdzz1cuQSzo79FeQs3BPcjuD3EQk7uO/
 pkyVRU1pZFjESJYnJJyUwHrlDH5GalHwvw7AvRxa5e1XSKlCYKl9+y7rqq3OZN56C1ZbY9BsHGh
 KMr5bqrt6c0y5uV6p+hT5HvAGBdgGeHr+dBpDNNrnP+F0ZVNQYTMwgmpoH+XFpNB8ToNZW79jrl
 pKa7zAP5RE=
X-Received: by 2002:a05:600c:64cf:b0:485:3f58:da6 with SMTP id
 5b1f17b1804b1-485566cdc2dmr208104665e9.2.1773657755840; 
 Mon, 16 Mar 2026 03:42:35 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/17] include/hw/core: Rename virtio_is_big_endian to
 internal_is_big_endian
Date: Mon, 16 Mar 2026 10:42:15 +0000
Message-ID: <20260316104230.836962-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>

These functions are needed to do semihosting on CPUs that support
runtime-configurable endiannes. This commit renames them and allows
using them for semihosting, but makes sure to signal that these
functions should not be used in other circumstances.

Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260311-semihosting-cpu-tswap-v3-1-8e239575ec08@eonerc.rwth-aachen.de
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/cpu-system.c             | 6 +++---
 hw/virtio/virtio.c               | 2 +-
 include/hw/core/cpu.h            | 4 ++--
 include/hw/core/sysemu-cpu-ops.h | 6 +++---
 target/arm/cpu.c                 | 4 ++--
 target/ppc/cpu_init.c            | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 4a91c3e8ec..273b9b7c22 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -127,10 +127,10 @@ int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
     return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
-bool cpu_virtio_is_big_endian(CPUState *cpu)
+bool cpu_internal_is_big_endian(CPUState *cpu)
 {
-    if (cpu->cc->sysemu_ops->virtio_is_big_endian) {
-        return cpu->cc->sysemu_ops->virtio_is_big_endian(cpu);
+    if (cpu->cc->sysemu_ops->internal_is_big_endian) {
+        return cpu->cc->sysemu_ops->internal_is_big_endian(cpu);
     }
     return target_big_endian();
 }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 0ba734d0bc..8fcf6cfd0b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2323,7 +2323,7 @@ static enum virtio_device_endian virtio_default_endian(void)
 
 static enum virtio_device_endian virtio_current_cpu_endian(void)
 {
-    if (cpu_virtio_is_big_endian(current_cpu)) {
+    if (cpu_internal_is_big_endian(current_cpu)) {
         return VIRTIO_DEVICE_ENDIAN_BIG;
     } else {
         return VIRTIO_DEVICE_ENDIAN_LITTLE;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7d2f4459d2..04e1f970ca 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -782,13 +782,13 @@ hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
 int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs);
 
 /**
- * cpu_virtio_is_big_endian:
+ * cpu_internal_is_big_endian:
  * @cpu: CPU
 
  * Returns %true if a CPU which supports runtime configurable endianness
  * is currently big-endian.
  */
-bool cpu_virtio_is_big_endian(CPUState *cpu);
+bool cpu_internal_is_big_endian(CPUState *cpu);
 
 /**
  * cpu_has_work:
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 877892373f..7b2d2d2610 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -77,13 +77,13 @@ typedef struct SysemuCPUOps {
     int (*write_elf64_qemunote)(WriteCoreDumpFunction f, CPUState *cpu,
                                 DumpState *s);
     /**
-     * @virtio_is_big_endian: Callback to return %true if a CPU which supports
+     * @internal_is_big_endian: Callback to return %true if a CPU which supports
      * runtime configurable endianness is currently big-endian.
      * Non-configurable CPUs can use the default implementation of this method.
      * This method should not be used by any callers other than the pre-1.0
-     * virtio devices.
+     * virtio devices and the semihosting interface.
      */
-    bool (*virtio_is_big_endian)(CPUState *cpu);
+    bool (*internal_is_big_endian)(CPUState *cpu);
 
     /**
      * @legacy_vmsd: Legacy state for migration.
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7e3e84b4bb..98d09ac065 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -756,7 +756,7 @@ static void arm_cpu_set_irq(void *opaque, int irq, int level)
     }
 }
 
-static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
+static bool arm_cpu_internal_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -2299,7 +2299,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
-    .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
+    .internal_is_big_endian = arm_cpu_internal_is_big_endian,
     .legacy_vmsd = &vmstate_arm_cpu,
 };
 #endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3d932a5642..191f5726f6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7480,7 +7480,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
-    .virtio_is_big_endian = ppc_cpu_is_big_endian,
+    .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
 #endif
-- 
2.43.0


