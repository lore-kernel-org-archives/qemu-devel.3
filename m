Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25CBEEE262
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 20:54:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmE-0002d2-7N; Thu, 12 Sep 2024 16:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmA-0002Us-DA; Thu, 12 Sep 2024 16:50:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqm8-00078k-4U; Thu, 12 Sep 2024 16:50:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CCTerR010617;
 Thu, 12 Sep 2024 20:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 7saMh70EOxjNro/ftfKlW9PomFUZYMKZfH2el1E0SPs=; b=O2UP3bEcG1Aa86mL
 zlhekc1k8dRuYzce0dHYiw85XE18Rl/7SDzV0QOHaS1kewJ3CcBPdT4XnURlukEo
 6gdCqrK8cY9sSx4pQo0fjso/zaUYloIc8c6DEgg4qXQuRxYBtv18sCLOpp6J/q28
 SLVDiY7WxoTL03+HHGApnu1h6yE9wbRXvcBlOc1CEdtZoYGK3/zrLfN/8tY5y+DE
 TvppcMdPiOFzNYyylFpzY49lsYIstqmfuL+qF+SFkyAqpufO1Jrp2FTkd5lWEqhb
 gndNdSARFzOE22/QhSKYNe83vfGvuvQzjCzkSZDPM2Kk1nscaD71AiEJbC05l+pd
 CLVnyQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefywttp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:44 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKoiFM023117;
 Thu, 12 Sep 2024 20:50:44 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefywttk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CItk0l027328;
 Thu, 12 Sep 2024 20:50:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3j07n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKoer149480182
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1232004D;
 Thu, 12 Sep 2024 20:50:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0957C20040;
 Thu, 12 Sep 2024 20:50:39 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:38 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 03/14] ppc/xive2: Support TIMA "Pull OS Context to Odd
 Thread Reporting Line"
Date: Thu, 12 Sep 2024 15:50:17 -0500
Message-Id: <20240912205028.15854-4-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x-17oUZTlCTk_BDFsYRu-zFW1nXvXbYL
X-Proofpoint-ORIG-GUID: Np0AiQU6D-i3BvtBFlCUL46O1WwURwdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=915 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Adds support for single byte writes to offset 0xC18 of the TIMA address
space.  When this offset is written to, the hardware disables the OS
context and copies the current state information to the odd cache line
of the pair specified by the NVT structure indexed by the OS CAM entry.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive2.h      |   2 +
 include/hw/ppc/xive2_regs.h |   2 +
 include/hw/ppc/xive_regs.h  |   3 +
 hw/intc/xive.c              |   2 +
 hw/intc/xive2.c             | 160 ++++++++++++++++++++++++++++++------
 5 files changed, 142 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index ab68f8d157..654f485e9b 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -107,5 +107,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, unsigned size);
+void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 4349d009d0..7acf7dccf3 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -171,7 +171,9 @@ typedef struct Xive2Nvp {
 #define NVP2_W5_VP_END_BLOCK       PPC_BITMASK32(4, 7)
 #define NVP2_W5_VP_END_INDEX       PPC_BITMASK32(8, 31)
         uint32_t       w6;
+#define NVP2_W6_REPORTING_LINE     PPC_BITMASK32(4, 31)
         uint32_t       w7;
+#define NVP2_W7_REPORTING_LINE     PPC_BITMASK32(0, 23)
 } Xive2Nvp;
 
 #define xive2_nvp_is_valid(nvp)    (be32_to_cpu((nvp)->w0) & NVP2_W0_VALID)
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 9062c6abf6..27a744d50d 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -77,6 +77,7 @@
 #define TM_LSMFB                0x3  /*  -   +   +   +  */
 #define TM_ACK_CNT              0x4  /*  -   +   -   -  */
 #define TM_INC                  0x5  /*  -   +   -   +  */
+#define TM_LGS                  0x5  /*  +   +   +   +  */ /* Rename P10 */
 #define TM_AGE                  0x6  /*  -   +   -   +  */
 #define TM_PIPR                 0x7  /*  -   +   -   +  */
 #define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
@@ -129,6 +130,8 @@
 #define TM_SPC_PULL_USR_CTX_OL  0xc08   /* Store8 Pull/Inval usr ctx to odd   */
                                         /* line                               */
 #define TM_SPC_ACK_OS_EL        0xc10   /* Store8 ack OS irq to even line     */
+#define TM_SPC_PULL_OS_CTX_OL   0xc18   /* Pull/Invalidate OS context to      */
+                                        /* odd Thread reporting line          */
 #define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
                                         /* line                               */
 #define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 136d82338a..8e62c7e75f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -547,6 +547,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
                                                      xive_tm_pull_pool_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
+                                                     NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 1f150685bf..fbd05aa9f5 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -26,6 +26,23 @@ uint32_t xive2_router_get_config(Xive2Router *xrtr)
     return xrc->get_config(xrtr);
 }
 
+static int xive2_router_get_block_id(Xive2Router *xrtr)
+{
+   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
+
+   return xrc->get_block_id(xrtr);
+}
+
+static uint64_t xive2_nvp_reporting_addr(Xive2Nvp *nvp)
+{
+    uint64_t cache_addr;
+
+    cache_addr = xive_get_field32(NVP2_W6_REPORTING_LINE, nvp->w6) << 24 |
+        xive_get_field32(NVP2_W7_REPORTING_LINE, nvp->w7);
+    cache_addr <<= 8; /* aligned on a cache line pair */
+    return cache_addr;
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
@@ -270,6 +287,27 @@ static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
     *ho = !!(cam & TM2_QW1W2_HO);
 }
 
+
+/*
+ * Encode the HW CAM line with 7bit or 8bit thread id. The thread id
+ * width and block id width is configurable at the IC level.
+ *
+ *    chipid << 24 | 0000 0000 0000 0000 1 threadid (7Bit)
+ *    chipid << 24 | 0000 0000 0000 0001 threadid   (8Bit)
+ */
+static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
+    uint32_t pir = env->spr_cb[SPR_PIR].default_value;
+    uint8_t blk = xive2_router_get_block_id(xrtr);
+    uint8_t tid_shift =
+        xive2_router_get_config(xrtr) & XIVE2_THREADID_8BITS ? 8 : 7;
+    uint8_t tid_mask = (1 << tid_shift) - 1;
+
+    return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
+}
+
 uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                               hwaddr offset, unsigned size)
 {
@@ -301,6 +339,101 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return qw1w2;
 }
 
+#define REPORT_LINE_GEN1_SIZE       16
+
+static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
+                                      uint8_t size)
+{
+    uint8_t *regs = tctx->regs;
+
+    g_assert(size == REPORT_LINE_GEN1_SIZE);
+    memset(data, 0, size);
+    /*
+     * See xive architecture for description of what is saved. It is
+     * hand-picked information to fit in 16 bytes.
+     */
+    data[0x0] = regs[TM_QW3_HV_PHYS + TM_NSR];
+    data[0x1] = regs[TM_QW3_HV_PHYS + TM_CPPR];
+    data[0x2] = regs[TM_QW3_HV_PHYS + TM_IPB];
+    data[0x3] = regs[TM_QW2_HV_POOL + TM_IPB];
+    data[0x4] = regs[TM_QW1_OS + TM_ACK_CNT];
+    data[0x5] = regs[TM_QW3_HV_PHYS + TM_LGS];
+    data[0x6] = 0xFF;
+    data[0x7] = regs[TM_QW3_HV_PHYS + TM_WORD2] & 0x80;
+    data[0x7] |= (regs[TM_QW2_HV_POOL + TM_WORD2] & 0x80) >> 1;
+    data[0x7] |= (regs[TM_QW1_OS + TM_WORD2] & 0x80) >> 2;
+    data[0x7] |= (regs[TM_QW3_HV_PHYS + TM_WORD2] & 0x3);
+    data[0x8] = regs[TM_QW1_OS + TM_NSR];
+    data[0x9] = regs[TM_QW1_OS + TM_CPPR];
+    data[0xA] = regs[TM_QW1_OS + TM_IPB];
+    data[0xB] = regs[TM_QW1_OS + TM_LGS];
+    if (regs[TM_QW0_USER + TM_WORD2] & 0x80) {
+        /*
+         * Logical server extension, except VU bit replaced by EB bit
+         * from NSR
+         */
+        data[0xC] = regs[TM_QW0_USER + TM_WORD2];
+        data[0xC] &= ~0x80;
+        data[0xC] |= regs[TM_QW0_USER + TM_NSR] & 0x80;
+        data[0xD] = regs[TM_QW0_USER + TM_WORD2 + 1];
+        data[0xE] = regs[TM_QW0_USER + TM_WORD2 + 2];
+        data[0xF] = regs[TM_QW0_USER + TM_WORD2 + 3];
+    }
+}
+
+void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t hw_cam, nvp_idx, xive2_cfg, reserved;
+    uint8_t nvp_blk;
+    Xive2Nvp nvp;
+    uint64_t phys_addr;
+    MemTxResult result;
+
+    hw_cam = xive2_tctx_hw_cam_line(xptr, tctx);
+    nvp_blk = xive2_nvp_blk(hw_cam);
+    nvp_idx = xive2_nvp_idx(hw_cam);
+
+    if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
+                      nvp_blk, nvp_idx);
+        return;
+    }
+
+    if (!xive2_nvp_is_valid(&nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                      nvp_blk, nvp_idx);
+        return;
+    }
+
+    xive2_cfg = xive2_router_get_config(xrtr);
+
+    phys_addr = xive2_nvp_reporting_addr(&nvp) + 0x80; /* odd line */
+    if (xive2_cfg & XIVE2_GEN1_TIMA_OS) {
+        uint8_t pull_ctxt[REPORT_LINE_GEN1_SIZE];
+
+        xive2_tm_report_line_gen1(tctx, pull_ctxt, REPORT_LINE_GEN1_SIZE);
+        result = dma_memory_write(&address_space_memory, phys_addr,
+                                  pull_ctxt, REPORT_LINE_GEN1_SIZE,
+                                  MEMTXATTRS_UNSPECIFIED);
+        assert(result == MEMTX_OK);
+    } else {
+        result = dma_memory_write(&address_space_memory, phys_addr,
+                                  &tctx->regs, sizeof(tctx->regs),
+                                  MEMTXATTRS_UNSPECIFIED);
+        assert(result == MEMTX_OK);
+        reserved = 0xFFFFFFFF;
+        result = dma_memory_write(&address_space_memory, phys_addr + 12,
+                                  &reserved, sizeof(reserved),
+                                  MEMTXATTRS_UNSPECIFIED);
+        assert(result == MEMTX_OK);
+    }
+
+    /* the rest is similar to pull OS context to registers */
+    xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
+}
+
 static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
                                         uint8_t nvp_blk, uint32_t nvp_idx,
                                         Xive2Nvp *nvp)
@@ -471,33 +604,6 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
    return xrc->write_nvp(xrtr, nvp_blk, nvp_idx, nvp, word_number);
 }
 
-static int xive2_router_get_block_id(Xive2Router *xrtr)
-{
-   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
-
-   return xrc->get_block_id(xrtr);
-}
-
-/*
- * Encode the HW CAM line with 7bit or 8bit thread id. The thread id
- * width and block id width is configurable at the IC level.
- *
- *    chipid << 24 | 0000 0000 0000 0000 1 threadid (7Bit)
- *    chipid << 24 | 0000 0000 0000 0001 threadid   (8Bit)
- */
-static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
-{
-    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
-    uint32_t pir = env->spr_cb[SPR_PIR].default_value;
-    uint8_t blk = xive2_router_get_block_id(xrtr);
-    uint8_t tid_shift =
-        xive2_router_get_config(xrtr) & XIVE2_THREADID_8BITS ? 8 : 7;
-    uint8_t tid_mask = (1 << tid_shift) - 1;
-
-    return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
-}
-
 /*
  * The thread context register words are in big-endian format.
  */
-- 
2.43.0


