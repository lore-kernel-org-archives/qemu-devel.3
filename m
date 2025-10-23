Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799F7CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtku-0002Ao-F0; Thu, 23 Oct 2025 07:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkp-0001lx-5v
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkm-0001dJ-8y
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N48UEW015154;
 Thu, 23 Oct 2025 11:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xy+FpD
 SQIuSIz8SH+Jrmw+29iCnIy43AKGGljobRpnk=; b=D7J3xZKDfz72+93mEcymJr
 +yOOWBCnuzmLZhlmMtKMBHSBLytO1Di2QEq23MJ5dKW80im8fkN9nmu8higukx22
 WI5StfOdofcnfF75owws8pwEp2ofl4q5/k/SrVbUbhoY3sH8LT4ERPmEAtO7xn2u
 +mF7l+QSkzqDkfRYkHC2Bu9RaGh8JmGjW6u8thPB0gJJ+RS8DoXGwy9a3AKocmIg
 qirtWNSh+O9IH3e6dykjEK3ZJ3BIPB/XbInOk8AFF30dLExxkobe8egA9xrCHZdj
 lOuNs14R7hxl7zq0Fe3UAapPQUZHfM/NyPN8HuPG06gE9AzG9J4aSHx2rKonxPPA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s9wau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9C5DE014685;
 Thu, 23 Oct 2025 11:44:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdpnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:56 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBituX49873324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45ACC20049;
 Thu, 23 Oct 2025 11:44:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56DB020040;
 Thu, 23 Oct 2025 11:44:54 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/32] hw/ppc/pegasos2: Introduce abstract superclass
Date: Thu, 23 Oct 2025 17:14:08 +0530
Message-ID: <20251023114422.3675018-22-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PM2hKii3YUWOpvLQV7gRF6FuJY0f-E8d
X-Proofpoint-GUID: PM2hKii3YUWOpvLQV7gRF6FuJY0f-E8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9WfqXy9sL9XI
 vA776eqs7pzRWkVnk4RUgSuZxwruxbB2qcWxmZ/iXKPMFpwJ06nbqhOTtTNGncf04zcC2e9DK5Y
 Pi67oNVTLOucSlphiG5rOe+oiZSPlAH2pbIFN7bOayV8/cubJ1UpkjKTwaGU2mZ4B5qW8ZlguFP
 WM003Rw8bmpG5Fzt0lUKtHKc8jEcxhsDmcR0vb4x49KEK24igSo0+Z7a1fdjGWRDjf1nGf3fU51
 w8OYjkzZyfkS8Tt5lznELqU+2Ke42i5l93LhQo8BTR6O8mYKBE9J1+HIU5BTGgi12xi/gMn4T70
 tBw3RzvjKQf+M7t50sW93OtIVhdaWdEjCyAjeifZmGzVtsf0eZaj7q+PPJ3nk/vuQxaMo1G1OKX
 otaAXPO1MuYvLBp5OuRnYFpWIpFSEg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa1539 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=PatsMKc-9FYN22uO058A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Rename machine state struct to PegasosMachineState as it will be used
for pegasos1 too.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/a09590a5da4572c9d392542f5c3793e6eb08ab9e.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 66 ++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index ed3070204b..f5b56c0e94 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -57,10 +57,10 @@
 
 #define BUS_FREQ_HZ 133333333
 
-#define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
-OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
+#define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
+OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
 
-struct Pegasos2MachineState {
+struct PegasosMachineState {
     MachineState parent_obj;
 
     PowerPCCPU *cpu;
@@ -78,12 +78,12 @@ struct Pegasos2MachineState {
     uint64_t initrd_size;
 };
 
-static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size);
+static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size);
 
 static void pegasos2_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(current_machine);
+    PegasosMachineState *pm = PEGASOS_MACHINE(current_machine);
 
     cpu_reset(CPU(cpu));
     cpu->env.spr[SPR_HID1] = 7ULL << 28;
@@ -96,7 +96,7 @@ static void pegasos2_cpu_reset(void *opaque)
 
 static void pegasos2_pci_irq(void *opaque, int n, int level)
 {
-    Pegasos2MachineState *pm = opaque;
+    PegasosMachineState *pm = opaque;
 
     /* PCI interrupt lines are connected to both MV64361 and VT8231 */
     qemu_set_irq(pm->mv_pirq[n], level);
@@ -104,7 +104,7 @@ static void pegasos2_pci_irq(void *opaque, int n, int level)
 }
 
 /* Set up PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
-static void pegasos2_setup_pci_irq(Pegasos2MachineState *pm)
+static void pegasos2_setup_pci_irq(PegasosMachineState *pm)
 {
     for (int h = 0; h < 2; h++) {
         DeviceState *pd;
@@ -137,7 +137,7 @@ static void pegasos2_setup_pci_irq(Pegasos2MachineState *pm)
 
 static void pegasos2_init(MachineState *machine)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     CPUPPCState *env;
     MemoryRegion *rom = g_new(MemoryRegion, 1);
     PCIBus *pci_bus;
@@ -262,7 +262,7 @@ static void pegasos2_init(MachineState *machine)
     }
 }
 
-static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
+static uint32_t pegasos2_mv_reg_read(PegasosMachineState *pm,
                                      uint32_t addr, uint32_t len)
 {
     MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
@@ -272,7 +272,7 @@ static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
     return val;
 }
 
-static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
+static void pegasos2_mv_reg_write(PegasosMachineState *pm, uint32_t addr,
                                   uint32_t len, uint32_t val)
 {
     MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
@@ -283,7 +283,7 @@ static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
 #define PCI0_CFG_ADDR 0xcf8
 #define PCI1_CFG_ADDR 0xc78
 
-static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
+static uint32_t pegasos2_pci_config_read(PegasosMachineState *pm, int bus,
                                          uint32_t addr, uint32_t len)
 {
     hwaddr pcicfg = bus ? PCI1_CFG_ADDR : PCI0_CFG_ADDR;
@@ -296,7 +296,7 @@ static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
     return val;
 }
 
-static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
+static void pegasos2_pci_config_write(PegasosMachineState *pm, int bus,
                                       uint32_t addr, uint32_t len, uint32_t val)
 {
     hwaddr pcicfg = bus ? PCI1_CFG_ADDR : PCI0_CFG_ADDR;
@@ -311,7 +311,7 @@ static void pegasos2_superio_write(uint8_t addr, uint8_t val)
     cpu_physical_memory_write(0xfe0003f1, &val, 1);
 }
 
-static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
+static void pegasos2_chipset_reset(PegasosMachineState *pm)
 {
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
     pegasos2_mv_reg_write(pm, 0x278, 4, 0xa31fc);
@@ -379,7 +379,7 @@ static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
 
 static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     void *fdt;
     uint32_t c[2];
     uint64_t d[2];
@@ -463,7 +463,7 @@ enum pegasos2_rtas_tokens {
     RTAS_SYSTEM_REBOOT = 20,
 };
 
-static target_ulong pegasos2_rtas(PowerPCCPU *cpu, Pegasos2MachineState *pm,
+static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
                                   target_ulong args_real)
 {
     AddressSpace *as = CPU(cpu)->as;
@@ -566,7 +566,7 @@ static bool pegasos2_cpu_in_nested(PowerPCCPU *cpu)
 
 static void pegasos2_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(vhyp);
+    PegasosMachineState *pm = PEGASOS_MACHINE(vhyp);
     CPUPPCState *env = &cpu->env;
 
     /* The TCG path should also be holding the BQL at this point */
@@ -629,24 +629,26 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     vmc->setprop = pegasos2_setprop;
 }
 
-static const TypeInfo pegasos2_machine_info = {
-    .name          = TYPE_PEGASOS2_MACHINE,
-    .parent        = TYPE_MACHINE,
-    .class_init    = pegasos2_machine_class_init,
-    .instance_size = sizeof(Pegasos2MachineState),
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_PPC_VIRTUAL_HYPERVISOR },
-        { TYPE_VOF_MACHINE_IF },
-        { }
+static const TypeInfo pegasos_machine_types[] = {
+    {
+        .name          = TYPE_PEGASOS_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(PegasosMachineState),
+        .abstract      = true,
+        .interfaces = (const InterfaceInfo[]) {
+              { TYPE_PPC_VIRTUAL_HYPERVISOR },
+              { TYPE_VOF_MACHINE_IF },
+              { }
+        },
+    },
+    {
+        .name          = MACHINE_TYPE_NAME("pegasos2"),
+        .parent        = TYPE_PEGASOS_MACHINE,
+        .class_init    = pegasos2_machine_class_init,
     },
 };
 
-static void pegasos2_machine_register_types(void)
-{
-    type_register_static(&pegasos2_machine_info);
-}
-
-type_init(pegasos2_machine_register_types)
+DEFINE_TYPES(pegasos_machine_types)
 
 /* FDT creation for passing to firmware */
 
@@ -847,7 +849,7 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
-static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size)
+static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size)
 {
     FDTInfo fi;
     PCIBus *pci_bus;
-- 
2.43.5


