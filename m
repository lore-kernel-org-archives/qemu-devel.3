Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE1E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MH-0003zd-8n; Thu, 19 Feb 2026 09:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lp-0003k3-LV
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5Lc-00082t-Go
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:49:53 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4362d4050c1so1024335f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512581; x=1772117381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UYWT62sEHBxv5crU/HblRe1sAfAFjgx1BptkDY9LkA=;
 b=kKY2nR8Y4mK8gMzjWDzMU9lw3EYjBIMjS1wqtdzTtwYqYMfnYJGW1CitJUI5rv+o0o
 mRVn9SqbCulUD9y1F/boYfwPJP7fmFRXRUXguPKA3XRxkQQTzB0YaBBUc6HblGzqwvzU
 y5/5JOWd7fHtlVsW7JqySNpeAOGE7/rMR6CwgCUtm8jJX4O3jj2UwXOb+yELpwIjOSv6
 fM0MMXPVHWvJf+DSGsEX6FN5SsQYQvGrqb86S7eRVC5z9JmQnQC3+ZyFBBY621F6bPh6
 8Txu/5hIR4vR9+TxDR5bjRZqaebBS+NVsFTBjIbxdTPjFV/pcACsnHxniuHFdJGuqXKd
 6mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512581; x=1772117381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6UYWT62sEHBxv5crU/HblRe1sAfAFjgx1BptkDY9LkA=;
 b=mFn3jY2E1Uk7yo/0nbb4R2MiudVmHNeTC+rMZrbwNv6Lk3nfGiBhPL8FXECtO6Jce3
 vuks/fhK+ApTm0aautBM7rFCkmgrwPQxlg3RIYSF1sAHzFdB9EkLatRRr27+KUKmeKEa
 J5MMaWF6511o6NaT0GL66aQWeeLz0zi2f02OWObt9iOwjTyZbnLQz5C06qZfNJlYeRQZ
 gFzP+EHqGXdNxisMZvjyH+Q//OUgT7nwiiuHpDU24pKxqRAgmb6HQFAzWx41P8HjHspz
 DMdSti2G6vf89s8zP2C4hT5UcGNs8S7BEG3NGlgaGxchBu5X3S8QvfSEOi97TNNQ3/yB
 S9iw==
X-Gm-Message-State: AOJu0Yw3aCwGI8ZNX9woSAdI9CpGqxae2XE8wAEixg0M5qZs5lmAzolH
 qZz93/gV9FO44N2jowdgdF6rnWBm6lNVm82fL9NKP8LApoi/TjweDFuq5mthfnxQ
X-Gm-Gg: AZuq6aLFbPDrWEZfbpOUf3vwhj0bsRMsfWlmbcg+AhGAvca3yjmdxGwcLvrpys5DI9n
 kSoYOAeO96t50RU6cqhbg3CZLDA4/IVRlLtGiCeRqWU0kFuAnmGgRCPoiibMlamjEd5lrW6WG8X
 Xh4CzFmwpAkPvML/cbC4vFqFRzD5hMUZuwUPs7GPvPHQe4ZKdBQr8lgCoZmAB36lnF5PM4BGM5j
 wwRsqo5ucOXnUsbVdVbA1U8ozP0g3iWqXLTiVrH0exy9Ywe/wZeSFX1k5UT3WBn6Udxzs6oQAMk
 H7HxV1g7touTbHbUa97iSE3gIxir5lg+cn3Iccgq65JFT9LH2YGFrihpWobbZiwpRG71Jt3CzIp
 nh77HoabZRUoSdUGEiIihm7op7F6KV7lfcQDp1HdFs46mCYuPssU2e2awRu1x9/LD6/vhH3t/Fr
 an74HCTYMgtwhdcCw7vCcaFWFfGvvHw+8HylZMK7nbGg/Cwr2egtox+YHuEqz8nm6yypbYdSPES
 ahw0kA=
X-Received: by 2002:a05:6000:402b:b0:437:95d4:fcb3 with SMTP id
 ffacd0b85a97d-43797913ce2mr37609847f8f.36.1771512581176; 
 Thu, 19 Feb 2026 06:49:41 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:40 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 20/33] hw/arm: add generic ARM machine initialized by FDT
Date: Thu, 19 Feb 2026 15:48:48 +0100
Message-ID: <20260219144901.3317747-2-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 hw/arm/arm_generic_fdt.c | 180 +++++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build       |   2 +
 2 files changed, 182 insertions(+)
 create mode 100644 hw/arm/arm_generic_fdt.c

diff --git a/hw/arm/arm_generic_fdt.c b/hw/arm/arm_generic_fdt.c
new file mode 100644
index 0000000000..49206269aa
--- /dev/null
+++ b/hw/arm/arm_generic_fdt.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
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
+#include "hw/core/loader.h"
+#include "hw/core/hw-error.h"
+#include "qapi/error.h"
+#include "hw/block/flash.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "qemu/config-file.h"
+#include "qemu/option.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "hw/arm/boot.h"
+#include "hw/arm/machines-qom.h"
+
+#include <libfdt.h>
+#include "hw/core/fdt_generic_util.h"
+
+#define GENERAL_MACHINE_NAME "arm-generic-fdt"
+
+#define QTEST_RUNNING (qtest_enabled() && qtest_driver())
+
+#define SMP_BOOT_ADDR 0xfffffff0
+/* Meaningless, but keeps arm boot happy */
+#define SMP_BOOTREG_ADDR 0xfffffffc
+
+static struct arm_boot_info arm_generic_fdt_binfo = {};
+
+typedef struct {
+    ram_addr_t ram_kernel_base;
+    ram_addr_t ram_kernel_size;
+} memory_info;
+
+typedef struct {
+    int fdt_size;
+    char *dtb;
+} FdtBlob;
+
+FdtBlob sw_fdt;
+
+static memory_info init_memory(void *fdt, ram_addr_t ram_size)
+{
+    FDTMachineInfo *fdti;
+    MemoryRegion *mem_area;
+    memory_info kernel_info;
+    Error *errp = NULL;
+    char **node_path;
+
+    /* Find a memory node or add new one if needed */
+    node_path = qemu_fdt_node_unit_path(fdt, "memory", &errp);
+    if (errp) {
+        error_report_err(errp);
+        exit(1);
+    }
+    if (!g_str_has_prefix(node_path[0], "/memory")) {
+        error_report("Failed to find /memory node");
+        exit(1);
+    }
+
+    /* Instantiate peripherals from the FDT.  */
+    fdti = fdt_generic_create_machine(fdt, NULL);
+
+    mem_area = MEMORY_REGION(object_resolve_path(node_path[0], NULL));
+
+    kernel_info.ram_kernel_base = object_property_get_int(OBJECT(mem_area),
+                                                            "addr", NULL);
+
+    kernel_info.ram_kernel_size = object_property_get_int(OBJECT(mem_area),
+                                                          "size", NULL);
+
+    if (kernel_info.ram_kernel_size == -1) {
+        kernel_info.ram_kernel_size = ram_size;
+    }
+
+    fdt_init_destroy_fdti(fdti);
+    g_strfreev(node_path);
+
+    return kernel_info;
+}
+
+static void *get_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
+{
+    *fdt_size = sw_fdt.fdt_size;
+    return sw_fdt.dtb;
+}
+
+static void arm_generic_fdt_init(MachineState *machine)
+{
+    void *fdt = NULL;
+    int fdt_size;
+    const char *hw_dtb_arg, *dtb_arg;
+    memory_info kernel_info;
+
+    dtb_arg = machine->dtb;
+    hw_dtb_arg = machine->hw_dtb;
+    if (!dtb_arg && !hw_dtb_arg) {
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
+    /* Software dtb is always the -dtb arg */
+    if (dtb_arg) {
+        sw_fdt.dtb = load_device_tree(dtb_arg, &sw_fdt.fdt_size);
+        if (!sw_fdt.dtb) {
+            error_report("Error: Unable to load Device Tree %s", dtb_arg);
+            exit(1);
+        }
+    }
+
+    /* If the user provided a -hw-dtb, use it as the hw description.  */
+    if (hw_dtb_arg) {
+        fdt = load_device_tree(hw_dtb_arg, &fdt_size);
+        if (!fdt) {
+            error_report("Error: Unable to load Device Tree %s", hw_dtb_arg);
+            exit(1);
+        }
+    } else if (sw_fdt.dtb) {
+        fdt = sw_fdt.dtb;
+        fdt_size = sw_fdt.fdt_size;
+    }
+
+    kernel_info = init_memory(fdt, machine->ram_size);
+
+    arm_generic_fdt_binfo.get_dtb = get_ref_dtb;
+    arm_generic_fdt_binfo.ram_size = kernel_info.ram_kernel_size;
+    arm_generic_fdt_binfo.kernel_filename = machine->kernel_filename;
+    arm_generic_fdt_binfo.kernel_cmdline = machine->kernel_cmdline;
+    arm_generic_fdt_binfo.initrd_filename = machine->initrd_filename;
+    arm_generic_fdt_binfo.smp_loader_start = SMP_BOOT_ADDR;
+    arm_generic_fdt_binfo.smp_bootreg_addr = SMP_BOOTREG_ADDR;
+    arm_generic_fdt_binfo.board_id = 0xd32;
+    arm_generic_fdt_binfo.loader_start = kernel_info.ram_kernel_base;
+    arm_generic_fdt_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+
+    if (!machine->kernel_filename) {
+        arm_generic_fdt_binfo.firmware_loaded = true;
+        arm_generic_fdt_binfo.psci_conduit = QEMU_PSCI_CONDUIT_DISABLED;
+    }
+
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &arm_generic_fdt_binfo);
+
+    return;
+}
+
+static void arm_generic_fdt_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARM device tree driven machine model";
+    mc->init = arm_generic_fdt_init;
+    mc->max_cpus = 64;
+    mc->default_cpus = 4;
+
+    mc->pci_allow_0_address = true;
+    mc->minimum_page_bits = 12;
+    mc->smp_props.clusters_supported = true;
+
+}
+
+DEFINE_MACHINE_ARM("arm-generic-fdt", arm_generic_fdt_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 47cdc51d13..1ef0b8c2c1 100644
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


