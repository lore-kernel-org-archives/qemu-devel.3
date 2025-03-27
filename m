Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045C4C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 20:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txtWT-0003fC-G7; Thu, 27 Mar 2025 16:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txtWR-0003cw-9v; Thu, 27 Mar 2025 16:08:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txtWP-0000jV-34; Thu, 27 Mar 2025 16:08:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RIdBU4011588;
 Thu, 27 Mar 2025 20:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Gnluow
 r9KjNUQBcT4bjS8RyCTboETNXEHB1+h5M9vvs=; b=c7o+r9Grugb+e9sMBGOsgZ
 xXsfAP15TypWZswBgZT+MLhTgp4VpJPkbyM2wsQnISxcDnOVc7cc1vbbJ7NKTuf1
 Z9hx3KYylM6EDvrzfJioq+bEvc5kYMTqq37IWmiIjQLXUJzQXimM92atyEXMRQe/
 YEH5Ia6VClGFzJxClKePEEBQdZhpDECnWtOm0H1m2uIbSU8KseDEKZpkKmuKOITc
 Kntzqn7Ao8MsnCw1AsR8aHRUdi1uMwAWc3exlsQ1XDRbTxsOk1QeK+JaYGKJbhQq
 JgSehMJGawZlKFWzB4iPg4A9sGfCx6kR5tD30jX6bZbZsklgSsbP9FZ/+hPQHlQQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrt067dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:08:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52RK6nLd015372;
 Thu, 27 Mar 2025 20:08:08 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrt067dp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:08:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RH43KR005801;
 Thu, 27 Mar 2025 20:08:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82psfw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:08:07 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52RK84Ax58786050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 20:08:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6913C20040;
 Thu, 27 Mar 2025 20:08:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 117C12004B;
 Thu, 27 Mar 2025 20:08:02 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.220])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Mar 2025 20:08:01 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v7 4/7] ppc/pnv: Add PHB5 PCIe Host bridge to Power11
Date: Fri, 28 Mar 2025 01:37:35 +0530
Message-ID: <20250327200738.1524401-5-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250327200738.1524401-1-adityag@linux.ibm.com>
References: <20250327200738.1524401-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PSL2ZvmpiTqeqvFl2GhfX_q2NRez92Ry
X-Proofpoint-GUID: Z5e-QN5xK9nx_4eCuvrads9Cv-3edt4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Power11 also uses PHB5, same as Power10.

Add Power11 PHBs with similar code as the corresponding Power10 implementation.

Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 982decc11386..8b92ad11ae8e 100644
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
@@ -2395,6 +2398,13 @@ static void pnv_chip_power11_instance_init(Object *obj)
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
@@ -2427,6 +2437,38 @@ static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
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
@@ -2556,7 +2598,12 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
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
@@ -2690,6 +2737,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, void *data)
     k->xscom_core_base = pnv_chip_power11_xscom_core_base;
     k->xscom_pcba = pnv_chip_power11_xscom_pcba;
     dc->desc = "PowerNV Chip Power11";
+    k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
     k->i2c_ports_per_engine = i2c_ports_per_engine;
 
@@ -3280,6 +3328,13 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, void *data)
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


