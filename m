Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806CFC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzDF-00044h-Le; Tue, 11 Mar 2025 09:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDD-0003xP-Fm; Tue, 11 Mar 2025 08:59:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzD7-00082N-Aw; Tue, 11 Mar 2025 08:59:58 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so8656755a91.0; 
 Tue, 11 Mar 2025 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697987; x=1742302787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hMN1cLhziqhpOJDuVkl12QW9EXehxz96DoalbVVJvq0=;
 b=TEweNpT20gR9p+/0ewUN5vDZyR8vjxanxo2JdoR1hUhanCYPZjVmbfGwfeNcLokVBy
 OgjUFCLlxoASSyKPnTuOX517/cIUqac7LtubddI7XpyV6bNwC4Qr1h34hPwvDUlWJjWn
 O7m0PVky9AO6NDbqlkwqJX9kr8KOhpsWT7jxOMWcjOD8dIU1l6EEcL8T6Z07rfyuGAc0
 66JjBmltIK1I6daLWGXlS3b1gXdq3Nn2HgW8bANdDAVN9SQUtfcEzwzS1e8XC3V2DQ9u
 vp+vBLQIwiAy9w2XSEMsgFcpalheQOk71m/GxeY0hW/C9/zBkk8osA0Ihu/6HGxerekl
 3aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697987; x=1742302787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hMN1cLhziqhpOJDuVkl12QW9EXehxz96DoalbVVJvq0=;
 b=K2q2Pyf/t1PbTeF5A4cmgta3tgMr5ApFBVeq7n03zQt4i33WYgzvoIGsLU0P2zLnjy
 oNM8XC6jBUcFJ9jm9ZslKY2d/XI6hvIGgVvgfy5YA9afZ4CxHwrIV6gavV+FfQr2z+7R
 v+wLTF2dWSILTRGDwNg7zEzNlPj/2EOCJZ3ArOFMALNZUpCMlvsch4OgIZK99cHOdlcD
 TephpMFPFM1R2v3c5lRo/tSFEqpuslrALbcJYMr3dgwvCEaa8ZteNB5Ang0nAnlb5QJh
 yKCBLTs8Zb4jNy9C6ehdcvFye22whx54+lN2K9rrN+Q1lrWz6KfTebOOu+OfucKKSJwM
 30hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVizmK9PcwIMF+FkYpMoZ2MdKPqVW0yFbbgHbod0A7fJBkx0o/h1bj4aPqKCMeAdBibddO2NtuiOA==@nongnu.org
X-Gm-Message-State: AOJu0Yy7DQjUnZXhTUwSgZrMUDSGYEU7rzKfA0KlET8YzvuLoqlIpawC
 kfqPNdy0E9ZqZPgDIiWEtbb8nahRnlwjUX1l9dl9GE9iPos0zz3SRVe21w==
X-Gm-Gg: ASbGncvFVpJ0c+RevmfYEVVMWRRvPhiNz1b85xVYIomAJNGyx22VbCf61iplQ6fXmBQ
 kdNZ+5XNLsj53L8xzU4qkFhBedPHw+dvhmcf5dbgekMwM3g48sburn7dynNokxWigs4Ns+W9uGf
 P2BKJUrddd7LcPNcC0ZfXg7xEsyz4JPx9Y8h3uAuH1gzveWD7FgGh3qm2TidzNc4jief1D56ZND
 Og/g9Gy3H0aAIZCJec61a1NBNIEuLM3/rFalaXoUNqvkbFA7EU1DVJ10y5HOqz49z7+KaXNcDkQ
 Axqt1x+8C76mFhFctwyvMDYoBpTW3DLP/xPFyzuxCwnXRLirb6uikDEqHkgAlg==
X-Google-Smtp-Source: AGHT+IE0ysSSHJbAK4sBVeloxEobHbZKuSuDoh1mll617LgWQJDxBczKLi3jFEtIs9BwkuUyBGK+Qw==
X-Received: by 2002:a17:90b:4b11:b0:2ff:6ac2:c5a5 with SMTP id
 98e67ed59e1d1-2ff7cf13a5emr23091757a91.26.1741697987463; 
 Tue, 11 Mar 2025 05:59:47 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 26/72] ppc/xive2: Support group-matching when looking for target
Date: Tue, 11 Mar 2025 22:57:20 +1000
Message-ID: <20250311125815.903177-27-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

If an END has the 'i' bit set (ignore), then it targets a group of
VPs. The size of the group depends on the VP index of the target
(first 0 found when looking at the least significant bits of the
index) so a mask is applied on the VP index of a running thread to
know if we have a match.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c    | 38 +++++++++++++++---------
 hw/intc/xive.c         | 56 +++++++++++++++++++++++++-----------
 hw/intc/xive2.c        | 65 ++++++++++++++++++++++++++++++------------
 include/hw/ppc/xive.h  |  5 +++-
 include/hw/ppc/xive2.h |  7 ++---
 5 files changed, 118 insertions(+), 53 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 9ed759417e..8429ccbd51 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1,10 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 interrupt controller model  (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation.
+ * Copyright (c) 2019-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -660,21 +659,34 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
                                                    logic_serv);
             }
 
-            /*
-             * Save the context and follow on to catch duplicates,
-             * that we don't support yet.
-             */
             if (ring != -1) {
-                if (match->tctx) {
+                /*
+                 * For VP-specific match, finding more than one is a
+                 * problem. For group notification, it's possible.
+                 */
+                if (!cam_ignore && match->tctx) {
                     qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
                                   "thread context NVT %x/%x\n",
                                   nvt_blk, nvt_idx);
-                    return false;
+                    /* Should set a FIR if we ever model it */
+                    return -1;
+                }
+                /*
+                 * For a group notification, we need to know if the
+                 * match is precluded first by checking the current
+                 * thread priority. If the interrupt can be delivered,
+                 * we always notify the first match (for now).
+                 */
+                if (cam_ignore &&
+                    xive2_tm_irq_precluded(tctx, ring, priority)) {
+                        match->precluded = true;
+                } else {
+                    if (!match->tctx) {
+                        match->ring = ring;
+                        match->tctx = tctx;
+                    }
+                    count++;
                 }
-
-                match->ring = ring;
-                match->tctx = tctx;
-                count++;
             }
         }
     }
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1e362f987a..3e4c932f19 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1655,6 +1655,16 @@ static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
 }
 
+uint32_t xive_get_vpgroup_size(uint32_t nvp_index)
+{
+    /*
+     * Group size is a power of 2. The position of the first 0
+     * (starting with the least significant bits) in the NVP index
+     * gives the size of the group.
+     */
+    return 1 << (ctz32(~nvp_index) + 1);
+}
+
 static uint8_t xive_get_group_level(uint32_t nvp_index)
 {
     /* FIXME add crowd encoding */
@@ -1727,30 +1737,39 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 /*
  * This is our simple Xive Presenter Engine model. It is merged in the
  * Router as it does not require an extra object.
- *
- * It receives notification requests sent by the IVRE to find one
- * matching NVT (or more) dispatched on the processor threads. In case
- * of a single NVT notification, the process is abbreviated and the
- * thread is signaled if a match is found. In case of a logical server
- * notification (bits ignored at the end of the NVT identifier), the
- * IVPE and IVRE select a winning thread using different filters. This
- * involves 2 or 3 exchanges on the PowerBus that the model does not
- * support.
- *
- * The parameters represent what is sent on the PowerBus
  */
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
                            bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv)
+                           uint32_t logic_serv, bool *precluded)
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
-    XiveTCTXMatch match = { .tctx = NULL, .ring = 0 };
+    XiveTCTXMatch match = { .tctx = NULL, .ring = 0, .precluded = false };
     uint8_t group_level;
     int count;
 
     /*
-     * Ask the machine to scan the interrupt controllers for a match
+     * Ask the machine to scan the interrupt controllers for a match.
+     *
+     * For VP-specific notification, we expect at most one match and
+     * one call to the presenters is all we need (abbreviated notify
+     * sequence documented by the architecture).
+     *
+     * For VP-group notification, match_nvt() is the equivalent of the
+     * "histogram" and "poll" commands sent to the power bus to the
+     * presenters. 'count' could be more than one, but we always
+     * select the first match for now. 'precluded' tells if (at least)
+     * one thread matches but can't take the interrupt now because
+     * it's running at a more favored priority. We return the
+     * information to the router so that it can take appropriate
+     * actions (backlog, escalation, broadcast, etc...)
+     *
+     * If we were to implement a better way of dispatching the
+     * interrupt in case of multiple matches (instead of the first
+     * match), we would need a heuristic to elect a thread (for
+     * example, the hardware keeps track of an 'age' in the TIMA) and
+     * a new command to the presenters (the equivalent of the "assign"
+     * power bus command in the documented full notify sequence.
      */
     count = xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
                            priority, logic_serv, &match);
@@ -1763,6 +1782,8 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
         group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
         xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
+    } else {
+        *precluded = match.precluded;
     }
 
     return !!count;
@@ -1802,7 +1823,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     uint8_t nvt_blk;
     uint32_t nvt_idx;
     XiveNVT nvt;
-    bool found;
+    bool found, precluded;
 
     uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
     uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
@@ -1885,8 +1906,9 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
     found = xive_presenter_notify(xrtr->xfb, format, nvt_blk, nvt_idx,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
-                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7));
-
+                          xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
+                          &precluded);
+    /* we don't support VP-group notification on P9, so precluded is not used */
     /* TODO: Auto EOI. */
 
     if (found) {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 62c3f05af9..41dbbdbb68 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -739,6 +739,12 @@ int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
    return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
 }
 
+static bool xive2_vp_match_mask(uint32_t cam1, uint32_t cam2,
+                                uint32_t vp_mask)
+{
+    return (cam1 & vp_mask) == (cam2 & vp_mask);
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
@@ -753,44 +759,50 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
     uint32_t qw0w2 = xive_tctx_word2(&tctx->regs[TM_QW0_USER]);
 
-    /*
-     * TODO (PowerNV): ignore mode. The low order bits of the NVT
-     * identifier are ignored in the "CAM" match.
-     */
+    uint32_t vp_mask = 0xFFFFFFFF;
 
     if (format == 0) {
-        if (cam_ignore == true) {
-            /*
-             * F=0 & i=1: Logical server notification (bits ignored at
-             * the end of the NVT identifier)
-             */
-            qemu_log_mask(LOG_UNIMP, "XIVE: no support for LS NVT %x/%x\n",
-                          nvt_blk, nvt_idx);
-            return -1;
+        /*
+         * i=0: Specific NVT notification
+         * i=1: VP-group notification (bits ignored at the end of the
+         *      NVT identifier)
+         */
+        if (cam_ignore) {
+            vp_mask = ~(xive_get_vpgroup_size(nvt_idx) - 1);
         }
 
-        /* F=0 & i=0: Specific NVT notification */
+        /* For VP-group notifications, threads with LGS=0 are excluded */
 
         /* PHYS ring */
         if ((be32_to_cpu(qw3w2) & TM2_QW3W2_VT) &&
-            cam == xive2_tctx_hw_cam_line(xptr, tctx)) {
+            !(cam_ignore && tctx->regs[TM_QW3_HV_PHYS + TM_LGS] == 0) &&
+            xive2_vp_match_mask(cam,
+                                xive2_tctx_hw_cam_line(xptr, tctx),
+                                vp_mask)) {
             return TM_QW3_HV_PHYS;
         }
 
         /* HV POOL ring */
         if ((be32_to_cpu(qw2w2) & TM2_QW2W2_VP) &&
-            cam == xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2)) {
+            !(cam_ignore && tctx->regs[TM_QW2_HV_POOL + TM_LGS] == 0) &&
+            xive2_vp_match_mask(cam,
+                                xive_get_field32(TM2_QW2W2_POOL_CAM, qw2w2),
+                                vp_mask)) {
             return TM_QW2_HV_POOL;
         }
 
         /* OS ring */
         if ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
-            cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) {
+            !(cam_ignore && tctx->regs[TM_QW1_OS + TM_LGS] == 0) &&
+            xive2_vp_match_mask(cam,
+                                xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2),
+                                vp_mask)) {
             return TM_QW1_OS;
         }
     } else {
         /* F=1 : User level Event-Based Branch (EBB) notification */
 
+        /* FIXME: what if cam_ignore and LGS = 0 ? */
         /* USER ring */
         if  ((be32_to_cpu(qw1w2) & TM2_QW1W2_VO) &&
              (cam == xive_get_field32(TM2_QW1W2_OS_CAM, qw1w2)) &&
@@ -802,6 +814,22 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
     return -1;
 }
 
+bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    /*
+     * The xive2_presenter_tctx_match() above tells if there's a match
+     * but for VP-group notification, we still need to look at the
+     * priority to know if the thread can take the interrupt now or if
+     * it is precluded.
+     */
+    if (priority < regs[TM_CPPR]) {
+        return false;
+    }
+    return true;
+}
+
 static void xive2_router_realize(DeviceState *dev, Error **errp)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(dev);
@@ -841,7 +869,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     Xive2End end;
     uint8_t priority;
     uint8_t format;
-    bool found;
+    bool found, precluded;
     Xive2Nvp nvp;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
@@ -922,7 +950,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
                           xive2_end_is_ignore(&end),
                           priority,
-                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7));
+                          xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
+                          &precluded);
 
     /* TODO: Auto EOI. */
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 805b1d7b80..e78adaffa5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -422,6 +422,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas);
 typedef struct XiveTCTXMatch {
     XiveTCTX *tctx;
     uint8_t ring;
+    bool precluded;
 } XiveTCTXMatch;
 
 #define TYPE_XIVE_PRESENTER "xive-presenter"
@@ -450,7 +451,9 @@ int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
                            uint8_t nvt_blk, uint32_t nvt_idx,
                            bool cam_ignore, uint8_t priority,
-                           uint32_t logic_serv);
+                           uint32_t logic_serv, bool *precluded);
+
+uint32_t xive_get_vpgroup_size(uint32_t nvp_index);
 
 /*
  * XIVE Fabric (Interface between Interrupt Controller and Machine)
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 5bccf41159..65154f78d8 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -1,11 +1,9 @@
 /*
  * QEMU PowerPC XIVE2 interrupt controller model  (POWER10)
  *
- * Copyright (c) 2019-2022, IBM Corporation.
- *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * Copyright (c) 2019-2024, IBM Corporation.
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE2_H
@@ -121,6 +119,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, unsigned size);
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
+bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


