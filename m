Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4551C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 04:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgEfM-00042A-HU; Sun, 05 Jul 2026 00:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfI-0003sH-Gn
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wgEfE-0006Ox-Iy
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 00:41:12 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-84592b55832so1646694b3a.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2026 21:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783226467; x=1783831267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSQn5AB1CNws1Obey85q6NalNpdc96132v00m/ICH9U=;
 b=LZor4ZPS8oGX0xHyGykbQeDESnVnORXI9Ytf1MuLIVYeV8/1wxwCZJqT1jIvv56rxJ
 LUxaT/fagmRbgmhsClji0TqmkROEH18zwCXC3KmhFlKkOMdpLblAJzJ8tbj7voy4PBqe
 RcbgLB2HSD1/RfrKSFXNRurSe/U0RYxLNGBvjTKif5Y7RRmEs5wgdUc3ASAyzKAUWI4O
 R/Wx66Eco8b7cXc4lLEeDr7uytr0ETpFz5zpiKFTJOtCBNNRd2QMG+9WmupkKtI520Z4
 HZbA7dZyDb1oMhKCCQh19JIT/4PHTQqbqp7Gon/E1OCctmJngcA3qvGuZ8doD2wFuhth
 NsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783226467; x=1783831267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NSQn5AB1CNws1Obey85q6NalNpdc96132v00m/ICH9U=;
 b=Ualp5b8Phmp5EYokg9jwcmTqlnYuvBzV5cb5gi7yE5am1qbbsH396d2ySeM9as+V+G
 K7ip0CRD4JKddONm4aLo7Wfi8Nt1p/SWsVkWJ4Q7hLZXMQgCRTLiIsBxrME5ttV3+aGT
 olEjyOkUZrX/XuDqBzeeoXVbFV48jUeH9xLiOgwJNHQmnd2JgC0u033CVVSd1Lv6FMbE
 yRvuuylFSXhrNMmm/1/VTPnGa2vqCHwjFzHDeONfOWFksEOVMCONr1EKzc96z4ShTaXk
 3BmW1lDZ/XYZWRPdvwSNx3t7CP5xovFxSR2pyUgZvIyamJkip5SZobZi5MTMZKXLRwrO
 DEdw==
X-Gm-Message-State: AOJu0YzERvsxbo7oBRtyamK4leKsPBEO3OwfQ4oHIjuyrQWBfekqjSQH
 e4bZYiz2uOdLEN7/rW+nbPeYA/xBqVodsUWZEVjEHf0Qpz4ZxB/+hGkxNfueZNG+wv1RQMsfFYI
 QeE9g
X-Gm-Gg: AfdE7cmawSIPuOkAuTVzKugt3dIbyMhujOGzdrP5lsq8ui7NclvCraKLgbJjqo7JoxH
 UpKboOOhk+reZo1nNICkdDkGxi5/TM7pPjpNVOE/7DBMfVp5+xoyPUvFdJ5fM3cbNoahVzxHCWb
 VHkdnMol7v7Q4Anu+r5DK4JK/MTMa28558J2nbtOqY0U1nu7a/T0c3VZEVqh1sx7uYgbKqaZkB5
 VXk4oTgHG3Ioh7xHuOE4uMKbh4GofUIt5CO88ZNg2FBl/DYgdob9xMoLLkajzZZyTH40OE7e2D7
 5AR9scCLb6lqt2/98VEP/FCGaT6nvU6htTd+3IvEYtLLoET6I7lYII/mdHWPIybp7dwtqJvIqE2
 mdqhPkk0DvuMp+XkbMlhdFZc+XT+5qTS5xSRXMrgYRH4Vjr8vdRJsXxWfHVVglatMF5Dp6nnNsw
 hI2uIliho51STwEKnBnE1gPZ3J+8GeXaQmWhvukLSpfpFKKnPKcnriEGaYyQ==
X-Received: by 2002:a05:6a00:10c5:b0:845:d274:bf94 with SMTP id
 d2e1a72fcca58-847f7010c5cmr4745455b3a.61.1783226467018; 
 Sat, 04 Jul 2026 21:41:07 -0700 (PDT)
Received: from stoup.. (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6952a0dsm1952615b3a.0.2026.07.04.21.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 21:41:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, philmd@oss.qualcomm.com
Subject: [PATCH v2 45/46] accel/tcg: Clear BP_WATCHPOINT_HIT after use
Date: Sat,  4 Jul 2026 21:37:24 -0700
Message-ID: <20260705043725.1373137-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705043725.1373137-1-richard.henderson@linaro.org>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Now that all targets have been converted to use the
debug_excp_handler, and no longer clear watchpoint_hit
themselves, we can clear BP_WATCHPOINT_HIT after the
single usage.  This avoids a loop over all watchpoints.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 23 ++++-------------------
 gdbstub/system.c     |  2 ++
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index bda6dd9e46..c1e4cdbc19 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -685,27 +685,12 @@ static inline bool cpu_handle_halt(CPUState *cpu)
 
 static inline void cpu_handle_debug_exception(CPUState *cpu)
 {
-    CPUBreakpoint *hit = cpu->watchpoint_hit;
+    CPUBreakpoint *hit = cpu->watchpoint_hit ? : cpu->breakpoint_hit;
 
-    if (hit) {
-        IntervalTreeNode *n;
-
-        for (n = interval_tree_iter_first(&cpu->watchpoints, 0, -1); n;
-             n = interval_tree_iter_next(n, 0, -1)) {
-            CPUBreakpoint *wp = container_of(n, CPUBreakpoint, itree);
-            if (wp != hit) {
-                wp->flags &= ~BP_WATCHPOINT_HIT;
-            }
-        }
-    } else {
-        hit = cpu->breakpoint_hit;
-        if (!hit) {
-            return;
-        }
-    }
-
-    if (hit->flags & BP_CPU) {
+    if (hit && hit->flags & BP_CPU) {
         cpu->cc->tcg_ops->debug_excp_handler(cpu, hit);
+
+        hit->flags &= ~BP_WATCHPOINT_HIT;
         cpu->watchpoint_hit = NULL;
         cpu->breakpoint_hit = NULL;
     }
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 017585187f..cbb72be33b 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -169,6 +169,8 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
             g_string_printf(buf, "T%02xthread:%s;%swatch:%" VADDR_PRIx ";",
                             GDB_SIGNAL_TRAP, tid->str, type,
                             cpu->watchpoint_hit->hitaddr);
+
+            cpu->watchpoint_hit->flags &= ~BP_WATCHPOINT_HIT;
             cpu->watchpoint_hit = NULL;
             goto send_packet;
         } else {
-- 
2.43.0


