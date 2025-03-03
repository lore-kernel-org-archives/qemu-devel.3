Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926EDC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp6Yx-0003Gd-8y; Mon, 03 Mar 2025 09:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YX-0003AF-KJ; Mon, 03 Mar 2025 09:14:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1tp6YS-0006UZ-Lf; Mon, 03 Mar 2025 09:14:05 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523CSJbC025066;
 Mon, 3 Mar 2025 14:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=v07bBNJ9TrU9C0HEF
 8xDDxs2sMbyK588DSTUhIsGFt8=; b=WF0A3yZHhUoh7JV07I8g6Hxk/NbfHKxND
 jxtny1MAiJXpryhXUVPwtfnLKLFdtl7D5OMP0SGHRxWHtCTSCM+xARqLhrEDdisN
 ZQdoEhoX+B0ejcUbDrdJousrj5VBawnwTpCX4Mnv86vD+TV0QzLf+TskSawUMq9x
 epiaJXTZlo3gBRqObuIN4vTvqVPqbirKdBYt7y7hJ4YdTarrw1r862XSSDWKnsdz
 /YmkoNGOs41mftoLusMIpaxjgh4CbEjsa6GLGNbfIyVV4/FLbEOXHAw2yKj4C7ty
 072l1Y+QLQj6XsYokcGLLqVP4I+vJ/QAC/IBItiGXJXxrHLfjoGBw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455cf2gh7d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 523EDoRW022782;
 Mon, 3 Mar 2025 14:13:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455cf2gh6w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 523D1nGI020928;
 Mon, 3 Mar 2025 14:13:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454esjqahr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Mar 2025 14:13:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 523EDjh619398942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Mar 2025 14:13:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7838D2004B;
 Mon,  3 Mar 2025 14:13:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45C8120043;
 Mon,  3 Mar 2025 14:13:43 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Mar 2025 14:13:43 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@linux.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@linux.vnet.ibm.com, milesg@linux.ibm.com, philmd@linaro.org,
 alistair@alistair23.me
Subject: [PATCH v6 3/4] hw/ssi/pnv_spi: Make bus names distinct for each
 controllers of a socket
Date: Mon,  3 Mar 2025 08:13:27 -0600
Message-Id: <20250303141328.23991-4-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
References: <20250303141328.23991-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6LZpHN2_KMwybgBKQj2GX-jumRDNAQQ-
X-Proofpoint-ORIG-GUID: Vy3Rwix8uUBGs-pN2oIET8cvfy_OKTFl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030107
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Create a spi buses with distinct names on each socket so that responders
are attached to correct SPI controllers.

Change the bus name to chipX.spi.<busnum> where X = 0..<num_sockets>

QOM tree on a 2 socket machine:
(qemu) info qom-tree
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /chip0.spi.0 (SSI)
      /xscom-spi[0] (memory-region)
  /chip[1] (power10_v2.0-pnv-chip)
    /pib_spic[0] (pnv-spi)
      /chip1.spi.0 (SSI)
      /xscom-spi[0] (memory-region)

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ssi/pnv_spi.h           | 3 ++-
 hw/ppc/pnv.c                       | 2 ++
 hw/ssi/pnv_spi.c                   | 5 +++--
 tests/qtest/pnv-spi-seeprom-test.c | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/ssi/pnv_spi.h b/include/hw/ssi/pnv_spi.h
index 9878d9a25f..6adb72dbb2 100644
--- a/include/hw/ssi/pnv_spi.h
+++ b/include/hw/ssi/pnv_spi.h
@@ -31,7 +31,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvSpi, PNV_SPI)
 #define PNV_SPI_REG_SIZE 8
 #define PNV_SPI_REGS 7
 
-#define TYPE_PNV_SPI_BUS "pnv-spi-bus"
+#define TYPE_PNV_SPI_BUS "spi"
 typedef struct PnvSpi {
     SysBusDevice parent_obj;
 
@@ -42,6 +42,7 @@ typedef struct PnvSpi {
     Fifo8 rx_fifo;
     /* SPI object number */
     uint32_t        spic_num;
+    uint32_t        chip_id;
     uint8_t         transfer_len;
     uint8_t         responder_select;
     /* To verify if shift_n1 happens prior to shift_n2 */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71..ce23892fdf 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2226,6 +2226,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
         /* pib_spic[2] connected to 25csm04 which implements 1 byte transfer */
         object_property_set_int(OBJECT(&chip10->pib_spic[i]), "transfer_len",
                                 (i == 2) ? 1 : 4, &error_fatal);
+        object_property_set_int(OBJECT(&chip10->pib_spic[i]), "chip-id",
+                                chip->chip_id, &error_fatal);
         if (!sysbus_realize(SYS_BUS_DEVICE(OBJECT
                                         (&chip10->pib_spic[i])), errp)) {
             return;
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index de33542c35..83221607c9 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -1147,14 +1147,15 @@ static const MemoryRegionOps pnv_spi_xscom_ops = {
 
 static const Property pnv_spi_properties[] = {
     DEFINE_PROP_UINT32("spic_num", PnvSpi, spic_num, 0),
+    DEFINE_PROP_UINT32("chip-id", PnvSpi, chip_id, 0),
     DEFINE_PROP_UINT8("transfer_len", PnvSpi, transfer_len, 4),
 };
 
 static void pnv_spi_realize(DeviceState *dev, Error **errp)
 {
     PnvSpi *s = PNV_SPI(dev);
-    g_autofree char *name = g_strdup_printf(TYPE_PNV_SPI_BUS ".%d",
-                    s->spic_num);
+    g_autofree char *name = g_strdup_printf("chip%d." TYPE_PNV_SPI_BUS ".%d",
+                    s->chip_id, s->spic_num);
     s->ssi_bus = ssi_create_bus(dev, name);
     s->cs_line = g_new0(qemu_irq, 1);
     qdev_init_gpio_out_named(DEVICE(s), s->cs_line, "cs", 1);
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 57f20af76e..600493c425 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -92,7 +92,7 @@ static void test_spi_seeprom(const void *data)
     qts = qtest_initf("-machine powernv10 -smp 2,cores=2,"
                       "threads=1 -accel tcg,thread=single -nographic "
                       "-blockdev node-name=pib_spic2,driver=file,"
-                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
+                      "filename=%s -device 25csm04,bus=chip0.spi.2,cs=0,"
                       "drive=pib_spic2", tmp_path);
     spi_seeprom_transaction(qts, chip);
     qtest_quit(qts);
-- 
2.39.5


