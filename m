Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C50C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Ifp-00024E-1s; Wed, 15 May 2024 13:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7IeP-00014R-H3; Wed, 15 May 2024 13:42:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1s7IeD-0006ad-Rw; Wed, 15 May 2024 13:42:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FHbFGt025156; Wed, 15 May 2024 17:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=QFOIIEwntNr8VDOPKVgOD5yWt8+9WtIKcxGP5ZVNdmE=;
 b=ZyCTIYbUiXy+39FSRgqwhq+MCzmt55JStzyJjL8DpxKCP/RzOHiEA3gZYi+wjZ0bHsNF
 gX0oXONSRdn3p83YaPI7IzFD962XdJWRz/a1LYYo09z8edT5m2SAjcRuZXdBkJgKrw1m
 Lci958x80pCZUWdDJ+rxGdRhHfVv+M4ENSauwRAx6KU0LpGzkbDV0eBS1ZXaeOqmDU4c
 NYKGqPFIFWs6jo5LmOMbCh4Vi2HCjiC6gW48OTLZdgjHHWSjxMne5lq+JDPgbdn5kVfW
 l5Ejxl5T/pDRK7/TVCULVjALM/+6jkEnfQLsZORfh7ZeUWYlOELEST0VGaS9PRw3Z6M7 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y51kug0ae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:33 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FHgXml032475;
 Wed, 15 May 2024 17:42:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y51kug0ad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44FFUxIt002273; Wed, 15 May 2024 17:42:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pcy91-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 May 2024 17:42:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44FHgPO151970482
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 May 2024 17:42:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEB552004F;
 Wed, 15 May 2024 17:42:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C92FA20067;
 Wed, 15 May 2024 17:42:23 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 May 2024 17:42:23 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com, milesg@linux.vnet.ibm.com
Subject: [PATCH v3 5/5] tests/qtest: Add pnv-spi-seeprom qtest
Date: Wed, 15 May 2024 12:41:49 -0500
Message-Id: <20240515174149.17713-6-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
References: <20240515174149.17713-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9avthapFlrb-803NlRz9dnDNKzJgTbKH
X-Proofpoint-ORIG-GUID: aJgCcfiZdR2tZIQeJf_bjkqg4uf0BUUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=521 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150125
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

In this commit Write a qtest pnv-spi-seeprom-test to check the
SPI transactions between spi controller and seeprom device.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 129 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   1 +
 2 files changed, 130 insertions(+)
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
new file mode 100644
index 0000000000..bfa57f3234
--- /dev/null
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -0,0 +1,129 @@
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
+
+#define P10_XSCOM_BASE          0x000603fc00000000ull
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
+static uint64_t pnv_xscom_addr(uint32_t pcba)
+{
+    return P10_XSCOM_BASE | ((uint64_t) pcba << 3);
+}
+
+static uint64_t pnv_spi_seeprom_xscom_addr(uint32_t reg)
+{
+    return pnv_xscom_addr(SPIC2_XSCOM_BASE + reg);
+}
+
+static void pnv_spi_controller_xscom_write(QTestState *qts, uint32_t reg,
+                uint64_t val)
+{
+    qtest_writeq(qts, pnv_spi_seeprom_xscom_addr(reg), val);
+}
+
+static uint64_t pnv_spi_controller_xscom_read(QTestState *qts, uint32_t reg)
+{
+    return qtest_readq(qts, pnv_spi_seeprom_xscom_addr(reg));
+}
+
+static void spi_seeprom_transaction(QTestState *qts)
+{
+    /* SPI transactions to SEEPROM to read from SEEPROM image */
+    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
+                                    READ_OP_COUNTER_CONFIG);
+    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
+                                    READ_OP_SEQUENCER);
+    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, READ_OP_TDR_DATA);
+    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, 0);
+    /* Read 5*8 bytes from SEEPROM at 0x100 */
+    uint64_t rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
+    printf("RDR READ = 0x%lx\n", rdr_val);
+    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
+    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
+    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
+    rdr_val = pnv_spi_controller_xscom_read(qts, RECEIVE_DATA_REG);
+    printf("RDR READ = 0x%lx\n", rdr_val);
+
+    /* SPI transactions to SEEPROM to write to SEEPROM image */
+    pnv_spi_controller_xscom_write(qts, COUNTER_CONFIG_REG,
+                                    WRITE_OP_COUNTER_CONFIG);
+    /* Set Write Enable Latch bit of status0 register */
+    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
+                                    WRITE_OP_SEQUENCER);
+    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, WRITE_OP_WREN);
+    /* write 8 bytes to SEEPROM at 0x100 */
+    pnv_spi_controller_xscom_write(qts, SEQUENCER_OPERATION_REG,
+                                    WRITE_OP_SEQUENCER);
+    pnv_spi_controller_xscom_write(qts, TRANSMIT_DATA_REG, WRITE_OP_TDR_DATA);
+}
+
+/* Find complete path of in_file in the current working directory */
+static void find_file(const char *in_file, char *in_path)
+{
+    g_autofree char *cwd = g_get_current_dir();
+    char *filepath = g_build_filename(cwd, in_file, NULL);
+    if (!access(filepath, F_OK)) {
+        strcpy(in_path, filepath);
+    } else {
+        strcpy(in_path, "");
+        printf("File %s not found within %s\n", in_file, cwd);
+    }
+}
+
+static void test_spi_seeprom(void)
+{
+    QTestState *qts = NULL;
+    char seepromfile[500];
+    find_file("sbe_measurement_seeprom.bin.ecc", seepromfile);
+    if (strcmp(seepromfile, "")) {
+        printf("Starting QEMU with seeprom file.\n");
+        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
+                          "threads=1 -accel tcg,thread=single -nographic "
+                          "-blockdev node-name=pib_spic2,driver=file,"
+			  "filename=sbe_measurement_seeprom.bin.ecc "
+			  "-device 25csm04,bus=pnv-spi-bus.2,cs=0,"
+			  "drive=pib_spic2");
+    } else {
+        printf("Starting QEMU without seeprom file.\n");
+        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
+                          "threads=1 -accel tcg,thread=single -nographic"
+			  " -device 25csm04,bus=pnv-spi-bus.2,cs=0");
+    }
+    spi_seeprom_transaction(qts);
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("spi_seeprom", test_spi_seeprom);
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


