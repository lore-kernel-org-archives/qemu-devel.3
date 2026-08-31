Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1749C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x11AB-0003Zc-4q; Mon, 31 Aug 2026 08:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A7-0003XY-0c; Mon, 31 Aug 2026 08:30:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1x11A5-00068G-3M; Mon, 31 Aug 2026 08:30:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBVd2x1974389; Mon, 31 Aug 2026 12:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dfcIkX
 3EAGKoyDAS8ZDM4uu/y1dkBZiNV17u/zTYUcA=; b=W6macO++COZDvlnbNgpLuG
 +KqcFp6dNR9BeodbJOLMEAsg9o9mhAzLi+uOe0f0ykXM1+Eabm3qm6+h96rYUUWQ
 4p5Q/XHo4gp2YX8ZewhO41k6fFnMKIEyBqaDL47XbcLU2zukLoJKJ42bNxPK9M2I
 WerZDTkoQZ9UMPyLAO2X0CwiSkAbxCgAbHTGS5zi00eiGU4xNGxdk9/TZSuSOjDW
 r2llexrsOjFiU2v+Z8g4gq1AbrpRHCPVYd7JwvGX3tvSFXhZr9c2OKVhVEDBLHm6
 EIaEual9bzRbq9Bf6T4SjUICkPiz6vND+K1N6azB5yEGuLo9iTkxjJE4GDA2eaDg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhhc2w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VCQGpm001137;
 Mon, 31 Aug 2026 12:30:26 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq5yc3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 12:30:26 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VCUPfl26346196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 12:30:25 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E3125805D;
 Mon, 31 Aug 2026 12:30:25 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7411858062;
 Mon, 31 Aug 2026 12:30:24 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 12:30:24 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 9/9] pnv/phb5: Mask off LSI Source-ID based on number of
 interrupts
Date: Mon, 31 Aug 2026 07:30:05 -0500
Message-ID: <20260831123005.1485518-10-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Jwwcgcw5Yp1303KGx56ymfvy6ScJMoP3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX0AbbhwRQcHmt
 zimwPFRMYGMc0Ksu3/Q5yqEvAVqWq1nLr8omMX+3nNSgn3vgCDz2TrQUzsQDImcMcGTgZJ5G/4P
 ExVRtwoBVyo2X8PPWYdIYkWORGsufFMvEZtFTJ74P10ncHXafGJY9uKs1w3+srImaOgbaHpXG8k
 BH4Ven0fbRjOYGpj1JywyqYuxVe0ruUJxCB9K2pKYjGft7MqM9vukoYimEvJpJEET8Tw81H9hWO
 cyBUgidOS/sLk/NY+rRDQSqZjur2zQcuvUQ3CH6UyHpTl5nLnU2Zmvd8ix/U1H8C23I1yzJU+fs
 1Pope0nZznVgfbtZWS8ansCswYm6cMHJEF2eiY+ie0+KT59tvFjJ2SJThmVdWQmJ5nwrFJ6m6F0
 dZc+mGf8xvfNK2rxoYkiwhF4vE3jjpX8xbPX8rk18e3W4EZi016jJepmwKwQfGZ5bsbQx2E+biP
 p7MEPROkTSabOrEIueQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9573e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=-uQQ_z-csOHJncX4BtYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwNCBTYWx0ZWRfX16c5A6pHwBrW
 EZeP9+F3uWC5LZtJsh6UKRn5mqPC7PVNMztvrNghQ76I25SvmLEmXScFUDt4+4c3tKt10EUKysc
 zJClD0tLSezGPIo3QPY33uFk/yG/6N0=
X-Proofpoint-ORIG-GUID: 5GPtXo2sj6DZ-m7_CfmS_eo5cdlG_F6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310104
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Add a method to reset the value of LSI Source-ID.
Mask off LSI source-id based on number of interrupts in the big/small PHB.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c         | 12 +++++++++---
 hw/pci-host/pnv_phb5.c         | 17 -----------------
 include/hw/pci-host/pnv_phb5.h | 10 ++++------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 5f84550a7c..362c9a039b 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -491,6 +491,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
 
     lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
     lsi_base <<= 3;
+    lsi_base &= (xsrc->nr_irqs - 1);
 
     /* TODO: handle reset values of PHB_LSI_SRC_ID */
     if (!lsi_base) {
@@ -1908,6 +1909,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
     /* TODO: Add more RO-masks as regs are implemented in the model */
 }
 
+static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
+{
+    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
+    pnv_phb4_update_xsrc(phb);
+}
+
 static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
 {
     STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
@@ -1964,10 +1971,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
     PnvPHB4 *phb = PNV_PHB4(obj);
 
     pnv_phb4_pbl_core_reset(phb);
+
+    pnv_phb4_xsrc_reset(phb);
     pnv_phb4_err_reg_reset(phb);
     pnv_phb4_pcie_stack_reg_reset(phb);
     pnv_phb4_regb_err_reg_reset(phb);
-    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
 }
 
 static void pnv_phb4_instance_init(Object *obj)
@@ -2041,8 +2049,6 @@ void pnv_phb4_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pnv_phb4_update_xsrc(phb);
-
     phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index b09351f69f..ec6dfbe2b2 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -6,24 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "qemu/bswap.h"
-#include "qapi/visitor.h"
-#include "qapi/error.h"
-#include "target/ppc/cpu.h"
-#include "hw/pci-host/pnv_phb4_regs.h"
-#include "hw/pci-host/pnv_phb4.h"
 #include "hw/pci-host/pnv_phb5.h"
-#include "hw/pci/pcie_host.h"
-#include "hw/pci/pcie_port.h"
-#include "hw/ppc/pnv.h"
-#include "hw/ppc/pnv_xscom.h"
-#include "hw/core/irq.h"
-#include "hw/core/qdev-properties.h"
-#include "qom/object.h"
-#include "trace.h"
-#include "system/reset.h"
 
 void pnv_phb5_cfg_core_reset(PCIDevice *d)
 {
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
index 4534083fd5..8f1df4892f 100644
--- a/include/hw/pci-host/pnv_phb5.h
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -9,12 +9,10 @@
 #ifndef PCI_HOST_PNV_PHB5_H
 #define PCI_HOST_PNV_PHB5_H
 
-#include "hw/pci-host/pnv_phb.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/ppc/pnv.h"
-#include "hw/ppc/pnv_nest_pervasive.h"
-#include "hw/ppc/xive.h"
-#include "qom/object.h"
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "hw/pci-host/pnv_phb4.h"
 
 void pnv_phb5_cfg_core_reset(PCIDevice *d);
 
-- 
2.52.0


