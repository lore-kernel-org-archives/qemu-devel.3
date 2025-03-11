Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B54C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzDx-0004p6-2b; Tue, 11 Mar 2025 09:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDL-0004Fh-PI; Tue, 11 Mar 2025 09:00:08 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDF-000840-QC; Tue, 11 Mar 2025 09:00:06 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2feb96064e4so10448206a91.1; 
 Tue, 11 Mar 2025 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697997; x=1742302797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHn+7OUywAbF6FO5dZ4T4+uIeHrdZtwa40tDfqPgy7A=;
 b=Psudf4yGVd2ZJITxMYM22OKN0cf70PcUSaNfLZDlKFCPeauA09m6KI9dmQowjthw+y
 5JPQwb7/CCsHkmAgyjmCb9HFsZLh99g3k6tnjvnlpryBeAxhb5qwipgQ7oahWTKIO54x
 +C4ajFGjVtUtY7MELLFTbQ5GmApI57mQmjghLei35WhdW3TJnm66MmjWLFXZEqOJ5lup
 uauQylig3fMCqgmV8oklQ13PIGH3RFV9wIxAM8odX9z/T64jA0sUICl/D0XHVXjm6h2+
 HPF88wQa0PNq87pqL/yyW0Dde4sVr0+SxNkigudXf3ghfU2OzIpUT+1EvEe1wU5uAMCO
 um7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697997; x=1742302797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHn+7OUywAbF6FO5dZ4T4+uIeHrdZtwa40tDfqPgy7A=;
 b=EPYp/Ipx3GWX52i4yWND+obdd1o20yunktW7k/xEu1XbDISNi2cE2DXBL9V1ru0FHD
 77+GTNprkw2yb4vzA//z00N/BuvSZewS9okhy0HS06QF/dIgiln1TEh//WiinqQ4jAnd
 ZY20G8GesKOi74rHvMtxJ9D3pOxPocqv0bRDDdbtp2RoZKqZQQZQK7fznxxYzrmRAH/c
 OcWtytQhBJEvnlKi0eAhvik748pACApx2E+wfrZNLxsZXN3pjd/EyadpB54kV6AEMhLa
 jYlU1u+UZBTLZQsiabxf05ALl/zokNCgOU65CR53uSoiUglzvA1sfHIs1iAWB8ZquLsp
 SvxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfAsWG+lGNNlJrHlMsvwu9pMWgufkfqKDt67ktkMeZ3CNK4teDcAdZuc4mFWrcujo0Ng6eNR6TuA==@nongnu.org
X-Gm-Message-State: AOJu0Yy9iVMlu7y5KAW4zJfX3zlVOpeDWFWTHaW5wyk+g7I2G6E+MOD8
 zHJHnHyq7raRWHA47rcCUliouOcXir8xuRZlH1NIwPcRtX6I0UWNsZdp1g==
X-Gm-Gg: ASbGncvoMXzMEa3ODJDevpnpZUVbhgZiGLCTSyB7NTtE3g7/q9GbzALAFi7wEQp1kBc
 iNDLu8y3utjvQhisvRYLVdbm6I8lUV5r1SPM5VuhBZog8/JzA24RIW8HiseNfJ76eKhY3eu5qEQ
 DrVbfLbA72EkqXJIUZhA9/C/P+VfvTYMlS1PH/6mTTNJS2GfYvvW8GP9zC46pnOkAce6t63GGyO
 WZjpyGwcFvsFyICb+Wq/KNg4476GadZ6AdgWMFazC46R+XohdnoEyrH7Mon+pAnPgv78B6A+KX1
 P77UaKWtn+cdT/8CwagiQUvAkGHHM4jF0ISXOK3UWcQdzQ3mJQc=
X-Google-Smtp-Source: AGHT+IEWWLTlPLkk0d6vRY14TnrdFBc0oc0LqTtBycsYZpBwaZb3VOwD/4MqE5ApmwUm0Pi0FHb/fw==
X-Received: by 2002:a17:90b:2883:b0:2ff:52e1:c49f with SMTP id
 98e67ed59e1d1-2ff7ced8c0amr23219572a91.26.1741697996495; 
 Tue, 11 Mar 2025 05:59:56 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 29/72] ppc/xive2: Process group backlog when updating the CPPR
Date: Tue, 11 Mar 2025 22:57:23 +1000
Message-ID: <20250311125815.903177-30-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

When the hypervisor or OS pushes a new value to the CPPR, if the LSMFB
value is lower than the new CPPR value, there could be a pending group
interrupt in the backlog, so it needs to be scanned.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive.c         |   4 +-
 hw/intc/xive2.c        | 173 ++++++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/xive2.h |   4 +
 3 files changed, 177 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3e4c932f19..535e59646f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -589,7 +589,7 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive2_tm_set_os_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
@@ -597,7 +597,7 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
                                                      NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive2_tm_set_hv_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
                                                      NULL },
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 2fa7b90669..017c0f8bb4 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -17,6 +17,7 @@
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
 #include "hw/ppc/xive2_regs.h"
+#include "trace.h"
 
 uint32_t xive2_router_get_config(Xive2Router *xrtr)
 {
@@ -768,6 +769,172 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
+                                      uint32_t *nvp_blk, uint32_t *nvp_idx)
+{
+    uint32_t w2, cam;
+
+    w2 = xive_tctx_word2(&tctx->regs[ring]);
+    switch (ring) {
+    case TM_QW1_OS:
+        if (!(be32_to_cpu(w2) & TM2_QW1W2_VO)) {
+            return -1;
+        }
+        cam = xive_get_field32(TM2_QW1W2_OS_CAM, w2);
+        break;
+    case TM_QW2_HV_POOL:
+        if (!(be32_to_cpu(w2) & TM2_QW2W2_VP)) {
+            return -1;
+        }
+        cam = xive_get_field32(TM2_QW2W2_POOL_CAM, w2);
+        break;
+    case TM_QW3_HV_PHYS:
+        if (!(be32_to_cpu(w2) & TM2_QW3W2_VT)) {
+            return -1;
+        }
+        cam = xive2_tctx_hw_cam_line(tctx->xptr, tctx);
+        break;
+    default:
+        return -1;
+    }
+    *nvp_blk = xive2_nvp_blk(cam);
+    *nvp_idx = xive2_nvp_idx(cam);
+    return 0;
+}
+
+static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
+{
+    uint8_t *regs = &tctx->regs[ring];
+    Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
+    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
+    uint8_t pipr_min, lsmfb_min, ring_min;
+    bool group_enabled;
+    uint32_t nvp_blk, nvp_idx;
+    Xive2Nvp nvp;
+    int rc;
+
+    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
+                             regs[TM_IPB], regs[TM_PIPR],
+                             cppr, regs[TM_NSR]);
+
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr = 0xff;
+    }
+
+    old_cppr = regs[TM_CPPR];
+    regs[TM_CPPR] = cppr;
+
+    /*
+     * Recompute the PIPR based on local pending interrupts. It will
+     * be adjusted below if needed in case of pending group interrupts.
+     */
+    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
+    group_enabled = !!regs[TM_LGS];
+    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
+    ring_min = ring;
+
+    /* PHYS updates also depend on POOL values */
+    if (ring == TM_QW3_HV_PHYS) {
+        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
+
+        /* POOL values only matter if POOL ctx is valid */
+        if (pregs[TM_WORD2] & 0x80) {
+
+            uint8_t pool_pipr = xive_ipb_to_pipr(pregs[TM_IPB]);
+            uint8_t pool_lsmfb = pregs[TM_LSMFB];
+
+            /*
+             * Determine highest priority interrupt and
+             * remember which ring has it.
+             */
+            if (pool_pipr < pipr_min) {
+                pipr_min = pool_pipr;
+                if (pool_pipr < lsmfb_min) {
+                    ring_min = TM_QW2_HV_POOL;
+                }
+            }
+
+            /* Values needed for group priority calculation */
+            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
+                group_enabled = true;
+                lsmfb_min = pool_lsmfb;
+                if (lsmfb_min < pipr_min) {
+                    ring_min = TM_QW2_HV_POOL;
+                }
+            }
+        }
+    }
+    regs[TM_PIPR] = pipr_min;
+
+    rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
+    if (rc) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
+        return;
+    }
+
+    if (cppr < old_cppr) {
+        /*
+         * FIXME: check if there's a group interrupt being presented
+         * and if the new cppr prevents it. If so, then the group
+         * interrupt needs to be re-added to the backlog and
+         * re-triggered (see re-trigger END info in the NVGC
+         * structure)
+         */
+    }
+
+    if (group_enabled &&
+        lsmfb_min < cppr &&
+        lsmfb_min < regs[TM_PIPR]) {
+        /*
+         * Thread has seen a group interrupt with a higher priority
+         * than the new cppr or pending local interrupt. Check the
+         * backlog
+         */
+        if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
+                          nvp_blk, nvp_idx);
+            return;
+        }
+
+        if (!xive2_nvp_is_valid(&nvp)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                          nvp_blk, nvp_idx);
+            return;
+        }
+
+        first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
+        if (!first_group) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                          nvp_blk, nvp_idx);
+            return;
+        }
+
+        backlog_prio = xive2_presenter_backlog_scan(tctx->xptr,
+                                                    nvp_blk, nvp_idx,
+                                                    first_group, &group_level);
+        tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
+        if (backlog_prio != 0xFF) {
+            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
+                                         backlog_prio, group_level);
+            regs[TM_PIPR] = backlog_prio;
+        }
+    }
+    /* CPPR has changed, check if we need to raise a pending exception */
+    xive_tctx_notify(tctx, ring_min, group_level);
+}
+
+void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_cppr(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
+void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
+}
+
 static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
 {
     uint8_t *regs = &tctx->regs[ring];
@@ -938,7 +1105,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
 {
-    uint8_t *regs = &tctx->regs[ring];
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *alt_regs = &tctx->regs[alt_ring];
 
     /*
      * The xive2_presenter_tctx_match() above tells if there's a match
@@ -946,7 +1115,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
      * priority to know if the thread can take the interrupt now or if
      * it is precluded.
      */
-    if (priority < regs[TM_CPPR]) {
+    if (priority < alt_regs[TM_CPPR]) {
         return false;
     }
     return true;
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index ebf301bb5b..fc7422fea7 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -113,6 +113,10 @@ typedef struct Xive2EndSource {
  * XIVE2 Thread Interrupt Management Area (POWER10)
  */
 
+void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


