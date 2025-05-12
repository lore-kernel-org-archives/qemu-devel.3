Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B97C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcp-00080T-In; Sun, 11 May 2025 23:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcK-0006aj-SS; Sun, 11 May 2025 23:14:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJcI-00076S-JY; Sun, 11 May 2025 23:14:12 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so4297427b3a.1; 
 Sun, 11 May 2025 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019649; x=1747624449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWMUQzQof10aqavcRRYrJIJN+XvDm8mVIsK9vXzBNnc=;
 b=PEAw54CIULK/F3eV7BLSWfjCkRK50bok5sOzrALvmKHR8CcI/WQbYJNFUy3C7X+2Gl
 9toIcEtZiMdR84zku4Mbo+ElBHOzwX4CJ7ocgg5diE8ppyDdYMLheThetFuRUxCDvxVF
 ftYMcNxsW8sUWLPuFKeyC/SWdtlBfQNqWc2KR3u3WFoGYXZFDHlT38E9kqebO2K2WAky
 WM5LWAxG6a4aWx1t5cgjjgquCbs2KbwbUBkBUaoxamQDWBCOpx2Q/JnretnEucQdZw4F
 88S6gW6J87upqfGrIf2u0juNqBES75iKC1K4kgVHtTVsEVEhdTKBUIJBq0c2o5LRnDBs
 30QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019649; x=1747624449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWMUQzQof10aqavcRRYrJIJN+XvDm8mVIsK9vXzBNnc=;
 b=vXbGuovMibKkj3dts53mJUmdGxA6dktyUqamNcDFQdH1NyXXhuYxKdQkMzRBAxQkos
 eDyzvEu5GNgj9dN++P45OugBeMwYG+aKi246n0KtjMrczCHQw7G0E7dOlkPWciIySZhq
 Ut04VII0574Hr6dd4zaq7HV9APgXj3YUacTsEg6vQnwgmzyIEJeqmWmQUdnLVECYygtn
 N17PCdsAqg4Fw+1NqrfCGDbXrNCzm4Df1YEvBOaWlViFWdSiMnipEH+Ms/Fp6sevpDx6
 iT274PaFkQ5pdUir01htTAWRDwuCaL0QCYp0veVyR/CaZ/jP7dJxlP/DhGzID9WCRHqQ
 kblQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7Zk9yV8ubgymB6i8NwEnPPxo25XNBVYwsi3ngSvGZq4yoswMTkAYG+Ks7/jByHYlM56etgoqpLxuT@nongnu.org
X-Gm-Message-State: AOJu0YxDn70lbfm1orHQNawwQCEZV+RUF7hyW3AHBSI4dikDeEVNB+6j
 Zey/oVuAwIG9YaiU67ehg/WX4ZytwYOGxPJl9WJ6dsK4DyxPTEGVzbAVuA==
X-Gm-Gg: ASbGncvIid0VGlqtXjmPWGcA6i2BhUvzUhvr+kBjwDYMtAqvFORfqvwapk8vxxpgovv
 b4VdHw11ZQKbX++7GBTjqRTnAQCK8tMb4lVd0svQPC8NYucdnJkpK+zsPQnJuiv0r6k0UUW5FQk
 ofGCb+CpEkmXgXf7vy/68HrTNcGUaVJHbTNAXLmTM9938LDlOopSOwueusiRNKeGYU8arVCZH7D
 kPy8D5is+rBgnryjIflCJLthB1U+eCjxptlStTYk2ZV7QQuAcQuk1Yy9ezPCCAhphzBP+XrO9uW
 MIowEq08FNSXZuoOxT7M49vC2IRhmmhbwPWUYdGwCoVsvhgblDmXE6Iifw==
X-Google-Smtp-Source: AGHT+IEgcahaiWklVNK7N2uTh+mT2P0zJV0OUB2yOHsRrY/305LF4eTLRtL/EAlAlcIlwZshdMLV4g==
X-Received: by 2002:a05:6a20:9f8e:b0:20d:d31c:cd28 with SMTP id
 adf61e73a8af0-215ababa299mr18480765637.7.1747019648602; 
 Sun, 11 May 2025 20:14:08 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:14:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 49/50] ppc/xive: Split need_resend into restore_nvp
Date: Mon, 12 May 2025 13:10:58 +1000
Message-ID: <20250512031100.439842-50-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

This is needed by the next patch which will re-send on all lower
rings when pushing a context.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c  | 24 ++++++++++++------------
 hw/intc/xive2.c | 28 ++++++++++++++++------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 69118999e6..9ade9ec6c1 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -606,7 +606,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return qw1w2;
 }
 
-static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
+static void xive_tctx_restore_nvp(XiveRouter *xrtr, XiveTCTX *tctx,
                                   uint8_t nvt_blk, uint32_t nvt_idx)
 {
     XiveNVT nvt;
@@ -632,16 +632,6 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
         uint8_t *regs = &tctx->regs[TM_QW1_OS];
         regs[TM_IPB] |= ipb;
     }
-
-    /*
-     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
-     * escalation triggered, there could be a pending interrupt which
-     * was saved when the context was pulled and that we need to take
-     * into account by recalculating the PIPR (which is not
-     * saved/restored).
-     * It will also raise the External interrupt signal if needed.
-     */
-    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
 }
 
 /*
@@ -663,7 +653,17 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     /* Check the interrupt pending bits */
     if (vo) {
-        xive_tctx_need_resend(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx);
+        xive_tctx_restore_nvp(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx);
+
+        /*
+         * Always call xive_tctx_recompute_from_ipb(). Even if there were no
+         * escalation triggered, there could be a pending interrupt which
+         * was saved when the context was pulled and that we need to take
+         * into account by recalculating the PIPR (which is not
+         * saved/restored).
+         * It will also raise the External interrupt signal if needed.
+         */
+        xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
     }
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index a9b188b909..53e90b8178 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -940,14 +940,14 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     return cppr;
 }
 
-static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
+/* Restore TIMA VP context from NVP backlog */
+static void xive2_tctx_restore_nvp(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t ring,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
-    uint8_t ipb, nsr = sig_regs[TM_NSR];
+    uint8_t ipb;
     Xive2Nvp nvp;
 
     /*
@@ -978,14 +978,6 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
-
-    if (xive_nsr_indicates_group_exception(ring, nsr)) {
-        /* redistribute precluded active grp interrupt */
-        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
-        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
-    }
-    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
-                                         TM_QW3_HV_PHYS : ring);
 }
 
 /*
@@ -1028,8 +1020,20 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     /* Check the interrupt pending bits */
     if (v) {
-        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
+        Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+        uint8_t nsr = sig_regs[TM_NSR];
+
+        xive2_tctx_restore_nvp(xrtr, tctx, ring,
                                nvp_blk, nvp_idx, do_restore);
+
+        if (xive_nsr_indicates_group_exception(ring, nsr)) {
+            /* redistribute precluded active grp interrupt */
+            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
+            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
+        }
+        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
+                                                 TM_QW3_HV_PHYS : ring);
     }
 }
 
-- 
2.47.1


