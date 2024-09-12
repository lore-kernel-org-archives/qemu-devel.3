Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7FAEEE25C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 20:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmM-0003CX-Nn; Thu, 12 Sep 2024 16:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmJ-00031S-TE; Thu, 12 Sep 2024 16:50:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmI-0007AK-7B; Thu, 12 Sep 2024 16:50:59 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CK9qn2018596;
 Thu, 12 Sep 2024 20:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=wxMft3GbcTi7u
 FZ0TQOQBXrG0uQRaYluO1dLiJkpprU=; b=sF3T2f0oIs6Fw69ukC4SJ4hz8IAK7
 Av7esBNfHRUj07YH7tkbtF4M5OvNKZ1cStRKDZrvmsKXrCtv+TGZBs7aNJo3i6eY
 StkP5JnsryP3HT1IFG9g9Nyx2KdIctQXJiAwRpeHnlnvDNWeJLWASiwyzm1fZCie
 I5z3PI6hRAqaJvNLuXXj17fe96uyVqOO2OeRcY1cmSAzg3K+c1MXk5MwvziME0s9
 Gej/epqBY6Wt9fTj/vCjslrarK6oSnbcfjP+/Rk6P+Wo3G2EgKzjtj8lzpBBCu5h
 Cv82k+8R5lP2FA2uv7DRy9IkfP6l+f67LH65wjsgN3vyFXvIkE1lDcv2Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx643m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKorS5024276;
 Thu, 12 Sep 2024 20:50:53 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx643k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CHik8r003155;
 Thu, 12 Sep 2024 20:50:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15uaf5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKontI52101394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2035520049;
 Thu, 12 Sep 2024 20:50:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E49E220040;
 Thu, 12 Sep 2024 20:50:47 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:47 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 09/14] ppc/xive2: Change context/ring specific functions to
 be generic
Date: Thu, 12 Sep 2024 15:50:23 -0500
Message-Id: <20240912205028.15854-10-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I4na9M74u9601332HqG0jEnNuNWUekV3
X-Proofpoint-ORIG-GUID: 98jBfaJYsGFr16rDjvbb3zUCaEtWXlZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=783
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120149
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
 hw/intc/xive2.c       | 23 ++++++++++++-----------
 3 files changed, 16 insertions(+), 15 deletions(-)

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
index 8d3d69a0db..ad8b8729ed 100644
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
@@ -321,13 +322,13 @@ static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
 }
 
-static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
-                                uint32_t *nvp_idx, bool *vo, bool *ho)
+static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
+                             uint32_t *nvp_idx, bool *valid, bool *hw)
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    *vo = !!(cam & TM2_QW1W2_VO);
-    *ho = !!(cam & TM2_QW1W2_HO);
+    *valid = !!(cam & TM2_QW1W2_VO);
+    *hw = !!(cam & TM2_QW1W2_HO);
 }
 
 
@@ -363,7 +364,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_save;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
 
     if (!vo) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
@@ -375,10 +376,10 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
+        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, TM_QW1_OS);
     }
 
-    xive_tctx_reset_os_signal(tctx);
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
     return qw1w2;
 }
 
@@ -573,7 +574,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_restore;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
 
     /* First update the thead context */
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
-- 
2.43.0


