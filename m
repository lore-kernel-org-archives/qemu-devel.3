Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC43C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHN-0002Tv-UX; Fri, 26 Jan 2024 09:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHK-0002Oh-H3
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:58 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHI-0007yR-FJ
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:58 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51022133a84so547269e87.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279635; x=1706884435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2Ij/Lp2rwQRGvyHfQ52tPmKqtKK6wJgy1701b00v8tA=;
 b=I1AEzOtkca1H6QB9YMQgHE6BmfT1Gq6TEikBujMreGN9h0ZV4LapbHPf8ZSZ0RwEQd
 fUeE9vrvXdegBoppkUXhR92JTYuyUAbQ/nrLtyqL5e6WFpEcV5Cw2jgdcDmJ9zdOdrCD
 AnRvIzgPsNIOJ5EVFg5srIuxp6j45hKkQUm0IL1KCLksTpDs/SL7Q6k1yD1kcl4uwd4q
 UUcJ3Ok7BgQZKsWZ/y5P21oo6qsy33EbyxWcVF7aIR7UJyqrZsTQt75nJIwNtgd3CdBh
 zYmVDNqrSZdOzi0lfz2h3Y2wTu4whIre3wGncM3T5kuNV9KrYBNhIxU1r8VTLWJVL7tj
 eQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279635; x=1706884435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ij/Lp2rwQRGvyHfQ52tPmKqtKK6wJgy1701b00v8tA=;
 b=Z12+sIaB/eP0W63iuGyw+pNX05grS5iTxpPK548wtYKa+6+5VHiQbOOv4XHQ9KGGzl
 59wrdCnCC5EZEXGga+97A1SW1jw6lXzsoWspAkyR0X0V9LxF+QTxKGnVgAe0cd2qMvho
 0W4GF95a+qaRl8EplFlrxUU4tqu6q1Pf0JAz7cJ9B905h8B0ka/43hodlDzttYZFZUwd
 4boRv3ri1r0M/VrvQM0AyTkm0addzTx8Tge6ryTgUdMCSyvAn3aIqfndMpBf2o2AvPwp
 jhX++87oZzPhthVQ6a9QH/p6VsWa7Jte4mT0jMxUPyahLKHrlQSzX2fXPP7dm/ZP3rny
 knFw==
X-Gm-Message-State: AOJu0YykivUf7KvUnk+eRxQ1u0OP/Jokwm4Xde8Tw7Dq2x7U35VfB3q+
 colHo1NJdUXtKnCIBicGdbddW7ZSQIh4ksQU744fJytHT384WxN99+C0C/bx6FxrphF5l4yD6aI
 E
X-Google-Smtp-Source: AGHT+IE+vDKB1/n/Pi8H2pPK0D4rZCrOUUpWQHl4846JXYxjSlfZ7hWuN5lW0j+UElxYflluhLHAYQ==
X-Received: by 2002:a05:6512:6d5:b0:510:ca7:dcca with SMTP id
 u21-20020a05651206d500b005100ca7dccamr2056420lff.40.1706279634596; 
 Fri, 26 Jan 2024 06:33:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/36] target/arm: Move GTimer definitions to new 'gtimer.h'
 header
Date: Fri, 26 Jan 2024 14:33:33 +0000
Message-Id: <20240126143341.2101237-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move Arm A-class Generic Timer definitions to the new
"target/arm/gtimer.h" header so units in hw/ which don't
need access to ARMCPU internals can use them without
having to include the huge "cpu.h".

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-20-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h       |  8 +-------
 target/arm/gtimer.h    | 21 +++++++++++++++++++++
 hw/arm/allwinner-h3.c  |  1 +
 hw/arm/allwinner-r40.c |  1 +
 hw/arm/bcm2836.c       |  1 +
 hw/arm/sbsa-ref.c      |  1 +
 hw/arm/virt.c          |  1 +
 hw/arm/xlnx-versal.c   |  1 +
 hw/arm/xlnx-zynqmp.c   |  1 +
 hw/cpu/a15mpcore.c     |  1 +
 target/arm/cpu.c       |  1 +
 target/arm/helper.c    |  1 +
 target/arm/hvf/hvf.c   |  1 +
 target/arm/kvm.c       |  1 +
 target/arm/machine.c   |  1 +
 15 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 target/arm/gtimer.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e8df41d642e..d3477b16018 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -27,6 +27,7 @@
 #include "exec/cpu-defs.h"
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/gtimer.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -140,13 +141,6 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-#define GTIMER_PHYS     0
-#define GTIMER_VIRT     1
-#define GTIMER_HYP      2
-#define GTIMER_SEC      3
-#define GTIMER_HYPVIRT  4
-#define NUM_GTIMERS     5
-
 #define VTCR_NSW (1u << 29)
 #define VTCR_NSA (1u << 30)
 #define VSTCR_SW VTCR_NSW
diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
new file mode 100644
index 00000000000..b992941bef1
--- /dev/null
+++ b/target/arm/gtimer.h
@@ -0,0 +1,21 @@
+/*
+ * ARM generic timer definitions for Arm A-class CPU
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_GTIMER_H
+#define TARGET_ARM_GTIMER_H
+
+enum {
+    GTIMER_PHYS     = 0,
+    GTIMER_VIRT     = 1,
+    GTIMER_HYP      = 2,
+    GTIMER_SEC      = 3,
+    GTIMER_HYPVIRT  = 4,
+#define NUM_GTIMERS   5
+};
+
+#endif
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 2d684b5287b..380e0ec11d6 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 /* Memory map */
 const hwaddr allwinner_h3_memmap[] = {
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 79976b0b54d..eef1fc196e5 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -34,6 +34,7 @@
 #include "hw/arm/allwinner-r40.h"
 #include "hw/misc/allwinner-r40-dramc.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 /* Memory map */
 const hwaddr allwinner_r40_memmap[] = {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 58a78780d2b..e3ba18a8ec1 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,6 +16,7 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 struct BCM283XClass {
     /*< private >*/
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index d6081bfc41f..85cb68d5463 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -51,6 +51,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 64802446cb1..e6ead2c5c89 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -76,6 +76,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/gtimer.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 87fdb39d430..2798df3730d 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -24,6 +24,7 @@
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 38cb34942f8..65901c6e74b 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "kvm_arm.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 #define GIC_NUM_SPI_INTR 160
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index bfd8aa56448..967d8d3dd50 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "target/arm/gtimer.h"
 
 static void a15mp_priv_set_irq(void *opaque, int irq, int level)
 {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4807a4fea0d..b60e1030469 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -49,6 +49,7 @@
 #include "fpu/softfloat.h"
 #include "cpregs.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e07b2af8a3d..945d8571a61 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -30,6 +30,7 @@
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
+#include "target/arm/gtimer.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 71a26db1886..e5f0f60093e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -29,6 +29,7 @@
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/gtimer.h"
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8f52b211f9a..81813030a5a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -38,6 +38,7 @@
 #include "qemu/log.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
+#include "target/arm/gtimer.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 542be14bec2..9d7dbaea54c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -7,6 +7,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "migration/cpu.h"
+#include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
 {
-- 
2.34.1


