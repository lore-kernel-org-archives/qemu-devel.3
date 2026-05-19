Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412B8CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPOgj-0008OD-MC; Tue, 19 May 2026 13:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wPOga-0008Mu-6x
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:56:57 -0400
Received: from inva021.nxp.com ([92.121.34.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wPOgR-0002gl-MT
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:56:52 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 11462203C19;
 Tue, 19 May 2026 19:56:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE359202769;
 Tue, 19 May 2026 19:56:41 +0200 (CEST)
Received: from lsv031015.swis.in-blr01.nxp.com
 (lsv031015.swis.in-blr01.nxp.com [10.12.177.77])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 1BC22180026F;
 Wed, 20 May 2026 01:56:41 +0800 (+08)
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, shentey@gmail.com,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCHv1 6/7] hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
Date: Tue, 19 May 2026 23:26:34 +0530
Message-Id: <20260519175635.3245229-7-gaurav.sharma_7@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
References: <20260519175635.3245229-1-gaurav.sharma_7@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=92.121.34.21;
 envelope-from=gaurav.sharma_7@nxp.com; helo=inva021.nxp.com
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
The handler translates the CPUWAIT into STOP and RUN.It follows the
classic Cortex-M boot sequence: initial SP and reset vector taken from
the vector table.

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
---
 docs/system/arm/imx8m.rst   |  86 +++++++++++++++++++++-
 hw/arm/fsl-imx8mp.c         | 143 ++++++++++++++++++++++++++++++++++++
 include/hw/arm/fsl-imx8mp.h |  13 +++-
 3 files changed, 240 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index c482bf180f..d6729cbcc6 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -12,6 +12,7 @@ The ``imx8mp-evk`` and ``imx8mm-evk`` machines implement the
 following devices:
 
  * Up to 4 Cortex-A53 cores
+ * 1 Cortex-M7 core (``imx8mp-evk`` only)
  * Generic Interrupt Controller (GICv3)
  * 4 UARTs
  * 3 USDHC Storage Controllers
@@ -36,6 +37,88 @@ Boot options
 The ``imx8mp-evk`` and ``imx8mm-evk`` machines can start a Linux
 kernel directly using the standard ``-kernel`` functionality.
 
+Asymmetric Multiprocessing (AMP) Boot (``imx8mp-evk`` only)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
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
+If you build a Cortex-M7 bare-metal firmware elf that is linked for a vector
+table base address other than the default 0x80000000, configure the CM7 vector base via the SoC property
+``cm7-vector-base``.
+
+Note:-Currently only DDR-linked bare-metal binaries are supported in qemu emulation.
+
+This can be set using a global property:
+
+.. code-block:: bash
+
+  -global fsl-imx8mp.cm7-vector-base=0x80000000
+
+In the absence of the above global property in qemu invocation, by default 0x80000000 will be used.
+
+
+To run the i.MX 8M Plus model with the Cortex-M7 core enabled(4x A53 + 1x M7), start QEMU with
+
+.. code-block:: bash
+
+  -smp 4,maxcpus=5 -global fsl-imx8mp.enable-cm7=on
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
+Once Linux is running, the M7 firmware can be loaded and started via the remoteproc interface:
+
+.. code-block:: bash
+
+  # echo <firmware_name>.elf > /sys/class/remoteproc/remoteproc0/firmware
+  # echo start > /sys/class/remoteproc/remoteproc0/state
+
+
 Direct Linux Kernel Boot
 ''''''''''''''''''''''''
 
@@ -72,7 +155,8 @@ For i.MX 8M Plus EVK:
 .. code-block:: bash
 
   $ qemu-system-aarch64 -M imx8mp-evk \
-      -display none -serial null -serial stdio \
+      -display none -serial null -serial stdio -serial null -serial /tmp/imx8mp-uart4 \
+      -smp 4,maxcpus=5 -global fsl-imx8mp.enable-cm7=on \
       -kernel Image \
       -dtb imx8mp-evk.dtb \
       -append "root=/dev/mmcblk2p2" \
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index eec83deced..a5066c3ae2 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -196,6 +196,10 @@ static void fsl_imx8mp_init(Object *obj)
     FslImx8mpState *s = FSL_IMX8MP(obj);
     int i;
 
+    s->cm7_booted = false;
+
+    object_initialize_child(obj, "cm7", &s->cm7, TYPE_ARMV7M);
+
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -269,6 +273,93 @@ static void fsl_imx8mp_init(Object *obj)
                             TYPE_FSL_IMX8M_PCIE_PHY);
 }
 
+static inline void imx8mp_cm7_halt(CPUState *m7cs)
+{
+    cpu_interrupt(m7cs, CPU_INTERRUPT_HALT);
+    m7cs->halted = 1;
+    qemu_cpu_kick(m7cs);
+}
+
+static inline void imx8mp_cm7_resume(CPUState *m7cs)
+{
+    /* Clear HALT interrupt (from STOP) and resume */
+    cpu_reset_interrupt(m7cs, CPU_INTERRUPT_HALT);
+    m7cs->halted = 0;
+    m7cs->stopped = 0;
+    cpu_resume(m7cs);
+    cpu_interrupt(m7cs, CPU_INTERRUPT_EXITTB);
+    qemu_cpu_kick(m7cs);
+}
+
+static void imx8mp_cm7_ctrl_apply(CPUState *cpu, run_on_cpu_data data)
+{
+    struct CM7CtlReq *r = data.host_ptr;
+    FslImx8mpState *s = r->s;
+    ARMCPU *m7 = s->cm7.cpu;
+    CPUState *m7cs = CPU(m7);
+
+    if (!r->run) {
+        /* STOP: halt the M7 */
+    imx8mp_cm7_halt(m7cs);
+        goto out;
+    }
+
+    /*
+     * RUN:
+     * CPUWAIT is modeled as a run/stop gate. On first RUN, boot from vector
+     * table. Subsequent RUN resumes execution without resetting CM7 state.
+     */
+    if (s->cm7_booted) {
+        imx8mp_cm7_resume(m7cs);
+        goto out;
+    }
+
+    uint32_t msp_le = 0, pc_le = 0;
+    uint32_t msp, pc;
+    hwaddr vbase = s->cm7_vector_base;
+
+    address_space_read(&address_space_memory, vbase,
+                       MEMTXATTRS_UNSPECIFIED, &msp_le, sizeof(msp_le));
+    address_space_read(&address_space_memory, vbase + 4,
+                       MEMTXATTRS_UNSPECIFIED, &pc_le, sizeof(pc_le));
+    msp = le32_to_cpu(msp_le);
+    pc  = le32_to_cpu(pc_le);
+
+
+    /* Clear Thumb indicator bit (bit0) */
+    pc &= ~1u;
+
+    cpu_reset(m7cs);
+
+    /* Set SP (R13) and PC (R15). Cortex-M uses Thumb */
+    m7->env.regs[13] = msp;
+    m7->env.regs[15] = pc;
+    m7->env.thumb = 1;
+
+    imx8mp_cm7_resume(m7cs);
+
+    s->cm7_booted = true;
+out:
+    g_free(r);
+};
+
+static void imx8mp_cm7_cpuwait_handler(void *opaque, int n, int level)
+{
+    FslImx8mpState *s = opaque;
+    (void)n;
+
+    if (!s->cm7.cpu) {
+        return;
+    }
+
+    struct CM7CtlReq *r = g_new0(struct CM7CtlReq, 1);
+    r->s = s;
+    r->run = !!level;
+
+    async_run_on_cpu(CPU(s->cm7.cpu), imx8mp_cm7_ctrl_apply,
+                     RUN_ON_CPU_HOST_PTR(r));
+}
+
 static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -277,6 +368,23 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
+    if (!s->enable_cm7) {
+        object_unparent(OBJECT(&s->cm7));
+    } else {
+        /*
+         * When CM7 is enabled we need one additional vCPU
+         * slot. If the user does not specify maxcpus=,
+         * QEMU defaults maxcpus to the current -smp count.
+         */
+        unsigned int need = ms->smp.cpus + 1;
+        if (ms->smp.max_cpus < need) {
+            error_setg(errp,
+                       "CM7 enabled requires -smp %u,maxcpus=%u (one extra vCPU slot for CM7)",
+                       ms->smp.cpus, need);
+            return;
+        }
+    }
+
     if (ms->smp.cpus > FSL_IMX8MP_NUM_CPUS) {
         error_setg(errp, "%s: Only %d CPUs are supported (%d requested)",
                    TYPE_FSL_IMX8MP, FSL_IMX8MP_NUM_CPUS, ms->smp.cpus);
@@ -459,6 +567,38 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0,
                     fsl_imx8mp_memmap[FSL_IMX8MP_IOMUXC_GPR].addr);
 
+    if (s->enable_cm7) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpr), 0,
+                   qemu_allocate_irq(imx8mp_cm7_cpuwait_handler, s, 0));
+
+    /* Realize Cortex-M7 subsystem */
+        DeviceState *cm7dev = DEVICE(&s->cm7);
+        DeviceState *ccmdev = DEVICE(&s->ccm);
+        qdev_prop_set_string(cm7dev, "cpu-type",
+                             ARM_CPU_TYPE_NAME("cortex-m7"));
+        qdev_prop_set_uint32(cm7dev, "num-irq", 64);
+        qdev_prop_set_bit(cm7dev, "enable-bitband", true);
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
+    }
+
+        CPUState *m7cs = CPU(s->cm7.cpu);
+        cpu_interrupt(m7cs, CPU_INTERRUPT_HALT);
+        m7cs->halted = 1;
+    }
+
     /* GPTs */
     object_property_set_int(OBJECT(&s->gpt5_gpt6_irq), "num-lines", 2,
                             &error_abort);
@@ -784,6 +924,9 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
 static const Property fsl_imx8mp_properties[] = {
     DEFINE_PROP_UINT32("fec1-phy-num", FslImx8mpState, phy_num, 0),
     DEFINE_PROP_BOOL("fec1-phy-connected", FslImx8mpState, phy_connected, true),
+    DEFINE_PROP_BOOL("enable-cm7", FslImx8mpState, enable_cm7, false),
+    DEFINE_PROP_UINT32("cm7-vector-base", FslImx8mpState,
+                       cm7_vector_base, 0x80000000),
 };
 
 static void fsl_imx8mp_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 94d198b932..335e4beb6c 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -10,6 +10,7 @@
 #define FSL_IMX8MP_H
 
 #include "target/arm/cpu.h"
+#include "hw/arm/armv7m.h"
 #include "hw/char/imx_serial.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/i2c/imx_i2c.h"
@@ -30,6 +31,7 @@
 #include "hw/timer/imx_gpt.h"
 #include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/core/sysbus.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -43,7 +45,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpState, FSL_IMX8MP)
 #define FSL_IMX8MP_MU1_A_IRQ  88
 
 enum FslImx8mpConfiguration {
-    FSL_IMX8MP_NUM_CPUS         = 4,
+    FSL_IMX8MP_NUM_CPUS         = 5,
     FSL_IMX8MP_NUM_ECSPIS       = 3,
     FSL_IMX8MP_NUM_GPIOS        = 5,
     FSL_IMX8MP_NUM_GPTS         = 6,
@@ -65,6 +67,10 @@ struct FslImx8mpState {
     SysBusDevice   parent_obj;
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
+    ARMv7MState        cm7;
+    bool               enable_cm7;
+    bool               cm7_booted;
+    uint32_t           cm7_vector_base;
     GICv3State         gic;
     IMX8MPGPCState     gpc;
     IMX8MPGPRState     gpr;
@@ -91,6 +97,11 @@ struct FslImx8mpState {
     bool               phy_connected;
 };
 
+struct CM7CtlReq {
+    FslImx8mpState *s;
+    bool run;
+};
+
 enum FslImx8mpMemoryRegions {
     FSL_IMX8MP_A53_DAP,
     FSL_IMX8MP_AIPS1_CONFIGURATION,
-- 
2.34.1


