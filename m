Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EC3CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuNd-0001wo-Lg; Thu, 23 Oct 2025 08:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG8-0001Hi-TU
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG3-0006RF-5S
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N3o6Yk001436;
 Thu, 23 Oct 2025 12:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EyGce5
 BYg9S+8n9a9Rw7o7tsF5KsQMLdcxs+HlA08vU=; b=iDmsb6ofNkvSZttSfdwh5P
 QnG1mVPfpcFy308QqlwJmpSQwF7lUhTInT+hGvFJW6BARxGxqrI4JF79vtJqXEoV
 S+JaqWEF3fFgeumklntNlU3RB6xlCPBf/vhgEzq26Q2Fbp9HYBT0XTdQ36FDhngk
 +WydkEuwVOpPcjaP+njxD+OEAguEkpM2DReRDzlWbKaGzA8ggq7FUvDoO+l73ahA
 /3XPLwnHRcB13XXFdiUEgbsQ9v3nW5szSd341MIICNMehYTe9WtHevaudapFBYaz
 7FaLvVF8SCFAE31IUYMNN67tqAFpTWhYNIQOJsre6n24zkqFZmgnvHtMhT81qlKg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sa1cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9iUZh017058;
 Thu, 23 Oct 2025 12:17:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky5qwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCHNID21430982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C5EA2004B;
 Thu, 23 Oct 2025 12:17:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6908820040;
 Thu, 23 Oct 2025 12:17:22 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:22 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/32] hw/ppc/pegasos2: Rename mv field in machine state
Date: Thu, 23 Oct 2025 17:46:36 +0530
Message-ID: <20251023121653.3686015-18-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0gSGyzKPMYUdrWyELDL5xA9wPNTKk_QQ
X-Proofpoint-GUID: 0gSGyzKPMYUdrWyELDL5xA9wPNTKk_QQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyhLUGHL4DgDR
 Fpnt3NQOIW0jnys4K9XXNpE2K/aMwYCu/p0Cl8ah/BC8op9ulhZP0j5tj1jLDGG/sRw8irUqF7P
 NxQk0ej+bmKKAGQ3MdonHW6ihCGgBAguSaw+Ee2FVPEV0uOQQzdPEsbGs/hULYNvdzfdC9fUutE
 nnxbP3gcFPpVpPhRRAFptrgBNLJPPbmoJ/f3PaP+FSv15UO5pUEkDDsnTvwXhdFf7KG37R2fky4
 sOIMLORq178j2r5N/8EIUBarEyy0XSiHMEJ+ybsuaDdXvt1vFQ1H4ShAG7HOdiq0KkrImqLeUme
 VowDrH9iSle/4+YevorIPQy5HvO8CGZJ2FZJr+G8aNqItm//m3PL7tRWPGeFhY7IfRHRbT9uNut
 A+RClfnqQwzalpJgqrC/CE2vYEO+Lw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fa1cd6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=VqWj-gOvcHZ2Xb4X8q8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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

Use more generic name for the field used to store the north bridge in
the machine state.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f1c189f16a260377abe0d270e778f2738649446a.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 2ba579dddf..9b89c7ecc2 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -68,7 +68,7 @@ struct Pegasos2MachineState {
     MachineState parent_obj;
 
     PowerPCCPU *cpu;
-    DeviceState *mv;
+    DeviceState *nb; /* north bridge */
     IRQState pci_irqs[PCI_NUM_PINS];
     OrIRQState orirq[PCI_NUM_PINS];
     qemu_irq mv_pirq[PCI_NUM_PINS];
@@ -166,12 +166,12 @@ static void pegasos2_init(MachineState *machine)
     }
 
     /* Marvell Discovery II system controller */
-    pm->mv = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
+    pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
                           qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->mv, "gpp", 12 + i);
+        pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
     }
-    pci_bus = mv64361_get_pci_bus(pm->mv, 1);
+    pci_bus = mv64361_get_pci_bus(pm->nb, 1);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
     via = OBJECT(pci_new_multifunction(PCI_DEVFN(12, 0), TYPE_VT8231_ISA));
@@ -190,7 +190,7 @@ static void pegasos2_init(MachineState *machine)
                               object_resolve_path_component(via, "rtc"),
                               "date");
     qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
-                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
+                                qdev_get_gpio_in_named(pm->nb, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
@@ -208,7 +208,7 @@ static void pegasos2_init(MachineState *machine)
         DeviceState *pd;
         g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
 
-        pd = DEVICE(object_resolve_path_component(OBJECT(pm->mv), pn));
+        pd = DEVICE(object_resolve_path_component(OBJECT(pm->nb), pn));
         assert(pd);
         for (i = 0; i < PCI_NUM_PINS; i++) {
             OrIRQState *ori = &pm->orirq[i];
@@ -267,7 +267,7 @@ static void pegasos2_init(MachineState *machine)
 static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
                                      uint32_t addr, uint32_t len)
 {
-    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->mv), 0);
+    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
     uint64_t val = 0xffffffffULL;
     memory_region_dispatch_read(r, addr, &val, size_memop(len) | MO_LE,
                                 MEMTXATTRS_UNSPECIFIED);
@@ -277,7 +277,7 @@ static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
 static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
                                   uint32_t len, uint32_t val)
 {
-    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->mv), 0);
+    MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
     memory_region_dispatch_write(r, addr, val, size_memop(len) | MO_LE,
                                  MEMTXATTRS_UNSPECIFIED);
 }
@@ -857,10 +857,10 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
 
     fi.fdt = fdt;
     fi.path = "/pci@c0000000";
-    pci_bus = mv64361_get_pci_bus(pm->mv, 0);
+    pci_bus = mv64361_get_pci_bus(pm->nb, 0);
     pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
     fi.path = "/pci@80000000";
-    pci_bus = mv64361_get_pci_bus(pm->mv, 1);
+    pci_bus = mv64361_get_pci_bus(pm->nb, 1);
     pci_for_each_device_reverse(pci_bus, 0, add_pci_device, &fi);
 
     return fdt;
-- 
2.43.5


