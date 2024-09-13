Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8703DFC6161
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8zS-0007AG-Nd; Fri, 13 Sep 2024 12:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8zE-0006NS-1X; Fri, 13 Sep 2024 12:17:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8zA-0006lS-O3; Fri, 13 Sep 2024 12:17:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBY0w024671;
 Fri, 13 Sep 2024 16:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=VMJbXyEZT62c9
 xzc/YS4AyUmH/Kmy7HafjofcTnJn8s=; b=TQTpz4Yq4pxiVLzNDTkCjzMijZU0o
 lzW8NelF+9T3ZVxL/FEFwTW57BEm6Xt4B8z0arXe+j/zPXoe78AqSVAgvMsvZuHD
 hpNx3gGP075FFotErNyjZoxIuVM9lGpJII39W6r3TugawxNR9Kisj65y6io7OpKL
 jZzie/K0yjk+f3c6PttfLrrvLcgJXQsKCW0WUZoKaHBqhNfvXUtj1JJ52LEvmdvJ
 Zx4dRMFK7/j7X6IcYuG3E7zoTAmgIeqcy+SAxCvmbp4KDMn1f1zv78yGDlp/prLq
 yrRSO1ANhlGPho5dOjQTl6SKZJKuEW7vJtaAd8yf6beQUQnv4X0FEsxYQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebau82n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DGHOTO003146;
 Fri, 13 Sep 2024 16:17:24 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebau82k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DEVKuG003168;
 Fri, 13 Sep 2024 16:17:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15uffbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DGHJLP33292724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 16:17:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A681E2004B;
 Fri, 13 Sep 2024 16:17:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7259220040;
 Fri, 13 Sep 2024 16:17:18 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 16:17:18 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 09/14] ppc/xive2: Change context/ring specific functions to
 be generic
Date: Fri, 13 Sep 2024 11:16:54 -0500
Message-Id: <20240913161659.1981-10-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240913161659.1981-1-kowal@linux.ibm.com>
References: <20240913161659.1981-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4fmd9XqtWdSQND3Y9JIQdZmyARcQ5AC7
X-Proofpoint-GUID: VbE_fSKmd-8UKBAM0vtdbur6zbf9_UQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=852 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409130113
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

Some the functions that have been created are specific to a ring or context. Some
of these same functions are being changed to operate on any ring/context. This  will
simplify the next patch sets that are adding additional ring/context operations.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h |  2 +-
 hw/intc/xive.c        |  6 +++---
 hw/intc/xive2.c       | 20 ++++++++++----------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 28c181faa2..31242f0406 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -533,7 +533,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
-void xive_tctx_reset_os_signal(XiveTCTX *tctx);
+void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 
 /*
  * KVM XIVE device helpers
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5b66a3aec5..f1d007d9a6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -114,7 +114,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
     }
 }
 
-void xive_tctx_reset_os_signal(XiveTCTX *tctx)
+void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 {
     /*
      * Lower the External interrupt. Used when pulling an OS
@@ -122,7 +122,7 @@ void xive_tctx_reset_os_signal(XiveTCTX *tctx)
      * context. It should be raised again when re-pushing the OS
      * context.
      */
-    qemu_irq_lower(xive_tctx_output(tctx, TM_QW1_OS));
+    qemu_irq_lower(xive_tctx_output(tctx, ring));
 }
 
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
@@ -424,7 +424,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     qw1w2_new = xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
     xive_tctx_set_os_cam(tctx, qw1w2_new);
 
-    xive_tctx_reset_os_signal(tctx);
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
     return qw1w2;
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 8d3d69a0db..c5aa784fe8 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -270,13 +270,14 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
  *     the NVP by changing the H bit while the context is enabled
  */
 
-static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                   uint8_t nvp_blk, uint32_t nvp_idx)
+static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
+                                uint8_t nvp_blk, uint32_t nvp_idx,
+                                uint8_t ring)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
     Xive2Nvp nvp;
-    uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t *regs = &tctx->regs[ring];
 
     if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
@@ -321,8 +322,8 @@ static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
 }
 
-static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
-                                uint32_t *nvp_idx, bool *vo, bool *ho)
+static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
+                             uint32_t *nvp_idx, bool *vo, bool *ho)
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
@@ -330,7 +331,6 @@ static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
     *ho = !!(cam & TM2_QW1W2_HO);
 }
 
-
 /*
  * Encode the HW CAM line with 7bit or 8bit thread id. The thread id
  * width and block id width is configurable at the IC level.
@@ -363,7 +363,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_save;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
 
     if (!vo) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
@@ -375,10 +375,10 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
+        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
     }
 
-    xive_tctx_reset_os_signal(tctx);
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
     return qw1w2;
 }
 
@@ -573,7 +573,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_restore;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
 
     /* First update the thead context */
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
-- 
2.43.0


