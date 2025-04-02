Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC9CC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06Vs-00051q-Ut; Wed, 02 Apr 2025 18:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VV-0004ly-63
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VS-0002Ux-AZ
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so1220945e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632659; x=1744237459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIBaSXCBiB76zYj9xN1pwI+WU4wW3ugy6kOSLXu/QpM=;
 b=UOOef8Jc7rGMFwIW0xgkrDHaZpkDifvPPZjX29UFlphjA5UCll6aADg92UXL/LIufM
 RvGkgk/7uFBrii2ovKHDeWPl6j4MnfbWVsbv2e2mXpu+RK7tZT72giD031ONW+uvaEud
 mSHUTId8RSN8n0kKuOl7gY7loAivtAwVwae+cpkFofHtej/xzNpv1nYi5Q/0G6O/CnZH
 ym46rK7D6xcgjrvPoRKt/P3J4mCQXTyy4dAGs0p568zp/VeGojsfbbCeQQ2CpDZEi62k
 fchu2+fl8LbX88L0+Q6AbPfTxyztI2DQ/Tcc3x7S147siRNniXm/zGGy2G9lWrY+RuZM
 45tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632659; x=1744237459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIBaSXCBiB76zYj9xN1pwI+WU4wW3ugy6kOSLXu/QpM=;
 b=MZcrdoUsi2hqABJfGDmPmWKuegTc7olMNsj9kKOoYbg6ydmC1QU6uWh8LqsNPkmeG3
 egAHCZ09lW2UYR/cptt+pbSA1toqqWvl8sBvBPZU6lK0erVDBkHWUzxNyKU8hamEq+r1
 S/zzWrlRxWyS48pRgiBy7ljf1iuAzqtU68xypD/gkudhDIQq2EbaN03YyNtCUPX0TacK
 Iob1ytM2OBUERTaoZW34rgOViUvtyQzdrQdM2gjz7wJ1YPECnJS+qjZAVkhVaM0MHkwt
 49C4U+2MG9JWfRsWFo+UELASnd2wo15V3x1ySTiGwFJPFJkb1cLWehaYNxvW/6/VkRiu
 kMjg==
X-Gm-Message-State: AOJu0Ywo47GgDHTvvf97TGCIG5/p64DSB9UVEf6p5BpJylYhpt2+99Vs
 KnPw9fIadFPU+7YTfCr7It4CJnIjL9MBnLOhruJvlXIj/vOelm2qzlZpkh6k7fbeQz72kLAQsqZ
 8
X-Gm-Gg: ASbGncvGa4334Di2Lq7g5MRTo5efV8Vn3eWhaDeW7vT2IqEOvqvWTtnbFsOuI4rYj4v
 BkwywQOBsSYSrlVEAs4vegpcls3DiVL6ilTujgbrBI7VLaaWnsjIypQonuhGTlCFd957zLeO2Ih
 bXsUg10X8kkpBVHbchNaH5czOtAL0CQxYKgJLHuvIZvG4zf/xaBZW3ES1YTDEanxtBSiulRhD+l
 4uLFz+RJykgGB/UbwZeHTm+8e8IvVDGeVKy4mMsakVGtjdpNFMevD0XwYKRLnbEFiaNY+w97t4N
 4CA6wYdSlKOte0x9A0igGwSNX5EJSUiDPNoSiM0Evy0XVz2x+dfs/KRPCz4Ft1OD531pXUR1srY
 YVW30U2WBq2ZU0UjkZ+s=
X-Google-Smtp-Source: AGHT+IECxLzo2qNl/k8gxQyaMkXEb5N7/ilVvHBE6Enpu/Z0gopL3i7j/HuBB4Avcp2H1Y+IdsjZAA==
X-Received: by 2002:a05:600c:4e47:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-43ea7c710a1mr89206975e9.12.1743632659058; 
 Wed, 02 Apr 2025 15:24:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d9cfsm42716f8f.78.2025.04.02.15.24.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:24:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 09/13] target/arm: Extract PSCI definitions to
 'psci.h'
Date: Thu,  3 Apr 2025 00:23:29 +0200
Message-ID: <20250402222334.66511-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Extract PSCI definitions (which are not target specific)
to the new "target/arm/psci.h", so code from hw/arm/ can
use them without having to include the target specific
"cpu.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/boot.h      |  3 ++-
 target/arm/cpu.h           |  6 ------
 target/arm/psci.h          | 18 ++++++++++++++++++
 hw/arm/bananapi_m2u.c      |  1 +
 hw/arm/boot.c              |  1 +
 hw/arm/highbank.c          |  1 +
 hw/arm/imx8mp-evk.c        |  1 +
 hw/arm/mcimx6ul-evk.c      |  1 +
 hw/arm/mcimx7d-sabre.c     |  1 +
 hw/arm/orangepi.c          |  1 +
 hw/arm/sbsa-ref.c          |  1 +
 hw/arm/virt-acpi-build.c   |  1 +
 hw/arm/virt.c              |  1 +
 hw/arm/xlnx-versal-virt.c  |  1 +
 hw/arm/xlnx-zcu102.c       |  1 +
 hw/vmapple/vmapple.c       |  1 +
 target/arm/helper.c        |  1 +
 target/arm/hvf/hvf.c       |  1 +
 target/arm/tcg/op_helper.c |  1 +
 target/arm/tcg/psci.c      |  1 +
 20 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 target/arm/psci.h

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index b12bf61ca81..648fdb88862 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -12,6 +12,7 @@
 #define HW_ARM_BOOT_H
 
 #include "target/arm/cpu-qom.h"
+//#include "target/arm/psci.h"
 #include "qemu/notify.h"
 
 typedef enum {
@@ -100,7 +101,7 @@ struct arm_boot_info {
      * as the conduit specifies calls should go to (eg guest firmware booted
      * to EL3) then PSCI will not be enabled.
      */
-    int psci_conduit;
+    int psci_conduit;//
     /* Used internally by arm_boot.c */
     int is_linux;
     hwaddr initrd_start;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 45a9551535e..e78a1668bba 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3104,12 +3104,6 @@ static inline bool bswap_code(bool sctlr_b)
 void cpu_get_tb_cpu_state(CPUARMState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *flags);
 
-enum {
-    QEMU_PSCI_CONDUIT_DISABLED = 0,
-    QEMU_PSCI_CONDUIT_SMC = 1,
-    QEMU_PSCI_CONDUIT_HVC = 2,
-};
-
 #ifndef CONFIG_USER_ONLY
 /* Return the address space index to use for a memory access */
 static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
diff --git a/target/arm/psci.h b/target/arm/psci.h
new file mode 100644
index 00000000000..8b868dfbb91
--- /dev/null
+++ b/target/arm/psci.h
@@ -0,0 +1,18 @@
+/*
+ * ARM Power State Coordination Interface (PSCI) definitions
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_PSCI_H
+#define TARGET_ARM_PSCI_H
+
+enum {
+    QEMU_PSCI_CONDUIT_DISABLED = 0,
+    QEMU_PSCI_CONDUIT_SMC = 1,
+    QEMU_PSCI_CONDUIT_HVC = 2,
+};
+
+#endif
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index b750a575f72..61e01a38099 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -27,6 +27,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
+#include "target/arm/psci.h"
 
 static struct arm_boot_info bpim2u_binfo;
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 79afb51b8a5..b81a850819b 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -29,6 +29,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "target/arm/psci.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 0caa08631ad..16fb2508d30 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -36,6 +36,7 @@
 #include "qemu/log.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/psci.h"
 
 #define SMP_BOOT_ADDR           0x100
 #define SMP_BOOT_REG            0x40
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 6e64ec4ea54..c8a99b2c49e 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -15,6 +15,7 @@
 #include "system/qtest.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "target/arm/psci.h"
 
 static void imx8mp_evk_init(MachineState *machine)
 {
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 86982cb0772..be5e50abf17 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -18,6 +18,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
+#include "target/arm/psci.h"
 
 static void mcimx6ul_evk_init(MachineState *machine)
 {
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 33119610113..e0f25b92594 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
+#include "target/arm/psci.h"
 
 static void mcimx7d_sabre_init(MachineState *machine)
 {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index e0956880d11..99037a09a36 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
+#include "target/arm/psci.h"
 
 static struct arm_boot_info orangepi_binfo;
 
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 90fbb56ba7a..1f592627c99 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -53,6 +53,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/psci.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e1786..da61af1d359 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -59,6 +59,7 @@
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/psci.h"
 
 #define ARM_SPI_BASE 32
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a4..fe2dec9500f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -79,6 +79,7 @@
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/psci.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e19c4d9ef58..94fad8e60f2 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -21,6 +21,7 @@
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/psci.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 88b1eafab4d..902ee65ca5f 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 #include "net/can_emu.h"
 #include "audio/audio.h"
+#include "target/arm/psci.h"
 
 struct XlnxZCU102 {
     MachineState parent_obj;
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 25652b16f0c..b73b6fb8115 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -53,6 +53,7 @@
 #include "system/system.h"
 #include "target/arm/gtimer.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/psci.h"
 
 struct VMAppleMachineState {
     MachineState parent;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e886306..48238ae0b20 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,7 @@
 #endif
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/psci.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 34ca36fab55..f617e73feae 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -33,6 +33,7 @@
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/psci.h"
 #include "trace.h"
 #include "migration/vmstate.h"
 
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 005f84082af..6e9db2e77e2 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -26,6 +26,7 @@
 #include "exec/exec-all.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/psci.h"
 #include "cpregs.h"
 
 #define SIGNBIT (uint32_t)0x80000000
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index cabed43e8a8..0313cdd6ba2 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -25,6 +25,7 @@
 #include "internals.h"
 #include "arm-powerctl.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/psci.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
-- 
2.47.1


