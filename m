Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F679ECE58A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlfS-00023L-SM; Mon, 09 Sep 2024 17:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlfK-0001T8-Lv; Mon, 09 Sep 2024 17:11:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlfH-00028e-NH; Mon, 09 Sep 2024 17:11:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489FO60x030495;
 Mon, 9 Sep 2024 21:11:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=TGEztAJvYx4sH
 JAczFOs/vtxKNE34WhVDHZCWqCPhI0=; b=N1x8HjLBX2Zj3PcVYmC63BebQ3r5j
 MfJRGNh14CREdVYGMHA3OpMd5RU9Rkm31vBbyTXetBoZ7vIfScEL6H6N0oR8j7+6
 IUnkJRZYZGxI7JwGV7k22qlsRchDr3jpZ7GkTwy9hzYsJSUvJQSEsDp+R8Fc1Isz
 lnzIxuTtSKJunyuAvEflriaidPqU06ZEYzKjeyJi6RbtrFB+TioTiEytLT1YdzMc
 07yMaHIPF+59lAGGxsFpWfPO9m41L4n31qSdYr3pCdB5j8BKiLUqWzowIAdrsrEj
 mfmBkAEjfuzgtDfj8zte3kbE3X093YHvvRQYrZDrxr1nCoBu568JdCVSQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kc36t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489L8TBO028290;
 Mon, 9 Sep 2024 21:11:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kc36s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489Il2PR032415;
 Mon, 9 Sep 2024 21:11:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0gdq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489LB1SB11141514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 21:11:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D9BF20040;
 Mon,  9 Sep 2024 21:11:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6113E20049;
 Mon,  9 Sep 2024 21:11:00 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 21:11:00 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 10/14] ppc/xive2: Support "Pull Thread Context to Odd
 Thread Reporting Line"
Date: Mon,  9 Sep 2024 16:10:34 -0500
Message-Id: <20240909211038.27440-11-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909211038.27440-1-kowal@linux.ibm.com>
References: <20240909211038.27440-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xo1lPYalvwu06WHo9D4xa_WBzwMYwE3Y
X-Proofpoint-ORIG-GUID: lTJX7v1_6hZ9UYOTyzdVelxrfSH1cG3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090166
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Adds support for single byte writes to offset 0xC38 of the TIMA address
space.  When this offset is written to, the hardware disables the thread
context and copies the current state information to the odd cache line of
the pair specified by the NVT structure indexed by the THREAD CAM entry.

Note that this operation is almost identical to what we are already doing
for the "Pull OS Context to Odd Thread Reporting Line" operation except
that it also invalidates the Pool and Thread Contexts.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h      |  2 ++
 include/hw/ppc/xive2_regs.h | 16 +++++++++-------
 include/hw/ppc/xive_regs.h  |  1 +
 hw/intc/xive.c              |  9 +++++----
 hw/intc/xive2.c             | 12 +++++++++---
 5 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 36bd0e747f..5bccf41159 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -123,5 +123,7 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 99840e88a8..1d00c8df64 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -19,16 +19,18 @@
  * mode (P10), the CAM line is slightly different as the VP space was
  * increased.
  */
-#define   TM2_QW0W2_VU           PPC_BIT32(0)
+#define   TM2_W2_VALID           PPC_BIT32(0)
+#define   TM2_W2_HW              PPC_BIT32(1)
+#define   TM2_QW0W2_VU           TM2_W2_VALID
 #define   TM2_QW0W2_LOGIC_SERV   PPC_BITMASK32(4, 31)
-#define   TM2_QW1W2_VO           PPC_BIT32(0)
-#define   TM2_QW1W2_HO           PPC_BIT32(1)
+#define   TM2_QW1W2_VO           TM2_W2_VALID
+#define   TM2_QW1W2_HO           TM2_W2_HW
 #define   TM2_QW1W2_OS_CAM       PPC_BITMASK32(4, 31)
-#define   TM2_QW2W2_VP           PPC_BIT32(0)
-#define   TM2_QW2W2_HP           PPC_BIT32(1)
+#define   TM2_QW2W2_VP           TM2_W2_VALID
+#define   TM2_QW2W2_HP           TM2_W2_HW
 #define   TM2_QW2W2_POOL_CAM     PPC_BITMASK32(4, 31)
-#define   TM2_QW3W2_VT           PPC_BIT32(0)
-#define   TM2_QW3W2_HT           PPC_BIT32(1)
+#define   TM2_QW3W2_VT           TM2_W2_VALID
+#define   TM2_QW3W2_HT           TM2_W2_HW
 #define   TM2_QW3W2_LP           PPC_BIT32(6)
 #define   TM2_QW3W2_LE           PPC_BIT32(7)
 
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 558a5ae742..5b11463777 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -138,6 +138,7 @@
 #define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
                                         /* line                               */
 #define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
+#define TM_SPC_PULL_PHYS_CTX_OL 0xc38   /* Pull phys ctx to odd cache line    */
 /* XXX more... */
 
 /* NSR fields for the various QW ack types */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f1d007d9a6..9d85da0999 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -117,10 +117,9 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 {
     /*
-     * Lower the External interrupt. Used when pulling an OS
-     * context. It is necessary to avoid catching it in the hypervisor
-     * context. It should be raised again when re-pushing the OS
-     * context.
+     * Lower the External interrupt. Used when pulling a context. It is
+     * necessary to avoid catching it in the higher privilege context. It
+     * should be raised again when re-pushing the lower privilege context.
      */
     qemu_irq_lower(xive_tctx_output(tctx, ring));
 }
@@ -581,6 +580,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
                                                      xive_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
+                                                     NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 38a4b0ff68..10fcbd04f1 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -327,8 +327,8 @@ static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    *valid = !!(cam & TM2_QW1W2_VO);
-    *hw = !!(cam & TM2_QW1W2_HO);
+    *valid = !!(cam & TM2_W2_VALID);
+    *hw = !!(cam & TM2_W2_HW);
 }
 
 
@@ -398,7 +398,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                               hwaddr offset, unsigned size)
 {
     return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
- }
+}
 
 #define REPORT_LINE_GEN1_SIZE       16
 
@@ -502,6 +502,12 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW1_OS);
 }
 
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
+}
+
 static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
                                         uint8_t nvp_blk, uint32_t nvp_idx,
                                         Xive2Nvp *nvp)
-- 
2.43.0


