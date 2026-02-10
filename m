Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450E4EA811A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpo06-0001BD-WD; Tue, 10 Feb 2026 08:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpnzw-00013h-7n; Tue, 10 Feb 2026 08:41:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vpnzu-00034j-Ae; Tue, 10 Feb 2026 08:41:47 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619IxNhT1915889; Tue, 10 Feb 2026 13:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=H8mHFG
 TieOahfb67i6yRuO7Y/g80NWvwNIA6BFKycbk=; b=rYWPeTgNceIh+Z3WgKgpTB
 Y6yy6hDuFxyjYbnFrbz0bSM5zb8co3Dm3EzWIzJU1V2z5L1zcKQRGDYPFwUnoa60
 mFZgnym2cSw+emz1aDD18OpITOdFAlOFjBT2w0MSld9GdwkhPXcovqmdB810AdcP
 YAZM6Goubka84UZTIOpWWvJxDOfq26o53+smvBfxYSJVCblGoRCS9ssgx9TLIyoB
 8sFpRcxNl9ph5h8JxZFooIHOYpuuJGoMSTrQOo025oMVUeKCSDUtL9Iuu9jqyGzq
 FVsXYRLINaVrwiOo/d5WoWxX2QJ6+xCmbYT6X0QD1gwAZ0YySRA64NRp3N/+gdTg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ucfv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:41:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A9g5hY001471;
 Tue, 10 Feb 2026 13:41:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6gqn1gbt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 13:41:35 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61ADfEIg23986840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 13:41:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DA745805C;
 Tue, 10 Feb 2026 13:41:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01F6258054;
 Tue, 10 Feb 2026 13:41:33 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 13:41:32 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 1/9] qtest/phb4: Add testbench for PHB4
Date: Tue, 10 Feb 2026 07:40:51 -0600
Message-ID: <20260210134110.1515322-2-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KZnfcAYD c=1 sm=1 tr=0 ts=698b3591 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=IezeUUPc-1SGbE2r020A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDExMiBTYWx0ZWRfXx/glpVvo7Gyu
 i/32HHclLQ4IOp0Fptp3IJ1ZUTGCUkMit2RFY8a491m4giCnWT1Dkr0rEDSQ9gsYlBX9njLUW89
 ssm5jGup7dte4Iv3uBWtIw98oe9wWEQhUK+WbUS39cDzp+leYbSN/ItoXVjBaeW2tj5T6dwhQTN
 dl3GuSsXodZZfUfY0PTXAGld/d7DevoUGI0FPLgOQemKd/YzZ4mrquHl67vqJpkddp0Lb/nR1mG
 Wma3RZJBmdOunmAlquTNcKUVrn+FndHIbjTrH7Gu5+aWjYbaGGI5YfkuZwAeOitFz/AILd/35h8
 4hJdqExOeXBbAnxcjvm/5GiXKaLlxB30vg8WRZQs4DeWKhpFj0YwJtFAaX65D07lh0h1E8SRvME
 AmGLBHH0SYl22qWefBAN850cVIrw3N30d5uExkbS/pO4WYkh06sKs6G7erDT+qGPDgC7M8QuPB/
 L2hDL2Ncb+qzST3TbGg==
X-Proofpoint-ORIG-GUID: mXsPg1T8bzbm_55dO7vE2jjcGKcUmzcx
X-Proofpoint-GUID: xiaObr088Jn7_RngN_-OFEvYWWLD_ARF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100112
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

New qtest testbench added for PHB[345].
Testbench reads PHB Version register and asserts that
bits[24:31] have value 0xA3, 0xA4 and 0xA5 respectively.

Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
v3: Updates for coding guidelines.

v2: Added version check for PHB3 and PHB4 also.

 tests/qtest/meson.build     |  1 +
 tests/qtest/pnv-phb4-test.c | 98 +++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)
 create mode 100644 tests/qtest/pnv-phb4-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index dfb83650c6..593c3c4560 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -184,6 +184,7 @@ qtests_ppc64 = \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-xive2-test'] : []) +                 \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-spi-seeprom-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-host-i2c-test'] : []) +              \
+  (config_all_devices.has_key('CONFIG_POWERNV') ? ['pnv-phb4-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['numa-test'] : []) +                      \
   (config_all_devices.has_key('CONFIG_PSERIES') ? ['rtas-test'] : []) +                      \
   (slirp.found() ? ['pxe-test'] : []) +              \
diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
new file mode 100644
index 0000000000..797f6b6c87
--- /dev/null
+++ b/tests/qtest/pnv-phb4-test.c
@@ -0,0 +1,98 @@
+/*
+ * QTest testcase for PowerNV PHB4
+ *
+ * Copyright (c) 2025, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "pnv-xscom.h"
+
+#define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
+#define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+
+#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
+#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
+
+/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
+#define PNV_P10_CHIP_INDEX      3
+#define PHB4_XSCOM              0x40084800ull
+
+/*
+ * Indirect XSCOM read::
+ * - Write 'Indirect Address Register' with register-offset to read.
+ * - Read 'Indirect Data Register' to get the value.
+ */
+static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
+        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
+        uint64_t reg)
+{
+    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_addr), reg);
+    return qtest_readq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_data));
+}
+
+/* Assert that 'PHB - Version Register' bits[24:31] are as expected */
+static void phb_version_test(const void *data)
+{
+    const PnvChip *chip = (PnvChip *)data;
+    QTestState *qts;
+    const char *machine = "powernv8";
+    uint64_t phb_xscom = 0x4809e000;
+    uint64_t reg_phb_version = PHB_VERSION;
+    uint32_t indirect_addr = PHB3_PBCQ_SPCI_ASB_ADDR;
+    uint32_t indirect_data = PHB3_PBCQ_SPCI_ASB_DATA;
+    uint32_t expected_ver = 0xA3;
+    uint64_t ver;
+
+    if (chip->chip_type == PNV_CHIP_POWER9) {
+        machine = "powernv9";
+        phb_xscom = 0x68084800;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA4;
+    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+        machine = "powernv10";
+        phb_xscom = PHB4_XSCOM;
+        indirect_addr = PHB_SCOM_HV_IND_ADDR;
+        indirect_data = PHB_SCOM_HV_IND_DATA;
+        reg_phb_version |= PPC_BIT(0);
+        expected_ver = 0xA5;
+    }
+
+    qts = qtest_initf("-M %s -accel tcg -cpu %s", machine, chip->cpu_model);
+
+    ver = pnv_phb_xscom_read(qts, chip, phb_xscom,
+                                indirect_addr, indirect_data, reg_phb_version);
+
+    /* PHB Version register bits [24:31] */
+    ver = ver >> (63 - 31);
+    g_assert_cmpuint(ver, ==, expected_ver);
+
+    qtest_quit(qts);
+}
+
+/* Verify versions of all supported PHB's */
+static void add_phbX_version_test(void)
+{
+    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        char *tname = g_strdup_printf("pnv-phb/%s",
+                                      pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], phb_version_test);
+        g_free(tname);
+    }
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    /* PHB[345] tests */
+    add_phbX_version_test();
+
+    return g_test_run();
+}
-- 
2.47.3


