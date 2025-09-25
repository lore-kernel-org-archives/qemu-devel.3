Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF025CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ppv-0002a0-DH; Thu, 25 Sep 2025 13:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1pp9-000212-Cj; Thu, 25 Sep 2025 13:32:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v1poy-0006El-7e; Thu, 25 Sep 2025 13:32:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PECc4B027212;
 Thu, 25 Sep 2025 17:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rkjpL5
 PbRynVlS+yCX+tI808+fCqJWqcruwTkwOKpsg=; b=fEmBUmPbLHEQMbU0phaTLK
 CBCLa5wX0rBOTEcv6UqHrnFMFt9n9S1ddnS+CNYBhLVywGrglRPO/ErFNoD0xNcn
 3LDqTpGXlckb6j4xLAe2CKem0sr8IUzcJabGz9BQfdzdWh1Ag/966w4hrs7gFbOV
 FBNOR+A4bNUA9R53l4JFk4QRhjplu3wvONmukTcVFUNyKLNvfXolg0MzT9XFCWeo
 7xZCLe+vCOBTVIyPWLNgpHF4r9sdFhT7hj8XvGFWTGpLqiBtL05ja3/ONdO6u/Be
 FgUMdVjGDRSYomr7TQtr9HeobCZrn32H280eDIefEceIjKAu0xGSY3Fi9ldGPO3A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqprtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:47 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PHT9YY022306;
 Thu, 25 Sep 2025 17:31:46 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpqprtd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PGHRXD031150;
 Thu, 25 Sep 2025 17:31:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49b9vdg6w0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:31:45 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHVgS761342198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:31:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70C4520043;
 Thu, 25 Sep 2025 17:31:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D38D20040;
 Thu, 25 Sep 2025 17:31:40 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.220.124])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:31:39 +0000 (GMT)
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
Subject: [PATCH v10 5/8] ppc/pnv: Add PHB5 PCIe Host bridge to Power11
Date: Thu, 25 Sep 2025 23:00:46 +0530
Message-ID: <20250925173049.891406-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250925173049.891406-1-adityag@linux.ibm.com>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d57c83 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=460_-ORYMF3lY5BZaOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 00qetM8MV8I-4ivo_QFzdGCcXqRGsNOj
X-Proofpoint-GUID: qb-RGrDvrLUlX1yaCAD-EXTEJed73RuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX1UR72LpHAujD
 RY8dMyujmpK9UZIUrdIst1eeUpUY4D3+LobZDnYUBiJgrHX1uXlSgyLVlnU4NuCJsxHLsYSVggO
 E5i6ziFk6TcGUl2vK4NMoyxXTlibKxD7pZoKXvGJa7AN/THinjWaMCn2lH6Ep11nw05bPs8Hdzm
 jj5Q2rYNK7IhPJTCP7C+9JwfO3DcxnaXG8QtcuOm5I/ST2zuyEcd3dXToINpWV3+5byuTNLTQgY
 0okwtT6AIXJyr2ENMHgpfbdmkT+IXmHtkxgWlrx0zzK56BhnoimY5wfhfjlvQ9J9sMnUUsXENxP
 o7NANHhsgTU2Sym9GDyr1ouYR3owyBinhq6bK0wZePOmG6neZXbZ8zuktdmMO+9tMqoO8JQhnbn
 ToNTaKyG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8097d3c09a2f..2b4df6076c4c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -978,6 +978,8 @@ static void pnv_chip_power11_pic_print_info(PnvChip *chip, GString *buf)
 
     pnv_xive2_pic_print_info(&chip11->xive, buf);
     pnv_psi_pic_print_info(&chip11->psi, buf);
+    object_child_foreach_recursive(OBJECT(chip),
+                         pnv_chip_power9_pic_print_info_child, buf);
 }
 
 /* Always give the first 1GB to chip 0 else we won't boot */
@@ -2473,6 +2475,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
 
 static void pnv_chip_power11_instance_init(Object *obj)
 {
+    PnvChip *chip = PNV_CHIP(obj);
     Pnv11Chip *chip11 = PNV11_CHIP(obj);
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(obj);
     int i;
@@ -2495,6 +2498,13 @@ static void pnv_chip_power11_instance_init(Object *obj)
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
@@ -2527,6 +2537,38 @@ static void pnv_chip_power11_quad_realize(Pnv11Chip *chip11, Error **errp)
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
@@ -2664,7 +2706,12 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
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
@@ -2799,6 +2846,7 @@ static void pnv_chip_power11_class_init(ObjectClass *klass, const void *data)
     k->xscom_core_base = pnv_chip_power11_xscom_core_base;
     k->xscom_pcba = pnv_chip_power11_xscom_pcba;
     dc->desc = "PowerNV Chip Power11";
+    k->num_pecs = PNV10_CHIP_MAX_PEC;
     k->i2c_num_engines = PNV10_CHIP_MAX_I2C;
     k->i2c_ports_per_engine = i2c_ports_per_engine;
 
@@ -3365,6 +3413,13 @@ static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
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
2.50.1


