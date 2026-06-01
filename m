Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD57CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5LZ-0007YW-1t; Mon, 01 Jun 2026 12:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wU5LR-0007XF-PJ; Mon, 01 Jun 2026 12:18:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wU5LP-0002Ot-KL; Mon, 01 Jun 2026 12:18:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651FmZit2337749; Mon, 1 Jun 2026 16:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=n5zzaT0gfooSGkYcsXOz9BLFa9jLzqbvKkPRUfRvE
 o0=; b=cum5XNLsNIao0xSo+ALQ/Ea/GrWnkMMLNwMzzHZ4sG0zfWmsv7kvEzGX0
 TeAIWNHgPecusMg6xg7qUsZK8xF7FRIb62K7b/+q+y8Sa+h07O3IfZG+aPS86zFM
 v8TS98nSfbHXk4VxqRY/DW/rbZ8jxF0BIRKwku2i56Zoqj9J9yIyN1KjwMq8emXD
 GvE/D2yVRr6aOvDhONipQ5p5RY/oX0f31tT0UabWvGCF3kDYUkWpyFaQtZe8FABD
 gxYWlG/V0AaxrNI535CLJFYBs6c7Hvwqzk/XLkjAf/gT+dwEPrzIi6ASVjhLAUXi
 e4q4o/iZ64rgICS1/+TvReuY8B0sQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae1f4v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 16:18:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651G97Zx000698;
 Mon, 1 Jun 2026 16:18:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegerm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 16:18:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651GIKgH34734510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 16:18:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C8BC20043;
 Mon,  1 Jun 2026 16:18:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 54C3F20040;
 Mon,  1 Jun 2026 16:18:17 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.39.22.2]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 16:18:17 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.ibm.com>,
 Jishnu Warrier <jishnuvw@linux.ibm.com>
Subject: [PATCH] hw/pci-host: Split PowerNV PHB5 code from PHB4 files
Date: Mon,  1 Jun 2026 21:48:02 +0530
Message-ID: <20260601161802.202512-1-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1db0d1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Ktw8pwExaukf0xcacNkA:9
X-Proofpoint-GUID: pqx9g2TLA95hhdapWnZh6QSX3YkAGCE3
X-Proofpoint-ORIG-GUID: Qdo_Fw7T0awqhFumvhDMuAhgKGpl4rWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2MCBTYWx0ZWRfXydo+Vf+N66fM
 eYV0zH1jvSRbAYcVwRWX1vqKBTmdWGgDnr6y3UVjj8IR9zr+8NXUeP/PfB6uzChVHTSyhJW/Cie
 eqMzNZAC4BXB/g2OSgWtzPaPORaQMUDU8mhMeFMrOrUNpzNcLAdVtERn/LTby1Ew3fMxw4Hcu3r
 ODli4u3CUwoHPmAm3sGW07Tx+gM4j+T1RMiNjJ+qpJLYTYMGDDPhTa7T/oBdBvq59dWa/q0ENYG
 8b+jkZQHA/yF3zMVFsSkLodcEUtmLt+yhwpVAgBoADBVJFWymB+LyJXlr2cCfKVc4PJq0Azimru
 V2qMQFMVoJD0LnqxeoxPEevfF2+tmHtoQh0+DGDyJm/l0+hJB+cZqCmlS6txItFNPLRMKvhxrLa
 sYxiknGfTEne7ISB/oKH6BCRbliBIJI1/j3O47+8dBs0TmOBFsiFuNiXg/e4gfz/yYdiKke/nO0
 +bMF+hdU5jYtSsp/nSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010160
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Separate Power10/11 PHB5 implementation from Power9 PHB4 code for
better maintainability and clarity. This is a pure code movement
with no functional changes.

Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
---
 hw/pci-host/meson.build    |  2 +
 hw/pci-host/pnv_phb4.c     |  6 ---
 hw/pci-host/pnv_phb4_pec.c | 58 -------------------------
 hw/pci-host/pnv_phb5.c     | 23 ++++++++++
 hw/pci-host/pnv_phb5_pec.c | 89 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 64 deletions(-)
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
index 0000000000..4b72539cec
--- /dev/null
+++ b/hw/pci-host/pnv_phb5.c
@@ -0,0 +1,23 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU PowerPC PowerNV (POWER10) PHB5 model
+ *
+ * Copyright (c) 2018-2026, IBM Corporation.
+ */
+#include "qemu/osdep.h"
+#include "hw/pci-host/pnv_phb4.h"
+#include "qom/object.h"
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
index 0000000000..d48bc09b8b
--- /dev/null
+++ b/hw/pci-host/pnv_phb5_pec.c
@@ -0,0 +1,89 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU PowerPC PowerNV (POWER10) PHB5 PEC model
+ *
+ * Copyright (c) 2018-2026, IBM Corporation.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "target/ppc/cpu.h"
+#include "hw/ppc/fdt.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_chip.h"
+#include "hw/core/qdev-properties.h"
+#include "system/system.h"
+
+#include <libfdt.h>
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


