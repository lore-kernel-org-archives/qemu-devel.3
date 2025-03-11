Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C41BC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzFU-0006Sl-JQ; Tue, 11 Mar 2025 09:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDc-0004i6-N0; Tue, 11 Mar 2025 09:00:25 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDQ-0008Hk-7O; Tue, 11 Mar 2025 09:00:19 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ff797f8f1bso7288104a91.3; 
 Tue, 11 Mar 2025 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698006; x=1742302806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V66yWUqp8rsmJBZEyKf71sM70wBJJD9B0Sphx+ooMzc=;
 b=B6S2o2joT4KT4l8Kj3Y39htmR9o9iOV7o7mFm+tX/yNhUWPAhbb3HT/1B1iZGc4b+M
 2jBccjUMpNquPL90yA1pEmz3wfRsIYHc0zGgzHzVVOZbMcGmzn7G9YOwOzaDOnk7dyQn
 lzW+E7U9Lc81GtNu527hUU2lLeIOjgeINahwkvHJEfA5kCHN4Irqe5RN/LizijmEPJ2z
 8oMowmNzpvBRDgZoXUuPmylRjb6m+EhHjAq5LpM0oCaGA9kNTxi/t3x2jWX8FRoL55yt
 u+0IZU3pg4WkPUmp+a61bDROhs2bXk9e0ti5lt0MQQs9Ja7e/GlQy51sOFqFyzxpGP3C
 aXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698006; x=1742302806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V66yWUqp8rsmJBZEyKf71sM70wBJJD9B0Sphx+ooMzc=;
 b=TP3dy+cdBuMSrMmyf7exJa9Ulu5OwGDGfTGHyQWqxtLCSH4yF8u4yG7NsKrterbFbO
 73oenjrPKx1X4wZ0/L5CqhtgbSqmMVtzoXZYVCtiHjleSgBMnScFcwvt+9/f1yYPz5ZR
 z6xoKE1g6kuttVUaI36M9y624abSwhLwdgO6cWkk4IJNV+gXaNxCcSDs8ekFiJBcU3au
 qSeJuJGTKP9EplyisEuJ5IYn49NolpOnPbYTT4G7qfH0n41lQ9D7wr7ngxpXNT1CDkQh
 dFqnRkRZBMhWUTyib1oxb6KtOTuqSyT+Wi/mVMfcSVqzKgIJrCGFw/ZITksM10MSRq7s
 P/vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVDIjHYTocUHhIkXSi8RViJwokROXohxFQ2JcneSP+6FK7FwrCeLIv3bgYRuUYIMBotEW3pP83Wg==@nongnu.org
X-Gm-Message-State: AOJu0YwwX7ZIEf9L1tNa7IzyRm+gWQdZ1WCxILC/4sE4qvK3YUoRzvsL
 Dmwf2yebN+/iFyK/rQ3VTmp7QQPIU5+UBb5W2pAUOA74D375+Uu1M4uc7A==
X-Gm-Gg: ASbGnctjg/rih+IPAYfBbRQdshExiSzw+NIZ6Jw9vFJWFw8Q11Mr5RX/G3J0tLRvTxa
 vk6kksfnXogqh1c0UIlzC2za7rp7J2kUPdgareI7e2H5/N5QdqelnLyAGeLYWWKmbe/1OuJ0B0N
 D/PZR5QXENfWZDT8TQlQFi8Utf7GGopSMQpN+u39kOmIf4nkdqCAW5NEG7Y72zQbitqxTh6R2X0
 rmuUuZCR20YSX4Z8mJoTQFFNAyeAT1R9TMdzrOj5t9o37CJcO6dghtLoLjOT/lFp+0hb6qB7OPJ
 wGRn04mlPvCZE22PfrwZHIMYAEJbMDLg6n+eP73UD1TGzK0U1cc=
X-Google-Smtp-Source: AGHT+IEfrVJuXfc+XS2CthpcI9JwyvsXeVDA2ClnnJjxtMLLYI0Lr9dO9PM/c4FEKPHb6mkYHmAwQA==
X-Received: by 2002:a17:90b:2742:b0:2fe:a8b1:7d8 with SMTP id
 98e67ed59e1d1-300ff34d643mr4825311a91.25.1741698006292; 
 Tue, 11 Mar 2025 06:00:06 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.vnet.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 32/72] ppc/xive2: Support crowd-matching when looking for target
Date: Tue, 11 Mar 2025 22:57:26 +1000
Message-ID: <20250311125815.903177-33-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

XIVE crowd sizes are encoded into a 2-bit field as follows:
  0: 0b00
  2: 0b01
  4: 0b10
 16: 0b11

A crowd size of 8 is not supported.

If an END is defined with the 'crowd' bit set, then a target can be
running on different blocks. It means that some bits from the block
VP are masked when looking for a match. It is similar to groups, but
on the block instead of the VP index.

Most of the changes are due to passing the extra argument 'crowd' all
the way to the function checking for matches.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive.c     | 10 +++---
 hw/intc/pnv_xive2.c    | 12 +++----
 hw/intc/spapr_xive.c   |  8 ++---
 hw/intc/xive.c         | 45 +++++++++++++++++++++----
 hw/intc/xive2.c        | 76 +++++++++++++++++++++++++++++++++---------
 hw/ppc/pnv.c           | 15 +++++----
 hw/ppc/spapr.c         |  7 ++--
 include/hw/ppc/xive.h  | 10 +++---
 include/hw/ppc/xive2.h |  3 +-
 9 files changed, 134 insertions(+), 52 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index b755ddf0ff..ccbe95a58e 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE interrupt controller model
  *
- * Copyright (c) 2017-2019, IBM Corporation.
+ * Copyright (c) 2017-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -473,7 +472,7 @@ static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
 
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
-                              bool cam_ignore, uint8_t priority,
+                              bool crowd, bool cam_ignore, uint8_t priority,
                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive *xive = PNV_XIVE(xptr);
@@ -500,7 +499,8 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
              * Check the thread context CAM lines and record matches.
              */
             ring = xive_presenter_tctx_match(xptr, tctx, format, nvt_blk,
-                                             nvt_idx, cam_ignore, logic_serv);
+                                             nvt_idx, cam_ignore,
+                                             logic_serv);
             /*
              * Save the context and follow on to catch duplicates, that we
              * don't support yet.
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index c55d596e48..0b81dad6ba 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -624,7 +624,7 @@ static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
 
 static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint8_t priority,
+                               bool crowd, bool cam_ignore, uint8_t priority,
                                uint32_t logic_serv, XiveTCTXMatch *match)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
@@ -655,8 +655,8 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                                  logic_serv);
             } else {
                 ring = xive2_presenter_tctx_match(xptr, tctx, format, nvt_blk,
-                                                   nvt_idx, cam_ignore,
-                                                   logic_serv);
+                                                  nvt_idx, crowd, cam_ignore,
+                                                  logic_serv);
             }
 
             if (ring != -1) {
@@ -707,7 +707,7 @@ static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
 
 static int pnv_xive2_broadcast(XivePresenter *xptr,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               uint8_t priority)
+                               bool crowd, bool ignore, uint8_t priority)
 {
     PnvXive2 *xive = PNV_XIVE2(xptr);
     PnvChip *chip = xive->chip;
@@ -732,10 +732,10 @@ static int pnv_xive2_broadcast(XivePresenter *xptr,
 
             if (gen1_tima_os) {
                 ring = xive_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
-                                                 nvt_idx, true, 0);
+                                                 nvt_idx, ignore, 0);
             } else {
                 ring = xive2_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
-                                                  nvt_idx, true, 0);
+                                                  nvt_idx, crowd, ignore, 0);
             }
 
             if (ring != -1) {
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index a764c0bb57..ce734b03ab 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC sPAPR XIVE interrupt controller model
  *
- * Copyright (c) 2017-2018, IBM Corporation.
+ * Copyright (c) 2017-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -431,7 +430,8 @@ static int spapr_xive_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk,
 
 static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool cam_ignore, uint8_t priority,
+                                bool crowd, bool cam_ignore,
+                                uint8_t priority,
                                 uint32_t logic_serv, XiveTCTXMatch *match)
 {
     CPUState *cs;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 535e59646f..c77df2c1f8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1665,10 +1665,42 @@ uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
     return 1 << (ctz32(~nvp_index) + 1);
 }
 
-static uint8_t xive_get_group_level(uint32_t nvp_index)
+static uint8_t xive_get_group_level(bool crowd, bool ignore,
+                                    uint32_t nvp_blk, uint32_t nvp_index)
 {
-    /* FIXME add crowd encoding */
-    return ctz32(~nvp_index) + 1;
+    uint8_t level;
+
+    if (!ignore) {
+        g_assert(!crowd);
+        return 0;
+    }
+
+    level = (ctz32(~nvp_index) + 1) & 0b1111;
+    if (crowd) {
+        uint32_t blk;
+
+        /* crowd level is bit position of first 0 from the right in nvp_blk */
+        blk = ctz32(~nvp_blk) + 1;
+
+        /*
+         * Supported crowd sizes are 2^1, 2^2, and 2^4. 2^3 is not supported.
+         * HW will encode level 4 as the value 3.  See xive2_pgofnext().
+         */
+        switch (level) {
+        case 1:
+        case 2:
+            break;
+        case 4:
+            blk = 3;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* Crowd level bits reside in upper 2 bits of the 6 bit group level */
+        level |= blk << 4;
+    }
+    return level;
 }
 
 /*
@@ -1740,7 +1772,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
  */
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, bool *precluded)
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
@@ -1771,7 +1803,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
      * a new command to the presenters (the equivalent of the "assign"
      * power bus command in the documented full notify sequence.
      */
-    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
+    count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, crowd, cam_ignore,
                            priority, logic_serv, &match);
     if (count < 0) {
         return false;
@@ -1779,7 +1811,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
 
     /* handle CPU exception delivery */
     if (count) {
-        group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
+        group_level = xive_get_group_level(crowd, cam_ignore, nvt_blk, nvt_idx);
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
         xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
     } else {
@@ -1904,6 +1936,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     }
 
     found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
+                          false /* crowd */,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 34628f2922..5fa8e1b3fb 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1121,13 +1121,40 @@ static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
     return (cam1 & vp_mask) == (cam2 & vp_mask);
 }
 
+static uint8_t xive2_get_vp_block_mask(uint32_t nvt_blk, bool crowd)
+{
+    uint8_t size, block_mask = 0b1111;
+
+    /* 3 supported crowd sizes: 2, 4, 16 */
+    if (crowd) {
+        size = xive_get_vpgroup_size(nvt_blk);
+        if (size == 8) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid crowd size of 8n");
+            return block_mask;
+        }
+        block_mask &= ~(size - 1);
+    }
+    return block_mask;
+}
+
+static uint32_t xive2_get_vp_index_mask(uint32_t nvt_index, bool cam_ignore)
+{
+    uint32_t index_mask = 0xFFFFFF; /* 24 bits */
+
+    if (cam_ignore) {
+        index_mask &= ~(xive_get_vpgroup_size(nvt_index) - 1);
+    }
+    return index_mask;
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
 int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint32_t logic_serv)
+                               bool crowd, bool cam_ignore,
+                               uint32_t logic_serv)
 {
     uint32_t cam =   xive2_nvp_cam_line(nvt_blk, nvt_idx);
     uint32_t qw3w2 = xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
@@ -1135,7 +1162,8 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
 
-    uint32_t vp_mask = 0xFFFFFFFF;
+    uint32_t index_mask, vp_mask;
+    uint8_t block_mask;
 
     if (format == 0) {
         /*
@@ -1143,9 +1171,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
          * i=1: VP-group notification (bits ignored at the end of the
          *      NVT identifier)
          */
-        if (cam_ignore) {
-            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
-        }
+        block_mask = xive2_get_vp_block_mask(nvt_blk, crowd);
+        index_mask = xive2_get_vp_index_mask(nvt_idx, cam_ignore);
+        vp_mask = xive2_nvp_cam_line(block_mask, index_mask);
 
         /* For VP-group notifications, threads with LGS=0 are excluded */
 
@@ -1277,6 +1305,12 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         return;
     }
 
+    if (xive2_end_is_crowd(&end) & !xive2_end_is_ignore(&end)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "XIVE: invalid END, 'crowd' bit requires 'ignore' bit\n");
+        return;
+    }
+
     if (xive2_end_is_enqueue(&end)) {
         xive2_end_enqueue(&end, end_data);
         /* Enqueuing event data modifies the EQ toggle and index */
@@ -1325,7 +1359,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     nvp_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
 
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
-                          xive2_end_is_ignore(&end),
+                          xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
                           &precluded);
@@ -1377,17 +1411,24 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
             xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
         } else {
-            Xive2Nvgc nvg;
+            Xive2Nvgc nvgc;
             uint32_t backlog;
+            bool crowd;
 
-            /* For groups, the per-priority backlog counters are in the NVG */
-            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg)) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVG %x/%x\n",
-                              nvp_blk, nvp_idx);
+            crowd = xive2_end_is_crowd(&end);
+
+            /*
+             * For groups and crowds, the per-priority backlog
+             * counters are stored in the NVG/NVC structures
+             */
+            if (xive2_router_get_nvgc(xrtr, crowd,
+                                      nvp_blk, nvp_idx, &nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
+                              crowd ? "NVC" : "NVG", nvp_blk, nvp_idx);
                 return;
             }
 
-            if (!xive2_nvgc_is_valid(&nvg)) {
+            if (!xive2_nvgc_is_valid(&nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is invalid\n",
                               nvp_blk, nvp_idx);
                 return;
@@ -1399,13 +1440,16 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
              * incremented. broadcast will set the LSMFB field of the TIMA of
              * relevant threads so that they know an interrupt is pending.
              */
-            backlog = xive2_nvgc_get_backlog(&nvg, priority) + 1;
-            xive2_nvgc_set_backlog(&nvg, priority, backlog);
-            xive2_router_write_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg);
+            backlog = xive2_nvgc_get_backlog(&nvgc, priority) + 1;
+            xive2_nvgc_set_backlog(&nvgc, priority, backlog);
+            xive2_router_write_nvgc(xrtr, crowd, nvp_blk, nvp_idx, &nvgc);
 
             if (backlog == 1) {
                 XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
-                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx, priority);
+                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx,
+                               xive2_end_is_crowd(&end),
+                               xive2_end_is_ignore(&end),
+                               priority);
 
                 if (!xive2_end_is_precluded_escalation(&end)) {
                     /*
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index af836c1388..d60574d601 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2608,7 +2608,7 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 
 static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
                          uint8_t nvt_blk, uint32_t nvt_idx,
-                         bool cam_ignore, uint8_t priority,
+                         bool crowd, bool cam_ignore, uint8_t priority,
                          uint32_t logic_serv,
                          XiveTCTXMatch *match)
 {
@@ -2622,8 +2622,8 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
         int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                               priority, logic_serv, match);
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                               cam_ignore, priority, logic_serv, match);
 
         if (count < 0) {
             return count;
@@ -2637,7 +2637,7 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
 
 static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                bool cam_ignore, uint8_t priority,
+                                bool crowd, bool cam_ignore, uint8_t priority,
                                 uint32_t logic_serv,
                                 XiveTCTXMatch *match)
 {
@@ -2651,8 +2651,8 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
         int count;
 
-        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                               priority, logic_serv, match);
+        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd,
+                               cam_ignore, priority, logic_serv, match);
 
         if (count < 0) {
             return count;
@@ -2666,6 +2666,7 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
 
 static int pnv10_xive_broadcast(XiveFabric *xfb,
                                 uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool crowd, bool cam_ignore,
                                 uint8_t priority)
 {
     PnvMachineState *pnv = PNV_MACHINE(xfb);
@@ -2676,7 +2677,7 @@ static int pnv10_xive_broadcast(XiveFabric *xfb,
         XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
         XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
 
-        xpc->broadcast(xptr, nvt_blk, nvt_idx, priority);
+        xpc->broadcast(xptr, nvt_blk, nvt_idx, crowd, cam_ignore, priority);
     }
     return 0;
 }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c15340a58d..c7cf04e063 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4,6 +4,9 @@
  * Copyright (c) 2004-2007 Fabrice Bellard
  * Copyright (c) 2007 Jocelyn Mayer
  * Copyright (c) 2010 David Gibson, IBM Corporation.
+ * Copyright (c) 2010-2024, IBM Corporation..
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -4436,7 +4439,7 @@ static void spapr_pic_print_info(InterruptStatsProvider *obj, GString *buf)
  */
 static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, XiveTCTXMatch *match)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(xfb);
@@ -4444,7 +4447,7 @@ static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
     XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
     int count;
 
-    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+    count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, crowd, cam_ignore,
                            priority, logic_serv, match);
     if (count < 0) {
         return count;
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 6a410c6f1a..538f438681 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -438,13 +438,13 @@ struct XivePresenterClass {
     InterfaceClass parent;
     int (*match_nvt)(XivePresenter *xptr, uint8_t format,
                      uint8_t nvt_blk, uint32_t nvt_idx,
-                     bool cam_ignore, uint8_t priority,
+                     bool crowd, bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
     uint32_t (*get_config)(XivePresenter *xptr);
     int (*broadcast)(XivePresenter *xptr,
                      uint8_t nvt_blk, uint32_t nvt_idx,
-                     uint8_t priority);
+                     bool crowd, bool cam_ignore, uint8_t priority);
 };
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
@@ -453,7 +453,7 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                               bool cam_ignore, uint32_t logic_serv);
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
-                           bool cam_ignore, uint8_t priority,
+                           bool crowd, bool cam_ignore, uint8_t priority,
                            uint32_t logic_serv, bool *precluded);
 
 uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
@@ -473,10 +473,10 @@ struct XiveFabricClass {
     InterfaceClass parent;
     int (*match_nvt)(XiveFabric *xfb, uint8_t format,
                      uint8_t nvt_blk, uint32_t nvt_idx,
-                     bool cam_ignore, uint8_t priority,
+                     bool crowd, bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
     int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
-                     uint8_t priority);
+                     bool crowd, bool cam_ignore, uint8_t priority);
 };
 
 /*
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index c07e23e1d3..8cdf819174 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -88,7 +88,8 @@ void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
 int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
                                uint8_t format,
                                uint8_t nvt_blk, uint32_t nvt_idx,
-                               bool cam_ignore, uint32_t logic_serv);
+                               bool crowd, bool cam_ignore,
+                               uint32_t logic_serv);
 
 uint64_t xive2_presenter_nvp_backlog_op(XivePresenter *xptr,
                                         uint8_t blk, uint32_t idx,
-- 
2.47.1


