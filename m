Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4BDC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJcI-0006Pa-V6; Sun, 11 May 2025 23:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJba-0002VD-Eu; Sun, 11 May 2025 23:13:26 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJbY-0006z7-40; Sun, 11 May 2025 23:13:26 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-30c3a038acfso3884609a91.3; 
 Sun, 11 May 2025 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019601; x=1747624401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKapXuN5JzAt5fRigG6BJ0hLK6lfq58zwGswv/hBNnc=;
 b=L5qYhSD6+zDsq/fecvx50G0jnLyoT1UJxJ2SnpSE2TsYJTxL1am1QZTns2Iti0j1XF
 HJAD/cQQmsd/clW1+z54PfYGTpCjhOq0tHzg/8HX8+MhBw39M2jOeyBKJH+QB8m984Lf
 QF2j4jI+oQLZ4xG+Uy2SHe3jD+Cvg3R3FY+dAn/Gpm2t0/FQj8BDH//CKxR2YP0qeei/
 3EQYoLmi/d2Ey8s7w6hQWXHDVZ6fO+313S1CbH9rI7eJT11bAQIHbMOSbhlMlmRlV9mk
 qLlNAIMRztCOuIi4An9ocqRg0NLM3L8bt0zEb2OxSKS2n2HzvWhStDGQvoSkvuiA6j/o
 jqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019601; x=1747624401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QKapXuN5JzAt5fRigG6BJ0hLK6lfq58zwGswv/hBNnc=;
 b=RnN7TFn5peKfDObyYyhR/Ibk7CCwaIRqtzZ0SF7Qy8FHzdc2uesN+H/lWokHTehLMs
 cOCBpWM5CXJQasRee4HKb0veoe+PW3GgBebHo673jWD+p8nKmm3ayC7HzosyGlxYxr0F
 OHiIjyN9apnnFV1SD8Fw5nLZkezxM2yOxJrtTsYOuj2/7x7eOo/CQlkOnCyxulNXfrT+
 OlExCp8EBsD4PzLYwklUiLu6UMcxmpce1ZVq03plFEdVzNbfs+y/sAmCvOkUQustYlYI
 AYE8KWsnvxc5+9NNgq1MItME/UxgvYRwToLyVmIKsGm+H7Wb264bCX/G0sBzAaAggS7V
 bJFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrruUbHvgjjmrf87bnJQO+BbTbMDD256V9DOquoIFxVLtlbxuA1DTDCRAJAaO4NvVU6tMNDsoV0wpI@nongnu.org
X-Gm-Message-State: AOJu0YzCIKPDZmkfmXndWc5ruN1wW29KzfFYkTpFJZXuun2WdT1Kaagi
 KogI2DXkdNqBa8BWdjeWW9vfDUUtPLLFPA+tx8aAMURj2XOtRIpRr7GLJw==
X-Gm-Gg: ASbGnct/dfmgHxwSnUQJxBAgQRwtpyZOcyzduN1IkAFaSPgnMkHjy063sYRg5c2Ngzu
 E1bFyli/p7YO3Hhd2eja/Acl8UWlPmSg++4ntevUxY3cMbLguXXHVzLA0INu0zpzi2G7ViC/fAL
 +egZ8R51yxF1hQ1bAR0CnKGwGu7K1CF0DG8WvMDMNJQwILPfM8tLhP8b9wNxVYYIpVOu+L4kchT
 s104thtv3Jjb6OLZUqJxfMWmzebsYT+nMfzbV0EITcvLNfkqRHSO91rej2G34CBRpnWNL+Af+Xv
 5E2wxY1zU22sU93koYZlRE2ajlEhSmDHc4G/AXXvjr5B5+YXGLreSMWXRw==
X-Google-Smtp-Source: AGHT+IEdTZPD+KEXEXiZK7g+sKu7yAiOk/GKdi4WppCmmVrRCwPwOny4d1GFI8nFrcSs0AlczkZcTg==
X-Received: by 2002:a17:90b:2d06:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-30c3d3d9ce0mr17315375a91.21.1747019601554; 
 Sun, 11 May 2025 20:13:21 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:13:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 36/50] ppc/xive2: split tctx presentation processing from set
 CPPR
Date: Mon, 12 May 2025 13:10:45 +1000
Message-ID: <20250512031100.439842-37-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

The second part of the set CPPR operation is to process (or re-present)
any pending interrupts after CPPR is adjusted.

Split this presentation processing out into a standalone function that
can be used in other places.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 137 +++++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 61 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 8c8dab3aa2..aa06bfda77 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1098,66 +1098,19 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
 }
 
-/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
-static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
+/* Re-calculate and present pending interrupts */
+static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
 {
-    uint8_t *sig_regs = &tctx->regs[ring];
+    uint8_t *sig_regs = &tctx->regs[sig_ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
-    uint8_t old_cppr, backlog_prio, first_group, group_level;
+    uint8_t backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
+    uint8_t cppr = sig_regs[TM_CPPR];
     bool group_enabled;
-    uint8_t nvp_blk;
-    uint32_t nvp_idx;
     Xive2Nvp nvp;
     int rc;
-    uint8_t nsr = sig_regs[TM_NSR];
-
-    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
-
-    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
-    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
-    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
-
-    /* XXX: should show pool IPB for PHYS ring */
-    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
-                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
-                             cppr, nsr);
-
-    if (cppr > XIVE_PRIORITY_MAX) {
-        cppr = 0xff;
-    }
-
-    old_cppr = sig_regs[TM_CPPR];
-    sig_regs[TM_CPPR] = cppr;
-
-    /* Handle increased CPPR priority (lower value) */
-    if (cppr < old_cppr) {
-        if (cppr <= sig_regs[TM_PIPR]) {
-            /* CPPR lowered below PIPR, must un-present interrupt */
-            if (xive_nsr_indicates_exception(ring, nsr)) {
-                if (xive_nsr_indicates_group_exception(ring, nsr)) {
-                    /* redistribute precluded active grp interrupt */
-                    xive2_redistribute(xrtr, tctx,
-                                       xive_nsr_exception_ring(ring, nsr));
-                    return;
-                }
-            }
 
-            /* interrupt is VP directed, pending in IPB */
-            xive_tctx_pipr_set(tctx, ring, cppr, 0);
-            return;
-        } else {
-            /* CPPR was lowered, but still above PIPR. No action needed. */
-            return;
-        }
-    }
-
-    /* CPPR didn't change, nothing needs to be done */
-    if (cppr == old_cppr) {
-        return;
-    }
-
-    /* CPPR priority decreased (higher value) */
+    g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
 
     /*
      * Recompute the PIPR based on local pending interrupts. It will
@@ -1167,11 +1120,11 @@ again:
     pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
     group_enabled = !!sig_regs[TM_LGS];
     lsmfb_min = group_enabled ? sig_regs[TM_LSMFB] : 0xff;
-    ring_min = ring;
+    ring_min = sig_ring;
     group_level = 0;
 
     /* PHYS updates also depend on POOL values */
-    if (ring == TM_QW3_HV_PHYS) {
+    if (sig_ring == TM_QW3_HV_PHYS) {
         uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
 
         /* POOL values only matter if POOL ctx is valid */
@@ -1201,20 +1154,25 @@ again:
         }
     }
 
-    rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
-    if (rc) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
-        return;
-    }
-
     if (group_enabled &&
         lsmfb_min < cppr &&
         lsmfb_min < pipr_min) {
+
+        uint8_t nvp_blk;
+        uint32_t nvp_idx;
+
         /*
          * Thread has seen a group interrupt with a higher priority
          * than the new cppr or pending local interrupt. Check the
          * backlog
          */
+        rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
+        if (rc) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid "
+                                           "context\n");
+            return;
+        }
+
         if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
                           nvp_blk, nvp_idx);
@@ -1260,6 +1218,63 @@ again:
     xive_tctx_pipr_set(tctx, ring_min, pipr_min, group_level);
 }
 
+/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
+static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t sig_ring, uint8_t cppr)
+{
+    uint8_t *sig_regs = &tctx->regs[sig_ring];
+    Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
+    uint8_t old_cppr;
+    uint8_t nsr = sig_regs[TM_NSR];
+
+    g_assert(sig_ring == TM_QW1_OS || sig_ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    /* XXX: should show pool IPB for PHYS ring */
+    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, sig_ring,
+                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
+                             cppr, nsr);
+
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr = 0xff;
+    }
+
+    old_cppr = sig_regs[TM_CPPR];
+    sig_regs[TM_CPPR] = cppr;
+
+    /* Handle increased CPPR priority (lower value) */
+    if (cppr < old_cppr) {
+        if (cppr <= sig_regs[TM_PIPR]) {
+            /* CPPR lowered below PIPR, must un-present interrupt */
+            if (xive_nsr_indicates_exception(sig_ring, nsr)) {
+                if (xive_nsr_indicates_group_exception(sig_ring, nsr)) {
+                    /* redistribute precluded active grp interrupt */
+                    xive2_redistribute(xrtr, tctx,
+                                       xive_nsr_exception_ring(sig_ring, nsr));
+                    return;
+                }
+            }
+
+            /* interrupt is VP directed, pending in IPB */
+            xive_tctx_pipr_set(tctx, sig_ring, cppr, 0);
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
+    xive2_tctx_process_pending(tctx, sig_ring);
+}
+
 void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size)
 {
-- 
2.47.1


