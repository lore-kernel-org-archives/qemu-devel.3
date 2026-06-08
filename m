Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC48CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWNg-0004lt-7j; Mon, 08 Jun 2026 05:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wWWNe-0004lH-Ux; Mon, 08 Jun 2026 05:34:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wWWNc-0003ld-Pe; Mon, 08 Jun 2026 05:34:50 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65891SEl2567161; Mon, 8 Jun 2026 09:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=KiJrUKXTM2NpjQx5AuWHT0ygGK+HHZKTH3trNOiwm
 UI=; b=iszj5uQK4bAzl+b51g+Xy84FxYEvpgydlln8hjdZupsx8MCXDuwgFDPv/
 uHI7d+fZ4w7a/PTt1iH7gUBmvH6ezSxCIv8Fj5Aul8TznsCJeNtUoMKaiYsvVvkp
 H9398ZZIb6E9TvtPvUWQe4wLOf70HBXJi8laZCY0qQeNrjtw69dJDPQ6Fr7KlCWW
 9ocrvh1TGu2jiUAW2bebxyGN8V9PxIMi70v971WzvWY5Za/mIlw/IS4FKiI7bnrH
 MEXrsPtSsUrq2aO68matO6bIz+S6GCeFdXPwix9EbRKv09/IZNiZ8w8MrB/ni+FF
 CquPbiI+U5msLjjTPLBI2KgKA/U1Q==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23pmf3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:34:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6589Ybv4014043;
 Mon, 8 Jun 2026 09:34:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjmpft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 09:34:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6589YdLM61342182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 09:34:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B7EA2004B;
 Mon,  8 Jun 2026 09:34:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F3FF20049;
 Mon,  8 Jun 2026 09:34:37 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.bl1-in.ibm.com (unknown
 [9.123.4.46]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 09:34:37 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>
Subject: [PATCH v2] hw/pci-host: Split PowerNV PHB5 code from PHB4 files
Date: Mon,  8 Jun 2026 15:04:30 +0530
Message-ID: <20260608093430.2729688-1-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a268cb5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Ktw8pwExaukf0xcacNkA:9
X-Proofpoint-ORIG-GUID: Yopw3uGHE9qVA7uacb0Nly389X9yY2kX
X-Proofpoint-GUID: LNsLW_dIbTXV99XrnzFBudf4bTMXz6SM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA4NCBTYWx0ZWRfX7KWsCFc46TQ9
 hIGWiDixH1zqDraQ1v2KYZfo/TRpBJ66Q9iOJWb0phFB85N4NAJr/TaqJkOoDPsn2C/LQO/19Ci
 QsDP1vvMsUmj27qL9vDoS5im/mS7SSbhAl2hkVZx3xah1y7+4vIF3+btdg6WVCETFe5q1fDywuJ
 Qf86sE5oAGOcT5jlU67fLmO/034roPIfDse1s2zHjdOmel8qSaAXJcP5BZFl49hl1+mY3B/T9eQ
 OyMZjlIhDKQXTyBN6+YInFX4rFel9kVZmqlsh9lvmb2phYku4FBRwfA9kALXdahJMz/rEyQfgSx
 jly1hVsmWNKDLKqbIoRdjtmo4i8wmNjzAsWXlUPiCPr7ql/i8hRhkWo4L6MsUyStysCr9qoB0P1
 fVohBmRvYMTbyKfYbynh4QbnXgm+PWQep3FeNuxNrKLZffa3pIynsJ6l5EoFW7PGNWv/HiXMctA
 rqjR8EXCEolS4hNqw5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080084
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Separate Power10/11 PHB5 implementation from Power9 PHB4 code for
better maintainability and clarity. This is a pure code movement
with no functional changes.

Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
---
 hw/pci-host/meson.build    |  2 +
 hw/pci-host/pnv_phb4.c     |  6 ---
 hw/pci-host/pnv_phb4_pec.c | 58 ----------------------------
 hw/pci-host/pnv_phb5.c     | 23 ++++++++++++
 hw/pci-host/pnv_phb5_pec.c | 77 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 64 deletions(-)
 create mode 100644 hw/pci-host/pnv_phb5.c
 create mode 100644 hw/pci-host/pnv_phb5_pec.c

diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 86b754d0b0..3217e7e912 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -44,5 +44,7 @@ specific_ss.add(when: 'CONFIG_PCI_POWERNV', if_true: files(
   'pnv_phb3_pbcq.c',
   'pnv_phb4.c',
   'pnv_phb4_pec.c',
+  'pnv_phb5.c',
+  'pnv_phb5_pec.c',
   'pnv_phb.c',
 ))
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 396bc47817..705a5bcf07 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1721,11 +1721,6 @@ static const TypeInfo pnv_phb4_type_info = {
     }
 };
 
-static const TypeInfo pnv_phb5_type_info = {
-    .name          = TYPE_PNV_PHB5,
-    .parent        = TYPE_PNV_PHB4,
-    .instance_size = sizeof(PnvPHB4),
-};
 
 static void pnv_phb4_root_bus_get_prop(Object *obj, Visitor *v,
                                        const char *name,
@@ -1794,7 +1789,6 @@ static void pnv_phb4_register_types(void)
 {
     type_register_static(&pnv_phb4_root_bus_info);
     type_register_static(&pnv_phb4_type_info);
-    type_register_static(&pnv_phb5_type_info);
     type_register_static(&pnv_phb4_iommu_memory_region_info);
 }
 
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 58ec14ec2f..ee5cdc3e45 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -394,67 +394,9 @@ static const TypeInfo pnv_pec_type_info = {
     }
 };
 
-/*
- * POWER10 definitions
- */
-static uint32_t pnv_phb5_pec_xscom_cplt_base(PnvPhb4PecState *pec)
-{
-    return PNV10_XSCOM_PEC_NEST_CPLT_BASE + XPEC_PCI_CPLT_OFFSET * pec->index;
-}
-
-static uint32_t pnv_phb5_pec_xscom_pci_base(PnvPhb4PecState *pec)
-{
-    return PNV10_XSCOM_PEC_PCI_BASE + 0x1000000 * pec->index;
-}
-
-static uint32_t pnv_phb5_pec_xscom_nest_base(PnvPhb4PecState *pec)
-{
-    /* index goes down ... */
-    return PNV10_XSCOM_PEC_NEST_BASE - 0x1000000 * pec->index;
-}
-
-/*
- * PEC0 -> 3 stacks
- * PEC1 -> 3 stacks
- */
-static const uint32_t pnv_phb5_pec_num_stacks[] = { 3, 3 };
-
-static void pnv_phb5_pec_class_init(ObjectClass *klass, const void *data)
-{
-    PnvPhb4PecClass *pecc = PNV_PHB4_PEC_CLASS(klass);
-    static const char compat[] = "ibm,power10-pbcq";
-    static const char stk_compat[] = "ibm,power10-phb-stack";
-
-    pecc->xscom_cplt_base = pnv_phb5_pec_xscom_cplt_base;
-    pecc->xscom_nest_base = pnv_phb5_pec_xscom_nest_base;
-    pecc->xscom_pci_base  = pnv_phb5_pec_xscom_pci_base;
-    pecc->xscom_nest_size = PNV10_XSCOM_PEC_NEST_SIZE;
-    pecc->xscom_pci_size  = PNV10_XSCOM_PEC_PCI_SIZE;
-    pecc->compat = compat;
-    pecc->compat_size = sizeof(compat);
-    pecc->stk_compat = stk_compat;
-    pecc->stk_compat_size = sizeof(stk_compat);
-    pecc->version = PNV_PHB5_VERSION;
-    pecc->phb_type = TYPE_PNV_PHB5;
-    pecc->num_phbs = pnv_phb5_pec_num_stacks;
-}
-
-static const TypeInfo pnv_phb5_pec_type_info = {
-    .name          = TYPE_PNV_PHB5_PEC,
-    .parent        = TYPE_PNV_PHB4_PEC,
-    .instance_size = sizeof(PnvPhb4PecState),
-    .class_init    = pnv_phb5_pec_class_init,
-    .class_size    = sizeof(PnvPhb4PecClass),
-    .interfaces    = (const InterfaceInfo[]) {
-        { TYPE_PNV_XSCOM_INTERFACE },
-        { }
-    }
-};
-
 static void pnv_pec_register_types(void)
 {
     type_register_static(&pnv_pec_type_info);
-    type_register_static(&pnv_phb5_pec_type_info);
 }
 
 type_init(pnv_pec_register_types);
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
new file mode 100644
index 0000000000..c3f2e16ce6
--- /dev/null
+++ b/hw/pci-host/pnv_phb5.c
@@ -0,0 +1,23 @@
+/*
+ * QEMU PowerPC PowerNV (POWER10) PHB5 model
+ *
+ * Copyright (c) 2018-2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci-host/pnv_phb4.h"
+
+static const TypeInfo pnv_phb5_type_info = {
+    .name          = TYPE_PNV_PHB5,
+    .parent        = TYPE_PNV_PHB4,
+    .instance_size = sizeof(PnvPHB4),
+};
+
+static void pnv_phb5_register_types(void)
+{
+    type_register_static(&pnv_phb5_type_info);
+}
+
+type_init(pnv_phb5_register_types);
diff --git a/hw/pci-host/pnv_phb5_pec.c b/hw/pci-host/pnv_phb5_pec.c
new file mode 100644
index 0000000000..488ccbfb12
--- /dev/null
+++ b/hw/pci-host/pnv_phb5_pec.c
@@ -0,0 +1,77 @@
+/*
+ * QEMU PowerPC PowerNV (POWER10) PHB5 PEC model
+ *
+ * Copyright (c) 2018-2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_xscom.h"
+
+#define XPEC_PCI_CPLT_OFFSET                        0x1000000ULL
+
+/*
+ * POWER10 definitions
+ */
+static uint32_t pnv_phb5_pec_xscom_cplt_base(PnvPhb4PecState *pec)
+{
+    return PNV10_XSCOM_PEC_NEST_CPLT_BASE + XPEC_PCI_CPLT_OFFSET * pec->index;
+}
+
+static uint32_t pnv_phb5_pec_xscom_pci_base(PnvPhb4PecState *pec)
+{
+    return PNV10_XSCOM_PEC_PCI_BASE + 0x1000000 * pec->index;
+}
+
+static uint32_t pnv_phb5_pec_xscom_nest_base(PnvPhb4PecState *pec)
+{
+    /* index goes down ... */
+    return PNV10_XSCOM_PEC_NEST_BASE - 0x1000000 * pec->index;
+}
+
+/*
+ * PEC0 -> 3 stacks
+ * PEC1 -> 3 stacks
+ */
+static const uint32_t pnv_phb5_pec_num_stacks[] = { 3, 3 };
+
+static void pnv_phb5_pec_class_init(ObjectClass *klass, const void *data)
+{
+    PnvPhb4PecClass *pecc = PNV_PHB4_PEC_CLASS(klass);
+    static const char compat[] = "ibm,power10-pbcq";
+    static const char stk_compat[] = "ibm,power10-phb-stack";
+
+    pecc->xscom_cplt_base = pnv_phb5_pec_xscom_cplt_base;
+    pecc->xscom_nest_base = pnv_phb5_pec_xscom_nest_base;
+    pecc->xscom_pci_base  = pnv_phb5_pec_xscom_pci_base;
+    pecc->xscom_nest_size = PNV10_XSCOM_PEC_NEST_SIZE;
+    pecc->xscom_pci_size  = PNV10_XSCOM_PEC_PCI_SIZE;
+    pecc->compat = compat;
+    pecc->compat_size = sizeof(compat);
+    pecc->stk_compat = stk_compat;
+    pecc->stk_compat_size = sizeof(stk_compat);
+    pecc->version = PNV_PHB5_VERSION;
+    pecc->phb_type = TYPE_PNV_PHB5;
+    pecc->num_phbs = pnv_phb5_pec_num_stacks;
+}
+
+static const TypeInfo pnv_phb5_pec_type_info = {
+    .name          = TYPE_PNV_PHB5_PEC,
+    .parent        = TYPE_PNV_PHB4_PEC,
+    .instance_size = sizeof(PnvPhb4PecState),
+    .class_init    = pnv_phb5_pec_class_init,
+    .class_size    = sizeof(PnvPhb4PecClass),
+    .interfaces    = (const InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_phb5_pec_register_types(void)
+{
+    type_register_static(&pnv_phb5_pec_type_info);
+}
+
+type_init(pnv_phb5_pec_register_types);
-- 
2.53.0


