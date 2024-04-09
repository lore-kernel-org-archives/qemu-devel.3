Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DF8CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 18:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFmu-0003DD-UV; Tue, 09 Apr 2024 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1ruFmp-00037U-Qk; Tue, 09 Apr 2024 14:01:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1ruFmn-0005RL-DU; Tue, 09 Apr 2024 14:01:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 439HhsNO018465; Tue, 9 Apr 2024 18:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=80rWkJvWKXvsZYiRvacBaqIQd/D5rUzbHIt4I2KHueY=;
 b=q5NMonS0ZE4CORsjNxVuiZKa0Nilq6EQbO6mwSO57mvX+jPg3uTexpYDv/4iFQNgQKvc
 iChkz+vsoBke61nl6tW+4SP/g19emzhs0lbTbNlu3dnq+jMjbG4UXFJqK26HJHBuDxFM
 vVXlgnGrbDe1hE5AzEBciZqehBdxDl8QSsGT3QQJFA2ROrJ631gU50c8cSXJJh743ivp
 6AR4Bae9cDvGsVBPLgc79gYnRXUX8lS59o+u4CDAOk2B803cRRbjyX+Q4Cxggm2aIL4q
 LcHjHib/6nvuixK9OcsjvLjQ36tN4Vq0cvQtwE4KGfBeMvTp0HyrtS4MB/P2ait80DbA /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xda5yr1ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 18:01:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439I1OBX011627;
 Tue, 9 Apr 2024 18:01:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xda5yr1r1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 18:01:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 439HjHLe022560; Tue, 9 Apr 2024 17:57:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqnyuax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:57:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 439HvSB251380732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2024 17:57:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 123402004E;
 Tue,  9 Apr 2024 17:57:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 572B02004B;
 Tue,  9 Apr 2024 17:57:26 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2024 17:57:26 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
Subject: [PATCH v2 5/6] hw/ppc: SPI controller wiring to P10 chip and create
 seeprom device
Date: Tue,  9 Apr 2024 12:56:59 -0500
Message-Id: <20240409175700.27535-6-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
References: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bo5o6NOQGFUcc1UsJp0gtkZTzHKy0_M6
X-Proofpoint-ORIG-GUID: hmy43hXcOpTjEnQnxmJsLuPBMXMzgfvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090118
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

In this commit
Creates SPI controller on p10 chip.
Create the keystore seeprom of type "seeprom-25csm04"
Connect the cs of seeprom to PIB_SPIC[2] cs irq.

The QOM tree of spi controller and seeprom are.
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[2] (pnv-spi-controller)
      /bus (pnv-spi-bus)
        /pnv-spi-bus.2 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)

/machine (powernv10-machine)
  /unattached (container)
    /device[7] (seeprom-25csm04)
      /ssi-gpio-cs[0] (irq)

(qemu) qom-get /machine/unattached/device[7] "parent_bus"
"/machine/chip[0]/pib_spic[2]/bus/pnv-spi-bus.2"

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_chip.h |  3 +++
 hw/ppc/pnv.c              | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291e..3edf13e8f9 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -6,6 +6,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ppc/pnv_spi_controller.h"
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_psi.h"
@@ -118,6 +119,8 @@ struct Pnv10Chip {
     PnvSBE       sbe;
     PnvHomer     homer;
     PnvN1Chiplet     n1_chiplet;
+#define PNV10_CHIP_MAX_PIB_SPIC 6
+    PnvSpiController pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..eeb2d650bd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -46,6 +46,7 @@
 #include "hw/pci-host/pnv_phb.h"
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/ssi/ssi.h"
 
 #include "hw/ppc/xics.h"
 #include "hw/qdev-properties.h"
@@ -1829,6 +1830,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
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
@@ -2043,7 +2049,35 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
-
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
+    /* Primary MEAS/MVPD/Keystore SEEPROM connected to pib_spic[2] */
+    DeviceState *seeprom = qdev_new("seeprom-25csm04");
+    qdev_prop_set_string(seeprom, "filename",
+                         "sbe_measurement_seeprom.bin.ecc");
+    ssi_realize_and_unref(seeprom, ((&chip10->pib_spic[2])->bus).ssi_bus,
+                          &error_fatal);
+    qemu_irq seeprom_cs = qdev_get_gpio_in_named(seeprom, SSI_GPIO_CS, 0);
+    Object *bus = OBJECT(&(&chip10->pib_spic[2])->bus);
+    sysbus_connect_irq(SYS_BUS_DEVICE(bus), 0, seeprom_cs);
 }
 
 static void pnv_rainier_i2c_init(PnvMachineState *pnv)
-- 
2.39.3


