Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B16CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOMK-0007m5-Gf; Thu, 30 Oct 2025 04:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOMA-0007Wy-UB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vEOM6-0007LV-L3
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:50:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TLlKcu026264
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GPbVsQqPoUn5GspAa
 APYZ/4VI48igMJQkCmuese8UTk=; b=LIn5cqevfwJ8sHlUrJ2HJpFldKLIZ+E5U
 ZEmdMhGiiRLb008w6nrI3DY7ZPrAGZ5tD5s+cR+RNC69fvob9DE++LtpX2OLP7oE
 dHx3jd/8pSFe8L7HJfgnq2Sr02WmSzQlBbh1unVKsyulIyMRsE5StnJdpTMvDhoY
 a94iWBm062P7OmxeXY3E7qLa53upIdQeh7RMig1r9cRDa1QMpDVkyFdBlw/MB26j
 2NeqppqlA53pZL0jeT+FBTn+ypg1d/DcMJTCiLKtDNFxLeIrGR7TJlYEJ0kpHf68
 Y9YGHl2wvb5lV7Q354P9mSnZweKBIPg3mnaAlOjo90Ns7L73Wmorg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aaq7ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:59 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U8mqYP028976
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:49:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aaq7fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U66vOW023847;
 Thu, 30 Oct 2025 08:49:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a33vx7qx7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:49:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59U8nsho41550206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Oct 2025 08:49:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 017A12004B;
 Thu, 30 Oct 2025 08:49:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D27520040;
 Thu, 30 Oct 2025 08:49:53 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.24]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Oct 2025 08:49:52 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Yoges Vyas <yvyas1991@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 05/10] ppc/spapr: Cleanup MSI IRQ number handling
Date: Thu, 30 Oct 2025 14:19:31 +0530
Message-ID: <20251030084936.1132417-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251030084936.1132417-1-harshpb@linux.ibm.com>
References: <20251030084936.1132417-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690326b7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=DxytLDYTajZr7bAJKvwA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-ORIG-GUID: 78HW8t0pAaJSoK7t32HOWNZUUfmTNrq6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX39ai2TmMj2C2
 e7TMMRBARNRGVnB0HVqatbE5k8Ug56Ww2Smozw+2SpaQyt7ZwxBgD8L1GyX/x7IGfRaoud+Z7Xx
 Azz/A9jzm9uMit+W9ozqeCdIZBk4MMKhJ7faK495L60vWvUGqXGXjkYkq10317BQyz1B/1uhIXq
 rfj6ytlQOqxGeFcB2Yxcbu/ziARu/qJSjHQCPO0mN/IRzxzqAgJh+k1YmGiZoWCZiYQh2bnMBfR
 vUPIga//RAQSHsdGdRf2d+CeyrjJAczLFP7rXxE8cFbpCAxeA9ycunxtCmoaXvKtJDJbwXD5u0v
 qoRgyMNbBIH2B041OlKdHKAdOrLflokKDF8VnoaLF+GD8aZPUuKDbcrKTIRA/xAAaAE/oofvFGg
 3G5uCTzqeeSAVgWVkGEZjPjbI5Tk8g==
X-Proofpoint-GUID: ES6EKJx5JISngOoQQQhqdOHe7COkVWsf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
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

From: Yoges Vyas <yvyas1991@gmail.com>

Now that spapr_irq_nr_msis() returns a constant value,
lets replace it with a macro.
Ref: https://lore.kernel.org/qemu-devel/bf149815-9782-4964-953d-73658b1043c9@linux.ibm.com/

Suggested-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Yogesh Vyas <yvyas1991@gmail.com>
Reviewed-by: Chinmay Rath <rathc@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20251026074852.53691-1-yvyas1991@gmail.com
Message-ID: <20251026074852.53691-1-yvyas1991@gmail.com>
---
 include/hw/ppc/spapr_irq.h | 2 +-
 hw/ppc/spapr_irq.c         | 7 +------
 hw/ppc/spapr_pci.c         | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 5ddd1107c3..265d43e06b 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -40,6 +40,7 @@
 #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
 
 #define SPAPR_NR_XIRQS       0x1000
+#define SPAPR_IRQ_NR_MSIS    (SPAPR_XIRQ_BASE + SPAPR_NR_XIRQS - SPAPR_IRQ_MSI)
 
 struct SpaprMachineState;
 
@@ -89,7 +90,6 @@ void spapr_irq_print_info(struct SpaprMachineState *spapr, GString *buf);
 void spapr_irq_dt(struct SpaprMachineState *spapr, uint32_t nr_servers,
                   void *fdt, uint32_t phandle);
 
-uint32_t spapr_irq_nr_msis(struct SpaprMachineState *spapr);
 int spapr_irq_msi_alloc(struct SpaprMachineState *spapr, uint32_t num, bool align,
                         Error **errp);
 void spapr_irq_msi_free(struct SpaprMachineState *spapr, int irq, uint32_t num);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2ce323457b..fc45a5d5d6 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -33,7 +33,7 @@ static const TypeInfo spapr_intc_info = {
 
 static void spapr_irq_msi_init(SpaprMachineState *spapr)
 {
-    spapr->irq_map_nr = spapr_irq_nr_msis(spapr);
+    spapr->irq_map_nr = SPAPR_IRQ_NR_MSIS;
     spapr->irq_map = bitmap_new(spapr->irq_map_nr);
 }
 
@@ -277,11 +277,6 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
     sicc->dt(spapr->active_intc, nr_servers, fdt, phandle);
 }
 
-uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
-{
-    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
-}
-
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     if (kvm_enabled() && kvm_kernel_irqchip_split()) {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index bdec8f0728..d596a9e38e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2279,7 +2279,7 @@ int spapr_dt_phb(SpaprMachineState *spapr, SpaprPhbState *phb,
     _FDT(fdt_setprop(fdt, bus_off, "reg", &bus_reg, sizeof(bus_reg)));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi",
-                          spapr_irq_nr_msis(spapr)));
+                          SPAPR_IRQ_NR_MSIS));
 
     /* Dynamic DMA window */
     if (phb->ddw_enabled) {
-- 
2.43.5


