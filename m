Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60810C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEeb-0000ui-Bq; Sun, 05 Jul 2026 00:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEcS-0005EY-N9
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:17 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEc7-0004Mt-0t
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:38:16 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso1289149a12.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226273; x=1783831073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cP494Rw8f0vgO7hsG8GqjbbSorQrWAAshXUTXMQVwCM=;
 b=RoAQjyoiTAQIyAY1GI2sbDqJW8IGrYPJQ/k6+xwMdgSCOo3hOVR/Y56bim/adckbcj
 2FexexQgfACaHOk9AbL6y+KbXRNTZ6rXI2uKbdTphM7xq2xHMoNWS8bOICpIegumicE4
 IV1w1UzquFxyfcfVT5MII/drmPYBS0VGwdbAW9Uqlg0rxi6y3rr5BrcO9srT4/BAR9SU
 vr260SRnyV10QUvd6t3pv4RFlK4NREa4OHDJYVfj/Um15PF8g8Ri+a1PO1eGuBLKtWZ7
 +L0an8K/NrTKXviq3L7IsAYQrRCAKrprcuRPN9IwXt8E1s3XQb+O8cT+25dckDqSY/hz
 kJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226273; x=1783831073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cP494Rw8f0vgO7hsG8GqjbbSorQrWAAshXUTXMQVwCM=;
 b=qgmpYfiabFZAKmerRwdR/Vvd8ntFKGj+Pt5vif4TZXc2DKw5DxMMPx3dj2poElE6pf
 vH2BVx0auJpcMn4amCANUczPSlTkc98SrBwPasMBwsj/RhIo/EYj2fcPr/hwFgBf+0Yi
 qdjlPKFM6nm21gIzXclI8LPsQBcXJU+d0cq5QA/lRFgwhzZrb2ABQWeK1fwxGIpxFFXL
 TWEeuYa/9+7DL+MEC6gVUONyLhX2D3bkDXKHBGbqBxMmudX8jwoZwq4KL5XmF4ABD2oy
 3odBXtfaL4+E+dr3xRW+eCatWG3i03ITCra1e959+aM6bKbgSkfeqnVBB56IwGUGYj+t
 9smQ==
X-Gm-Message-State: AOJu0YxDlYhB/MbRPgM0f/JaeRIFE4h9eufYakhwNJDx4nlioSNxue9T
 sz44HsiiWJGUL47h359OjSYW3ok84rBBysYKFnzzRhwvghpdRmP5aflo/akE2+0DAm3dAeA6v6V
 pvLrj
X-Gm-Gg: AfdE7clLue53RLk9VdxkRfn0avR+uWv72KYN/tDCBqfYVjspIPw8tN/GwfmMZwa6TJB
 BBm9h/fmtKKVBSei40ZbEUwzujLCHFd6MvVvodsyKPrTurwnuCLqt/cVZu11Ylgibkb8UgozcVC
 B1HvSyupgjsd+92Bips37HFeAdtr/GlIBYf6QPb4H8pQRd/O3do6f5SDzaAvUPjYuN6Bjr+d305
 ET8P0uAy87rSpZj92SSXoWiWL+rd9q+tCjNacQ+isQQWeArRx0zGSlcIalcqTM+LeuEmSqAkdUb
 I2p5Pmd92UU7g14qgkpIFWDsUb8q8x4rZQp7grfmhTWPe7WEI3rM7QMXDex74DK496xXgCzCsus
 7EIsB4VLbOf0VjQF69ISP3zIY5cJvfNbZMi7S+kfDGjfiTlWvZnESdtMuViJy/P0UcENCbIoCL+
 ufjwuOJ5sIjC6ZuWgmt5kNrCcjTa+3c5bQovEcjYeAS765XRI=
X-Received: by 2002:a17:902:e786:b0:2c9:ff83:41fa with SMTP id
 d9443c01a7336-2cbb9ebb50dmr50629105ad.24.1783226273331; 
 Sat, 04 Jul 2026 21:37:53 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cad712ca17sm29863785ad.28.2026.07.04.21.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:37:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 31/46] accel/tcg: Pass breakpoint hit to debug_excp_handler
Date: Sat,  4 Jul 2026 21:37:10 -0700
Message-ID: <20260705043725.1373137-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Record the CPUBreakpoint in check_for_breakpoints_slow,
into a new CPUState field, so that the as-yet unconverted
target debug_excp_handler functions won't see it.

Only call debug_excp_handler for BP_CPU, and clear the
CPUState fields after the call.  This will allow these
actions to be dropped from the target hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h |  1 +
 accel/tcg/cpu-exec.c  | 32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 8d24aaff44..dc1c634258 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -526,6 +526,7 @@ struct CPUState {
     /* ice debug support */
     IntervalTreeRoot breakpoints;
     IntervalTreeRoot watchpoints;
+    CPUBreakpoint *breakpoint_hit;
     CPUBreakpoint *watchpoint_hit;
 
     void *opaque;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index cca403ad62..bda6dd9e46 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -363,6 +363,10 @@ static bool check_for_breakpoints_slow(CPUState *cpu, vaddr pc,
     return false;
 
  found:
+    bp->hitaddr = pc;
+    bp->hitlast = pc;
+    bp->hitattrs = MEMTXATTRS_UNSPECIFIED;
+    cpu->breakpoint_hit = bp;
     cpu->exception_index = EXCP_DEBUG;
     return true;
 }
@@ -681,19 +685,29 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
-    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    IntervalTreeNode *n;
+    CPUBreakpoint *hit = cpu->watchpoint_hit;
 
-    for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
-         n = interval_tree_iter_next(n, 0, -1)) {
-        CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
-        if (wp != cpu->watchpoint_hit) {
-            wp->flags &= ~BP_WATCHPOINT_HIT;
+    if (hit) {
+        IntervalTreeNode *n;
+
+        for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
+             n = interval_tree_iter_next(n, 0, -1)) {
+            CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
+            if (wp != hit) {
+                wp->flags &= ~BP_WATCHPOINT_HIT;
+            }
+        }
+    } else {
+        hit = cpu->breakpoint_hit;
+        if (!hit) {
+            return;
         }
     }
 
-    if (tcg_ops->debug_excp_handler) {
-        tcg_ops->debug_excp_handler(cpu, cpu->watchpoint_hit);
+    if (hit->flags & BP_CPU) {
+        cpu->cc->tcg_ops->debug_excp_handler(cpu, hit);
+        cpu->watchpoint_hit = NULL;
+        cpu->breakpoint_hit = NULL;
     }
 }
 
-- 
2.43.0


