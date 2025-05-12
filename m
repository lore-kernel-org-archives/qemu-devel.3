Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B45C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbw-0004QP-Pa; Sun, 11 May 2025 23:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbW-000255-CL; Sun, 11 May 2025 23:13:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbU-0006yt-6F; Sun, 11 May 2025 23:13:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-22e6344326dso39843505ad.1; 
 Sun, 11 May 2025 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019598; x=1747624398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWhWRZATIJ3bSZKLCT4T6wltmeKQkbW20fOvUpjd3GE=;
 b=A3o8U6g9b6GWaPwaZZtx3Zp0mv54d9fndElZ4JMP+lCH/+V/p08UFMk/mjB8tRFDXZ
 62AsuUhkRwJgj2LKB7jyzYVw91jxFz63TxWnQ8Dm6FzVygG90yLaBzviec3piqXu8Kxs
 E0wk9rxivfl3py/2Cm/4YKClffvJakWbKSTfUm/MuvV5hcEgtd/HoadYavZDtCCS4k0r
 tIbpDwYzZXztCFh4UVFTDbnll/YuWQi8XJwgMb6GN8oMArE0NGaVx7B6taO1Ka2P8Loh
 bI2/DnM0iXaR05WRU9DG5Ept6svBSbsMY5ZrzLFG+Te/6XVYwD40XIcHY97p4Du3RE7m
 cZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019598; x=1747624398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWhWRZATIJ3bSZKLCT4T6wltmeKQkbW20fOvUpjd3GE=;
 b=RfGOzzFiVRqwE2puQWMECDKsBRmp9qYZWderj21pRmPt34CdoQ25vdUEEKQpWBMCwx
 SXg0GDiPEBPY3VSJGNd+S9nXyeTec3gWnDorcljnEtMHuCqvNHZbFHkxGJfv4sM/3h94
 jS2M3BiHl7eFZeCSlXCCOMk2CzP045G0+OkTlQBXXoZsnGslTACaNikGMIdyJsIJo6ik
 /qAx/Fbgj54NQDfhq8zcgfDrnbMYhx9vbQ9sGwJY/9SIlBSXTi9SSkN7EjgWbh/dmEMh
 UjqLv5wjMQ1UepkWcV6TIFZbmql6JxU8xoUNmKOn8a/kdVVRLBMVirBOGWIF9/D5M5y6
 VYng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVluTlDjftHy5NgPz7HOxLKrQiCf1D7kzRHdiaprfTc5pNMzankAeJakrWXe+XYnJg74ArS96gl3IiM@nongnu.org
X-Gm-Message-State: AOJu0YyGP7DF0aInz95cmdRPYhUyYtB3gAqbxp7dr6DmjR4uOQycd9+a
 I3OOrl+GAlCMKb+rJXNSxl7yrbAXTOcgBdv7poOlkc+ZJUyAhHcaRjmTmw==
X-Gm-Gg: ASbGncvnAVwyqkku5HO27nwdwRDIPKOIqWr3TGyMx1RCaO0VhpGK93XNkJwt1i7dMWB
 0cXVHngsatf+wpmqeFiusuXQTSc1H4qvDR8DMoyiNsSNA3qCgGKpzXGMklMwaTzCxh6d3wtpPlv
 ivd0SvnYd9dPA5yjSeZCr/FDB5uXNqZiALoCNWONQJnFy6bXgxxRr0SLFi936qSSlmlGGd2nNnm
 icJYwVZhllfbSV5AvEJ4RhIxHZXHrL54UGu7sTOrQAoDxK4QPuw42F5nTh2Wavv+ZdQz/kgWPT3
 tVF5ISxrQOkVIOhENhooGWgoIQzZAj6soG4dMYkjmmieaM+Wj40cSzPLMw==
X-Google-Smtp-Source: AGHT+IGN08/5LZZ9pJZdWEB26MS5egKXpU6W7RA+u0IAlVCNooWJ/56clRMNWhjYj9viHA06lq/4Zw==
X-Received: by 2002:a17:903:41d2:b0:220:c4e8:3b9d with SMTP id
 d9443c01a7336-22fc8d98a2dmr154378255ad.37.1747019597877; 
 Sun, 11 May 2025 20:13:17 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 35/50] ppc/xive: Add xive_tctx_pipr_set() helper function
Date: Mon, 12 May 2025 13:10:44 +1000
Message-ID: <20250512031100.439842-36-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

Have xive_tctx_notify() also set the new PIPR value and rename it to
xive_tctx_pipr_set(). This can replace the last xive_tctx_pipr_update()
caller because it does not need to update IPB (it already sets it).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c        | 39 +++++++++++----------------------------
 hw/intc/xive2.c       | 16 +++++++---------
 include/hw/ppc/xive.h |  5 ++---
 3 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d5dbeab6bd..4659821d4a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -125,12 +125,16 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
     return ((uint64_t)nsr << 8) | sig_regs[TM_CPPR];
 }
 
-void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
+/* Change PIPR and calculate NSR and irq based on PIPR, CPPR, group */
+void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t pipr,
+                        uint8_t group_level)
 {
     uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
-    if (sig_regs[TM_PIPR] < sig_regs[TM_CPPR]) {
+    sig_regs[TM_PIPR] = pipr;
+
+    if (pipr < sig_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
             sig_regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
@@ -145,7 +149,7 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
             g_assert_not_reached();
         }
         trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], sig_regs[TM_PIPR],
+                               regs[TM_IPB], pipr,
                                sig_regs[TM_CPPR], sig_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
     } else {
@@ -213,29 +217,10 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         }
     }
 
-    sig_regs[TM_PIPR] = pipr_min;
-
-    /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring_min, 0);
+    /* CPPR has changed, this may present or preclude a pending exception */
+    xive_tctx_pipr_set(tctx, ring_min, pipr_min, 0);
 }
 
-void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
-                           uint8_t group_level)
-{
-    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
-    uint8_t *regs = &tctx->regs[ring];
-
-    if (group_level == 0) {
-        /* VP-specific */
-        regs[TM_IPB] |= xive_priority_to_ipb(priority);
-        sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
-    } else {
-        /* VP-group */
-        sig_regs[TM_PIPR] = xive_priority_to_pipr(priority);
-    }
-    xive_tctx_notify(tctx, ring, group_level);
- }
-
 static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
@@ -244,8 +229,7 @@ static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
     /* Does not support a presented group interrupt */
     g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
 
-    sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
-    xive_tctx_notify(tctx, ring, 0);
+    xive_tctx_pipr_set(tctx, ring, xive_ipb_to_pipr(regs[TM_IPB]), 0);
 }
 
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
@@ -264,8 +248,7 @@ void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
     }
     g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
     g_assert(pipr < sig_regs[TM_PIPR]);
-    sig_regs[TM_PIPR] = pipr;
-    xive_tctx_notify(tctx, ring, group_level);
+    xive_tctx_pipr_set(tctx, ring, pipr, group_level);
 }
 
 /*
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index b9ee8c9e9f..8c8dab3aa2 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -966,10 +966,10 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
 
     /*
-     * Compute the PIPR based on the restored state.
+     * Set the PIPR/NSR based on the restored state.
      * It will raise the External interrupt signal if needed.
      */
-    xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);
+    xive_tctx_pipr_set(tctx, TM_QW1_OS, backlog_prio, backlog_level);
 }
 
 /*
@@ -1144,8 +1144,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
             }
 
             /* interrupt is VP directed, pending in IPB */
-            sig_regs[TM_PIPR] = cppr;
-            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
+            xive_tctx_pipr_set(tctx, ring, cppr, 0);
             return;
         } else {
             /* CPPR was lowered, but still above PIPR. No action needed. */
@@ -1255,11 +1254,10 @@ again:
         pipr_min = backlog_prio;
     }
 
-    /* PIPR should not be set to a value greater than CPPR */
-    sig_regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
-
-    /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring_min, group_level);
+    if (pipr_min > cppr) {
+        pipr_min = cppr;
+    }
+    xive_tctx_pipr_set(tctx, ring_min, pipr_min, group_level);
 }
 
 void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a3c2f50ece..2372d1014b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -584,12 +584,11 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf);
 Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
-void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
-                           uint8_t group_level);
+void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                        uint8_t group_level);
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
-void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
 uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
 
 /*
-- 
2.47.1


