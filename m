Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE1EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKJ-0001Y1-Ht; Mon, 21 Jul 2025 12:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ0-0005Rx-5t
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIw-0001Yj-4d
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbsatBWGHnXK0ln5RenIDg9eQQYBOHkeiL6Ce6cZ+TY=;
 b=a1WWEMhvKBioM1btrJrpFAmhGGJY2nqObx0P/DH96R6vJ6joC11OnsbUWM0qT5dU1utTx5
 1HB3hLOcPbgriDneVId/+vCqJXHilOh0FqDFO3/FqNQY8cdfLyxHCLQhewkL3qMFLI7HRG
 jDguevlJHvblq4MEU0H4ROa8S6IItQM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-57TcfSAqNRm2W4OOBNdvsg-1; Mon,
 21 Jul 2025 12:23:42 -0400
X-MC-Unique: 57TcfSAqNRm2W4OOBNdvsg-1
X-Mimecast-MFC-AGG-ID: 57TcfSAqNRm2W4OOBNdvsg_1753115021
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96A1E1956048; Mon, 21 Jul 2025 16:23:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63923195608D; Mon, 21 Jul 2025 16:23:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/50] ppc/xive2: Support redistribution of group interrupts
Date: Mon, 21 Jul 2025 18:22:05 +0200
Message-ID: <20250721162233.686837-23-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Glenn Miles <milesg@linux.ibm.com>

When an XIVE context is pulled while it has an active, unacknowledged
group interrupt, XIVE will check to see if a context on another thread
can handle the interrupt and, if so, notify that context.  If there
are no contexts that can handle the interrupt, then the interrupt is
added to a backlog and XIVE will attempt to escalate the interrupt,
if configured to do so, allowing the higher privileged handler to
activate a context that can handle the original interrupt.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-23-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2_regs.h |  3 ++
 hw/intc/xive2.c             | 84 +++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 2c535ec0d0f1..e22203814312 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -224,6 +224,9 @@ typedef struct Xive2Nvgc {
 #define NVGC2_W0_VALID             PPC_BIT32(0)
 #define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
         uint32_t        w1;
+#define NVGC2_W1_PSIZE             PPC_BITMASK32(0, 1)
+#define NVGC2_W1_END_BLK           PPC_BITMASK32(4, 7)
+#define NVGC2_W1_END_IDX           PPC_BITMASK32(8, 31)
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 541b05225cd2..9ef372b6d1d9 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -19,6 +19,10 @@
 #include "hw/ppc/xive2_regs.h"
 #include "trace.h"
 
+static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
+                                    uint32_t end_idx, uint32_t end_data,
+                                    bool redistribute);
+
 uint32_t xive2_router_get_config(Xive2Router *xrtr)
 {
     Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
@@ -597,6 +601,68 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
+static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
+                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_t ring)
+{
+    uint8_t nsr = tctx->regs[ring + TM_NSR];
+    uint8_t crowd = NVx_CROWD_LVL(nsr);
+    uint8_t group = NVx_GROUP_LVL(nsr);
+    uint8_t nvgc_blk;
+    uint8_t nvgc_idx;
+    uint8_t end_blk;
+    uint32_t end_idx;
+    uint8_t pipr = tctx->regs[ring + TM_PIPR];
+    Xive2Nvgc nvgc;
+    uint8_t prio_limit;
+    uint32_t cfg;
+
+    /* convert crowd/group to blk/idx */
+    if (group > 0) {
+        nvgc_idx = (nvp_idx & (0xffffffff << group)) |
+                   ((1 << (group - 1)) - 1);
+    } else {
+        nvgc_idx = nvp_idx;
+    }
+
+    if (crowd > 0) {
+        crowd = (crowd == 3) ? 4 : crowd;
+        nvgc_blk = (nvp_blk & (0xffffffff << crowd)) |
+                   ((1 << (crowd - 1)) - 1);
+    } else {
+        nvgc_blk = nvp_blk;
+    }
+
+    /* Use blk/idx to retrieve the NVGC */
+    if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
+                      crowd ? "NVC" : "NVG", nvgc_blk, nvgc_idx);
+        return;
+    }
+
+    /* retrieve the END blk/idx from the NVGC */
+    end_blk = xive_get_field32(NVGC2_W1_END_BLK, nvgc.w1);
+    end_idx = xive_get_field32(NVGC2_W1_END_IDX, nvgc.w1);
+
+    /* determine number of priorities being used */
+    cfg = xive2_router_get_config(xrtr);
+    if (cfg & XIVE2_EN_VP_GRP_PRIORITY) {
+        prio_limit = 1 << GETFIELD(NVGC2_W1_PSIZE, nvgc.w1);
+    } else {
+        prio_limit = 1 << GETFIELD(XIVE2_VP_INT_PRIO, cfg);
+    }
+
+    /* add priority offset to end index */
+    end_idx += pipr % prio_limit;
+
+    /* trigger the group END */
+    xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
+
+    /* clear interrupt indication for the context */
+    tctx->regs[ring + TM_NSR] = 0;
+    tctx->regs[ring + TM_PIPR] = tctx->regs[ring + TM_CPPR];
+    xive_tctx_reset_signal(tctx, ring);
+}
+
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -608,6 +674,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     uint8_t cur_ring;
     bool valid;
     bool do_save;
+    uint8_t nsr;
 
     xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
@@ -624,6 +691,12 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
     }
 
+    /* Active group/crowd interrupts need to be redistributed */
+    nsr = tctx->regs[ring + TM_NSR];
+    if (xive_nsr_indicates_group_exception(ring, nsr)) {
+        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
+    }
+
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
         xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
     }
@@ -1352,7 +1425,8 @@ static bool xive2_router_end_es_notify(Xive2Router *xrtr, uint8_t end_blk,
  * message has the same parameters than in the function below.
  */
 static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
-                                    uint32_t end_idx, uint32_t end_data)
+                                    uint32_t end_idx, uint32_t end_data,
+                                    bool redistribute)
 {
     Xive2End end;
     uint8_t priority;
@@ -1380,7 +1454,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         return;
     }
 
-    if (xive2_end_is_enqueue(&end)) {
+    if (!redistribute && xive2_end_is_enqueue(&end)) {
         xive2_end_enqueue(&end, end_data);
         /* Enqueuing event data modifies the EQ toggle and index */
         xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
@@ -1560,7 +1634,8 @@ do_escalation:
         xive2_router_end_notify(xrtr,
                                xive_get_field32(END2_W4_END_BLOCK,     end.w4),
                                xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5),
+                               false);
     } /* end END adaptive escalation */
 
     else {
@@ -1641,7 +1716,8 @@ void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
     xive2_router_end_notify(xrtr,
                             xive_get_field64(EAS2_END_BLOCK, eas.w),
                             xive_get_field64(EAS2_END_INDEX, eas.w),
-                            xive_get_field64(EAS2_END_DATA,  eas.w));
+                            xive_get_field64(EAS2_END_DATA,  eas.w),
+                            false);
     return;
 }
 
-- 
2.50.1


