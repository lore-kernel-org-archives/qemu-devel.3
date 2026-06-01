Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3614CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAai-0006bm-Gy; Mon, 01 Jun 2026 17:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAag-0006a8-0O
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAad-0003qQ-GH
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651EIZoO1502206; Mon, 1 Jun 2026 21:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eV0D9IU7ZEz0FiZdF
 J4P4/D36Ke7+YJ7qke5GTmq3AM=; b=LCrDnjJo2w5kAYdlQOV6VtEcGvkPOP2PY
 L7w9fxpTFB/mkCp/IRxUns5p1+f3kzxJr8jmtB7lpMdxBelCnsZ4R0wOdus+/7LY
 C5GnpI0m89Q80lbD31h9Vgm2d2b4Mi7UsbvU898aMJOp4eZ/jUH11n8W/EMl372R
 j3xAEiuZ0f5JKgSQFW/5EhkBkYtT6PMsSFT2AzsCROPRmjGrh7UyPKskTpXA+61u
 1mUh0pIIQy+BngboPrqYqxOG8bfcWgQ6rmIKNmyj21JyxOQIgkWCUA1wHP/AWwCH
 avelmPXdE7p/gk7ztwfm1YLQimYbHOJum4kk5Z6+z64VChBUSGb6g==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahjwhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651Ls9eZ022941;
 Mon, 1 Jun 2026 21:54:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegg1sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsS7I31130284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C2585805C;
 Mon,  1 Jun 2026 21:54:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B32E5805A;
 Mon,  1 Jun 2026 21:54:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PULL v1 06/16] tests: Add a TPM TIS I2C swtpm test
Date: Mon,  1 Jun 2026 17:53:59 -0400
Message-ID: <20260601215410.517009-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfXxxi3AHH7DXht
 SdN8L6nLAyAUIO9QUBSqVqSVr3xQSMVbNs1y7JLIV0y9ALwWYrGcu4pkfQOAFWz17RRcq6PAiuE
 Ry4inqYKn4CRBWRwIoRhplslI4eRNe3lSzK4bs4i3/nA0hmKtJnNbEgvHVsTlZP5cbs+dF/eENl
 eayjXSrf9TVrLa2lm09kg5xQOZss3OBHv8bxQQtI0oVLBuNjzP4dec7DktkuJOgG+BXNrqIeUMU
 U9FF3TAF4wkKBgZ+sHC4IV7PQeJPMfB0ohXXVZeudKGDAkAcNWaH84D4wwZQQbHyYls4ui0nrNg
 D3jDC5zPCO58zKQ+JGqsi4GI9PU0xAOLs3z4qbQGdmR6bEay/UhbUWxbvhmn1m4lcsGwa9/msS6
 nWrzfRllgQQxnoqvw8dRKPWwYSQNySIMEnJBQLH35pZXxXWtQO93MbNd6I5M+YSujrczzbka4qO
 n2TNaAae3knLU9kKb6g==
X-Proofpoint-ORIG-GUID: Doh4eW9rzY9KPVTb2OIGrqsp7XwAHKfb
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1dff96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=nr6cYVCJ1kreKA-1BtQA:9
X-Proofpoint-GUID: Doh4eW9rzY9KPVTb2OIGrqsp7XwAHKfb
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

Add a test case testing the TPM TIS over I2C with swtpm.

Reviewed-by: Arun Menon <armenon@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260429121743.1346635-7-stefanb@linux.ibm.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/meson.build              |  5 +-
 tests/qtest/tpm-tis-i2c-swtpm-test.c | 82 ++++++++++++++++++++++++++++
 tests/qtest/tpm-tis-i2c-util.c       | 38 +++++++++++++
 tests/qtest/tpm-tis-i2c-util.h       |  4 ++
 4 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-i2c-swtpm-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 57512c6e56..45ea497fa5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -244,7 +244,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
@@ -263,7 +263,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
-   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
@@ -402,6 +402,7 @@ qtests = {
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-i2c-test': [io, tpmemu_files, 'tpm-tis-i2c-util.c', 'qtest_aspeed.c'],
+  'tpm-tis-i2c-swtpm-test': [io, tpmemu_files, 'tpm-tis-i2c-util.c', 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'virtio-net-failover': test_migration_files,
diff --git a/tests/qtest/tpm-tis-i2c-swtpm-test.c b/tests/qtest/tpm-tis-i2c-swtpm-test.c
new file mode 100644
index 0000000000..50d32a960b
--- /dev/null
+++ b/tests/qtest/tpm-tis-i2c-swtpm-test.c
@@ -0,0 +1,82 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QTest testcase for TPM TIS over I2C talking to external swtpm
+ *
+ * Copyright (c) 2018, 2026 IBM Corporation
+ *  with parts borrowed from migration-test.c that is:
+ *     Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *
+ * Authors:
+ *   Stefan Berger <stefanb@linux.ibm.com>
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qemu/module.h"
+#include "tpm-tests.h"
+#include "tpm-tis-i2c-util.h"
+#include "qtest_aspeed.h"
+
+typedef struct TestState {
+    char *src_tpm_path;
+    char *dst_tpm_path;
+    char *uri;
+    const char *machine_options;
+    char *ifmodel;
+} TestState;
+
+static void tpm_tis_i2c_swtpm_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_test(ts->src_tpm_path, tpm_tis_i2c_transfer,
+                        ts->ifmodel, ts->machine_options);
+}
+
+static void tpm_tis_swtpm_migration_test(const void *data)
+{
+    const TestState *ts = data;
+
+    tpm_test_swtpm_migration_test(ts->src_tpm_path, ts->dst_tpm_path,
+                                  ts->uri, tpm_tis_i2c_transfer,
+                                  ts->ifmodel, ts->machine_options);
+}
+
+
+int main(int argc, char **argv)
+{
+    int ret;
+    TestState ts;
+
+    ts.src_tpm_path = g_dir_make_tmp("qemu-tpm-tis-i2c-swtpm-test.XXXXXX",
+                                     NULL);
+    ts.dst_tpm_path = g_dir_make_tmp("qemu-tpm-tis-i2c-swtpm-test.XXXXXX",
+                                     NULL);
+    ts.uri = g_strdup_printf("unix:%s/migsocket", ts.src_tpm_path);
+    ts.machine_options = "-machine rainier-bmc -accel tcg";
+    ts.ifmodel = g_strdup_printf(
+                            "tpm-tis-i2c,bus=aspeed.i2c.bus.%d,address=0x%x",
+                            I2C_DEV_BUS_NUM, I2C_SLAVE_ADDR);
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    aspeed_bus_addr = ast2600_i2c_calc_bus_addr(I2C_DEV_BUS_NUM);
+
+    qtest_add_data_func("/tpm/tis-i2c-swtpm/test", &ts, tpm_tis_i2c_swtpm_test);
+    qtest_add_data_func("/tpm/tis-i2c-swtpm-migration/test", &ts,
+                        tpm_tis_swtpm_migration_test);
+    ret = g_test_run();
+
+    tpm_util_rmdir(ts.dst_tpm_path);
+    g_free(ts.dst_tpm_path);
+    tpm_util_rmdir(ts.src_tpm_path);
+    g_free(ts.src_tpm_path);
+    g_free(ts.uri);
+    g_free(ts.ifmodel);
+
+    return ret;
+}
diff --git a/tests/qtest/tpm-tis-i2c-util.c b/tests/qtest/tpm-tis-i2c-util.c
index 6e724a4a47..c73420ec5b 100644
--- a/tests/qtest/tpm-tis-i2c-util.c
+++ b/tests/qtest/tpm-tis-i2c-util.c
@@ -15,6 +15,7 @@
 #include "libqtest-single.h"
 #include "qtest_aspeed.h"
 #include "tpm-tis-i2c-util.h"
+#include "tpm-emu.h"
 
 uint32_t aspeed_bus_addr;
 
@@ -62,3 +63,40 @@ void tpm_tis_i2c_writel(QTestState *s, uint8_t locty, uint8_t reg, uint32_t v)
     }
     aspeed_i2c_writel(s, aspeed_bus_addr, I2C_SLAVE_ADDR, reg, v);
 }
+
+void tpm_tis_i2c_transfer(QTestState *s,
+                          const unsigned char *req, size_t req_size,
+                          unsigned char *rsp, size_t rsp_size)
+{
+    uint32_t sts;
+    size_t i;
+
+    /* request use of locality 0 */
+    tpm_tis_i2c_writeb(s, 0, TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_REQUEST_USE);
+
+    tpm_tis_i2c_writel(s, 0, TPM_I2C_REG_STS, TPM_TIS_STS_COMMAND_READY);
+
+    /* transmit command */
+    for (i = 0; i < req_size; i++) {
+        tpm_tis_i2c_writeb(s, 0, TPM_I2C_REG_DATA_FIFO, req[i]);
+    }
+
+    /* start processing */
+    tpm_tis_i2c_writeb(s, 0, TPM_I2C_REG_STS, TPM_TIS_STS_TPM_GO);
+
+    uint64_t end_time = g_get_monotonic_time() + 50 * G_TIME_SPAN_SECOND;
+    do {
+        sts = tpm_tis_i2c_readl(s, 0, TPM_I2C_REG_STS);
+        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) != 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+
+    /* read response */
+    for (i = 0; i < rsp_size; i++) {
+        rsp[i] = tpm_tis_i2c_readb(s, 0, TPM_I2C_REG_DATA_FIFO);
+    }
+    /* relinquish use of locality 0 */
+    tpm_tis_i2c_writeb(s, 0,
+                       TPM_I2C_REG_ACCESS, TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+}
diff --git a/tests/qtest/tpm-tis-i2c-util.h b/tests/qtest/tpm-tis-i2c-util.h
index 3289545f61..499bf4964a 100644
--- a/tests/qtest/tpm-tis-i2c-util.h
+++ b/tests/qtest/tpm-tis-i2c-util.h
@@ -27,4 +27,8 @@ uint32_t tpm_tis_i2c_readl(QTestState *s, uint8_t locty, uint8_t reg);
 void tpm_tis_i2c_writeb(QTestState *s, uint8_t locty, uint8_t reg, uint8_t v);
 void tpm_tis_i2c_writel(QTestState *s, uint8_t locty, uint8_t reg, uint32_t v);
 
+void tpm_tis_i2c_transfer(QTestState *s,
+                          const unsigned char *req, size_t req_size,
+                          unsigned char *rsp, size_t rsp_size);
+
 #endif /* TESTS_TPM_TIS_I2C_UTIL_H */
-- 
2.54.0


