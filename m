Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798EBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcW-0007Dq-1b; Sun, 11 May 2025 23:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc2-000522-Uo; Sun, 11 May 2025 23:13:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJc0-00073E-SC; Sun, 11 May 2025 23:13:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so32629115ad.2; 
 Sun, 11 May 2025 20:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019631; x=1747624431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKRQ/jspPj1VcCbebrp6U4yg+D1vklbVCURQdOWBTCk=;
 b=ib3cg/YjOdTNqb+QzGgudG30C5j8ugALX5JlRBDBYzbdL3eFdo6oxT/jBrg/H17sK1
 73CSF9Rn6OgwIZt9XaLWafGFLKNcYf/FfRcgtbuGM/V5hqNEsyUDBnioUAJEYdRxYlRI
 x+thKHZeuldvOvteW8oVtmgnP1Q558z98xnzVOqodODc/Btvd8uuZ2uSEUMWQ9U4L5vy
 nVrVsyImtMgbdDulB3NEbCmE8MVoJDWtkE5SDoP8fXES0jqYYTYfhEhM5YYbyPkUw96K
 SQXlGKHbtEOfHj7YJOWUC8TDTy1KZ4J9I15h/lWXF4vD1Pbf5xAnGlFFbYXmxRqq9laI
 XyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019631; x=1747624431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKRQ/jspPj1VcCbebrp6U4yg+D1vklbVCURQdOWBTCk=;
 b=WHBHTywpHD2UHJn4bmR1f2lJRUZv16Ds1k3x+pdbOsyseLO7rNKkGIOjNeS0aghFaI
 kmzHlYckfI9VSPasV9MwYLmPe4yvNBuIzSCBGQJ7hJer//ej9ikrROX956JTYijtz+GU
 8FofvPQQYAVdPtgT7k/RAO5almNL/8Mv5Nq3BZk4kjHFs255K3HSQKpSIsUv3Dz0zVOM
 xwyrAUUHSjH8M3UbfLUHdX6OnelIBvOcteJJ1nKdeQdKRrvoEr//xmjuSmklFhUIRcG2
 PG0aY0YlQxyD6xg2px36S/rFuVN3y6ZXjxqSIOrnJKul/HGuQa9diFjhPGbvJ3SPMIvh
 w3XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS7nVbBddN3ZFs0wJK5pjCXmi4EvQVGpvkCUmO1GAzbREEOWfaOSFsZrWnlAX55lscodXJgD5gBztT@nongnu.org
X-Gm-Message-State: AOJu0YxU0FkUtWuhiNhUnKFNDDfl+PeGqZevx1mw0B4nFqJ/x8g/aJn3
 KDQaZtykloFro6YXvWL052XASD9zYNopFl9roSkLPQGqs6UuGAz8Fd4HVg==
X-Gm-Gg: ASbGncs5mWdtClNMzlvzs2H5E3ND3mDkmV43taKi5naHuGHKCSXwalVPC4flRf0h2Oi
 hHOwHmJlsgXae755asRbkvMfS7pXuegTo8OO2TfxxMqzfNUqr9Wck5yjRDrkG2kJyHzuklpS5MJ
 JD6gVyn1z06I4tjtMlFJNzWZc2a4zufciy9/7rlui8wl4ez3xC0jkWkBtyI1PkJC3GJFjQ7uIal
 bfzswcop5A3rnQqc8844B9pucabnVQWp4/skCZZ/K02NUPId9tTOJnEQhlm7HeHLt/Fj+EZJ/w7
 CsfcPTWB2rg2Y/5p7Ht931np6Jl3XC0m/BTdneUiZzo0gzBo2t/JAoTsnA==
X-Google-Smtp-Source: AGHT+IFHyzHmalvGUmvfYp/w71yV93SA7rvBlZO1qDQaoWf1r9iNG4RQ5LcY2lGekYAnWd6lRb9K/g==
X-Received: by 2002:a17:902:ecc6:b0:224:78e:4eb4 with SMTP id
 d9443c01a7336-22fc917fbc2mr150506135ad.39.1747019630660; 
 Sun, 11 May 2025 20:13:50 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 44/50] ppc/xive2: Implement pool context push TIMA op
Date: Mon, 12 May 2025 13:10:53 +1000
Message-ID: <20250512031100.439842-45-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

Implement pool context push TIMA op.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c         |  4 ++++
 hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++--------------
 include/hw/ppc/xive2.h |  2 ++
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d5bbd8f4c6..979031a587 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -733,6 +733,10 @@ static const XiveTmOp xive2_tm_operations[] = {
       xive2_tm_push_os_ctx, NULL },
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, true, true,
       xive_tm_set_os_lgs, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 4, true, true,
+      xive2_tm_push_pool_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 8, true, true,
+      xive2_tm_push_pool_ctx, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
       xive2_tm_set_hv_cppr, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 917ecbaae4..21cd07df68 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -583,6 +583,7 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
 }
 
+/* POOL cam is the same as OS cam encoding */
 static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
                              uint32_t *nvp_idx, bool *valid, bool *hw)
 {
@@ -940,10 +941,11 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 }
 
 static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
+                                   uint8_t ring,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t *regs = &tctx->regs[ring];
     uint8_t ipb;
     Xive2Nvp nvp;
 
@@ -965,7 +967,7 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
 
     /* Automatically restore thread context registers */
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
-        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
+        xive2_tctx_restore_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx, &nvp);
     }
 
     ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
@@ -976,48 +978,62 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
 
-    xive2_tctx_process_pending(tctx, TM_QW1_OS);
+    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
+                                         TM_QW3_HV_PHYS : ring);
 }
 
 /*
- * Updating the OS CAM line can trigger a resend of interrupt
+ * Updating the ring CAM line can trigger a resend of interrupt
  */
-void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-                          hwaddr offset, uint64_t value, unsigned size)
+static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                              hwaddr offset, uint64_t value, unsigned size,
+                              uint8_t ring)
 {
     uint32_t cam;
-    uint32_t qw1w2;
-    uint64_t qw1dw1;
+    uint32_t w2;
+    uint64_t dw1;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
-    bool vo;
+    bool v;
     bool do_restore;
 
     /* First update the thead context */
     switch (size) {
     case 4:
         cam = value;
-        qw1w2 = cpu_to_be32(cam);
-        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+        w2 = cpu_to_be32(cam);
+        memcpy(&tctx->regs[ring + TM_WORD2], &w2, 4);
         break;
     case 8:
         cam = value >> 32;
-        qw1dw1 = cpu_to_be64(value);
-        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1dw1, 8);
+        dw1 = cpu_to_be64(value);
+        memcpy(&tctx->regs[ring + TM_WORD2], &dw1, 8);
         break;
     default:
         g_assert_not_reached();
     }
 
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &v, &do_restore);
 
     /* Check the interrupt pending bits */
-    if (vo) {
-        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, nvp_blk, nvp_idx,
-                               do_restore);
+    if (v) {
+        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
+                               nvp_blk, nvp_idx, do_restore);
     }
 }
 
+void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW1_OS);
+}
+
+void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
+}
+
 /* returns -1 if ring is invalid, but still populates block and index */
 static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
                                       uint8_t *nvp_blk, uint32_t *nvp_idx)
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index a91b99057c..c1ab06a55a 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -140,6 +140,8 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, unsigned size);
 uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


