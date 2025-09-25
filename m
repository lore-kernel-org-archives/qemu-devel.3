Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72344CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ppb-0002Fw-3d; Thu, 25 Sep 2025 13:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pp9-00021B-Nm; Thu, 25 Sep 2025 13:32:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pow-0006FA-T2; Thu, 25 Sep 2025 13:32:06 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PGoBiE015979;
 Thu, 25 Sep 2025 17:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=AwERyV
 /VAcs9mGoS7dxzj2Sd7b6mCRTkz0oc9F6wtwc=; b=gA5cpEpo9fKn6Rx+maQatt
 uftmes90AZ1cLW2TGUv4/s+Mn+3aNv6EyONGcpQX3a+2En0Bqtr4xb24bhyC5js6
 meXw1PqdiCCxAV89tbgUU0at5SYzKRrr+ogegQCKf4RuhbizKaLNlIebjw/PNGMG
 q4iI81zIetjfpCOvinmJmu2bayxyx2WE7rXpZ1i6Kar0gNMzmrLJTrfgZ+662Pgt
 QvafXAmj0T2h1jAp1xCyLQkbSMEkPebwO6UYOAXuptfAKoTNhq+052QUgm7soufI
 dQmJD38lqkWQKiNHfqu5oNzhCMybnY73j14OzmWfxhtEqNBnStfSvJYoVYU3p2Zw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6fd3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:49 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHVnXG009449;
 Thu, 25 Sep 2025 17:31:49 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6fd36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHJlPF030359;
 Thu, 25 Sep 2025 17:31:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1ey5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:48 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHVjKs52167158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:31:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D2BB20043;
 Thu, 25 Sep 2025 17:31:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB14F20040;
 Thu, 25 Sep 2025 17:31:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:31:42 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Subject: [PATCH v10 6/8] ppc/pnv: Add ChipTOD model for Power11
Date: Thu, 25 Sep 2025 23:00:47 +0530
Message-ID: <20250925173049.891406-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4u-dt1SI9KN-4JvL38TL_aoAeWJHTKYq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX+9RUu5vxjYkW
 c6lsQc7jcDgrJdFKuwzG9WtgSMR0YFBH19DeBQrmADRdZgausMAyisoPIWex36XmHVQnDDbWf9M
 O5CS280RqYpKz3e/1mv9nHBZhfVYHre4zUieDMPsEb4TFQpjG3T+zxG4Q5lOlSZINqlfdbrUhHC
 NOIKPifXCD+cSVWtQLcWy35bLlJIt6DVo3ejIW+RbtppvnXMlwaJ71hGZ0UIyBzmPKtsvvM5u6n
 ScieMecCZolLvDUJ8jHDFMtHPqc8LnRGg4DycvNZyOMcHKXatMOA5IXxOK5Ghct+CwkunyvaWKE
 GJJr4YdDW3aqHcmROBduVBjQnUYQhcYwrFlwMTdFHj0JckO4UdAZuddLWTLsKslSUHNiKTIoSZG
 5KvfLaJk
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d57c86 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=2Cdvp3Fp0pe4zfQS8PQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WGfJddUjNYnS4w2LRQAq4Lc-Q7SnDy6X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Introduce Power11 ChipTod. The code has been copied from Power10 ChipTod
code as the Power11 core is same as Power10 core.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c                 | 15 +++++++++
 hw/ppc/pnv_chiptod.c         | 59 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 3 files changed, 76 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 2b4df6076c4c..f0469cdb8b65 100644
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
index b9e9c7ba3dbb..f887a18cde8d 100644
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
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index fde569bcbfa9..466b06560a28 100644
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
-- 
2.50.1


