Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FCEC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbs-0003xx-HY; Sun, 11 May 2025 23:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJb0-0000Ql-PI; Sun, 11 May 2025 23:12:52 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJax-0006sv-Dz; Sun, 11 May 2025 23:12:49 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so243543b3a.3; 
 Sun, 11 May 2025 20:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019565; x=1747624365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vOCzHEshZdF2PGmhQxaKIQEJ3+Y4NOpAgvsqlFnuDNc=;
 b=AuQmOT9O9OS4jFeio4Y6v4KLaiF4JHy7Gw9EWxouJk2kmQDUFlT08GXjWq6bNoZ5oJ
 YXL05ktH+viFmgSYRjEI8ZAzvGe1OlmqTwjaaNN1rD9+jwEn7biW4k8xmyAb5ceixA0g
 aui0BveeqUoakmILRjsCQ12QGTxsMKT9TotsnwCEXuEi9/pZEKd5atSBQrZ9duqnrS6l
 IFGiyxpeuZKOcaBt5DgRA8MN6+9htmJJGMoroLZgA78KYI9V0ScvvLOncRmXNB+gT3Eg
 lgiGNtvPLpC4sEviIAl3up5a2D+08zZsjZVcMJ3hmEvWmfagUrQ1WUAxcZPYuiT+Imi1
 5pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019565; x=1747624365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vOCzHEshZdF2PGmhQxaKIQEJ3+Y4NOpAgvsqlFnuDNc=;
 b=RID03fc7m/IohSo1KOj0e4XBFfd+F7epjWn+wv8q7E8qw4RDZOZZg4HMPdNG65moWa
 RNuutC79vodSZsBYxJkK3mOH7ftLn7P5rXwUvgwqdwwa6jnKOEuQjFFeMO/Ed1ZSUb5p
 F3fgAXh+aYJegFlowsI3HGuCZ+OK5cXxnb4dqAH8eaj9Te4oXDPaa2rVS5fGGTIwiGoh
 lKrul3+Uh+gd/ZGsYdeaZLk9fIeyOJ3eB+o5gYT0ZcN6Ddg59XekXwF571UDBx2vzNF9
 jeA65U5ENX3Nkv/pQDIrmY9A17fWtCZb70FqeWjDp59h+TUjdOlH2+dUYpsPS0qNLSuh
 2TFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhs9j3B8VVPjUMk2asFSGXhzd2jOj5k+AQn2NHRPINZadJH8nABrh2jvCPVWnBPocP4vTGlXpArrum@nongnu.org
X-Gm-Message-State: AOJu0Ywl/sAC0s3/k31rdEVIAwCSzadkyytXj+5fNV6txbUkMLswlLQi
 vCdtxbIrXnVlZj9HqHV4wv9a3UPCDIdqZlA/UCvAu7GfSQf2J3HvftkW+A==
X-Gm-Gg: ASbGncsDaeL4OsqUp79gDdYcUsbBV2CCMP7IVCBd7nGcc09G1ZgzULRUxLI8Yla59pQ
 RiBrTO0YX+PjYX8f835ftTpzvMhL3oTrrrKutaJVpWJyD9ypzNOYq1QGsEeBcBldQfv/WlwD1g8
 m3nNpAxlOk7BTXfA0rY4pIAb4hM3HFduosY4KbKhcMArzlr9zhM/lp2rYUujBKxAAWkdshAuAP/
 yfzSM2353IXYlaMFgzF2JVT6WnNYj2x2dI4KA9/fJRJi7+xUcmGX0gOH9RVGY5NzI+6YyKQdJ3K
 L2qQMFpaSHJmoOHL4NkW06fUn3vs5mqNfgzmC679cCPwVEVGgGSjjjHA7w==
X-Google-Smtp-Source: AGHT+IE1hybcP26oESchPASlFxfMGrKCSWIkA3tZv4F+/7dW6JQ+lTvZZN7bjj+MlO8JN+jIFyFh/A==
X-Received: by 2002:a05:6a21:9017:b0:1f5:6878:1a43 with SMTP id
 adf61e73a8af0-215abb0b773mr17108008637.14.1747019565037; 
 Sun, 11 May 2025 20:12:45 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:44 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 26/50] ppc/xive2: Redistribute group interrupt precluded by
 CPPR update
Date: Mon, 12 May 2025 13:10:35 +1000
Message-ID: <20250512031100.439842-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

Add support for redistributing a presented group interrupt if it
is precluded as a result of changing the CPPR value. Without this,
group interrupts can be lost.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive2.c | 82 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 68be138335..92dbbad8d4 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -601,20 +601,37 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
-static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
-                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_t ring)
+static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 {
-    uint8_t nsr = tctx->regs[ring + TM_NSR];
+    uint8_t *regs = &tctx->regs[ring];
+    uint8_t nsr = regs[TM_NSR];
+    uint8_t pipr = regs[TM_PIPR];
     uint8_t crowd = NVx_CROWD_LVL(nsr);
     uint8_t group = NVx_GROUP_LVL(nsr);
-    uint8_t nvgc_blk;
-    uint8_t nvgc_idx;
-    uint8_t end_blk;
-    uint32_t end_idx;
-    uint8_t pipr = tctx->regs[ring + TM_PIPR];
+    uint8_t nvgc_blk, end_blk, nvp_blk;
+    uint32_t nvgc_idx, end_idx, nvp_idx;
     Xive2Nvgc nvgc;
     uint8_t prio_limit;
     uint32_t cfg;
+    uint8_t alt_ring;
+    uint32_t target_ringw2;
+    uint32_t cam;
+    bool valid;
+    bool hw;
+
+    /* redistribution is only for group/crowd interrupts */
+    if (!xive_nsr_indicates_group_exception(ring, nsr)) {
+        return;
+    }
+
+    alt_ring = xive_nsr_exception_ring(ring, nsr);
+    target_ringw2 = xive_tctx_word2(&tctx->regs[alt_ring]);
+    cam = be32_to_cpu(target_ringw2);
+
+    /* extract nvp block and index from targeted ring's cam */
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
+
+    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
 
     trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
@@ -659,8 +676,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
 
     /* clear interrupt indication for the context */
-    tctx->regs[ring + TM_NSR] = 0;
-    tctx->regs[ring + TM_PIPR] = tctx->regs[ring + TM_CPPR];
+    regs[TM_NSR] = 0;
+    regs[TM_PIPR] = regs[TM_CPPR];
     xive_tctx_reset_signal(tctx, ring);
 }
 
@@ -695,7 +712,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     /* Active group/crowd interrupts need to be redistributed */
     nsr = tctx->regs[ring + TM_NSR];
     if (xive_nsr_indicates_group_exception(ring, nsr)) {
-        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
+        xive2_redistribute(xrtr, tctx, ring);
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
@@ -1059,6 +1076,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
 }
 
+/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
 static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
@@ -1069,10 +1087,11 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     uint32_t nvp_blk, nvp_idx;
     Xive2Nvp nvp;
     int rc;
+    uint8_t nsr = regs[TM_NSR];
 
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
                              regs[TM_IPB], regs[TM_PIPR],
-                             cppr, regs[TM_NSR]);
+                             cppr, nsr);
 
     if (cppr > XIVE_PRIORITY_MAX) {
         cppr = 0xff;
@@ -1081,6 +1100,35 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     old_cppr = regs[TM_CPPR];
     regs[TM_CPPR] = cppr;
 
+    /* Handle increased CPPR priority (lower value) */
+    if (cppr < old_cppr) {
+        if (cppr <= regs[TM_PIPR]) {
+            /* CPPR lowered below PIPR, must un-present interrupt */
+            if (xive_nsr_indicates_exception(ring, nsr)) {
+                if (xive_nsr_indicates_group_exception(ring, nsr)) {
+                    /* redistribute precluded active grp interrupt */
+                    xive2_redistribute(xrtr, tctx, ring);
+                    return;
+                }
+            }
+
+            /* interrupt is VP directed, pending in IPB */
+            regs[TM_PIPR] = cppr;
+            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
+            return;
+        } else {
+            /* CPPR was lowered, but still above PIPR. No action needed. */
+            return;
+        }
+    }
+
+    /* CPPR didn't change, nothing needs to be done */
+    if (cppr == old_cppr) {
+        return;
+    }
+
+    /* CPPR priority decreased (higher value) */
+
     /*
      * Recompute the PIPR based on local pending interrupts. It will
      * be adjusted below if needed in case of pending group interrupts.
@@ -1129,16 +1177,6 @@ again:
         return;
     }
 
-    if (cppr < old_cppr) {
-        /*
-         * FIXME: check if there's a group interrupt being presented
-         * and if the new cppr prevents it. If so, then the group
-         * interrupt needs to be re-added to the backlog and
-         * re-triggered (see re-trigger END info in the NVGC
-         * structure)
-         */
-    }
-
     if (group_enabled &&
         lsmfb_min < cppr &&
         lsmfb_min < pipr_min) {
-- 
2.47.1


