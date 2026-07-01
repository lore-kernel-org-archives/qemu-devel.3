Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C5C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf2oa-00020o-Fz; Wed, 01 Jul 2026 17:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.i3sbe3ri2szxq23=i4g2cd7udsv6=3qoiy9vdttodoh@em1175899.techtravels.org>)
 id 1wf2oZ-00020f-KU
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:49:51 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.i3sbe3ri2szxq23=i4g2cd7udsv6=3qoiy9vdttodoh@em1175899.techtravels.org>)
 id 1wf2oW-0003qr-QF
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 17:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782942585; h=from :
 subject : to : message-id : date;
 bh=HrnERIchmfr98hxVHqmX5VPYqWMD94gizr69iCT6pG0=;
 b=EABINQUOM2fXqRb284pfBzyV913bDdLkBtmEZTfzxnEjywEzwTqMEpzXzmSPQu102fThu
 hsvdrOEgWxecfON9wZbMrHoq3x4R0Dzh1MpMbTo9MPdtrd/GPcJyENeGPd77AmV/gxqc+ZS
 sC8tdHpXnmTGadHR2uXBcqX+6EV3C/qlhQyWMmjDcJL6rVdj329Oja6oPSLF9pgV9m/VB4A
 PFJDL4SmVDpvmv32T8yj87U4XHuCokUQm5d2osPTfWON2Oo3n/nq6X2PeDU4dnCZlL6cWJm
 dWTYwIdGzg28UQoYIPgCHgYxmQlhc3elDNWBexO/vpIehD23LLvK4qB78Kdw==
Received: from [10.34.231.120] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wf2ZG-3Quys430272-ovsJ; Wed, 01 Jul 2026 21:34:02 +0000
Received: from [10.91.249.253] (helo=antecquad..) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wf2ZF-FnQW0hPscrZ-JVFq; Wed, 01 Jul 2026 21:34:01 +0000
From: Keith Monahan <keith@techtravels.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Keith Monahan <keith@techtravels.org>
Subject: [PATCH v2 4/4] hw/scsi/ncr53c710: support HP-UX overlapped tagged
 commands
Date: Wed,  1 Jul 2026 17:33:59 -0400
Message-ID: <20260701213359.1855870-5-keith@techtravels.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701213359.1855870-1-keith@techtravels.org>
References: <20260701213359.1855870-1-keith@techtravels.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aL0uvZj:1175899svwHxevZJG
X-smtpcorp-track: LOMAs7nh8Zoa.Avp51DCavJgT.utI04wir3up
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.i3sbe3ri2szxq23=i4g2cd7udsv6=3qoiy9vdttodoh@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The HP-UX 10.20 c720 driver overlaps tagged commands and recovers a
disconnected command by parking the SCRIPTS engine on a Wait Reselect
instruction with the reselection interrupt disabled (SIEN.SEL clear),
which the base engine cannot service.  Add the target-initiated
disconnect/reselect and asynchronous completion path it needs.

A tagged command whose data is not yet ready is disconnected and queued
(only under a Wait Reselect driver; untagged transfers and
reselection-interrupt drivers keep the connected path), and reselected
once its data is ready and the engine is parked at Wait Reselect.
Completions are delivered asynchronously through a bottom half rather than
reentrantly inside the interpreter, and the interpreter guards the
reentrancy class behind CVE-2023-0330.

The c720 driver also issues its "start next command" SIGP kick with CPU
interrupts masked and then spins, so after a register write starts an
asynchronous transfer the model drives it to completion before returning
to the guest (a bounded synchronous drain under the BQL, as IDE and
MegaSAS do, falling back to asynchronous completion if it cannot
advance), and a SIGP kick that lands on a stopped engine is held and
replayed once it parks.

The HP-UX 10.20 install kernel is also nonconformant in negotiation: its
self-modifying SCRIPTS reads a second message byte after a MESSAGE REJECT
and hangs unless it is SAVE DATA POINTERS, while NetBSD's osiop resets the
bus if it sees that byte.  The two are told apart by ATN state as the
reject is consumed (HP-UX has deasserted ATN, a conformant initiator has
not), so the extra byte is appended only for HP-UX.

With this, HP-UX 10.20 installs and reboots into the installed system on
both the Ignite (16700A) media and a software install that overlaps
tagged commands.

Signed-off-by: Keith Monahan <keith@techtravels.org>
---
 hw/scsi/ncr53c710.c | 295 +++++++++++++++++++++++++++++++++++++++++---
 hw/scsi/ncr53c710.h |  19 +++
 2 files changed, 295 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57cd7d91a4..1dcc111cc9 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -119,6 +119,14 @@
 
 #define NCR710_BUF_SIZE     4096
 
+/*
+ * Safety bound on the synchronous completion drain loop in ncr710_reg_write().
+ * A real transfer needs only a handful of iterations; this cap prevents an
+ * unbounded spin if a drain ever fails to progress (it then falls back to
+ * asynchronous completion).
+ */
+#define NCR710_DRAIN_MAX_ITERS  100000
+
 /* waiting state machine (mirrors lsi53c895a). */
 enum {
     NCR710_NOWAIT = 0,        /* SCRIPTS running or stopped */
@@ -167,6 +175,7 @@ static const char *ncr710_reg_name(int offset)
 static uint8_t ncr710_reg_readb(NCR710State *s, int offset);
 static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val);
 static void ncr710_execute_script(NCR710State *s);
+static void ncr710_issue_bh(void *opaque);
 static void ncr710_set_phase(NCR710State *s, int phase);
 
 /*
@@ -225,6 +234,14 @@ void ncr710_soft_reset(NCR710State *s)
     s->select_tag = 0;
     s->command_complete = 0;
     s->script_running = false;
+    s->sigp_pending_resume = false;
+    /*
+     * Do not reset reentrancy_level here.  A SCRIPTS driven soft reset (a guest
+     * write of ISTAT.RST from a register move) can run while execute_script
+     * frames are still on the stack; those frames decrement the counter as they
+     * unwind, so zeroing it would underflow negative and defeat the reentrancy
+     * guard.  It is zero at device init and balances itself to zero.
+     */
 
     s->scntl0 = 0xc0;       /* full arbitration */
     s->scntl1 = 0;
@@ -371,6 +388,21 @@ static int ncr710_bad_phase(NCR710State *s, int new_phase)
 static void ncr710_resume_script(NCR710State *s)
 {
     trace_ncr710_resume_script(s->waiting);
+    if (s->reentrancy_level > 0) {
+        /*
+         * A completion fired synchronously while the SCRIPTS interpreter is
+         * already on the stack, e.g. inline GOOD status for a no data
+         * command (TEST UNIT READY, START STOP UNIT, ...) completing inside
+         * scsi_req_enqueue().  Reentering ncr710_execute_script() here would
+         * advance s->dsp underneath the outer interpreter frame and can
+         * double execute SCRIPTS (the reentrancy class behind CVE-2023-0330
+         * in lsi53c895a).  Do not recurse: release the wait so the outer
+         * loop continues to the next instruction, which the completion has
+         * already armed (PHASE_ST, via ncr710_command_complete()).
+         */
+        s->waiting = NCR710_NOWAIT;
+        return;
+    }
     if (s->waiting != NCR710_DMA_SCRIPTS) {
         s->waiting = NCR710_NOWAIT;
         ncr710_execute_script(s);
@@ -394,6 +426,26 @@ static void ncr710_bad_selection(NCR710State *s, uint32_t id)
     ncr710_disconnect(s);
 }
 
+/*
+ * Deferred half of ncr710_do_dma()'s SCSI continue: runs on a clean stack so a
+ * cached backend's completion arrives asynchronously (reentrancy_level 0)
+ * instead of reentrantly inside the SCRIPTS interpreter.  Guarded against an
+ * orphaned/cancelled request like ncr710_reselect_bh.
+ */
+static void ncr710_issue_bh(void *opaque)
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
 static void ncr710_do_dma(NCR710State *s, int out)
 {
     uint32_t count;
@@ -436,7 +488,30 @@ static void ncr710_do_dma(NCR710State *s, int out)
     p->dma_len -= count;
     if (p->dma_len == 0) {
         p->dma_buf = NULL;
-        scsi_req_continue(req);
+        /*
+         * Defer the completing continue (Block Move satisfied, dbc == 0) of a
+         * tagged disconnect/reselect transfer to a bottom half: its
+         * scsi_req_continue can trigger a cached backend (CD-ROM) completion
+         * reentrantly inside execute_script, collapsing the disconnect and
+         * completion INT into the guest MMIO write driving the engine.  That
+         * lets the HP-UX c720 driver's next-command SIGP kick race ahead of its
+         * completion ISR and wedge the install.  Deferring makes completion an
+         * autonomous async event, like the disk-backed path;
+         * the engine parks at DMA_IN_PROGRESS (set by the caller) meanwhile.
+         */
+        if ((p->tag & NCR710_TAG_VALID) && s->dbc == 0) {
+            s->issue_pending = true;
+            aio_bh_schedule_oneshot(qemu_get_aio_context(), ncr710_issue_bh, s);
+        } else {
+            /*
+             * Complete inline for untagged transfers (the connected, polled
+             * early-boot and PDC path: SeaBIOS, ISL, pre-driver probe) and
+             * mid-transfer continues (dbc > 0) that fetch more data without
+             * completing the command (deferring every chunk would stall large
+             * multi-chunk reads).
+             */
+            scsi_req_continue(req);
+        }
     } else {
         p->dma_buf += count;
         ncr710_resume_script(s);
@@ -478,6 +553,20 @@ static NCR710Request *ncr710_get_pending_req(NCR710State *s)
     return NULL;
 }
 
+/* Move the in-flight command to the disconnected queue (target disconnect). */
+static void ncr710_queue_command(NCR710State *s)
+{
+    NCR710Request *p = s->current;
+
+    trace_ncr710_queue_command(p->tag);
+    assert(s->current != NULL);
+    assert(s->current->dma_len == 0);
+    QTAILQ_INSERT_TAIL(&s->queue, s->current, next);
+    s->current = NULL;
+    p->pending = 0;
+    p->out = (s->sstat2 & PHASE_MASK) == PHASE_DO;
+}
+
 /* Reselect a disconnected command to resume (continue) its data transfer. */
 static void ncr710_reselect(NCR710State *s, NCR710Request *p)
 {
@@ -528,20 +617,51 @@ static int ncr710_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
     return 1;
 }
 
-/* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
-static void ncr710_wait_reselect(NCR710State *s)
+/*
+ * Deferred half of ncr710_wait_reselect(): reconnect a disconnected command
+ * whose data is ready and resume the engine, on a clean (bottom half) stack.
+ * Guarded so it does nothing if a guest SIGP wake or an inline transfer_data
+ * reselection moved the engine on while this was pending.
+ */
+static void ncr710_reselect_bh(void *opaque)
 {
+    NCR710State *s = opaque;
     NCR710Request *p;
 
-    if (s->current) {
+    if (s->current != NULL || s->waiting != NCR710_WAIT_RESELECT) {
         return;
     }
     p = ncr710_get_pending_req(s);
-    if (p) {
-        ncr710_reselect(s, p);
+    if (p == NULL) {
+        return;
     }
-    if (s->current == NULL) {
-        s->waiting = NCR710_WAIT_RESELECT;
+    ncr710_reselect(s, p);
+    s->waiting = NCR710_NOWAIT;
+    ncr710_execute_script(s);
+}
+
+/* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
+static void ncr710_wait_reselect(NCR710State *s)
+{
+    if (s->current) {
+        return;
+    }
+    /*
+     * A disconnected command whose data is ready must reconnect to resume its
+     * transfer.  Reselecting synchronously here, inside the guest register
+     * write that drove the engine to this Wait Reselect, would deliver the
+     * command's completion interrupt reentrantly in the middle of driver flow,
+     * racing the HP-UX 10.20 c720 driver's completion bookkeeping and dropping
+     * a biodone/wakeup (the install then sleeps forever; the model idles
+     * with the queue empty).  Defer the reconnect to a bottom half so it
+     * lands on a clean stack after the register write returns, as a real target
+     * initiated reselection would arrive.  The engine parks meanwhile; if more
+     * data arrives first, transfer_data's own reselection (or a SIGP wake)
+     * handles it and the bottom half does nothing.
+     */
+    s->waiting = NCR710_WAIT_RESELECT;
+    if (ncr710_get_pending_req(s)) {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), ncr710_reselect_bh, s);
     }
 }
 
@@ -667,7 +787,36 @@ static void ncr710_do_command(NCR710State *s)
     }
     if (!s->command_complete) {
         if (n) {
-            /* Stay connected; the block move waits for transfer_data. */
+            if ((s->current->tag & NCR710_TAG_VALID) &&
+                !ncr710_irq_on_rsl(s)) {
+                /*
+                 * Tagged command whose data is not yet ready (typically a read
+                 * whose media access has not completed), issued by a driver
+                 * that recovers a disconnected command by parking the SCRIPTS
+                 * engine on a Wait Reselect instruction (SIEN.SEL clear, e.g.
+                 * HP-UX). Disconnect and queue it so the bus is free for
+                 * further tagged commands; ncr710_wait_reselect() reselects it
+                 * once its data is ready.
+                 *
+                 * Do not disconnect for:
+                 *   - untagged transfers (SeaBIOS/PDC firmware, simple
+                 *     drivers), which have no Wait Reselect handler; and
+                 *   - reselection-interrupt drivers (SIEN.SEL set, e.g. Linux's
+                 *     53c700), which expect a target-reselect interrupt with
+                 *     the 700-family reselection handshake rather than a script
+                 *     park.
+                 * Both keep the connected behaviour and complete inline.
+                 */
+                ncr710_add_msg_byte(s, 2);   /* SAVE DATA POINTER */
+                ncr710_add_msg_byte(s, 4);   /* DISCONNECT */
+                ncr710_set_phase(s, PHASE_MI);
+                s->msg_action = NCR710_MSG_ACTION_DISCONNECT;
+                ncr710_queue_command(s);
+            }
+            /*
+             * Otherwise stay connected and let the block move wait for
+             * transfer_data; no disconnect is fabricated (see policy above).
+             */
         } else {
             /*
              * Async no data command (e.g. SYNCHRONIZE CACHE from Linux
@@ -741,6 +890,17 @@ static void ncr710_do_msgin(NCR710State *s)
     if (!s->msg_len) {
         switch (s->msg_action) {
         case NCR710_MSG_ACTION_COMMAND:
+            /*
+             * A MESSAGE REJECT declining negotiation was just consumed.
+             * The HP-UX install template reads it with ATN deasserted and
+             * requires a trailing SAVE DATA POINTERS (0x02); a conformant
+             * initiator (NetBSD, Linux) reads it with ATN still asserted and
+             * wants no second byte.  See ncr710_do_msgout for the
+             * discriminator.
+             */
+            if (s->sfbr == 7 && !(s->socl & NCR710_SOCL_ATN)) {
+                ncr710_add_msg_byte(s, 2);   /* SAVE DATA POINTERS (HP-UX) */
+            }
             /*
              * Stay in MSG IN: SSTAT2 latches the last REQ phase, so the driver
              * samples MSG IN at the script interrupt and the lazy MSG IN ->
@@ -899,14 +1059,13 @@ static void ncr710_execute_script(NCR710State *s)
     uint32_t addr;
     int opcode;
     int insn_processed = 0;
-    static int reentrancy_level;
 
     if (s->waiting == NCR710_WAIT_SCRIPTS) {
         timer_del(s->scripts_timer);
         s->waiting = NCR710_NOWAIT;
     }
 
-    reentrancy_level++;
+    s->reentrancy_level++;
     s->script_running = true;
 again:
     /*
@@ -914,11 +1073,11 @@ again:
      * waiting on a memory change make progress), and guard against a script
      * that retriggers itself (CVE-2023-0330) via the reentrancy counter.
      */
-    if (++insn_processed > NCR710_MAX_INSN || reentrancy_level > 8) {
+    if (++insn_processed > NCR710_MAX_INSN || s->reentrancy_level > 8) {
         trace_ncr710_script_yield(insn_processed);
         s->waiting = NCR710_WAIT_SCRIPTS;
         ncr710_scripts_timer_start(s);
-        reentrancy_level--;
+        s->reentrancy_level--;
         return;
     }
 
@@ -1065,11 +1224,23 @@ again:
                 break;
             case 2: /* Wait Reselect */
                 /*
-                 * A SIGP "start next command" kick jumps to the dispatch
-                 * address latched in DNAD; otherwise reconnect a ready queued
-                 * command, or park.
+                 * Two things release a Wait Reselect: the driver's SIGP "start
+                 * next command" kick (jump to the dispatch address latched in
+                 * DNAD), or a disconnected tagged command becoming ready to
+                 * reselect.  A SIGP that arrived while the engine was halted at
+                 * a completion INT is held in sigp_pending_resume and consumed
+                 * here.  Otherwise reconnect a ready queued command, or park.
                  */
-                if (s->istat & NCR710_ISTAT_SIGP) {
+                if ((s->istat & NCR710_ISTAT_SIGP) || s->sigp_pending_resume) {
+                    /*
+                     * The SIGP divert is a one-shot: clear the latch as it is
+                     * consumed so a subsequent Wait Reselect does not re-fire
+                     * on a stale SIGP, and so SIGP is never left set across a
+                     * real reselection (Jun92 p.53: an active SIGP at
+                     * reselection disables target-mode auto-switching).
+                     */
+                    s->istat &= ~NCR710_ISTAT_SIGP;
+                    s->sigp_pending_resume = false;
                     s->dsp = s->dnad;
                 } else if (!ncr710_irq_on_rsl(s)) {
                     ncr710_wait_reselect(s);
@@ -1266,7 +1437,7 @@ again:
         }
     }
 
-    reentrancy_level--;
+    s->reentrancy_level--;
 }
 
 #define CASE_GET_REG24(name, addr) \
@@ -1528,6 +1699,52 @@ static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val)
         if (val & NCR710_ISTAT_ABRT) {
             ncr710_script_dma_interrupt(s, NCR710_DSTAT_ABRT);
         }
+        if (s->waiting == NCR710_WAIT_RESELECT && (val & NCR710_ISTAT_SIGP)) {
+            /*
+             * SIGP "start next command" wake of a parked Wait Reselect.  Run
+             * the engine synchronously: the Wait Reselect opcode, on SIGP,
+             * jumps to the DNAD dispatch and SELECTs the next command (Jun92
+             * p.69 step 3).  This SELECT must take priority over any
+             * disconnected command pending reselection: on real silicon the
+             * SIGP jump wins and the pending target reselects later, when the
+             * engine is next parked.  Deferring this to a bottom half let
+             * ncr710_reselect_bh win the race and reconnect a pending command
+             * instead of selecting the new one, stranding the driver's
+             * start-next kick (it polls, sees no progress, and resets the bus).
+             * qemu_set_irq only raises the IRQ line here; the guest takes it at
+             * the next instruction boundary, after this store returns, so this
+             * is not a reentrant interrupt delivery.
+             */
+            trace_ncr710_awoken();
+            s->waiting = NCR710_NOWAIT;
+            s->dsp = s->dnad;
+            ncr710_execute_script(s);
+        } else if ((val & NCR710_ISTAT_SIGP) && !s->script_running &&
+                   s->waiting == NCR710_NOWAIT) {
+            /*
+             * The driver's "start next command" SIGP kick raced ahead of the
+             * prior command's completion ISR: the engine is halted (script
+             * stopped, not parked at Wait Reselect) on a just completed
+             * command, either at its completion INT or in the brief window
+             * after the ISR has read cleared DSTAT but before it restarts the
+             * engine.  The wake above is skipped, so the kick only latches
+             * SIGP.  On real silicon the completion ISR runs before this lower
+             * priority kick, so the kick always lands on a parked Wait
+             * Reselect; under TCG it can land in the completion window.  The
+             * driver then polls the engine, sees no progress (SIGP still
+             * latched, DCMD/bus unchanged) and resets the SCSI bus, destroying
+             * the in flight command and hanging the install.
+             *
+             * Present "kick consumed" to that poll without disturbing any
+             * pending completion: clear the SIGP latch, exactly as a real Wait
+             * Reselect consumption would.  DSTAT/DSPS/DIP and the asserted IRQ
+             * are untouched, so the real completion ISR still services the
+             * command. Remember the kick so the next command is selected once
+             * the engine parks again at Wait Reselect (execute_script, case 2).
+             */
+            s->istat &= ~NCR710_ISTAT_SIGP;
+            s->sigp_pending_resume = true;
+        }
         break;
     case NCR710_CTEST8:
         /*
@@ -1599,7 +1816,40 @@ uint64_t ncr710_reg_read(NCR710State *s, hwaddr addr, unsigned size)
 
 void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
 {
+    unsigned drained = 0;
+
     ncr710_reg_writeb(s, addr & 0xff, val & 0xff);
+
+    /*
+     * Drive any asynchronous SCSI transfer the register write kicked off to
+     * completion before returning to the guest, so its completion interrupt is
+     * raised first.  The HP-UX 10.20 c720 driver issues its "start next
+     * command" SIGP kick with CPU interrupts masked and then spins; a still
+     * pending asynchronous completion (its bottom half has not run) would land
+     * in that masked window unserviced, and the driver's watchdog would reset
+     * the bus.  Real hardware takes the higher priority completion interrupt
+     * before that poll.
+     *
+     * A deferred continue (ncr710_issue_bh, for a tagged reselect transfer) has
+     * not issued its backing I/O yet, so pump it inline first; otherwise
+     * blk_drain the backend.  The loop is bounded by NCR710_DRAIN_MAX_ITERS and
+     * falls back to asynchronous completion (trace_ncr710_drain_exhausted) if it
+     * cannot make progress.
+     */
+    while (s->waiting == NCR710_DMA_IN_PROGRESS && s->current != NULL &&
+           s->current->req != NULL) {
+        if (drained++ >= NCR710_DRAIN_MAX_ITERS) {
+            trace_ncr710_drain_exhausted(drained);
+            break;
+        }
+        if (s->issue_pending) {
+            ncr710_issue_bh(s);
+        } else if (s->current->req->dev->conf.blk != NULL) {
+            blk_drain(s->current->req->dev->conf.blk);
+        } else {
+            break;      /* nothing deferred and no backend to drain */
+        }
+    }
 }
 
 static int ncr710_pre_save(void *opaque)
@@ -1644,7 +1894,7 @@ const VMStateDescription vmstate_ncr710 = {
      * raised in lockstep so a legacy stream is rejected rather than parsed
      * positionally into the new layout.
      */
-    .version_id = 2,
+    .version_id = 3,
     .minimum_version_id = 2,
     .pre_save = ncr710_pre_save,
     .post_load = ncr710_post_load,
@@ -1659,6 +1909,13 @@ const VMStateDescription vmstate_ncr710 = {
         VMSTATE_UINT32(select_tag, NCR710State),
         VMSTATE_INT32(command_complete, NCR710State),
         VMSTATE_BOOL(script_running, NCR710State),
+        /*
+         * A deferred "start next command" SIGP kick (version 3+).  Unlike
+         * reentrancy_level it can be live across a migration point (set while
+         * the engine is halted at a completion INT awaiting its ISR), so it is
+         * migrated; absent from a v2 stream it defaults to false.
+         */
+        VMSTATE_BOOL_V(sigp_pending_resume, NCR710State, 3),
 
         VMSTATE_UINT8(scntl0, NCR710State),
         VMSTATE_UINT8(scntl1, NCR710State),
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 7bcefae902..4e15c9d0c1 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -95,6 +95,25 @@ typedef struct NCR710State {
     uint32_t select_tag;
     int command_complete;
     bool script_running;
+    /*
+     * The driver's "start next command" SIGP kick landed while the engine was
+     * halted at a completion INT (waiting==NOWAIT) instead of parked at Wait
+     * Reselect, so the normal SIGP wake is skipped.  The ISTAT write clears the
+     * SIGP latch (presenting the kick as "consumed" to the driver's poll) and
+     * sets this flag instead; the Wait Reselect handler (execute_script case 2)
+     * consumes it when the engine next parks, selecting the next command.
+     */
+    bool sigp_pending_resume;
+    /*
+     * A cached-backend SCSI continue was deferred to ncr710_issue_bh so its
+     * completion arrives asynchronously, not reentrantly inside the engine.
+     */
+    bool issue_pending;
+    /*
+     * SCRIPTS interpreter on-stack recursion depth; transient (always 0
+     * outside execute_script), so it is not migrated in vmstate.
+     */
+    int reentrancy_level;
     NCR710Request *current;
     /*
      * Disconnected tagged commands awaiting target-initiated reselection
-- 
2.43.0


