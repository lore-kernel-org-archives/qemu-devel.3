Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666D2CD4F39
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuKy-00013c-Bp; Tue, 12 May 2026 17:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJe-000870-7e; Tue, 12 May 2026 17:07:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJb-0001xI-Vg; Tue, 12 May 2026 17:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=MvMxfg/awm4QKSSpC+nVhMXM7Vz8ngt1ifX4OKpmZ7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UgUsAXj+WkIz8nSjvR210XajqneWehmyWhVHI7+EJoc/6l5XgeDkiYMNdjaQ97d3C
 7Lsg53nubezdQJTtDuGBNbpjliIoEbvf+63iMgpwXzuPOnjXtdzTHWT9KnKOQ3NbJ1
 vjqc/KnZvpJJ5MRRU2heJvSk9+LSUZXQC4ylaxXfRGBOPrzCYwCLTDVlgBy4zAoYqw
 7JZeylz9rFM2wRN+1O+ZXzJ1DQ6N1tn+YyBy5AEMLz2iBU7FaKx/c1ODgITno3L1dG
 F2vE9fpU3rD84hkGKiWqM1ryY5c5wEl4rmb9u15T+VHLFpoY3+3l+SW/J40jqYbRvJ
 wYeJ9cTfBy7pw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 89CD11AA348;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F0003ABCB9;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Nathan Chancellor <nathan@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 012/117] ppc/pnv: generate dtb after machine
 initialization is complete
Date: Tue, 12 May 2026 23:53:14 +0300
Message-ID: <20260512205503.361097-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Shivang Upadhyay <shivangu@linux.ibm.com>

Currently, the machine dtb is generated in pnv_init(), before all devices
are fully initialized. This can result in an incomplete dtb for the system,
as seen in bug [1].

Fix this by deferring dtb generation until machine initialization is complete,
using the machine_init_done_notifier hook.

[1] https://lore.kernel.org/all/20260323231612.GA2637687@ax162/

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-stable@nongnu.org
Reported-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: a16d4c2f162a86d ("ppc/pnv: fix dumpdtb option")
Fixes: 43ed0362d0b2c4c ("ppc/pnv: fix dumpdtb option") in 10.2.x series
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260327124136.983955-1-shivangu@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit ba48bff09fa1fea8030eb26f2bc0add8c3549bb7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e8a12d87c4..090716b1ff 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -747,31 +747,10 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
 
 static void pnv_reset(MachineState *machine, ResetType type)
 {
-    PnvMachineState *pnv = PNV_MACHINE(machine);
-    IPMIBmc *bmc;
     void *fdt;
 
     qemu_devices_reset(type);
 
-    /*
-     * The machine should provide by default an internal BMC simulator.
-     * If not, try to use the BMC device that was provided on the command
-     * line.
-     */
-    bmc = pnv_bmc_find(&error_fatal);
-    if (!pnv->bmc) {
-        if (!bmc) {
-            if (!qtest_enabled()) {
-                warn_report("machine has no BMC device. Use '-device "
-                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
-                            "to define one");
-            }
-        } else {
-            pnv_bmc_set_pnor(bmc, pnv->pnor);
-            pnv->bmc = bmc;
-        }
-    }
-
     fdt = machine->fdt;
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
@@ -983,6 +962,37 @@ static uint64_t pnv_chip_get_ram_size(PnvMachineState *pnv, int chip_id)
     return chip_id == 0 ? 1 * GiB : QEMU_ALIGN_DOWN(ram_per_chip, 1 * MiB);
 }
 
+static void pnv_machine_init_done(Notifier *notifier, void *data)
+{
+    PnvMachineState *pnv = container_of(notifier, PnvMachineState, machine_init_done);
+    MachineState *machine = MACHINE(pnv);
+    IPMIBmc *bmc;
+
+    /*
+     * The machine should provide by default an internal BMC simulator.
+     * If not, try to use the BMC device that was provided on the command
+     * line.
+     */
+    bmc = pnv_bmc_find(&error_fatal);
+    if (!pnv->bmc) {
+        if (!bmc) {
+            if (!qtest_enabled()) {
+                warn_report("machine has no BMC device. Use '-device "
+                            "ipmi-bmc-sim,id=bmc0 -device isa-ipmi-bt,bmc=bmc0,irq=10' "
+                            "to define one");
+            }
+        } else {
+            pnv_bmc_set_pnor(bmc, pnv->pnor);
+            pnv->bmc = bmc;
+        }
+    }
+
+    if (!machine->fdt) {
+        machine->fdt = pnv_dt_create(machine);
+        _FDT((fdt_pack(machine->fdt)));
+    }
+}
+
 static void pnv_init(MachineState *machine)
 {
     const char *bios_name = machine->firmware ?: FW_FILE_NAME;
@@ -1243,10 +1253,8 @@ static void pnv_init(MachineState *machine)
         pmc->i2c_init(pnv);
     }
 
-    if (!machine->fdt) {
-        machine->fdt = pnv_dt_create(machine);
-        _FDT((fdt_pack(machine->fdt)));
-    }
+    pnv->machine_init_done.notify = pnv_machine_init_done;
+    qemu_add_machine_init_done_notifier(&pnv->machine_init_done);
 }
 
 /*
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index cbdddfc73c..574861ce03 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -111,6 +111,8 @@ struct PnvMachineState {
 
     bool         big_core;
     bool         lpar_per_core;
+
+    Notifier     machine_init_done;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
-- 
2.47.3


