Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83225FC6160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8zA-000647-HH; Fri, 13 Sep 2024 12:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8z3-0005qy-Nl; Fri, 13 Sep 2024 12:17:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8z1-0006jZ-NN; Fri, 13 Sep 2024 12:17:21 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBXKB014533;
 Fri, 13 Sep 2024 16:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 Ux3PaV9CR8zvtRb9DC4RrYkLwh3J7d329aJIVOBjfIM=; b=RoO7Cxhp0L3bNuK/
 jkkc+3zLQOtWbNmq+bplpPOP6lqZOnwwLCHl4FgMOaiOVHE6no6ynTP1dwXK6ET4
 qYfvrylYsR0F83EZOMDoXN2n+LtZarB15Gbu8w7K698wbpEfKtmg3M3VTnKALnDW
 c2YlCu2XQWHHVCFNycCgQSsAc7S0pZY1Ue1i02LoT74ItiiQqCSgfL7mZgDRBpWT
 StVaO6bjIUzMKYTgo+N0Rk5kRBa7HWtxch+5XnMvP7KWcLpY1HIptLcaCNlbGDVN
 rGtk/US0aQ5uRUJxIK66SIVfz7zZeLWd3b11HZYR2MMAHgSQqCo/uPpoFbLTq9wy
 3NCgWw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg02ybu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DGHGKM025182;
 Fri, 13 Sep 2024 16:17:16 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg02ybs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFX7N1013468;
 Fri, 13 Sep 2024 16:17:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cmq31g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DGHCW633882490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 16:17:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28D3E20040;
 Fri, 13 Sep 2024 16:17:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA3362004D;
 Fri, 13 Sep 2024 16:17:10 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 16:17:10 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 04/14] pnv/xive2: Support for "OS LGS Push" TIMA operation
Date: Fri, 13 Sep 2024 11:16:49 -0500
Message-Id: <20240913161659.1981-5-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240913161659.1981-1-kowal@linux.ibm.com>
References: <20240913161659.1981-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KGkuD86OCiW70dFiGcP34aLAhRqh13wy
X-Proofpoint-ORIG-GUID: 7DEEM57LA-BwOr-QXI_xaopyarMREGt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=978 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130113
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte writes to offset 0x15 of the TIMA address
space.  This offset holds the Logical Server Group Size (LGS) field.
The field is used to evenly distribute the interrupt load among the
members of a group, but is unused in the current implementation so we
just support the writing of the value for now.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8e62c7e75f..8605dd618f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -341,6 +341,19 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
     xive_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
 }
 
+static void xive_tctx_set_lgs(XiveTCTX *tctx, uint8_t ring, uint8_t lgs)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    regs[TM_LGS] = lgs;
+}
+
+static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
+}
+
 /*
  * Adjust the IPB to allow a CPU to process event queues of other
  * priorities during one physical interrupt cycle.
@@ -525,6 +538,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
+                                                     NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
-- 
2.43.0


