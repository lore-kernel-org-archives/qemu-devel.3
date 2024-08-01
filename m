Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71573C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRd-0003Kk-MT; Thu, 01 Aug 2024 16:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRY-0003J7-Co; Thu, 01 Aug 2024 16:30:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRW-0007IH-CP; Thu, 01 Aug 2024 16:30:36 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471HthlI026105;
 Thu, 1 Aug 2024 20:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=6XK+9Ojm4/z4D
 n9UG7F4QU2mOgElDHkji8nqDgIVehs=; b=EITS3WCwovVIQFWrZalyF6HxDlB+O
 TaC8233xTA7caxjTE9Jmvi8SgIAjfByVdMlPX+AA8GJt7eq3Qg40kQgk+lNfsf/+
 Mj0brtyXPGsS0NaYfUwCpHsOXhS18ZsxLWSMmj1+uBmOINb+JL5oxLFA46zqAaor
 K8F0sJ/z2ImZnHiLJk1qLN2p6qTTA53FvO8aw0grvTCK/l4luu/5ngK0bM7c6UR4
 BuCfdiom+JpZxhLykpQtRxEi+wB+j2CXAxwJSxsToFytlKaP0ajEU11t5Rr91vLq
 nVcK701AutGxAWaJLebKqthOxngZwO2/u9d4zK9fkbyUE2UJq3ERoV4AQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdyhrg0g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:30 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUTO0025405;
 Thu, 1 Aug 2024 20:30:29 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdyhrg0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471JR5r7003935; Thu, 1 Aug 2024 20:30:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndemugh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUKY013304226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:22 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A1222004F;
 Thu,  1 Aug 2024 20:30:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DB8520040;
 Thu,  1 Aug 2024 20:30:19 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:19 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 01/13] pnv/xive: TIMA patch sets pre-req alignment and
 formatting changes
Date: Thu,  1 Aug 2024 15:29:56 -0500
Message-Id: <20240801203008.11224-2-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ryD13MTDFcyvv0qcbBTJq5eb296PL6gx
X-Proofpoint-ORIG-GUID: _Jf-Le3alvuXF_iLSVLBeCKrkYavYeLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=665 mlxscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Michael Kowal <kowal@linux.vnet.ibm.com>

Making some pre-requisite alignment changes ahead of the following patch
sets.  Making these changes now will ease the review of the patch sets.

Checkpatch wants the closing comment '*/' on a separate line, unless it is
on the same line as the starting comment '/*'.

There are also changes to prevent lines from spanning 80 columns.

Changed block of defines from:
   #define A 1  /* original define comment is not
                 * preferred, but not flagged... */
   #define B 2  /* Newly added define comment
                 * is flagged with a warning */
To:
   #define A 1  /* original define comment is */
                /* now fine, no warning...    */
   #define B 2  /* Newly added define comment */
                /* is fine...                 */

Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 include/hw/ppc/xive_regs.h | 32 ++++++++---------
 hw/intc/xive.c             | 72 +++++++++++++++++++++++++-------------
 2 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index b9db7abc2e..9d52d464d9 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -114,23 +114,23 @@
  * Then we have all these "special" CI ops at these offset that trigger
  * all sorts of side effects:
  */
-#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg*/
-#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg */
+#define TM_SPC_ACK_EBB          0x800   /* Load8 ack EBB to reg               */
+#define TM_SPC_ACK_OS_REG       0x810   /* Load16 ack OS irq to reg           */
 #define TM_SPC_PUSH_USR_CTX     0x808   /* Store32 Push/Validate user context */
-#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user
-                                         * context */
-#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit */
-#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS
-                                         * context to reg */
-#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool
-                                         * context to reg*/
-#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg */
-#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd
-                                         * line */
-#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line */
-#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even
-                                         * line */
-#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line */
+#define TM_SPC_PULL_USR_CTX     0x808   /* Load32 Pull/Invalidate user        */
+                                        /* context                            */
+#define TM_SPC_SET_OS_PENDING   0x812   /* Store8 Set OS irq pending bit      */
+#define TM_SPC_PULL_OS_CTX      0x818   /* Load32/Load64 Pull/Invalidate OS   */
+                                        /* context to reg                     */
+#define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
+                                        /* context to reg                     */
+#define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
+#define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
+                                        /* line                               */
+#define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
+#define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
+                                        /* line                               */
+#define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
 /* XXX more... */
 
 /* NSR fields for the various QW ack types */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5a02dd8e02..2fb38e2102 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -488,20 +488,32 @@ static const XiveTmOp xive_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,     4, xive_tm_push_os_ctx, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive_tm_push_os_ctx,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
+                                                     xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
+                                                     xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
+                                                     xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
+                                                     xive_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
+                                                     xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
+                                                     xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
+                                                     xive_tm_pull_pool_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -509,20 +521,32 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,   1, xive_tm_set_os_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,  4, xive2_tm_push_os_ctx, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR, 1, xive_tm_set_hv_cppr, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push, NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL, xive_tm_vt_poll },
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
+                                                     xive_tm_vt_poll },
 
     /* MMIOs above 2K : special operations with side effects */
-    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,     2, NULL, xive_tm_ack_os_reg },
-    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING, 1, xive_tm_set_os_pending, NULL },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    4, NULL, xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,    8, NULL, xive2_tm_pull_os_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,     2, NULL, xive_tm_ack_hv_reg },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  4, NULL, xive_tm_pull_pool_ctx },
-    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,  8, NULL, xive_tm_pull_pool_ctx },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
+                                                     xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
+                                                     NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, NULL,
+                                                     xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        8, NULL,
+                                                     xive2_tm_pull_os_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
+                                                     xive_tm_ack_hv_reg },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
+                                                     xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
+                                                     xive_tm_pull_pool_ctx },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
-- 
2.43.0


