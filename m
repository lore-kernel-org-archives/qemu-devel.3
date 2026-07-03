Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E1FC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 04:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfVly-0002Dy-BL; Fri, 03 Jul 2026 00:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlp-0002Av-Rm
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wfVlU-00038F-5a
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 00:44:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6631ITOS1257927
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IqNdDMbfDZ7vqU8Hz
 maD3Pee5snLqI04XPZyd/tUlqw=; b=MFHUEow312iIcDL8VGEDj6PVhZ/1ZPh/W
 kRNKpdOurq8NipuUjO8A/hZiEqql9Nvc5SQPD1TqDagGrmdXuAMpICrERzym/ROe
 lyF7dvjMBOz9HdAxAQ1JI0FVXRDpcWrQcDvGpd0zvhtscfjibjHhTgZPygfGIuJk
 ou+FOgaiVmU7W9HJAcw6E7BZMWz5pYWPak6BVtmS93jm6lR6Vlvvq7w3J7WmN698
 WsLu0pLxKnURlwLoJ6sNcX7AyFbKYiYVya85BctvJ0CLiNu1SFyLxOUUYc0r67OT
 wSBHd3YIlyxUICKBjA+xcz0tukgEdqs7tMcOHFGHTWafjlwAzdfSw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n65de9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6634Ya2j021798
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 04:44:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqqdpm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 04:44:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6634iId918350522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 3 Jul 2026 04:44:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72FE920040;
 Fri,  3 Jul 2026 04:44:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E11A20043;
 Fri,  3 Jul 2026 04:44:17 +0000 (GMT)
Received: from Mac-11.lan (unknown [9.39.22.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  3 Jul 2026 04:44:16 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Jishnu Warrier <jishnuvw@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 3/7] hw/pci-host: Split PowerNV PHB5 code from PHB4 files
Date: Fri,  3 Jul 2026 10:13:58 +0530
Message-ID: <20260703044402.79723-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260703044402.79723-1-harshpb@linux.ibm.com>
References: <20260703044402.79723-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX/IIqY/N18bHy
 PKqv4Mpd2FpKbiqAtPvF4YlveIBk40bleONchzwlhtnCtCM6KMfAfwnk7bqh3TBZGwfftI5JOv6
 vvQJ6D5bgPSirMAmaUg8z3GsHHnsktj9NT7p50hLCDLSjjb3DLyHtx8P+vwcXutlIx0jAJ2zbMu
 m+pgub24svS2fMotN+zvPO5QvgPp+S4y+y05y5kDbrAeCmKNCoU0laagCFS70kVs2VP1GB0tDRy
 gWU7aR43sT0SDTqMnAaFDZnofxI53NdCwFCHmTVQc2Ly0C00BEU/eulKounoQWXvWU69qML7YNX
 Az0pPwpvIJ0lCNKVuf71kO/2xYbizfdSE5G3xYs7QR3WtIv7vlgBmt5EgEGsB6eSHdQ9ZWyUQOd
 mToVVoKOYAJH/PT97Y7TYmiIxG5HNoI1fVlEQ7dXEi8D9Zidv4U4WhFD9iIKO2DmXQNEDWWRouw
 CbG9UF67jm8PUbv49tg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a473e27 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ktw8pwExaukf0xcacNkA:9
X-Proofpoint-ORIG-GUID: -M0gvEJGV-T9lA53OAeseBuTgC-invqm
X-Proofpoint-GUID: -M0gvEJGV-T9lA53OAeseBuTgC-invqm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAzNyBTYWx0ZWRfX+q8lHdwsfxQM
 0IN4GsyHcYtlpoDQqU6SloQ4TwvVvp++JenjRVGDATMHkto22wJq0QsQGEYmksFyyfHWkGOuTop
 j8cHLy8mFEvL6dvUB5mHN8oOO0hPghI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030037
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Jishnu Warrier <jishnuvw@linux.ibm.com>

Separate Power10/11 PHB5 implementation from Power9 PHB4 code for
better maintainability and clarity. This is a pure code movement
with no functional changes.

Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260608093430.2729688-1-jishnuvw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c     |  6 ---
 hw/pci-host/pnv_phb4_pec.c | 58 ----------------------------
 hw/pci-host/pnv_phb5.c     | 23 ++++++++++++
 hw/pci-host/pnv_phb5_pec.c | 77 ++++++++++++++++++++++++++++++++++++++
 hw/pci-host/meson.build    |  2 +
 5 files changed, 102 insertions(+), 64 deletions(-)
 create mode 100644 hw/pci-host/pnv_phb5.c
 create mode 100644 hw/pci-host/pnv_phb5_pec.c

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
-- 
2.52.0


