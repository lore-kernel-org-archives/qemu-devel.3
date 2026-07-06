Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C3C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgedw-0004Me-Ga; Mon, 06 Jul 2026 04:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedb-0004H5-Uw
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wgedY-0007bB-UL
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 04:25:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665MK1552253170
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=t5D5LojTRkhsNV0Va
 cTwcO50oWidnyZRmMzprf1lVzc=; b=k7DvjZ+Ii3bghfgVMQyva04116e4hLwf5
 /512BG0Qo12IDKUtg1lQGF7kg/gmG22qgHMErzDEZfno7ZiGGmYFvgN4HwIRu6q3
 OeQ4kaZKU+Y8DmWnkmVFktCZz8JBvCB7neVhFtbuzXvcXbpOHamvcvgr+vgdOzTc
 0C2kzgC92Z/3YfGRVpX12bbIzzqbZp3Yobp63D8M/G0IMbTXHjMeNdYeriWCoUaU
 paN8w5E9iCDIXiC6Un4T4l3mEhHgRm7fm6KSLUe7nYCNAioBYNNqADCq3OibGf5v
 JsLPV+HNt+Zc/xuqZSfn4zi5Ua6qObG+YsfFqpRp1zy3EyE9RtDRw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8jsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:25:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6668JZah011023
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 08:25:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpvxj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 08:25:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6668P2qG29360602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 08:25:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80AF82004B;
 Mon,  6 Jul 2026 08:25:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 84EBA20043;
 Mon,  6 Jul 2026 08:25:01 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.1.190])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 08:25:01 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PULL 3/8] tests/qtest: Add Power11 chip & machine to qtests
Date: Mon,  6 Jul 2026 13:54:46 +0530
Message-ID: <20260706082451.59299-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706082451.59299-1-harshpb@linux.ibm.com>
References: <20260706082451.59299-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b6662 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jlYlrgOtAAFGYfj3CJAA:9
X-Proofpoint-GUID: grqyfWZmQiIctYLllpTyB_UK2kJgtb7t
X-Proofpoint-ORIG-GUID: grqyfWZmQiIctYLllpTyB_UK2kJgtb7t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX/Ol4EbnNxa37
 cQFyoPe1nXU6cH+ALr5ULLpBgRtkrbfCc05Ngo9sdGCIuZUbeNRKfaHN7U2FV0unySn3yO8vvCQ
 cZc6jZQt5KwmIE/vRDuyK4GG8GdcZWg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXxcV5LKf37/BE
 L7XWpvy/4ypOjIHOrZR0DApA3muxWRXYXnzrpafD1AhLuriZXnuj3PUjRoZ/P1sW4WbFpXvTt7D
 btaPOeesJNmPJ7p4Yhf7ggCBTQJskzAAk7km0NCag8bvofbT8pZgJ3IdDfXB279nYMQUi4ygRPS
 rSsUL+nAcPIijOKHydKs6DxZ45Skcah0B4KsQmBzSM6QtpyZ4lvMBqHiPwtRYJqSJ+iDQKtZIXb
 2UfH+gQygwkQTqZ0H3lXKOPF994kMM9/pFCzggtwnskA6GsNu0WY5xsxUFIaAkh2O610QJfmo3W
 dxXLE/yLTCYIOgA0f2eVSpBvIbEyZGgkpCSVax20xfMoP3CHmG3b9GLiftFfK226wWEYkezLTbr
 MM0YNLHBozcEpnWZXmR6vHZjQH/g75kiCdXlYzxj1K2HsdoqtaQ/gtPochGaSUceNvyZuBT18+D
 MRbIDDMqjSpb2lqckuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

Previously the machines/chips tested by qtest was till Power10, update
the tests to also test PowerNV11 and Power11 PNV Chip

Since if-else-if ladder was common pattern to get machine type,
implement pnv_get_machine_type so new processor cases can be implemented
in one location in pnv_get_machine_type

While at it, also add g_autofree to allocation by g_strdup_printf in
modified tests

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260703085955.2318600-4-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/qtest/pnv-xscom.h            | 29 ++++++++++++++++++++++++++---
 tests/qtest/pnv-host-i2c-test.c    | 10 ++++------
 tests/qtest/pnv-spi-seeprom-test.c |  2 +-
 tests/qtest/pnv-xive2-test.c       | 21 +++++++++++++++++----
 tests/qtest/pnv-xscom-test.c       | 22 +++++-----------------
 5 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 5aa1701ea7..8e882dac9d 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -17,6 +17,7 @@ typedef enum PnvChipType {
     PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
+    PNV_CHIP_POWER11,
 } PnvChipType;
 
 typedef struct PnvChip {
@@ -60,15 +61,23 @@ static const PnvChip pnv_chips[] = {
         .first_core = 0x0,
         .num_i2c    = 4,
     },
+    {
+        .chip_type  = PNV_CHIP_POWER11,
+        .cpu_model  = "Power11",
+        .xscom_base = 0x000603fc00000000ull,
+        .cfam_id    = 0x220da04980000000ull,
+        .first_core = 0x0,
+        .num_i2c    = 0,
+    },
 };
 
 static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
 {
     uint64_t addr = chip->xscom_base;
 
-    if (chip->chip_type == PNV_CHIP_POWER10) {
-        addr |= ((uint64_t) pcba << 3);
-    } else if (chip->chip_type == PNV_CHIP_POWER9) {
+    if ((chip->chip_type == PNV_CHIP_POWER11) ||
+        (chip->chip_type == PNV_CHIP_POWER10) ||
+        (chip->chip_type == PNV_CHIP_POWER9)) {
         addr |= ((uint64_t) pcba << 3);
     } else {
         addr |= (((uint64_t) pcba << 4) & ~0xffull) |
@@ -77,4 +86,18 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
     return addr;
 }
 
+static const char *pnv_get_machine_type(enum PnvChipType chip_type)
+{
+    static const char *const machine_types[] = {
+         [PNV_CHIP_POWER8]  = "powernv8",
+         [PNV_CHIP_POWER9]  = "powernv9",
+         [PNV_CHIP_POWER10] = "powernv10",
+         [PNV_CHIP_POWER11] = "powernv11",
+     };
+
+    g_assert(chip_type <= PNV_CHIP_POWER11);
+
+    return machine_types[chip_type];
+}
+
 #endif /* PNV_XSCOM_H */
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613ebdc..5fd54f9de7 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -402,15 +402,14 @@ static void reset_all(QTestState *qts, const PnvChip *chip)
 static void test_host_i2c(const void *data)
 {
     const PnvChip *chip = data;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
-    const char *machine = "powernv8";
     PnvI2cCtlr ctlr;
     PnvI2cDev pca9552;
     PnvI2cDev pca9554;
 
-    if (chip->chip_type == PNV_CHIP_POWER9) {
-        machine = "powernv9";
-    } else if (chip->chip_type == PNV_CHIP_POWER10) {
+    /* i2c is initialised for rainier in case of P10 */
+    if (chip->chip_type == PNV_CHIP_POWER10) {
         machine = "powernv10-rainier";
     }
 
@@ -473,10 +472,9 @@ static void add_test(const char *name, void (*test)(const void *data))
     int i;
 
     for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
-        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
+        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
                                       pnv_chips[i].cpu_model);
         qtest_add_data_func(tname, &pnv_chips[i], test);
-        g_free(tname);
     }
 }
 
diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-seeprom-test.c
index 1a78e8d966..8bb30eb649 100644
--- a/tests/qtest/pnv-spi-seeprom-test.c
+++ b/tests/qtest/pnv-spi-seeprom-test.c
@@ -77,7 +77,7 @@ static void test_spi_seeprom(const void *data)
     const PnvChip *chip = data;
     QTestState *qts = NULL;
     g_autofree char *tmp_path = NULL;
-    const char *machine = "powernv10";
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     int ret;
     int fd;
 
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 5313d4ef18..9f67a00668 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -14,6 +14,7 @@
 #include "libqtest.h"
 
 #include "pnv-xive2-common.h"
+#include "pnv-xscom.h"
 #include "hw/intc/pnv_xive2_regs.h"
 #include "hw/ppc/xive_regs.h"
 #include "hw/ppc/xive2_regs.h"
@@ -544,14 +545,16 @@ static void test_hw_group_irq_backlog(QTestState *qts)
     g_assert_cmphex(lsmfb, ==, 0xFF);
 }
 
-static void test_xive(void)
+static void test_xive(const void *data)
 {
+    const PnvChip *chip = data;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
 
-    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
+    qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
                       "-d guest_errors -trace '*xive*'",
-                      SMT, SMT);
+                      machine, SMT, SMT);
     init_xive(qts);
 
     test_hw_irq(qts);
@@ -580,6 +583,16 @@ static void test_xive(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
-    qtest_add_func("xive2", test_xive);
+
+    for (int i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
+        /* xive2 exists from Power10 onwards */
+        if (pnv_chips[i].chip_type < PNV_CHIP_POWER10) {
+            continue;
+        }
+
+        g_autofree char *tname = g_strdup_printf("pnv-xive2/%s",
+                pnv_chips[i].cpu_model);
+        qtest_add_data_func(tname, &pnv_chips[i], test_xive);
+    }
     return g_test_run();
 }
diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index c814c0f4f5..94b50c071c 100644
--- a/tests/qtest/pnv-xscom-test.c
+++ b/tests/qtest/pnv-xscom-test.c
@@ -28,15 +28,9 @@ static void test_xscom_cfam_id(QTestState *qts, const PnvChip *chip)
 static void test_cfam_id(const void *data)
 {
     const PnvChip *chip = data;
-    const char *machine = "powernv8";
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
 
-    if (chip->chip_type == PNV_CHIP_POWER9) {
-        machine = "powernv9";
-    } else if (chip->chip_type == PNV_CHIP_POWER10) {
-        machine = "powernv10";
-    }
-
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
                       machine, chip->cpu_model);
     test_xscom_cfam_id(qts, chip);
@@ -57,7 +51,8 @@ static void test_cfam_id(const void *data)
 
 static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 {
-    if (chip->chip_type == PNV_CHIP_POWER10) {
+    if ((chip->chip_type == PNV_CHIP_POWER10) ||
+        (chip->chip_type == PNV_CHIP_POWER11)) {
         uint32_t first_core_thread_state =
                  PNV_XSCOM_P10_EC_BASE(chip->first_core) + 0x412;
         uint64_t thread_state;
@@ -84,14 +79,8 @@ static void test_xscom_core(QTestState *qts, const PnvChip *chip)
 static void test_core(const void *data)
 {
     const PnvChip *chip = data;
+    const char *machine = pnv_get_machine_type(chip->chip_type);
     QTestState *qts;
-    const char *machine = "powernv8";
-
-    if (chip->chip_type == PNV_CHIP_POWER9) {
-        machine = "powernv9";
-    } else if (chip->chip_type == PNV_CHIP_POWER10) {
-        machine = "powernv10";
-    }
 
     qts = qtest_initf("-M %s -accel tcg -cpu %s",
                       machine, chip->cpu_model);
@@ -104,10 +93,9 @@ static void add_test(const char *name, void (*test)(const void *data))
     int i;
 
     for (i = 0; i < ARRAY_SIZE(pnv_chips); i++) {
-        char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
+        g_autofree char *tname = g_strdup_printf("pnv-xscom/%s/%s", name,
                                       pnv_chips[i].cpu_model);
         qtest_add_data_func(tname, &pnv_chips[i], test);
-        g_free(tname);
     }
 }
 
-- 
2.52.0


