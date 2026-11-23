Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51933606A330
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPzIrVTm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkF-0006Bw-T8; Mon, 23 Nov 2026 12:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkF-0006BZ-3K
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:23 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkD-0002mx-4M
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:22 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4901E4403B;
 Mon, 23 Nov 2026 17:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F651F000EC;
 Mon, 23 Nov 2026 17:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454540;
 bh=K7qtqHsNY2qs2QCrjUuLc5KL4to8dyW2+P78ykKZqOw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lPzIrVTmIZjWu7zR9GptJHy6GATWGSSZ9Cohn4eYFI/Va/aD5/2alyeCmgNHg2I9W
 NS1VRpFEc7+yEaqODmlfVfa4aToBIkMKA3gAk6OYa0eR5Sj38l4BwGpPDCSnC++0OK
 iB92Tnz5MGnmqmkNcB/PcARDN/oeTFyuZmrG1keIjOKjHpX6I0dFFXs/IMYsfOceVq
 w4tTVY3as+TBSp3QRciDCBXmp5RK2NC1pgYoL4MiLrRfwl0hTesFv2V/15cSloBf4V
 cFAjEihZJeX3QT5x2h18fryD87cwxihAMNd+fa2E2bjqbsVCg7lKVGVjH1lxeTGtjj
 wLZIGUq4ehAkA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 08/14] hw/scsi/ncr53c710: Deliver completions from bottom
 halves
Date: Mon, 23 Nov 2026 18:21:45 +0100
Message-ID: <20261123172151.7605-9-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Completions are delivered asynchronously, as the real chip delivers
them, rather than reentrantly inside the interpreter: a reselect
reconnect and a tagged completion off host cached media (the install
CD-ROM) are deferred to a bottom half.  A reentrant completion would
collapse the disconnect and the completion interrupt into the one guest
MMIO write driving the engine and race the HP-UX 10.20 c720 driver's
completion bookkeeping.  Untagged and polled transfers keep inline
completion.

A SIGP kick that lands on a stopped engine, rather than one parked at
Wait Reselect, is held in sigp_pending_resume and replayed once the
engine parks.

Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 92 ++++++++++++++++++++++++++++++++++++++++-----
 hw/scsi/ncr53c710.h |  8 ++++
 2 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 75060f5d99..5522dedee8 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -74,6 +74,7 @@ static const char *lsi_reg_name(int offset)
 static uint8_t lsi_reg_readb(NCR710State *s, int offset);
 static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val);
 static void lsi_execute_script(NCR710State *s);
+static void lsi_issue_bh(void *opaque);
 static void lsi_set_phase(NCR710State *s, int phase);
 
 /*
@@ -107,6 +108,7 @@ void ncr710_soft_reset(NCR710State *s)
     s->select_tag = 0;
     s->command_complete = 0;
     s->script_running = false;
+    s->sigp_pending_resume = false;
 
     s->scntl0 = 0xc0;       /* full arbitration */
     s->scntl1 = 0;
@@ -273,6 +275,25 @@ static void lsi_bad_selection(NCR710State *s, uint32_t id)
     lsi_disconnect(s);
 }
 
+/*
+ * Deferred half of lsi_do_dma()'s SCSI continue.  It runs on a clean stack,
+ * so a cached backend's completion cannot arrive reentrantly inside the
+ * SCRIPTS interpreter.
+ */
+static void lsi_issue_bh(void *opaque)
+{
+    NCR710State *s = opaque;
+
+    if (!s->issue_pending) {
+        return;
+    }
+    s->issue_pending = false;
+    if (s->current == NULL || s->current->orphan) {
+        return;
+    }
+    scsi_req_continue(s->current->req);
+}
+
 static void lsi_do_dma(NCR710State *s, int out)
 {
     uint32_t count;
@@ -315,7 +336,21 @@ static void lsi_do_dma(NCR710State *s, int out)
     p->dma_len -= count;
     if (p->dma_len == 0) {
         p->dma_buf = NULL;
-        scsi_req_continue(req);
+        /*
+         * Defer the completing continue (dbc == 0) of a tagged transfer to a
+         * bottom half; the engine parks at DMA_IN_PROGRESS (set by the caller)
+         * meanwhile.
+         */
+        if ((p->tag & LSI_TAG_VALID) && s->dbc == 0) {
+            s->issue_pending = true;
+            aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_issue_bh, s);
+        } else {
+            /*
+             * Complete inline for untagged transfers and mid-transfer
+             * continues (dbc > 0).
+             */
+            scsi_req_continue(req);
+        }
     } else {
         p->dma_buf += count;
         lsi_resume_script(s);
@@ -418,20 +453,43 @@ static int lsi_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
     return 1;
 }
 
-/* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
-static void lsi_wait_reselect(NCR710State *s)
+/*
+ * Deferred half of lsi_wait_reselect(): reconnect a disconnected command
+ * whose data is ready and resume the engine.  Does nothing if the engine moved
+ * on while this was pending.
+ */
+static void lsi_reselect_bh(void *opaque)
 {
+    NCR710State *s = opaque;
     lsi_request *p;
 
-    if (s->current) {
+    if (s->current != NULL || s->waiting != LSI_WAIT_RESELECT) {
         return;
     }
     p = lsi_get_pending_req(s);
-    if (p) {
-        lsi_reselect(s, p);
+    if (p == NULL) {
+        return;
+    }
+    lsi_reselect(s, p);
+    s->waiting = LSI_NOWAIT;
+    lsi_execute_script(s);
+}
+
+/* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
+static void lsi_wait_reselect(NCR710State *s)
+{
+    if (s->current) {
+        return;
     }
-    if (s->current == NULL) {
-        s->waiting = LSI_WAIT_RESELECT;
+    /*
+     * Reselecting synchronously here, inside the guest register write that
+     * drove the engine to this Wait Reselect, would deliver the command's
+     * completion interrupt reentrantly.  Defer the reconnect to a bottom half;
+     * the engine parks meanwhile.
+     */
+    s->waiting = LSI_WAIT_RESELECT;
+    if (lsi_get_pending_req(s)) {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_reselect_bh, s);
     }
 }
 
@@ -931,9 +989,10 @@ again:
                 /*
                  * Two things release a Wait Reselect: SIGP (jump to the
                  * dispatch address latched in DNAD), or a disconnected command
-                 * becoming ready to reselect.
+                 * becoming ready to reselect.  A SIGP that arrived while the
+                 * engine was halted is held in sigp_pending_resume.
                  */
-                if (s->istat & LSI_ISTAT0_SIGP) {
+                if ((s->istat & LSI_ISTAT0_SIGP) || s->sigp_pending_resume) {
                     /*
                      * The SIGP divert is a one-shot: clear the latch so a
                      * later Wait Reselect does not re-fire on a stale SIGP.
@@ -941,6 +1000,7 @@ again:
                      * auto-switching.
                      */
                     s->istat &= ~LSI_ISTAT0_SIGP;
+                    s->sigp_pending_resume = false;
                     s->dsp = s->dnad;
                 } else if (!lsi_irq_on_rsl(s)) {
                     lsi_wait_reselect(s);
@@ -1405,6 +1465,17 @@ static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
             s->waiting = LSI_NOWAIT;
             s->dsp = s->dnad;
             lsi_execute_script(s);
+        } else if ((val & LSI_ISTAT0_SIGP) && !s->script_running &&
+                   s->waiting == LSI_NOWAIT) {
+            /*
+             * SIGP while the engine is halted on a just completed command,
+             * not parked at Wait Reselect.  Clear the SIGP latch, as a Wait
+             * Reselect consumption would, without disturbing the pending
+             * completion.  Remember the kick so the next command is selected
+             * once the engine parks again at Wait Reselect.
+             */
+            s->istat &= ~LSI_ISTAT0_SIGP;
+            s->sigp_pending_resume = true;
         }
         break;
     case NCR710_CTEST8:
@@ -1536,6 +1607,7 @@ const VMStateDescription vmstate_ncr710 = {
         VMSTATE_UINT32(select_tag, NCR710State),
         VMSTATE_INT32(command_complete, NCR710State),
         VMSTATE_BOOL(script_running, NCR710State),
+        VMSTATE_BOOL(sigp_pending_resume, NCR710State),
 
         VMSTATE_UINT8(scntl0, NCR710State),
         VMSTATE_UINT8(scntl1, NCR710State),
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 82202940ca..8b5cbfc135 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -93,6 +93,14 @@ typedef struct NCR710State {
     uint32_t select_tag;
     int command_complete;
     bool script_running;
+    /*
+     * A SIGP arrived while the engine was halted instead of parked at Wait
+     * Reselect; the Wait Reselect handler consumes it when the engine next
+     * parks.
+     */
+    bool sigp_pending_resume;
+    /* A SCSI continue was deferred to lsi_issue_bh. */
+    bool issue_pending;
     lsi_request *current;
     /* Disconnected tagged commands awaiting reselection. */
     QTAILQ_HEAD(, lsi_request) queue;
-- 
2.54.0


