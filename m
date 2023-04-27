Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC04C56207
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7s-0005rb-D0; Fri, 20 Feb 2026 10:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2F-0008Ec-IM; Fri, 20 Feb 2026 10:03:19 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2B-0002LQ-J6; Fri, 20 Feb 2026 10:03:14 -0500
DKIM-Signature: a=rsa-sha256; bh=y8/iG1x91AvcU0JSYGvA1Y86G6kqZ/bl4CFKG6Hl2wI=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599788; v=1;
 b=arWagb+yHOWbYMDlxyvJ9qJzHpv2yjAarLqMTQNV0uinbHU1vw3DW0j5ep9m1q7opzgt2jdu
 Q9Lkg0FHdgQTA6OnCZacua01c4//F8IffH2XZohgGqHPH0GoHp6FLqY+Wf0hyXFG6VsdeleusbF
 Cd0eeF+8a7I8zyFj8pBURBE+p26mhTTU+7sKNhfOyoZM6IRw13EjqGU5wFlVOUoS/2LWA1wt3Uf
 GD1mi1RtxP2UY1le0c0Q22Q/VEMenoPLxS+Q5bO7PRcL7KOhZ8Oq7lfSdErTe7l69TYLTg6JuIi
 9gfQ1B70SIFr8yUhtvy8jX95vFYgExJnGvWH5lhA0/H4Q==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 246432501E;
 Fri, 20 Feb 2026 15:03:08 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Thu, 27 Apr 2023 19:45:37 +0200
Subject: [PATCH qemu 06/11] [ot] target/riscv, hw/riscv: add basic OpenTitan
 EarlGrey machine
MIME-Version: 1.0
Message-ID: <177159976712.8279.7732381632410882915-6@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

1. Define a generic version of lowrisc-ibex core that can be used in several =
machines:

 - leave MISA empty so that generic properties can be defined for this core
 - remove all arbitrary default properties but ISA I,C,U which are mandatory =
for ibex
 - define default mtvec which is only support vectored mode
 - update privilege version (1.12) according to the Ibex documentation
 - define ibex architecture identifier
 - remove hart array (mostly useless, its definition is incoherent and
   prevent from applying properties to CPU cores)

2. Add an EarlGrey machine that uses this new definition

Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>
Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 MAINTAINERS                    |   7 +
 hw/Kconfig                     |   3 +
 hw/meson.build                 |   1 +
 hw/opentitan/Kconfig           |   2 +
 hw/opentitan/meson.build       |   2 +
 hw/opentitan/trace-events      |   1 +
 hw/opentitan/trace.h           |   2 +
 hw/riscv/Kconfig               |   7 +
 hw/riscv/ibex_common.c         |  10 +-
 hw/riscv/meson.build           |   1 +
 hw/riscv/opentitan.c           |  30 +-
 hw/riscv/ot_earlgrey.c         | 734 +++++++++++++++++++++++++++++++++
 include/hw/riscv/ibex_common.h |   2 +-
 include/hw/riscv/opentitan.h   |   4 +-
 include/hw/riscv/ot_earlgrey.h |  27 ++
 meson.build                    |   1 +
 target/riscv/cpu-qom.h         |   2 +
 target/riscv/cpu.c             |  14 +-
 18 files changed, 829 insertions(+), 21 deletions(-)
 create mode 100644 hw/opentitan/Kconfig
 create mode 100644 hw/opentitan/meson.build
 create mode 100644 hw/opentitan/trace-events
 create mode 100644 hw/opentitan/trace.h
 create mode 100644 hw/riscv/ot_earlgrey.c
 create mode 100644 include/hw/riscv/ot_earlgrey.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b8bb7b554..c7f98e4b61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4460,6 +4460,13 @@ S: Supported
 F: hw/riscv/ibex_common.c
 F: include/hw/riscv/ibex_common.h
 F: include/hw/riscv/ibex_irq.h
+
+OpenTitan
+M: lowRISC <qemu-maintainers@lowrisc.org>
+S: Supported
+F: hw/opentitan/*
+F: include/hw/opentitan/*
+
 Build and test automation
 -------------------------
 Build and test automation, general continuous integration
diff --git a/hw/Kconfig b/hw/Kconfig
index f8f92b5d03..5215240092 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -69,6 +69,9 @@ source sparc64/Kconfig
 source tricore/Kconfig
 source xtensa/Kconfig
=20
+# OpenTitan devices
+source opentitan/Kconfig
+
 # Symbols used by multiple targets
 config TEST_DEVICES
     bool
diff --git a/hw/meson.build b/hw/meson.build
index 66e46b8090..f00346854e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -20,6 +20,7 @@ subdir('sparc')
 subdir('sparc64')
 subdir('tricore')
 subdir('xtensa')
+subdir('opentitan')
=20
 subdir('9pfs')
 subdir('acpi')
diff --git a/hw/opentitan/Kconfig b/hw/opentitan/Kconfig
new file mode 100644
index 0000000000..6bd1855a84
--- /dev/null
+++ b/hw/opentitan/Kconfig
@@ -0,0 +1,2 @@
+# OpenTitan devices
+
diff --git a/hw/opentitan/meson.build b/hw/opentitan/meson.build
new file mode 100644
index 0000000000..6bd1855a84
--- /dev/null
+++ b/hw/opentitan/meson.build
@@ -0,0 +1,2 @@
+# OpenTitan devices
+
diff --git a/hw/opentitan/trace-events b/hw/opentitan/trace-events
new file mode 100644
index 0000000000..695debd380
--- /dev/null
+++ b/hw/opentitan/trace-events
@@ -0,0 +1 @@
+# OpenTitan EarlGrey Trace Events
diff --git a/hw/opentitan/trace.h b/hw/opentitan/trace.h
new file mode 100644
index 0000000000..17c1fd28ed
--- /dev/null
+++ b/hw/opentitan/trace.h
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include "trace/trace-hw_opentitan.h"
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 7877f0615c..76588c43ae 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -12,6 +12,13 @@ config IBEX_COMMON
=20
 # RISC-V machines in alphabetical order
=20
+config OT_EARLGREY
+    bool
+    default y
+    select IBEX
+    select IBEX_COMMON
+    select SIFIVE_PLIC
+
 config MICROCHIP_PFSOC
     bool
     default y
diff --git a/hw/riscv/ibex_common.c b/hw/riscv/ibex_common.c
index c6056767c7..6b53662a5b 100644
--- a/hw/riscv/ibex_common.c
+++ b/hw/riscv/ibex_common.c
@@ -17,13 +17,13 @@
 #include "disas/disas.h"
 #include "elf.h"
 #include "exec/hwaddr.h"
-#include "hw/boards.h"
-#include "hw/loader.h"
+#include "hw/core/boards.h"
+#include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
-#include "hw/qdev-core.h"
-#include "hw/qdev-properties.h"
+#include "hw/core/qdev.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/riscv/ibex_common.h"
-#include "hw/sysbus.h"
+#include "hw/core/sysbus.h"
 #include "monitor/monitor.h"
=20
=20
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 70d63f56b5..76dc93147a 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,6 +4,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.=
c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_IBEX_COMMON', if_true: files('ibex_common.c'))
+riscv_ss.add(when: 'CONFIG_OT_EARLGREY', if_true: files('ot_earlgrey.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 19cb35b351..22f8b20f42 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -104,7 +104,9 @@ static void opentitan_machine_init(MachineState *machine)
         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
     }
=20
-    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+    boot_info.kernel_size =3D 0;
+    boot_info.is_32bit =3D 1;
+
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info,
                           memmap[IBEX_DEV_RAM].base,
@@ -119,7 +121,7 @@ static void opentitan_machine_class_init(ObjectClass *oc,=
 const void *data)
     mc->desc =3D "RISC-V Board compatible with OpenTitan";
     mc->init =3D opentitan_machine_init;
     mc->max_cpus =3D 1;
-    mc->default_cpu_type =3D TYPE_RISCV_CPU_LOWRISC_IBEX;
+    mc->default_cpu_type =3D TYPE_RISCV_CPU_LOWRISC_OPENTITAN;
     mc->default_ram_id =3D "riscv.lowrisc.ibex.ram";
     mc->default_ram_size =3D ibex_memmap[IBEX_DEV_RAM].size;
 }
@@ -128,7 +130,7 @@ static void lowrisc_ibex_soc_init(Object *obj)
 {
     LowRISCIbexSoCState *s =3D RISCV_IBEX_SOC(obj);
=20
-    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+    object_initialize_child(obj, "cpu", &s->cpu, TYPE_RISCV_CPU_LOWRISC_OPEN=
TITAN);
=20
     object_initialize_child(obj, "plic", &s->plic, TYPE_SIFIVE_PLIC);
=20
@@ -152,13 +154,17 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     MemoryRegion *sys_mem =3D get_system_memory();
     int i;
=20
-    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->cpus), "resetvec", s->resetvec,
-                            &error_abort);
-    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+    Object *cpu =3D OBJECT(&s->cpu);
+    object_property_set_int(cpu, "resetvec", s->resetvec,
+                            &error_fatal);
+    object_property_set_bool(cpu, "m", true, &error_fatal);
+    object_property_set_bool(cpu, "pmp", true, &error_fatal);
+    object_property_set_bool(cpu, "zba", true, &error_fatal);
+    object_property_set_bool(cpu, "zbb", true, &error_fatal);
+    object_property_set_bool(cpu, "zbc", true, &error_fatal);
+    object_property_set_bool(cpu, "zbs", true, &error_fatal);
+    object_property_set_bool(cpu, "smepmp", true, &error_fatal);
+    qdev_realize(DEVICE(&s->cpu), NULL, &error_fatal);
=20
     /* Boot ROM */
     memory_region_init_rom(&s->rom, OBJECT(dev_soc), "riscv.lowrisc.ibex.rom=
",
@@ -194,10 +200,10 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_DEV_PLIC].base);
=20
     for (i =3D 0; i < ms->smp.cpus; i++) {
-        CPUState *cpu =3D qemu_get_cpu(i);
+        CPUState *cpu_i =3D qemu_get_cpu(i);
=20
         qdev_connect_gpio_out(DEVICE(&s->plic), ms->smp.cpus + i,
-                              qdev_get_gpio_in(DEVICE(cpu), IRQ_M_EXT));
+                              qdev_get_gpio_in(DEVICE(cpu_i), IRQ_M_EXT));
     }
=20
     /* UART */
diff --git a/hw/riscv/ot_earlgrey.c b/hw/riscv/ot_earlgrey.c
new file mode 100644
index 0000000000..760a8d2c2e
--- /dev/null
+++ b/hw/riscv/ot_earlgrey.c
@@ -0,0 +1,734 @@
+/*
+ * QEMU RISC-V Board Compatible with OpenTitan EarlGrey FPGA platform
+ *
+ * Copyright (c) 2022-2023 Rivos, Inc.
+ *
+ * Author(s):
+ *  Emmanuel Blot <eblot@rivosinc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *
+ * This implementation is based on OpenTitan RTL version:
+ *  <lowRISC/opentitan@caa3bd0a14ddebbf60760490f7c917901482c8fd>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "system/address-spaces.h"
+#include "hw/core/boards.h"
+#include "hw/intc/sifive_plic.h"
+#include "hw/misc/unimp.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/riscv/ibex_common.h"
+#include "hw/riscv/ot_earlgrey.h"
+#include "system/system.h"
+
+/* ------------------------------------------------------------------------ =
*/
+/* Constants */
+/* ------------------------------------------------------------------------ =
*/
+
+#define OT_EARLGREY_PERIPHERAL_CLK_HZ 2500000u
+
+enum OtEarlgreySocMemory {
+    OT_EARLGREY_SOC_MEM_ROM,
+    OT_EARLGREY_SOC_MEM_RAM,
+    OT_EARLGREY_SOC_MEM_FLASH,
+};
+
+static const MemMapEntry ot_earlgrey_soc_memories[] =3D {
+    [OT_EARLGREY_SOC_MEM_ROM] =3D { 0x00008000u, 0x8000u },
+    [OT_EARLGREY_SOC_MEM_RAM] =3D { 0x10000000u, 0x20000u },
+    [OT_EARLGREY_SOC_MEM_FLASH] =3D { 0x20000000u, 0x100000u },
+};
+
+enum OtEarlgreySocDevice {
+    OT_EARLGREY_SOC_DEV_ADC_CTRL,
+    OT_EARLGREY_SOC_DEV_AES,
+    OT_EARLGREY_SOC_DEV_ALERT_HANDLER,
+    OT_EARLGREY_SOC_DEV_AON_TIMER,
+    OT_EARLGREY_SOC_DEV_AST,
+    OT_EARLGREY_SOC_DEV_CLKMGR,
+    OT_EARLGREY_SOC_DEV_CSRNG,
+    OT_EARLGREY_SOC_DEV_EDN0,
+    OT_EARLGREY_SOC_DEV_EDN1,
+    OT_EARLGREY_SOC_DEV_ENTROPY_SRC,
+    OT_EARLGREY_SOC_DEV_FLASH_CTRL,
+    OT_EARLGREY_SOC_DEV_FLASH_CTRL_PRIM,
+    OT_EARLGREY_SOC_DEV_GPIO,
+    OT_EARLGREY_SOC_DEV_HART,
+    OT_EARLGREY_SOC_DEV_HMAC,
+    OT_EARLGREY_SOC_DEV_I2C0,
+    OT_EARLGREY_SOC_DEV_I2C1,
+    OT_EARLGREY_SOC_DEV_I2C2,
+    OT_EARLGREY_SOC_DEV_IBEX_WRAPPER,
+    OT_EARLGREY_SOC_DEV_KEYMGR,
+    OT_EARLGREY_SOC_DEV_KMAC,
+    OT_EARLGREY_SOC_DEV_LC_CTRL,
+    OT_EARLGREY_SOC_DEV_OTBN,
+    OT_EARLGREY_SOC_DEV_OTP_CTRL,
+    OT_EARLGREY_SOC_DEV_OTP_CTRL_PRIM,
+    OT_EARLGREY_SOC_DEV_PATTGEN,
+    OT_EARLGREY_SOC_DEV_PINMUX,
+    OT_EARLGREY_SOC_DEV_PLIC,
+    OT_EARLGREY_SOC_DEV_PWM,
+    OT_EARLGREY_SOC_DEV_PWRMGR,
+    OT_EARLGREY_SOC_DEV_RAM_RET,
+    OT_EARLGREY_SOC_DEV_ROM_CTRL,
+    OT_EARLGREY_SOC_DEV_RSTMGR,
+    OT_EARLGREY_SOC_DEV_RV_DM,
+    OT_EARLGREY_SOC_DEV_RV_DM_MEM,
+    OT_EARLGREY_SOC_DEV_SENSOR_CTRL,
+    OT_EARLGREY_SOC_DEV_SPI_DEVICE,
+    OT_EARLGREY_SOC_DEV_SPI_HOST0,
+    OT_EARLGREY_SOC_DEV_SPI_HOST1,
+    OT_EARLGREY_SOC_DEV_SRAM_CTRL,
+    OT_EARLGREY_SOC_DEV_SRAM_CTRL_MAIN,
+    OT_EARLGREY_SOC_DEV_SYSRST_CTRL,
+    OT_EARLGREY_SOC_DEV_TIMER,
+    OT_EARLGREY_SOC_DEV_UART0,
+    OT_EARLGREY_SOC_DEV_UART1,
+    OT_EARLGREY_SOC_DEV_UART2,
+    OT_EARLGREY_SOC_DEV_UART3,
+    OT_EARLGREY_SOC_DEV_USBDEV,
+};
+
+#define OT_EARLGREY_SOC_GPIO(_irq_, _target_, _num_) \
+    IBEX_GPIO(_irq_, OT_EARLGREY_SOC_DEV_##_target_, _num_)
+
+#define OT_EARLGREY_SOC_GPIO_SYSBUS_IRQ(_irq_, _target_, _num_) \
+    IBEX_GPIO_SYSBUS_IRQ(_irq_, OT_EARLGREY_SOC_DEV_##_target_, _num_)
+
+#define OT_EARLGREY_SOC_DEVLINK(_pname_, _target_) \
+    IBEX_DEVLINK(_pname_, OT_EARLGREY_SOC_DEV_##_target_)
+
+/*
+ * MMIO/interrupt mapping as per:
+ * lowRISC/opentitan: hw/top_earlgrey/sw/autogen/top_earlgrey_memory.h
+ * and
+ * lowRISC/opentitan: hw/top_earlgrey/sw/autogen/top_earlgrey.h
+ */
+static const IbexDeviceDef ot_earlgrey_soc_devices[] =3D {
+    /* clang-format off */
+    [OT_EARLGREY_SOC_DEV_HART] =3D {
+        .type =3D TYPE_RISCV_CPU_LOWRISC_OPENTITAN,
+        .prop =3D IBEXDEVICEPROPDEFS(
+            IBEX_DEV_BOOL_PROP("zba", true),
+            IBEX_DEV_BOOL_PROP("zbb", true),
+            IBEX_DEV_BOOL_PROP("zbc", true),
+            IBEX_DEV_BOOL_PROP("zbs", true),
+            IBEX_DEV_BOOL_PROP("smepmp", true)
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_RV_DM_MEM] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-rv_dm_mem",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x00010000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_UART0] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-uart",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 0,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40000000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_UART1] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-uart",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 1,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40010000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_UART2] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-uart",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 2,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40020000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_UART3] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-uart",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 3,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40030000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_GPIO] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-gpio",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40040000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SPI_DEVICE] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-spi_device",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40050000u, 0x2000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_I2C0] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-i2c",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 0,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40080000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_I2C1] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-i2c",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 1,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40090000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_I2C2] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-i2c",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 2,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x400a0000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_PATTGEN] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-pattgen",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x400e0000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_TIMER] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-timer",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40100000u, 0x200u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_OTP_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-otp_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40130000u, 0x2000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_OTP_CTRL_PRIM] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-ot_ctrl_prim",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40132000u, 0x20u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_LC_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-lc_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40140000u, 0x100u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_ALERT_HANDLER] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-alert_handler",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40150000u, 0x800u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SPI_HOST0] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-spi_host",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 0,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40300000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SPI_HOST1] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-spi_host",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 1,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40310000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_USBDEV] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-usbdev",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40320000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_PWRMGR] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-pwrmgr",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40400000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_RSTMGR] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-rstmgr",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40410000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_CLKMGR] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-clkmgr",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40420000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SYSRST_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-sysrst_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40430000u, 0x100u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_ADC_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-adc_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40440000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_PWM] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-pwm",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40450000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_PINMUX] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-pinmux",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40460000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_AON_TIMER] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-aon_timer",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40470000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_AST] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-ast",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40480000u, 0x400u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SENSOR_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-sensor_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40490000u, 0x40u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SRAM_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-sram_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40500000u, 0x20u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_RAM_RET] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-ram_ret",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x40600000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_FLASH_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-flash_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41000000u, 0x200u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_FLASH_CTRL_PRIM] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-flash_ctrl_prim",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41008000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_AES] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-aes",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41100000u, 0x100u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_HMAC] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-hmac",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41110000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_KMAC] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-kmac",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41120000u, 0x1000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_OTBN] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-otbn",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41130000u, 0x10000u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_KEYMGR] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-keymgr",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41140000u, 0x100u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_CSRNG] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-csrng",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41150000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_ENTROPY_SRC] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-entropy_src",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41160000u, 0x100u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_EDN0] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-edn",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 0,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41170000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_EDN1] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-edn",
+        .cfg =3D &ibex_unimp_configure,
+        .instance =3D 1,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41180000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_SRAM_CTRL_MAIN] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-sram_ctrl_main",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x411c0000u, 0x20u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_ROM_CTRL] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-rom_ctrl",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x411e0000u, 0x80u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_IBEX_WRAPPER] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-ibex_wrapper",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x411f0000u, 0x100u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_RV_DM] =3D {
+        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
+        .name =3D "ot-rv_dm",
+        .cfg =3D &ibex_unimp_configure,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x41200000u, 0x4u }
+        ),
+    },
+    [OT_EARLGREY_SOC_DEV_PLIC] =3D {
+        .type =3D TYPE_SIFIVE_PLIC,
+        .memmap =3D MEMMAPENTRIES(
+            { 0x48000000u, 0x8000000u }
+        ),
+        .gpio =3D IBEXGPIOCONNDEFS(
+            OT_EARLGREY_SOC_GPIO(1, HART, IRQ_M_EXT)
+        ),
+        .prop =3D IBEXDEVICEPROPDEFS(
+            IBEX_DEV_STRING_PROP("hart-config", "M"),
+            IBEX_DEV_UINT_PROP("hartid-base", 0u),
+            /* note: should always be max_irq + 1 */
+            IBEX_DEV_UINT_PROP("num-sources", 185u),
+            IBEX_DEV_UINT_PROP("num-priorities", 3u),
+            IBEX_DEV_UINT_PROP("priority-base", 0x0u),
+            IBEX_DEV_UINT_PROP("pending-base", 0x1000u),
+            IBEX_DEV_UINT_PROP("enable-base", 0x2000u),
+            IBEX_DEV_UINT_PROP("enable-stride", 32u),
+            IBEX_DEV_UINT_PROP("context-base", 0x200000u),
+            IBEX_DEV_UINT_PROP("context-stride", 8u),
+            IBEX_DEV_UINT_PROP("aperture-size", 0x8000000u)
+        ),
+    },
+    /* clang-format on */
+};
+
+enum OtEarlgreyBoardDevice {
+    OT_EARLGREY_BOARD_DEV_SOC,
+    _OT_EARLGREY_BOARD_DEV_COUNT,
+};
+
+/* ------------------------------------------------------------------------ =
*/
+/* Type definitions */
+/* ------------------------------------------------------------------------ =
*/
+
+struct OtEarlGreySoCState {
+    SysBusDevice parent_obj;
+
+    DeviceState **devices;
+    MemoryRegion *memories;
+};
+
+struct OtEarlGreyBoardState {
+    DeviceState parent_obj;
+
+    DeviceState **devices;
+};
+
+struct OtEarlGreyMachineState {
+    MachineState parent_obj;
+};
+
+/* ------------------------------------------------------------------------ =
*/
+/* SoC */
+/* ------------------------------------------------------------------------ =
*/
+
+static void ot_earlgrey_soc_reset(DeviceState *dev)
+{
+    OtEarlGreySoCState *s =3D RISCV_OT_EARLGREY_SOC(dev);
+
+    cpu_reset(CPU(s->devices[OT_EARLGREY_SOC_DEV_HART]));
+}
+
+static void ot_earlgrey_soc_realize(DeviceState *dev, Error **errp)
+{
+    OtEarlGreySoCState *s =3D RISCV_OT_EARLGREY_SOC(dev);
+    const MemMapEntry *memmap =3D &ot_earlgrey_soc_memories[0];
+
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+    MemoryRegion *sys_mem =3D get_system_memory();
+
+    /* RAM */
+    memory_region_add_subregion(sys_mem, memmap[OT_EARLGREY_SOC_MEM_RAM].bas=
e,
+                                ms->ram);
+
+    /* Boot ROM */
+    memory_region_init_rom(&s->memories[OT_EARLGREY_SOC_MEM_ROM], OBJECT(dev=
),
+                           "ot-rom", memmap[OT_EARLGREY_SOC_MEM_ROM].size,
+                           &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[OT_EARLGREY_SOC_MEM_ROM].bas=
e,
+                                &s->memories[OT_EARLGREY_SOC_MEM_ROM]);
+
+    /* Flash memory */
+    memory_region_init_rom(&s->memories[OT_EARLGREY_SOC_MEM_FLASH], OBJECT(d=
ev),
+                           "ot-flash", memmap[OT_EARLGREY_SOC_MEM_FLASH].siz=
e,
+                           &error_fatal);
+    memory_region_add_subregion(sys_mem, memmap[OT_EARLGREY_SOC_MEM_FLASH].b=
ase,
+                                &s->memories[OT_EARLGREY_SOC_MEM_FLASH]);
+
+    /* Link, define properties and realize devices, then connect GPIOs */
+    ibex_link_devices(s->devices, ot_earlgrey_soc_devices,
+                      ARRAY_SIZE(ot_earlgrey_soc_devices));
+    ibex_define_device_props(s->devices, ot_earlgrey_soc_devices,
+                             ARRAY_SIZE(ot_earlgrey_soc_devices));
+    ibex_realize_system_devices(s->devices, ot_earlgrey_soc_devices,
+                                ARRAY_SIZE(ot_earlgrey_soc_devices));
+    ibex_connect_devices(s->devices, ot_earlgrey_soc_devices,
+                         ARRAY_SIZE(ot_earlgrey_soc_devices));
+
+    /* load kernel if provided */
+    ibex_load_kernel(NULL);
+}
+
+static void ot_earlgrey_soc_init(Object *obj)
+{
+    OtEarlGreySoCState *s =3D RISCV_OT_EARLGREY_SOC(obj);
+
+    s->devices =3D
+        ibex_create_devices(ot_earlgrey_soc_devices,
+                            ARRAY_SIZE(ot_earlgrey_soc_devices), DEVICE(s));
+    s->memories =3D g_new0(MemoryRegion, ARRAY_SIZE(ot_earlgrey_soc_memories=
));
+}
+
+static void ot_earlgrey_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    dc->legacy_reset =3D &ot_earlgrey_soc_reset;
+    dc->realize =3D &ot_earlgrey_soc_realize;
+    dc->user_creatable =3D false;
+}
+
+static const TypeInfo ot_earlgrey_soc_type_info =3D {
+    .name =3D TYPE_RISCV_OT_EARLGREY_SOC,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(OtEarlGreySoCState),
+    .instance_init =3D &ot_earlgrey_soc_init,
+    .class_init =3D &ot_earlgrey_soc_class_init,
+};
+
+static void ot_earlgrey_soc_register_types(void)
+{
+    type_register_static(&ot_earlgrey_soc_type_info);
+}
+
+type_init(ot_earlgrey_soc_register_types);
+
+/* ------------------------------------------------------------------------ =
*/
+/* Board */
+/* ------------------------------------------------------------------------ =
*/
+
+static void ot_earlgrey_board_realize(DeviceState *dev, Error **errp)
+{
+    OtEarlGreyBoardState *board =3D RISCV_OT_EARLGREY_BOARD(dev);
+
+    DeviceState *soc =3D board->devices[OT_EARLGREY_BOARD_DEV_SOC];
+    object_property_add_child(OBJECT(board), "soc", OBJECT(soc));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(soc), &error_fatal);
+}
+
+static void ot_earlgrey_board_init(Object *obj)
+{
+    OtEarlGreyBoardState *s =3D RISCV_OT_EARLGREY_BOARD(obj);
+
+    s->devices =3D g_new0(DeviceState *, _OT_EARLGREY_BOARD_DEV_COUNT);
+    s->devices[OT_EARLGREY_BOARD_DEV_SOC] =3D
+        qdev_new(TYPE_RISCV_OT_EARLGREY_SOC);
+}
+
+static void ot_earlgrey_board_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    dc->realize =3D &ot_earlgrey_board_realize;
+}
+
+static const TypeInfo ot_earlgrey_board_type_info =3D {
+    .name =3D TYPE_RISCV_OT_EARLGREY_BOARD,
+    .parent =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(OtEarlGreyBoardState),
+    .instance_init =3D &ot_earlgrey_board_init,
+    .class_init =3D &ot_earlgrey_board_class_init,
+};
+
+static void ot_earlgrey_board_register_types(void)
+{
+    type_register_static(&ot_earlgrey_board_type_info);
+}
+
+type_init(ot_earlgrey_board_register_types);
+
+/* ------------------------------------------------------------------------ =
*/
+/* Machine */
+/* ------------------------------------------------------------------------ =
*/
+
+static void ot_earlgrey_machine_instance_init(Object *obj)
+{
+    OtEarlGreyMachineState *s =3D RISCV_OT_EARLGREY_MACHINE(obj);
+
+    /* nothing here */
+    (void)s;
+}
+
+static void ot_earlgrey_machine_init(MachineState *state)
+{
+    DeviceState *dev =3D qdev_new(TYPE_RISCV_OT_EARLGREY_BOARD);
+
+    object_property_add_child(OBJECT(state), "board", OBJECT(dev));
+    qdev_realize(dev, NULL, &error_fatal);
+}
+
+static void ot_earlgrey_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->desc =3D "RISC-V Board compatible with OpenTitan EarlGrey FPGA platf=
orm";
+    mc->init =3D ot_earlgrey_machine_init;
+    mc->max_cpus =3D 1u;
+    mc->default_cpu_type =3D
+        ot_earlgrey_soc_devices[OT_EARLGREY_SOC_DEV_HART].type;
+    mc->default_ram_id =3D "ot-ram";
+    mc->default_ram_size =3D
+        ot_earlgrey_soc_memories[OT_EARLGREY_SOC_MEM_RAM].size;
+}
+
+static const TypeInfo ot_earlgrey_machine_type_info =3D {
+    .name =3D TYPE_RISCV_OT_EARLGREY_MACHINE,
+    .parent =3D TYPE_MACHINE,
+    .instance_size =3D sizeof(OtEarlGreyMachineState),
+    .instance_init =3D &ot_earlgrey_machine_instance_init,
+    .class_init =3D &ot_earlgrey_machine_class_init,
+};
+
+static void ot_earlgrey_machine_register_types(void)
+{
+    type_register_static(&ot_earlgrey_machine_type_info);
+}
+
+type_init(ot_earlgrey_machine_register_types);
diff --git a/include/hw/riscv/ibex_common.h b/include/hw/riscv/ibex_common.h
index 6c7dae5cbe..963ab1fa78 100644
--- a/include/hw/riscv/ibex_common.h
+++ b/include/hw/riscv/ibex_common.h
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qom/object.h"
 #include "exec/hwaddr.h"
-#include "hw/qdev-core.h"
+#include "hw/core/qdev.h"
=20
=20
 /* ------------------------------------------------------------------------ =
*/
diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index 5b9016e1d8..0da19c671f 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -19,13 +19,13 @@
 #ifndef HW_OPENTITAN_H
 #define HW_OPENTITAN_H
=20
-#include "hw/riscv/riscv_hart.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/char/ibex_uart.h"
 #include "hw/timer/ibex_timer.h"
 #include "hw/ssi/ibex_spi_host.h"
 #include "hw/core/boards.h"
 #include "qom/object.h"
+#include "target/riscv/cpu.h"
=20
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 OBJECT_DECLARE_SIMPLE_TYPE(LowRISCIbexSoCState, RISCV_IBEX_SOC)
@@ -41,7 +41,7 @@ struct LowRISCIbexSoCState {
     SysBusDevice parent_obj;
=20
     /*< public >*/
-    RISCVHartArrayState cpus;
+    RISCVCPU cpu;
     SiFivePLICState plic;
     IbexUartState uart;
     IbexTimerState timer;
diff --git a/include/hw/riscv/ot_earlgrey.h b/include/hw/riscv/ot_earlgrey.h
new file mode 100644
index 0000000000..650f53a9dd
--- /dev/null
+++ b/include/hw/riscv/ot_earlgrey.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU RISC-V Board Compatible with OpenTitan EarlGrey FPGA platform
+ *
+ * Copyright (c) 2022-2023 Rivos, Inc.
+ *
+ * Author(s):
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_RISCV_OT_EARLGREY_H
+#define HW_RISCV_OT_EARLGREY_H
+
+#include "qom/object.h"
+
+#define TYPE_RISCV_OT_EARLGREY_MACHINE MACHINE_TYPE_NAME("ot-earlgrey")
+OBJECT_DECLARE_SIMPLE_TYPE(OtEarlGreyMachineState, RISCV_OT_EARLGREY_MACHINE)
+
+#define TYPE_RISCV_OT_EARLGREY_BOARD "riscv.ot_earlgrey.board"
+OBJECT_DECLARE_SIMPLE_TYPE(OtEarlGreyBoardState, RISCV_OT_EARLGREY_BOARD)
+
+#define TYPE_RISCV_OT_EARLGREY_SOC "riscv.ot_earlgrey.soc"
+OBJECT_DECLARE_SIMPLE_TYPE(OtEarlGreySoCState, RISCV_OT_EARLGREY_SOC)
+
+#endif /* HW_RISCV_OT_EARLGREY_H */
diff --git a/meson.build b/meson.build
index 4af32c3e1f..55a85ec895 100644
--- a/meson.build
+++ b/meson.build
@@ -3626,6 +3626,7 @@ if have_system
     'hw/nubus',
     'hw/nvme',
     'hw/nvram',
+    'hw/opentitan',
     'hw/pci',
     'hw/pci-host',
     'hw/ppc',
diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 3a6394fd11..418b56d69e 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -43,6 +43,8 @@
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_LOWRISC_IBEX     RISCV_CPU_TYPE_NAME("lowrisc-ibex")
+#define TYPE_RISCV_CPU_LOWRISC_OPENTITAN \
+    RISCV_CPU_TYPE_NAME("lowrisc-opentitan")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dd30b21dd2..507061e8e9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3043,13 +3043,25 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .misa_mxl_max =3D MXL_RV32,
     ),
=20
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_LOWRISC_IBEX, TYPE_RISCV_VENDOR_CPU,
+
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_LOWRISC_IBEX,
+        TYPE_RISCV_VENDOR_CPU,
         .misa_mxl_max =3D MXL_RV32,
         .misa_ext =3D RVI | RVM | RVC | RVU,
         .priv_spec =3D PRIV_VERSION_1_12_0,
         .cfg.max_satp_mode =3D VM_1_10_MBARE,
         .cfg.ext_zifencei =3D true,
         .cfg.ext_zicsr =3D true,
+
+        .cfg.marchid =3D 0x16u,
+
+#ifndef CONFIG_USER_ONLY
+        .custom_csrs =3D ibex_csr_list,
+#endif
+    ),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_LOWRISC_OPENTITAN,
+        TYPE_RISCV_CPU_LOWRISC_IBEX,
         .cfg.pmp =3D true,
         .cfg.ext_smepmp =3D true,
=20
--=20
2.49.1


