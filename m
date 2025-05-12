Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D03C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcA-0005X3-EH; Sun, 11 May 2025 23:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbQ-0001Kj-Dw; Sun, 11 May 2025 23:13:16 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbN-0006xy-9j; Sun, 11 May 2025 23:13:16 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b0db0b6a677so3603279a12.2; 
 Sun, 11 May 2025 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019591; x=1747624391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxIgXzORnqNF+QYVni5wn4pGK5Tuqpb76omRpVktP20=;
 b=JDTgUDQsr1cBlQ8I6UZK/l8bN5DEF2rylEUWKj/fCLKz49C72yeNkQJS2LfSMciGlY
 CoAhWYAyCGhZnYHLaRLhuQnRlVLWLdJHv9Bk6LxgpXjcq5GxRZ64WYCk48zu+LEi4MWc
 peAYYXspduBdI7jjXl2Cfvw4TzUJcnZ36TT5vf+v3KoxF54srb7p5sYGT8m1zKIVTXf0
 vIVenahWPM+Hl1kTAAqE48s9Ej+fLseEIaaaqaWFYHNuzOMX6X0YZSUTfCKJqiJa3hfB
 DYF2L6r3hXmRQ0HmhtofKBbtaRvL6HCydt1BBIEbMM6VIrB5BoQLSJbO0ura5QDv6SqK
 Wdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019591; x=1747624391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxIgXzORnqNF+QYVni5wn4pGK5Tuqpb76omRpVktP20=;
 b=eUcC43C45rTIkwYE5YbVbIePpY9SktWfE46PgrBg0058azcSxswmC8WMe5OLZcsYWO
 wUtT1YMZxiwPvV/mSTwkmcE4erJr8iij6MaA2FDkHTdTRpssL9vobhiR89EHhqtYOcBE
 1UMjaVD0iu6Hs3+oeokbBABtoORZ313J4gv//akyTZP+jZGR5mbVvA2lJS3PJ+GivT5M
 gdhAMQ7B6bkx32sUqHk8frkPrWs5VzfC932XWNSQtYK7bEn2337zvJmaY2wWVGXfUXuH
 fRGsgct68r8wUL9GtbvMJk0Db6PxwIVlWZP0P2Hb+v9shhwI7glvVwB6FLdnOpVUCJst
 zPEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSVtd2MZ0eENmRvBsnoRzyJIyRaVr/3SNUn7n5wEHkFS9sxpfdh2Xq97A33YvNJLflKNaPESiWxrhc@nongnu.org
X-Gm-Message-State: AOJu0Yw1aysizbpf3aD6n+aTwfv/6D398KCo/s047yeEF5M6CGPN+LVN
 D/MV1UApa8Xo73/uZ8O9hUIDmcH4xOiPbR/JT5AOHohpSuYkHQIqFvgnMg==
X-Gm-Gg: ASbGncuBq3ugD/7080mFWmZNFNBIxS88sdgh0DBrYUMaA55w0B5kPQdB4Vs24luOTMk
 2EJlT1KH8MB+YwAm5oXP+l13EsnoKRG2+3z5IIWBjL78Xap90w/SJZulAwDJBs0/VHbWkC8NLaz
 9Mx2w7IJXOw9laZG3wqhNp+5TpQIc+4f6MKY9dVu/Y74Xyp292CG062TAMpQo8qX04x821IkqH6
 j4KqK7wt0IolSVTggSXPLAiMrCGYn10jEnUF1KufQkj390J8uFTRkOVEuv7pf+IJNZ+W56PelD3
 VV0bGmX9Cc6hhuKuj0aIlfAqPgdFrQMTmnEApQ6+I2+H3we6/cHefzXm7w==
X-Google-Smtp-Source: AGHT+IHcakdbIc7Ffiupd62stq73L9mO5vGzuBLP6awZAeheslTJcuJblCeW+f8k9Lz+2scMPZQa+w==
X-Received: by 2002:a05:6a20:ce49:b0:1f5:6e71:e55 with SMTP id
 adf61e73a8af0-215ababa250mr17826415637.6.1747019590661; 
 Sun, 11 May 2025 20:13:10 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 33/50] ppc/xive: tctx signaling registers rework
Date: Mon, 12 May 2025 13:10:42 +1000
Message-ID: <20250512031100.439842-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x535.google.com
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

The tctx "signaling" registers (PIPR, CPPR, NSR) raise an interrupt on
the target CPU thread. The POOL and PHYS rings both raise hypervisor
interrupts, so they both share one set of signaling registers in the
PHYS ring. The PHYS NSR register contains a field that indicates which
ring has presented the interrupt being signaled to the CPU.

This sharing results in all the "alt_regs" throughout the code. alt_regs
is not very descriptive, and worse is that the name is used for
conversions in both directions, i.e., to find the presenting ring from
the signaling ring, and the signaling ring from the presenting ring.

Instead of alt_regs, use the names sig_regs and sig_ring, and regs and
ring for the presenting ring being worked on. Add a helper function to
get the sign_regs, and add some asserts to ensure the POOL regs are
never used to signal interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        | 112 ++++++++++++++++++++++--------------------
 hw/intc/xive2.c       |  94 ++++++++++++++++-------------------
 include/hw/ppc/xive.h |  26 +++++++++-
 3 files changed, 126 insertions(+), 106 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5ff1b8f024..4e0c71d684 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -80,69 +80,77 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
         }
 }
 
-uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
+/*
+ * interrupt is accepted on the presentation ring, for PHYS ring the NSR
+ * directs it to the PHYS or POOL rings.
+ */
+uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
 {
-    uint8_t *regs = &tctx->regs[ring];
-    uint8_t nsr = regs[TM_NSR];
+    uint8_t *sig_regs = &tctx->regs[sig_ring];
+    uint8_t nsr = sig_regs[TM_NSR];
 
-    qemu_irq_lower(xive_tctx_output(tctx, ring));
+    g_assert(sig_ring == TM_QW1_OS || sig_ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
 
-    if (xive_nsr_indicates_exception(ring, nsr)) {
-        uint8_t cppr = regs[TM_PIPR];
-        uint8_t alt_ring;
-        uint8_t *alt_regs;
+    if (xive_nsr_indicates_exception(sig_ring, nsr)) {
+        uint8_t cppr = sig_regs[TM_PIPR];
+        uint8_t ring;
+        uint8_t *regs;
 
-        alt_ring = xive_nsr_exception_ring(ring, nsr);
-        alt_regs = &tctx->regs[alt_ring];
+        ring = xive_nsr_exception_ring(sig_ring, nsr);
+        regs = &tctx->regs[ring];
 
-        regs[TM_CPPR] = cppr;
+        sig_regs[TM_CPPR] = cppr;
 
         /*
          * If the interrupt was for a specific VP, reset the pending
          * buffer bit, otherwise clear the logical server indicator
          */
-        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
-            alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        if (!xive_nsr_indicates_group_exception(sig_ring, nsr)) {
+            regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
         }
 
         /* Clear the exception from NSR */
-        regs[TM_NSR] = 0;
+        sig_regs[TM_NSR] = 0;
 
-        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
-                               alt_regs[TM_IPB], regs[TM_PIPR],
-                               regs[TM_CPPR], regs[TM_NSR]);
+        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
+                               regs[TM_IPB], sig_regs[TM_PIPR],
+                               sig_regs[TM_CPPR], sig_regs[TM_NSR]);
     }
 
-    return ((uint64_t)nsr << 8) | regs[TM_CPPR];
+    return ((uint64_t)nsr << 8) | sig_regs[TM_CPPR];
 }
 
 void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *alt_regs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
-    if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
+    if (sig_regs[TM_PIPR] < sig_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
-            regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
+            sig_regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
             break;
         case TM_QW2_HV_POOL:
-            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
+            sig_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
             break;
         case TM_QW3_HV_PHYS:
-            regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
+            sig_regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
             break;
         default:
             g_assert_not_reached();
         }
         trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], alt_regs[TM_PIPR],
-                               alt_regs[TM_CPPR], alt_regs[TM_NSR]);
+                               regs[TM_IPB], sig_regs[TM_PIPR],
+                               sig_regs[TM_CPPR], sig_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
     } else {
-        alt_regs[TM_NSR] = 0;
+        sig_regs[TM_NSR] = 0;
         qemu_irq_lower(xive_tctx_output(tctx, ring));
     }
 }
@@ -159,25 +167,32 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
-    uint8_t *regs = &tctx->regs[ring];
+    uint8_t *sig_regs = &tctx->regs[ring];
     uint8_t pipr_min;
     uint8_t ring_min;
 
+    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    /* XXX: should show pool IPB for PHYS ring */
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
-                             regs[TM_IPB], regs[TM_PIPR],
-                             cppr, regs[TM_NSR]);
+                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
+                             cppr, sig_regs[TM_NSR]);
 
     if (cppr > XIVE_PRIORITY_MAX) {
         cppr = 0xff;
     }
 
-    tctx->regs[ring + TM_CPPR] = cppr;
+    sig_regs[TM_CPPR] = cppr;
 
     /*
      * Recompute the PIPR based on local pending interrupts.  The PHYS
      * ring must take the minimum of both the PHYS and POOL PIPR values.
      */
-    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
+    pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
     ring_min = ring;
 
     /* PHYS updates also depend on POOL values */
@@ -186,7 +201,6 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
         /* POOL values only matter if POOL ctx is valid */
         if (pool_regs[TM_WORD2] & 0x80) {
-
             uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
 
             /*
@@ -200,7 +214,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         }
     }
 
-    regs[TM_PIPR] = pipr_min;
+    sig_regs[TM_PIPR] = pipr_min;
 
     /* CPPR has changed, check if we need to raise a pending exception */
     xive_tctx_notify(tctx, ring_min, 0);
@@ -208,56 +222,50 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
 void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                            uint8_t group_level)
- {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *alt_regs = &tctx->regs[alt_ring];
+{
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
     if (group_level == 0) {
         /* VP-specific */
         regs[TM_IPB] |= xive_priority_to_ipb(priority);
-        alt_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+        sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
     } else {
         /* VP-group */
-        alt_regs[TM_PIPR] = xive_priority_to_pipr(priority);
+        sig_regs[TM_PIPR] = xive_priority_to_pipr(priority);
     }
     xive_tctx_notify(tctx, ring, group_level);
  }
 
 static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
     /* Does not support a presented group interrupt */
-    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR]));
+    g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
 
-    aregs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+    sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
     xive_tctx_notify(tctx, ring, 0);
 }
 
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
     uint8_t pipr = xive_priority_to_pipr(priority);
 
     if (group_level == 0) {
         regs[TM_IPB] |= xive_priority_to_ipb(priority);
-        if (pipr >= aregs[TM_PIPR]) {
+        if (pipr >= sig_regs[TM_PIPR]) {
             /* VP interrupts can come here with lower priority than PIPR */
             return;
         }
     }
     g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
-    g_assert(pipr < aregs[TM_PIPR]);
-    aregs[TM_PIPR] = pipr;
+    g_assert(pipr < sig_regs[TM_PIPR]);
+    sig_regs[TM_PIPR] = pipr;
     xive_tctx_notify(tctx, ring, group_level);
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f91109b84a..b9ee8c9e9f 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -606,11 +606,9 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
 
 static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 {
-    uint8_t *regs = &tctx->regs[ring];
-    uint8_t *alt_regs = (ring == TM_QW2_HV_POOL) ? &tctx->regs[TM_QW3_HV_PHYS] :
-                                                   regs;
-    uint8_t nsr = alt_regs[TM_NSR];
-    uint8_t pipr = alt_regs[TM_PIPR];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+    uint8_t nsr = sig_regs[TM_NSR];
+    uint8_t pipr = sig_regs[TM_PIPR];
     uint8_t crowd = NVx_CROWD_LVL(nsr);
     uint8_t group = NVx_GROUP_LVL(nsr);
     uint8_t nvgc_blk, end_blk, nvp_blk;
@@ -618,19 +616,16 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     Xive2Nvgc nvgc;
     uint8_t prio_limit;
     uint32_t cfg;
-    uint8_t alt_ring;
 
     /* redistribution is only for group/crowd interrupts */
     if (!xive_nsr_indicates_group_exception(ring, nsr)) {
         return;
     }
 
-    alt_ring = xive_nsr_exception_ring(ring, nsr);
-
     /* Don't check return code since ring is expected to be invalidated */
-    xive2_tctx_get_nvp_indexes(tctx, alt_ring, &nvp_blk, &nvp_idx);
+    xive2_tctx_get_nvp_indexes(tctx, ring, &nvp_blk, &nvp_idx);
 
-    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
+    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
 
     trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
@@ -675,23 +670,11 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
 
     /* clear interrupt indication for the context */
-    alt_regs[TM_NSR] = 0;
-    alt_regs[TM_PIPR] = alt_regs[TM_CPPR];
+    sig_regs[TM_NSR] = 0;
+    sig_regs[TM_PIPR] = sig_regs[TM_CPPR];
     xive_tctx_reset_signal(tctx, ring);
 }
 
-static uint8_t xive2_hv_irq_ring(uint8_t nsr)
-{
-    switch (nsr >> 6) {
-    case TM_QW3_NSR_HE_POOL:
-        return TM_QW2_HV_POOL;
-    case TM_QW3_NSR_HE_PHYS:
-        return TM_QW3_HV_PHYS;
-    default:
-        return -1;
-    }
-}
-
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -718,7 +701,8 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
         uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
         bool is_valid = !!(xive_get_field32(TM2_QW1W2_VO, ringw2));
-        uint8_t alt_ring;
+        uint8_t *sig_regs;
+
         memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
 
         /* Skip the rest for USER or invalid contexts */
@@ -727,12 +711,11 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         }
 
         /* Active group/crowd interrupts need to be redistributed */
-        alt_ring = (cur_ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : cur_ring;
-        nsr = tctx->regs[alt_ring + TM_NSR];
-        if (xive_nsr_indicates_group_exception(alt_ring, nsr)) {
-            /* For HV rings, only redistribute if cur_ring matches NSR */
-            if ((cur_ring == TM_QW1_OS) ||
-                (cur_ring == xive2_hv_irq_ring(nsr))) {
+        sig_regs = xive_tctx_signal_regs(tctx, ring);
+        nsr = sig_regs[TM_NSR];
+        if (xive_nsr_indicates_group_exception(cur_ring, nsr)) {
+            /* Ensure ring matches NSR (for HV NSR POOL vs PHYS rings) */
+            if (cur_ring == xive_nsr_exception_ring(cur_ring, nsr)) {
                 xive2_redistribute(xrtr, tctx, cur_ring);
             }
         }
@@ -1118,7 +1101,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
 /* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
 static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
-    uint8_t *regs = &tctx->regs[ring];
+    uint8_t *sig_regs = &tctx->regs[ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
     uint8_t old_cppr, backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
@@ -1127,33 +1110,41 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     uint32_t nvp_idx;
     Xive2Nvp nvp;
     int rc;
-    uint8_t nsr = regs[TM_NSR];
+    uint8_t nsr = sig_regs[TM_NSR];
+
+    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
 
+    /* XXX: should show pool IPB for PHYS ring */
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
-                             regs[TM_IPB], regs[TM_PIPR],
+                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
                              cppr, nsr);
 
     if (cppr > XIVE_PRIORITY_MAX) {
         cppr = 0xff;
     }
 
-    old_cppr = regs[TM_CPPR];
-    regs[TM_CPPR] = cppr;
+    old_cppr = sig_regs[TM_CPPR];
+    sig_regs[TM_CPPR] = cppr;
 
     /* Handle increased CPPR priority (lower value) */
     if (cppr < old_cppr) {
-        if (cppr <= regs[TM_PIPR]) {
+        if (cppr <= sig_regs[TM_PIPR]) {
             /* CPPR lowered below PIPR, must un-present interrupt */
             if (xive_nsr_indicates_exception(ring, nsr)) {
                 if (xive_nsr_indicates_group_exception(ring, nsr)) {
                     /* redistribute precluded active grp interrupt */
-                    xive2_redistribute(xrtr, tctx, ring);
+                    xive2_redistribute(xrtr, tctx,
+                                       xive_nsr_exception_ring(ring, nsr));
                     return;
                 }
             }
 
             /* interrupt is VP directed, pending in IPB */
-            regs[TM_PIPR] = cppr;
+            sig_regs[TM_PIPR] = cppr;
             xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
             return;
         } else {
@@ -1174,9 +1165,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
      * be adjusted below if needed in case of pending group interrupts.
      */
 again:
-    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
-    group_enabled = !!regs[TM_LGS];
-    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
+    pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
+    group_enabled = !!sig_regs[TM_LGS];
+    lsmfb_min = group_enabled ? sig_regs[TM_LSMFB] : 0xff;
     ring_min = ring;
     group_level = 0;
 
@@ -1265,7 +1256,7 @@ again:
     }
 
     /* PIPR should not be set to a value greater than CPPR */
-    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
+    sig_regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
 
     /* CPPR has changed, check if we need to raise a pending exception */
     xive_tctx_notify(tctx, ring_min, group_level);
@@ -1490,9 +1481,7 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *alt_regs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
 
     /*
      * The xive2_presenter_tctx_match() above tells if there's a match
@@ -1500,7 +1489,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
      * priority to know if the thread can take the interrupt now or if
      * it is precluded.
      */
-    if (priority < alt_regs[TM_PIPR]) {
+    if (priority < sig_regs[TM_PIPR]) {
         return false;
     }
     return true;
@@ -1640,14 +1629,13 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
                              &match)) {
         XiveTCTX *tctx = match.tctx;
         uint8_t ring = match.ring;
-        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-        uint8_t *aregs = &tctx->regs[alt_ring];
-        uint8_t nsr = aregs[TM_NSR];
+        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+        uint8_t nsr = sig_regs[TM_NSR];
         uint8_t group_level;
 
-        if (priority < aregs[TM_PIPR] &&
-            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
-            xive2_redistribute(xrtr, tctx, alt_ring);
+        if (priority < sig_regs[TM_PIPR] &&
+            xive_nsr_indicates_group_exception(ring, nsr)) {
+            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
         }
 
         group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 0d6b11e818..a3c2f50ece 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -539,7 +539,7 @@ static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
 }
 
 /*
- * XIVE Thread Interrupt Management Aera (TIMA)
+ * XIVE Thread Interrupt Management Area (TIMA)
  *
  * This region gives access to the registers of the thread interrupt
  * management context. It is four page wide, each page providing a
@@ -551,6 +551,30 @@ static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
 #define XIVE_TM_OS_PAGE         0x2
 #define XIVE_TM_USER_PAGE       0x3
 
+/*
+ * The TCTX (TIMA) has 4 rings (phys, pool, os, user), but only signals
+ * (raises an interrupt on) the CPU from 3 of them. Phys and pool both
+ * cause a hypervisor privileged interrupt so interrupts presented on
+ * those rings signal using the phys ring. This helper returns the signal
+ * regs from the given ring.
+ */
+static inline uint8_t *xive_tctx_signal_regs(XiveTCTX *tctx, uint8_t ring)
+{
+    /*
+     * This is a good point to add invariants to ensure nothing has tried to
+     * signal using the POOL ring.
+     */
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    if (ring == TM_QW2_HV_POOL) {
+        /* POOL and PHYS rings share the signal regs (PIPR, NSR, CPPR) */
+        ring = TM_QW3_HV_PHYS;
+    }
+    return &tctx->regs[ring];
+}
+
 void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                         uint64_t value, unsigned size);
 uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
-- 
2.47.1


