Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA7DCD11DB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 10:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnFIr-0007TG-KX; Thu, 21 Mar 2024 06:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFIH-00072I-Cj; Thu, 21 Mar 2024 06:05:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1rnFI1-0007Yu-FD; Thu, 21 Mar 2024 06:05:04 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L9tmjd032392; Thu, 21 Mar 2024 10:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g8ymaAhhz8mBn3W1p/yjiLJCu2ruL9drdKnC6kGOb7s=;
 b=IFl9waxzwW406mVpgcbvh82eIlwo21MxSKBBEvzIkkXlPooxwv02PeWsZoPEpYIKXLwd
 Z8bR18L8IXu9ZonYGMMA6GscpFjegDNPFKxIXTMpZifvsvsvwq98vFW1b7H1j1VRLcEf
 jrneFbLOMXt7sofZWszpOVvVbNn/7OyPcuAGqkjd0tver7HlCGetE5D3I3zESOlx6X7I
 FZAtjYK/I2Ej8DZ1IwOxPQPotkTaYIoFh/lUf8N4vlr44yVK3vCkY2u+6Y6aIUTlWZ9P
 /jlsPwU+BDiuFe4VpluYPTQwAVa4RIJSqiYwavbjmhRIE9IszYR8aVLs4T4fsmEyhqxE Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0gta09d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:38 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LA4bUZ019710;
 Thu, 21 Mar 2024 10:04:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0gta09d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42L7OV9Q019878; Thu, 21 Mar 2024 10:04:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwqykv0p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 10:04:36 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42LA4Yt347448320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 10:04:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D6A758062;
 Thu, 21 Mar 2024 10:04:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E1C85805A;
 Thu, 21 Mar 2024 10:04:33 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 10:04:33 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH 01/10] qtest/phb4: Add testbench for PHB4
Date: Thu, 21 Mar 2024 05:04:13 -0500
Message-Id: <20240321100422.5347-2-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
References: <20240321100422.5347-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XlclDVvXX1rPE9gpz4Jkfqza7cB_ah4C
X-Proofpoint-GUID: HRBOU0qF6-YPLCQZUKJ694SFpk-jnYqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_06,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=795 spamscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403210069
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

New qtest TB added for PHB4.
TB reads PHB Version register and asserts that
bits[24:31] have value 0xA5.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
---
 tests/qtest/meson.build     |  1 +
 tests/qtest/pnv-phb4-test.c | 74 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tests/qtest/pnv-phb4-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 36c5c13a7b..4795e51c17 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -168,6 +168,7 @@ qtests_ppc64 = \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['device-plug-test'] : []) +               \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xscom-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb4-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_USB_UHCI') ? ['usb-hcd-uhci-test'] : []) +             \
diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
new file mode 100644
index 0000000000..e3b809e9c4
--- /dev/null
+++ b/tests/qtest/pnv-phb4-test.c
@@ -0,0 +1,74 @@
+/*
+ * QTest testcase for PowerNV PHB4
+ *
+ * Copyright (c) 2024, IBM Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+
+#define P10_XSCOM_BASE          0x000603fc00000000ull
+#define PHB4_MMIO               0x000600c3c0000000ull
+#define PHB4_XSCOM              0x8010900ull
+
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+
+static uint64_t pnv_xscom_addr(uint32_t pcba)
+{
+    return P10_XSCOM_BASE | ((uint64_t) pcba << 3);
+}
+
+static uint64_t pnv_phb4_xscom_addr(uint32_t reg)
+{
+    return pnv_xscom_addr(PHB4_XSCOM + reg);
+}
+
+/*
+ * XSCOM read/write is indirect in PHB4:
+ * Write 'SCOM - HV Indirect Address Register'
+ * with register-offset to read/write.
+   - bit[0]: Valid Bit
+   - bit[51:61]: Indirect Address(00:10)
+ * Read/write 'SCOM - HV Indirect Data Register' to get/set the value.
+ */
+
+static uint64_t pnv_phb4_xscom_read(QTestState *qts, uint32_t reg)
+{
+    qtest_writeq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_ADDR),
+            PPC_BIT(0) | reg);
+    return qtest_readq(qts, pnv_phb4_xscom_addr(PHB_SCOM_HV_IND_DATA));
+}
+
+/* Assert that 'PHB - Version Register Offset 0x0800' bits-[24:31] are 0xA5 */
+static void phb4_version_test(QTestState *qts)
+{
+    uint64_t ver = pnv_phb4_xscom_read(qts, PHB_VERSION);
+
+    /* PHB Version register [24:31]: Major Revision ID 0xA5 */
+    ver = ver >> (63 - 31);
+    g_assert_cmpuint(ver, ==, 0xA5);
+}
+
+static void test_phb4(void)
+{
+    QTestState *qts = NULL;
+
+    qts = qtest_initf("-machine powernv10 -accel tcg -nographic -d unimp");
+
+    /* Make sure test is running on PHB */
+    phb4_version_test(qts);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("phb4", test_phb4);
+    return g_test_run();
+}
-- 
2.39.3


