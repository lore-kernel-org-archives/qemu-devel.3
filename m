Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC53CAC5BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 19:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2x3D-0002iR-Lh; Sun, 28 Sep 2025 15:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x39-0002g1-Ox
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1v2x2u-00041N-S2
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 15:27:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SChOe0021061;
 Sun, 28 Sep 2025 19:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=7bYgwx
 rNH5Z80T4OAb1N/zsRTJZa/9qjcjLUZjjAgII=; b=J6m9t4UZn1uLPmqN0RMUWf
 De2fV1ZjDZGA/CPOtMWQ0BL/G0oWWnIc2i693FYQKydV8bZywAM4eeE998Fg/PN7
 KVCmpHqpXc+D6hQeEqrLxRRDOLiTdes4E5bC046d8HsMrTocRNQ+iJ+6tNqvM7Ex
 FhAFfOvBgrikjWa3sgRXw5nkt/WGIoONd4el0bZtxsqlpHmA/uqWvn+JHQ+JrC+E
 lQpUIta8K2a+nqAjFudCdP8CzFPhdMFHZ+JGN5ld69soppsxy/CstqzN48XlKD6V
 gSsxGTLnE4Uri1FlBUzQC2mXKcF/n09jxBsLx/cm6bHjz1rhULM47fc3adf/lGdw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh6q7b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:26:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SEwKdx024151;
 Sun, 28 Sep 2025 19:26:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49evy0thks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Sep 2025 19:26:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58SJQkYg35848558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Sep 2025 19:26:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3067920049;
 Sun, 28 Sep 2025 19:26:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1A6220040;
 Sun, 28 Sep 2025 19:26:44 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.39.17.115]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 28 Sep 2025 19:26:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 06/27] ppc/pnv: Add ChipTOD model for Power11
Date: Mon, 29 Sep 2025 00:56:08 +0530
Message-ID: <20250928192629.139822-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250928192629.139822-1-harshpb@linux.ibm.com>
References: <20250928192629.139822-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d98bfa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f7IdgyKtn90A:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=eKxLocFOgOs3f5weUJ0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfX9MtlhZ2tN8Q0
 x8pgUC4FxbdRQHPYkFJTdhbYn5Mb48mYrWQKAYQDPqpgxUq2LuKQ/s1E9w7GVxOujRgX53gJR2K
 bcEpaLl1s7Mhh2em1hhzNTMdEndVrr2ZFO0oCv4t2fh+ovsv/9aLwZljrbdhUvC1neL4bj5Q10g
 ZJBIc4nFMsXhakvQAqwPbH3wAQC5b+U+PmrPTALBrFgMk4fnFoBkP4KbPpQxNzmLpPWlb6c8iqK
 0Gn48mlUquyfQmyWuaqrGX8sUbjb5UJgAcSaFpdL4vUjsgwhcFOtYcdbi403fHy0OS3EwWtDoaA
 iHPBnkYG5wKnecp6r1NOmd2VH4V3JuRoDJdEf9SBxJEuW8rSgWfqKOFxfP0KGkWrP1w2+W5TsFl
 nisV0iAMVvwAEHh71nskx9ImqerUiA==
X-Proofpoint-GUID: Bl0jHkvuS9VAtjcOII8t7BH12tj-D3EJ
X-Proofpoint-ORIG-GUID: Bl0jHkvuS9VAtjcOII8t7BH12tj-D3EJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

Introduce Power11 ChipTod. The code has been copied from Power10 ChipTod
code as the Power11 core is same as Power10 core.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250925173049.891406-7-adityag@linux.ibm.com
Message-ID: <20250925173049.891406-7-adityag@linux.ibm.com>
---
 include/hw/ppc/pnv_chiptod.h |  2 ++
 hw/ppc/pnv.c                 | 15 +++++++++
 hw/ppc/pnv_chiptod.c         | 59 ++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index fde569bcbf..466b06560a 100644
--- a/include/hw/ppc/pnv_chiptod.h
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -17,6 +17,8 @@ OBJECT_DECLARE_TYPE(PnvChipTOD, PnvChipTODClass, PNV_CHIPTOD)
 DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV9_CHIPTOD, TYPE_PNV9_CHIPTOD)
 #define TYPE_PNV10_CHIPTOD TYPE_PNV_CHIPTOD "-POWER10"
 DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV10_CHIPTOD, TYPE_PNV10_CHIPTOD)
+#define TYPE_PNV11_CHIPTOD TYPE_PNV_CHIPTOD "-POWER11"
+DECLARE_INSTANCE_CHECKER(PnvChipTOD, PNV11_CHIPTOD, TYPE_PNV11_CHIPTOD)
 
 enum tod_state {
     tod_error = 0,
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2b4df6076c..f0469cdb8b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2495,6 +2495,8 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
                               "xive-fabric");
+    object_initialize_child(obj, "chiptod", &chip11->chiptod,
+                            TYPE_PNV11_CHIPTOD);
     object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
@@ -2653,6 +2655,19 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
     chip->dt_isa_nodename = g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc@0",
                                             (uint64_t) PNV11_LPCM_BASE(chip));
 
+    /* ChipTOD */
+    object_property_set_bool(OBJECT(&chip11->chiptod), "primary",
+                             chip->chip_id == 0, &error_abort);
+    object_property_set_bool(OBJECT(&chip11->chiptod), "secondary",
+                             chip->chip_id == 1, &error_abort);
+    object_property_set_link(OBJECT(&chip11->chiptod), "chip", OBJECT(chip),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&chip11->chiptod), NULL, errp)) {
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV11_XSCOM_CHIPTOD_BASE,
+                            &chip11->chiptod.xscom_regs);
+
     /* HOMER (must be created before OCC) */
     object_property_set_link(OBJECT(&chip11->homer), "chip", OBJECT(chip),
                              &error_abort);
diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index b9e9c7ba3d..f887a18cde 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -210,6 +210,22 @@ static void chiptod_power10_broadcast_ttype(PnvChipTOD *sender,
     }
 }
 
+static void chiptod_power11_broadcast_ttype(PnvChipTOD *sender,
+                                            uint32_t trigger)
+{
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv11Chip *chip11 = PNV11_CHIP(pnv->chips[i]);
+        PnvChipTOD *chiptod = &chip11->chiptod;
+
+        if (chiptod != sender) {
+            chiptod_receive_ttype(chiptod, trigger);
+        }
+    }
+}
+
 static PnvCore *pnv_chip_get_core_by_xscom_base(PnvChip *chip,
                                                 uint32_t xscom_base)
 {
@@ -283,6 +299,12 @@ static PnvCore *chiptod_power10_tx_ttype_target(PnvChipTOD *chiptod,
     }
 }
 
+static PnvCore *chiptod_power11_tx_ttype_target(PnvChipTOD *chiptod,
+                                               uint64_t val)
+{
+    return chiptod_power10_tx_ttype_target(chiptod, val);
+}
+
 static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
                                     uint64_t val, unsigned size)
 {
@@ -520,6 +542,42 @@ static const TypeInfo pnv_chiptod_power10_type_info = {
     }
 };
 
+static int pnv_chiptod_power11_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                             int xscom_offset)
+{
+    const char compat[] = "ibm,power-chiptod\0ibm,power11-chiptod";
+
+    return pnv_chiptod_dt_xscom(dev, fdt, xscom_offset, compat, sizeof(compat));
+}
+
+static void pnv_chiptod_power11_class_init(ObjectClass *klass, const void *data)
+{
+    PnvChipTODClass *pctc = PNV_CHIPTOD_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    dc->desc = "PowerNV ChipTOD Controller (Power11)";
+    device_class_set_props(dc, pnv_chiptod_properties);
+
+    xdc->dt_xscom = pnv_chiptod_power11_dt_xscom;
+
+    pctc->broadcast_ttype = chiptod_power11_broadcast_ttype;
+    pctc->tx_ttype_target = chiptod_power11_tx_ttype_target;
+
+    pctc->xscom_size = PNV_XSCOM_CHIPTOD_SIZE;
+}
+
+static const TypeInfo pnv_chiptod_power11_type_info = {
+    .name          = TYPE_PNV11_CHIPTOD,
+    .parent        = TYPE_PNV_CHIPTOD,
+    .instance_size = sizeof(PnvChipTOD),
+    .class_init    = pnv_chiptod_power11_class_init,
+    .interfaces    = (const InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
 static void pnv_chiptod_reset(void *dev)
 {
     PnvChipTOD *chiptod = PNV_CHIPTOD(dev);
@@ -579,6 +637,7 @@ static void pnv_chiptod_register_types(void)
     type_register_static(&pnv_chiptod_type_info);
     type_register_static(&pnv_chiptod_power9_type_info);
     type_register_static(&pnv_chiptod_power10_type_info);
+    type_register_static(&pnv_chiptod_power11_type_info);
 }
 
 type_init(pnv_chiptod_register_types);
-- 
2.43.5


