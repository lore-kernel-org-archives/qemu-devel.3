Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D36C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbt-00043J-22; Sun, 11 May 2025 23:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJb8-0000bk-Dq; Sun, 11 May 2025 23:13:01 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJb5-0006uw-9J; Sun, 11 May 2025 23:12:57 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7406c6dd2b1so4453504b3a.0; 
 Sun, 11 May 2025 20:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019572; x=1747624372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7slcSP31eGLiCSnII4g7yxJ+62yHMMUJkZ5N196u1k=;
 b=m6951aV1UNX8xkPEAv/022yo16NSHU2JhlrHFriyUs7z4rc9HS7Y9MzTwL9ipgj7WD
 3+oniZRr54X+G6h+W5n1yW/udvhLo5KSY+7TCG+dOMvRC5op24BbuU4s9AL+M8lxdCp1
 MkicqkWpDabvsC7DR0nAJDAEL9/oiGVb2vFAR5jz1T5NKNF+xZk1xylv0nsyiSPjeD4j
 iNqF00Vf8Fg8wBODdWjDb+7xPIn9TCUxn9wsLd6byYQYHNF0eLmLloaryvTOMpCHBLDn
 Qky8AquBYlaJmnW2xjrSXZtl50TIn6ktEx3wKuxOnS+J9uy+f3bqjAkurEa5G8ByJAvN
 DJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019572; x=1747624372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7slcSP31eGLiCSnII4g7yxJ+62yHMMUJkZ5N196u1k=;
 b=NLnPQg14atASoc2AFA2bltYBodFNR0xN0hqwvg2/yqydpFUS8nyEVNbPldd+nEyagM
 IORXy9JqywXyg7Ylfw4KcYTztQB6e32FwxfV8BpZ8AKnzd3QZXrqMJffnodzA4jkLUxf
 l/BPSxS+qK01+Y89L6pyDuzfdCezjH+kfa7bIPAYZ5b7xGSDPKKsmXXHdSFP/S/+upBU
 Tc+mBP+AtVxEyDFPuiukqbATmTaHqk/59sRnYDcDFicYz6zjrE51YpPmbGucAEeUV4Ye
 2zi+dpO/pNOb6fZhjqeiaEOeyQAJLTmycUy9ZaoB9Qvry4IO7q5qQt2evV6GbV63dHiA
 +fVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrkT3/28dw+T64yL7Ioguttk/psTN42RECtiIc7IxlH3nh6C888h+PjPoxRzh9pFE1jop1hll4nqYW@nongnu.org
X-Gm-Message-State: AOJu0YyXjZpV0M9XHRuoHbI3Cti4zxgM668BuEogicoz4thcINeTthHJ
 +vnXXbXKopVmfeca7DjvtZM3AfrUdK0chBmXEqVCSVDF95WtB7dqiDCVHQ==
X-Gm-Gg: ASbGncsCZt+HN6sl4LCI1BuPVGvkk3HpUoYC5B/TKWO1ShciqWPrmlehLSI870z7GP6
 TbnPLLl9Fi0wANEJE1HfB22Upe6l822UdwzB0jW5uKBpbMYsh+C7ToIwa17Brnn+QoL4jMWhP4+
 Oe5jJEshV9A+JJ/UJcYq1mdrCRD1wBpxPOwMXW3uUJZV4uuyqDUlhIUMcth3Av8/2Sdc6MBlRSn
 tkDJXG0EzWt9gzq1e8gEvTiSTfu/JGqeykx/gV5bV34WIkYWBOjPpR3I1U+FJ/oIzGuve0S71Hj
 ZiMEv0+Z2vky+da33c+ib7/RleUPF3J3gt0p3lY9ff206eoIDCLhNFSsIA==
X-Google-Smtp-Source: AGHT+IE7QgzT34LqaRnPxNy/Pf5MD61zyFbqeUbS60dwFPlteCac+VbtwhPE/hVocfnUAKmpNUQVwg==
X-Received: by 2002:a05:6a20:431f:b0:215:e02f:1eb8 with SMTP id
 adf61e73a8af0-215e02f1f9fmr388040637.14.1747019572389; 
 Sun, 11 May 2025 20:12:52 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 28/50] ppc/xive: Change presenter .match_nvt to match not
 present
Date: Mon, 12 May 2025 13:10:37 +1000
Message-ID: <20250512031100.439842-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

Have the match_nvt method only perform a TCTX match but don't present
the interrupt, the caller presents. This has no functional change, but
allows for more complicated presentation logic after matching.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive.c    | 16 +++++++-------
 hw/intc/pnv_xive2.c   | 16 +++++++-------
 hw/intc/spapr_xive.c  | 18 +++++++--------
 hw/intc/xive.c        | 51 +++++++++++++++----------------------------
 hw/intc/xive2.c       | 31 +++++++++++++-------------
 hw/ppc/pnv.c          | 48 ++++++++++++++--------------------------
 hw/ppc/spapr.c        | 21 +++++++-----------
 include/hw/ppc/xive.h | 27 +++++++++++++----------
 8 files changed, 97 insertions(+), 131 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ccbe95a58e..cdde8d0814 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -470,14 +470,13 @@ static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
     return xive->regs[reg >> 3] & PPC_BIT(bit);
 }
 
-static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
-                              uint8_t nvt_blk, uint32_t nvt_idx,
-                              bool crowd, bool cam_ignore, uint8_t priority,
-                              uint32_t logic_serv, XiveTCTXMatch *match)
+static bool pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                               uint8_t nvt_blk, uint32_t nvt_idx,
+                               bool crowd, bool cam_ignore, uint8_t priority,
+                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive *xive = PNV_XIVE(xptr);
     PnvChip *chip = xive->chip;
-    int count = 0;
     int i, j;
 
     for (i = 0; i < chip->nr_cores; i++) {
@@ -510,17 +509,18 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                     qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
                                   "thread context NVT %x/%x\n",
                                   nvt_blk, nvt_idx);
-                    return -1;
+                    match->count++;
+                    continue;
                 }
 
                 match->ring = ring;
                 match->tctx = tctx;
-                count++;
+                match->count++;
             }
         }
     }
 
-    return count;
+    return !!match->count;
 }
 
 static uint32_t pnv_xive_presenter_get_config(XivePresenter *xptr)
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 96b8851b7e..59b95e5219 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -640,14 +640,13 @@ static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
     return xive->tctxt_regs[reg >> 3] & PPC_BIT(bit);
 }
 
-static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
-                               uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool crowd, bool cam_ignore, uint8_t priority,
-                               uint32_t logic_serv, XiveTCTXMatch *match)
+static bool pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool crowd, bool cam_ignore, uint8_t priority,
+                                uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
     PnvChip *chip = xive->chip;
-    int count = 0;
     int i, j;
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
@@ -692,7 +691,8 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                   "thread context NVT %x/%x\n",
                                   nvt_blk, nvt_idx);
                     /* Should set a FIR if we ever model it */
-                    return -1;
+                    match->count++;
+                    continue;
                 }
                 /*
                  * For a group notification, we need to know if the
@@ -717,13 +717,13 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                             }
                         }
                     }
-                    count++;
+                    match->count++;
                 }
             }
         }
     }
 
-    return count;
+    return !!match->count;
 }
 
 static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ce734b03ab..a7475d2f21 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -428,14 +428,13 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
     g_assert_not_reached();
 }
 
-static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
-                                uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool crowd, bool cam_ignore,
-                                uint8_t priority,
-                                uint32_t logic_serv, XiveTCTXMatch *match)
+static bool spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                 bool crowd, bool cam_ignore,
+                                 uint8_t priority,
+                                 uint32_t logic_serv, XiveTCTXMatch *match)
 {
     CPUState *cs;
-    int count = 0;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -463,16 +462,17 @@ static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
             if (match->tctx) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a thread "
                               "context NVT %x/%x\n", nvt_blk, nvt_idx);
-                return -1;
+                match->count++;
+                continue;
             }
 
             match->ring = ring;
             match->tctx = tctx;
-            count++;
+            match->count++;
         }
     }
 
-    return count;
+    return !!match->count;
 }
 
 static uint32_t spapr_xive_presenter_get_config(XivePresenter *xptr)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ad30476c17..27b5a21371 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1762,8 +1762,8 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
     return 1U << (first_zero + 1);
 }
 
-static uint8_t xive_get_group_level(bool crowd, bool ignore,
-                                    uint32_t nvp_blk, uint32_t nvp_index)
+uint8_t xive_get_group_level(bool crowd, bool ignore,
+                             uint32_t nvp_blk, uint32_t nvp_index)
 {
     int first_zero;
     uint8_t level;
@@ -1881,15 +1881,14 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  * This is our simple Xive Presenter Engine model. It is merged in the
  * Router as it does not require an extra object.
  */
-bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
+bool xive_presenter_match(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
                            bool crowd, bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv, bool *precluded)
+                           uint32_t logic_serv, XiveTCTXMatch *match)
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
-    XiveTCTXMatch match = { .tctx = NULL, .ring = 0, .precluded = false };
-    uint8_t group_level;
-    int count;
+
+    memset(match, 0, sizeof(*match));
 
     /*
      * Ask the machine to scan the interrupt controllers for a match.
@@ -1914,22 +1913,8 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
      * a new command to the presenters (the equivalent of the "assign"
      * power bus command in the documented full notify sequence.
      */
-    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
-                           priority, logic_serv, &match);
-    if (count < 0) {
-        return false;
-    }
-
-    /* handle CPU exception delivery */
-    if (count) {
-        group_level = xive_get_group_level(crowd, cam_ignore, nvt_blk, nvt_idx);
-        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
-        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
-    } else {
-        *precluded = match.precluded;
-    }
-
-    return !!count;
+    return xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
+                          priority, logic_serv, match);
 }
 
 /*
@@ -1966,7 +1951,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     uint8_t nvt_blk;
     uint32_t nvt_idx;
     XiveNVT nvt;
-    bool found, precluded;
+    XiveTCTXMatch match;
 
     uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
     uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
@@ -2046,16 +2031,16 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
         return;
     }
 
-    found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
-                          false /* crowd */,
-                          xive_get_field32(END_W7_F0_IGNORE, end.w7),
-                          priority,
-                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
-                          &precluded);
-    /* we don't support VP-group notification on P9, so precluded is not used */
     /* TODO: Auto EOI. */
-
-    if (found) {
+    /* we don't support VP-group notification on P9, so precluded is not used */
+    if (xive_presenter_match(xrtr->xfb, format, nvt_blk, nvt_idx,
+                             false /* crowd */,
+                             xive_get_field32(END_W7_F0_IGNORE, end.w7),
+                             priority,
+                             xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
+                             &match)) {
+        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
+        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
         return;
     }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ac94193464..6e136ad2e2 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1559,7 +1559,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     Xive2End end;
     uint8_t priority;
     uint8_t format;
-    bool found, precluded;
+    XiveTCTXMatch match;
+    bool crowd, cam_ignore;
     uint8_t nvx_blk;
     uint32_t nvx_idx;
 
@@ -1629,16 +1630,19 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
      */
     nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
     nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
-
-    found = xive_presenter_notify(xrtr->xfb, format, nvx_blk, nvx_idx,
-                          xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
-                          priority,
-                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
-                          &precluded);
+    crowd = xive2_end_is_crowd(&end);
+    cam_ignore = xive2_end_is_ignore(&end);
 
     /* TODO: Auto EOI. */
-
-    if (found) {
+    if (xive_presenter_match(xrtr->xfb, format, nvx_blk, nvx_idx,
+                             crowd, cam_ignore, priority,
+                             xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
+                             &match)) {
+        uint8_t group_level;
+
+        group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
+        trace_xive_presenter_notify(nvx_blk, nvx_idx, match.ring, group_level);
+        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
         return;
     }
 
@@ -1656,7 +1660,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             return;
         }
 
-        if (!xive2_end_is_ignore(&end)) {
+        if (!cam_ignore) {
             uint8_t ipb;
             Xive2Nvp nvp;
 
@@ -1685,9 +1689,6 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         } else {
             Xive2Nvgc nvgc;
             uint32_t backlog;
-            bool crowd;
-
-            crowd = xive2_end_is_crowd(&end);
 
             /*
              * For groups and crowds, the per-priority backlog
@@ -1719,9 +1720,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             if (backlog == 1) {
                 XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
                 xfc->broadcast(xrtr->xfb, nvx_blk, nvx_idx,
-                               xive2_end_is_crowd(&end),
-                               xive2_end_is_ignore(&end),
-                               priority);
+                               crowd, cam_ignore, priority);
 
                 if (!xive2_end_is_precluded_escalation(&end)) {
                     /*
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index deb29a6389..0c17846b38 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2619,62 +2619,46 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
     }
 }
 
-static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
-                         uint8_t nvt_blk, uint32_t nvt_idx,
-                         bool crowd, bool cam_ignore, uint8_t priority,
-                         uint32_t logic_serv,
-                         XiveTCTXMatch *match)
+static bool pnv_match_nvt(XiveFabric *xfb, uint8_t format,
+                          uint8_t nvt_blk, uint32_t nvt_idx,
+                          bool crowd, bool cam_ignore, uint8_t priority,
+                          uint32_t logic_serv,
+                          XiveTCTXMatch *match)
 {
     PnvMachineState *pnv = PNV_MACHINE(xfb);
-    int total_count = 0;
     int i;
 
     for (i = 0; i < pnv->num_chips; i++) {
         Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
         XivePresenter *xptr = XIVE_PRESENTER(&chip9->xive);
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
-        int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
-                               cam_ignore, priority, logic_serv, match);
-
-        if (count < 0) {
-            return count;
-        }
-
-        total_count += count;
+        xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                       cam_ignore, priority, logic_serv, match);
     }
 
-    return total_count;
+    return !!match->count;
 }
 
-static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
-                                uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool crowd, bool cam_ignore, uint8_t priority,
-                                uint32_t logic_serv,
-                                XiveTCTXMatch *match)
+static bool pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                 bool crowd, bool cam_ignore, uint8_t priority,
+                                 uint32_t logic_serv,
+                                 XiveTCTXMatch *match)
 {
     PnvMachineState *pnv = PNV_MACHINE(xfb);
-    int total_count = 0;
     int i;
 
     for (i = 0; i < pnv->num_chips; i++) {
         Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
         XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
-        int count;
-
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
-                               cam_ignore, priority, logic_serv, match);
-
-        if (count < 0) {
-            return count;
-        }
 
-        total_count += count;
+        xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                       cam_ignore, priority, logic_serv, match);
     }
 
-    return total_count;
+    return !!match->count;
 }
 
 static int pnv10_xive_broadcast(XiveFabric *xfb,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b0a0f8c689..93574d2a63 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4468,21 +4468,14 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 /*
  * This is a XIVE only operation
  */
-static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
-                           uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool crowd, bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv, XiveTCTXMatch *match)
+static bool spapr_match_nvt(XiveFabric *xfb, uint8_t format,
+                            uint8_t nvt_blk, uint32_t nvt_idx,
+                            bool crowd, bool cam_ignore, uint8_t priority,
+                            uint32_t logic_serv, XiveTCTXMatch *match)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(xfb);
     XivePresenter *xptr = XIVE_PRESENTER(spapr->active_intc);
     XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
-    int count;
-
-    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
-                           priority, logic_serv, match);
-    if (count < 0) {
-        return count;
-    }
 
     /*
      * When we implement the save and restore of the thread interrupt
@@ -4493,12 +4486,14 @@ static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
      * Until this is done, the sPAPR machine should find at least one
      * matching context always.
      */
-    if (count == 0) {
+    if (!xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
+                           priority, logic_serv, match)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatched\n",
                       nvt_blk, nvt_idx);
+        return false;
     }
 
-    return count;
+    return true;
 }
 
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 46d05d74fb..8152a9df3d 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -425,6 +425,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas);
 
 typedef struct XiveTCTXMatch {
     XiveTCTX *tctx;
+    int count;
     uint8_t ring;
     bool precluded;
 } XiveTCTXMatch;
@@ -440,10 +441,10 @@ DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
 
 struct XivePresenterClass {
     InterfaceClass parent;
-    int (*match_nvt)(XivePresenter *xptr, uint8_t format,
-                     uint8_t nvt_blk, uint32_t nvt_idx,
-                     bool crowd, bool cam_ignore, uint8_t priority,
-                     uint32_t logic_serv, XiveTCTXMatch *match);
+    bool (*match_nvt)(XivePresenter *xptr, uint8_t format,
+                      uint8_t nvt_blk, uint32_t nvt_idx,
+                      bool crowd, bool cam_ignore, uint8_t priority,
+                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
     uint32_t (*get_config)(XivePresenter *xptr);
     int (*broadcast)(XivePresenter *xptr,
@@ -455,12 +456,14 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                               uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint32_t logic_serv);
-bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
-                           uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool crowd, bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv, bool *precluded);
+bool xive_presenter_match(XiveFabric *xfb, uint8_t format,
+                          uint8_t nvt_blk, uint32_t nvt_idx,
+                          bool crowd, bool cam_ignore, uint8_t priority,
+                          uint32_t logic_serv, XiveTCTXMatch *match);
 
 uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
+uint8_t xive_get_group_level(bool crowd, bool ignore,
+                             uint32_t nvp_blk, uint32_t nvp_index);
 
 /*
  * XIVE Fabric (Interface between Interrupt Controller and Machine)
@@ -475,10 +478,10 @@ DECLARE_CLASS_CHECKERS(XiveFabricClass, XIVE_FABRIC,
 
 struct XiveFabricClass {
     InterfaceClass parent;
-    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
-                     uint8_t nvt_blk, uint32_t nvt_idx,
-                     bool crowd, bool cam_ignore, uint8_t priority,
-                     uint32_t logic_serv, XiveTCTXMatch *match);
+    bool (*match_nvt)(XiveFabric *xfb, uint8_t format,
+                      uint8_t nvt_blk, uint32_t nvt_idx,
+                      bool crowd, bool cam_ignore, uint8_t priority,
+                      uint32_t logic_serv, XiveTCTXMatch *match);
     int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
                      bool crowd, bool cam_ignore, uint8_t priority);
 };
-- 
2.47.1


