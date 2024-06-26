Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC6CC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 09:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMObT-0005uf-DA; Wed, 26 Jun 2024 05:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObR-0005sa-5E; Wed, 26 Jun 2024 05:06:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1sMObP-0005wW-5w; Wed, 26 Jun 2024 05:06:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45Q8wT17023387;
 Wed, 26 Jun 2024 09:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 IKGngWxi40Sd7pPfA7JgaTe9FzA8cq5+o+LuU+2iM2k=; b=JJcqyaGwNYexMAm9
 75Y5f5oRh0+6XSK9SXJ8vEO/F9cjCCk3hek63WtFQzWMd0gdp5ORVdVqyPj8ZD55
 q1V9R1/rk5Os+L9MxW2MNL6IBcXRCJcueZS4N80PQAY8Kbzer/Wp/9qjj28uQys0
 djLulkcwLKKUXwgu1+Y5cURtWdhVfTKz+CxybHHZfGxDR/C/YnZxRM7QZKINGtC+
 Cuxu9+vAnUN0Mo3qkmSQltM+MBhQ2wUD0lqx696Dg85IY/2trSnuBnhKnZdzxD1o
 zINZYTNmJIzrSxO1gDq5+bdNlBBNjSX7+IYlqVAzhrozdUDdLO1i6qES1SSLRJW9
 CxrOJw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fx9g0kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:06:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45Q962VL003415;
 Wed, 26 Jun 2024 09:06:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400fx9g0kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:06:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45Q90kGl019625; Wed, 26 Jun 2024 09:06:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xq3bj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 09:06:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45Q95tSZ34079354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2024 09:05:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D45C220040;
 Wed, 26 Jun 2024 09:05:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 046DD20043;
 Wed, 26 Jun 2024 09:05:54 +0000 (GMT)
Received: from gfwr527.rchland.ibm.com (unknown [9.10.239.127])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2024 09:05:53 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
Subject: [PATCH v5 6/6] tests/qtest: Add pnv-spi-seeprom qtest
Date: Wed, 26 Jun 2024 04:05:28 -0500
Message-Id: <20240626090528.812-7-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KKui9KH5cxm8m-9Qg7f9PzZv-S03P2GW
X-Proofpoint-ORIG-GUID: W9T_8480Sw61prWTq7pauzvLZ7hO6EII
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_03,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=531 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

In this commit Write a qtest pnv-spi-seeprom-test to check the
SPI transactions between spi controller and seeprom device.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Acked-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 110 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   1 +
 2 files changed, 111 insertions(+)
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
new file mode 100644
index 0000000000..92bc8a11ae
--- /dev/null
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -0,0 +1,110 @@
+/*
+ * QTest testcase for PowerNV 10 Seeprom Communications
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <unistd.h>
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bswap.h"
+#include "hw/ssi/pnv_spi_regs.h"
+#include "pnv-xscom.h"
+
+#define FLASH_SIZE              (512 * 1024)
+#define SPIC2_XSCOM_BASE        0xc0040
+
+/* To transmit READ opcode and address */
+#define READ_OP_TDR_DATA        0x0300010000000000
+/*
+ * N1 shift - tx 4 bytes (transmit opcode and address)
+ * N2 shift - tx and rx 8 bytes.
+ */
+#define READ_OP_COUNTER_CONFIG  0x2040000000002b00
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - N2 Shift * 5 - SEQ_OP_STOP */
+#define READ_OP_SEQUENCER       0x1130404040404010
+
+/* To transmit WREN(Set Write Enable Latch in status0 register) opcode */
+#define WRITE_OP_WREN           0x0600000000000000
+/* To transmit WRITE opcode, address and data */
+#define WRITE_OP_TDR_DATA       0x0300010012345678
+/* N1 shift - tx 8 bytes (transmit opcode, address and data) */
+#define WRITE_OP_COUNTER_CONFIG 0x4000000000002000
+/* SEQ_OP_SELECT_RESPONDER - N1 Shift - SEQ_OP_STOP */
+#define WRITE_OP_SEQUENCER      0x1130100000000000
+
+static void pnv_spi_xscom_write(QTestState *qts, const PnvChip *chip,
+        uint32_t reg, uint64_t val)
+{
+    uint32_t pcba = SPIC2_XSCOM_BASE + reg;
+    qtest_writeq(qts, pnv_xscom_addr(chip, pcba), val);
+}
+
+static uint64_t pnv_spi_xscom_read(QTestState *qts, const PnvChip *chip,
+        uint32_t reg)
+{
+    uint32_t pcba = SPIC2_XSCOM_BASE + reg;
+    return qtest_readq(qts, pnv_xscom_addr(chip, pcba));
+}
+
+static void spi_seeprom_transaction(QTestState *qts, const PnvChip *chip)
+{
+    /* SPI transactions to SEEPROM to read from SEEPROM image */
+    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, READ_OP_COUNTER_CONFIG);
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, READ_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, READ_OP_TDR_DATA);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, 0);
+    /* Read 5*8 bytes from SEEPROM at 0x100 */
+    uint64_t rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    g_test_message("RDR READ = 0x%lx", rdr_val);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    rdr_val = pnv_spi_xscom_read(qts, chip, SPI_RCV_DATA_REG);
+    g_test_message("RDR READ = 0x%lx", rdr_val);
+
+    /* SPI transactions to SEEPROM to write to SEEPROM image */
+    pnv_spi_xscom_write(qts, chip, SPI_CTR_CFG_REG, WRITE_OP_COUNTER_CONFIG);
+    /* Set Write Enable Latch bit of status0 register */
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_WREN);
+    /* write 8 bytes to SEEPROM at 0x100 */
+    pnv_spi_xscom_write(qts, chip, SPI_SEQ_OP_REG, WRITE_OP_SEQUENCER);
+    pnv_spi_xscom_write(qts, chip, SPI_XMIT_DATA_REG, WRITE_OP_TDR_DATA);
+}
+
+static void test_spi_seeprom(const void *data)
+{
+    const PnvChip *chip = data;
+    QTestState *qts = NULL;
+    g_autofree char *tmp_path = NULL;
+    int ret;
+    int fd;
+
+    /* Create a temporary raw image */
+    fd = g_file_open_tmp("qtest-seeprom-XXXXXX", &tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, FLASH_SIZE);
+    g_assert(ret == 0);
+    close(fd);
+
+    qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
+                      "threads=1 -accel tcg,thread=single -nographic "
+                      "-blockdev node-name=pib_spic2,driver=file,"
+                      "filename=%s -device 25csm04,bus=pnv-spi-bus.2,cs=0,"
+                      "drive=pib_spic2", tmp_path);
+    spi_seeprom_transaction(qts, chip);
+    qtest_quit(qts);
+    unlink(tmp_path);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    char *tname = g_strdup_printf("pnv-xscom/spi-seeprom/%s",
+            pnv_chips[3].cpu_model);
+    qtest_add_data_func(tname, &pnv_chips[3], test_spi_seeprom);
+    g_free(tname);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 86293051dc..2fa98b2430 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -171,6 +171,7 @@ qtests_ppc64 = \
   qtests_ppc + \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
-- 
2.39.3


