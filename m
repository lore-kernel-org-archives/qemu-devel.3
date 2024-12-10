Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0022CE7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKno1-0008Aj-3Y; Mon, 09 Dec 2024 19:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlw-0004r3-G5; Mon, 09 Dec 2024 19:06:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlu-0001yk-KK; Mon, 09 Dec 2024 19:06:40 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9G2qaW014258;
 Tue, 10 Dec 2024 00:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=FJjn7cZHCSjxChF3r
 7xIh9CQMabXawtmRr5/Tjzq6ZQ=; b=f6J+FBo0eKeheBAujA5AVeglQ+qHO7whd
 K2PIkhm/JbRxCT085YF+8gd2mC8AIwg73AXmNTEX7fB41G8iq6FHENJPTfVvGMO9
 d7upe1DO6W5TMgEJcnLMOSFCh/DqbK274Vn8MRMwxU/ZxMvZry3RbOvcGqZpf/lr
 Y/wNMRihTVPBAZQjhL5Wu/Ep7U99DTdp/15w23qNM763NNrlUnJUx5f/AXD4Ix+z
 RyBB5rhM8ccLC/jbAO6jgGdeClbzls+75VP5Iad2kMiU9ntRxMQkqgckSwjGnLA5
 ag22l7h6mjWY0Pv2zshNmNwlSGyP04KotzjR2duyUTGAcGpTBHvTg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb5jr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA06Uh8004354;
 Tue, 10 Dec 2024 00:06:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb5jm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9MD5P0016919;
 Tue, 10 Dec 2024 00:06:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y16ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA06QiS51511600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:06:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 163782004D;
 Tue, 10 Dec 2024 00:06:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A26620043;
 Tue, 10 Dec 2024 00:06:24 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:06:24 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 14/14] qtest/xive: Add test of pool interrupts
Date: Mon,  9 Dec 2024 18:05:27 -0600
Message-Id: <20241210000527.9541-25-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pb5FGsVnF6lqB_Yfpr6ejep4hN--BDtW
X-Proofpoint-ORIG-GUID: RHccktp41U6j0moEiNUXd-Fckw78cRKX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.ibm.com>

Added new test for pool interrupts.  Removed all printfs from pnv-xive2-* qtests.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 tests/qtest/pnv-xive2-flush-sync.c |  6 +-
 tests/qtest/pnv-xive2-nvpg_bar.c   |  7 +--
 tests/qtest/pnv-xive2-test.c       | 98 +++++++++++++++++++++++++++---
 3 files changed, 94 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/pnv-xive2-flush-sync.c b/tests/qtest/pnv-xive2-flush-sync.c
index 3b32446adb..142826bad0 100644
--- a/tests/qtest/pnv-xive2-flush-sync.c
+++ b/tests/qtest/pnv-xive2-flush-sync.c
@@ -178,14 +178,14 @@ void test_flush_sync_inject(QTestState *qts)
     int test_nr;
     uint8_t byte;
 
-    printf("# ============================================================\n");
-    printf("# Starting cache flush/queue sync injection tests...\n");
+    g_test_message("=========================================================");
+    g_test_message("Starting cache flush/queue sync injection tests...");
 
     for (test_nr = 0; test_nr < sizeof(xive_inject_tests);
          test_nr++) {
         int op_type = xive_inject_tests[test_nr];
 
-        printf("# Running test %d\n", test_nr);
+        g_test_message("Running test %d", test_nr);
 
         /* start with status byte set to 0 */
         clr_sync(qts, src_pir, ic_topo_id, op_type);
diff --git a/tests/qtest/pnv-xive2-nvpg_bar.c b/tests/qtest/pnv-xive2-nvpg_bar.c
index 10d4962d1e..8481a70f22 100644
--- a/tests/qtest/pnv-xive2-nvpg_bar.c
+++ b/tests/qtest/pnv-xive2-nvpg_bar.c
@@ -4,8 +4,7 @@
  *
  * Copyright (c) 2024, IBM Corporation.
  *
- * This work is licensed under the terms of the GNU GPL, version 2 or
- * later. See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 #include "libqtest.h"
@@ -78,8 +77,8 @@ void test_nvpg_bar(QTestState *qts)
     uint32_t count, delta;
     uint8_t i;
 
-    printf("# ============================================================\n");
-    printf("# Testing NVPG BAR operations\n");
+    g_test_message("=========================================================");
+    g_test_message("Testing NVPG BAR operations");
 
     set_nvg(qts, group_target, 0);
     set_nvp(qts, nvp_target, 0x04);
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index a0e9f19313..5313d4ef18 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -4,6 +4,7 @@
  *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
  *  - Test irq to hardware group
  *  - Test irq to hardware group going through backlog
+ *  - Test irq to pool thread
  *
  * Copyright (c) 2024, IBM Corporation.
  *
@@ -220,8 +221,8 @@ static void test_hw_irq(QTestState *qts)
     uint16_t reg16;
     uint8_t pq, nsr, cppr;
 
-    printf("# ============================================================\n");
-    printf("# Testing irq %d to hardware thread %d\n", irq, target_pir);
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to hardware thread %d", irq, target_pir);
 
     /* irq config */
     set_eas(qts, irq, end_index, irq_data);
@@ -266,6 +267,79 @@ static void test_hw_irq(QTestState *qts)
     g_assert_cmphex(cppr, ==, 0xFF);
 }
 
+static void test_pool_irq(QTestState *qts)
+{
+    uint32_t irq = 2;
+    uint32_t irq_data = 0x600d0d06;
+    uint32_t end_index = 5;
+    uint32_t target_pir = 1;
+    uint32_t target_nvp = 0x100 + target_pir;
+    uint8_t priority = 5;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr, ipb;
+
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to pool thread %d", irq, target_pir);
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, false /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    /* check TIMA values in the PHYS ring (shared by POOL ring) */
+    reg32 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x40);
+    g_assert_cmphex(cppr, ==, 0xFF);
+
+    /* check TIMA values in the POOL ring */
+    reg32 = get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    ipb = (reg32 >> 8) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0);
+    g_assert_cmphex(cppr, ==, 0);
+    g_assert_cmphex(ipb, ==, 0x80 >> priority);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, target_pir, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x40);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* check IPB is cleared in the POOL ring */
+    reg32 = get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD0);
+    ipb = (reg32 >> 8) & 0xFF;
+    g_assert_cmphex(ipb, ==, 0);
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, target_pir, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+}
+
 #define XIVE_ODD_CL 0x80
 static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
 {
@@ -278,8 +352,9 @@ static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
     uint32_t cl_word;
     uint32_t word2;
 
-    printf("# ============================================================\n");
-    printf("# Testing 'Pull Thread Context to Odd Thread Reporting Line'\n");
+    g_test_message("=========================================================");
+    g_test_message("Testing 'Pull Thread Context to Odd Thread Reporting " \
+                   "Line'");
 
     /* clear odd cache line prior to pull operation */
     memset(cl_pair, 0, sizeof(cl_pair));
@@ -330,8 +405,8 @@ static void test_hw_group_irq(QTestState *qts)
     uint16_t reg16;
     uint8_t pq, nsr, cppr;
 
-    printf("# ============================================================\n");
-    printf("# Testing irq %d to hardware group of size 4\n", irq);
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to hardware group of size 4", irq);
 
     /* irq config */
     set_eas(qts, irq, end_index, irq_data);
@@ -395,10 +470,10 @@ static void test_hw_group_irq_backlog(QTestState *qts)
     uint16_t reg16;
     uint8_t pq, nsr, cppr, lsmfb, i;
 
-    printf("# ============================================================\n");
-    printf("# Testing irq %d to hardware group of size 4 going through " \
-           "backlog\n",
-           irq);
+    g_test_message("=========================================================");
+    g_test_message("Testing irq %d to hardware group of size 4 going " \
+                   "through backlog",
+                   irq);
 
     /*
      * set current priority of all threads in the group to something
@@ -484,6 +559,9 @@ static void test_xive(void)
     /* omit reset_state here and use settings from test_hw_irq */
     test_pull_thread_ctx_to_odd_thread_cl(qts);
 
+    reset_state(qts);
+    test_pool_irq(qts);
+
     reset_state(qts);
     test_hw_group_irq(qts);
 
-- 
2.43.0


