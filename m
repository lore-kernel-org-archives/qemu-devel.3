Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF74C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRz-0004gU-OY; Thu, 01 Aug 2024 16:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRo-0003zF-Eu; Thu, 01 Aug 2024 16:30:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRl-0007Qb-Oj; Thu, 01 Aug 2024 16:30:51 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471GS97i012740;
 Thu, 1 Aug 2024 20:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=ehhl7J81G7M63
 GY3mmNPdgOePkqV1Qktx280p73mefg=; b=ZNejcX4zriSGdAae5j5829i9E3SA3
 TQ72Y0J6JAD3UPe9Ry1YmyES40j8G6JnFeo8x3naQqKzY5a8EmKAmPs/XemXC7jV
 2Pz3JPvCeyIj2vIlaflZh5WDiCqNv7RYVUSU4iHlf41+M6Lu+RN6F9IjGKdDZG82
 UPpHQK9WIUPwy2mv5Oe0aoYvzKRv7unR3RdL7ihDOM/yy7KFQ/sXZbCb2Hvec26E
 BgMqbD/0C7sSTDbj1H0zLcVdZ9D2rSjZk6nC2LwZwnFXTTcS3RMSHW8dFugfTTIo
 31EcZUWFxat+NXQeXbZ3+maqaEr1Mq74tY5OgfIl1F9LmoDSbzUPieSzg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdfkghpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:45 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUjrC003483;
 Thu, 1 Aug 2024 20:30:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdfkghpr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471JKLGZ011155; Thu, 1 Aug 2024 20:30:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn3pdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUc5M21758426
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F05882004D;
 Thu,  1 Aug 2024 20:30:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C609520043;
 Thu,  1 Aug 2024 20:30:36 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:36 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 13/13] pnv/xive2: TIMA CI ops using alternative offsets or
 byte lengths
Date: Thu,  1 Aug 2024 15:30:08 -0500
Message-Id: <20240801203008.11224-14-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IFb_miJeVCYAeoKdahdSQxbsSgyzAQr0
X-Proofpoint-ORIG-GUID: BvYTY1uzPYWx9F3GdvhJzHei8T1UyTOF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=951 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Some of the TIMA Special CI operations perform the same operation at
alternative byte offsets and lengths.  The following
xive2_tm_opertions[] table entries are missing when they exist for
other offsets/sizes and have been added:
- lwz@0x810 Pull/Invalidate O/S Context to register    added
  lwz@0x818                                            exists
  ld @0x818                                            exists
- lwz@0x820 Pull Pool Context to register              added
  lwz@0x828                                            exists
  ld @0x828                                            exists
- lwz@0x830 Pull Thread Context to register            added
  lbz@0x838                                            exists

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive_regs.h | 7 ++++++-
 hw/intc/xive.c             | 6 ++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 5b11463777..326327fc79 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -124,12 +124,17 @@
 #define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
                                         /* context                            */
 #define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
+#define TM_SPC_PULL_OS_CTX_G2   0x810   /* Load32/Load64 Pull/Invalidate OS   */
+                                        /* context to reg                     */
 #define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
                                         /* context to reg                     */
+#define TM_SPC_PULL_POOL_CTX_G2 0x820   /* Load32/Load64 Pull/Invalidate Pool */
+                                        /* context to reg                     */
 #define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
                                         /* context to reg                     */
 #define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
-#define TM_SPC_PULL_PHYS_CTX    0x838   /* Pull phys ctx to reg               */
+#define TM_SPC_PULL_PHYS_CTX_G2 0x830   /* Load32 Pull phys ctx to reg        */
+#define TM_SPC_PULL_PHYS_CTX    0x838   /* Load8  Pull phys ctx to reg        */
 #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
                                         /* line                               */
 #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 99c8bea598..ce1504fbed 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -614,18 +614,24 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_ack_os_reg },
     { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
+                                                     xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
                                                      xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
                                                      xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
                                                      xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
+                                                     xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
+                                                     xive_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
                                                      xive_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
-- 
2.43.0


