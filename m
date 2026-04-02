Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209F7D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:58:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q2g-0000BK-5K; Thu, 02 Apr 2026 17:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2V-0008WN-Gf
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:24 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2S-0007Bx-L4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so206789366b.2
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167038; x=1775771838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bR48XpEfrTAurqrwxi3w+VRNBBsgCOfbhfQQhlmqcQo=;
 b=qkQMl+rXJ/i5LPkZjJk83bSwIpCUFnB+a3uJA5sN/1PCu+j8D1tKjaHCGp8L44hgvX
 mI7x+dFC2/CEDe39ET401qGsdanAhUJKNObnNH43KSTQSWzy1QSiXCHMA/5Jc1xC2BnJ
 pXO3T+49Fs/P3VhcjnpPrgbvy++YmzQgvmlZEue57nROBuTZsZlwUQ47fom0bN4Uruv4
 qjuO/EevcXpqvZ8KGYyhU7zX2cOIbEq5PRK49/2MWyfFfD0BgG5HE3H4t06WBTnXBiK3
 x2LFbRsabMdXbc1D/ihoX/wbRIzAXNu9bGAkEHYnBVm2qICXWt3w2HS60pJ6A7MkH4Kl
 xKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167038; x=1775771838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bR48XpEfrTAurqrwxi3w+VRNBBsgCOfbhfQQhlmqcQo=;
 b=QcAcsGU/Ryx4e5jpwrMmk0r1YMmoQqM5IcL3Th9h/4M3lp15UvBuO3dfgU8O6CHcWQ
 WKp5sftoC/Ajg9xxsa9ZQDEh94QewP1UnYwHdBZ6tX8nkyOO0AJk6KaoZNjROx1CIiJs
 BBkJ5dbOCoc/W1rd8qz0aE3ufIkoScqc/751evzt+yCrb3cirtnE4AgXGop1AMhf0An2
 HOSLlObL2J92K2BUW3TVNyRl80BvkjClFzgiTS7GbGomoBHzR3F6Hdw5+zXGVc7DeHe7
 ovUzjG821n9nuvPNQaP6vGAWqG5aBEnUsiQXFV19dJpXfaGEJqcWl4XwaZKC5wUQN1Lt
 RnIA==
X-Gm-Message-State: AOJu0Yy1vENXR1gBkBoFOlLMrSoPQASk+lFFijNIdyQgmNCXFLLMQiAo
 cZCHhRHI6c/9cB1AgyV598mnSR+umRxwg2k0kdSD9bkElzy53ajfIU2tMkA2tbgm
X-Gm-Gg: AeBDiessStP2ImBNBCHOErEESGjmueY/F4FkQPiKN4My/mkoovUvuwLJNEUUvNLw9J0
 /+sbKsENZFQSGaGTgl7m+mFeVmsGYtKFxaoTIf4HceDNPsUvzZC9ch5d8qiuL6jBcz05lj3xDM0
 +Ab/SC5Mdsueo/Nq3fB1RCXqVyNRr16oEM1kcOz2RhrVRk1XOiJE4YNilmJRyYY6MOXZihLjtIe
 qPp68FQvk+cBuDLFHPYBIV0f4ITiYDcTRTZHtz3kWczbvQmuWf/JMe85FRYERFOI4iVim0bQJl+
 MniRhz/m6YdkBPp6z/vCK2/lTYchi4OPVbqzy1J845rdHg8+zbnxel3gndQAj4MbLmiIBBwpXFT
 jatJaPrYQkims3yad7je39F1adL5gVljpfc4f4k0AvigrPiu78+W2hvoYf5dom4706qgDPWBEsp
 ONTnT5O5A+nELXu0Wl0pQ56zqK06R5yBHWt67i6xaqrKIBKERbhQIohhc4JATAzQC8jGaORg==
X-Received: by 2002:a17:907:802:b0:b9c:530b:7986 with SMTP id
 a640c23a62f3a-b9c67422988mr24737266b.6.1775167038411; 
 Thu, 02 Apr 2026 14:57:18 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:17 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 20/33] hw/arm: add generic ARM machine initialized by FDT
Date: Thu,  2 Apr 2026 23:56:05 +0200
Message-ID: <20260402215629.745866-21-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch introduces new ARM machine model, which is
fully instantiated from a Device Tree description.

This model uses fdt_generic framework to dynamically
construct system topology based on provided DTB, instead
of standard machines which rely on hardcoded models in
C files.

This allows to contruct machines with custom memory maps,
device structures without the need to modify and re-build
QEMU sources each time.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/arm_generic_fdt.c | 172 +++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |   2 +
 2 files changed, 174 insertions(+)
 create mode 100644 hw/arm/arm_generic_fdt.c

diff --git a/hw/arm/arm_generic_fdt.c b/hw/arm/arm_generic_fdt.c
new file mode 100644
index 0000000000..7b50957a82
--- /dev/null
+++ b/hw/arm/arm_generic_fdt.c
@@ -0,0 +1,172 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2012 Xilinx. Inc
+ * Copyright (c) 2012 Peter A.G. Crosthwaite (peter.crosthwaite@xilinx.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/core/boards.h"
+#include "hw/core/hw-error.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "qom/object.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+
+#include <libfdt.h>
+#include "hw/core/fdt_generic_util.h"
+
+#define QTEST_RUNNING (qtest_enabled() && qtest_driver())
+
+struct ARMGenericFDTState {
+    MachineState parent;
+
+    struct arm_boot_info bootinfo;
+
+    char *hw_dtb;
+};
+
+#define TYPE_ARM_GENERIC_FDT_MACHINE MACHINE_TYPE_NAME("arm-generic-fdt")
+
+OBJECT_DECLARE_SIMPLE_TYPE(ARMGenericFDTState, ARM_GENERIC_FDT_MACHINE)
+
+static void init_machine(void *fdt, ARMGenericFDTState *s)
+{
+    FDTMachineInfo *fdti;
+    MemoryRegion *mem_area;
+    Error *errp = NULL;
+    char **node_path;
+
+    node_path = qemu_fdt_node_unit_path(fdt, "memory", &errp);
+    if (errp) {
+        error_report_err(errp);
+        exit(1);
+    }
+    if (!node_path || !g_str_has_prefix(node_path[0], "/memory")) {
+        error_report("Failed to find /memory node");
+        exit(1);
+    }
+
+    /* Instantiate peripherals from the FDT.  */
+    fdti = fdt_generic_create_machine(fdt, NULL);
+
+    mem_area = MEMORY_REGION(object_resolve_path(node_path[0], NULL));
+
+    s->bootinfo.loader_start = object_property_get_int(OBJECT(mem_area),
+                                                            "addr", NULL);
+
+    s->bootinfo.ram_size = object_property_get_int(OBJECT(mem_area),
+                                                          "size", NULL);
+
+    fdt_init_destroy_fdti(fdti);
+    g_strfreev(node_path);
+}
+
+static void arm_generic_fdt_init(MachineState *machine)
+{
+    int fdt_size;
+    void *hw_fdt = NULL;
+    ARMGenericFDTState *s = ARM_GENERIC_FDT_MACHINE(machine);
+
+    if (!s->hw_dtb) {
+        if (!QTEST_RUNNING) {
+            /*
+             * Just return without error if running qtest, as we never have a
+             * device tree
+             */
+            hw_error("DTB must be specified for %s machine model\n",
+                     MACHINE_GET_CLASS(machine)->name);
+        }
+        return;
+    }
+
+    hw_fdt = load_device_tree(s->hw_dtb, &fdt_size);
+    if (!hw_fdt) {
+        error_report("Error: Unable to load Device Tree %s", s->hw_dtb);
+        exit(1);
+    }
+
+    init_machine(hw_fdt, s);
+
+    s->bootinfo.kernel_filename = machine->kernel_filename;
+    s->bootinfo.kernel_cmdline = machine->kernel_cmdline;
+    s->bootinfo.initrd_filename = machine->initrd_filename;
+    s->bootinfo.board_id = -1;
+    s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+
+    /*
+     * Expect a direct kernel boot if the '-kernel' option is specified.
+     * In this case, QEMU provides the PSCI implementation.
+     */
+    if (machine->kernel_filename) {
+        s->bootinfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    }
+
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &s->bootinfo);
+
+    return;
+}
+
+static char *arm_generic_fdt_get_hw_dtb(Object *obj, Error **errp)
+{
+    ARMGenericFDTState *s = ARM_GENERIC_FDT_MACHINE(obj);
+
+    return g_strdup(s->hw_dtb);
+}
+
+static void arm_generic_fdt_set_hw_dtb(Object *obj, const char *value,
+                                       Error **errp)
+{
+    ARMGenericFDTState *s = ARM_GENERIC_FDT_MACHINE(obj);
+
+    s->hw_dtb = g_strdup(value);
+}
+
+static void arm_generic_fdt_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "ARM device tree driven machine model";
+    mc->init = arm_generic_fdt_init;
+    mc->max_cpus = 64;
+    mc->default_cpus = 4;
+
+    mc->pci_allow_0_address = true;
+    mc->minimum_page_bits = 12;
+    mc->smp_props.clusters_supported = true;
+
+    object_class_property_add_str(oc, "hw-dtb",
+                              arm_generic_fdt_get_hw_dtb,
+                                  arm_generic_fdt_set_hw_dtb);
+    object_class_property_set_description(oc, "hw-dtb",
+                    "Hardware device-tree file with description "
+                                "used to create the emulated machine");
+}
+
+static const TypeInfo arm_generic_fdt_machine_info = {
+    .name           = TYPE_ARM_GENERIC_FDT_MACHINE,
+    .parent         = TYPE_MACHINE,
+    .instance_size  = sizeof(ARMGenericFDTState),
+    .class_init     = arm_generic_fdt_class_init,
+    .interfaces     = arm_machine_interfaces,
+};
+
+static void arm_generic_fdt_register_type(void)
+{
+    type_register_static(&arm_generic_fdt_machine_info);
+}
+
+type_init(arm_generic_fdt_register_type)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b187b946f0..e62fabbb6c 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,6 @@
 arm_ss = ss.source_set()
+arm_ss.add(files('arm_generic_fdt.c'))
+
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
-- 
2.43.0


