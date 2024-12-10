Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4886E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnmp-00062h-QH; Mon, 09 Dec 2024 19:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlY-0004mH-Q0; Mon, 09 Dec 2024 19:06:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlW-0001si-Bn; Mon, 09 Dec 2024 19:06:16 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IRkxV029271;
 Tue, 10 Dec 2024 00:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GxAZEvqUSVDXfwaxF
 Otl5iIcrjzT8kAiB8N4UyF7zeo=; b=q51w4ioWfaE+IxXGxo+vlRnYDZVDS2Wxc
 MDrPQFszJpJ1MJd1LWG4Bj/mQk3FgnWav7Q5GVgQxn0C93+v6pGaf7Etfabod8KR
 MYyO6on7lYmiSdKwtYIQn5vf0hW3SN5GuxVlmqDm+kcD4HD95ZtuTH2N9qAWefFH
 RrObPgWwuHkvcuc0yuLAKhevWGoX5AKWmZ1Js4pOHYkKL/1zAORmKu5+fNq7Ihbn
 /yE3HVVuvVd0IQmroG8g3fY2N9AE67xp4vzujZQuW/+9RlWOH0sYQnZdTKBMw04D
 86JWYzZxMglupB78lAKl8aZQL7hUVG/lR0jwrKk7g2lqoHwWrSEtQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vm6f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA067pU004302;
 Tue, 10 Dec 2024 00:06:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce1vm6f4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9K8bTp017364;
 Tue, 10 Dec 2024 00:06:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1gpb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA063ul63177060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:06:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 060F420043;
 Tue, 10 Dec 2024 00:06:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 34C8220040;
 Tue, 10 Dec 2024 00:06:01 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:06:01 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 07/14] qtest/xive: Add group-interrupt test
Date: Mon,  9 Dec 2024 18:05:16 -0600
Message-Id: <20241210000527.9541-14-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XhqY-aeMSlEMdM-S1cM5SSSOPVYq3O1X
X-Proofpoint-ORIG-GUID: fC3rF65lgqabruKJ19oDH0yqQ3HMPSGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090182
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Add XIVE2 tests for group interrupts and group interrupts that have
been backlogged.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 tests/qtest/pnv-xive2-test.c | 160 +++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index dd19e88861..a4d06550ee 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -2,6 +2,8 @@
  * QTest testcase for PowerNV 10 interrupt controller (xive2)
  *  - Test irq to hardware thread
  *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
+ *  - Test irq to hardware group
+ *  - Test irq to hardware group going through backlog
  *
  * Copyright (c) 2024, IBM Corporation.
  *
@@ -315,6 +317,158 @@ static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
     word2 = get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD2);
     g_assert_cmphex(xive_get_field32(TM_QW3W2_VT, word2), ==, 0);
 }
+
+static void test_hw_group_irq(QTestState *qts)
+{
+    uint32_t irq = 100;
+    uint32_t irq_data = 0xdeadbeef;
+    uint32_t end_index = 23;
+    uint32_t chosen_one;
+    uint32_t target_nvp = 0x81; /* group size = 4 */
+    uint8_t priority = 6;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr;
+
+    printf("# ============================================================\n");
+    printf("# Testing irq %d to hardware group of size 4\n", irq);
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, true /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    /* find the targeted vCPU */
+    for (chosen_one = 0; chosen_one < SMT; chosen_one++) {
+        reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+        nsr = reg32 >> 24;
+        if (nsr == 0x82) {
+            break;
+        }
+    }
+    g_assert_cmphex(chosen_one, <, SMT);
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, 0xFF);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, chosen_one, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+}
+
+static void test_hw_group_irq_backlog(QTestState *qts)
+{
+    uint32_t irq = 31;
+    uint32_t irq_data = 0x01234567;
+    uint32_t end_index = 129;
+    uint32_t target_nvp = 0x81; /* group size = 4 */
+    uint32_t chosen_one = 3;
+    uint8_t blocking_priority, priority = 3;
+    uint32_t reg32;
+    uint16_t reg16;
+    uint8_t pq, nsr, cppr, lsmfb, i;
+
+    printf("# ============================================================\n");
+    printf("# Testing irq %d to hardware group of size 4 going through " \
+           "backlog\n",
+           irq);
+
+    /*
+     * set current priority of all threads in the group to something
+     * higher than what we're about to trigger
+     */
+    blocking_priority = priority - 1;
+    for (i = 0; i < SMT; i++) {
+        set_tima8(qts, i, TM_QW3_HV_PHYS + TM_CPPR, blocking_priority);
+    }
+
+    /* irq config */
+    set_eas(qts, irq, end_index, irq_data);
+    set_end(qts, end_index, target_nvp, priority, true /* group */);
+
+    /* enable and trigger irq */
+    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
+    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
+
+    /* check irq is raised on cpu */
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_PENDING);
+
+    /* check no interrupt is pending on the 2 possible targets */
+    for (i = 0; i < SMT; i++) {
+        reg32 = get_tima32(qts, i, TM_QW3_HV_PHYS + TM_WORD0);
+        nsr = reg32 >> 24;
+        cppr = (reg32 >> 16) & 0xFF;
+        lsmfb = reg32 & 0xFF;
+        g_assert_cmphex(nsr, ==, 0x0);
+        g_assert_cmphex(cppr, ==, blocking_priority);
+        g_assert_cmphex(lsmfb, ==, priority);
+    }
+
+    /* lower priority of one thread */
+    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, priority + 1);
+
+    /* check backlogged interrupt is presented */
+    reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, priority + 1);
+
+    /* ack the irq */
+    reg16 = get_tima16(qts, chosen_one, TM_SPC_ACK_HV_REG);
+    nsr = reg16 >> 8;
+    cppr = reg16 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x82);
+    g_assert_cmphex(cppr, ==, priority);
+
+    /* check irq data is what was configured */
+    reg32 = qtest_readl(qts, xive_get_queue_addr(end_index));
+    g_assert_cmphex((reg32 & 0x7fffffff), ==, (irq_data & 0x7fffffff));
+
+    /* End Of Interrupt */
+    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
+    pq = get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
+    g_assert_cmpuint(pq, ==, XIVE_ESB_RESET);
+
+    /* reset CPPR */
+    set_tima8(qts, chosen_one, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
+    reg32 = get_tima32(qts, chosen_one, TM_QW3_HV_PHYS + TM_WORD0);
+    nsr = reg32 >> 24;
+    cppr = (reg32 >> 16) & 0xFF;
+    lsmfb = reg32 & 0xFF;
+    g_assert_cmphex(nsr, ==, 0x00);
+    g_assert_cmphex(cppr, ==, 0xFF);
+    g_assert_cmphex(lsmfb, ==, 0xFF);
+}
+
 static void test_xive(void)
 {
     QTestState *qts;
@@ -330,6 +484,12 @@ static void test_xive(void)
     /* omit reset_state here and use settings from test_hw_irq */
     test_pull_thread_ctx_to_odd_thread_cl(qts);
 
+    reset_state(qts);
+    test_hw_group_irq(qts);
+
+    reset_state(qts);
+    test_hw_group_irq_backlog(qts);
+
     reset_state(qts);
     test_flush_sync_inject(qts);
 
-- 
2.43.0


