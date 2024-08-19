Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBEFC52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 16:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4zF-0001vL-Rw; Mon, 19 Aug 2024 12:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg4zA-0001Z6-6I; Mon, 19 Aug 2024 12:12:00 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5961d01319=ian.brockbank@cirrus.com>)
 id 1sg4z6-0007Rb-8j; Mon, 19 Aug 2024 12:11:59 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JF7dSI014567;
 Mon, 19 Aug 2024 11:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 PODMain02222019; bh=OYxYjEmv+8IBn8zuhaulDEnH+AOoV5azivhId3Zg+tc=; b=
 hyzfEQJ8jPUAku7FJrzde37QYvrE3SslyUg9SE+uCuIUqhkMBi3tbz26izWl4mdp
 KswlCmtjpObU61avolQqKvuJZNBuQ2pHDHb0tKOHS8+GsSw5CvRSMtICoomzL86A
 W04PVNddsjZFuH3p3nPnSOCEv5v90sQFI746yYqALBGAsQQWB/l9izj0wYzAwrQ9
 NfT929AEJrUjhIpIMhtQ+bsH+ZTfnp1Oz/UzDCaop4ht1tl8JqL+BzaDHXkDVqA5
 vQwB9uQupSoGdSFZ80/ljjygNSh8i3qZHYWfhZcy6LZAX0ogCKmJSgDXX3jsDec5
 tZAGy6vSILDee0CFIhe93Q==
Received: from ausex01.ad.cirrus.com ([141.131.3.19])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 412r9hsxbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Aug 2024 11:11:47 -0500 (CDT)
Received: from ausex01.ad.cirrus.com (141.131.37.95) by ausex01.ad.cirrus.com
 (141.131.37.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 19 Aug
 2024 11:11:46 -0500
Received: from EDIN7BQBTG3.ad.cirrus.com (141.131.38.212) by
 anon-ausex01.ad.cirrus.com (141.131.37.95) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 19 Aug 2024 11:11:39 -0500
From: Ian Brockbank <Ian.Brockbank@cirrus.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
CC: Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis
 <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Ian Brockbank
 <ian.brockbank@cirrus.com>, Ian Brockbank <Ian.Brockbank@cirrus.com>
Subject: [PATCH 10/11 v2] hw/riscv: add CLIC into virt machine
Date: Mon, 19 Aug 2024 17:02:21 +0100
Message-ID: <20240819160742.27586-14-Ian.Brockbank@cirrus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
References: <https://lists.gnu.org/archive/html/qemu-riscv/2024-08/msg00234.html>
 <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Proofpoint-GUID: ov-vTmIYCBI2zn1UzUAR-hZOL9kNRO3k
X-Proofpoint-ORIG-GUID: ov-vTmIYCBI2zn1UzUAR-hZOL9kNRO3k
X-Proofpoint-Spam-Reason: orgsafe
Received-SPF: pass client-ip=67.231.152.168;
 envelope-from=prvs=5961d01319=ian.brockbank@cirrus.com;
 helo=mx0b-001ae601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Ian Brockbank<ian.brockbank@cirrus.com>
---
 hw/riscv/virt.c         | 235 +++++++++++++++++++++++++++++++++++++++-
 include/hw/riscv/virt.h |  35 ++++++
 2 files changed, 267 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index cef41c150a..68d614ad5c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1,4 +1,4 @@
-/*
+ /*
  * QEMU RISC-V VirtIO Board
  *
  * Copyright (c) 2017 SiFive, Inc.
@@ -39,6 +39,7 @@
 #include "hw/firmware/smbios.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
+#include "hw/intc/riscv_clic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
 #include "hw/platform-bus.h"
@@ -72,6 +73,7 @@ static const MemMapEntry virt_memmap[] =3D {
     [VIRT_MROM] =3D         {     0x1000,        0xf000 },
     [VIRT_TEST] =3D         {   0x100000,        0x1000 },
     [VIRT_RTC] =3D          {   0x101000,        0x1000 },
+    [VIRT_CLIC] =3D         {  0x2000000, VIRT_CLIC_MAX_SIZE(VIRT_CPUS_MAX=
)},
     [VIRT_CLINT] =3D        {  0x2000000,       0x10000 },
     [VIRT_ACLINT_SSWI] =3D  {  0x2F00000,        0x4000 },
     [VIRT_PCIE_PIO] =3D     {  0x3000000,       0x10000 },
@@ -424,6 +426,37 @@ static void create_fdt_socket_aclint(RISCVVirtState *s=
,
     }
 }

+static void create_fdt_socket_clic(RISCVVirtState *s,
+                                   const MemMapEntry *memmap, int socket)
+{
+    g_autofree char *clic_name =3D NULL;
+    g_autofree uint32_t *clic_cells =3D NULL;
+    unsigned long mclicbase;
+    MachineState *ms =3D MACHINE(s);
+    static const char * const clic_compat[1] =3D {
+        "riscv,clic-0.9"
+    };
+
+    /*
+     * The spec doesn't define a memory layout, other than to say that eac=
h
+     * CLIC should be on a 4KiB boundary if memory-mapped.
+     * This implementation makes all the CLICs contiguous, in the order M,=
 S, U,
+     * and assumes the worst-case size.
+     * TODO: create entries for each CLIC on the system.
+     */
+    mclicbase =3D memmap[VIRT_CLIC].base;
+    clic_name =3D g_strdup_printf("/soc/clic@%lx", mclicbase);
+    qemu_fdt_add_subnode(ms->fdt, clic_name);
+    qemu_fdt_setprop_string_array(ms->fdt, clic_name, "compatible",
+                                  (char **)&clic_compat,
+                                  ARRAY_SIZE(clic_compat));
+    qemu_fdt_setprop_cells(ms->fdt, clic_name, "regs",
+        0x0, mclicbase, 0x0, memmap[VIRT_CLIC].size);
+    qemu_fdt_setprop_cell(ms->fdt, clic_name, "riscv,num-sources",
+                          VIRT_IRQCHIP_NUM_SOURCES);
+    riscv_socket_fdt_write_id(ms, clic_name, socket);
+}
+
 static void create_fdt_socket_plic(RISCVVirtState *s,
                                    const MemMapEntry *memmap, int socket,
                                    uint32_t *phandle, uint32_t *intc_phand=
les,
@@ -759,7 +792,10 @@ static void create_fdt_sockets(RISCVVirtState *s, cons=
t MemMapEntry *memmap,

         create_fdt_socket_memory(s, memmap, socket);

-        if (virt_aclint_allowed() && s->have_aclint) {
+
+        if (s->have_clic) {
+            create_fdt_socket_clic(s, memmap, socket);
+        } else if (virt_aclint_allowed() && s->have_aclint) {
             create_fdt_socket_aclint(s, memmap, socket,
                                      &intc_phandles[phandle_pos]);
         } else if (tcg_enabled()) {
@@ -1206,6 +1242,37 @@ static DeviceState *virt_create_plic(const MemMapEnt=
ry *memmap, int socket,
     return ret;
 }

+static DeviceState *virt_create_clic(RISCVVirtState *s, uint64_t clic_base=
,
+                                     int hartid)
+{
+    DeviceState *ret;
+    uint32_t block_size =3D VIRT_CLIC_HART_SIZE(s->clic_prv_s, s->clic_prv=
_u);
+    uint64_t mclicbase =3D clic_base + hartid * block_size;
+    uint64_t sclicbase =3D 0;
+    uint64_t uclicbase =3D 0;
+
+    /*
+     * The spec doesn't define a memory layout, other than to say that eac=
h
+     * CLIC should be on a 4KiB boundary if memory-mapped.
+     * This implementation makes all the CLICs contiguous, in the order M,=
 S, U.
+     */
+    if (s->clic_prv_s) {
+        sclicbase =3D mclicbase + VIRT_CLIC_BLOCK_SIZE;
+    }
+    if (s->clic_prv_u) {
+        uclicbase =3D mclicbase + VIRT_CLIC_BLOCK_SIZE;
+        if (s->clic_prv_s) {
+            uclicbase +=3D VIRT_CLIC_BLOCK_SIZE;
+        }
+    }
+    ret =3D riscv_clic_create(mclicbase, sclicbase, uclicbase,
+                            hartid, VIRT_IRQCHIP_NUM_SOURCES,
+                            s->clic_intctlbits,
+                            s->clic_version);
+
+    return ret;
+}
+
 static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_gue=
sts,
                                     const MemMapEntry *memmap, int socket,
                                     int base_hartid, int hart_count)
@@ -1505,7 +1572,7 @@ static void virt_machine_init(MachineState *machine)
                             i * memmap[VIRT_ACLINT_SSWI].size,
                         base_hartid, hart_count, true);
             }
-        } else if (tcg_enabled()) {
+        } else if (tcg_enabled() && !s->have_clic) {
             /* Per-socket SiFive CLINT */
             riscv_aclint_swi_create(
                     memmap[VIRT_CLINT].base + i * memmap[VIRT_CLINT].size,
@@ -1527,6 +1594,12 @@ static void virt_machine_init(MachineState *machine)
                                             hart_count);
         }

+        /* CLIC if present - needs to come after PLIC */
+        if (s->have_clic) {
+            s->irqchip[i] =3D virt_create_clic(s, memmap[VIRT_CLIC].base,
+                                             base_hartid);
+        }
+
         /* Try to use different IRQCHIP instance based device type */
         if (i =3D=3D 0) {
             mmio_irqchip =3D s->irqchip[i];
@@ -1710,6 +1783,134 @@ static void virt_set_aclint(Object *obj, bool value=
, Error **errp)
     s->have_aclint =3D value;
 }

+static bool virt_get_clic(Object *obj, Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+
+    return s->have_clic;
+}
+
+static void virt_set_clic(Object *obj, bool value, Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+
+    s->have_clic =3D value;
+}
+
+static char *virt_get_clic_mode(Object *obj, Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+    const char *val;
+
+    if (s->have_clic) {
+        if (s->clic_prv_s && s->clic_prv_u) {
+            val =3D "msu";
+        } else if (s->clic_prv_s) {
+            val =3D "ms";
+        } else if (s->clic_prv_u) {
+            val =3D "mu";
+        } else {
+            val =3D "m";
+        }
+    } else {
+        val =3D "none";
+    }
+
+    return g_strdup(val);
+}
+
+static void virt_set_clic_mode(Object *obj, const char *val, Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+    const char *c =3D val;
+
+    s->have_clic =3D true;
+
+    s->clic_prv_s =3D false;
+    s->clic_prv_u =3D false;
+
+    /* The mode is encoded with m =3D machine, s =3D PRV_S, u =3D PRV_U */
+    while (*c && !*errp) {
+        switch (*c) {
+        case 'm':
+        case 'M':
+            /* Machine mode is implicit and always enabled */
+            break;
+        case 's':
+        case 'S':
+            s->clic_prv_s =3D true;
+            break;
+        case 'u':
+        case 'U':
+            s->clic_prv_u =3D true;
+            break;
+        default:
+            error_setg(errp, "Invalid CLIC interrupt mode %c in %s", *c, v=
al);
+            error_append_hint(errp, "Valid values are m, s and u.\n");
+            break;
+        }
+        ++c;
+    }
+}
+
+static char *virt_get_clic_version(Object *obj, Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+    return g_strdup(s->clic_version);
+}
+
+static void virt_set_clic_version(Object *obj, const char *val, Error **er=
rp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+    g_autofree char **tokens =3D g_strsplit(val, "-", 2);
+
+    if (0 !=3D strcmp(tokens[0], "v0.9")) {
+        error_setg(errp, "Invalid CLIC version %s", tokens[0]);
+        error_append_hint(errp,
+                          "Only v0.9 is supported. The 'v' is required.\n"=
);
+        return;
+    }
+
+    if (tokens[1]) {
+        if (0 !=3D strcmp(tokens[1], "jmp")) {
+            error_setg(errp, "Invalid CLIC version suffix -%s", tokens[1])=
;
+            error_append_hint(errp, "Only -jmp is supported.\n");
+            return;
+        }
+    }
+
+    s->clic_version =3D g_strdup(val);
+    s->have_clic =3D true;
+}
+
+static void virt_get_clicintctlbits(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+    uint8_t value =3D s->clic_intctlbits;
+
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static void virt_set_clicintctlbits(Object *obj, Visitor *v,
+                                    const char *name, void *opaque,
+                                    Error **errp)
+{
+    RISCVVirtState *s =3D RISCV_VIRT_MACHINE(obj);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+    if (value > MAX_CLIC_INTCTLBITS) {
+        error_setg(errp, "CLIC intctlbits must be <=3D %d; was %d",
+                   MAX_CLIC_INTCTLBITS, value);
+    }
+
+    s->clic_intctlbits =3D value;
+}
+
 bool virt_is_acpi_enabled(RISCVVirtState *s)
 {
     return s->acpi !=3D ON_OFF_AUTO_OFF;
@@ -1767,6 +1968,7 @@ static void virt_machine_class_init(ObjectClass *oc, =
void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     HotplugHandlerClass *hc =3D HOTPLUG_HANDLER_CLASS(oc);
+    ObjectProperty *op =3D NULL;

     mc->desc =3D "RISC-V VirtIO board";
     mc->init =3D virt_machine_init;
@@ -1799,6 +2001,33 @@ static void virt_machine_class_init(ObjectClass *oc,=
 void *data)
                                           "enable/disable emulating "
                                           "ACLINT devices");

+    object_class_property_add_bool(oc, "clic", virt_get_clic,
+                                   virt_set_clic);
+    object_class_property_set_description(oc, "clic",
+                                          "Set on/off to enable/disable "
+                                          "emulating CLIC devices");
+    object_class_property_add_str(oc, "clic-mode", virt_get_clic_mode,
+                                   virt_set_clic_mode);
+    object_class_property_set_description(oc, "clic-mode",
+                                          "Specify supported CLIC modes: "
+                                          "m =3D machine (always enabled),=
 "
+                                          "s =3D PRV_S, u =3D PRV_U");
+    op =3D object_class_property_add_str(oc, "clic-version",
+                                       virt_get_clic_version,
+                                       virt_set_clic_version);
+    object_property_set_default_str(op, VIRT_CLIC_VERSION);
+    object_class_property_set_description(oc, "clic-version",
+                                          "Set the CLIC version to use. "
+                                          "Valid values are v0.9 and v0.9-=
jmp");
+    op =3D object_class_property_add(oc, "clic-intctlbits", "uint8",
+                                   virt_get_clicintctlbits,
+                                   virt_set_clicintctlbits,
+                                   NULL, NULL);
+    object_property_set_default_uint(op, 8);
+    object_class_property_set_description(oc, "clic-intctlbits",
+                                          "The number of intctl bits used =
in "
+                                          "this CLIC implementation");
+
     object_class_property_add_str(oc, "aia", virt_get_aia,
                                   virt_set_aia);
     object_class_property_set_description(oc, "aia",
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index c0dc41ff9a..d0a245608c 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -55,6 +55,11 @@ struct RISCVVirtState {

     int fdt_size;
     bool have_aclint;
+    bool have_clic;
+    bool clic_prv_s;
+    bool clic_prv_u;
+    uint8_t clic_intctlbits;
+    char *clic_version;
     RISCVVirtAIAType aia_type;
     int aia_guests;
     char *oem_id;
@@ -71,6 +76,7 @@ enum {
     VIRT_RTC,
     VIRT_CLINT,
     VIRT_ACLINT_SSWI,
+    VIRT_CLIC,
     VIRT_PLIC,
     VIRT_APLIC_M,
     VIRT_APLIC_S,
@@ -113,6 +119,35 @@ enum {
 #define VIRT_PLIC_SIZE(__num_context) \
     (VIRT_PLIC_CONTEXT_BASE + (__num_context) * VIRT_PLIC_CONTEXT_STRIDE)

+#define VIRT_CLIC_INTCLTBITS    3
+#define VIRT_CLIC_VERSION       "v0.9"
+#define VIRT_CLIC_MAX_IRQS      0x1000
+#define VIRT_CLIC_CONTEXT_BASE  0x1000
+#define VIRT_CLIC_CONTEXT_COUNT(_prv_s, _prv_u) \
+    (1 + ((_prv_s) ? 1 : 0) + ((_prv_u) ? 1 : 0))
+#define VIRT_CLIC_FULL_CONTEXT_COUNT VIRT_CLIC_CONTEXT_COUNT(1, 1)
+#define VIRT_CLIC_ALIGN_BITS    12
+#define VIRT_CLIC_ALIGN_MASK    ((1U << VIRT_CLIC_ALIGN_BITS) - 1)
+/* Round up to next 4KiB alignment boundary */
+#define VIRT_CLIC_ALIGN(_base_addr) \
+    (((_base_addr) + VIRT_CLIC_ALIGN_MASK) & VIRT_CLIC_ALIGN_MASK)
+#define VIRT_CLIC_INT_SIZE(_irq_count) ((_irq_count) * 4)
+/*
+ * The spec doesn't define a memory layout, other than to say that each
+ * CLIC should be on a 4KiB boundary if memory-mapped.
+ * This implementation makes all the CLICs contiguous, in the order M, S, =
U,
+ * and assumes the worst-case size.
+ */
+#define VIRT_CLIC_BLOCK_SIZE \
+    (VIRT_CLIC_CONTEXT_BASE + VIRT_CLIC_INT_SIZE(VIRT_CLIC_MAX_IRQS))
+#define VIRT_CLIC_HART_SIZE(_prv_s, _prv_u) \
+    (VIRT_CLIC_CONTEXT_COUNT(_prv_s, _prv_u) * VIRT_CLIC_BLOCK_SIZE)
+#define VIRT_CLIC_SIZE(_hart_count, _prv_s, _prv_u) \
+    ((_hart_count) * VIRT_CLIC_HART_SIZE(_prv_s, _prv_u))
+#define VIRT_CLIC_MAX_HART_SIZE VIRT_CLIC_HART_SIZE(1, 1)
+#define VIRT_CLIC_MAX_SIZE(_hart_count) \
+    ((_hart_count) * VIRT_CLIC_MAX_HART_SIZE)
+
 #define FDT_PCI_ADDR_CELLS    3
 #define FDT_PCI_INT_CELLS     1
 #define FDT_PLIC_ADDR_CELLS   0
--
2.46.0.windows.1
This message and any attachments may contain privileged and confidential in=
formation that is intended solely for the person(s) to whom it is addressed=
. If you are not an intended recipient you must not: read; copy; distribute=
; discuss; take any action in or make any reliance upon the contents of thi=
s message; nor open or read any attachment. If you have received this messa=
ge in error, please notify us as soon as possible on the following telephon=
e number and destroy this message including any attachments. Thank you. Cir=
rus Logic International (UK) Ltd and Cirrus Logic International Semiconduct=
or Ltd are companies registered in Scotland, with registered numbers SC0898=
39 and SC495735 respectively. Our registered office is at 7B Nightingale Wa=
y, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cirru=
s.com

