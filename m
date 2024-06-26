Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78ACC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMObO-0005qq-5h; Wed, 26 Jun 2024 05:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObL-0005p6-H8; Wed, 26 Jun 2024 05:06:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObJ-0005uP-N7; Wed, 26 Jun 2024 05:06:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8wVG8000722;
 Wed, 26 Jun 2024 09:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 eAurzItmL5+L8srDa3gjAGXEIM0D6mLHa6VVHRt7UeU=; b=sAZlaDUkfcTqZbGD
 SSsRKoD+qtephp7zGW0i/+Z8oshpLrwP/z5tSzsvj532aXVv6fym2O0FFCwgFCmW
 sJUm4BDDRh5XDOQR7PH43MbyURDVGemK/l79T20+TLW1y8tSzIIMvC56xBuIMaYh
 jDQzrhStXa8Z4oU5p+AEUuayqQB1k/cf7JfVdxpcc0B57StdBa/FbKci9yNMRdf7
 lekCnUiTwrDjXwjnn+Ja6cxgUbGLfkdyunhAVaGv9uZanXlGbxbPK7sazpZcDZfT
 h8fVxj2ePVhsBLw7o6WVYJwDtjQ6yBBXFSj/bynx6fJ+2/V5n0t1+vvU7oeryVg2
 dMpx5w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fxr00gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:58 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q93XfE008585;
 Wed, 26 Jun 2024 09:05:58 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fxr00ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45Q6uGr3032606; Wed, 26 Jun 2024 09:05:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn3ax62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:05:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45Q95qMJ51642824
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 09:05:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B5D22004F;
 Wed, 26 Jun 2024 09:05:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F9CC20040;
 Wed, 26 Jun 2024 09:05:50 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2024 09:05:50 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v5 5/6] hw/ppc: SPI controller wiring to P10 chip
Date: Wed, 26 Jun 2024 04:05:27 -0500
Message-Id: <20240626090528.812-6-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JxdaC144-JRQAcPvtr_2if9Uf4n_8qAT
X-Proofpoint-GUID: zn7uhmk-oSaR1vc3XqzZx12ARzBFJrCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=776 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260067
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

The QOM tree of pnv-spi and seeprom are.
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[2] (pnv-spi)
      /pnv-spi-bus.2 (SSI)
      /xscom-spi[0] (memory-region)

/machine (powernv10-machine)
  /peripheral-anon (container)
    /device[0] (25csm04)
      /WP#[0] (irq)
      /ssi-gpio-cs[0] (irq)

(qemu) qom-get /machine/peripheral-anon /device[76] "parent_bus"
"/machine/chip[0]/pib_spic[2]/pnv-spi-bus.2"

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_chip.h |  3 +++
 hw/ppc/pnv.c              | 21 ++++++++++++++++++++-
 hw/ssi/pnv_spi.c          |  8 ++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 8589f3291e..a3376fa844 100644
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
+    PnvSpi pib_spic[PNV10_CHIP_MAX_PIB_SPIC];
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6e3a5ccdec..2ada4394e2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1829,6 +1829,11 @@ static void pnv_chip_power10_instance_init(Object *obj)
     for (i = 0; i < pcc->i2c_num_engines; i++) {
         object_initialize_child(obj, "i2c[*]", &chip10->i2c[i], TYPE_PNV_I2C);
     }
+
+    for (i = 0; i < PNV10_CHIP_MAX_PIB_SPIC; i++) {
+        object_initialize_child(obj, "pib_spic[*]", &chip10->pib_spic[i],
+                                TYPE_PNV_SPI);
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
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index f67c2a0ee2..ddfcac049e 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1050,9 +1050,17 @@ static void operation_sequencer(PnvSpi *s)
 static void do_reset(DeviceState *dev)
 {
     PnvSpi *s = PNV_SPI(dev);
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


