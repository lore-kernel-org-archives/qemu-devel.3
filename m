Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920B0FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rZ-0004Fq-W8; Wed, 29 Apr 2026 08:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rX-0004Ew-B4
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rV-0000os-4Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:54 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SN5qv41046341; Wed, 29 Apr 2026 12:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KhmwtuPz647wE9lQY
 CX8IQtwAdej61plNxZ9W+w08AU=; b=EfMtYvj9/IZxPx/fJj/nwwelW+faMYbfl
 7UpccGEmJnXYSnFCbYWk189rRWcAIaEeY7Pzxr8sQZOqHd//VddaXyZxvvSDwZ9h
 PWqcrFZnggQxxRedxtK7IeQ+n1/KExgSIttiim2nqewT9+wgai6ZwG4Qj2xXK9tF
 pdswIQ0j5+aqM5k5KaYEYyFiYIrknAf+SOFgAGh9PSzd7ru0YXOt6kkwA2az/8P2
 ClQ5YPC9nZqmHI6h4HXj6fmdVNUMW+QKMZ3e+mBMYSuONqbsOgIxxkpc5ESN6bZ0
 iu153yie13IiCQjDvkwp99O+kQxdHLKf80Ar6qV3tbOsgAEhxL6zQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44tg55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TC975S002450;
 Wed, 29 Apr 2026 12:17:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avx969-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHnai32899708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6354D58045;
 Wed, 29 Apr 2026 12:17:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD72A58052;
 Wed, 29 Apr 2026 12:17:48 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:48 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/6] tests: Move TPM I2C bus read/write functions to common
 files
Date: Wed, 29 Apr 2026 12:17:38 +0000
Message-ID: <20260429121743.1346635-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429121743.1346635-1-stefanb@linux.ibm.com>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jLOVYG8OPfiB47XMOjJVZUaX0aqbm5NX
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f1f6ef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=8hQrII4DcMiSDO2ebf0A:9
X-Proofpoint-GUID: jLOVYG8OPfiB47XMOjJVZUaX0aqbm5NX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfX70jYyFf+h0QD
 lOjWH2GMfyvnFPCwSx6f901JIURCr4vJ381iYXEqSOEfkqc4rVtH9hDi6H8FnGk4FBwvgWITd6J
 4HLvf2Ck0vaGTNjmKhb+IgBKHLwZpk88TPIUfhmcQpbnFK4/M6ZV5xuotzb9Myl78ctDu0ovcN5
 RWAFWZ0mQfD3BHhYOCGbn8uFurbj8VpQKtPji+P5r1SUlHONZDkLgLE7LUMS0JEWY+OfTa6d5fN
 uTnlaK1FXFs21FVDlb24GOxVrIPohAgYs6RB10DR4l2ycD+jQLK+B93VgJsyaWMlMVYQaFpvoxL
 qMDSA1XJXa6aB2Mo9CTn54IJ14wZUmoq9yCK83o3wqcMF+hsMxS00TBzxtWFhkpL1v+hwJPyQ/L
 1IMkQ1y4j/XYQjzL87OecZcMvfmg2tjwLuIcgYY0Vp+mqUyOwAvwuE3TGIlwmb0XPQg25EqOpfy
 1OqJff0bzboO6r87lLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290125
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
Reviewed-by: Arun Menon <armenon@redhat.com>
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


