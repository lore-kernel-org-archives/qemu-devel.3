Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00161C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 16:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXkU5-0003eg-Lr; Wed, 07 Feb 2024 11:09:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkU3-0003e8-5q; Wed, 07 Feb 2024 11:09:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rXkU1-0000lT-Ju; Wed, 07 Feb 2024 11:09:10 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 417G3iu4026864; Wed, 7 Feb 2024 16:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DqbFhz0Hvsq5FHd4UbswTshlP/Zzie3wFaViPm2OLf0=;
 b=sq+r6msvz5XO957rFMvIZlJmwOBGZR6w0WcbJK36/vKUKwImdBjGDcwtH3fP/WHORR7p
 jzlugYSNgAn+gJkq09iWZObjk5++BX5asg0LK934w3a95sBqXYdOOFe8r4h0naBkKjFn
 yHsJfXiMb9K7Su91cFaSZFeqOGD7FDQsYrP5AxGjW8qjM+oCd5Ue0fSY2uvA3QoZ+MNR
 +CM53yl9PidxnUiPUASQ8o/IWDcPMgkrqIKSigmClCes35GLposP9Ebu2xvjEJd7VkjU
 pHA+ZlFlX5b86WKlKoH6qGf9aI9nzeccyOJGwRIIMuJqVXHJIUtq1Z4RC++cs0XmqD2R 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4d22g5r8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:09:06 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 417G6p2Y007233;
 Wed, 7 Feb 2024 16:09:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4d22g5qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:09:06 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 417DukBd014865; Wed, 7 Feb 2024 16:09:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w20tnxqkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Feb 2024 16:09:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 417G92go45089240
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Feb 2024 16:09:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91E3620043;
 Wed,  7 Feb 2024 16:09:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E672020040;
 Wed,  7 Feb 2024 16:09:00 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Feb 2024 16:09:00 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v1 5/5] hw/ppc: SPI controller wiring to P10 chip and create
 seeprom device
Date: Wed,  7 Feb 2024 10:08:33 -0600
Message-Id: <20240207160833.3437779-6-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
References: <20240207160833.3437779-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _lel2OhS-T7y9780jf3vQ_nfE_kjEjZc
X-Proofpoint-ORIG-GUID: Lpwku8SpCd3-HJAaiGnk0fGZaXh5rgxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_06,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=779 mlxscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit creates SPI controller to p10 chip and create the keystore seeprom
device on spi_bus2 of PIB_SPIC[2].

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_chip.h |  4 ++++
 hw/ppc/pnv.c              | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 0ab5c42308..0d67516ede 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -4,6 +4,8 @@
 #include "hw/pci-host/pnv_phb4.h"
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
+#include "hw/ppc/pnv_spi_controller.h"
+#include "hw/ppc/pnv_spi_seeprom.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -113,6 +115,8 @@ struct Pnv10Chip {
     PnvOCC       occ;
     PnvSBE       sbe;
     PnvHomer     homer;
+#define PNV10_CHIP_MAX_PIB_SPIC 6
+    PnvSpiController pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..8fffd999f6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1691,6 +1691,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
     for (i = 0; i < pcc->i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
     }
+
+    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC ; i++) {
+        object_initialize_child(obj, "pib_spic[*]", &chip10->pib_spic[i],
+                                TYPE_PNV_SPI_CONTROLLER);
+    }
 }
 
 static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
@@ -1879,6 +1884,33 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
+
+    /* PIB SPI Controller */
+    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "spic_num",
+                                i , &error_fatal);
+        /*
+         * The TPM attached SPIC needs to reverse the bit order in each byte
+         * it sends to the TPM.
+         */
+        if (i == 4) {
+            object_property_set_bool(OBJECT(&chip10->pib_spic[i]),
+                    "reverse_bits", true, &error_fatal);
+        }
+        if (!qdev_realize(DEVICE(&chip10->pib_spic[i]), NULL, errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
+                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
+                                &chip10->pib_spic[i].xscom_spic_regs);
+    }
+
+    /* Primary MEAS/MVPD/Keystore SEEPROM connected to pib_spic[2]*/
+    PnvSpiSeeprom *meas_mvpd_ks_p = PNV_SPI_SEEPROM(spi_create_responder(
+                            (&chip10->pib_spic[2])->spi_bus,
+                            TYPE_PNV_SPI_SEEPROM));
+    meas_mvpd_ks_p->file = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                    "sbe_measurement_seeprom.bin.ecc");
 }
 
 static uint32_t pnv_chip_power10_xscom_pcba(PnvChip *chip, uint64_t addr)
-- 
2.31.1


