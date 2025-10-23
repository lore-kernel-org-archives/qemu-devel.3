Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78E0CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuKp-00068k-4d; Thu, 23 Oct 2025 08:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG4-0001Fm-V9
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFy-0006Q2-DJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3p0Of032408;
 Thu, 23 Oct 2025 12:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5qJcKAaxEhbQQl8EH
 ZhB8vzb0tre6FGBmz2jv71gkIY=; b=ivxrfMdDmCRqVZDWJiI+aHehzDsDeWJf/
 fsMH2o9eTxNJKawWMGJTEMmSIVvkymL/ZHHql5Pk+3EnbIGXoyzymsV0ztjpRQ1+
 aNpKVfCoZJaZ5jdCz96l8ehVYM0AkA+YhSTYrVnsLNdCrRo+rriggn6VwJfHBKtt
 RATuNCSLn4bFe4p5lg3+Z1nSvSmTcrJzSL3PKbtWH+IXWA8jGR2ozUCxrnhnh8f4
 sX+QAwAZHYKYpd13HGc9PNew+CbNA/hhqm9rFlm12QDqbMYc8WQrwGl4oNqtADBB
 H5Cc28Sk9lojErzvx+3dhpkX8airD0YLG34vS02KT/w+mOzS4BxOw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgnye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9C5MO014685;
 Thu, 23 Oct 2025 12:17:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdttk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHJgI35455250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 742FD2004B;
 Thu, 23 Oct 2025 12:17:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9DCC20043;
 Thu, 23 Oct 2025 12:17:18 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:18 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 14/32] hw/ppc/pegasos2: Remove explicit name properties from
 device tree
Date: Thu, 23 Oct 2025 17:46:33 +0530
Message-ID: <20251023121653.3686015-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HA7pwPzkjwsHocRhAKq3Lm8-B9bXpzUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7BJK7j4AfN7w
 lZaOdp8OlzZlA7RjYTtPQCRNaJqYI8mk8wEiz6hrMBRvueQjBofPf9QeUpytnjeroXkvqvcRT7S
 pW5xG36vWPiO6Dvs7gnHsoBTf8dG1GdcJXWJHHRWYMeVQqPRo5bfnxuGx1xXsCcvIr3whKH6207
 3iVicILI4yZs5ViGcfqiHY1Q67GL7w87nf8pQYXtVTS5ts7OhDkCDkUXwhzJvTNs8QOwMPROo3R
 x+hsdYerMS3Qd0TD9MoNB/x0y1Z/ekBUpQgGYyUUeUQKUumHJOeIabCXqIVtVkhQTkSpNRmsqAT
 V5FufKsp2+EmwTSc4kjV+hehZfQpn+ToAHNymmBg3kflODxUYgkULM+Iv/Y6m2k+Az6/4ZeNNf0
 nTV/rN1T7jmzxEj2U+ZBW1zEVpbxWg==
X-Proofpoint-GUID: HA7pwPzkjwsHocRhAKq3Lm8-B9bXpzUL
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa1cd3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VppXks6di9rBbx2e8wcA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
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

These are not needed any more now that VOF can handle it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/fa36ab5a04e10c6acb89583f646aad83df2b0b13.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index e15cf96427..73995624e5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -662,7 +662,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     qemu_fdt_setprop_cell(fi->fdt, fi->path, "#size-cells", 1);
     qemu_fdt_setprop_cell(fi->fdt, fi->path, "#address-cells", 2);
     qemu_fdt_setprop_string(fi->fdt, fi->path, "device_type", "isa");
-    qemu_fdt_setprop_string(fi->fdt, fi->path, "name", "isa");
 
     /* additional devices */
     g_string_printf(name, "%s/lpt@i3bc", fi->path);
@@ -677,7 +676,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "lpt");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "lpt");
 
     g_string_printf(name, "%s/fdc@i3f0", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -691,7 +689,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "fdc");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "fdc");
 
     g_string_printf(name, "%s/timer@i40", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -701,7 +698,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "timer");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "timer");
 
     g_string_printf(name, "%s/rtc@i70", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -716,7 +712,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(2);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "rtc");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "rtc");
 
     g_string_printf(name, "%s/keyboard@i60", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -729,7 +724,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(5);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "keyboard");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "keyboard");
 
     g_string_printf(name, "%s/8042@i60", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -743,7 +737,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(5);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "8042");
 
     g_string_printf(name, "%s/serial@i2f8", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -757,7 +750,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "serial");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "serial");
 
     g_string_free(name, TRUE);
 }
@@ -846,7 +838,6 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         j += 5;
     }
     qemu_fdt_setprop(fi->fdt, node->str, "reg", cells, j * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, node->str, "name", name ?: pn);
     if (pci_get_byte(&d->config[PCI_INTERRUPT_PIN])) {
         qemu_fdt_setprop_cell(fi->fdt, node->str, "interrupts",
                               pci_get_byte(&d->config[PCI_INTERRUPT_PIN]));
@@ -916,7 +907,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#size-cells", 2);
     qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#address-cells", 3);
     qemu_fdt_setprop_string(fdt, "/pci@c0000000", "device_type", "pci");
-    qemu_fdt_setprop_string(fdt, "/pci@c0000000", "name", "pci");
 
     fi.path = "/pci@c0000000";
     pci_bus = mv64361_get_pci_bus(pm->mv, 0);
@@ -951,7 +941,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#size-cells", 2);
     qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#address-cells", 3);
     qemu_fdt_setprop_string(fdt, "/pci@80000000", "device_type", "pci");
-    qemu_fdt_setprop_string(fdt, "/pci@80000000", "name", "pci");
 
     fi.path = "/pci@80000000";
     pci_bus = mv64361_get_pci_bus(pm->mv, 1);
@@ -959,7 +948,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
 
     qemu_fdt_add_subnode(fdt, "/failsafe");
     qemu_fdt_setprop_string(fdt, "/failsafe", "device_type", "serial");
-    qemu_fdt_setprop_string(fdt, "/failsafe", "name", "failsafe");
 
     qemu_fdt_add_subnode(fdt, "/rtas");
     qemu_fdt_setprop_cell(fdt, "/rtas", "system-reboot", RTAS_SYSTEM_REBOOT);
@@ -989,14 +977,12 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-display-device", 0);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-size", 20);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-version", 1);
-    qemu_fdt_setprop_string(fdt, "/rtas", "name", "rtas");
 
     /* cpus */
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "#cpus", 1);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0);
-    qemu_fdt_setprop_string(fdt, "/cpus", "name", "cpus");
 
     /* FIXME Get CPU name from CPU object */
     const char *cp = "/cpus/PowerPC,G4";
@@ -1048,7 +1034,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     cells[1] = 0;
     qemu_fdt_setprop(fdt, cp, "reg", cells, 2 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fdt, cp, "device_type", "cpu");
-    qemu_fdt_setprop_string(fdt, cp, "name", strrchr(cp, '/') + 1);
 
     /* memory */
     qemu_fdt_add_subnode(fdt, "/memory@0");
@@ -1056,7 +1041,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     cells[1] = cpu_to_be32(machine->ram_size);
     qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fdt, "/memory@0", "device_type", "memory");
-    qemu_fdt_setprop_string(fdt, "/memory@0", "name", "memory");
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     if (pm->initrd_addr && pm->initrd_size) {
@@ -1067,7 +1051,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                             machine->kernel_cmdline ?: "");
-    qemu_fdt_setprop_string(fdt, "/chosen", "name", "chosen");
 
     qemu_fdt_add_subnode(fdt, "/openprom");
     qemu_fdt_setprop_string(fdt, "/openprom", "model", "Pegasos2,1.1");
-- 
2.43.5


