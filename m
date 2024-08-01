Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2185C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRm-0003pY-MG; Thu, 01 Aug 2024 16:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRe-0003NI-SS; Thu, 01 Aug 2024 16:30:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRc-0007Kq-HE; Thu, 01 Aug 2024 16:30:42 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471GWYpc013709;
 Thu, 1 Aug 2024 20:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=V08NEzerWk16B
 BS+hYADCIvtwu0yt3DnNc0/ruz/kWg=; b=QcRcrfPHoM6lOE/rI8TDlMAHVSmUi
 UqlusXBJeK99veCz2pyYeA42rYe304B0vJvJjIeQQ7DmRWdMXMCzopzJX/Q87JLC
 E4AD95ybGeNZ1RRn23tkURnpMVIerz1etIB+Buimm0Ilx1oG0pOcyoO98HVmdtgB
 sAjOh+eTPYac2tsr+Kvz/JL45D8Wy2ATwz52kpvgSUpZsFSfA8sHMdRPAiZ7Jhpe
 fwka7draMgpaPi3j6RcFi6Sg4IECSMVFgZh1qmKB84vhtmtQ+o5ZpU6jgxs9iedf
 jYJMUXf5cA1ugBkG6PppdoJ2eCdcoWSUF24i/6W3CLBeB9yVe7lYKJKtg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdyhrg16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:37 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUbJC025759;
 Thu, 1 Aug 2024 20:30:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rdyhrg14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471Hf2VZ029103; Thu, 1 Aug 2024 20:30:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm13wvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUU5057344326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0AAC20040;
 Thu,  1 Aug 2024 20:30:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 870382004B;
 Thu,  1 Aug 2024 20:30:29 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:29 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 08/13] ppc/xive2: Support "Pull Thread Context to Register"
 operation
Date: Thu,  1 Aug 2024 15:30:03 -0500
Message-Id: <20240801203008.11224-9-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jEx9j-qqkTiekvQzXxUU410UxZ7uzNB6
X-Proofpoint-ORIG-GUID: uDo-kDs9C9NW8kevDIfBpps0SZHzMPM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 clxscore=1015
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte read of offset 0x838 of the TIMA address
space.  According to the XIVE2 Specification, this causes the hardware
to atomically:
  1. Read the number of bytes requested (lbz or lhz are supported).
  2. Reset the valid bit of the thread context.
  3. Return the number of bytes requested in step 1 to a register.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive_regs.h |  2 ++
 hw/intc/xive.c             | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index f8f05deafd..558a5ae742 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -101,6 +101,7 @@
 #define   TM_QW3W2_LP           PPC_BIT32(6)
 #define   TM_QW3W2_LE           PPC_BIT32(7)
 #define   TM_QW3W2_T            PPC_BIT32(31)
+#define   TM_QW3B8_VT           PPC_BIT8(0)
 
 /*
  * In addition to normal loads to "peek" and writes (only when invalid)
@@ -128,6 +129,7 @@
 #define TM_SPC_PULL_POOL_CTX    0x828   /* Load32/Load64 Pull/Invalidate Pool */
                                         /* context to reg                     */
 #define TM_SPC_ACK_HV_REG       0x830   /* Load16 ack HV irq to reg           */
+#define TM_SPC_PULL_PHYS_CTX    0x838   /* Pull phys ctx to reg               */
 #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
                                         /* line                               */
 #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6229a6f870..5b66a3aec5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -179,6 +179,17 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return qw2w2;
 }
 
+static uint64_t xive_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                      hwaddr offset, unsigned size)
+{
+    uint8_t qw3b8_prev = tctx->regs[TM_QW3_HV_PHYS + TM_WORD2];
+    uint8_t qw3b8;
+
+    qw3b8 = qw3b8_prev & ~TM_QW3B8_VT;
+    tctx->regs[TM_QW3_HV_PHYS + TM_WORD2] = qw3b8;
+    return qw3b8;
+}
+
 static void xive_tm_vt_push(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                             uint64_t value, unsigned size)
 {
@@ -527,6 +538,8 @@ static const XiveTmOp xive_tm_operations[] = {
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
                                                      xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
+                                                     xive_tm_pull_phys_ctx },
 };
 
 static const XiveTmOp xive2_tm_operations[] = {
@@ -566,6 +579,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
+                                                     xive_tm_pull_phys_ctx },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
-- 
2.43.0


