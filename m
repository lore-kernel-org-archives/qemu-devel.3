Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tz5GG9iR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXkJ-0006IN-Nj; Mon, 23 Nov 2026 12:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkH-0006EA-JX
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:25 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVXkG-0002xX-0w
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:22:25 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6727D6238D;
 Mon, 23 Nov 2026 17:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088081F000C0;
 Mon, 23 Nov 2026 17:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795454543;
 bh=VGBVfMxDCicHLKWal5RFeUy7+lYxfrUcbpJpWQGcpm8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Tz5GG9iRwpwiozWhGjZx8EEcCfAIygyicwpyL/tfAhnpkK+lYhKtW7Lqp7jYrj39h
 3mXxpKBbVeDgzFVbpCobEe1GadOjeyOg7sdk/aZTvRPDU4dpYNwAp58tT7m4cyitYJ
 8Jt6chX7sH0ZJf3UTYAjJ45XlkRwSYBr4atxYSXq7taZyCHb4lo8J61NefiQiLLkn0
 QFzyO3cV0i0DEoMFc/DbJP/1I8ev0kOhcjgnMI8ZZw8QaeQourCee28zFfclo5ccPL
 dhi2YHgxorGlqHOkcAP7NuEUENrABNCe5NQrIUbNLNyDFgDI5qPIZ/ziamujYdUn7y
 pHOCXiA9WvkDg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 09/14] hw/scsi/ncr53c710: Drain asynchronous transfers in the
 register write
Date: Mon, 23 Nov 2026 18:21:46 +0100
Message-ID: <20261123172151.7605-10-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123172151.7605-1-deller@kernel.org>
References: <20261123172151.7605-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

The c720 driver of HP-UX 10.20 needs the completion interrupt ordering
hardware provides, starting a command with interrupts masked and then
spinning.  So after a register write starts an asynchronous transfer
the model drives it to completion before returning to the guest (a
bounded synchronous drain under the BQL, as IDE and MegaSAS do, falling
back to asynchronous completion if it cannot advance).

Signed-off-by: Keith Monahan <keith@techtravels.org>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c  | 29 +++++++++++++++++++++++++++++
 hw/scsi/trace-events |  1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 5522dedee8..7558d5b4b0 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -54,6 +54,12 @@
 
 #define LSI_BUF_SIZE     4096
 
+/*
+ * Safety bound on the synchronous completion drain loop in ncr710_reg_write();
+ * it then falls back to asynchronous completion.
+ */
+#define LSI_DRAIN_MAX_ITERS  100000
+
 static const char *const lsi_reg_names[64] = {
     "SCNTL0", "SCNTL1", "SDID", "SIEN", "SCID", "SXFER", "SODL", "SOCL",
     "SFBR", "SIDL", "SBDL", "SBCL", "DSTAT", "SSTAT0", "SSTAT1", "SSTAT2",
@@ -1553,7 +1559,30 @@ uint64_t ncr710_reg_read(NCR710State *s, hwaddr addr, unsigned size)
 
 void ncr710_reg_write(NCR710State *s, hwaddr addr, uint64_t val, unsigned size)
 {
+    unsigned drained = 0;
+
     lsi_reg_writeb(s, addr & 0xff, val & 0xff);
+
+    /*
+     * Drive any asynchronous SCSI transfer the register write kicked off to
+     * completion before returning to the guest, so its completion interrupt is
+     * raised first.  A deferred continue (lsi_issue_bh) has not issued its
+     * backing I/O yet, so pump it inline; otherwise blk_drain the backend.
+     */
+    while (s->waiting == LSI_DMA_IN_PROGRESS && s->current != NULL &&
+           s->current->req != NULL) {
+        if (drained++ >= LSI_DRAIN_MAX_ITERS) {
+            trace_ncr710_drain_exhausted(drained);
+            break;
+        }
+        if (s->issue_pending) {
+            lsi_issue_bh(s);
+        } else if (s->current->req->dev->conf.blk != NULL) {
+            blk_drain(s->current->req->dev->conf.blk);
+        } else {
+            break;      /* nothing deferred and no backend to drain */
+        }
+    }
 }
 
 static int lsi_pre_save(void *opaque)
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index f0eb145702..843d8f1a1e 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -340,6 +340,7 @@ ncr710_memmove(uint32_t dest, uint32_t src, int count) "MOVE MEMORY dest=0x%08x
 ncr710_do_dma_unavailable(void) "DMA: data not yet available"
 ncr710_wait_disconnect(void) "Wait Disconnect"
 ncr710_illegal_insn(uint32_t insn) "ILLEGAL instruction 0x%08x"
+ncr710_drain_exhausted(unsigned iters) "synchronous completion drain gave up after %u iters"
 
 # lasi_ncr710.c
 lasi_ncr710_device_realize(void) "Device realized"
-- 
2.54.0


