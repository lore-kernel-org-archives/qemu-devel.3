Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3898DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtko-0001lB-7H; Thu, 23 Oct 2025 07:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkm-0001hT-8c
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkj-0001cn-Oa
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:11 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N7h6Wg002474;
 Thu, 23 Oct 2025 11:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9iBxiB
 LeBwvy9mCaX1xtUVuE7Oh9PcyzMKCkJrJ5pgE=; b=JADJ6kV3PZYJ9mYaX8M2e6
 DWKIDNY4ok7mAKaVt9WOsni9DxywG1rebVyMs5CbVNRG/QiftpPzf1HakQDgXuXf
 zJcQ66ExPOxxHNYJ17i5fIxPtvJRqiNApC/FNFlMaZnZM7Y+yAJRPOPEgYPfm4J8
 WMmZyFqgMM/0iEk5FSOh/IH77A3UIfATHSO+LM9usseQUiEiktOPWfZ/tIpvq4S4
 t/ejyiYOY4Dqs5lIRLFJUsu4v03An6tO2lp66j9HPTzr+649pN36vymJ7GSVF87e
 ujIqiKBo7OyoNmu4Yqm1cIqr1L5hPPk5DTzK/IuixblcRDBsVJakJLBz3YamE6zQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3271wch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NB1VkE011075;
 Thu, 23 Oct 2025 11:44:54 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1d6ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:44:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBiq1u54133090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:44:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7C9520049;
 Thu, 23 Oct 2025 11:44:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6E8E20040;
 Thu, 23 Oct 2025 11:44:51 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:44:51 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/32] hw/ppc/pegasos2: Move PCI IRQ routing setup to a function
Date: Thu, 23 Oct 2025 17:14:06 +0530
Message-ID: <20251023114422.3675018-20-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa1537 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=Px54sdigDSgh_EqQyywA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3y5IAoMDpRxd
 KOnunwJPC2u805aMyb/QTzFsO01CfqF0LIo0panc8WDRUk922FepYY7O+qiP4xCFbn9cXN91J++
 pAzNRejb38g4lV/a2xBH57Xhti/ccLM1XxDGLaX81fUbv0OuBZnro0NBHGiN7gmQbKMLZdg5/4M
 4rrEh1ddG2pWCBsifppt7CLlPQ/CUyKtuuQoq/t33RbVxKF39AvIUJLdgRikLRriN6iYNucCPW5
 LSt+ityDVtArJn4OC1+8ZYTowo8zYKjCl8parFzPk+8z4qaPJe6yx4f9mf3ooiD79rsyoznjVAn
 kqMrSmLbrL6osWq3L7L7UJ/33t5zYAE7wYvoWzC3sLfGYI+DaX/miuE0ntr0DSzzXukWyhB6lma
 Xyb19Hkko6Zzgvo/VE5ePjAT5TRh8A==
X-Proofpoint-GUID: m6WPlVmswBiPIJDGYmGGFERud3uOD02G
X-Proofpoint-ORIG-GUID: m6WPlVmswBiPIJDGYmGGFERud3uOD02G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
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

Collect steps of setting up PCI IRQ routing in one function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/f5ff16a6933ab6e1f9e194d16ef85364ac3cf6df.1761176219.git.balaton@eik.bme.hu
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pegasos2.c | 66 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 4b63f0e175..2f9bd3eac5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -107,6 +107,38 @@ static void pegasos2_pci_irq(void *opaque, int n, int level)
     qemu_set_irq(pm->via_pirq[n], level);
 }
 
+/* Set up PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
+static void pegasos2_setup_pci_irq(Pegasos2MachineState *pm)
+{
+    for (int h = 0; h < 2; h++) {
+        DeviceState *pd;
+        g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
+
+        pd = DEVICE(object_resolve_path_component(OBJECT(pm->nb), pn));
+        assert(pd);
+        for (int i = 0; i < PCI_NUM_PINS; i++) {
+            OrIRQState *ori = &pm->orirq[i];
+
+            if (h == 0) {
+                g_autofree const char *n = g_strdup_printf("pci-orirq[%d]", i);
+
+                object_initialize_child_with_props(OBJECT(pm), n,
+                                                   ori, sizeof(*ori),
+                                                   TYPE_OR_IRQ, &error_fatal,
+                                                   "num-lines", "2", NULL);
+                qdev_realize(DEVICE(ori), NULL, &error_fatal);
+                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, i);
+                qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]);
+                pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
+                pm->via_pirq[i] = qdev_get_gpio_in_named(pm->sb, "pirq", i);
+            }
+            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori), h));
+        }
+    }
+    qdev_connect_gpio_out_named(pm->sb, "intr", 0,
+                                qdev_get_gpio_in_named(pm->nb, "gpp", 31));
+}
+
 static void pegasos2_init(MachineState *machine)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
@@ -118,7 +150,6 @@ static void pegasos2_init(MachineState *machine)
     I2CBus *i2c_bus;
     const char *fwname = machine->firmware ?: PROM_FILENAME;
     char *filename;
-    int i;
     ssize_t sz;
     uint8_t *spd_data;
 
@@ -169,9 +200,6 @@ static void pegasos2_init(MachineState *machine)
     /* Marvell Discovery II system controller */
     pm->nb = DEVICE(sysbus_create_simple(TYPE_MV64361, -1,
                           qdev_get_gpio_in(DEVICE(pm->cpu), PPC6xx_INPUT_INT)));
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        pm->mv_pirq[i] = qdev_get_gpio_in_named(pm->nb, "gpp", 12 + i);
-    }
     pci_bus = mv64361_get_pci_bus(pm->nb, 1);
 
     /* VIA VT8231 South Bridge (multifunction PCI device) */
@@ -185,14 +213,9 @@ static void pegasos2_init(MachineState *machine)
     }
 
     pci_realize_and_unref(PCI_DEVICE(via), pci_bus, &error_abort);
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        pm->via_pirq[i] = qdev_get_gpio_in_named(DEVICE(via), "pirq", i);
-    }
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
-                                qdev_get_gpio_in_named(pm->nb, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
@@ -205,30 +228,7 @@ static void pegasos2_init(MachineState *machine)
     /* other PC hardware */
     pci_vga_init(pci_bus);
 
-    /* PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
-    for (int h = 0; h < 2; h++) {
-        DeviceState *pd;
-        g_autofree const char *pn = g_strdup_printf("pcihost%d", h);
-
-        pd = DEVICE(object_resolve_path_component(OBJECT(pm->nb), pn));
-        assert(pd);
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            OrIRQState *ori = &pm->orirq[i];
-
-            if (h == 0) {
-                g_autofree const char *n = g_strdup_printf("pci-orirq[%d]", i);
-
-                object_initialize_child_with_props(OBJECT(pm), n,
-                                                   ori, sizeof(*ori),
-                                                   TYPE_OR_IRQ, &error_fatal,
-                                                   "num-lines", "2", NULL);
-                qdev_realize(DEVICE(ori), NULL, &error_fatal);
-                qemu_init_irq(&pm->pci_irqs[i], pegasos2_pci_irq, pm, i);
-                qdev_connect_gpio_out(DEVICE(ori), 0, &pm->pci_irqs[i]);
-            }
-            qdev_connect_gpio_out(pd, i, qdev_get_gpio_in(DEVICE(ori), h));
-        }
-    }
+    pegasos2_setup_pci_irq(pm);
 
     if (machine->kernel_filename) {
         sz = load_elf(machine->kernel_filename, NULL, NULL, NULL,
-- 
2.43.5


