Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73627FF8868
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHiAM-0006Yr-Ee; Tue, 28 Apr 2026 09:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA5-0006Sz-2E
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wHiA2-0001Jl-Rm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 09:07:36 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S87CjF2932084; Tue, 28 Apr 2026 13:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=4NVviGlb5bh+PXwzP
 d4clx4ddjYk8AJvga6aJCpuk8A=; b=DhDkocj4QW0iiEsnpn23ZcsU7Z1vRYkn+
 SqxaymmoaqV7zcruJ2VEke/BtsTTZMEYKc7p3mHG5qE52induYnZOYLObpTSWrwY
 4d/F67QjhrX1qA3QLOwzdbMERswR5RP2qzxQFg92GoQ6iFU0AO0yhj3Zgg/TgAKZ
 78MHSQ5QHWZPdjOlIHlsG5UlEKKh914K2+lWjTmir6tVNFVmFzCpnb0Ahn9BtPNH
 ToNLKz7lEgXr8a5XKJzCdKT1a5nG5WVyu5ZtiA+qW0QTflP26VOFtIKstCEQPDDT
 UzfChDEEf7kxuhrjbXkKIXDeVI3tKTLFDHTN+doFq+sO660k1qAxg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r5jpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SCwAmx010502;
 Tue, 28 Apr 2026 13:07:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq9wfj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Apr 2026 13:07:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63SD7RCL40960634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Apr 2026 13:07:28 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFBC75805A;
 Tue, 28 Apr 2026 13:07:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B4CD58052;
 Tue, 28 Apr 2026 13:07:27 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Apr 2026 13:07:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/6] tests: Move TPM I2C bus read/write functions to common
 files
Date: Tue, 28 Apr 2026 13:07:13 +0000
Message-ID: <20260428130718.1325177-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428130718.1325177-1-stefanb@linux.ibm.com>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VCyFsJgVuz4ZoCC4ynXetmwng-NRz9Hu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExOCBTYWx0ZWRfX1cNIhkfCVqKc
 EpAswt6Z3OLmLe/B0yzpKDmiCCZOe22aAwyO8nOHqIjRZZzVMRqsudThyZSWRjhCLvR7fkynHTU
 /9u2WBTHm6ysbT2Oen8p+cdRss1e/cBhMdqfBSnbofVdqJu0JqJUSaQlAExIsLWShPrxivVRBDV
 oQ8k/19S+G/HY3t+fwhFMUg2S0bI0tSQ8gyN0afM3FrS19RZ1iSPj1VeK2eJ8r2kLYAbbIKREaf
 ZupdG7kADFB334eCh2Pzo/Haucm+IcOTRYSRKHdumgxj/ZJg1PNh7SFUuc00G9YJ8Tx1sF4i8qZ
 TUH196f08oDgtrkZbNsdIEslrz8yEHL6ywxQ62DztcAuSpVo79kh1WAnO03zyvpz+Leu9/yS3Xr
 vUAc18yCSWnWUEaZ6r/HbguRkIA8j5kc8bdscMkb8DtT8C6DX8tdj1xcIy/9BFb4VefWkHwxvJj
 B/sJ8SooIIkoEoHrUOQ==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0b111 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=8hQrII4DcMiSDO2ebf0A:9
X-Proofpoint-ORIG-GUID: VCyFsJgVuz4ZoCC4ynXetmwng-NRz9Hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280118
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
index b735f55fc4..823be192e7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -397,7 +397,7 @@ qtests = {
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
2.43.0


