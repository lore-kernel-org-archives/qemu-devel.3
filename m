Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E758CC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 18:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXPuw-0004L5-3k; Fri, 26 Jul 2024 14:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sXPus-0004Ao-H4; Fri, 26 Jul 2024 14:43:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gregorhaas1997@gmail.com>)
 id 1sXPuo-0005iu-In; Fri, 26 Jul 2024 14:43:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso830492b3a.0; 
 Fri, 26 Jul 2024 11:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722019421; x=1722624221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSzL0j+2QLWemXLbTj2Y1SLqSHWS70nOxooQxIQySMQ=;
 b=d4zQ2VdXbfo4Hvq0+KgQMD2adeX7sDrPhRL3r9gIIUs0HrhxtuAO8sPaJJYIcsSw5c
 G+WXZtbZAZw4Cg3T+jeQ2YgrZ9HASJNZIxa3lMIhbKet65D9WVKeeXM5gInJffB4M9Tk
 nHSLoKrjhAkgr6UVBXix9mEaHRFvRaEReuiTGILkQH3Ynd5w9ro1wMaAUdsOXGCzCDVm
 cqc73evY9Vwr7eABhXD8wNAw+EZsoJEQ128mpNutDESlxBDrb6yvs3/8tEtLF8pDZnnT
 etL48YDWV4+o38DJFH80LIJUXSIgMuuVIiuqXLDRHmYvTPfdUkV8Q9qpB+U76GtRSET8
 Bm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722019421; x=1722624221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSzL0j+2QLWemXLbTj2Y1SLqSHWS70nOxooQxIQySMQ=;
 b=TyOikrqLX43QLgx74gGSHUWi7V4vAJ6dF4Eo8t9gSSg8d0Ejkb1TSkhrWR78O6AN9D
 yldL34aAFr7S1nnx2D0hgXRXPIM38XPaw00jCoYbQr5HPIw2+YUxtgPA9Ioodwv1+g74
 bWOkpe4C1XGEpMBCe0cyzxDXUXTKfwD6VuhTgDWe01arynFh/r5eHVZGa4bv1l/AbCSX
 jUW/syBjN1WOVo5+Y51OBu8uz6J2rdIcnMERz2FrTJibhJMbpZ2bmzYSr2zWL7utnvCB
 ZhdS4Orr0aIRccJ2qUGvcaL5TDBR6E9I1rZcjg4DMUsd0J8AdhLlJ0JeIoF5YB4klY+o
 tWcA==
X-Gm-Message-State: AOJu0Yww539XqMI+SHtbxEPLmce6D9dojePqsdLgZWizZjlIJxEiwZPG
 jBXAi8MgRgioJP1mL7TSjhxXQjSlsAVXHEokbqtwK/Hx+ihgB6nUzirtRdYY
X-Google-Smtp-Source: AGHT+IEpYC7c2AjOLe7v+qCkgRgkNxAoFFYb9AT0gKW8xxTFgLcDSivTx3cZnV3MHuLAEXyZNYRsrA==
X-Received: by 2002:a17:902:e549:b0:1f9:d6bf:a67c with SMTP id
 d9443c01a7336-1ff04a2397amr7375955ad.5.1722019420564; 
 Fri, 26 Jul 2024 11:43:40 -0700 (PDT)
Received: from localhost ([205.175.106.198])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fed7d29766sm36224775ad.110.2024.07.26.11.43.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 11:43:40 -0700 (PDT)
From: Gregor Haas <gregorhaas1997@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, dbarboza@ventanamicro.com,
 alistair.francis@wdc.com, Gregor Haas <gregorhaas1997@gmail.com>
Subject: [PATCH v2 1/1] Add support for generating OpenSBI domains in the
 device tree
Date: Fri, 26 Jul 2024 11:43:24 -0700
Message-ID: <20240726184324.597939-2-gregorhaas1997@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726184324.597939-1-gregorhaas1997@gmail.com>
References: <20240726184324.597939-1-gregorhaas1997@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gregorhaas1997@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

OpenSBI has support for domains, which are partitions of CPUs and memory into
isolated compartments. Domains can be specified in the device tree according to
a standardized format [1], which OpenSBI parses at boot time to initialize all
system domains. This patch enables simply specifying domains (and their
associated memory regions) on the QEMU command line, from which these are then
rendered into the machine's device tree. A simple example of what this looks
like is below:

qemu-system-riscv64 -machine virt -bios fw_jump.bin -cpu max -smp 2 -m 4G \
	-device opensbi-memregion,id=mem,base=0x178000000,size=0x4000000,mmio=false \
	-device opensbi-domain,possible-harts=0x2,boot-hart=0x1,next-addr=0x178000000,next-mode=1,region0=mem,perms0=0x3f

At machine initialization time, a new create_fdt_opensbi_domains() function
walks the peripherals/peripherals-anon containers, identifies all domains and
memregions, and parses them into the relevant device tree structures.

[1] https://github.com/riscv-software-src/opensbi/blob/master/docs/domain_support.md

Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
---
 MAINTAINERS                       |   7 +
 hw/riscv/Kconfig                  |   4 +
 hw/riscv/meson.build              |   1 +
 hw/riscv/opensbi_domain.c         | 428 ++++++++++++++++++++++++++++++
 hw/riscv/virt.c                   |   3 +
 include/hw/riscv/opensbi_domain.h |  51 ++++
 6 files changed, 494 insertions(+)
 create mode 100644 hw/riscv/opensbi_domain.c
 create mode 100644 include/hw/riscv/opensbi_domain.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 98eddf7ae1..796c023a7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -355,6 +355,13 @@ F: target/riscv/XVentanaCondOps.decode
 F: target/riscv/insn_trans/trans_xventanacondops.c.inc
 F: disas/riscv-xventana*
 
+RISC-V OpenSBI domain support
+M: Gregor Haas <gregorhaas1997@gmail.com>
+L: qemu-riscv@nongnu.org
+S: Maintained
+F: hw/riscv/opensbi_domain.c
+F: include/hw/riscv/opensbi_domain.h
+
 RENESAS RX CPUs
 R: Yoshinori Sato <ysato@users.sourceforge.jp>
 S: Orphan
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a2030e3a6f..db3a4d77ad 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,6 +1,9 @@
 config RISCV_NUMA
     bool
 
+config RISCV_OPENSBI_DOMAIN
+    bool
+
 config IBEX
     bool
 
@@ -40,6 +43,7 @@ config RISCV_VIRT
     imply TPM_TIS_SYSBUS
     select DEVICE_TREE
     select RISCV_NUMA
+    select RISCV_OPENSBI_DOMAIN
     select GOLDFISH_RTC
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index f872674093..f47626c164 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,6 +1,7 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_OPENSBI_DOMAIN', if_true: files('opensbi_domain.c'))
 riscv_ss.add(files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
diff --git a/hw/riscv/opensbi_domain.c b/hw/riscv/opensbi_domain.c
new file mode 100644
index 0000000000..418ebe1e56
--- /dev/null
+++ b/hw/riscv/opensbi_domain.c
@@ -0,0 +1,428 @@
+#include "qemu/osdep.h"
+#include "hw/riscv/opensbi_domain.h"
+#include "hw/boards.h"
+#include "sysemu/device_tree.h"
+#include "qapi/error.h"
+
+#include <libfdt.h>
+
+static void create_fdt_domain_possible_harts(MachineState *ms,
+                                             OpenSBIDomainState *s,
+                                             char *path) {
+    unsigned long i, cpu;
+    int num_cpus;
+
+    num_cpus = ctpop64(s->possible_harts);
+    if (num_cpus) {
+        g_autofree uint32_t *phandles = g_malloc0_n(num_cpus, sizeof(uint32_t));
+
+        for (i = 0, cpu = -1; i < num_cpus; i++) {
+            cpu = find_next_bit(&s->possible_harts, BITS_PER_LONG, cpu + 1);
+            g_autofree char *cpu_name = g_strdup_printf("/cpus/cpu@%li", cpu);
+            phandles[i] = cpu_to_fdt32(qemu_fdt_get_phandle(
+                    ms->fdt, cpu_name));
+        }
+
+        qemu_fdt_setprop(ms->fdt, path, "possible-harts",
+                         phandles, num_cpus * 4);
+    }
+}
+
+static void create_fdt_domain_regions(MachineState *ms,
+                                      OpenSBIDomainState *s,
+                                      char *path) {
+    unsigned long i;
+    int num_regions = 0;
+    DeviceState *ds;
+
+    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
+        if (s->regions[i]) {
+            num_regions++;
+        }
+    }
+
+    if (num_regions) {
+        g_autofree uint32_t *regions =
+                 g_malloc0_n(num_regions, 2 * sizeof(uint32_t));
+        for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
+            if (s->regions[i]) {
+                ds = DEVICE(s->regions[i]);
+                g_autofree char *region_name = g_strdup_printf(
+                       "/chosen/opensbi-domains/%s", ds->id);
+                regions[2 * i] = cpu_to_fdt32(qemu_fdt_get_phandle
+                        (ms->fdt, region_name));
+                regions[2 * i + 1] = cpu_to_fdt32(s->region_perms[i]);
+            }
+        }
+
+        qemu_fdt_setprop(ms->fdt, path, "regions",
+                         regions, num_regions * 8);
+    }
+}
+
+struct DomainFDTState {
+    MachineState *ms;
+    bool regions;
+};
+
+static void create_fdt_one_domain(MachineState *ms, OpenSBIDomainState *s)
+{
+    DeviceState *ds = DEVICE(s);
+    g_autofree char *path, *cpu_name;
+
+    if (ds->id) {
+        path = g_strdup_printf("/chosen/opensbi-domains/%s",
+                               ds->id);
+    } else {
+        path = g_strdup_printf("/chosen/opensbi-domains/domain@%lx",
+                               s->next_addr);
+    }
+
+    qemu_fdt_add_subnode(ms->fdt, path);
+    qemu_fdt_setprop_string(ms->fdt, path, "compatible",
+                            "opensbi,domain,instance");
+    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
+                           qemu_fdt_alloc_phandle(ms->fdt));
+
+    create_fdt_domain_possible_harts(ms, s, path);
+    create_fdt_domain_regions(ms, s, path);
+
+    /* Assign boot hart to this domain */
+    cpu_name = g_strdup_printf("/cpus/cpu@%i", s->boot_hart);
+    qemu_fdt_setprop_cell(ms->fdt, path, "boot-hart",
+                          qemu_fdt_get_phandle(ms->fdt, cpu_name));
+    if (s->assign) {
+        qemu_fdt_setprop_cell(ms->fdt, cpu_name, "opensbi-domain",
+                              qemu_fdt_get_phandle(ms->fdt, path));
+    }
+
+    qemu_fdt_setprop_cells(ms->fdt, path, "next-arg1",
+                           (uint64_t) s->next_arg1 >> 32, s->next_arg1);
+    qemu_fdt_setprop_cells(ms->fdt, path, "next-addr",
+                           (uint64_t) s->next_addr >> 32, s->next_addr);
+    qemu_fdt_setprop_cell(ms->fdt, path, "next-mode",
+                          s->next_mode);
+
+    if (s->system_reset_allowed) {
+        qemu_fdt_setprop(ms->fdt, path, "system-reset-allowed", NULL, 0);
+    }
+
+    if (s->system_suspend_allowed) {
+        qemu_fdt_setprop(ms->fdt, path, "system-suspend-allowed", NULL, 0);
+    }
+}
+
+static void create_fdt_one_memregion(MachineState *ms,
+                                     OpenSBIMemregionState *s)
+{
+    g_autofree char *path;
+    int i, dev, num_devices;
+    DeviceState *ds = DEVICE(s);
+
+    path = g_strdup_printf("/chosen/opensbi-domains/%s", ds->id);
+    qemu_fdt_add_subnode(ms->fdt, path);
+    qemu_fdt_setprop_string(ms->fdt, path, "compatible",
+                            "opensbi,domain,memregion");
+    qemu_fdt_setprop_cells(ms->fdt, path, "base",
+                           (uint64_t) s->base >> 32, s->base);
+
+    qemu_fdt_setprop_cell(ms->fdt, path, "order",
+                          (uint32_t) s->order);
+
+    if (s->mmio) {
+        qemu_fdt_setprop(ms->fdt, path, "mmio", NULL, 0);
+
+        /* Get all phandles for related devices */
+        num_devices = 0;
+        for (i = 0; i < OPENSBI_MEMREGION_DEVICES_MAX; i++) {
+            if (s->devices[i]) {
+                num_devices++;
+            }
+        }
+
+        g_autofree uint32_t *devices =
+                g_malloc0_n(num_devices, sizeof(uint32_t));
+        for (i = 0, dev = 0; i < OPENSBI_MEMREGION_DEVICES_MAX; i++) {
+            if (s->devices[i]) {
+                devices[dev++] = cpu_to_fdt32(
+                        qemu_fdt_get_phandle(ms->fdt, s->devices[i]));
+            }
+        }
+
+        qemu_fdt_setprop(ms->fdt, path, "devices", devices, num_devices * 4);
+    }
+
+    qemu_fdt_setprop_cells(ms->fdt, path, "phandle",
+                           qemu_fdt_alloc_phandle(ms->fdt));
+}
+
+static int create_fdt_domains(Object *obj, void *opaque)
+{
+    struct DomainFDTState *dfs = opaque;
+    OpenSBIDomainState *osds;
+    OpenSBIMemregionState *osms;
+
+    osds = (OpenSBIDomainState *)
+            object_dynamic_cast(obj, TYPE_OPENSBI_DOMAIN);
+    osms = (OpenSBIMemregionState *)
+            object_dynamic_cast(obj, TYPE_OPENSBI_MEMREGION);
+
+    if (dfs->regions) {
+        if (osms) {
+            create_fdt_one_memregion(dfs->ms, osms);
+        }
+    } else {
+        if (osds) {
+            create_fdt_one_domain(dfs->ms, osds);
+        }
+    }
+
+    return 0;
+}
+
+static const char *containers[] = {
+        "/peripheral", "/peripheral-anon"
+};
+
+void create_fdt_opensbi_domains(MachineState *s)
+{
+    int i;
+    MachineState *ms = MACHINE(s);
+    Object *container;
+
+    struct DomainFDTState check = {
+            .ms = ms,
+            .regions = true
+    };
+
+    /* Make sure that top-level node exists */
+    qemu_fdt_add_subnode(ms->fdt, "/chosen/opensbi-domains");
+    qemu_fdt_setprop_string(ms->fdt, "/chosen/opensbi-domains",
+                            "compatible", "opensbi,domain,config");
+
+    /* Do a scan through regions first */
+    for (i = 0; i < ARRAY_SIZE(containers); i++) {
+        container = container_get(OBJECT(s), containers[i]);
+        object_child_foreach(container, create_fdt_domains, &check);
+    }
+
+    /* Then scan through domains */
+    check.regions = false;
+    for (i = 0; i < ARRAY_SIZE(containers); i++) {
+        container = container_get(OBJECT(s), containers[i]);
+        object_child_foreach(container, create_fdt_domains, &check);
+    }
+}
+
+/* OpenSBI Memregions */
+
+static void set_mmio(Object *obj, bool val, Error **err)
+{
+    OpenSBIMemregionState *s = OPENSBI_MEMREGION(obj);
+    s->mmio = val;
+}
+
+static void set_device(Object *obj, const char *val, Error **err)
+{
+    int i;
+    OpenSBIMemregionState *s = OPENSBI_MEMREGION(obj);
+
+    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
+        if (!s->devices[i]) {
+            s->devices[i] = g_strdup(val);
+            break;
+        }
+    }
+}
+
+static void opensbi_memregion_instance_init(Object *obj)
+{
+    int i;
+    OpenSBIMemregionState *s = OPENSBI_MEMREGION(obj);
+
+    object_property_add_uint64_ptr(obj, "base", &s->base,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "base",
+                                    "The base address of the domain memory region. If \"order\" is also specified, "
+                                    "this property should be a 2 ^ order aligned 64 bit address");
+
+    object_property_add_uint32_ptr(obj, "order", &s->order,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "order",
+                                    "The order of the domain memory region. This property should have a 32 bit value "
+                                    "(i.e. one DT cell) in the range 3 <= order <= __riscv_xlen.");
+
+    object_property_add_bool(obj, "mmio", NULL, set_mmio);
+    object_property_set_description(obj, "mmio",
+                                    "A boolean flag representing whether the domain memory region is a "
+                                    "memory-mapped I/O (MMIO) region.");
+
+    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
+        g_autofree char *propname = g_strdup_printf("device%i", i);
+        object_property_add_str(obj, propname, NULL, set_device);
+
+        g_autofree char *description = g_strdup_printf(
+                "Device %i (out of %i) for this memregion. This property should be a device tree path to the device.",
+                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
+        object_property_set_description(obj, propname, description);
+    }
+}
+
+static void opensbi_memregion_realize(DeviceState *ds, Error **errp)
+{
+    #if defined(TARGET_RISCV32)
+    int xlen = 32;
+    #elif defined(TARGET_RISCV64)
+    int xlen = 64;
+    #endif
+
+    OpenSBIMemregionState *s = OPENSBI_MEMREGION(ds);
+
+    if (!s->base) {
+        error_setg(errp, "Must specify base");
+        return;
+    }
+
+    /* Check order bounds */
+    if (s->order < 3) {
+        error_setg(errp, "Order too small");
+        return;
+    }
+
+    if (s->order > xlen) {
+        error_setg(errp, "Order too big");
+        return;
+    }
+
+    /* Check base alignment */
+    if (s->order < xlen && (s->base & (BIT(s->order) - 1))) {
+        error_setg(errp, "Base not aligned to order");
+        return;
+    }
+}
+
+static void opensbi_memregion_class_init(ObjectClass *oc, void *opaque)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    dc->realize = opensbi_memregion_realize;
+}
+
+static const TypeInfo opensbi_memregion_info = {
+        .name = TYPE_OPENSBI_MEMREGION,
+        .parent = TYPE_DEVICE,
+        .instance_init = opensbi_memregion_instance_init,
+        .instance_size = sizeof(OpenSBIDomainState),
+        .class_init = opensbi_memregion_class_init
+};
+
+/* OpenSBI Domains */
+
+static void set_sysreset_allowed(Object *obj, bool val, Error **err)
+{
+    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
+    s->system_reset_allowed = val;
+}
+
+static void set_suspend_allowed(Object *obj, bool val, Error **err)
+{
+    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
+    s->system_suspend_allowed = val;
+}
+
+static void set_assign(Object *obj, bool val, Error **err)
+{
+    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
+    s->assign = val;
+}
+
+static void opensbi_domain_instance_init(Object *obj)
+{
+    int i;
+    OpenSBIDomainState *s = OPENSBI_DOMAIN(obj);
+
+    object_property_add_uint32_ptr(obj, "boot-hart", &s->boot_hart,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "boot-hart",
+                                    "The HART booting the domain instance.");
+
+    object_property_add_uint64_ptr(obj, "possible-harts", &s->possible_harts,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "possible-harts",
+                                    "The list of CPUs for the domain instance, encoded as a bitmask");
+
+    object_property_add_uint64_ptr(obj, "next-arg1", &s->next_arg1,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "next-arg1",
+                                    "The 64 bit next booting stage arg1 for the domain instance.");
+
+    object_property_add_uint64_ptr(obj, "next-addr", &s->next_addr,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "next-addr",
+                                    "The 64 bit next booting stage address for the domain instance.");
+
+    object_property_add_uint32_ptr(obj, "next-mode", &s->next_mode,
+                                   OBJ_PROP_FLAG_WRITE);
+    object_property_set_description(obj, "next-mode",
+                                    "The 32 bit next booting stage mode for the domain instance.");
+
+    object_property_add_bool(obj, "system-reset-allowed", NULL,
+                             set_sysreset_allowed);
+    object_property_set_description(obj, "system-reset-allowed",
+                                    "Whether the domain instance is allowed to do system reset.");
+
+    object_property_add_bool(obj, "system-suspend-allowed", NULL,
+                             set_suspend_allowed);
+    object_property_set_description(obj, "system-suspend-allowed",
+                                    "Whether the domain instance is allowed to do system suspend.");
+
+    for (i = 0; i < OPENSBI_DOMAIN_MEMREGIONS_MAX; i++) {
+        g_autofree char *reg_propname = g_strdup_printf("region%i", i);
+        object_property_add_link(obj, reg_propname, TYPE_OPENSBI_MEMREGION,
+                                 (Object **) &s->regions[i],
+                                 qdev_prop_allow_set_link_before_realize, 0);
+
+        g_autofree char *reg_description = g_strdup_printf(
+                "Region %i (out of %i) for this domain.",
+                i, OPENSBI_DOMAIN_MEMREGIONS_MAX);
+        object_property_set_description(obj, reg_propname, reg_description);
+
+        g_autofree char *perm_propname = g_strdup_printf("perms%i", i);
+        object_property_add_uint32_ptr(obj, perm_propname, &s->region_perms[i],
+                                       OBJ_PROP_FLAG_WRITE);
+
+        g_autofree char *perm_description = g_strdup_printf(
+                "Permissions for region %i for this domain.", i);
+        object_property_set_description(obj, perm_propname, perm_description);
+    }
+
+    object_property_add_bool(obj, "assign", NULL, set_assign);
+    object_property_set_description(obj, "assign",
+                                    "Whether to assign this domain to its boot hart.");
+}
+
+static void opensbi_domain_realize(DeviceState *ds, Error **errp)
+{
+    /* Nothing to do */
+}
+
+static void opensbi_domain_class_init(ObjectClass *oc, void *opaque)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    dc->realize = opensbi_domain_realize;
+}
+
+static const TypeInfo opensbi_domain_info = {
+        .name = TYPE_OPENSBI_DOMAIN,
+        .parent = TYPE_DEVICE,
+        .instance_init = opensbi_domain_instance_init,
+        .instance_size = sizeof(OpenSBIDomainState),
+        .class_init = opensbi_domain_class_init
+};
+
+static void opensbi_register_types(void)
+{
+    type_register_static(&opensbi_domain_info);
+    type_register_static(&opensbi_memregion_info);
+}
+
+type_init(opensbi_register_types)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9981e0f6c9..bb4bf3ce5b 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -55,6 +55,7 @@
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "hw/riscv/opensbi_domain.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia(RISCVVirtState *s)
@@ -1051,6 +1052,8 @@ static void finalize_fdt(RISCVVirtState *s)
     create_fdt_uart(s, virt_memmap, irq_mmio_phandle);
 
     create_fdt_rtc(s, virt_memmap, irq_mmio_phandle);
+
+    create_fdt_opensbi_domains(MACHINE(s));
 }
 
 static void create_fdt(RISCVVirtState *s, const MemMapEntry *memmap)
diff --git a/include/hw/riscv/opensbi_domain.h b/include/hw/riscv/opensbi_domain.h
new file mode 100644
index 0000000000..61bcf1a296
--- /dev/null
+++ b/include/hw/riscv/opensbi_domain.h
@@ -0,0 +1,51 @@
+
+#ifndef RISCV_DOMAIN_H
+#define RISCV_DOMAIN_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+#include "cpu.h"
+
+#define TYPE_OPENSBI_MEMREGION "opensbi-memregion"
+OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIMemregionState, OPENSBI_MEMREGION)
+
+#define OPENSBI_MEMREGION_DEVICES_MAX   16
+
+struct OpenSBIMemregionState {
+    /* public */
+    DeviceState parent_obj;
+
+    /* private */
+    uint64_t base;
+    uint32_t order;
+    bool mmio;
+    char *devices[OPENSBI_MEMREGION_DEVICES_MAX];
+};
+
+#define TYPE_OPENSBI_DOMAIN "opensbi-domain"
+OBJECT_DECLARE_SIMPLE_TYPE(OpenSBIDomainState, OPENSBI_DOMAIN)
+
+#define OPENSBI_DOMAIN_MEMREGIONS_MAX   16
+
+struct OpenSBIDomainState {
+    /* public */
+    DeviceState parent_obj;
+
+    /* private */
+    OpenSBIMemregionState *regions[OPENSBI_DOMAIN_MEMREGIONS_MAX];
+    unsigned int region_perms[OPENSBI_DOMAIN_MEMREGIONS_MAX];
+
+    unsigned long possible_harts;
+    unsigned int boot_hart;
+    uint64_t next_arg1;
+    uint64_t next_addr;
+    uint32_t next_mode;
+    bool system_reset_allowed;
+    bool system_suspend_allowed;
+
+    bool assign;
+};
+
+void create_fdt_opensbi_domains(MachineState *s);
+
+#endif /* RISCV_DOMAIN_H */
-- 
2.45.2


