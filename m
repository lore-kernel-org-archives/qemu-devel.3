Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479D8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7If4-0001OX-57; Wed, 15 May 2024 13:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7IeI-00013s-Ov; Wed, 15 May 2024 13:42:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7IeE-0006aU-9S; Wed, 15 May 2024 13:42:40 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FGHua0019147; Wed, 15 May 2024 17:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9JpHgyAWqR1K/1zTMIvfKMjnTXujnXR48Y1/i2DU7PM=;
 b=e0ZNFl4+kkfE0VAjYQR11Qk1hS3r9gs0KYYB7dSJ6YxQYf/q4XTADsCgYRagEEWJvvt9
 F2yR3pr0b+9VRr3bM35UyzOoZD8+3HurQZ3A6NMzyb0Ef5+7Pjr1AkNiIi413olJW0Vr
 8MoMaIJvcSlneKN9spzRogDjk/zwNKP7yX1ylj6+VTZLP4kRMs0Il97YBm9e6jsqDZ20
 MwviSkbQsbom/a1dPSLGHgF6d9BPD3Kq4pPdh+1hA6o84H3PGKX1x0+Qwuo+POjX8DY2
 11+C7Z8UTiW77L0/kouyrjHWE1v5685QgbNGXmtVaRfGGTWSQQAP2v1KBZ/fZWVovKKy vA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4y29rej9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:27 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FHgQwU019191;
 Wed, 15 May 2024 17:42:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4y29rej8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:26 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FF2IDC006183; Wed, 15 May 2024 17:42:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmmw04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44FHgKON30147188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 17:42:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE872004B;
 Wed, 15 May 2024 17:42:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 776C320043;
 Wed, 15 May 2024 17:42:18 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 17:42:18 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
Subject: [PATCH v3 4/5] hw/ppc: SPI controller wiring to P10 chip
Date: Wed, 15 May 2024 12:41:48 -0500
Message-Id: <20240515174149.17713-5-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LSVk2wWVaXNYga3QCqVSXnmRWnCX8eCQ
X-Proofpoint-GUID: tr2dOtYwDX5omusT-wvcszu2dMdQl5eC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=736 spamscore=0
 mlxscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150125
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

In this commit, create SPI controller on p10 chip and connect cs irq.

The QOM tree of spi controller and seeprom are.
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[2] (pnv-spi-controller)
      /pnv-spi-bus.2 (SSI)
      /xscom-spi-controller-regs[0] (memory-region)

/machine (powernv10-machine)
  /peripheral-anon (container)
    /device[0] (25csm04)
      /WP#[0] (irq)
      /ssi-gpio-cs[0] (irq)

(qemu) qom-get /machine/peripheral-anon /device[76] "parent_bus"
"/machine/chip[0]/pib_spic[2]/pnv-spi-bus.2"

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_chip.h   |  3 +++
 hw/ppc/pnv.c                | 21 ++++++++++++++++++++-
 hw/ppc/pnv_spi_controller.c |  8 ++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291e..d464858f79 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -6,6 +6,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_n1_chiplet.h"
+#include "hw/ssi/pnv_spi.h"
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
index 6e3a5ccdec..6850592a85 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1829,6 +1829,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
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
@@ -2043,7 +2048,21 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&chip10->psi),
                                                PSIHB9_IRQ_SBE_I2C));
     }
-
+    /* PIB SPI Controller */
+    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "spic_num",
+                                i, &error_fatal);
+        /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
+                                (i == 2) ? 1 : 4, &error_fatal);
+        if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
+                                        (&chip10->pib_spic[i])), errp)) {
+            return;
+        }
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_PIB_SPIC_BASE +
+                                i * PNV10_XSCOM_PIB_SPIC_SIZE,
+                                &chip10->pib_spic[i].xscom_spic_regs);
+    }
 }
 
 static void pnv_rainier_i2c_init(PnvMachineState *pnv)
diff --git a/hw/ppc/pnv_spi_controller.c b/hw/ppc/pnv_spi_controller.c
index e87f583074..3d47e932de 100644
--- a/hw/ppc/pnv_spi_controller.c
+++ b/hw/ppc/pnv_spi_controller.c
@@ -1067,9 +1067,17 @@ static void operation_sequencer(PnvSpiController *s)
 static void do_reset(DeviceState *dev)
 {
     PnvSpiController *s = PNV_SPICONTROLLER(dev);
+    DeviceState *ssi_dev;
 
     trace_pnv_spi_reset();
 
+    /* Connect cs irq */
+    ssi_dev = ssi_get_cs(s->ssi_bus, 0);
+    if (ssi_dev) {
+        qemu_irq cs_line = qdev_get_gpio_in_named(ssi_dev, SSI_GPIO_CS, 0);
+        qdev_connect_gpio_out_named(DEVICE(s), "cs", 0, cs_line);
+    }
+
     /* Reset all N1 and N2 counters, and other constants */
     s->N2_bits = 0;
     s->N2_bytes = 0;
-- 
2.39.3


