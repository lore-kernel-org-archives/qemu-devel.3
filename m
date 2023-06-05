Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A2C56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7t-0005ri-72; Fri, 20 Feb 2026 10:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2C-0008Cn-1p; Fri, 20 Feb 2026 10:03:13 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS29-0002Kl-7Y; Fri, 20 Feb 2026 10:03:11 -0500
DKIM-Signature: a=rsa-sha256; bh=WWZhY35LLWHeJdCFFOr+e8kJW4fpE0wdAgDqorcI8cE=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599782; v=1;
 b=E1ZCIiDdZvF6fSlCx5QSPrkzDlCGfCY1B6tSMNvOVGqUg8qhUEUlnSAKY9v/kLqJMxJ7l2SU
 Q0sORnKRzPEgHDlPSmGiC+a//H6noMza/UbugRBoUbxaAqv7fNyUXZookNlKeOYUxXY1mvUPq83
 IopqKbcCEHdOzZwn3LH57xqU9O6AiYNJU55z/M1xvEDiysi98C/lfOkUyvLrZmsQqbnAZHHtOfi
 LseEjFSSHPPCh55PtPryf+LlnvY+qZTnXGkxsgarf5SHLYs0MQKSwBF8/ikRx9/1/CI5T8MGExw
 A+er3bW6tnvGLf8DZ7nfIYUzos724NlwonRRjuX2hmtiQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id D306625019;
 Fri, 20 Feb 2026 15:03:02 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Mon, 05 Jun 2023 12:24:08 +0200
Subject: [PATCH qemu 03/11] [ot] hw/riscv: add helper for Ibex platforms
Message-ID: <177159976712.8279.7732381632410882915-3@git.sr.ht>
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
MIME-Version: 1.0
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

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>
---
 MAINTAINERS                    |  14 +-
 hmp-commands-info.hx           |  12 ++
 hw/riscv/Kconfig               |   3 +
 hw/riscv/ibex_common.c         | 316 ++++++++++++++++++++++++++++++++
 hw/riscv/meson.build           |   1 +
 include/hw/riscv/ibex_common.h | 322 +++++++++++++++++++++++++++++++++
 6 files changed, 666 insertions(+), 2 deletions(-)
 create mode 100644 hw/riscv/ibex_common.c
 create mode 100644 include/hw/riscv/ibex_common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e0c481e212..8b8bb7b554 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1716,9 +1716,13 @@ M: Alistair Francis <Alistair.Francis@wdc.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/opentitan.c
-F: hw/*/ibex_*.c
+F: hw/ssi/ibex_spi_host.c
+F: hw/timer/ibex_timer.c
+F: hw/char/ibex_uart.c
 F: include/hw/riscv/opentitan.h
-F: include/hw/*/ibex_*.h
+F: include/hw/ssi/ibex_spi_host.h
+F: include/hw/timer/ibex_timer.h
+F: include/hw/char/ibex_uart.h
=20
 Microchip PolarFire SoC Icicle Kit
 L: qemu-riscv@nongnu.org
@@ -4450,6 +4454,12 @@ F: docs/devel/ebpf_rss.rst
 F: ebpf/*
 F: tools/ebpf/*
=20
+Ibex
+M: lowRISC <qemu-maintainers@lowrisc.org>
+S: Supported
+F: hw/riscv/ibex_common.c
+F: include/hw/riscv/ibex_common.h
+F: include/hw/riscv/ibex_irq.h
 Build and test automation
 -------------------------
 Build and test automation, general continuous integration
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e..90f05f7599 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -1010,3 +1010,15 @@ SRST
   ``info firmware-log``
     Show the firmware (ovmf) debug log.
 ERST
+
+    {
+        .name       =3D "ibex",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "Show Ibex vCPU info",
+    },
+
+SRST
+  ``info ibex``
+    Show Ibex vCPU information.
+ERST
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6aa32ee8f..7877f0615c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,9 @@ config RISCV_NUMA
 config IBEX
     bool
=20
+config IBEX_COMMON
+    bool
+
 # RISC-V machines in alphabetical order
=20
 config MICROCHIP_PFSOC
diff --git a/hw/riscv/ibex_common.c b/hw/riscv/ibex_common.c
new file mode 100644
index 0000000000..c6056767c7
--- /dev/null
+++ b/hw/riscv/ibex_common.c
@@ -0,0 +1,316 @@
+/*
+ * QEMU RISC-V Helpers for LowRISC Ibex Demo System & OpenTitan EarlGrey
+ *
+ * Copyright (c) 2022-2023 Rivos, Inc.
+ *
+ * Author(s):
+ *  Emmanuel Blot <eblot@rivosinc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "cpu.h"
+#include "disas/disas.h"
+#include "elf.h"
+#include "exec/hwaddr.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/misc/unimp.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/ibex_common.h"
+#include "hw/sysbus.h"
+#include "monitor/monitor.h"
+
+
+static void ibex_mmio_map_device(SysBusDevice *dev, MemoryRegion *mr,
+                                 unsigned nr, hwaddr addr)
+{
+    assert(nr < dev->num_mmio);
+    assert(dev->mmio[nr].addr =3D=3D (hwaddr)-1);
+    dev->mmio[nr].addr =3D addr;
+    memory_region_add_subregion(mr, addr, dev->mmio[nr].memory);
+}
+
+DeviceState **ibex_create_devices(const IbexDeviceDef *defs, unsigned count,
+                                  DeviceState *parent)
+{
+    DeviceState **devices =3D g_new0(DeviceState *, count);
+    unsigned unimp_count =3D 0;
+    for (unsigned idx =3D 0; idx < count; idx++) {
+        const IbexDeviceDef *def =3D &defs[idx];
+        assert(def->type);
+        devices[idx] =3D qdev_new(def->type);
+
+        char *name;
+        if (!strcmp(def->type, TYPE_UNIMPLEMENTED_DEVICE)) {
+            if (def->name) {
+                name =3D g_strdup_printf("%s[%u]", def->name, def->instance);
+            } else {
+                name =3D g_strdup_printf(TYPE_UNIMPLEMENTED_DEVICE "[%u]",
+                                       unimp_count);
+            }
+            unimp_count +=3D 1u;
+        } else {
+            name =3D g_strdup_printf("%s[%u]", def->type, def->instance);
+        }
+        object_property_add_child(OBJECT(parent), name, OBJECT(devices[idx])=
);
+        g_free(name);
+    }
+    return devices;
+}
+
+void ibex_link_devices(DeviceState **devices, const IbexDeviceDef *defs,
+                       unsigned count)
+{
+    /* Link devices */
+    for (unsigned idx =3D 0; idx < count; idx++) {
+        DeviceState *dev =3D devices[idx];
+        const IbexDeviceLinkDef *link =3D defs[idx].link;
+        if (link) {
+            while (link->propname) {
+                DeviceState *target =3D devices[link->index];
+                (void)object_property_set_link(OBJECT(dev), link->propname,
+                                               OBJECT(target), &error_fatal);
+                link++;
+            }
+        }
+    }
+}
+
+void ibex_define_device_props(DeviceState **devices, const IbexDeviceDef *de=
fs,
+                              unsigned count)
+{
+    for (unsigned idx =3D 0; idx < count; idx++) {
+        DeviceState *dev =3D devices[idx];
+        const IbexDevicePropDef *prop =3D defs[idx].prop;
+        if (prop) {
+            while (prop->propname) {
+                switch (prop->type) {
+                case IBEX_PROP_TYPE_BOOL:
+                    object_property_set_bool(OBJECT(dev), prop->propname,
+                                             prop->b, &error_fatal);
+                    break;
+                case IBEX_PROP_TYPE_INT:
+                    object_property_set_int(OBJECT(dev), prop->propname,
+                                            prop->i, &error_fatal);
+                    break;
+                case IBEX_PROP_TYPE_UINT:
+                    object_property_set_int(OBJECT(dev), prop->propname,
+                                            prop->u, &error_fatal);
+                    break;
+                case IBEX_PROP_TYPE_STR:
+                    object_property_set_str(OBJECT(dev), prop->propname,
+                                            prop->s, &error_fatal);
+                    break;
+                default:
+                    g_assert_not_reached();
+                    break;
+                }
+                prop++;
+            }
+        }
+    }
+}
+
+void ibex_realize_system_devices(DeviceState **devices,
+                                 const IbexDeviceDef *defs, unsigned count)
+{
+    BusState *bus =3D sysbus_get_default();
+
+    ibex_realize_devices(devices, bus, defs, count);
+
+    MemoryRegion *mrs[] =3D { get_system_memory(), NULL, NULL, NULL };
+
+    ibex_map_devices(devices, mrs, defs, count);
+}
+
+void ibex_realize_devices(DeviceState **devices, BusState *bus,
+                          const IbexDeviceDef *defs, unsigned count)
+{
+    /* Realize devices */
+    for (unsigned idx =3D 0; idx < count; idx++) {
+        DeviceState *dev =3D devices[idx];
+        const IbexDeviceDef *def =3D &defs[idx];
+
+        if (def->cfg) {
+            def->cfg(dev, def, DEVICE(OBJECT(dev)->parent));
+        }
+
+        if (def->memmap) {
+            SysBusDevice *busdev =3D
+                (SysBusDevice *)object_dynamic_cast(OBJECT(dev),
+                                                    TYPE_SYS_BUS_DEVICE);
+            if (!busdev) {
+                /* non-sysbus devices are not supported for now */
+                g_assert_not_reached();
+            }
+
+            qdev_realize_and_unref(DEVICE(busdev), bus, &error_fatal);
+        } else {
+            /* device is not connected to a bus */
+            qdev_realize_and_unref(dev, NULL, &error_fatal);
+        }
+    }
+}
+
+void ibex_map_devices(DeviceState **devices, MemoryRegion **mrs,
+                      const IbexDeviceDef *defs, unsigned count)
+{
+    for (unsigned idx =3D 0; idx < count; idx++) {
+        DeviceState *dev =3D devices[idx];
+        const IbexDeviceDef *def =3D &defs[idx];
+
+        if (def->memmap) {
+            SysBusDevice *busdev =3D
+                (SysBusDevice *)object_dynamic_cast(OBJECT(dev),
+                                                    TYPE_SYS_BUS_DEVICE);
+            if (busdev) {
+                const MemMapEntry *memmap =3D def->memmap;
+                unsigned mem =3D 0;
+                while (memmap->size) {
+                    unsigned region =3D IBEX_MEMMAP_GET_REGIDX(memmap->base);
+                    MemoryRegion *mr =3D mrs[region];
+                    if (mr) {
+                        ibex_mmio_map_device(busdev, mr, mem,
+                                             IBEX_MEMMAP_GET_ADDRESS(
+                                                 memmap->base));
+                    }
+                    mem++;
+                    memmap++;
+                }
+            }
+        }
+    }
+}
+
+void ibex_connect_devices(DeviceState **devices, const IbexDeviceDef *defs,
+                          unsigned count)
+{
+    /* Connect GPIOs (in particular, IRQs) */
+    for (unsigned idx =3D 0; idx < count; idx++) {
+        DeviceState *dev =3D devices[idx];
+        const IbexDeviceDef *def =3D &defs[idx];
+
+        if (def->gpio) {
+            const IbexGpioConnDef *conn =3D def->gpio;
+            while (conn->out.num >=3D 0 && conn->in.num >=3D 0) {
+                qemu_irq in_gpio =3D
+                    qdev_get_gpio_in_named(devices[conn->in.index],
+                                           conn->in.name, conn->in.num);
+
+                qdev_connect_gpio_out_named(dev, conn->out.name, conn->out.n=
um,
+                                            in_gpio);
+                conn++;
+            }
+        }
+    }
+}
+
+void ibex_configure_devices(DeviceState **devices, BusState *bus,
+                            const IbexDeviceDef *defs, unsigned count)
+{
+    ibex_link_devices(devices, defs, count);
+    ibex_define_device_props(devices, defs, count);
+    ibex_realize_devices(devices, bus, defs, count);
+    ibex_connect_devices(devices, defs, count);
+}
+
+void ibex_unimp_configure(DeviceState *dev, const IbexDeviceDef *def,
+                          DeviceState *parent)
+{
+    if (def->name) {
+        qdev_prop_set_string(dev, "name", def->name);
+    }
+    assert(def->memmap !=3D NULL);
+    assert(def->memmap->size !=3D 0);
+    qdev_prop_set_uint64(dev, "size", def->memmap->size);
+}
+
+void ibex_load_kernel(AddressSpace *as)
+{
+    MachineState *ms =3D MACHINE(qdev_get_machine());
+
+    /* load kernel if provided */
+    if (ms->kernel_filename) {
+        uint64_t kernel_entry;
+        if (load_elf_ram_sym(ms->kernel_filename, NULL, NULL, NULL,
+                             &kernel_entry, NULL, NULL, NULL, 0, EM_RISCV, 1=
, 0,
+                             as, true, NULL) <=3D 0) {
+            error_report("Cannot load ELF kernel %s", ms->kernel_filename);
+            exit(EXIT_FAILURE);
+        }
+
+        CPUState *cpu;
+        CPU_FOREACH(cpu) {
+            if (!as || cpu->as =3D=3D as) {
+                CPURISCVState *env =3D &RISCV_CPU(cpu)->env;
+                env->resetvec =3D (target_ulong)kernel_entry;
+            }
+        }
+    }
+}
+
+uint64_t ibex_get_current_pc(void)
+{
+    CPUState *cs =3D current_cpu;
+
+    return cs && cs->cc->get_pc ? cs->cc->get_pc(cs) : 0u;
+}
+
+/* x0 is replaced with PC */
+static const char ibex_ireg_names[32u][4u] =3D {
+    "pc", "ra", "sp", "gp", "tp",  "t0",  "t1", "t2", "s0", "s1", "a0",
+    "a1", "a2", "a3", "a4", "a5",  "a6",  "a7", "s2", "s3", "s4", "s5",
+    "s6", "s7", "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6",
+};
+
+void ibex_log_vcpu_registers(uint64_t regbm)
+{
+    CPURISCVState *env =3D &RISCV_CPU(current_cpu)->env;
+    qemu_log_mask(CPU_LOG_TB_IN_ASM, "\n....\n");
+    if (regbm & 0x1u) {
+        qemu_log_mask(CPU_LOG_TB_IN_ASM, "%4s: 0x" TARGET_FMT_lx "\n",
+                      ibex_ireg_names[0], env->pc);
+    }
+    for (unsigned gix =3D 1u; gix < 32u; gix++) {
+        uint64_t mask =3D 1u << gix;
+        if (regbm & mask) {
+            qemu_log_mask(CPU_LOG_TB_IN_ASM, "%4s: 0x" TARGET_FMT_lx "\n",
+                          ibex_ireg_names[gix], env->gpr[gix]);
+        }
+    }
+}
+
+/*
+ * Note: this is not specific to Ibex, and might apply to any vCPU.
+ */
+static void hmp_info_ibex(Monitor *mon, const QDict *qdict)
+{
+    CPUState *cpu;
+
+    CPU_FOREACH(cpu) {
+        vaddr pc;
+        const char *symbol;
+        if (cpu->cc->get_pc) {
+            pc =3D cpu->cc->get_pc(cpu);
+            symbol =3D lookup_symbol(pc);
+        } else {
+            pc =3D -1;
+            symbol =3D "?";
+        }
+        monitor_printf(mon, "* CPU #%d: 0x%" PRIx64 " in '%s'\n",
+                       cpu->cpu_index, (uint64_t)pc, symbol);
+    }
+}
+
+static void ibex_register_types(void)
+{
+    monitor_register_hmp("ibex", true, &hmp_info_ibex);
+}
+
+type_init(ibex_register_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 533472e22a..70d63f56b5 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -3,6 +3,7 @@ riscv_ss.add(files('boot.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
+riscv_ss.add(when: 'CONFIG_IBEX_COMMON', if_true: files('ibex_common.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
diff --git a/include/hw/riscv/ibex_common.h b/include/hw/riscv/ibex_common.h
new file mode 100644
index 0000000000..6c7dae5cbe
--- /dev/null
+++ b/include/hw/riscv/ibex_common.h
@@ -0,0 +1,322 @@
+/*
+ * QEMU RISC-V Helpers for LowRISC OpenTitan EarlGrey and related systems
+ *
+ * Copyright (c) 2022-2023 Rivos, Inc.
+ *
+ * Author(s):
+ *  Emmanuel Blot <eblot@rivosinc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_IBEX_COMMON_H
+#define HW_RISCV_IBEX_COMMON_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "exec/hwaddr.h"
+#include "hw/qdev-core.h"
+
+
+/* ------------------------------------------------------------------------ =
*/
+/* Devices & GPIOs */
+/* ------------------------------------------------------------------------ =
*/
+
+#define IBEX_MAX_MMIO_ENTRIES 4u
+#define IBEX_MAX_GPIO_ENTRIES 16u
+
+typedef struct IbexDeviceDef IbexDeviceDef;
+
+typedef void (*ibex_dev_cfg_fn)(DeviceState *dev, const IbexDeviceDef *def,
+                                DeviceState *parent);
+
+/**
+ * Structure defining a GPIO connection (in particular, IRQs) from the curre=
nt
+ * device to a target device
+ */
+typedef struct {
+    /** Source GPIO */
+    struct {
+        /** Name of source GPIO array or NULL for unnamed */
+        const char *name;
+        /** Index of source output GPIO */
+        int num;
+    } out;
+
+    /** Target GPIO */
+    struct {
+        /** Target device index */
+        int index;
+        /** Name of target input GPIO array or NULL for unnamed */
+        const char *name;
+        /** Index of target input GPIO */
+        int num;
+    } in;
+} IbexGpioConnDef;
+
+typedef struct {
+    /** Name of the property to assign the linked device to */
+    const char *propname;
+    /** Linked device index */
+    int index;
+} IbexDeviceLinkDef;
+
+/** Type of device property */
+typedef enum {
+    IBEX_PROP_TYPE_BOOL,
+    IBEX_PROP_TYPE_INT,
+    IBEX_PROP_TYPE_UINT,
+    IBEX_PROP_TYPE_STR,
+} IbexPropertyType;
+
+typedef struct {
+    /** Name of the property */
+    const char *propname;
+    /** Type of property */
+    IbexPropertyType type;
+    /** Value */
+    union {
+        bool b;
+        int64_t i;
+        uint64_t u;
+        const char *s;
+    };
+} IbexDevicePropDef;
+
+struct IbexDeviceDef {
+    /** Registered type of the device */
+    const char *type;
+    /** Optional name, may be NULL */
+    const char *name;
+    /** Instance number, default to 0 */
+    int instance;
+    /** Optional configuration function */
+    ibex_dev_cfg_fn cfg;
+    /** Array of memory map */
+    const MemMapEntry *memmap;
+    /** Array of GPIO connections */
+    const IbexGpioConnDef *gpio;
+    /** Array of linked devices */
+    const IbexDeviceLinkDef *link;
+    /** Array of properties */
+    const IbexDevicePropDef *prop;
+};
+
+/*
+ * Special memory address marked to flag a special MemMapEntry.
+ * Flagged MemMapEntry are used to select a memory region while mem mapping
+ * devices. There could be up to 4 different regions.
+ */
+#define IBEX_MEMMAP_REGIDX_COUNT 4u
+#define IBEX_MEMMAP_REGIDX_MASK \
+    ((IBEX_MEMMAP_REGIDX_COUNT) - 1u) /* address are always word-aligned */
+#define IBEX_MEMMAP_MAKE_REG(_addr_, _flag_) \
+    ((_addr_) | ((_flag_) & IBEX_MEMMAP_REGIDX_MASK))
+#define IBEX_MEMMAP_GET_REGIDX(_addr_) ((_addr_) & IBEX_MEMMAP_REGIDX_MASK)
+#define IBEX_MEMMAP_GET_ADDRESS(_addr_) ((_addr_) & ~IBEX_MEMMAP_REGIDX_MASK)
+
+/**
+ * Create memory map entries, each arg is MemMapEntry definition
+ */
+#define MEMMAPENTRIES(...) \
+    (const MemMapEntry[]) \
+    { \
+        __VA_ARGS__, \
+        { \
+            .size =3D 0u \
+        } \
+    }
+
+/**
+ * Create GPIO connection entries, each arg is IbexGpioConnDef definition
+ */
+#define IBEXGPIOCONNDEFS(...) \
+    (const IbexGpioConnDef[]) \
+    { \
+        __VA_ARGS__, \
+        { \
+            .out =3D {.num =3D -1 } \
+        } \
+    }
+
+/**
+ * Create device link entries, each arg is IbexDeviceLinkDef definition
+ */
+#define IBEXDEVICELINKDEFS(...) \
+    (const IbexDeviceLinkDef[]) \
+    { \
+        __VA_ARGS__, \
+        { \
+            .propname =3D NULL \
+        } \
+    }
+
+/**
+ * Create device property entries, each arg is IbexDevicePropDef definition
+ */
+#define IBEXDEVICEPROPDEFS(...) \
+    (const IbexDevicePropDef[]) \
+    { \
+        __VA_ARGS__, \
+        { \
+            .propname =3D NULL \
+        } \
+    }
+
+/**
+ * Create a IbexGpioConnDef to connect two unnamed GPIOs
+ */
+#define IBEX_GPIO(_irq_, _in_idx_, _num_) \
+    { \
+        .out =3D { \
+            .num =3D (_irq_), \
+        }, \
+        .in =3D { \
+            .index =3D (_in_idx_), \
+            .num =3D (_num_), \
+        } \
+    }
+
+/**
+ * Create a IbexGpioConnDef to connect a SysBus IRQ to an unnamed GPIO
+ */
+#define IBEX_GPIO_SYSBUS_IRQ(_irq_, _in_idx_, _num_) \
+    { \
+        .out =3D { \
+            .name =3D SYSBUS_DEVICE_GPIO_IRQ, \
+            .num =3D (_irq_), \
+        }, \
+        .in =3D { \
+            .index =3D (_in_idx_), \
+            .num =3D (_num_), \
+        } \
+    }
+
+/**
+ * Create a IbexLinkDeviceDef to link one device to another
+ */
+#define IBEX_DEVLINK(_pname_, _idx_) \
+    { \
+        .propname =3D (_pname_), .index =3D (_idx_), \
+    }
+
+/**
+ * Create a boolean device property
+ */
+#define IBEX_DEV_BOOL_PROP(_pname_, _b_) \
+    { \
+        .propname =3D (_pname_), .type =3D IBEX_PROP_TYPE_BOOL, .b =3D (_b_)=
, \
+    }
+
+/**
+ * Create a signed integer device property
+ */
+#define IBEX_DEV_INT_PROP(_pname_, _i_) \
+    { \
+        .propname =3D (_pname_), .type =3D IBEX_PROP_TYPE_INT, .i =3D (_i_),=
 \
+    }
+
+/**
+ * Create an unsigned integer device property
+ */
+#define IBEX_DEV_UINT_PROP(_pname_, _u_) \
+    { \
+        .propname =3D (_pname_), .type =3D IBEX_PROP_TYPE_UINT, .u =3D (_u_)=
, \
+    }
+
+/**
+ * Create a string device property
+ */
+#define IBEX_DEV_STRING_PROP(_pname_, _s_) \
+    { \
+        .propname =3D (_pname_), .type =3D IBEX_PROP_TYPE_STR, .s =3D (_s_),=
 \
+    }
+
+DeviceState **ibex_create_devices(const IbexDeviceDef *defs, unsigned count,
+                                  DeviceState *parent);
+void ibex_link_devices(DeviceState **devices, const IbexDeviceDef *defs,
+                       unsigned count);
+void ibex_define_device_props(DeviceState **devices, const IbexDeviceDef *de=
fs,
+                              unsigned count);
+void ibex_realize_system_devices(DeviceState **devices,
+                                 const IbexDeviceDef *defs, unsigned count);
+void ibex_realize_devices(DeviceState **devices, BusState *bus,
+                          const IbexDeviceDef *defs, unsigned count);
+void ibex_connect_devices(DeviceState **devices, const IbexDeviceDef *defs,
+                          unsigned count);
+void ibex_map_devices(DeviceState **devices, MemoryRegion **mrs,
+                      const IbexDeviceDef *defs, unsigned count);
+void ibex_configure_devices(DeviceState **devices, BusState *bus,
+                            const IbexDeviceDef *defs, unsigned count);
+
+/**
+ * Utility function to configure unimplemented device.
+ * The Ibex device definition should have one defined memory entry, and an
+ * optional name.
+ */
+void ibex_unimp_configure(DeviceState *dev, const IbexDeviceDef *def,
+                          DeviceState *parent);
+
+/* ------------------------------------------------------------------------ =
*/
+/* CPU */
+/* ------------------------------------------------------------------------ =
*/
+
+/**
+ * Load an ELF application into a CPU address space.
+ * @as the address space to load the application into, maybe NULL to use the
+ * default address space
+ */
+void ibex_load_kernel(AddressSpace *as);
+
+/**
+ * Helper for device debugging: report the current guest PC, if any.
+ *
+ * If a HW access is performed from another device but the CPU, reported PC
+ * is 0.
+ */
+uint64_t ibex_get_current_pc(void);
+
+enum {
+    RV_GPR_PC =3D (1u << 0u),
+    RV_GPR_RA =3D (1u << 1u),
+    RV_GPR_SP =3D (1u << 2u),
+    RV_GPR_GP =3D (1u << 3u),
+    RV_GPR_TP =3D (1u << 4u),
+    RV_GPR_T0 =3D (1u << 5u),
+    RV_GPR_T1 =3D (1u << 6u),
+    RV_GPR_T2 =3D (1u << 7u),
+    RV_GPR_S0 =3D (1u << 8u),
+    RV_GPR_S1 =3D (1u << 9u),
+    RV_GPR_A0 =3D (1u << 10u),
+    RV_GPR_A1 =3D (1u << 11u),
+    RV_GPR_A2 =3D (1u << 12u),
+    RV_GPR_A3 =3D (1u << 13u),
+    RV_GPR_A4 =3D (1u << 14u),
+    RV_GPR_A5 =3D (1u << 15u),
+    RV_GPR_A6 =3D (1u << 16u),
+    RV_GPR_A7 =3D (1u << 17u),
+    RV_GPR_S2 =3D (1u << 18u),
+    RV_GPR_S3 =3D (1u << 19u),
+    RV_GPR_S4 =3D (1u << 20u),
+    RV_GPR_S5 =3D (1u << 21u),
+    RV_GPR_S6 =3D (1u << 22u),
+    RV_GPR_S7 =3D (1u << 23u),
+    RV_GPR_S8 =3D (1u << 24u),
+    RV_GPR_S9 =3D (1u << 25u),
+    RV_GPR_S10 =3D (1u << 26u),
+    RV_GPR_S11 =3D (1u << 27u),
+    RV_GPR_T3 =3D (1u << 28u),
+    RV_GPR_T4 =3D (1u << 29u),
+    RV_GPR_T5 =3D (1u << 30u),
+    RV_GPR_T6 =3D (1u << 31u),
+};
+
+/**
+ * Log current vCPU registers.
+ *
+ * @regbm is a bitmap of registers to be dumped [x1..t6], pc replace x0
+ */
+void ibex_log_vcpu_registers(uint64_t regbm);
+
+#endif /* HW_RISCV_IBEX_COMMON_H */
--=20
2.49.1


