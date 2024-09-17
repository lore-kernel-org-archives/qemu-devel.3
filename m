Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E17CAC595
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 18:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqdEy-0001zF-05; Tue, 17 Sep 2024 14:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sqdEv-0001wj-JW; Tue, 17 Sep 2024 14:47:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_mathbern@quicinc.com>)
 id 1sqdEt-0006pc-K6; Tue, 17 Sep 2024 14:47:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HGHHDY003273;
 Tue, 17 Sep 2024 18:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gvs7LqF+xtFGfN6thtTWry
 siI/92KfpTLHMHjZtddRg=; b=FMb02qzJ/8mmZtWJjoSjvX4B+Mj6M5tujdGDah
 jheK04Qkk39N0SxErgq2GptOkudDeMDMgPC11EKzf6c8A+RC8SXEUW7Qu2Wz6Qsj
 yEYp636/IOSF6gG2pr77lyFjmgCtmfhNHAhnz5bMo53GTbBngef5spNydjSl38+w
 m7c7jNtmKyBSzMPJUiHfNh28kXE8pE5vHekWFPZCOyNqrlBG8RmOp8o2LCdENdBs
 2po4gGaWZACqXro9UUPC+dCAEA/iISKL/jaRKUCI7w4MFuLCYFny88nzp+q7LIOW
 z1B/buJC9pLbYwkyW8uflvM23tIa4S6MnxzNcpWVQqQMcqJw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jhqtve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 18:47:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HIlc6q009775
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Sep 2024 18:47:38 GMT
Received: from hu-mathbern-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Sep 2024 11:47:38 -0700
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <balaton@eik.bme.hu>, <mst@redhat.com>, <bcain@quicinc.com>,
 <qemu-trivial@nongnu.org>
Subject: [PATCH] hw: fix memory leak in IRQState allocation
Date: Tue, 17 Sep 2024 15:47:28 -0300
Message-ID: <6f0b480e1f0fbeb9550d447dcbeda920f1869d2d.1726598846.git.quic_mathbern@quicinc.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 09_5WzyaVgyuJS2giFnFeESq81pqY2EO
X-Proofpoint-GUID: 09_5WzyaVgyuJS2giFnFeESq81pqY2EO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1011 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=884 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_mathbern@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

At e72a7f65c1 (hw: Move declaration of IRQState to header and add init
function, 2024-06-29), we've changed qemu_allocate_irq() to use a
combination of g_new() + object_initialize() instead of
IRQ(object_new()). The latter sets obj->free, so that that the memory is
properly cleaned when the object is finalized, but the former doesn't.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 hw/core/irq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index db95ffc18f..7d80de1ca6 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -34,13 +34,19 @@ void qemu_set_irq(qemu_irq irq, int level)
     irq->handler(irq->opaque, irq->n, level);
 }
 
+static void qemu_init_irq_fields(IRQState *irq, qemu_irq_handler handler,
+                                 void *opaque, int n)
+{
+    irq->handler = handler;
+    irq->opaque = opaque;
+    irq->n = n;
+}
+
 void qemu_init_irq(IRQState *irq, qemu_irq_handler handler, void *opaque,
                    int n)
 {
     object_initialize(irq, sizeof(*irq), TYPE_IRQ);
-    irq->handler = handler;
-    irq->opaque = opaque;
-    irq->n = n;
+    qemu_init_irq_fields(irq, handler, opaque, n);
 }
 
 qemu_irq *qemu_extend_irqs(qemu_irq *old, int n_old, qemu_irq_handler handler,
@@ -66,11 +72,8 @@ qemu_irq *qemu_allocate_irqs(qemu_irq_handler handler, void *opaque, int n)
 
 qemu_irq qemu_allocate_irq(qemu_irq_handler handler, void *opaque, int n)
 {
-    IRQState *irq;
-
-    irq = g_new(IRQState, 1);
-    qemu_init_irq(irq, handler, opaque, n);
-
+    IRQState *irq = IRQ(object_new(TYPE_IRQ));
+    qemu_init_irq_fields(irq, handler, opaque, n);
     return irq;
 }
 
-- 
2.37.2


