Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC7BEEE262
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 20:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmg-0004U7-Q8; Thu, 12 Sep 2024 16:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmc-0004D4-RP; Thu, 12 Sep 2024 16:51:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmT-0007C9-Pg; Thu, 12 Sep 2024 16:51:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CDDURg023476;
 Thu, 12 Sep 2024 20:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 +3ppw8BFBE3S4nBdj6OXMry882xwu7Lbt9mBUyQU5+4=; b=KTZpdR+OItvHU8h4
 yQ/wkfueJMrxRdCdo0V9R3dcZu6qK8AyDNG3glb6mgleS61t1P2sSEN9K4Xno54Y
 qaQafcr1Tl4wU3RVS1qM30TPoibovJCKKFhp7ehC3o9XUvwQSr6dGkobIvaEg6h8
 j6ZHLFTl0NSUDrgWo8WjRbR06WwiS4iWBkJHrKAWlDOScxH92NVLs9PpD2eo5/LG
 nSon552UezSrzHbmgumnyn1yHE6PguYD43/H1RgFb8rzlEn8rMjyPEXpDLGOoJde
 jUg/Ew4J+OSTY7hjzdMuQJdFvM3quBQs3SMlspRPUvq4ZuOPdcFQRQ7fjhSXLGN4
 mrdA2A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qpacy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:51:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKovI3002090;
 Thu, 12 Sep 2024 20:51:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qpacv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:51:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIdxb8032103;
 Thu, 12 Sep 2024 20:51:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nn278n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:51:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKouaQ49545550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 850BA20049;
 Thu, 12 Sep 2024 20:50:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5546720040;
 Thu, 12 Sep 2024 20:50:55 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:55 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 14/14] pnv/xive2: TIMA CI ops using alternative offsets or
 byte lengths
Date: Thu, 12 Sep 2024 15:50:28 -0500
Message-Id: <20240912205028.15854-15-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ENpQfp9nKZkLPT5RplqnmdCgJ2YVDjcH
X-Proofpoint-ORIG-GUID: QjXR6UPx5-uMSE4ElM36qIpWi0WYnQL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=937 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
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
index 3ce86b6895..efcb63e8aa 100644
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


