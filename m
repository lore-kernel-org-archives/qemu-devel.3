Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CA9CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAai-0006b7-0Q; Mon, 01 Jun 2026 17:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAae-0006ZR-UR
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAab-0003pc-Sd
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651GtHL92415657; Mon, 1 Jun 2026 21:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XCzspYkogliws8oIC
 JPxI7vAv69/YR57DVkiYYvwANc=; b=KovHkorA6JF8k3Lkg1mHRR5AMLoXUmeWv
 wK65mGVztyYlw2stkbPbcyGsc6a2r/lhOGHbRcd0NGlua2mdAYhWAP64KT+pBsmB
 Z6iEdqoXFNBnr4bn5pF1i+zLNxWGGQLLlpvDrVKMOrxIb0oPygzetoOvF+W7zhY9
 mVWdGHYzhTS5TEaWtNl8vJqlrYQVwPUIvTF+JAqFhJq/P5qUxEhKkZqezlxym/ah
 JrxlamOvnMpAYGyF8Qz+wvzEtlfdeGyoBGwMEIUqL1ZbA47xP5KP0bmDG7vNgJZJ
 oR6/OeO2ezrZ1yAmp0A+aAXCdWHwKUInyOP3zzK7rEkK5BrtlAPEw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahjwh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsCBU005299;
 Mon, 1 Jun 2026 21:54:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvrct6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsPfe30278366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 486D05805A;
 Mon,  1 Jun 2026 21:54:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C49E058054;
 Mon,  1 Jun 2026 21:54:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 01/16] tests: Move TPM I2C bus read/write functions to
 common files
Date: Mon,  1 Jun 2026 17:53:54 -0400
Message-ID: <20260601215410.517009-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX1+66sFuW5Sl6
 UtlcfS1lwqJ1uWfCt4hhnkyef1GnhGd3nHajS7SNPeOu+7Tn/S06G+w6zZ7JBB+GHQvdhikIoHk
 kVTptfBrc6DvharY69taJqztp4vTVYLzpniDpKvCe13JaIWzIWhHo3Z2gyMUWTEhniTaMmyCJyR
 ire+qBAmH+4a8FobvB2vN4XUIM6i32geSxBoDhwkjNKjj6vStl8lyCnlwR/ZyGYoa8x0diq6O2H
 +ryDjMIyd/L+XeGgbH4gjy7ALfptfQfQQroxOj1UtoKSqFV5phAqILe7MxklG5W8WlTqaa2UYUW
 /YXnLCaKZXygBiE7c9kP3uplBRd+P/81Wgp6ydFNNZx/fCQ98HyegIpeHq6N4GBQrRkxBJi5lr8
 IUukt8hfN+KgNVY8Y1LmyJrXwjrEevwNyYQZ+fbYczWj6TkM6Ebr85KSoineWBDEHitMulM7dCp
 3fB41SmXII1GJ21rImA==
X-Proofpoint-ORIG-GUID: cc1jHGBcK5D17kL-u7DopW2Kz08p-1N4
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dff92 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=8hQrII4DcMiSDO2ebf0A:9
X-Proofpoint-GUID: cc1jHGBcK5D17kL-u7DopW2Kz08p-1N4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move functions for reading from and writing to the Aspeed I2C device into
a file so they can be reused by other functions.

Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260429121743.1346635-2-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/meson.build        |  2 +-
 tests/qtest/tpm-tis-i2c-test.c | 50 +-------------------------
 tests/qtest/tpm-tis-i2c-util.c | 64 ++++++++++++++++++++++++++++++++++
 tests/qtest/tpm-tis-i2c-util.h | 30 ++++++++++++++++
 4 files changed, 96 insertions(+), 50 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-i2c-util.c
 create mode 100644 tests/qtest/tpm-tis-i2c-util.h

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 728dde54b3..57512c6e56 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -401,7 +401,7 @@ qtests = {
   'tpm-crb-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
-  'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
+  'tpm-tis-i2c-test': [io, tpmemu_files, 'tpm-tis-i2c-util.c', 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'virtio-net-failover': test_migration_files,
diff --git a/tests/qtest/tpm-tis-i2c-test.c b/tests/qtest/tpm-tis-i2c-test.c
index 3a1af026f2..02ddf76c2c 100644
--- a/tests/qtest/tpm-tis-i2c-test.c
+++ b/tests/qtest/tpm-tis-i2c-test.c
@@ -20,6 +20,7 @@
 #include "hw/pci/pci_ids.h"
 #include "qtest_aspeed.h"
 #include "tpm-emu.h"
+#include "tpm-tis-i2c-util.h"
 
 #define DEBUG_TIS_TEST 0
 
@@ -36,58 +37,9 @@
 #define DPRINTF_STS \
     DPRINTF("%s: %d: sts = 0x%08x\n", __func__, __LINE__, sts)
 
-#define I2C_SLAVE_ADDR   0x2e
-#define I2C_DEV_BUS_NUM  10
-
 static const uint8_t TPM_CMD[12] =
     "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
 
-static uint32_t aspeed_bus_addr;
-
-static uint8_t cur_locty = 0xff;
-
-static void tpm_tis_i2c_set_locty(uint8_t locty)
-{
-    if (cur_locty != locty) {
-        cur_locty = locty;
-        aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR,
-                          TPM_I2C_REG_LOC_SEL, locty);
-    }
-}
-
-static uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg)
-{
-    tpm_tis_i2c_set_locty(locty);
-    return aspeed_i2c_readb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
-}
-
-static uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg)
-{
-    tpm_tis_i2c_set_locty(locty);
-    return aspeed_i2c_readw(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
-}
-
-static uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg)
-{
-    tpm_tis_i2c_set_locty(locty);
-    return aspeed_i2c_readl(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
-}
-
-static void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v)
-{
-    if (reg != TPM_I2C_REG_LOC_SEL) {
-        tpm_tis_i2c_set_locty(locty);
-    }
-    aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
-}
-
-static void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v)
-{
-    if (reg != TPM_I2C_REG_LOC_SEL) {
-        tpm_tis_i2c_set_locty(locty);
-    }
-    aspeed_i2c_writel(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
-}
 
 static void tpm_tis_i2c_test_basic(const void *data)
 {
diff --git a/tests/qtest/tpm-tis-i2c-util.c b/tests/qtest/tpm-tis-i2c-util.c
new file mode 100644
index 0000000000..07b1eeba69
--- /dev/null
+++ b/tests/qtest/tpm-tis-i2c-util.c
@@ -0,0 +1,64 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTest utilities for TPM TIS over I2C
+ *
+ * Copyright (c) 2018, 2026 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.ibm.com>
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/tpm.h"
+#include "libqtest-single.h"
+#include "qtest_aspeed.h"
+#include "tpm-tis-i2c-util.h"
+
+uint32_t aspeed_bus_addr;
+
+static uint8_t cur_locty = 0xff;
+
+static void tpm_tis_i2c_set_locty(uint8_t locty)
+{
+    if (cur_locty != locty) {
+        cur_locty = locty;
+        aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR,
+                          TPM_I2C_REG_LOC_SEL, locty);
+    }
+}
+
+uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg)
+{
+    tpm_tis_i2c_set_locty(locty);
+    return aspeed_i2c_readb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
+}
+
+uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg)
+{
+    tpm_tis_i2c_set_locty(locty);
+    return aspeed_i2c_readw(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
+}
+
+uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg)
+{
+    tpm_tis_i2c_set_locty(locty);
+    return aspeed_i2c_readl(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg);
+}
+
+void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v)
+{
+    if (reg != TPM_I2C_REG_LOC_SEL) {
+        tpm_tis_i2c_set_locty(locty);
+    }
+    aspeed_i2c_writeb(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
+}
+
+void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v)
+{
+    if (reg != TPM_I2C_REG_LOC_SEL) {
+        tpm_tis_i2c_set_locty(locty);
+    }
+    aspeed_i2c_writel(global_qtest, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
+}
diff --git a/tests/qtest/tpm-tis-i2c-util.h b/tests/qtest/tpm-tis-i2c-util.h
new file mode 100644
index 0000000000..dfe626b43d
--- /dev/null
+++ b/tests/qtest/tpm-tis-i2c-util.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTest TPM TIS I2C: Common test functions used for TPM I2C on Aspeed bus
+ *
+ * Copyright (c) 2026 IBM Corporation
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.ibm.com>
+ *
+ */
+
+#ifndef TESTS_TPM_TIS_I2C_UTIL_H
+#define TESTS_TPM_TIS_I2C_UTIL_H
+
+#include "qemu/osdep.h"
+
+extern uint32_t aspeed_bus_addr;
+
+#define I2C_SLAVE_ADDR   0x2e
+#define I2C_DEV_BUS_NUM  10
+
+uint8_t tpm_tis_i2c_readb(uint8_t locty, uint8_t reg);
+uint16_t tpm_tis_i2c_readw(uint8_t locty, uint8_t reg);
+uint32_t tpm_tis_i2c_readl(uint8_t locty, uint8_t reg);
+
+void tpm_tis_i2c_writeb(uint8_t locty, uint8_t reg, uint8_t v);
+void tpm_tis_i2c_writel(uint8_t locty, uint8_t reg, uint32_t v);
+
+#endif /* TESTS_TPM_TIS_I2C_UTIL_H */
-- 
2.54.0


