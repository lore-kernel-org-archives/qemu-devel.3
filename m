Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F27C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 20:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txtWc-0003lL-Hd; Thu, 27 Mar 2025 16:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txtWa-0003kW-Gj; Thu, 27 Mar 2025 16:08:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txtWX-0000lY-BB; Thu, 27 Mar 2025 16:08:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RE37cT008011;
 Thu, 27 Mar 2025 20:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qu8wDT
 XGvJJ7IMQZTMVsYLdl8rX9z12x2FBUvVJJMZc=; b=aJLHL5j2V9PdpArmq7bCO5
 qtqdpAaf26uFqLsSIM9KvXASeDKB0R4EMuQa8F/tCS2gDUDHY095yCZxdQreMQKK
 z5SRylhHgspoMRR+/PrKtI8bg/CQPHB0cD8/vIuUAnsWxnUawqxRNgf4zXwQLZ/E
 /jEaKa4wLebrhe68wjQor1cOlmfXVzXqZsQSo/Vl3r1jhvBii4kA8eC25s4QhFQX
 4GSRckBM7pTfTOXWD7tfrY+hMRsyLFhWRuVETnjIbfgRU1mKWFj/E8bjOkrrE4rP
 lywLS2VQpBB9+rnX6A934lDJOzh7I4LdYOO0PzA7t3VrosZhroCsvfrWQywKyP4A
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83pa2uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:08:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52RK7kuK016053;
 Thu, 27 Mar 2025 20:08:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n83pa2u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:08:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RJ7aX1025462;
 Thu, 27 Mar 2025 20:08:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0f6v8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 20:08:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52RK86ft56623382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 20:08:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B38F520043;
 Thu, 27 Mar 2025 20:08:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC8F220040;
 Thu, 27 Mar 2025 20:08:04 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.220])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Mar 2025 20:08:04 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: [PATCH v7 5/7] ppc/pnv: Add ChipTOD model for Power11
Date: Fri, 28 Mar 2025 01:37:36 +0530
Message-ID: <20250327200738.1524401-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250327200738.1524401-1-adityag@linux.ibm.com>
References: <20250327200738.1524401-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SJzr0ffVOy2xVpNsq2ktJ8qrILtV4Mwx
X-Proofpoint-ORIG-GUID: kiWmLgNjSE-7JtWk4-y7jVJ46q81YI4k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Introduce Power11 ChipTod. The code has been copied from Power10 ChipTod
code as the Power11 core is same as Power10 core.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/pnv.c                 | 15 +++++++++
 hw/ppc/pnv_chiptod.c         | 59 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 3 files changed, 76 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8b92ad11ae8e..d7da0e79063d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2395,6 +2395,8 @@ static void pnv_chip_power11_instance_init(Object *obj)
     object_initialize_child(obj, "xive", &chip11->xive, TYPE_PNV_XIVE2);
     object_property_add_alias(obj, "xive-fabric", OBJECT(&chip11->xive),
                               "xive-fabric");
+    object_initialize_child(obj, "chiptod", &chip11->chiptod,
+                            TYPE_PNV11_CHIPTOD);
     object_initialize_child(obj, "n1-chiplet", &chip11->n1_chiplet,
                             TYPE_PNV_N1_CHIPLET);
 
@@ -2545,6 +2547,19 @@ static void pnv_chip_power11_realize(DeviceState *dev, Error **errp)
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
index c8987ae67a2a..2e87ab62b2cf 100644
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
+static void pnv_chiptod_power11_class_init(ObjectClass *klass, void *data)
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
+    .interfaces    = (InterfaceInfo[]) {
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
2.49.0


