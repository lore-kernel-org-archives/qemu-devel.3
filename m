Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772E3C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbp-0003iB-0o; Sun, 11 May 2025 23:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJb7-0000ax-2k; Sun, 11 May 2025 23:12:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJb0-0006ta-SI; Sun, 11 May 2025 23:12:56 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso3734375b3a.0; 
 Sun, 11 May 2025 20:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019569; x=1747624369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MLMpdYEApi8qA/xkPICeuKYWy65spnbdBI8qQxxjiMo=;
 b=ZueEpyU9vZUNsJuu4qe9AzDHLbUkQPBNtPev2/cyGMO4ETZBrOykfYctTZ+Fk4PqRS
 9NOctz7P7IWXOKY5yCYi1go3O1PM7tJ5/wfsPEiCoD/vVZ7waDxIvTrr5WCOFX7epKi6
 d22jOkPM/HcYh+Tgb4YgWrvDb1QSw6/aVFG5LAbTiOH3hOTY7Zfw2Z356Dmph0YUjo5l
 3IHmGdL4P5UHDIm6tN6r+nSosVbUD7qwpmFwiF7C+k1wLYY6h4aYf8u3K7bWKBHACYXb
 cyZrmw370O4dGza9Fz72G2h20W+00fLfWsfHYo79FPhNcj5/Sv06EzmdYZNQap+V0HRM
 6gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019569; x=1747624369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MLMpdYEApi8qA/xkPICeuKYWy65spnbdBI8qQxxjiMo=;
 b=CM3Q0lWOOZhd3nMQrhjKMuZz0ptXmB1tM3ZA4d80mIZKa5JmQmLFp6R7pkdbwX4nxb
 23TToa60ELlvQQSuyL3XZcSvpdHF6qELeg3FvtDgheml1hFxvNLa9eEsvtc4rI2hIiNF
 mlV3Lk66an/QQcuJMj/ArLyAc8Z8gguE2sv2djvlchqm+DTSxinrWIHdkm+kLNlT1P6m
 xBdgvmvoENTjmlk9OLmHRYj4Srv/gf8EXkrNlYEpnWTts9zFXB6whKpHRHcejr2SERdC
 XBrPLH6swbHHoP8sgOswrIwbkvi3b1segQ6+UEkYJn22Sq9PQ6uF3z8dA6myfT59p+Hz
 Slpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0JicOK6iG/zBV9hTzimpZt63R0jEWzfzdBWlx2yAeS7uYODXNAG6dimI8xGMaE7qdcTiaho5viGu8@nongnu.org
X-Gm-Message-State: AOJu0Yy/4Z+cMfL0MgbSO67MogwmtmKynwbG9sykX0zBzOAqSHXllF2i
 XJMRFWrxJTSx+ltgs1IxbOz2WcHEA2s91aO0eDE/8eo1a4THoOYzQpKO1A==
X-Gm-Gg: ASbGncvkmHwURdFu7w3aG9txXSEFuCIBXdoTqUL9NV3S1RJHMD7GAa3h7KvzTEHBSqf
 Xct85a3IqsWs66MQvwGOMmauwjuwDftxNKyyxWlulEupoJfLRd9R0k3H387Y/8N4Z10wXtSGljO
 6NQffeD/GfbG2PP5uOqlsdDQfXEYd/PMJCeGGNBzhhGX/S6LgErSJ5zQUAuEDptgcJgXXnaLcj0
 BrfeYnLxayGShgltMtcAVd9rs8HneilbozwcW2ES03XuPQ+he9WZw9Qz3D+j3jAbOriJ+NV1r8W
 uS8zniTSRr3z4ngAQo8ksrmpV7kGHiCDZjrScgvPqog6Wmg5DHaE1ag+Mg==
X-Google-Smtp-Source: AGHT+IF+SD0HzTqyMIMVsd413DL092seT7CDkXByiqLdA2zS1BOAF2rbeAHUNtWzdwY2ZVg75bA+lw==
X-Received: by 2002:a05:6a20:c90a:b0:1f3:2968:5ac5 with SMTP id
 adf61e73a8af0-2159a0d166cmr24573075637.20.1747019568665; 
 Sun, 11 May 2025 20:12:48 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 27/50] ppc/xive2: redistribute irqs for pool and phys ctx pull
Date: Mon, 12 May 2025 13:10:36 +1000
Message-ID: <20250512031100.439842-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

When disabling (pulling) an xive interrupt context, we need
to redistribute any active group interrupts to other threads
that can handle the interrupt if possible.  This support had
already been added for the OS context but had not yet been
added to the pool or physical context.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive.c              | 12 ++---
 hw/intc/xive2.c             | 94 ++++++++++++++++++++++++++-----------
 include/hw/ppc/xive2.h      |  4 ++
 include/hw/ppc/xive2_regs.h |  4 +-
 4 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9ec1193dfc..ad30476c17 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -693,7 +693,7 @@ static const XiveTmOp xive2_tm_operations[] = {
 
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
-                                                     xive_tm_ack_os_reg },
+                                                   xive_tm_ack_os_reg },
     { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
@@ -705,17 +705,17 @@ static const XiveTmOp xive2_tm_operations[] = {
     { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
                                                      xive_tm_ack_hv_reg },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
-                                                     xive_tm_pull_pool_ctx },
+                                                     xive2_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
-                                                     xive_tm_pull_pool_ctx },
+                                                     xive2_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
-                                                     xive_tm_pull_pool_ctx },
+                                                     xive2_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
-                                                     xive_tm_pull_phys_ctx },
+                                                     xive2_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
-                                                     xive_tm_pull_phys_ctx },
+                                                     xive2_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
                                                      NULL },
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 92dbbad8d4..ac94193464 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -23,6 +23,9 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
                                     uint32_t end_idx, uint32_t end_data,
                                     bool redistribute);
 
+static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
+                                      uint8_t *nvp_blk, uint32_t *nvp_idx);
+
 uint32_t xive2_router_get_config(Xive2Router *xrtr)
 {
     Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
@@ -604,8 +607,10 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
 static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs = &tctx->regs[ring];
-    uint8_t nsr = regs[TM_NSR];
-    uint8_t pipr = regs[TM_PIPR];
+    uint8_t *alt_regs = (ring == TM_QW2_HV_POOL) ? &tctx->regs[TM_QW3_HV_PHYS] :
+                                                   regs;
+    uint8_t nsr = alt_regs[TM_NSR];
+    uint8_t pipr = alt_regs[TM_PIPR];
     uint8_t crowd = NVx_CROWD_LVL(nsr);
     uint8_t group = NVx_GROUP_LVL(nsr);
     uint8_t nvgc_blk, end_blk, nvp_blk;
@@ -614,10 +619,6 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     uint8_t prio_limit;
     uint32_t cfg;
     uint8_t alt_ring;
-    uint32_t target_ringw2;
-    uint32_t cam;
-    bool valid;
-    bool hw;
 
     /* redistribution is only for group/crowd interrupts */
     if (!xive_nsr_indicates_group_exception(ring, nsr)) {
@@ -625,11 +626,9 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     }
 
     alt_ring = xive_nsr_exception_ring(ring, nsr);
-    target_ringw2 = xive_tctx_word2(&tctx->regs[alt_ring]);
-    cam = be32_to_cpu(target_ringw2);
 
-    /* extract nvp block and index from targeted ring's cam */
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
+    /* Don't check return code since ring is expected to be invalidated */
+    xive2_tctx_get_nvp_indexes(tctx, alt_ring, &nvp_blk, &nvp_idx);
 
     trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
 
@@ -676,11 +675,23 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
 
     /* clear interrupt indication for the context */
-    regs[TM_NSR] = 0;
-    regs[TM_PIPR] = regs[TM_CPPR];
+    alt_regs[TM_NSR] = 0;
+    alt_regs[TM_PIPR] = alt_regs[TM_CPPR];
     xive_tctx_reset_signal(tctx, ring);
 }
 
+static uint8_t xive2_hv_irq_ring(uint8_t nsr)
+{
+    switch (nsr >> 6) {
+    case TM_QW3_NSR_HE_POOL:
+        return TM_QW2_HV_POOL;
+    case TM_QW3_NSR_HE_PHYS:
+        return TM_QW3_HV_PHYS;
+    default:
+        return -1;
+    }
+}
+
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -696,7 +707,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
-    if (!valid) {
+    if (xive2_tctx_get_nvp_indexes(tctx, ring, &nvp_blk, &nvp_idx)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
                       nvp_blk, nvp_idx);
     }
@@ -706,13 +717,25 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
          cur_ring += XIVE_TM_RING_SIZE) {
         uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
         uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
+        bool is_valid = !!(xive_get_field32(TM2_QW1W2_VO, ringw2));
+        uint8_t alt_ring;
         memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
-    }
 
-    /* Active group/crowd interrupts need to be redistributed */
-    nsr = tctx->regs[ring + TM_NSR];
-    if (xive_nsr_indicates_group_exception(ring, nsr)) {
-        xive2_redistribute(xrtr, tctx, ring);
+        /* Skip the rest for USER or invalid contexts */
+        if ((cur_ring == TM_QW0_USER) || !is_valid) {
+            continue;
+        }
+
+        /* Active group/crowd interrupts need to be redistributed */
+        alt_ring = (cur_ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : cur_ring;
+        nsr = tctx->regs[alt_ring + TM_NSR];
+        if (xive_nsr_indicates_group_exception(alt_ring, nsr)) {
+            /* For HV rings, only redistribute if cur_ring matches NSR */
+            if ((cur_ring == TM_QW1_OS) ||
+                (cur_ring == xive2_hv_irq_ring(nsr))) {
+                xive2_redistribute(xrtr, tctx, cur_ring);
+            }
+        }
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
@@ -736,6 +759,18 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
 }
 
+uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW2_HV_POOL);
+}
+
+uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW3_HV_PHYS);
+}
+
 #define REPORT_LINE_GEN1_SIZE       16
 
 static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
@@ -993,37 +1028,40 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+/* returns -1 if ring is invalid, but still populates block and index */
 static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
-                                      uint32_t *nvp_blk, uint32_t *nvp_idx)
+                                      uint8_t *nvp_blk, uint32_t *nvp_idx)
 {
-    uint32_t w2, cam;
+    uint32_t w2;
+    uint32_t cam = 0;
+    int rc = 0;
 
     w2 = xive_tctx_word2(&tctx->regs[ring]);
     switch (ring) {
     case TM_QW1_OS:
         if (!(be32_to_cpu(w2) & TM2_QW1W2_VO)) {
-            return -1;
+            rc = -1;
         }
         cam = xive_get_field32(TM2_QW1W2_OS_CAM, w2);
         break;
     case TM_QW2_HV_POOL:
         if (!(be32_to_cpu(w2) & TM2_QW2W2_VP)) {
-            return -1;
+            rc = -1;
         }
         cam = xive_get_field32(TM2_QW2W2_POOL_CAM, w2);
         break;
     case TM_QW3_HV_PHYS:
         if (!(be32_to_cpu(w2) & TM2_QW3W2_VT)) {
-            return -1;
+            rc = -1;
         }
         cam = xive2_tctx_hw_cam_line(tctx->xptr, tctx);
         break;
     default:
-        return -1;
+        rc = -1;
     }
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    return 0;
+    return rc;
 }
 
 static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
@@ -1031,7 +1069,8 @@ static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
 {
     uint64_t rd;
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t nvp_blk, nvp_idx, xive2_cfg;
+    uint32_t nvp_idx, xive2_cfg;
+    uint8_t nvp_blk;
     Xive2Nvp nvp;
     uint64_t phys_addr;
     uint8_t OGen = 0;
@@ -1084,7 +1123,8 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     uint8_t old_cppr, backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
     bool group_enabled;
-    uint32_t nvp_blk, nvp_idx;
+    uint8_t nvp_blk;
+    uint32_t nvp_idx;
     Xive2Nvp nvp;
     int rc;
     uint8_t nsr = regs[TM_NSR];
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index ff02ce2549..a91b99057c 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -140,6 +140,10 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size);
+uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index e222038143..f82054661b 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -209,9 +209,9 @@ static inline uint32_t xive2_nvp_idx(uint32_t cam_line)
     return cam_line & ((1 << XIVE2_NVP_SHIFT) - 1);
 }
 
-static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
+static inline uint8_t xive2_nvp_blk(uint32_t cam_line)
 {
-    return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
+    return (uint8_t)((cam_line >> XIVE2_NVP_SHIFT) & 0xf);
 }
 
 void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
-- 
2.47.1


