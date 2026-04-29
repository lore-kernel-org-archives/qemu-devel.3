Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFD4FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI3rm-0004IN-IK; Wed, 29 Apr 2026 08:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rZ-0004Fo-TY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wI3rX-0000t8-Ss
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:17:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SJXuJr3499801; Wed, 29 Apr 2026 12:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=+SBRLx3hztB6HqxJ9
 0C7GOa0WF9j8r7wQYbco1ebfes=; b=BwZjYVIwvuTcbQ0pom8XBBHwiuSBcFyBY
 xK5dhu4cVi2uIr09f20adaCHexPA/u9QuZGhuGzFVYb2hPFkar1HiVrLmwZ64fLV
 Mm4OWt6MS2HSeMQBJ9nIQ0AdihRz5syX6VI3+fuaGAafCMgLqBe0kJVptSc4ddoj
 DG75kDAGMRWL52fwf6VL34+Dq0JqHefnStSHRTGs5n2WvaJi9pdAuIzhXtcpnsZm
 GtFlHC3tLPr302AduVlNtFdRfmHermUfOX0D/U28nojhP/xKwAw7G44PicrHfynL
 1fOtl6bL5rtCv94Njom3+FRJTOukPNvB5DcLuUNs1DNfb5AHCpZYg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44tg5a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TC8jvM002178;
 Wed, 29 Apr 2026 12:17:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avx96a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 29 Apr 2026 12:17:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TCHqCA5768042
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Apr 2026 12:17:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9365658056;
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19A9F58045;
 Wed, 29 Apr 2026 12:17:52 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 29 Apr 2026 12:17:51 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 6/6] tests: Add a TPM TIS I2C swtpm test
Date: Wed, 29 Apr 2026 12:17:43 +0000
Message-ID: <20260429121743.1346635-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429121743.1346635-1-stefanb@linux.ibm.com>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CIj4vYb_saFGwYN_-Rqvp1epvr6W6ruB
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f1f6f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=nr6cYVCJ1kreKA-1BtQA:9
X-Proofpoint-GUID: CIj4vYb_saFGwYN_-Rqvp1epvr6W6ruB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEyNSBTYWx0ZWRfXziOLCI/amuWv
 Pm+s4pAJGUB16z7ZZntwuiP/pbit9zCU3/Vco3EUtLvn4VJiA+xlLKNcqlKAesr+KEDCxrkQt7w
 Zm5zrhsEzbBX8iTJbSA59K3xIw8oT+9to2+uNdjOIx4XqRQ5UZYtmfdevhcL5fjHhCPAQry5TpK
 2OzIRRwIP5q/4Cm+DbRv82JqgN+zF6i+uKVyQWrmc/cKEcG5n//YeuDWu7NvRqWI3/ARijRcyvr
 a/LqA71TrmDgoEfmLIcdck4RiJ5VQBnSNVQ4hs+3FSiYC5NJqi5y07QdkKi5LUUpdKIwf0fKVLW
 /yEpLULeggnrckL0mWXTdjsBBorZv05ci29jkXNODj5sKsHKYBMw7JYnevCceVBt8RjW/G/2Wqg
 M9tRqSYtuBwGXOaNQrNv20kFSAiUW6hT17MWV/5UY3vOiouXagweSk8QGXEghBnkkgg38uoOEPr
 jFlnr3VKM35RyNllSOg==
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

Add a test case testing the TPM TIS over I2C with swtpm.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Arun Menon <armenon@redhat.com>
---
 tests/qtest/meson.build              |  5 +-
 tests/qtest/tpm-tis-i2c-swtpm-test.c | 82 ++++++++++++++++++++++++++++
 tests/qtest/tpm-tis-i2c-util.c       | 38 +++++++++++++
 tests/qtest/tpm-tis-i2c-util.h       |  4 ++
 4 files changed, 127 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/tpm-tis-i2c-swtpm-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 823be192e7..1a94f20f7f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -241,7 +241,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
@@ -260,7 +260,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
-   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+   config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
@@ -398,6 +398,7 @@ qtests = {
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
2.43.0


