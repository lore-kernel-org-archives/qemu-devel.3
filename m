Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F34CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23aW-0001Tp-6k; Fri, 26 Sep 2025 04:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23a0-0000qs-Aq; Fri, 26 Sep 2025 04:13:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Zq-0000np-AV; Fri, 26 Sep 2025 04:13:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 75038157D5D;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8470D290C41;
 Fri, 26 Sep 2025 11:10:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 21/60] hw/ppc: Fix build error with CONFIG_POWERNV
 disabled
Date: Fri, 26 Sep 2025 11:09:49 +0300
Message-ID: <20250926081031.2214971-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

Currently when CONFIG_POWERNV is not enabled, the build fails, such as
with --without-default-devices:

    $ ./configure --without-default-devices
    $ make

    [281/283] Linking target qemu-system-ppc64
    FAILED: qemu-system-ppc64
    cc -m64 @qemu-system-ppc64.rsp
    /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_load_sprd':
    .../target/ppc/misc_helper.c:335:(.text+0xcdc): undefined reference to `pnv_chip_find_core'
    /usr/bin/ld: libqemu-ppc64-softmmu.a.p/target_ppc_misc_helper.c.o: in function `helper_store_sprd':
    .../target/ppc/misc_helper.c:375:(.text+0xdf4): undefined reference to `pnv_chip_find_core'
    collect2: error: ld returned 1 exit status
    ...

This is since target/ppc/misc_helper.c references PowerNV specific
'pnv_chip_find_core' call.

Split the PowerNV specific SPRD code out of the generic PowerPC code, by
moving the SPRD code to pnv.c

Fixes: 9808ce6d5cb ("target/ppc: Big-core scratch register fix")
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250820122516.949766-2-adityag@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 46d03bb23dde86513465724760d85f42eb17539e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d84c9067ed..9c74f46091 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
+#include "qemu/log.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
@@ -1794,12 +1795,83 @@ static void pnv_chip_power9_pec_realize(PnvChip *chip, Error **errp)
     }
 }
 
+static uint64_t pnv_handle_sprd_load(CPUPPCState *env)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    uint64_t sprc = env->spr[SPR_POWER_SPRC];
+
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        return pc->scratch[(sprc >> 3) & 0x7];
+
+    case 0x1e0: /* core thread state */
+        if (env->excp_model == POWERPC_EXCP_POWER9) {
+            /*
+             * Only implement for POWER9 because skiboot uses it to check
+             * big-core mode. Other bits are unimplemented so we would
+             * prefer to get unimplemented message on POWER10 if it were
+             * used anywhere.
+             */
+            if (pc->big_core) {
+                return PPC_BIT(63);
+            } else {
+                return 0;
+            }
+        }
+        /* fallthru */
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+    return 0;
+}
+
+static void pnv_handle_sprd_store(CPUPPCState *env, uint64_t val)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    uint64_t sprc = env->spr[SPR_POWER_SPRC];
+    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
+    int nr;
+
+    if (pc->big_core) {
+        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    }
+
+    switch (sprc & 0x3e0) {
+    case 0: /* SCRATCH0-3 */
+    case 1: /* SCRATCH4-7 */
+        /*
+         * Log stores to SCRATCH, because some firmware uses these for
+         * debugging and logging, but they would normally be read by the BMC,
+         * which is not implemented in QEMU yet. This gives a way to get at the
+         * information. Could also dump these upon checkstop.
+         */
+        nr = (sprc >> 3) & 0x7;
+        pc->scratch[nr] = val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+}
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     Pnv9Chip *chip9 = PNV9_CHIP(dev);
     PnvChip *chip = PNV_CHIP(dev);
     Pnv9Psi *psi9 = &chip9->psi;
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *cpu_class;
     Error *local_err = NULL;
     int i;
 
@@ -1827,6 +1899,12 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Set handlers for Special registers, such as SPRD */
+    cpu = chip->cores[0]->threads[0];
+    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
+    cpu_class->load_sprd = pnv_handle_sprd_load;
+    cpu_class->store_sprd = pnv_handle_sprd_store;
+
     /* XIVE interrupt controller (POWER9) */
     object_property_set_int(OBJECT(&chip9->xive), "ic-bar",
                             PNV9_XIVE_IC_BASE(chip), &error_fatal);
@@ -2078,6 +2156,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
     PnvChip *chip = PNV_CHIP(dev);
     Pnv10Chip *chip10 = PNV10_CHIP(dev);
+    PowerPCCPU *cpu;
+    PowerPCCPUClass *cpu_class;
     Error *local_err = NULL;
     int i;
 
@@ -2105,6 +2185,12 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Set handlers for Special registers, such as SPRD */
+    cpu = chip->cores[0]->threads[0];
+    cpu_class = POWERPC_CPU_GET_CLASS(cpu);
+    cpu_class->load_sprd = pnv_handle_sprd_load;
+    cpu_class->store_sprd = pnv_handle_sprd_store;
+
     /* XIVE2 interrupt controller (POWER10) */
     object_property_set_int(OBJECT(&chip10->xive), "ic-bar",
                             PNV10_XIVE2_IC_BASE(chip), &error_fatal);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 6b90543811..0e26e4343d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1522,6 +1522,10 @@ struct PowerPCCPUClass {
     void (*init_proc)(CPUPPCState *env);
     int  (*check_pow)(CPUPPCState *env);
     int  (*check_attn)(CPUPPCState *env);
+
+    /* Handlers to be set by the machine initialising the chips */
+    uint64_t (*load_sprd)(CPUPPCState *env);
+    void (*store_sprd)(CPUPPCState *env, uint64_t val);
 };
 
 static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index e7d9462518..0e625cbb70 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -328,69 +328,22 @@ target_ulong helper_load_sprd(CPUPPCState *env)
      * accessed by powernv machines.
      */
     PowerPCCPU *cpu = env_archcpu(env);
-    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
-    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    if (pc->big_core) {
-        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
+    if (pcc->load_sprd) {
+        return pcc->load_sprd(env);
     }
 
-    switch (sprc & 0x3e0) {
-    case 0: /* SCRATCH0-3 */
-    case 1: /* SCRATCH4-7 */
-        return pc->scratch[(sprc >> 3) & 0x7];
-
-    case 0x1e0: /* core thread state */
-        if (env->excp_model == POWERPC_EXCP_POWER9) {
-            /*
-             * Only implement for POWER9 because skiboot uses it to check
-             * big-core mode. Other bits are unimplemented so we would
-             * prefer to get unimplemented message on POWER10 if it were
-             * used anywhere.
-             */
-            if (pc->big_core) {
-                return PPC_BIT(63);
-            } else {
-                return 0;
-            }
-        }
-        /* fallthru */
-
-    default:
-        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
-                                  TARGET_FMT_lx"\n", sprc);
-        break;
-    }
     return 0;
 }
 
 void helper_store_sprd(CPUPPCState *env, target_ulong val)
 {
-    target_ulong sprc = env->spr[SPR_POWER_SPRC];
     PowerPCCPU *cpu = env_archcpu(env);
-    PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
-    int nr;
-
-    if (pc->big_core) {
-        pc = pnv_chip_find_core(pc->chip, CPU_CORE(pc)->core_id & ~0x1);
-    }
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
-    switch (sprc & 0x3e0) {
-    case 0: /* SCRATCH0-3 */
-    case 1: /* SCRATCH4-7 */
-        /*
-         * Log stores to SCRATCH, because some firmware uses these for
-         * debugging and logging, but they would normally be read by the BMC,
-         * which is not implemented in QEMU yet. This gives a way to get at the
-         * information. Could also dump these upon checkstop.
-         */
-        nr = (sprc >> 3) & 0x7;
-        pc->scratch[nr] = val;
-        break;
-    default:
-        qemu_log_mask(LOG_UNIMP, "mtSPRD: Unimplemented SPRC:0x"
-                                  TARGET_FMT_lx"\n", sprc);
-        break;
+    if (pcc->store_sprd) {
+        return pcc->store_sprd(env, val);
     }
 }
 
-- 
2.47.3


