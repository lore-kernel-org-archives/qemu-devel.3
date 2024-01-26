Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BC8C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 03:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTD5K-0004ia-Cg; Thu, 25 Jan 2024 22:40:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTD5I-0004ga-6O; Thu, 25 Jan 2024 22:40:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rTD5G-0003Ou-8D; Thu, 25 Jan 2024 22:40:51 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q3YfG3025775; Fri, 26 Jan 2024 03:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1RTSsUfrFy2oNFvE6e1pLm3PcFC61XO6Zm5btOYFWuQ=;
 b=Pato+hPS8XnrP5uRUTqsBL4LLC6TBFwi+WHOJOculrP7z/fw7Deb2PSiZF6Xe/ww52g/
 EWQbEqt+FeTJbNfFQCiki8MjcJlXjVYbxKMrNOZrCZuwu+Aa+UjJfzTRH+ytt4JinTNL
 n2FAfw7q0+yGvdzJHujL6KI/EHjdE+4KFJPOz3MlAOWp41vd5mZFxoW9d3x1lGz/o4x5
 xhLypZ5sD5mKOJ6Shv9W5uhd8Qca/S37odkHWnvDn0X0ukmkiDxm55am1YlnGHlPx+Ww
 7GSBAollpnb1PwX97KLMhQibCUTmocdpAMg2K8qTEtpcb+BIBYq5S/GMrqix8kJGNRVa xw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv4mdrf8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 03:40:34 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40Q3Zdt7029302;
 Fri, 26 Jan 2024 03:40:33 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vv4mdrf8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 03:40:33 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40Q1pSNc025636; Fri, 26 Jan 2024 03:40:33 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrsgpgfmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 Jan 2024 03:40:33 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40Q3eW8O64160164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jan 2024 03:40:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40D3458043;
 Fri, 26 Jan 2024 03:40:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F08BD58061;
 Fri, 26 Jan 2024 03:40:31 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jan 2024 03:40:31 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v11 09/11] hw/fsi: Added qtest
Date: Thu, 25 Jan 2024 21:40:24 -0600
Message-Id: <20240126034026.31068-10-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126034026.31068-1-ninad@linux.ibm.com>
References: <20240126034026.31068-1-ninad@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RKDQ1O8pqdYF9pZH2YtButba1vJHV8h2
X-Proofpoint-GUID: ReYGvl7MOuaBGXNGlJkg8Q0xbwNH_lkg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=412
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401260024
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Added basic qtests for FSI model.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
---
v11:
  - Removed Cedric's signoff
---
 tests/qtest/aspeed-fsi-test.c | 205 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   1 +
 2 files changed, 206 insertions(+)
 create mode 100644 tests/qtest/aspeed-fsi-test.c

diff --git a/tests/qtest/aspeed-fsi-test.c b/tests/qtest/aspeed-fsi-test.c
new file mode 100644
index 0000000000..b3020dd821
--- /dev/null
+++ b/tests/qtest/aspeed-fsi-test.c
@@ -0,0 +1,205 @@
+/*
+ * QTest testcases for IBM's Flexible Service Interface (FSI)
+ *
+ * Copyright (c) 2023 IBM Corporation
+ *
+ * Authors:
+ *   Ninad Palsule <ninad@linux.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "qemu/module.h"
+#include "libqtest-single.h"
+
+/* Registers from ast2600 specifications */
+#define ASPEED_FSI_ENGINER_TRIGGER   0x04
+#define ASPEED_FSI_OPB0_BUS_SELECT   0x10
+#define ASPEED_FSI_OPB1_BUS_SELECT   0x28
+#define ASPEED_FSI_OPB0_RW_DIRECTION 0x14
+#define ASPEED_FSI_OPB1_RW_DIRECTION 0x2c
+#define ASPEED_FSI_OPB0_XFER_SIZE    0x18
+#define ASPEED_FSI_OPB1_XFER_SIZE    0x30
+#define ASPEED_FSI_OPB0_BUS_ADDR     0x1c
+#define ASPEED_FSI_OPB1_BUS_ADDR     0x34
+#define ASPEED_FSI_INTRRUPT_CLEAR    0x40
+#define ASPEED_FSI_INTRRUPT_STATUS   0x48
+#define ASPEED_FSI_OPB0_BUS_STATUS   0x80
+#define ASPEED_FSI_OPB1_BUS_STATUS   0x8c
+#define ASPEED_FSI_OPB0_READ_DATA    0x84
+#define ASPEED_FSI_OPB1_READ_DATA    0x90
+
+/*
+ * FSI Base addresses from the ast2600 specifications.
+ */
+#define AST2600_OPB_FSI0_BASE_ADDR 0x1e79b000
+#define AST2600_OPB_FSI1_BASE_ADDR 0x1e79b100
+
+static uint32_t aspeed_fsi_base_addr;
+
+static uint32_t aspeed_fsi_readl(QTestState *s, uint32_t reg)
+{
+    return qtest_readl(s, aspeed_fsi_base_addr + reg);
+}
+
+static void aspeed_fsi_writel(QTestState *s, uint32_t reg, uint32_t val)
+{
+    qtest_writel(s, aspeed_fsi_base_addr + reg, val);
+}
+
+/* Setup base address and select register */
+static void test_fsi_setup(QTestState *s, uint32_t base_addr)
+{
+    uint32_t curval;
+
+    aspeed_fsi_base_addr = base_addr;
+
+    /* Set the base select register */
+    if (base_addr == AST2600_OPB_FSI0_BASE_ADDR) {
+        /* Unselect FSI1 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x0);
+
+        /* Select FSI0 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x1);
+    } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
+        /* Unselect FSI0 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x0);
+
+        /* Select FSI1 */
+        aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
+        curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
+        g_assert_cmpuint(curval, ==, 0x1);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
+static void test_fsi_reg_change(QTestState *s, uint32_t reg, uint32_t newval)
+{
+    uint32_t base;
+    uint32_t curval;
+
+    base = aspeed_fsi_readl(s, reg);
+    aspeed_fsi_writel(s, reg, newval);
+    curval = aspeed_fsi_readl(s, reg);
+    g_assert_cmpuint(curval, ==, newval);
+    aspeed_fsi_writel(s, reg, base);
+    curval = aspeed_fsi_readl(s, reg);
+    g_assert_cmpuint(curval, ==, base);
+}
+
+static void test_fsi0_master_regs(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+
+    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
+
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0xF3F4F514);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_XFER_SIZE, 0xF3F4F518);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xF3F4F51c);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_BUS_STATUS, 0xF3F4F580);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB0_READ_DATA, 0xF3F4F584);
+}
+
+static void test_fsi1_master_regs(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+
+    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
+
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0xF3F4F514);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_XFER_SIZE, 0xF3F4F518);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xF3F4F51c);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_CLEAR, 0xF3F4F540);
+    test_fsi_reg_change(s, ASPEED_FSI_INTRRUPT_STATUS, 0xF3F4F548);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_BUS_STATUS, 0xF3F4F580);
+    test_fsi_reg_change(s, ASPEED_FSI_OPB1_READ_DATA, 0xF3F4F584);
+}
+
+static void test_fsi0_getcfam_addr0(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+    uint32_t curval;
+
+    test_fsi_setup(s, AST2600_OPB_FSI0_BASE_ADDR);
+
+    /* Master access direction read */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_RW_DIRECTION, 0x1);
+    /* word */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_XFER_SIZE, 0x3);
+    /* Address */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_ADDR, 0xa0000000);
+    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
+    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
+
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
+    g_assert_cmpuint(curval, ==, 0x10000);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
+    g_assert_cmpuint(curval, ==, 0x0);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
+    g_assert_cmpuint(curval, ==, 0x152d02c0);
+}
+
+static void test_fsi1_getcfam_addr0(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+    uint32_t curval;
+
+    test_fsi_setup(s, AST2600_OPB_FSI1_BASE_ADDR);
+
+    /* Master access direction read */
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_RW_DIRECTION, 0x1);
+
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_XFER_SIZE, 0x3);
+    aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_ADDR, 0xa0000000);
+    aspeed_fsi_writel(s, ASPEED_FSI_INTRRUPT_CLEAR, 0x1);
+    aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
+
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
+    g_assert_cmpuint(curval, ==, 0x20000);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
+    g_assert_cmpuint(curval, ==, 0x0);
+    curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
+    g_assert_cmpuint(curval, ==, 0x152d02c0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret = -1;
+    QTestState *s;
+
+    g_test_init(&argc, &argv, NULL);
+
+    s = qtest_init("-machine ast2600-evb ");
+
+    /* Tests for OPB/FSI0 */
+    qtest_add_data_func("/aspeed-fsi-test/test_fsi0_master_regs", s,
+                        test_fsi0_master_regs);
+
+    qtest_add_data_func("/aspeed-fsi-test/test_fsi0_getcfam_addr0", s,
+                        test_fsi0_getcfam_addr0);
+
+    /* Tests for OPB/FSI1 */
+    qtest_add_data_func("/aspeed-fsi-test/test_fsi1_master_regs", s,
+                        test_fsi1_master_regs);
+
+    qtest_add_data_func("/aspeed-fsi-test/test_fsi1_getcfam_addr0", s,
+                        test_fsi1_getcfam_addr0);
+
+    ret = g_test_run();
+    qtest_quit(s);
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 84a055a7d9..4c871fa095 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -217,6 +217,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
+  (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed-fsi-test'] : []) + \
   ['arm-cpu-features',
    'boot-serial-test']
 
-- 
2.39.2


