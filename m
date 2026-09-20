Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39860C982E1
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8G8f-0006Wz-FE; Sun, 20 Sep 2026 07:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8c-0006Vi-H8; Sun, 20 Sep 2026 07:55:18 -0400
Received: from inva020.nxp.com ([92.121.34.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1x8G8Z-0001bG-CT; Sun, 20 Sep 2026 07:55:18 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E80D41A001A;
 Sun, 20 Sep 2026 13:55:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 894B91A0018;
 Sun, 20 Sep 2026 13:55:13 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 9AA7F180006C;
 Sun, 20 Sep 2026 19:55:11 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 shentey@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv3 06/10] hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
Date: Sun, 20 Sep 2026 17:24:54 +0530
Message-Id: <20260920115458.481605-7-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
References: <20260920115458.481605-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.13;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva020.nxp.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

Configure the i.MX8MP to boot the Cortex-M7 core alongside
the Cortex-A53 cores in an Asymmetric Multiprocessing (AMP)
configuration. The M7 firmware can be loaded and started from Linux
running on the A53 cores via the remoteproc framework.

CM7 boot is made optional. A GPR IRQ is connected to a cpuwait handler.
The handler translates the CPUWAIT into STOP and RUN.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8m.rst   | 184 +++++++++++++++++++++++++++++++++++-
 hw/arm/fsl-imx8mp.c         | 116 ++++++++++++++++++-----
 include/hw/arm/fsl-imx8mp.h |  10 +-
 3 files changed, 286 insertions(+), 24 deletions(-)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index cdf862a456..95fd27ec5c 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` and ``imx8mm-evk`` machines implement the
 following devices:
 
  * Up to 4 Cortex-A53 cores
+ * 1 Cortex-M7 core (``imx8mp-evk`` only)
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
  * 3 USDHC Storage Controllers
@@ -37,6 +38,187 @@ Boot options
 The ``imx8mp-evk`` and ``imx8mm-evk`` machines can start a Linux
 kernel directly using the standard ``-kernel`` functionality.
 
+
+Asymmetric Multiprocessing (AMP) Boot Recipe (``imx8mp-evk`` only)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``imx8mp-evk`` machine includes a Cortex-M7 core alongside the
+Cortex-A53 cores, enabling Asymmetric Multiprocessing (AMP). The M7
+firmware can be loaded from Linux using the remoteproc framework.
+
+There are 2 control paths for Cortex-M7 on iMX8MP:-
+1. Firmware-mediated (via SMC/ATF)
+2. MMIO driven path (via SRC and GPR access)
+
+``fsl,imx8mp-cm7-mmio`` exists specifically to select the MMIO path and avoid dependence on firmware interfaces that aren’t guaranteed in qemu.
+This mode uses the SRC syscon block and the IOMUXC GPR for start/stop control.
+
+Memory carveouts for resource table, vrings need to be specified in the ``imx8mp-evk-rpmsg.dts``.
+Follow this application note to make the necessary changes - https://www.nxp.com/docs/en/application-note/AN5317.pdf
+
+When Linux boots CM7 via remoteproc, the typical flow is:
+
+1. Linux booted with imx8mp-evk-rpmsg.dtb
+2. Linux loads the CM7 ELF into a reserved DDR region
+3. Linux toggles the CM7 start/stop control (SRC/GPR CPUWAIT, etc.)
+4. CM7 starts executing from that DDR entry
+
+
+Prerequisites
+~~~~~~~~~~~~~
+
+To manually test Cortex-M7 firmware loading from Linux, the following
+components are needed:
+
+1. Linux kernel configuration to enable i.MX remoteproc support.
+2. ``imx8mp-evk-rpmsg.dtb`` -  device tree that enables the Cortex-M7 remoteproc node, reserves DDR memory regions
+   for the Cortex-M7 firmware, resource table,vrings and buffers.
+3. A Cortex-M7 ELF firmware image linked to execute from DDR.
+
+NXP application note AN5317 describes the required remoteproc and reserved-memory setup
+for loading Cortex-M firmware from Linux.
+
+
+Linux kernel configuration
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The guest kernel needs remoteproc support. On official linux-imx kernels, this support is enabled by default.
+When using Buildroot, verify that the kernel configuration enables the remoteproc and rpmsg options needed by the
+i.MX remoteproc driver, for example:
+
+.. code-block:: none
+
+  CONFIG_REMOTEPROC=y
+  CONFIG_IMX_REMOTEPROC=y
+  CONFIG_RPMSG=y
+  CONFIG_VIRTIO_RPMSG_BUS=y
+  CONFIG_RPMSG_CHAR=y
+
+Depending on the kernel version and configuration, some options may be selected
+automatically by the i.MX remoteproc driver.
+
+
+
+Device tree preparation
+~~~~~~~~~~~~~~~~~~~~~~~
+
+1. Refer to ``9.1 i.MX Linux rproc support`` of application note AN5317 to add the
+   following nodes in ``imx8mp-evk-rpmsg.dts`` :-
+
+   m7_ddr_alias
+   m7_itcm
+   m7_dtcm
+
+2. Modify the compatible string of ``imx8mp-cm7`` node from ``fsl,imx8mn-cm7`` to ``fsl,imx8mp-cm7-mmio``
+3. Add the following properties to the ``imx8mp-cm7`` node :-
+
+   ``syscon = <&src>;``
+   ``fsl,iomuxc-gpr = <&gpr>;``
+
+   These references are needed by imx_rproc_mmio_detect_mode in i.MX remoteproc driver
+   for M7 boot mode detection.
+
+
+   Build ``imx8mp-evk-rpmsg.dtb`` from the above dts changes.
+
+
+
+Building a Cortex-M7 ELF firmware
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A simple manual test is the MCUXpresso SDK UART polling example for the i.MX8MP
+EVK. It prints to a UART and is therefore easy to observe from QEMU.
+
+1. Follow this guide to set up MCUXpresso SDK for i.MX8MPEVK :- MCUXSDKIMX8MPGSUG[https://share.google/qD4D09FCkkydTurqp]
+2. Build a DDR-linked Cortex-M7 ELF using the ARM GNU toolchain from the MCUXpresso SDK:-
+
+
+.. code-block:: bash
+
+  $ cd ${MCUX_SDK}/boards/evkmimx8mp/driver_examples/uart/polling/armgcc
+  $ ./build_ddr_release.sh
+
+As a result, ``iuart_polling_cm7.elf`` will be generated  in ``ddr_release`` folder.
+
+Boot qemu i.MX8MP EVK machine with the updated linux kernel and ``imx8mp-evk-rpmsg.dtb``
+
+3. Copy the ``iuart_polling_cm7.elf`` to ``/lib/firmware/`` path inside iMX8MPEVK qemu emulation.
+
+
+Serial ports (UARTs)
+''''''''''''''''''''
+
+The i.MX 8M Plus EVK model provides four UARTs. QEMU connects each UART to a
+host character backend using the ``-serial`` option. This option can be used
+multiple times to create and wire multiple serial ports.
+
+The ``-serial`` options are positional:
+
+* the 1st ``-serial ...`` maps to ``serial0`` (UART1)
+* the 2nd ``-serial ...`` maps to ``serial1`` (UART2)
+* the 3rd ``-serial ...`` maps to ``serial2`` (UART3)
+* the 4th ``-serial ...`` maps to ``serial3`` (UART4)
+
+Example usage:- To enable serial console for the official M7 mcuxpresso sdk driver example - driver_examples/uart/polling which uses UART4, use:-
+
+.. code-block:: bash
+
+  -serial null -serial stdio -serial null -serial pty:/tmp/imx8mp-uart4
+
+This will create a symlink /tmp/imx8mp-uart4 pointed to the allocated PTY. On a different tab the console for UART4 can be opened using the following:-
+
+.. code-block:: bash
+
+  $ screen /tmp/imx8mp-uart4 115200
+
+
+Starting QEMU for Cortex-M7 remoteproc testing
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+1. Execute the following command to start i.MX8MPEVK emulation:-
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M imx8mp-evk \
+      -display none -serial null -serial stdio -serial null -serial /tmp/imx8mp-uart4 \
+      -kernel Image \
+      -dtb imx8mp-evk-rpmsg.dtb \
+      -append "root=/dev/mmcblk2p2" \
+      -drive file=sdcard.img,if=sd,bus=2,format=raw,id=mmcblk2
+
+2. On a new tab execute the following to open a console:-
+
+.. code-block:: bash
+
+  $ screen /tmp/imx8mp-uart4 115200
+
+3. Execute the following commands inside emulation to load the firmware elf:-
+
+.. code-block:: bash
+
+   $ echo iuart_polling_cm7.elf > /sys/class/remoteproc/remoteproc0/firmware
+   $ echo start > /sys/class/remoteproc/remoteproc0/state
+
+
+On the tab where the console is opened, you will observe the UART logs. The characters
+typed from the keyboard will echo on the console.
+
+
+Note:-
+
+Only DDR-linked bare-metal ELF images are currently supported by QEMU
+emulation. If the firmware is linked for a vector table base address other than
+``0x80000000``, configure the Cortex-M7 vector base using the SoC property
+``cm7-vector-base``:-
+
+.. code-block:: bash
+
+  -global fsl-imx8mp.cm7-vector-base=0x80000000
+
+If this property is not provided, QEMU uses ``0x80000000`` by default.
+
+
+
 Direct Linux Kernel Boot
 ''''''''''''''''''''''''
 
@@ -73,7 +255,7 @@ For i.MX 8M Plus EVK:
 .. code-block:: bash
 
   $ qemu-system-aarch64 -M imx8mp-evk \
-      -display none -serial null -serial stdio \
+      -display none -serial null -serial stdio -serial null -serial /tmp/imx8mp-uart4 \
       -kernel Image \
       -dtb imx8mp-evk.dtb \
       -append "root=/dev/mmcblk2p2" \
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 2d5b5f3870..cea8be7b71 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -12,6 +12,8 @@
 #include "system/address-spaces.h"
 #include "hw/arm/bsa.h"
 #include "hw/arm/fsl-imx8mp.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/core/boards.h"
 #include "system/kvm.h"
@@ -21,6 +23,9 @@
 #include "target/arm/kvm_arm.h"
 #include "qapi/error.h"
 #include "qobject/qlist.h"
+#include "target/arm/arm-powerctl.h"
+
+#define IMX8MP_NUM_A53 4
 
 static const struct {
     hwaddr addr;
@@ -196,6 +201,8 @@ static void fsl_imx8mp_init(Object *obj)
     FslImx8mpState *s = FSL_IMX8MP(obj);
     int i;
 
+    object_initialize_child(obj, "cm7", &s->cm7, TYPE_ARMV7M);
+
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -282,21 +289,15 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
-        error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
-                   TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp.cpus);
-        return;
-    }
-
-    for (i = 0; i < ms->smp.cpus; i++) {
+    for (i = 0; i < IMX8MP_NUM_A53; i++) {
         g_autofree char *name = g_strdup_printf("cpu%d", i);
         object_initialize_child(OBJECT(dev), name, &s->cpu[i], cpu_type);
     }
 
     /* CPUs */
-    for (i = 0; i < ms->smp.cpus; i++) {
+    for (i = 0; i < IMX8MP_NUM_A53; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-        if (ms->smp.cpus > 1 &&
+        if (IMX8MP_NUM_A53 > 1 &&
                 object_property_find(OBJECT(&s->cpu[i]), "reset-cbar")) {
             object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
                                     fsl_imx8mp_memmap[FSL_IMX8MP_GIC_DIST].addr,
@@ -339,11 +340,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         QList *redist_region_count;
         bool pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
 
-        qdev_prop_set_uint32(gicdev, "num-cpu", ms->smp.cpus);
+        qdev_prop_set_uint32(gicdev, "num-cpu", IMX8MP_NUM_A53);
         qdev_prop_set_uint32(gicdev, "num-irq",
                              FSL_IMX8MP_NUM_IRQS + GIC_INTERNAL);
         redist_region_count = qlist_new();
-        qlist_append_int(redist_region_count, ms->smp.cpus);
+        qlist_append_int(redist_region_count, IMX8MP_NUM_A53);
         qdev_prop_set_array(gicdev, "redist-region-count", redist_region_count);
         object_property_set_link(OBJECT(&s->gic), "sysmem",
                                  OBJECT(get_system_memory()), &error_fatal);
@@ -358,7 +359,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
          * maintenance interrupt signal to the appropriate GIC PPI inputs, and
          * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
          */
-        for (i = 0; i < ms->smp.cpus; i++) {
+        for (i = 0; i < IMX8MP_NUM_A53; i++) {
             DeviceState *cpudev = DEVICE(&s->cpu[i]);
             int intidbase = FSL_IMX8MP_NUM_IRQS + i * GIC_INTERNAL;
             qemu_irq irq;
@@ -388,11 +389,11 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 
             sysbus_connect_irq(gicsbd, i,
                                qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-            sysbus_connect_irq(gicsbd, i + ms->smp.cpus,
+            sysbus_connect_irq(gicsbd, i + IMX8MP_NUM_A53,
                                qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-            sysbus_connect_irq(gicsbd, i + 2 * ms->smp.cpus,
+            sysbus_connect_irq(gicsbd, i + 2 * IMX8MP_NUM_A53,
                                qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-            sysbus_connect_irq(gicsbd, i + 3 * ms->smp.cpus,
+            sysbus_connect_irq(gicsbd, i + 3 * IMX8MP_NUM_A53,
                                qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
 
             if (kvm_enabled()) {
@@ -443,13 +444,6 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gicdev, serial_table[i].irq));
     }
 
-    /* SRC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
-        return;
-    }
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0,
-                    fsl_imx8mp_memmap[FSL_IMX8MP_SRC].addr);
-
     /* GPC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpc), errp)) {
         return;
@@ -464,6 +458,49 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_IOMUXC_GPR].addr);
 
+    /* Realize Cortex-M7 subsystem */
+    {
+        DeviceState *cm7dev = DEVICE(&s->cm7);
+        DeviceState *ccmdev = DEVICE(&s->ccm);
+        qdev_prop_set_string(cm7dev, "cpu-type",
+                             ARM_CPU_TYPE_NAME("cortex-m7"));
+        qdev_prop_set_uint32(cm7dev, "num-irq", 160);
+        qdev_prop_set_bit(cm7dev, "enable-bitband", false);
+
+        /* CM7 vector table base (configurable) */
+        qdev_prop_set_uint32(cm7dev, "init-nsvtor", s->cm7_vector_base);
+
+        /* Connect CM7 clocks from CCM exported outputs */
+        qdev_connect_clock_in(cm7dev, "cpuclk",
+                              qdev_get_clock_out(ccmdev, "cm7_cpuclk"));
+        qdev_connect_clock_in(cm7dev, "refclk",
+                              qdev_get_clock_out(ccmdev, "cm7_refclk"));
+        object_property_set_link(OBJECT(&s->cm7), "memory",
+                                 OBJECT(get_system_memory()), &error_abort);
+
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->cm7), errp)) {
+            return;
+        }
+
+        arm_set_cpu_off(arm_cpu_mp_affinity(s->cm7.cpu));
+    }
+
+    qdev_prop_set_uint32(DEVICE(&s->src), "cm7-vector-base",
+                         s->cm7_vector_base);
+    object_property_set_link(OBJECT(&s->src), "cm7-cpu",
+                             OBJECT(s->cm7.cpu), &error_abort);
+    object_property_set_link(OBJECT(&s->src), "gpr",
+                             OBJECT(&s->gpr), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->src), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->src), 0,
+                    fsl_imx8mp_memmap[FSL_IMX8MP_SRC].addr);
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpr), 0,
+                       qdev_get_gpio_in_named(DEVICE(&s->src),
+                                              "cm7-cpuwait", 0));
+
     /* GPTs */
     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
                             &error_abort);
@@ -777,6 +814,37 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].addr,
                                 &s->ocram);
 
+    if (!memory_region_init_ram(&s->itcm, OBJECT(dev), "imx8mp.itcm",
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM].size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM].addr,
+                                &s->itcm);
+
+    if (!memory_region_init_ram(&s->dtcm, OBJECT(dev), "imx8mp.dtcm",
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM].size,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(),
+                                fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM].addr,
+                                &s->dtcm);
+
+    /* M7-view aliases: ITCM@0x0, DTCM@0x20000000 */
+    memory_region_init_alias(&s->itcm_alias, OBJECT(dev), "imx8mp.itcm-alias",
+                             &s->itcm, 0,
+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_ITCM].size);
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        0x00000000, &s->itcm_alias, 1);
+
+    memory_region_init_alias(&s->dtcm_alias, OBJECT(dev), "imx8mp.dtcm-alias",
+                             &s->dtcm, 0,
+                             fsl_imx8mp_memmap[FSL_IMX8MP_TCM_DTCM].size);
+    memory_region_add_subregion_overlap(get_system_memory(),
+                                        0x20000000, &s->dtcm_alias, 1);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(fsl_imx8mp_memmap); i++) {
         switch (i) {
@@ -794,6 +862,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_IOMUXC_GPR:
         case FSL_IMX8MP_MU_1_A ... FSL_IMX8MP_MU_3_B:
         case FSL_IMX8MP_OCRAM:
+        case FSL_IMX8MP_TCM_ITCM:
+        case FSL_IMX8MP_TCM_DTCM:
         case FSL_IMX8MP_PCIE1:
         case FSL_IMX8MP_PCIE_PHY1:
         case FSL_IMX8MP_RAM:
@@ -822,6 +892,8 @@ static const Property fsl_imx8mp_properties[] = {
                      CanBusState *),
     DEFINE_PROP_LINK("canbus1", FslImx8mpState, canbus[1], TYPE_CAN_BUS,
                      CanBusState *),
+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
+                       cm7_vector_base, 0x80000000),
 };
 
 static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index f9fb703816..317e6a4576 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -10,6 +10,7 @@
 #define FSL_IMX8MP_H
 
 #include "target/arm/cpu.h"
+#include "hw/arm/armv7m.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/i2c/imx_i2c.h"
@@ -67,6 +68,9 @@ struct FslImx8mpState {
     SysBusDevice   parent_obj;
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
+    ARMv7MState        cm7;
+    bool               enable_cm7;
+    uint32_t           cm7_vector_base;
     GICv3State         gic;
     IMX8MPGPCState     gpc;
     IMX8MPGPRState     gpr;
@@ -89,13 +93,17 @@ struct FslImx8mpState {
     FlexcanState       flexcan[FSL_IMX8MP_NUM_CANS];
     OrIRQState         gpt5_gpt6_irq;
     MemoryRegion       ocram;
-
+    MemoryRegion       itcm;
+    MemoryRegion       dtcm;
+    MemoryRegion       itcm_alias;
+    MemoryRegion       dtcm_alias;
     uint32_t           phy_num;
     bool               phy_connected;
 
     CanBusState       *canbus[FSL_IMX8MP_NUM_CANS];
 };
 
+
 enum FslImx8mpMemoryRegions {
     FSL_IMX8MP_A53_DAP,
     FSL_IMX8MP_AIPS1_CONFIGURATION,
-- 
2.34.1


