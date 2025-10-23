Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69B2CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtks-0001zs-MU; Thu, 23 Oct 2025 07:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkg-0001YY-DJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkd-0001dp-El
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:05 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MLaLh1002476;
 Thu, 23 Oct 2025 11:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=C7Y5NP
 2Npdw6iAypcFayCOM0FsVSamrJy/I3zDO0a84=; b=hoKXxV0g/HFfRACTomU5In
 sRSWi5aXGIFZ2sMJJkhDTqW6MeUI6eOoS+tGfdiWdNw6lb+xGXDtqwRHqO++Jlq/
 XJnc3pnDMhriPufTkaJYRd6ReM27oyUJ24SgjC9tkMQr2mpMFa4Pl2pz9EDf2dTG
 jtWRTWAyQZj0+/4n99IckeVICy8UYXzltsEb+NdKuYFvXh6/SMfkTuTpL4Bw+tFF
 w4gxfB0Vr3OmIGfIFDaYPnMVz/z9qRqbBr4PONyGWigfgfY/LkYk2dnzsktf+vyG
 w1Y/3Iq6qc7ZPyrbWDtOhxl+EUji88/wOKHmqOqXY39RltPAlr/n93+ArKdQ78FQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w0eg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:45:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAk0uq024940;
 Thu, 23 Oct 2025 11:44:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5dss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBivOP34537852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC6E520049;
 Thu, 23 Oct 2025 11:44:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBCEC20040;
 Thu, 23 Oct 2025 11:44:56 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:56 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/32] hw/ppc/pegasos2: Add Pegasos I emulation
Date: Thu, 23 Oct 2025 17:14:10 +0530
Message-ID: <20251023114422.3675018-24-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iGQaiR2_69pqvUHNvdIooiV5M635lcw3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4DdZK6TxAuSQ
 e68TWROBxZyXvGCo88x6FEluMc0Td8EeVSWwcTk/UbGrsVx4EESojSrpQe3+rAcD2Hd6mv6DCEU
 UrU7hd3UT6i6n2ArbNhzY0STfHLTjEVlv253so0NmD3EFsV8E0rR08rpk8e7IbAKSwFLksgw1kp
 bj6lC25YhK71YzdKajYOsb92sJYZ3eCcyiDpZEp/ix5yF67aNBer9ULkxajHZHlzXtjVmhV+Hzr
 j/z4b8K33FbGqBQlECCrgThRDwV+n6hhh0XfTPQmhIL0KSBYYZW7L3sAAt5dHO46Oj8BWg7rgUs
 Sa2O9eD2vOty0/3/2ynKDs0j9upLvn7ixRYitu6L7QxyLF+LcMMUayLEWKYJCWMLWPqk6IXaoFc
 Emw6mdT9+fYElUdoZ6d3NSJoKAdGLA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fa153c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=dyx6wcTaBH8QTcpR19sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: iGQaiR2_69pqvUHNvdIooiV5M635lcw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

The Pegasos II is a redesign of the original Pegasos (later marked I)
that replaces the north bridge and has updated firmware but otherwise
these are very similar. The Pegasos uses the same north bridge that
AmigaOne used which we already emulate so we can also easily emulate
Pegasos I.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/8f5bd07553b41d83a54f9df0bb93b76b22dea5c5.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 156 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 117 insertions(+), 39 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 7eaefcf9a0..a11f3c99ed 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -1,5 +1,5 @@
 /*
- * QEMU PowerPC CHRP (Genesi/bPlan Pegasos II) hardware System Emulator
+ * QEMU PowerPC CHRP (Genesi/bPlan Pegasos I/II) hardware System Emulator
  *
  * Copyright (c) 2018-2021 BALATON Zoltan
  *
@@ -15,6 +15,7 @@
 #include "hw/pci/pci_host.h"
 #include "hw/irq.h"
 #include "hw/or-irq.h"
+#include "hw/pci-host/articia.h"
 #include "hw/pci-host/mv64361.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
@@ -55,12 +56,18 @@
 #define H_PRIVILEGE  -3  /* Caller not privileged */
 #define H_PARAMETER  -4  /* Parameter invalid, out-of-range or conflicting */
 
+typedef enum {
+    PEGASOS1 = 1,
+    PEGASOS2 = 2,
+} PegasosMachineType;
+
 #define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
 OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
 
 struct PegasosMachineState {
     MachineState parent_obj;
 
+    PegasosMachineType type;
     PowerPCCPU *cpu;
     DeviceState *nb; /* north bridge */
     DeviceState *sb; /* south bridge */
@@ -79,7 +86,7 @@ struct PegasosMachineState {
 
 static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size);
 
-static void pegasos2_cpu_reset(void *opaque)
+static void pegasos_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
     PegasosMachineState *pm = PEGASOS_MACHINE(current_machine);
@@ -89,6 +96,8 @@ static void pegasos2_cpu_reset(void *opaque)
     if (pm->vof) {
         cpu->env.gpr[1] = 2 * VOF_STACK_SIZE - 0x20;
         cpu->env.nip = 0x100;
+    } else if (pm->type == PEGASOS1) {
+        cpu->env.nip = 0xfffc0100;
     }
     cpu_ppc_tb_reset(&cpu->env);
 }
@@ -139,13 +148,15 @@ static void pegasos_init(MachineState *machine)
     PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     CPUPPCState *env;
     MemoryRegion *rom = g_new(MemoryRegion, 1);
-    PCIBus *pci_bus;
+    PCIBus *pci_bus = NULL;
     Object *via;
     PCIDevice *dev;
     I2CBus *i2c_bus;
     const char *fwname = machine->firmware ?: PROM_FILENAME;
     char *filename;
+    hwaddr prom_addr;
     ssize_t sz;
+    int devfn;
     uint8_t *spd_data;
 
     /* init CPU */
@@ -158,7 +169,7 @@ static void pegasos_init(MachineState *machine)
 
     /* Set time-base frequency */
     cpu_ppc_tb_init(env, pm->bus_freq_hz / 4);
-    qemu_register_reset(pegasos2_cpu_reset, pm->cpu);
+    qemu_register_reset(pegasos_cpu_reset, pm->cpu);
 
     /* RAM */
     if (machine->ram_size > 2 * GiB) {
@@ -176,12 +187,16 @@ static void pegasos_init(MachineState *machine)
     if (!machine->firmware && !pm->vof) {
         pm->vof = g_malloc0(sizeof(*pm->vof));
     }
-    memory_region_init_rom(rom, NULL, "pegasos2.rom", PROM_SIZE, &error_fatal);
-    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+    prom_addr = PROM_ADDR;
+    if (pm->type == PEGASOS1) {
+        prom_addr += PROM_SIZE;
+    }
+    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), prom_addr, rom);
     sz = load_elf(filename, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
                   ELFDATA2MSB, PPC_ELF_MACHINE, 0, 0);
     if (sz <= 0) {
-        sz = load_image_targphys(filename, pm->vof ? 0 : PROM_ADDR, PROM_SIZE);
+        sz = load_image_targphys(filename, pm->vof ? 0 : prom_addr, PROM_SIZE);
     }
     if (sz <= 0 || sz > PROM_SIZE) {
         error_report("Could not load firmware '%s'", filename);
@@ -192,13 +207,37 @@ static void pegasos_init(MachineState *machine)
         pm->vof->fw_size = sz;
     }
 
-    /* Marvell Discovery II system controller */
-    pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
-                          qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
-    pci_bus = mv64361_get_pci_bus(pm->nb, 1);
+    /* north bridge */
+    switch (pm->type) {
+    case PEGASOS1:
+    {
+        MemoryRegion *pci_mem, *mr;
+
+        /* Articia S */
+        pm->nb = DEVICE(sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL));
+        pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 1);
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-low", pci_mem,
+                                 0, 0x1000000);
+        memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_alias(mr, OBJECT(pm->nb), "pci-mem-high", pci_mem,
+                                 0x80000000, 0x7d000000);
+        memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
+        pci_bus = PCI_BUS(qdev_get_child_bus(pm->nb, "pci.0"));
+        break;
+    }
+    case PEGASOS2:
+        /* Marvell Discovery II system controller */
+        pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
+                        qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
+        pci_bus = mv64361_get_pci_bus(pm->nb, 1);
+        break;
+    }
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
-    pm->sb = DEVICE(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
+    devfn = PCI_DEVFN(pm->type == PEGASOS1 ? 7 : 12, 0);
+    pm->sb = DEVICE(pci_new_multifunction(devfn, TYPE_VT8231_ISA));
     via = OBJECT(pm->sb);
 
     /* Set properties on individual devices before realizing the south bridge */
@@ -223,7 +262,21 @@ static void pegasos_init(MachineState *machine)
     /* other PC hardware */
     pci_vga_init(pci_bus);
 
-    pegasos2_setup_pci_irq(pm);
+    /* pci interrupt routing */
+    switch (pm->type) {
+    case PEGASOS1:
+        qdev_connect_gpio_out_named(pm->sb, "intr", 0,
+                                    qdev_get_gpio_in(DEVICE(pm->cpu),
+                                                     PPC6xx_INPUT_INT));
+        for (int i = 0; i < PCI_NUM_PINS; i++) {
+            qdev_connect_gpio_out(pm->nb, i,
+                                  qdev_get_gpio_in_named(pm->sb, "pirq", i));
+        }
+        break;
+    case PEGASOS2:
+        pegasos2_setup_pci_irq(pm);
+        break;
+    }
 
     if (machine->kernel_filename) {
         sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
@@ -376,7 +429,7 @@ static void pegasos2_chipset_reset(PegasosMachineState *pm)
                               PCI_INTERRUPT_LINE, 2, 0x309);
 }
 
-static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+static void pegasos_machine_reset(MachineState *machine, ResetType type)
 {
     PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     void *fdt;
@@ -387,6 +440,9 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
     qemu_devices_reset(type);
     if (!pm->vof) {
         return; /* Firmware should set up machine so nothing to do */
+    } else if (pm->type == PEGASOS1) {
+        error_report("VOF is not supported by this machine");
+        exit(1);
     }
 
     /* Otherwise, set up devices that board firmware would normally do */
@@ -558,12 +614,12 @@ static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
     }
 }
 
-static bool pegasos2_cpu_in_nested(PowerPCCPU *cpu)
+static bool pegasos_cpu_in_nested(PowerPCCPU *cpu)
 {
     return false;
 }
 
-static void pegasos2_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
+static void pegasos_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
     PegasosMachineState *pm = PEGASOS_MACHINE(vhyp);
     CPUPPCState *env = &cpu->env;
@@ -574,7 +630,7 @@ static void pegasos2_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
     if (FIELD_EX64(env->msr, MSR, PR)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Hypercall made with MSR[PR]=1\n");
         env->gpr[3] = H_PRIVILEGE;
-    } else if (env->gpr[3] == KVMPPC_H_RTAS) {
+    } else if (env->gpr[3] == KVMPPC_H_RTAS && pm->type == PEGASOS2) {
         env->gpr[3] = pegasos2_rtas(cpu, pm, env->gpr[4]);
     } else if (env->gpr[3] == KVMPPC_H_VOF_CLIENT) {
         int ret = vof_client_call(MACHINE(pm), pm->vof, MACHINE(pm)->fdt,
@@ -596,56 +652,78 @@ static target_ulong vhyp_encode_hpt_for_kvm_pr(PPCVirtualHypervisor *vhyp)
     return POWERPC_CPU(current_cpu)->env.spr[SPR_SDR1];
 }
 
-static bool pegasos2_setprop(MachineState *ms, const char *path,
-                             const char *propname, void *val, int vallen)
+static bool pegasos_setprop(MachineState *ms, const char *path,
+                            const char *propname, void *val, int vallen)
 {
     return true;
 }
 
-static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
+static void pegasos_machine_init(MachineClass *mc)
 {
-    MachineClass *mc = MACHINE_CLASS(oc);
-    PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
-    VofMachineIfClass *vmc = VOF_MACHINE_CLASS(oc);
+    PPCVirtualHypervisorClass *vhc = PPC_VIRTUAL_HYPERVISOR_CLASS(mc);
+    VofMachineIfClass *vmc = VOF_MACHINE_CLASS(mc);
 
-    mc->desc = "Genesi/bPlan Pegasos II";
     mc->init = pegasos_init;
-    mc->reset = pegasos2_machine_reset;
+    mc->reset = pegasos_machine_reset;
     mc->block_default_type = IF_IDE;
     mc->default_boot_order = "cd";
     mc->default_display = "std";
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
-    mc->default_ram_id = "pegasos2.ram";
+    mc->default_ram_id = "ram";
     mc->default_ram_size = 512 * MiB;
     machine_add_audiodev_property(mc);
 
-    vhc->cpu_in_nested = pegasos2_cpu_in_nested;
-    vhc->hypercall = pegasos2_hypercall;
+    vhc->cpu_in_nested = pegasos_cpu_in_nested;
+    vhc->hypercall = pegasos_hypercall;
     vhc->cpu_exec_enter = vhyp_nop;
     vhc->cpu_exec_exit = vhyp_nop;
     vhc->encode_hpt_for_kvm_pr = vhyp_encode_hpt_for_kvm_pr;
 
-    vmc->setprop = pegasos2_setprop;
+    vmc->setprop = pegasos_setprop;
+}
+
+static void pegasos1_init(Object *obj)
+{
+    PegasosMachineState *pm = PEGASOS_MACHINE(obj);
+
+    pm->type = PEGASOS1;
+    pm->bus_freq_hz = 33000000;
+}
+
+static void pegasos1_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Genesi/bPlan Pegasos I";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("750cxe_v3.1b");
 }
 
 static void pegasos2_init(Object *obj)
 {
     PegasosMachineState *pm = PEGASOS_MACHINE(obj);
 
+    pm->type = PEGASOS2;
     pm->bus_freq_hz = 133333333;
 }
 
+static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Genesi/bPlan Pegasos II";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
+}
+
+DEFINE_MACHINE_EXTENDED("pegasos", MACHINE, PegasosMachineState,
+                        pegasos_machine_init, true, (const InterfaceInfo[]) {
+                        { TYPE_PPC_VIRTUAL_HYPERVISOR },
+                        { TYPE_VOF_MACHINE_IF }, { } })
+
 static const TypeInfo pegasos_machine_types[] = {
     {
-        .name          = TYPE_PEGASOS_MACHINE,
-        .parent        = TYPE_MACHINE,
-        .instance_size = sizeof(PegasosMachineState),
-        .abstract      = true,
-        .interfaces = (const InterfaceInfo[]) {
-              { TYPE_PPC_VIRTUAL_HYPERVISOR },
-              { TYPE_VOF_MACHINE_IF },
-              { }
-        },
+        .name          = MACHINE_TYPE_NAME("pegasos1"),
+        .parent        = TYPE_PEGASOS_MACHINE,
+        .class_init    = pegasos1_machine_class_init,
+        .instance_init = pegasos1_init,
     },
     {
         .name          = MACHINE_TYPE_NAME("pegasos2"),
-- 
2.43.5


