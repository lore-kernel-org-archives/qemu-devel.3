Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9849CC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKx-0003Qm-7s; Mon, 21 Jul 2025 12:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJc-0007pk-Pq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJa-0001kn-KL
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9zwT7ZGhqGYHNUIdjiGru3IcNqxqD9iWpzeEHAQh+g=;
 b=NoP9NOooeDULkDhiiAyzSWreb8/WbrkAzEn/dWennvUc3D1tqBWJPLW0FT6oi5m6Z0fl+3
 EEz42R8lOUVjAUPXEJtAIgYy/v8GOl8rPVRfkFoK2fT8B//DDTVWtzEhZ8x/NvP727+Sh1
 EccblhsgMszrmjTDSoTg3zSJYiAVLH0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-pVO4pux2P6KyUOCu-rD2Lg-1; Mon,
 21 Jul 2025 12:24:32 -0400
X-MC-Unique: pVO4pux2P6KyUOCu-rD2Lg-1
X-Mimecast-MFC-AGG-ID: pVO4pux2P6KyUOCu-rD2Lg_1753115071
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E466180029E; Mon, 21 Jul 2025 16:24:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A029195608D; Mon, 21 Jul 2025 16:24:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 40/50] ppc/xive2: implement NVP context save restore for POOL
 ring
Date: Mon, 21 Jul 2025 18:22:23 +0200
Message-ID: <20250721162233.686837-41-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

In preparation to implement POOL context push, add support for POOL
NVP context save/restore.

The NVP p bit is defined in the spec as follows:

    If TRUE, the CPPR of a Pool VP in the NVP is updated during store of
    the context with the CPPR of the Hard context it was running under.

It's not clear whether non-pool VPs always or never get CPPR updated.
Before this patch, OS contexts always save CPPR, so we will assume that
is the behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-41-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2_regs.h |  1 +
 hw/intc/xive2.c             | 51 +++++++++++++++++++++++++------------
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index f82054661bda..2a3e60abadbf 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -158,6 +158,7 @@ typedef struct Xive2Nvp {
 #define NVP2_W0_L                  PPC_BIT32(8)
 #define NVP2_W0_G                  PPC_BIT32(9)
 #define NVP2_W0_T                  PPC_BIT32(10)
+#define NVP2_W0_P                  PPC_BIT32(11)
 #define NVP2_W0_ESC_END            PPC_BIT32(25) /* 'N' bit 0:ESB  1:END */
 #define NVP2_W0_PGOFIRST           PPC_BITMASK32(26, 31)
         uint32_t       w1;
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index a0a6b1a88179..7631d4886206 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -512,12 +512,13 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
  */
 
 static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                uint8_t nvp_blk, uint32_t nvp_idx,
-                                uint8_t ring)
+                                uint8_t ring,
+                                uint8_t nvp_blk, uint32_t nvp_idx)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
     Xive2Nvp nvp;
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
     if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
@@ -553,7 +554,14 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     }
 
     nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, regs[TM_IPB]);
-    nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, regs[TM_CPPR]);
+
+    if ((nvp.w0 & NVP2_W0_P) || ring != TM_QW2_HV_POOL) {
+        /*
+         * Non-pool contexts always save CPPR (ignore p bit). XXX: Clarify
+         * whether that is the correct behaviour.
+         */
+        nvp.w2 = xive_set_field32(NVP2_W2_CPPR, nvp.w2, sig_regs[TM_CPPR]);
+    }
     if (nvp.w0 & NVP2_W0_L) {
         /*
          * Typically not used. If LSMFB is restored with 0, it will
@@ -722,7 +730,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
+        xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
     }
 
     /*
@@ -863,12 +871,15 @@ void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
 }
 
-static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                        uint8_t nvp_blk, uint32_t nvp_idx,
-                                        Xive2Nvp *nvp)
+static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
+                                      uint8_t ring,
+                                      uint8_t nvp_blk, uint32_t nvp_idx,
+                                      Xive2Nvp *nvp)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+    uint8_t *regs = &tctx->regs[ring];
     uint8_t cppr;
 
     if (!xive2_nvp_is_hw(nvp)) {
@@ -881,10 +892,10 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     nvp->w2 = xive_set_field32(NVP2_W2_CPPR, nvp->w2, 0);
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 2);
 
-    tctx->regs[TM_QW1_OS + TM_CPPR] = cppr;
-    tctx->regs[TM_QW1_OS + TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
-    tctx->regs[TM_QW1_OS + TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
-    tctx->regs[TM_QW1_OS + TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
+    sig_regs[TM_CPPR] = cppr;
+    regs[TM_LSMFB] = xive_get_field32(NVP2_W2_LSMFB, nvp->w2);
+    regs[TM_LGS] = xive_get_field32(NVP2_W2_LGS, nvp->w2);
+    regs[TM_T] = xive_get_field32(NVP2_W2_T, nvp->w2);
 
     nvp->w1 = xive_set_field32(NVP2_W1_CO, nvp->w1, 1);
     nvp->w1 = xive_set_field32(NVP2_W1_CO_THRID_VALID, nvp->w1, 1);
@@ -893,9 +904,18 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     /*
      * Checkout privilege: 0:OS, 1:Pool, 2:Hard
      *
-     * TODO: we only support OS push/pull
+     * TODO: we don't support hard push/pull
      */
-    nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
+    switch (ring) {
+    case TM_QW1_OS:
+        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 0);
+        break;
+    case TM_QW2_HV_POOL:
+        nvp->w1 = xive_set_field32(NVP2_W1_CO_PRIV, nvp->w1, 1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
 
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, nvp, 1);
 
@@ -930,9 +950,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
 
     /* Automatically restore thread context registers */
-    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE &&
-        do_restore) {
-        xive2_tctx_restore_os_ctx(xrtr, tctx, nvp_blk, nvp_idx, &nvp);
+    if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
+        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
     }
 
     ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
-- 
2.50.1


