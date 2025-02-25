Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAC6C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzL0-0001xk-BZ; Tue, 25 Feb 2025 13:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJA-0008L0-Pf
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ6-0002D6-V9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:28 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so56629465e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506723; x=1741111523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aW0zCtC8OIsiWYUh98kNB1SPvnD+Hi97ZoX3/5CmiFs=;
 b=lkmpWJr3SwEHf2TXCR3ULrJXjy+Ipms1n34L9gnKoXBrksBbvDj+uGuZraEn9JlSW1
 vLpQILWK+UDEC99s6c+8cTJGy5BxZlJ3aQPGobnLCwM+5cvOeenmGTG7jYcMYhmIuCIX
 PHThQuQTxnZueeG640/B53i/kH/PnwGe88M47nLfOKVmrEupdE5CDVsaQdItdvLBsPLQ
 cEe8z4DQIHbjJmrhxYDg4Rk/IOjsNFKMHO9GmxXpLozAwCAOJW2vbYTo1k/Cy30Ri6wh
 EZhY5KsrYY/9MQ/bHcQdBL8U8NEei0ZUx5OtToxvVv8VQLStivdCu3L7E2H7PkvXQdom
 Jozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506723; x=1741111523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aW0zCtC8OIsiWYUh98kNB1SPvnD+Hi97ZoX3/5CmiFs=;
 b=Yg3yazWT/oTjYjemFo0K68l/wRwyoZxfVV1/mXum8Cqz89U41RO/BH4kvFsmxrEH32
 F30yByRnfPKnCJkRYP/x0XeLEBlU3pSjMd9q0IVkZMqnxV/1dMxXSQiNUtMvYO3O7H1u
 TwHG229DPGUwKSUWEjfHOiPMojNT1PtX/rzsFImN3RyMnwqUPDcapjBd1aQX/z/t9Xqi
 Ww0fUx/b9PycXBPhhTEujkpypgU8Porx7HZQrWn9ruVyo4tZ4MsO1440p3TDNe8ctqh1
 2wZxRFcNizCLcNenSTbeynyTmre1wUeh9A7Y7HCwoTpRwwtpt5l1drIPboAk2vbEBTNa
 aiKQ==
X-Gm-Message-State: AOJu0Yzk5F7EzzFd82gjgd7nU27XBbGApybZYA4A5SLgJPcGTs7nEYcx
 +i7KyM+kVXCT4cmblHuoQKLCJ6dhUaDtAwNyjapHEUUBrezCyp27XrUVQy2fcoDKw0EFLYbgLS3
 3
X-Gm-Gg: ASbGnctz6SwtAxNG/Y7TPPE4IszNZaQr7xf8cm3Bp04El4do0gklvtiIF+YV9Z2A2SX
 ldYaoGjZq0s6mZWMfE6ebNksxjD7jSJP1EGqaJLNU5cbSGikE7s/UG7mgcewBEPBzRsUy/KjAVD
 k79TzPgtxxiCiwh9G8fq+gqYbA4Gb6avM5VFTQH9DyY4BUCzd9ol7Km/QVeBYsp+/G1CmfM6Lx+
 00wPwfd5ee6RyE56yabw87nGfxUzovWV/Iny59u5wMFJH/ZOE1yqxIJW+nWXoUjvZ8YzydaupC9
 cM8egdbTAC5Y6A8qTzCikHcSq+D6cQUL
X-Google-Smtp-Source: AGHT+IGWoKiglTcinLu0taRMZbW+PXards+Dc/Z5XxOg9JpzsUW8V5PxTGyyjeUDuqkqE6p6VvbXow==
X-Received: by 2002:a05:6000:18a2:b0:38f:50bd:ad11 with SMTP id
 ffacd0b85a97d-38f707840afmr14380506f8f.5.1740506721547; 
 Tue, 25 Feb 2025 10:05:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/43] hw: Centralize handling of -machine dumpdtb option
Date: Tue, 25 Feb 2025 18:04:33 +0000
Message-ID: <20250225180510.1318207-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Currently we handle the 'dumpdtb' machine sub-option ad-hoc in every
board model that has an FDT.  It's up to the board code to make sure
it calls qemu_fdt_dumpdtb() in the right place.

This means we're inconsistent and often just ignore the user's
command line argument:
 * if the board doesn't have an FDT at all
 * if the board supports FDT, but there happens not to be one
   present (usually because of a missing -fdt option)

This isn't very helpful because it gives the user no clue why their
option was ignored.

However, in order to support the QMP/HMP dumpdtb commands we require
now that every FDT machine stores a pointer to the FDT in
MachineState::fdt.  This means we can handle -machine dumpdtb
centrally by calling the qmp_dumpdtb() function, unifying its
handling with the QMP/HMP commands.  All the board code calls to
qemu_fdt_dumpdtb() can then be removed.

For this commit we retain the existing behaviour that if there
is no FDT we silently ignore the -machine dumpdtb option.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/device_tree.h  |  2 --
 hw/arm/boot.c                 |  2 --
 hw/core/machine.c             | 25 +++++++++++++++++++++++++
 hw/loongarch/virt-fdt-build.c |  1 -
 hw/mips/boston.c              |  1 -
 hw/openrisc/boot.c            |  1 -
 hw/ppc/e500.c                 |  1 -
 hw/ppc/pegasos2.c             |  1 -
 hw/ppc/pnv.c                  |  1 -
 hw/ppc/spapr.c                |  1 -
 hw/riscv/boot.c               |  2 --
 system/device_tree.c          | 15 ---------------
 12 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/include/system/device_tree.h b/include/system/device_tree.h
index eb601522f88..49d8482ed4e 100644
--- a/include/system/device_tree.h
+++ b/include/system/device_tree.h
@@ -133,8 +133,6 @@ int qemu_fdt_add_path(void *fdt, const char *path);
                          sizeof(qdt_tmp));                                    \
     } while (0)
 
-void qemu_fdt_dumpdtb(void *fdt, int size);
-
 /**
  * qemu_fdt_setprop_sized_cells_from_array:
  * @fdt: device tree blob
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 42c18355e85..e296b62fa12 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -661,8 +661,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         binfo->modify_dtb(binfo, fdt);
     }
 
-    qemu_fdt_dumpdtb(fdt, size);
-
     /* Put the DTB into the memory map as a ROM image: this will ensure
      * the DTB is copied again upon reset, even if addr points into RAM.
      */
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 02cff735b3f..61c22f723a0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qemu/madvise.h"
 #include "qom/object_interfaces.h"
 #include "system/cpus.h"
@@ -1696,6 +1697,24 @@ void qemu_remove_machine_init_done_notifier(Notifier *notify)
     notifier_remove(notify);
 }
 
+static void handle_machine_dumpdtb(MachineState *ms)
+{
+    if (!ms->dumpdtb) {
+        return;
+    }
+    if (!ms->fdt) {
+        /* Silently ignore dumpdtb option if there is nothing to dump */
+        return;
+    }
+#ifdef CONFIG_FDT
+    qmp_dumpdtb(ms->dumpdtb, &error_fatal);
+    exit(0);
+#else
+    error_report("This machine doesn't have an FDT");
+    exit(1);
+#endif
+}
+
 void qdev_machine_creation_done(void)
 {
     cpu_synchronize_all_post_init();
@@ -1712,6 +1731,12 @@ void qdev_machine_creation_done(void)
     phase_advance(PHASE_MACHINE_READY);
     qdev_assert_realized_properly();
 
+    /*
+     * If the user used -machine dumpdtb=file.dtb to request that we
+     * dump the DTB to a file,  do it now, and exit.
+     */
+    handle_machine_dumpdtb(current_machine);
+
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     /*
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index dbc269afba4..728ce466996 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -527,7 +527,6 @@ void virt_fdt_setup(LoongArchVirtMachineState *lvms)
      * Put the FDT into the memory map as a ROM image: this will ensure
      * the FDT is copied again upon reset, even if addr points into RAM.
      */
-    qemu_fdt_dumpdtb(machine->fdt, lvms->fdt_size);
     rom_add_blob_fixed_as("fdt", machine->fdt, lvms->fdt_size, FDT_BASE,
                           &address_space_memory);
     qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 79410dabe7f..149a263bd5a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -395,7 +395,6 @@ static void *boston_fdt_filter(void *opaque, const void *fdt_orig,
                         1, ram_high_sz);
 
     fdt = g_realloc(fdt, fdt_totalsize(fdt));
-    qemu_fdt_dumpdtb(fdt, fdt_sz);
 
     s->fdt_base = *load_addr;
 
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 72e2756af05..0a5881be314 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -109,7 +109,6 @@ uint32_t openrisc_load_fdt(MachineState *ms, void *fdt,
     /* Should only fail if we've built a corrupted tree */
     g_assert(ret == 0);
     /* copy in the device tree */
-    qemu_fdt_dumpdtb(fdt, fdtsize);
 
     /* Save FDT for dumpdtb monitor command */
     ms->fdt = fdt;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 26933e0457e..fe8b9f79621 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -658,7 +658,6 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
 
 done:
     if (!dry_run) {
-        qemu_fdt_dumpdtb(fdt, fdt_size);
         cpu_physical_memory_write(addr, fdt, fdt_size);
 
         /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index b057672e829..246d6d633b5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -417,7 +417,6 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
     qemu_fdt_setprop(fdt, "/chosen", "qemu,boot-kernel", d, sizeof(d));
 
-    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     g_free(pm->fdt_blob);
     pm->fdt_blob = fdt;
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71b..87607508c76 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -744,7 +744,6 @@ static void pnv_reset(MachineState *machine, ResetType type)
         _FDT((fdt_pack(fdt)));
     }
 
-    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 
     /* Update machine->fdt with latest fdt */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f3a4b4235d4..c15340a58d8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1760,7 +1760,6 @@ static void spapr_machine_reset(MachineState *machine, ResetType type)
                                   0, fdt_addr, 0);
         cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
     }
-    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
 
     g_free(spapr->fdt_blob);
     spapr->fdt_size = fdt_totalsize(fdt);
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c309441b7d8..765b9e2b1ab 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -374,8 +374,6 @@ void riscv_load_fdt(hwaddr fdt_addr, void *fdt)
     uint32_t fdtsize = fdt_totalsize(fdt);
 
     /* copy in the device tree */
-    qemu_fdt_dumpdtb(fdt, fdtsize);
-
     rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
                           &address_space_memory);
     qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
diff --git a/system/device_tree.c b/system/device_tree.c
index 4bc2d61b934..d605ed2a217 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -594,21 +594,6 @@ int qemu_fdt_add_path(void *fdt, const char *path)
     return retval;
 }
 
-void qemu_fdt_dumpdtb(void *fdt, int size)
-{
-    const char *dumpdtb = current_machine->dumpdtb;
-
-    if (dumpdtb) {
-        /* Dump the dtb to a file and quit */
-        if (g_file_set_contents(dumpdtb, fdt, size, NULL)) {
-            info_report("dtb dumped to %s. Exiting.", dumpdtb);
-            exit(0);
-        }
-        error_report("%s: Failed dumping dtb to %s", __func__, dumpdtb);
-        exit(1);
-    }
-}
-
 int qemu_fdt_setprop_sized_cells_from_array(void *fdt,
                                             const char *node_path,
                                             const char *property,
-- 
2.43.0


