Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BED0CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 18:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruFlU-0001cC-Tv; Tue, 09 Apr 2024 14:00:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1ruFl3-0001YO-5d; Tue, 09 Apr 2024 13:59:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1ruFkz-0004tS-CV; Tue, 09 Apr 2024 13:59:44 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 439HnB91008434; Tue, 9 Apr 2024 17:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0EzdbDVuLZCw/eJ4MDkGX4+gksizigEUsKFw90GT9eU=;
 b=mmhWmBm1zujAho7ovwl/NdmClQCMJrd0JFunbQlvzbzyClV7vcPjKV6tTgAPrp3W0pWM
 SuZ5BUF69sYiwzm5TQ9wzzISi2XfkUzdR0KnvgU2C+ZpHBAYrdKnHJfkQK3n88XkF/FB
 1qv+TdeXQcq0BTME02Qpj+Po8tmCUjyrjbbI4/MG5Nqv6buDRIHoMLcAFNCSKc1V5YWH
 rH+aCPwqIKdVL3ZnbePfZK/DV4zkNYGC1FvubCTmdJQlZP7Ip4MtctsSF0NzAvWzZSn+
 xUX+jZRZxF+rAikXcFaQlob4RI2QntrfThTcTkwfLtXtLgb1xi3u252jjGn7h1wXgwNL fA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdada80n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:59:33 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439HxWtC022061;
 Tue, 9 Apr 2024 17:59:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xdada80jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:59:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 439FWWR6029894; Tue, 9 Apr 2024 17:57:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbj7m7qr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 17:57:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 439HvWFG34734664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Apr 2024 17:57:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 491F920043;
 Tue,  9 Apr 2024 17:57:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8ED312006B;
 Tue,  9 Apr 2024 17:57:30 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Apr 2024 17:57:30 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com,
 dantan@us.ibm.com
Subject: [PATCH v2 6/6] tests/qtest: Add pnv-spi-seeprom qtest
Date: Tue,  9 Apr 2024 12:57:00 -0500
Message-Id: <20240409175700.27535-7-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
References: <20240409175700.27535-1-chalapathi.v@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: p1a7RNoAHe0aJImpYEJImj8CbbrLCUEu
X-Proofpoint-GUID: z8GdOpWz1C2CLuqMPyjbcbuQ96Q_qJx5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 mlxlogscore=741 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404090118
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

In this commit Write a qtest pnv-spi-seeprom-test to check the
SPI transactions between spi controller and seeprom device.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 tests/qtest/pnv-spi-seeprom-test.c | 126 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   1 +
 2 files changed, 127 insertions(+)
 create mode 100644 tests/qtest/pnv-spi-seeprom-test.c

diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
new file mode 100644
index 0000000000..4f0fcb1ea3
--- /dev/null
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -0,0 +1,126 @@
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
+#include "hw/ppc/pnv_spi_controller_regs.h"
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
+                          "-device loader,file=sbe_measurement_seeprom.bin.ecc"
+                          ",addr=0x7000000");
+    } else {
+        printf("Starting QEMU without seeprom file.\n");
+        qts = qtest_initf("-m 2G -machine powernv10 -smp 2,cores=2,"
+                          "threads=1 -accel tcg,thread=single -nographic");
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
index 36c5c13a7b..e95453022d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -167,6 +167,7 @@ qtests_ppc64 = \
   qtests_ppc + \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
-- 
2.39.3


