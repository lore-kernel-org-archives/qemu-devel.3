Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598C8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzGs-0000jx-NF; Tue, 11 Mar 2025 09:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDE-00043v-NU; Tue, 11 Mar 2025 09:00:00 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDB-00082v-Hp; Tue, 11 Mar 2025 09:00:00 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso9005405a91.1; 
 Tue, 11 Mar 2025 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697991; x=1742302791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTjpRh8AshfIRm5pJ5AIa8+ub5kge53Qy5H2Kvu+cVA=;
 b=noBanvvLtEQvQktWO2jBxGBNNbqAQsBxKjHzU7TMfapOr6LnQgHuGjKPGWaeLv0dLu
 ZAfrVoee8bJNkinmugqbxRrPzCGSn9WWIrv6eN3QWWC8uBVuBzHmPLN7tXSC8WlrMFFj
 et5ANPBj76fjPwO8Hpycg/+fXjNgHR+pKVpm9G+957N2XlI4pGv0ICuGB+JO1sk4OEFF
 IQnmdmSgcX6Sf+5O7JlxBq1AEJFV2702kOlUzKz1GgvozY1TzV/UpRnR+qlV/TdaAMql
 q4oF98wOGKisLju3SC52ukIfGfK10kWyjOWPuRzr0NpJpsJyyf7+a9z1pK8YxB/x9kvC
 ANiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697991; x=1742302791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTjpRh8AshfIRm5pJ5AIa8+ub5kge53Qy5H2Kvu+cVA=;
 b=XEMIyMxhuJDbC3NZ+LUyNnnagOWhYqpzPxEyXhAnbLWKFrtX6DxH1MEk+9wRWHgUrG
 SlDE92D3iIju+m/TvTNrSxITdbSsy2D0gXp04guTVL20FlSZT5qFT2HynePWSxSlprcW
 mU2cr11v17UGZW/YN/MpElrJSKb9NH9EAV6GqI3FpzkC1BAmhtUFbMxHev5D8gKbzyPd
 cHTWHy5CzvVB9j0E2fQyujwURBwzXSi3J+UkGOb/PBV4CciUHlKB9sLS0BzD5RdQijYM
 UbbGeXJ0CbVzsho9bUuXhT9nk7aDPkByH48hRUhZA4Pp24hRTEtcKkVSyNNw2KsP7X23
 stzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLT8855Ucfmk9D513+yfRCFTK6uxcnqS4G1SH8qIYh92gEjD+5p2I7xN9RdyRQOSIhUN5l0KPWaw==@nongnu.org
X-Gm-Message-State: AOJu0YzqRC0Iz72tknHaA5w9a4YrCaCUqkAuQOAOyA4Qa6+nCMAmUPEf
 Q/ZegDe4S27tACnS76XIyhhI3gNmTCIPieOqbjrVm9Gy1bfoJ2y9OiTG5Q==
X-Gm-Gg: ASbGncvY4WACg4mqg937Hr/iL9LcEw8yM6X/DXRMyeqxIsHXKwisn6qnMR2PCyFuFqs
 7enUFO3noJsJEmJLUbiCcjTCFvj3YzOo+hSNichds2xUKlRIVFMpQkEYZkb7LgV558KL5J04II4
 UA/ZvQhMx8u9E6lVKnd4uJUrsWPMDfEwhgIfH84riMRdsJJepMjX11hKa2iM7syz10amC1y8Rka
 NCy3C1r4uZ21NBkorBtGUmRgbgtXEaRnU36mzc/Xnd8AxUXH1SP3jwAo54uU/+aochZDpDCEcyI
 FxCcsUdQfbh7DGuSGGLACFEcTT/3d2CL2mlg3k3jKCu5suNzEaE=
X-Google-Smtp-Source: AGHT+IEM67xUBNJBPEPT1mrvnjjezGC4Sj5o21YDfJsIN8s7vSw+oXHfHEE5Pb3+WJP0fGJhsXA+xA==
X-Received: by 2002:a17:90b:4c81:b0:2fc:b40:339a with SMTP id
 98e67ed59e1d1-2ff7ce7abdfmr27297036a91.10.1741697990449; 
 Tue, 11 Mar 2025 05:59:50 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 27/72] ppc/xive2: Add undelivered group interrupt to backlog
Date: Tue, 11 Mar 2025 22:57:21 +1000
Message-ID: <20250311125815.903177-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

When a group interrupt cannot be delivered, we need to:
- increment the backlog counter for the group in the NVG table
  (if the END is configured to keep a backlog).
- start a broadcast operation to set the LSMFB field on matching CPUs
  which can't take the interrupt now because they're running at too
  high a priority.

[npiggin: squash in fixes from milesg]
[milesg: only load the NVP if the END is !ignore]
[milesg: always broadcast backlog, not only when there are precluded VPs]

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/pnv_xive2.c    |  42 +++++++++++++
 hw/intc/xive2.c        | 136 ++++++++++++++++++++++++++++++++---------
 hw/ppc/pnv.c           |  22 ++++++-
 include/hw/ppc/xive.h  |   5 ++
 include/hw/ppc/xive2.h |   1 +
 5 files changed, 175 insertions(+), 31 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 8429ccbd51..e7a7d1b50f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -705,6 +705,47 @@ static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
     return cfg;
 }
 
+static int pnv_xive2_broadcast(XivePresenter *xptr,
+                               uint8_t nvt_blk, uint32_t nvt_idx,
+                               uint8_t priority)
+{
+    PnvXive2 *xive = PNV_XIVE2(xptr);
+    PnvChip *chip = xive->chip;
+    int i, j;
+    bool gen1_tima_os =
+        xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+
+        for (j = 0; j < cc->nr_threads; j++) {
+            PowerPCCPU *cpu = pc->threads[j];
+            XiveTCTX *tctx;
+            int ring;
+
+            if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
+                continue;
+            }
+
+            tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+            if (gen1_tima_os) {
+                ring = xive_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
+                                                 nvt_idx, true, 0);
+            } else {
+                ring = xive2_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
+                                                  nvt_idx, true, 0);
+            }
+
+            if (ring != -1) {
+                xive2_tm_set_lsmfb(tctx, ring, priority);
+            }
+        }
+    }
+    return 0;
+}
+
 static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
 {
     return pnv_xive2_block_id(PNV_XIVE2(xrtr));
@@ -2444,6 +2485,7 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
 
     xpc->match_nvt  = pnv_xive2_match_nvt;
     xpc->get_config = pnv_xive2_presenter_get_config;
+    xpc->broadcast  = pnv_xive2_broadcast;
 };
 
 static const TypeInfo pnv_xive2_info = {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 41dbbdbb68..44d891f1f6 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -53,7 +53,8 @@ static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
 
     /*
      * The per-priority backlog counters are 24-bit and the structure
-     * is stored in big endian
+     * is stored in big endian. NVGC is 32-bytes long, so 24-bytes from
+     * w2, which fits 8 priorities * 24-bits per priority.
      */
     ptr = (uint8_t *)&nvgc->w2 + priority * 3;
     for (i = 0; i < 3; i++, ptr++) {
@@ -62,6 +63,30 @@ static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
     return val;
 }
 
+static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
+                                   uint32_t val)
+{
+    uint8_t *ptr, i;
+    uint32_t shift;
+
+    if (priority > 7) {
+        return;
+    }
+
+    if (val > 0xFFFFFF) {
+        val = 0xFFFFFF;
+    }
+    /*
+     * The per-priority backlog counters are 24-bit and the structure
+     * is stored in big endian
+     */
+    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
+    for (i = 0; i < 3; i++, ptr++) {
+        shift = 8 * (2 - i);
+        *ptr = (val >> shift) & 0xFF;
+    }
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
@@ -830,6 +855,19 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
     return true;
 }
 
+void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    /*
+     * Called by the router during a VP-group notification when the
+     * thread matches but can't take the interrupt because it's
+     * already running at a more favored priority. It then stores the
+     * new interrupt priority in the LSMFB field.
+     */
+    regs[TM_LSMFB] = priority;
+}
+
 static void xive2_router_realize(DeviceState *dev, Error **errp)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(dev);
@@ -870,7 +908,6 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     uint8_t priority;
     uint8_t format;
     bool found, precluded;
-    Xive2Nvp nvp;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
 
@@ -934,19 +971,6 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     nvp_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
     nvp_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
 
-    /* NVP cache lookup */
-    if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVP %x/%x\n",
-                      nvp_blk, nvp_idx);
-        return;
-    }
-
-    if (!xive2_nvp_is_valid(&nvp)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVP %x/%x is invalid\n",
-                      nvp_blk, nvp_idx);
-        return;
-    }
-
     found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
                           xive2_end_is_ignore(&end),
                           priority,
@@ -962,10 +986,9 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     /*
      * If no matching NVP is dispatched on a HW thread :
      * - specific VP: update the NVP structure if backlog is activated
-     * - logical server : forward request to IVPE (not supported)
+     * - VP-group: update the backlog counter for that priority in the NVG
      */
     if (xive2_end_is_backlog(&end)) {
-        uint8_t ipb;
 
         if (format == 1) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -974,19 +997,72 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             return;
         }
 
-        /*
-         * Record the IPB in the associated NVP structure for later
-         * use. The presenter will resend the interrupt when the vCPU
-         * is dispatched again on a HW thread.
-         */
-        ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2) |
-            xive_priority_to_ipb(priority);
-        nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
-        xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
-
-        /*
-         * On HW, follows a "Broadcast Backlog" to IVPEs
-         */
+        if (!xive2_end_is_ignore(&end)) {
+            uint8_t ipb;
+            Xive2Nvp nvp;
+
+            /* NVP cache lookup */
+            if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVP %x/%x\n",
+                              nvp_blk, nvp_idx);
+                return;
+            }
+
+            if (!xive2_nvp_is_valid(&nvp)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVP %x/%x is invalid\n",
+                              nvp_blk, nvp_idx);
+                return;
+            }
+
+            /*
+             * Record the IPB in the associated NVP structure for later
+             * use. The presenter will resend the interrupt when the vCPU
+             * is dispatched again on a HW thread.
+             */
+            ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2) |
+                xive_priority_to_ipb(priority);
+            nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
+            xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
+        } else {
+            Xive2Nvgc nvg;
+            uint32_t backlog;
+
+            /* For groups, the per-priority backlog counters are in the NVG */
+            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVG %x/%x\n",
+                              nvp_blk, nvp_idx);
+                return;
+            }
+
+            if (!xive2_nvgc_is_valid(&nvg)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is invalid\n",
+                              nvp_blk, nvp_idx);
+                return;
+            }
+
+            /*
+             * Increment the backlog counter for that priority.
+             * We only call broadcast the first time the counter is
+             * incremented. broadcast will set the LSMFB field of the TIMA of
+             * relevant threads so that they know an interrupt is pending.
+             */
+            backlog = xive2_nvgc_get_backlog(&nvg, priority) + 1;
+            xive2_nvgc_set_backlog(&nvg, priority, backlog);
+            xive2_router_write_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg);
+
+            if (backlog == 1) {
+                XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
+                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx, priority);
+
+                if (!xive2_end_is_precluded_escalation(&end)) {
+                    /*
+                     * The interrupt will be picked up when the
+                     * matching thread lowers its priority level
+                     */
+                    return;
+                }
+            }
+        }
     }
 
 do_escalation:
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6fec455ff9..af836c1388 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1,7 +1,9 @@
 /*
  * QEMU PowerPC PowerNV machine model
  *
- * Copyright (c) 2016, IBM Corporation.
+ * Copyright (c) 2016-2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -2662,6 +2664,23 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
     return total_count;
 }
 
+static int pnv10_xive_broadcast(XiveFabric *xfb,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                uint8_t priority)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+        xpc->broadcast(xptr, nvt_blk, nvt_idx, priority);
+    }
+    return 0;
+}
+
 static bool pnv_machine_get_big_core(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2795,6 +2814,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
+    xfc->broadcast = pnv10_xive_broadcast;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index e78adaffa5..6a410c6f1a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -442,6 +442,9 @@ struct XivePresenterClass {
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
     uint32_t (*get_config)(XivePresenter *xptr);
+    int (*broadcast)(XivePresenter *xptr,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     uint8_t priority);
 };
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
@@ -472,6 +475,8 @@ struct XiveFabricClass {
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
+    int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
+                     uint8_t priority);
 };
 
 /*
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 65154f78d8..ebf301bb5b 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -120,6 +120,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
+void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.47.1


