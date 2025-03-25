Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4637C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 11:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx2OK-0005Uj-Vr; Tue, 25 Mar 2025 07:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2OI-0005U7-LA; Tue, 25 Mar 2025 07:24:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tx2OH-0004Ds-0Z; Tue, 25 Mar 2025 07:24:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P9AdfA011984;
 Tue, 25 Mar 2025 11:24:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zkbfEG
 plTy9hm2mwam20Z1wTn1QdkftBk9UdVjzy5nE=; b=K6EQYlnY/zdWwEMzSsGF4w
 rUbGc+le2mbQdCWOo5Nq3fEGpxmH8PoPSgjBpwTOfkxkxRmlMMHlyfoAbAKGQ7pN
 IqOa32R4S6N5L9Wb185jj+lBPIr5vL1YIfq64tBI9soSIkX+TS/erE7EpULI+J+W
 BMhT9Q53C+vA/IBPCcH8EBNpb+u2ZdZJTuWw517EYxRt1EX7OmItGWd93rI6hQhC
 O4rNLqXsLN09SMZE1RaCDbTkAvUUVti1HZa7/gqKZMtPzmm2Mzo1m8crSf3bOtSC
 f8FeVkLaZWV85Hz1QuZRj7W2b5bKz8Dx0+weGOS2Q0WO/BYPmoqHj1sijw7DZz9Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpu8ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:24:14 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PBNLX8024223;
 Tue, 25 Mar 2025 11:24:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kejpu8ec-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:24:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P91ewu012240;
 Tue, 25 Mar 2025 11:24:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91m31k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Mar 2025 11:24:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52PBO9AK48890224
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 11:24:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5ED1020043;
 Tue, 25 Mar 2025 11:24:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BC1C20040;
 Tue, 25 Mar 2025 11:24:07 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.216.239])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Mar 2025 11:24:07 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v6 09/10] ppc/pnv: Add PHB5 PCIe Host bridge to Power11
Date: Tue, 25 Mar 2025 16:53:18 +0530
Message-ID: <20250325112319.927190-10-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325112319.927190-1-adityag@linux.ibm.com>
References: <20250325112319.927190-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xFIXAr-MLDAiIPRj936SKquDXsi4XfHH
X-Proofpoint-GUID: ZQYZ3JAIOjiUtiVbwL_pYhCWW9kAV1PY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=991 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250076
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Power11 also uses PHB5, same as Power10.

Add Power11 PHBs with similar code as the corresponding Power10 implementation.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ae2c1dcd4684..0b741fd4076f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -973,6 +973,8 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
 
     pnv_psi_pic_print_info(&chip11->psi, buf);
     pnv_xive2_pic_print_info(&chip11->xive, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
 }
 
 /* Always give the first 1GB to chip 0 else we won't boot */
@@ -2373,6 +2375,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 
 static void pnv_chip_power11_instance_init(Object *obj)
 {
+    PnvChip *chip = PNV_CHIP(obj);
     Pnv11Chip *chip11 = PNV11_CHIP(obj);
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
@@ -2389,6 +2392,13 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
+    chip->num_pecs = pcc->num_pecs;
+
+    for (i = 0; i < chip->num_pecs; i++) {
+        object_initialize_child(obj, "pec[*]", &chip11->pecs[i],
+                                TYPE_PNV_PHB5_PEC);
+    }
+
     for (i = 0; i < pcc->i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &chip11->i2c[i], TYPE_PNV_I2C);
     }
@@ -2421,6 +2431,38 @@ static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
     }
 }
 
+static void pnv_chip_power11_phb_realize(PnvChip *chip, Error **errp)
+{
+    Pnv11Chip *chip11 = PNV11_CHIP(chip);
+    int i;
+
+    for (i = 0; i < chip->num_pecs; i++) {
+        PnvPhb4PecState *pec = &chip11->pecs[i];
+        PnvPhb4PecClass *pecc = PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_cplt_base;
+        uint32_t pec_nest_base;
+        uint32_t pec_pci_base;
+
+        object_property_set_int(OBJECT(pec), "index", i, &error_fatal);
+        object_property_set_int(OBJECT(pec), "chip-id", chip->chip_id,
+                                &error_fatal);
+        object_property_set_link(OBJECT(pec), "chip", OBJECT(chip),
+                                 &error_fatal);
+        if (!qdev_realize(DEVICE(pec), NULL, errp)) {
+            return;
+        }
+
+        pec_cplt_base = pecc->xscom_cplt_base(pec);
+        pec_nest_base = pecc->xscom_nest_base(pec);
+        pec_pci_base = pecc->xscom_pci_base(pec);
+
+        pnv_xscom_add_subregion(chip, pec_cplt_base,
+                 &pec->nest_pervasive.xscom_ctrl_regs_mr);
+        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr);
+        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
+    }
+}
+
 static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(dev);
@@ -2550,7 +2592,12 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV11_XSCOM_N1_PB_SCOM_ES_BASE,
                            &chip11->n1_chiplet.xscom_pb_es_mr);
 
-    /* WIP: PHB added in future patch */
+    /* PHBs */
+    pnv_chip_power11_phb_realize(chip, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     /*
      * I2C
@@ -2684,6 +2731,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
     k->xscom_core_base = pnv_chip_power11_xscom_core_base;
     k->xscom_pcba = pnv_chip_power11_xscom_pcba;
     dc->desc = "PowerNV Chip Power11";
+    k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
     k->i2c_ports_per_engine = i2c_ports_per_engine;
 
@@ -3274,6 +3322,13 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
     XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
     static const char compat[] = "qemu,powernv11\0ibm,powernv";
 
+    static GlobalProperty phb_compat[] = {
+        { TYPE_PNV_PHB, "version", "5" },
+        { TYPE_PNV_PHB_ROOT_PORT, "version", "5" },
+    };
+
+    compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
+
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
-- 
2.49.0


