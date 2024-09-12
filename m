Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527C6EEE262
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 20:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmQ-0003Rc-Mi; Thu, 12 Sep 2024 16:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmO-0003KO-K0; Thu, 12 Sep 2024 16:51:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmM-0007Av-TG; Thu, 12 Sep 2024 16:51:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CBXhKa020293;
 Thu, 12 Sep 2024 20:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 6xZiUYVlSV2LODCEsKOf1wxf3QQ4WQ/QUPGd67HsvBk=; b=lVn7DXlNShbqGYV2
 PsQtKhFoEKy/fAtV4b3puzZ+jBwyWOEhFXRkmGMIvrjhTpBabVOfc9C0VMopQY9T
 YeqLCXAShYaXqlL5tj/hRWkzGjJqHMcH748ptOuk0bZZOvDNNDwrSBPXtWu8YBJb
 HwF98wTEuFvO8Yq99sPsuvHNYS+oGOY8q1mtmiGGlKpUz1pbGuOiVzN1vpMClBmR
 mo0iFMi6vNLI++YfjAGqZS5EKpv7XAPn96JC0XNxuDLm5neQ7OaSbK3bdpVsUUOI
 8pFB3gSwr/RVgNsBz+LtalaIVJapfbZa0+2hzFoSxe5IEH39giPEMzwXyvNvRwRQ
 61fQaw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebap3fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKoqF3004620;
 Thu, 12 Sep 2024 20:50:52 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebap3fc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CKcGFj003130;
 Thu, 12 Sep 2024 20:50:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15uaf5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKolWB51249558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E31B20049;
 Thu, 12 Sep 2024 20:50:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EB7120040;
 Thu, 12 Sep 2024 20:50:46 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:46 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 08/14] ppc/xive2: Support "Pull Thread Context to Register"
 operation
Date: Thu, 12 Sep 2024 15:50:22 -0500
Message-Id: <20240912205028.15854-9-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LzZYuOHqmpJ4K6NVe1oHxha7i3zMRZ3q
X-Proofpoint-GUID: h4VYMHmoO02AG-T8ERQ3D43R4_GAx-xM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120149
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte read of offset 0x838 of the TIMA address
space.  According to the XIVE2 Specification, this causes the hardware
to atomically:
  1. Read the number of bytes requested (lbz or lhz are supported).
  2. Reset the valid bit of the thread context.
  3. Return the number of bytes requested in step 1 to a register.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


