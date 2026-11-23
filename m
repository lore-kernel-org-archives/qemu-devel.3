Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DBC606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ltIB2IKv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkT-0006bM-Ka; Mon, 23 Nov 2026 12:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkN-0006UF-CA
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:34 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkL-0003Pe-NK
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:31 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21BFC62397;
 Mon, 23 Nov 2026 17:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53E21F000E1;
 Mon, 23 Nov 2026 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454548;
 bh=+oNDc3o3gz1XiDr3S9zFT2krXIhkc8komSvWhPXf97s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ltIB2IKvDlslTPxViA0HbV/7nzkK73GN91SuYkehHht7YD4BzVl/neqYCZrWVVojE
 YpMqRMbtcu87LGqyDUi41PAYCdp8dGgOMvEPyVjXcPccLPnCn6lNDXlLBtfd58RxG2
 UhZMkNT1cAdrIH7Z3yiVx8wopNe+VV8sh8BOMiRxHiXMZSjVkYG+hqe2cfoh3ngYDs
 4iaK6rLYq3nPBMlcd4AAqyLDL/6is5fm3GiSUf1TIBaecP0OBBqrwS0hklZQjxJ/El
 lIyyiZ8dg4t2v7O7ysarWppOMwEnr5o+9W+/88S9RA43lEQCSHffmo4PBOCp8IrxhU
 3mfhnQAFI8HjA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 11/14] hw/scsi/ncr53c710: Guard SCRIPTS reentrancy and cancel
 requests on soft reset
Date: Mon, 23 Nov 2026 18:21:48 +0100
Message-ID: <20261123172151.7605-12-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

The SCRIPTS interpreter guards against CVE-2023-0330. When a command finishes
while the interpreter is running, the interpreter moves on to the next
instruction without restarting itself. If a script keeps triggering itself, the
interpreter stops it after 8 nested restarts.

A guest ISTAT.RST soft reset cancels the connected and any queued
tagged requests, so a stale s->current cannot dangle into the next
command and queued requests are not leaked, mirroring the SCNTL1.RST
bus reset teardown.

Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 41 +++++++++++++++++++++++++++++++++++++++--
 hw/scsi/ncr53c710.h |  5 +++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index d6bd1c95fc..b7fc97b93b 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -104,8 +104,23 @@ static int lsi_id_from_bits(unsigned bits)
 
 void ncr710_soft_reset(NCR710State *s)
 {
+    lsi_request *p, *p_next;
+
     trace_ncr710_reset();
 
+    /*
+     * A guest ISTAT.RST soft reset can land with commands still in flight.
+     * Cancel them so no stale pointer survives the reset.
+     */
+    if (s->current && s->current->req) {
+        scsi_req_cancel(s->current->req);
+    }
+    QTAILQ_FOREACH_SAFE(p, &s->queue, next, p_next) {
+        if (p->req) {
+            scsi_req_cancel(p->req);
+        }
+    }
+
     s->carry = 0;
     s->msg_action = LSI_MSG_ACTION_COMMAND;
     s->msg_len = 0;
@@ -115,6 +130,11 @@ void ncr710_soft_reset(NCR710State *s)
     s->command_complete = 0;
     s->script_running = false;
     s->sigp_pending_resume = false;
+    /*
+     * Do not reset reentrancy_level here.  A SCRIPTS driven soft reset can run
+     * while lsi_execute_script frames are still on the stack; those frames
+     * decrement the counter as they unwind.
+     */
 
     s->scntl0 = 0xc0;       /* full arbitration */
     s->scntl1 = 0;
@@ -258,6 +278,16 @@ static int lsi_bad_phase(NCR710State *s, int new_phase)
 static void lsi_resume_script(NCR710State *s)
 {
     trace_ncr710_resume_script(s->waiting);
+    if (s->reentrancy_level > 0) {
+        /*
+         * A completion fired synchronously while the SCRIPTS interpreter is
+         * already on the stack.  Do not recurse: release the wait so the outer
+         * loop continues to the next instruction, which the completion has
+         * already armed.
+         */
+        s->waiting = LSI_NOWAIT;
+        return;
+    }
     if (s->waiting != LSI_DMA_SCRIPTS) {
         s->waiting = LSI_NOWAIT;
         lsi_execute_script(s);
@@ -858,13 +888,18 @@ static void lsi_execute_script(NCR710State *s)
         s->waiting = LSI_NOWAIT;
     }
 
+    s->reentrancy_level++;
     s->script_running = true;
 again:
-    /* Yield to the CPU after LSI_MAX_INSN instructions. */
-    if (++insn_processed > LSI_MAX_INSN) {
+    /*
+     * Yield to the CPU after LSI_MAX_INSN instructions, and guard against a
+     * script that retriggers itself (CVE-2023-0330).
+     */
+    if (++insn_processed > LSI_MAX_INSN || s->reentrancy_level > 8) {
         trace_ncr710_script_yield(insn_processed);
         s->waiting = LSI_WAIT_SCRIPTS;
         lsi_scripts_timer_start(s);
+        s->reentrancy_level--;
         return;
     }
 
@@ -1210,6 +1245,8 @@ again:
             goto again;
         }
     }
+
+    s->reentrancy_level--;
 }
 
 static uint8_t lsi_reg_readb(NCR710State *s, int offset)
diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 8b5cbfc135..9a4816794e 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -101,6 +101,11 @@ typedef struct NCR710State {
     bool sigp_pending_resume;
     /* A SCSI continue was deferred to lsi_issue_bh. */
     bool issue_pending;
+    /*
+     * SCRIPTS interpreter recursion depth; always 0 outside
+     * lsi_execute_script, so it is not migrated.
+     */
+    int reentrancy_level;
     lsi_request *current;
     /* Disconnected tagged commands awaiting reselection. */
     QTAILQ_HEAD(, lsi_request) queue;
-- 
2.54.0


