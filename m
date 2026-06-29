Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DE8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 11:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we9nu-000409-KT; Mon, 29 Jun 2026 07:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1we9nd-0003nX-PB; Mon, 29 Jun 2026 07:05:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1we9nb-0002uA-Ez; Mon, 29 Jun 2026 07:05:13 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmYag3182095; Mon, 29 Jun 2026 11:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=3bHy0bjaJ+P+Q6EON
 1VYPG0VERhf+UUVuwCQJEFkrJs=; b=ppJiD5EswmDlnwxRNotJaOCqCKxXCffm0
 8MhcZzqgH/DsVPEsB5dJVOTd9uuzX58PnZ9sBIBOzi2P+IeS82baiQaQx07BVsv4
 XCuTt9P+lgAKK6ishzzE8A3w0ZkK9R/3MT7py7U5USrsdqn2DnOnM5n2mF0BgKcg
 w7EEnvUyMR2QDjioCKbzJ6IpVbbeoDnKnAoREhY90bCiOztrDdNjznIilB3GcJf8
 DuBLBHqjQaixdo3mRIHjLyo7+cTfFVy1CPR36YYdEP+jEVq2UQMZqVa1KJ6I+Ga/
 oewg+3q+dpFgB8aiSbSeOq8HGlEVJaO35Xu/vnLJ37tsa2WqOPmFA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfrvw5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:05:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4fdi001013;
 Mon, 29 Jun 2026 11:05:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7vw666-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 11:05:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TB52Or51184108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 11:05:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC8E920043;
 Mon, 29 Jun 2026 11:05:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C84820040;
 Mon, 29 Jun 2026 11:04:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown
 [9.123.10.203]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jun 2026 11:04:58 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 3/8] tests/qtest: Add Power11 chip & machine to qtests
Date: Mon, 29 Jun 2026 16:34:06 +0530
Message-ID: <20260629110411.3051274-4-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629110411.3051274-1-adityag@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a425164 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ecs4qFjb3cSJlp2yJ8oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX3bBj8pMoq/+v
 Q1RnWRCR8LR8otUXB3f0foajVLU9qzIuwZ5kkgKLf2+DAroDI/TcL7M13ZJC/7bIl0VinolB2/x
 SMGFpQYq5X6mXbRMMFYDNmKrpG11t9o=
X-Proofpoint-GUID: j66v-6MjuA8lFnjxklxNSbU6jbeD0MLL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX8bzEYXuu8o/h
 jVssvRimL6NoSglUasD9wuD10fHCXnKIyDjQmAa1+lwypwADiH+foY3+Y5JRxKtLLCl50UCPwqj
 2L2j3c5NYVJ4W0QE6ShrzPEBDbs4qi/ZMYbi+kHOb1fGIb/I9Hws1c6Vyl9+1IUN0l9EKiMLZ1q
 /ZeoSwW64ySJKaRp6M/PcKP1VLJeOuE8p6naBLMxn2M94ESxYic8BDs9AJIzBzMhVaO6x/yj2PW
 DbDGT2VW+L2msetioB+XkqlNVatvg1pl6yi8Hl3nSYIw8lcok/qhTElkBLzPJnaGiBxGw+jVJq0
 v0hVRM4LSxMyp86Q48svgLULqvsN4L224sM/sG71Uq973vaGrGq0+SrYKTint+5OuM3+5Qty1Nk
 jl4wIkuIIDa4C/f3CmCM1/BoPUeg5JcFjBWHKBO77iccjf730tv17g/PX2Hrz2Sl6pCP+Ewmd5n
 0zZ8WOK8nUfowV+0q+w==
X-Proofpoint-ORIG-GUID: 2OdOIM7OdOHNpybW8EDh2-jTKYAJQdPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Previously the machines/chips tested by qtest was till Power10, update
the tests to also test PowerNV11 and Power11 PNV Chip

Since if-else-if ladder was common pattern to get machine type,
implement pnv_get_machine_type so new processor cases can be implemented
in one location in pnv_get_machine_type

While at it, also add g_autofree to allocation by g_strdup_printf in
modified tests

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/pnv-host-i2c-test.c    | 10 ++++------
 tests/qtest/pnv-spi-seeprom-test.c |  2 +-
 tests/qtest/pnv-xive2-test.c       |  2 +-
 tests/qtest/pnv-xscom-test.c       | 22 +++++---------------
 tests/qtest/pnv-xscom.h            | 32 +++++++++++++++++++++++++++---
 5 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613ebdcb2..5fd54f9de771 100644
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
index 1a78e8d966a5..8bb30eb649aa 100644
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
index 5313d4ef18b7..80de9d09ed09 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -548,7 +548,7 @@ static void test_xive(void)
 {
     QTestState *qts;
 
-    qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
+    qts = qtest_initf("-M powernv11 -smp %d,cores=1,threads=%d -nographic "
                       "-nodefaults -serial mon:stdio -S "
                       "-d guest_errors -trace '*xive*'",
                       SMT, SMT);
diff --git a/tests/qtest/pnv-xscom-test.c b/tests/qtest/pnv-xscom-test.c
index c814c0f4f5b1..94b50c071c02 100644
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
 
diff --git a/tests/qtest/pnv-xscom.h b/tests/qtest/pnv-xscom.h
index 5aa1701ea768..eefe206a2007 100644
--- a/tests/qtest/pnv-xscom.h
+++ b/tests/qtest/pnv-xscom.h
@@ -9,6 +9,9 @@
 #ifndef PNV_XSCOM_H
 #define PNV_XSCOM_H
 
+#include <stdint.h>
+#include <assert.h>
+
 #define SMT                     4 /* some tests will break if less than 4 */
 
 typedef enum PnvChipType {
@@ -17,6 +20,7 @@ typedef enum PnvChipType {
     PNV_CHIP_POWER8NVL,   /* AKA Naples */
     PNV_CHIP_POWER9,      /* AKA Nimbus */
     PNV_CHIP_POWER10,
+    PNV_CHIP_POWER11,
 } PnvChipType;
 
 typedef struct PnvChip {
@@ -60,15 +64,23 @@ static const PnvChip pnv_chips[] = {
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
@@ -77,4 +89,18 @@ static inline uint64_t pnv_xscom_addr(const PnvChip *chip, uint32_t pcba)
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
-- 
2.54.0


