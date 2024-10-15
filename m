Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69D2D1D876
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0osC-000532-UH; Tue, 15 Oct 2024 17:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os8-0004vL-4x; Tue, 15 Oct 2024 17:14:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0os6-0000RR-Bt; Tue, 15 Oct 2024 17:14:27 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJu6eT002682;
 Tue, 15 Oct 2024 21:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/DBhHEQue6m2kIXKt
 c0Fa1uIdhy1To8+56w5CU0nnME=; b=LQYrFXq6JsaS7dCc9YdWo/0yR03aKChHU
 exhg/rO3isQF8JfO/DOrzZzaQWnzuaVxp2GY4mPFB7ik6ChPgbcLhi0YieLztvb1
 I2fkRy+SmnEHAykOzJ2iOGmumTbnT+x6oPWTwu57SRLN+++zcbLKF5/2phyRvOPu
 PkiJEA+Fk935WIJqTc0mDYHGtYxAQIQwdmI1PlRPpzRgaN9+JfNOPPICmrIrb1T3
 c+7RS2s93d1LIwJgo3tQRdAazGoljPbGMkJq3BSjN8SNfxjIvW4pp6Ew4mgB6sKa
 2K4cz1OI15/DaWrIfZrwuYE6Kk+vOa519GZHXlOLYqSLC58tANK0g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429xywr91e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLAPOQ022718;
 Tue, 15 Oct 2024 21:14:15 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429xywr918-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJ0oRu005965;
 Tue, 15 Oct 2024 21:14:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650wkyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:14:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLEBKC42860908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:14:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C4532004D;
 Tue, 15 Oct 2024 21:14:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E652820043;
 Tue, 15 Oct 2024 21:14:08 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:14:08 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 14/14] qtest/xive: Add test of pool interrupts
Date: Tue, 15 Oct 2024 16:13:29 -0500
Message-Id: <20241015211329.21113-15-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nsSDH1Wg4HClfMbo-wb4QEMI2M55dGoO
X-Proofpoint-GUID: 4bNBXyqOAiAh2UuLhkasw9hAsQEGk6pz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Added new test for pool interrupts.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 tests/qtest/pnv-xive2-test.c | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index a6008bc053..6e7e7f0d9b 100644
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
@@ -267,6 +268,79 @@ static void test_hw_irq(QTestState *qts)
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
+    printf("# ============================================================\n");
+    printf("# Testing irq %d to pool thread %d\n", irq, target_pir);
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
@@ -485,6 +559,9 @@ static void test_xive(void)
     /* omit reset_state here and use settings from test_hw_irq */
     test_pull_thread_ctx_to_odd_thread_cl(qts);
 
+    reset_state(qts);
+    test_pool_irq(qts);
+
     reset_state(qts);
     test_hw_group_irq(qts);
 
-- 
2.43.0


