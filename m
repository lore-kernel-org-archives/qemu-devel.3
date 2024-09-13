Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448C7FC6162
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8za-0007rP-Fg; Fri, 13 Sep 2024 12:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8zM-0006uL-3N; Fri, 13 Sep 2024 12:17:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8zI-0006n2-6z; Fri, 13 Sep 2024 12:17:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBYdS030003;
 Fri, 13 Sep 2024 16:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 dDoViFg80EZaYkYc0RqVdS9w4xOGLjx48bY0jXVJTPQ=; b=NBshkE1FiHFdPdjm
 ZaRj+KY883kkrqUdIT7Q4DsyxtG46jmKJaq5o5GRzXM54a5bzsVqlCXM7gnSh6Ds
 Jo4w3GTIbszahsknCvCaQQ5BBBFRbUGalOLR8W2RtKadrWuHQcLdSnJ25mREZHlD
 b91PvRrkBt5+6u41rYqukUAHH1kZOYZ+Ss4Kws53dD05DVQ7px/KFtFMDFQklprI
 L7YOKc/zC1qsrwqYlC6M0LkODE58eidfhKZ2E2/34516Yn/tb13s6z7UOLqAZCqi
 dPwmYhxm0OuZhj5voLeuYHdjAJ2mb3jJQJ4zT/WOGH4uSmTGcqieaDd7oh6EI4OR
 wNTmZw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxb9m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DGHQam009682;
 Fri, 13 Sep 2024 16:17:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxb9m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DExZ0V019847;
 Fri, 13 Sep 2024 16:17:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25qfafb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DGHLEl42336608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 16:17:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BED920040;
 Fri, 13 Sep 2024 16:17:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED5F62004B;
 Fri, 13 Sep 2024 16:17:19 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 16:17:19 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 10/14] ppc/xive2: Support "Pull Thread Context to Odd
 Thread Reporting Line"
Date: Fri, 13 Sep 2024 11:16:55 -0500
Message-Id: <20240913161659.1981-11-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240913161659.1981-1-kowal@linux.ibm.com>
References: <20240913161659.1981-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AUmuV42cB2EufNnCNt7O5F4Q95sA11pv
X-Proofpoint-ORIG-GUID: DJM5LiF5uzdNWsFGorilAeVQS1J2DH1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130113
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

Adds support for single byte writes to offset 0xC38 of the TIMA address
space.  When this offset is written to, the hardware disables the thread
context and copies the current state information to the odd cache line of
the pair specified by the NVT structure indexed by the THREAD CAM entry.

Note that this operation is almost identical to what we are already doing
for the "Pull OS Context to Odd Thread Reporting Line" operation except
that it also invalidates the Pool and Thread Contexts.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive2.h      |  2 +
 include/hw/ppc/xive2_regs.h | 16 ++++----
 include/hw/ppc/xive_regs.h  |  1 +
 hw/intc/xive.c              |  9 +++--
 hw/intc/xive2.c             | 73 ++++++++++++++++++++++++++-----------
 5 files changed, 69 insertions(+), 32 deletions(-)

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
index c5aa784fe8..2e41bd9edb 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -323,12 +323,12 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 }
 
 static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
-                             uint32_t *nvp_idx, bool *vo, bool *ho)
+                             uint32_t *nvp_idx, bool *valid, bool *hw)
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    *vo = !!(cam & TM2_QW1W2_VO);
-    *ho = !!(cam & TM2_QW1W2_HO);
+    *valid = !!(cam & TM2_W2_VALID);
+    *hw = !!(cam & TM2_W2_HW);
 }
 
 /*
@@ -351,35 +351,52 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
-uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-                              hwaddr offset, unsigned size)
+static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                  hwaddr offset, unsigned size, uint8_t ring)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
-    uint32_t qw1w2_new;
-    uint32_t cam = be32_to_cpu(qw1w2);
+    uint32_t target_ringw2 = xive_tctx_word2(&tctx->regs[ring]);
+    uint32_t cam = be32_to_cpu(target_ringw2);
     uint8_t nvp_blk;
     uint32_t nvp_idx;
-    bool vo;
+    uint8_t cur_ring;
+    bool valid;
     bool do_save;
 
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
-    if (!vo) {
+    if (!valid) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
                       nvp_blk, nvp_idx);
     }
 
-    /* Invalidate CAM line */
-    qw1w2_new = xive_set_field32(TM2_QW1W2_VO, qw1w2, 0);
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
+    /* Invalidate CAM line of requested ring and all lower rings */
+    for (cur_ring = TM_QW0_USER; cur_ring <= ring;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
+        uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
+        memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
+    }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
+        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
+    }
+
+    /*
+     * Lower external interrupt line of requested ring and below except for
+     * USER, which doesn't exist.
+     */
+    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        xive_tctx_reset_signal(tctx, cur_ring);
     }
+    return target_ringw2;
+}
 
-    xive_tctx_reset_signal(tctx, TM_QW1_OS);
-    return qw1w2;
+uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                              hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
 }
 
 #define REPORT_LINE_GEN1_SIZE       16
@@ -424,8 +441,9 @@ static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
     }
 }
 
-void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
-                             hwaddr offset, uint64_t value, unsigned size)
+static void xive2_tm_pull_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                                 hwaddr offset, uint64_t value,
+                                 unsigned size, uint8_t ring)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
     uint32_t hw_cam, nvp_idx, xive2_cfg, reserved;
@@ -473,8 +491,21 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
         assert(result == MEMTX_OK);
     }
 
-    /* the rest is similar to pull OS context to registers */
-    xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
+    /* the rest is similar to pull context to registers */
+    xive2_tm_pull_ctx(xptr, tctx, offset, size, ring);
+}
+
+void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW1_OS);
+}
+
+
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
 }
 
 static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-- 
2.43.0


