Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FD8C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKO-0001rY-AO; Mon, 21 Jul 2025 12:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ9-000678-LM
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ6-0001eD-PN
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DxO+MEsa6kAwvFVPm9WTdeaXRowfeF8rs791JdvIT+U=;
 b=jCVVDilzVcY9OzhzMUm9HYB6ra7PVXE2YVnGyL8HxYsetQdrbowoLXtkCJru6BT1IVyf/G
 UqUbchbO6waVRhDry731YOS25FrpR8hKRBH5Mx4B43i8n9pmdrUNI2OS2LbY+R5PlgAwfr
 q+6OOmibMzYPMyGdQRJyxhq3jimfgzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-0SXzTDBnP6Oz78ekTqNkdQ-1; Mon,
 21 Jul 2025 12:23:59 -0400
X-MC-Unique: 0SXzTDBnP6Oz78ekTqNkdQ-1
X-Mimecast-MFC-AGG-ID: 0SXzTDBnP6Oz78ekTqNkdQ_1753115038
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23ED11800359; Mon, 21 Jul 2025 16:23:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB38919560AD; Mon, 21 Jul 2025 16:23:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/50] ppc/xive: Change presenter .match_nvt to match not
 present
Date: Mon, 21 Jul 2025 18:22:11 +0200
Message-ID: <20250721162233.686837-29-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Have the match_nvt method only perform a TCTX match but don't present
the interrupt, the caller presents. This has no functional change, but
allows for more complicated presentation logic after matching.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-29-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h | 27 +++++++++++++----------
 hw/intc/pnv_xive.c    | 16 +++++++-------
 hw/intc/pnv_xive2.c   | 16 +++++++-------
 hw/intc/spapr_xive.c  | 18 +++++++--------
 hw/intc/xive.c        | 51 +++++++++++++++----------------------------
 hw/intc/xive2.c       | 31 +++++++++++++-------------
 hw/ppc/pnv.c          | 48 ++++++++++++++--------------------------
 hw/ppc/spapr.c        | 21 +++++++-----------
 8 files changed, 97 insertions(+), 131 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 46d05d74fbfb..8152a9df3d39 100644
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
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 935c0e4742f5..c2ca40b8be87 100644
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
index 7b4a33228e05..e019cad5c14c 100644
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
index 440edb97d8d3..e393f5dcdccf 100644
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
index 2f72d6ecd5a5..c92e819053e8 100644
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
index 2791985cf29b..602b23d06d80 100644
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
index 4a49e9d1a865..d84c9067edb3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2608,62 +2608,46 @@ static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
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
index 40f53ad7b344..1855a3cd8d03 100644
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
-- 
2.50.1


