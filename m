Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8170C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnR-0008Ly-5t; Sat, 11 Jul 2026 18:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmk-0007AP-Ge; Sat, 11 Jul 2026 18:02:58 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifmg-0008Tu-Vp; Sat, 11 Jul 2026 18:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=2/UMdZmGkrqCMWpA4A1Pr5CQLkrQP/7AvMXSoTxKWMM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AfGFdYxFJ4ZlznojKjQP+GZ2uWs1aSg31uEE+Kqh4RnA/J/MsmxcCCNpIP+aM62Et
 p8BjJxTZa1sFFef70paiBOOnuAsb9EydyzUZbAmAlUq4eMfDhBxtbnsqGuPy7cMZGT
 xRWR/OURCWS9FMMRCG+euMa+sqL54POcAeL2lJdz01sn9kstaAAsNhZCVdlJjRTY2q
 /HdHnpWAKcLgRIFkThBsMSDmoe4ecpLhoJoDbJmk/iwaA62qkuABx+yB/pEwA80jzq
 yuN6w/UPMMEkeNFOrcWwQl4ISeGkKcJvO0cR89wCeUksSRO392xtKl6ex7s3YULimf
 RaeJUI/xdMeRQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF9F61C0AB0;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A48E03EAF3B;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8F1871332D; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jesper Wendel Devantier <j.devantier@samsung.com>,
 jaeyeong <fin@spl.team>, Jesper Wendel Devantier <foss@defmacro.it>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 37/81] hw/nvme: fix FDP set FDP events
Date: Sun, 12 Jul 2026 00:58:15 +0300
Message-ID: <20260711215904.3757-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jesper Wendel Devantier <j.devantier@samsung.com>

Addresses an issue reported whereby user-provided event type values
could trigger two issues:

 1. if provided event_type == 0xff -> out-of-bounds access

 2. if provided event_type > 7 -> generate a value too large for the
    u8 event mask.

This patch fixes (1) by correctly adjusting the length of the look-up
array to be 256 values.
This patch fixes (2) by:
  a. changing the event_type mask to 64bit, matching
     NvmeRuHandle.event_filter
  b. Matching the behavior of Get Feature - FDP Events by skipping
     event type values which we do not support.
     5.2.26.1.21 of the 2.3 Base specification does not explicitly
     tell us to reject unsupported event type values.
  c. Documenting in the event type lookup table, that supporting
     event types greater than 63 requires refactoring the masking
     code.

Cc: qemu-stable@nongnu.org
Reported-by: jaeyeong <fin@spl.team>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3631
Signed-off-by: Jesper Wendel Devantier <foss@defmacro.it>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit ec917cd49918b6135546b4f6c02658a1913e3d7c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 8463fd3e9a0..28cc8d0e7dc 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6242,10 +6242,6 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     for (uint8_t event_type = 0; event_type < FDP_EVT_MAX; event_type++) {
         uint8_t shift = nvme_fdp_evf_shifts[event_type];
         if (!shift && event_type) {
-            /*
-             * only first entry (event_type == 0) has a shift value of 0
-             * other entries are simply unpopulated.
-             */
             continue;
         }
 
@@ -6490,9 +6486,9 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
     uint8_t noet = (cdw11 >> 16) & 0xff;
     uint16_t ret, ruhid;
     uint8_t enable = le32_to_cpu(cmd->cdw12) & 0x1;
-    uint8_t event_mask = 0;
+    uint64_t event_mask = 0;
     unsigned int i;
-    g_autofree uint8_t *events = g_malloc0(noet);
+    g_autofree uint8_t *events = NULL;
     NvmeRuHandle *ruh = NULL;
 
     assert(ns);
@@ -6505,15 +6501,29 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
+    if (unlikely(noet == 0)) {
+        return NVME_SUCCESS;
+    }
+
     ruhid = ns->fdp.phs[ph];
     ruh = &n->subsys->endgrp.fdp.ruhs[ruhid];
 
+    events = g_malloc0(noet);
+
     ret = nvme_h2c(n, events, noet, req);
     if (ret) {
         return ret;
     }
 
     for (i = 0; i < noet; i++) {
+        /*
+         * We ignore requests to enable tracking of unsupported FDP event types
+         */
+        uint8_t event_type = events[i];
+        uint8_t shift = nvme_fdp_evf_shifts[event_type];
+        if (!shift && event_type) {
+            continue;
+        }
         event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
     }
 
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index d66f7dc82d5..ad0f8fa9678 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -160,7 +160,14 @@ typedef struct NvmeZone {
 #define NVME_FDP_MAX_NS_RUHS 32u
 #define FDPVSS 0
 
-static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX] = {
+/*
+ * NOTE: Apart from event type 0, any event type with a shift value of 0 is
+ * considered unsupported and thus skipped in get/set features calls.
+ *
+ * NOTE: NvmeRuHandle uses a 64bit event mask - refactor to support event types
+ *       of 63 or greater.
+ */
+static const uint8_t nvme_fdp_evf_shifts[FDP_EVT_MAX + 1] = {
     /* Host events */
     [FDP_EVT_RU_NOT_FULLY_WRITTEN]      = 0,
     [FDP_EVT_RU_ATL_EXCEEDED]           = 1,
-- 
2.47.3


