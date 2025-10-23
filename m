Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8F1CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtke-0001TM-8L; Thu, 23 Oct 2025 07:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkW-0001Lp-MK
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkT-0001bh-I4
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:44:56 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8B7wI015123;
 Thu, 23 Oct 2025 11:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QSlvDG
 nDDl4b+7RChUQZhL4Jt0GxsEYvIJPaC1ZJN0U=; b=FbNR2HUJGE74om9hmTvg3t
 W3g90nmSX81rx6Gdw3XuJHK6oKgj29Il1SXlxHzIaQYmBCh2HT1ht5FIYdkWTZrP
 eLS9CwyrUykFRTxEPl52WUVm8FV2s2ERSC8SSu78x/n5um4xjex3TcGS0ypr8BiG
 ba0DfKZD3GChOiLsRVnQSjjETgNDYJ4GPozQbEyt3OT2lxEpoEXP9X0DGzJ6AB8O
 hcFDXsvMqXsj69cEFdOcPw/iRZzI9laXN33slbs6zHgpT7YCfTPoHK2s4Uw6I8l9
 8bdBfHdCJF/bytwdfO8nWLXkwGaDhcXZ6/VO+nkD9QdRC2yW2++xp0Gbs7eoCrFg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrcnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NB1VkC011075;
 Thu, 23 Oct 2025 11:44:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1d6ep-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBimDp46203140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F16AA20049;
 Thu, 23 Oct 2025 11:44:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E8D2820040;
 Thu, 23 Oct 2025 11:44:46 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:46 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/32] hw/ppc/pegasos2: Change device tree generation
Date: Thu, 23 Oct 2025 17:14:02 +0530
Message-ID: <20251023114422.3675018-16-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7Fi4OudSCHzE
 stdxqMbimdqz63nGkbbMfYsAUWeE90rwkLU/I2FOV+TQSNarOHbYGUhDuOezxiAZ1BsmI27IS/o
 oVN7bPfzi9/H37megza1pKMaPkM5vrh570l3z3oDLaLonQ900wrufMqIbF3VzEz9Ka+vYuD98r8
 wac/HL/uSTOy5TAiqv41T0u3y2WwbLTkxds2LRB0XPywafNQz0wll4jctY7LL9DHiLaEZFjw+AW
 zAegCEhn5USC27B2PO3XWSSgNxg+0ZfIpGbXO/PmLdec1jcIujjH89ejStl8x6ovEzgo8V1WE7M
 TwMHNN1Qp9qLyTtjB8i310BUczwsBuQBcnaQRlzr3pjXeYHVlL6fF7REonNUFZKbia4ACJ16Uxc
 JcGgw0am+WFYiZm6wntvkYr9lsxCdw==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1532 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=VdymBoROAfzTdu8dDj8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: 2cNUZ2Q073hnOelRoZx7twOm_72ZziWI
X-Proofpoint-ORIG-GUID: 2cNUZ2Q073hnOelRoZx7twOm_72ZziWI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
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

We generate a flattened device tree programmatically for VOF. Change
this to load the static parts from a device tree blob and only
generate the parts that depend on run time conditions such as CPU
type, memory size and PCI devices. Moving the static parts in a dts
makes the board code simpler and more generic.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/383891fc2696609b27d2de9773efe1b4f493e333.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c        | 291 +++++++--------------------------------
 pc-bios/dtb/meson.build  |   1 +
 pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
 pc-bios/dtb/pegasos2.dts | 167 ++++++++++++++++++++++
 4 files changed, 219 insertions(+), 240 deletions(-)
 create mode 100644 pc-bios/dtb/pegasos2.dtb
 create mode 100644 pc-bios/dtb/pegasos2.dts

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 73995624e5..f4787397dc 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -58,16 +58,8 @@
 #define BUS_FREQ_HZ 133333333
 
 #define PCI0_CFG_ADDR 0xcf8
-#define PCI0_MEM_BASE 0xc0000000
-#define PCI0_MEM_SIZE 0x20000000
-#define PCI0_IO_BASE  0xf8000000
-#define PCI0_IO_SIZE  0x10000
-
 #define PCI1_CFG_ADDR 0xc78
-#define PCI1_MEM_BASE 0x80000000
-#define PCI1_MEM_SIZE 0x40000000
 #define PCI1_IO_BASE  0xfe000000
-#define PCI1_IO_SIZE  0x10000
 
 #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
 OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
@@ -411,7 +403,11 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
         error_report("Memory for initrd is in use");
         exit(1);
     }
+
     fdt = build_fdt(machine, &sz);
+    if (!fdt) {
+        exit(1);
+    }
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
@@ -654,113 +650,12 @@ static void dt_usb(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     qemu_fdt_setprop_string(fi->fdt, fi->path, "device_type", "usb");
 }
 
-static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
-{
-    GString *name = g_string_sized_new(64);
-    uint32_t cells[3];
-
-    qemu_fdt_setprop_cell(fi->fdt, fi->path, "#size-cells", 1);
-    qemu_fdt_setprop_cell(fi->fdt, fi->path, "#address-cells", 2);
-    qemu_fdt_setprop_string(fi->fdt, fi->path, "device_type", "isa");
-
-    /* additional devices */
-    g_string_printf(name, "%s/lpt@i3bc", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "clock-frequency", 0);
-    cells[0] = cpu_to_be32(7);
-    cells[1] = 0;
-    qemu_fdt_setprop(fi->fdt, name->str, "interrupts",
-                     cells, 2 * sizeof(cells[0]));
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x3bc);
-    cells[2] = cpu_to_be32(8);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "lpt");
-
-    g_string_printf(name, "%s/fdc@i3f0", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "clock-frequency", 0);
-    cells[0] = cpu_to_be32(6);
-    cells[1] = 0;
-    qemu_fdt_setprop(fi->fdt, name->str, "interrupts",
-                     cells, 2 * sizeof(cells[0]));
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x3f0);
-    cells[2] = cpu_to_be32(8);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "fdc");
-
-    g_string_printf(name, "%s/timer@i40", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "clock-frequency", 0);
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x40);
-    cells[2] = cpu_to_be32(8);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "timer");
-
-    g_string_printf(name, "%s/rtc@i70", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    qemu_fdt_setprop_string(fi->fdt, name->str, "compatible", "ds1385-rtc");
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "clock-frequency", 0);
-    cells[0] = cpu_to_be32(8);
-    cells[1] = 0;
-    qemu_fdt_setprop(fi->fdt, name->str, "interrupts",
-                     cells, 2 * sizeof(cells[0]));
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x70);
-    cells[2] = cpu_to_be32(2);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "rtc");
-
-    g_string_printf(name, "%s/keyboard@i60", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    cells[0] = cpu_to_be32(1);
-    cells[1] = 0;
-    qemu_fdt_setprop(fi->fdt, name->str, "interrupts",
-                     cells, 2 * sizeof(cells[0]));
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x60);
-    cells[2] = cpu_to_be32(5);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "keyboard");
-
-    g_string_printf(name, "%s/8042@i60", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "#interrupt-cells", 2);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "#size-cells", 0);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "#address-cells", 1);
-    qemu_fdt_setprop_string(fi->fdt, name->str, "interrupt-controller", "");
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "clock-frequency", 0);
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x60);
-    cells[2] = cpu_to_be32(5);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "");
-
-    g_string_printf(name, "%s/serial@i2f8", fi->path);
-    qemu_fdt_add_subnode(fi->fdt, name->str);
-    qemu_fdt_setprop_cell(fi->fdt, name->str, "clock-frequency", 0);
-    cells[0] = cpu_to_be32(3);
-    cells[1] = 0;
-    qemu_fdt_setprop(fi->fdt, name->str, "interrupts",
-                     cells, 2 * sizeof(cells[0]));
-    cells[0] = cpu_to_be32(1);
-    cells[1] = cpu_to_be32(0x2f8);
-    cells[2] = cpu_to_be32(8);
-    qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "serial");
-
-    g_string_free(name, TRUE);
-}
-
 static struct {
     const char *id;
     const char *name;
     void (*dtf)(PCIBus *bus, PCIDevice *d, FDTInfo *fi);
 } device_map[] = {
     { "pci11ab,6460", "host", NULL },
-    { "pci1106,8231", "isa", dt_isa },
     { "pci1106,571", "ide", dt_ide },
     { "pci1106,3044", "firewire", NULL },
     { "pci1106,3038", "usb", dt_usb },
@@ -780,7 +675,10 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
                                      pci_get_word(&d->config[PCI_VENDOR_ID]),
                                      pci_get_word(&d->config[PCI_DEVICE_ID]));
 
-    if (pci_get_word(&d->config[PCI_CLASS_DEVICE])  ==
+    if (!strcmp(pn, "pci1106,8231")) {
+        return; /* ISA bridge and devices are included in dtb */
+    }
+    if (pci_get_word(&d->config[PCI_CLASS_DEVICE]) ==
         PCI_CLASS_NETWORK_ETHERNET) {
         name = "ethernet";
     } else if (pci_get_word(&d->config[PCI_CLASS_DEVICE]) >> 8 ==
@@ -858,131 +756,9 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
     g_string_free(node, TRUE);
 }
 
-static void *build_fdt(MachineState *machine, int *fdt_size)
+static void add_cpu_info(void *fdt, PowerPCCPU *cpu)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
-    PowerPCCPU *cpu = pm->cpu;
-    PCIBus *pci_bus;
-    FDTInfo fi;
-    uint32_t cells[16];
-    void *fdt = create_device_tree(fdt_size);
-
-    fi.fdt = fdt;
-
-    /* root node */
-    qemu_fdt_setprop_string(fdt, "/", "CODEGEN,description",
-                            "Pegasos CHRP PowerPC System");
-    qemu_fdt_setprop_string(fdt, "/", "CODEGEN,board", "Pegasos2");
-    qemu_fdt_setprop_string(fdt, "/", "CODEGEN,vendor", "bplan GmbH");
-    qemu_fdt_setprop_string(fdt, "/", "revision", "2B");
-    qemu_fdt_setprop_string(fdt, "/", "model", "Pegasos2");
-    qemu_fdt_setprop_string(fdt, "/", "device_type", "chrp");
-    qemu_fdt_setprop_cell(fdt, "/", "#address-cells", 1);
-    qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
-
-    /* pci@c0000000 */
-    qemu_fdt_add_subnode(fdt, "/pci@c0000000");
-    cells[0] = 0;
-    cells[1] = 0;
-    qemu_fdt_setprop(fdt, "/pci@c0000000", "bus-range",
-                     cells, 2 * sizeof(cells[0]));
-    qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "pci-bridge-number", 1);
-    cells[0] = cpu_to_be32(PCI0_MEM_BASE);
-    cells[1] = cpu_to_be32(PCI0_MEM_SIZE);
-    qemu_fdt_setprop(fdt, "/pci@c0000000", "reg", cells, 2 * sizeof(cells[0]));
-    cells[0] = cpu_to_be32(0x01000000);
-    cells[1] = 0;
-    cells[2] = 0;
-    cells[3] = cpu_to_be32(PCI0_IO_BASE);
-    cells[4] = 0;
-    cells[5] = cpu_to_be32(PCI0_IO_SIZE);
-    cells[6] = cpu_to_be32(0x02000000);
-    cells[7] = 0;
-    cells[8] = cpu_to_be32(PCI0_MEM_BASE);
-    cells[9] = cpu_to_be32(PCI0_MEM_BASE);
-    cells[10] = 0;
-    cells[11] = cpu_to_be32(PCI0_MEM_SIZE);
-    qemu_fdt_setprop(fdt, "/pci@c0000000", "ranges",
-                     cells, 12 * sizeof(cells[0]));
-    qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#size-cells", 2);
-    qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#address-cells", 3);
-    qemu_fdt_setprop_string(fdt, "/pci@c0000000", "device_type", "pci");
-
-    fi.path = "/pci@c0000000";
-    pci_bus = mv64361_get_pci_bus(pm->mv, 0);
-    pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
-
-    /* pci@80000000 */
-    qemu_fdt_add_subnode(fdt, "/pci@80000000");
-    cells[0] = 0;
-    cells[1] = 0;
-    qemu_fdt_setprop(fdt, "/pci@80000000", "bus-range",
-                     cells, 2 * sizeof(cells[0]));
-    qemu_fdt_setprop_cell(fdt, "/pci@80000000", "pci-bridge-number", 0);
-    cells[0] = cpu_to_be32(PCI1_MEM_BASE);
-    cells[1] = cpu_to_be32(PCI1_MEM_SIZE);
-    qemu_fdt_setprop(fdt, "/pci@80000000", "reg", cells, 2 * sizeof(cells[0]));
-    qemu_fdt_setprop_cell(fdt, "/pci@80000000", "8259-interrupt-acknowledge",
-                          0xf1000cb4);
-    cells[0] = cpu_to_be32(0x01000000);
-    cells[1] = 0;
-    cells[2] = 0;
-    cells[3] = cpu_to_be32(PCI1_IO_BASE);
-    cells[4] = 0;
-    cells[5] = cpu_to_be32(PCI1_IO_SIZE);
-    cells[6] = cpu_to_be32(0x02000000);
-    cells[7] = 0;
-    cells[8] = cpu_to_be32(PCI1_MEM_BASE);
-    cells[9] = cpu_to_be32(PCI1_MEM_BASE);
-    cells[10] = 0;
-    cells[11] = cpu_to_be32(PCI1_MEM_SIZE);
-    qemu_fdt_setprop(fdt, "/pci@80000000", "ranges",
-                     cells, 12 * sizeof(cells[0]));
-    qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#size-cells", 2);
-    qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#address-cells", 3);
-    qemu_fdt_setprop_string(fdt, "/pci@80000000", "device_type", "pci");
-
-    fi.path = "/pci@80000000";
-    pci_bus = mv64361_get_pci_bus(pm->mv, 1);
-    pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
-
-    qemu_fdt_add_subnode(fdt, "/failsafe");
-    qemu_fdt_setprop_string(fdt, "/failsafe", "device_type", "serial");
-
-    qemu_fdt_add_subnode(fdt, "/rtas");
-    qemu_fdt_setprop_cell(fdt, "/rtas", "system-reboot", RTAS_SYSTEM_REBOOT);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "hibernate", RTAS_HIBERNATE);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "suspend", RTAS_SUSPEND);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "power-off", RTAS_POWER_OFF);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "set-indicator", RTAS_SET_INDICATOR);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "display-character",
-                          RTAS_DISPLAY_CHARACTER);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "write-pci-config",
-                          RTAS_WRITE_PCI_CONFIG);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "read-pci-config",
-                          RTAS_READ_PCI_CONFIG);
-    /* Pegasos2 firmware misspells check-exception and guests use that */
-    qemu_fdt_setprop_cell(fdt, "/rtas", "check-execption",
-                          RTAS_CHECK_EXCEPTION);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "event-scan", RTAS_EVENT_SCAN);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "set-time-of-day",
-                          RTAS_SET_TIME_OF_DAY);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "get-time-of-day",
-                          RTAS_GET_TIME_OF_DAY);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "nvram-store", RTAS_NVRAM_STORE);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "nvram-fetch", RTAS_NVRAM_FETCH);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "restart-rtas", RTAS_RESTART_RTAS);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-error-log-max", 0);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-event-scan-rate", 0);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-display-device", 0);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-size", 20);
-    qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-version", 1);
-
-    /* cpus */
-    qemu_fdt_add_subnode(fdt, "/cpus");
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#cpus", 1);
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 1);
-    qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0);
+    uint32_t cells[2];
 
     /* FIXME Get CPU name from CPU object */
     const char *cp = "/cpus/PowerPC,G4";
@@ -1034,15 +810,43 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     cells[1] = 0;
     qemu_fdt_setprop(fdt, cp, "reg", cells, 2 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fdt, cp, "device_type", "cpu");
+}
+
+static void *load_dtb(const char *filename, int *fdt_size)
+{
+    void *fdt;
+    g_autofree char *name = qemu_find_file(QEMU_FILE_TYPE_DTB, filename);
+
+    if (!name) {
+        error_report("Could not find dtb file '%s'", filename);
+        return NULL;
+    }
+    fdt = load_device_tree(name, fdt_size);
+    if (!fdt) {
+        error_report("Could not load dtb file '%s'", name);
+    }
+    return fdt;
+}
 
-    /* memory */
-    qemu_fdt_add_subnode(fdt, "/memory@0");
+static void *build_fdt(MachineState *machine, int *fdt_size)
+{
+    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    FDTInfo fi;
+    PCIBus *pci_bus;
+    uint32_t cells[2];
+    void *fdt = load_dtb("pegasos2.dtb", fdt_size);
+
+    if (!fdt) {
+        return NULL;
+    }
+    qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
+
+    /* Set memory size */
     cells[0] = 0;
     cells[1] = cpu_to_be32(machine->ram_size);
     qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fdt, "/memory@0", "device_type", "memory");
 
-    qemu_fdt_add_subnode(fdt, "/chosen");
+    /* Boot parameters */
     if (pm->initrd_addr && pm->initrd_size) {
         qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
                               pm->initrd_addr + pm->initrd_size);
@@ -1052,8 +856,15 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                             machine->kernel_cmdline ?: "");
 
-    qemu_fdt_add_subnode(fdt, "/openprom");
-    qemu_fdt_setprop_string(fdt, "/openprom", "model", "Pegasos2,1.1");
+    add_cpu_info(fdt, pm->cpu);
+
+    fi.fdt = fdt;
+    fi.path = "/pci@c0000000";
+    pci_bus = mv64361_get_pci_bus(pm->mv, 0);
+    pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
+    fi.path = "/pci@80000000";
+    pci_bus = mv64361_get_pci_bus(pm->mv, 1);
+    pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
 
     return fdt;
 }
diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
index 993032949f..f14648f3a4 100644
--- a/pc-bios/dtb/meson.build
+++ b/pc-bios/dtb/meson.build
@@ -1,6 +1,7 @@
 dtbs = [
   'bamboo.dtb',
   'canyonlands.dtb',
+  'pegasos2.dtb',
   'petalogix-ml605.dtb',
   'petalogix-s3adsp1800.dtb',
 ]
diff --git a/pc-bios/dtb/pegasos2.dtb b/pc-bios/dtb/pegasos2.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..29c35216ec2d77e4083a3ef618ca185925fb5d61
GIT binary patch
literal 1701
zcmb_cyKWRQ6!nns2oQw;9TbZ~fl!Q+2&AN25u&7m6$nwJh`gS=yH;k#6WhC+r9h#h
zgAYK01`0YPJ|IXGlptz8fP#XKNGRf7&v-N0P;#X^bI!5v!;hISllwmzJMo4ww#eA{
zXMA5npGH52juw4K{Y8NfJ)@G1;d{Kqq!B-kJ|#OQFLlx;&@VNhEv&W+6`jVeEZp`A
z;WOyhn|UI#+G^Td8|oCl^pE(<sIQiKZF%i}qt?)UFpcHfgMoFBQi4e5kmW{uf}HA1
zq7VC-oxd@Uoa`8SBs<zdcED3ewHegsyi&xUL_AgKUZtF;(APaH9!0LaYfFvh&|Ynf
zaH3)FXneEeKHfMn8oxC%{|WMo=pp|z#AJcLEa;HGAK{-y_*dlBe((<XeF^z~ASWF7
z9%Aad<Pn|Ki3+FQXurbvRm8Mcf!{<-F@dijK3(CD5YxQ~<A8X&!ZqUa72ZdDp~9ac
zrXKu$wuDNoXi*L_%IVM2f>9#znxB_TRbQMd%&WutYzoInD*N%HgafDZr5q)Xo=1OP
zKP)-kq39KDZm|6TP^2KToze-{>2Z+j?JsurL&^Pp+d)!CM+@~n7SwZ`6MZW=y{JS)
zYm@(JZDV`&cbJoEA6eUP6uni}wu=HeS<OE~pKN{iu!eUkqP1Xjm~&(;w4R9>5yu9s
z<r0#_vKV?w!iF2<z)~GU!VD@_>5MJkyR)*oa(A`|S**>FHnlMEki}r7QMsc418p{A
z)nh1g&q(^7>7(R5Fg~XzG^LPZW%2hl;6)dO23XH=D@DeQaOFfWMjM{!Hc!Pi7P3wl
z$Nl%7^^8b)3!Ln*0$ZmIur@gER0>?Tcq|6Yj_`vzOm;wSa@YnL79wJf2hXL>TB^<Z
zMmeYop>Np{Mo0(7XIELQq`=}Vr~fJzZZX@n_(P3ZM>WA@v>xmKwcJ2cYsX}wv2@G8
zRu?ikU`AwZuxxSR))H44W;Wg2aUnM|-A^EH1Eap0Mj_-`H^r>1*|oS;7{~qsTcHaV

literal 0
HcmV?d00001

diff --git a/pc-bios/dtb/pegasos2.dts b/pc-bios/dtb/pegasos2.dts
new file mode 100644
index 0000000000..0ddb9e3bec
--- /dev/null
+++ b/pc-bios/dtb/pegasos2.dts
@@ -0,0 +1,167 @@
+/*
+ * QEMU Pegasos2 Device Tree Source
+ *
+ * Copyright 2025 BALATON Zoltan
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This is partial source, more info will be filled in by board code.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	device_type = "chrp";
+	model = "Pegasos2";
+	revision = "2B";
+	CODEGEN,vendor = "bplan GmbH";
+	CODEGEN,board = "Pegasos2";
+	CODEGEN,description = "Pegasos CHRP PowerPC System";
+
+	openprom {
+		model = "Pegasos2,1.1";
+	};
+
+	chosen {
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
+	cpus {
+		#size-cells	= <0>;
+		#address-cells	= <1>;
+		#cpus		= <1>;
+	};
+
+	rtas {
+		rtas-version		= <1>;
+		rtas-size		= <20>;
+		rtas-display-device	= <0>;
+		rtas-event-scan-rate	= <0>;
+		rtas-error-log-max	= <0>;
+		restart-rtas		= <0>;
+		nvram-fetch		= <1>;
+		nvram-store		= <2>;
+		get-time-of-day		= <3>;
+		set-time-of-day		= <4>;
+		event-scan		= <6>;
+		/* Pegasos2 firmware misspells check-exception */
+		check-execption		= <7>;
+		read-pci-config		= <8>;
+		write-pci-config	= <9>;
+		display-character	= <10>;
+		set-indicator		= <11>;
+		power-off		= <17>;
+		suspend			= <18>;
+		hibernate		= <19>;
+		system-reboot		= <20>;
+	};
+
+	failsafe {
+		device_type = "serial";
+	};
+
+	pci@80000000 {
+		device_type		= "pci";
+		#address-cells		= <3>;
+		#size-cells		= <2>;
+		clock-frequency		= <33333333>;
+		ranges = <0x01000000 0 0x00000000 0xfe000000 0 0x00010000
+			  0x02000000 0 0x80000000 0x80000000 0 0x40000000>;
+		8259-interrupt-acknowledge = <0xf1000cb4>;
+		reg = <0x80000000 0x40000000>;
+		pci-bridge-number	= <0>;
+		bus-range		= <0 0>;
+
+		isa@c {
+			vendor-id	= <0x1106>;
+			device-id	= <0x8231>;
+			revision-id	= <0x10>;
+			class-code	= <0x60100>;
+			/* Pegasos firmware has subsystem-id and
+			   subsystem-vendor-id swapped */
+			subsystem-id	= <0x1af4>;
+			subsystem-vendor-id = <0x1100>;
+			reg = <0x6000 0 0 0 0>;
+			device_type	= "isa";
+			#address-cells	= <2>;
+			#size-cells	= <1>;
+			eisa-slots	= <0>;
+			clock-frequency	= <8333333>;
+			slot-names	= <0>;
+
+			serial@i2f8 {
+				device_type	= "serial";
+				reg		= <1 0x2f8 8>;
+				interrupts	= <3 0>;
+				clock-frequency	= <1843200>;
+				compatible	= "pnpPNP,501";
+			};
+
+			8042@i60 {
+				device_type	= "";
+				reg		= <1 0x60 5>;
+				clock-frequency	= <0>;
+				compatible	= "chrp,8042";
+				interrupt-controller = "";
+				#address-cells	= <1>;
+				#size-cells	= <0>;
+				#interrupt-cells = <2>;
+
+			};
+
+			keyboard@i60 {
+				device_type	= "keyboard";
+				reg		= <1 0x60 5>;
+				interrupts	= <1 0>;
+				compatible	= "pnpPNP,303";
+			};
+
+			rtc@i70 {
+				device_type	= "rtc";
+				reg		= <1 0x70 2>;
+				interrupts	= <8 0>;
+				clock-frequency	= <0>;
+				compatible	= "ds1385-rtc";
+			};
+
+			timer@i40 {
+				device_type	= "timer";
+				reg		= <1 0x40 8>;
+				clock-frequency	= <0>;
+				compatible	= "pnpPNP,100";
+			};
+
+			fdc@i3f0 {
+				device_type	= "fdc";
+				reg		= <1 0x3f0 8>;
+				interrupts	= <6 0>;
+				clock-frequency	= <0>;
+				compatible	= "pnpPNP,700";
+			};
+
+			lpt@i3bc {
+				device_type	= "lpt";
+				reg		= <1 0x3bc 8>;
+				interrupts	= <7 0>;
+				clock-frequency	= <0>;
+				compatible	= "pnpPNP,400";
+			};
+		};
+	};
+
+	pci@c0000000 {
+		device_type		= "pci";
+		#address-cells		= <3>;
+		#size-cells		= <2>;
+		clock-frequency		= <66666666>;
+		ranges = <0x01000000 0 0x00000000 0xf8000000 0 0x00010000
+			  0x02000000 0 0xc0000000 0xc0000000 0 0x20000000>;
+		reg = <0xc0000000 0x20000000>;
+		pci-bridge-number	= <1>;
+		bus-range		= <0 0>;
+	};
+};
-- 
2.43.5


