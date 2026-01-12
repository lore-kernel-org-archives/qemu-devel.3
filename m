Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB59CF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQpC-0006wa-E7; Mon, 12 Jan 2026 17:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQp3-0006UQ-1s
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQp1-0004Jr-93
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:55:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso63301405e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258537; x=1768863337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e0VpS/erUaB8uXlATMToZM9LtCgo93xRrVfjCp8AQZk=;
 b=E1O/r6EXXmMzlR9LtXBHEqMVD9OeDh6EVBTWB+2n5GxjGGDBtkeTZM8z/kedSCrBzM
 ce61JETzcOmYukfbhOqAR9v0fkOvE3PxC5Xg/kwgsKJyuQXmF0LtHKX6ipLjiPxJIEgX
 plJDUStGyz8MffMAFioR0K/WumsplqQEo+Tb1z7FbXA+EvHaLK66ie+kYr6BFXwOoUNn
 6GPycasN+A0rFih2/lomSeYWCYkSIvWtNWwj0EnjTSzSfqU1XvXd8dyDcJxxztPa4f5Z
 ChZY3PBr1Xi1DB+iMhC/nnOsZ42ig3Ig8ehm77l4HlSnddIuoeBeTA1fY1BQXzDnG5le
 bfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258537; x=1768863337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e0VpS/erUaB8uXlATMToZM9LtCgo93xRrVfjCp8AQZk=;
 b=PvczWobhPp0QUnDExVv3qNOsrwsZoBXZmOaxjIdD3y0k5kuPFdN3ikh1jsMfCuN71E
 TOKUHIce3R9aA+PoCugyFHGMXMli53pD12SPlIwdzuPBQ6l9eL7DPGtBarRAwc8Bnv0x
 xJsFgO6kljLXJzLRaFbVQszynj9sG9RLXk49IkgGRXDExxYAUn//ysziXQS2TEAtnSpg
 D+E4kCzGAk6Z4TUPY9Ls1bDT2byGTUEPVsckqqhgX9WnKi14+jPVzR87gH/iIQs8ssJZ
 2NgQDa6O0G9r1ovcnC+ZWZiJEC7+K/MbBWNjI9DI8fTk26WXZ2wLpHT8u/ME7zAcnCQd
 ne+A==
X-Gm-Message-State: AOJu0YwBgwNuwcQ8XXmx4ZrSjhe04IHM97vxZB6VXyaZzWHPUqwTOYmo
 k1ZSAmAJd908LXN/l4BW14fgiZVYshfLFBL7e/c2TzkYWrGq9fzFKNHCMGvC/f65Tb2cronIuqZ
 g0hJh4XQ=
X-Gm-Gg: AY/fxX4tYpP3pnASIYHvsiR18o400Dfo5NqBeGli3xNY6B7YZD2K2vnbe2eDKMAFzzQ
 80/gsy82na6GcruAiStIe3K/FPL7hLpmajDYpgAeKK5dXHpR5Kq/kmA8i3YDW3umcAZ106yIfj/
 nlynO4mcq95DomjpJMzOtQ/DgCNhpz+qkhqVle3pLqtYHBsoTW8PXjgeRIq/yt9+An/xyGufXVQ
 qW7AuLm0r7EpJrlmzNveCoaQqR9FPbfjKheXspRivD6vh0eSh1Ual0he4/6XLfIDJdoDIWzPPCN
 /bMnzb2DJK/x41qz6/ybCxe+j+vWf7I+y3cpIy2F43KuyKe+nOmuLEVrh6x5iKsdPzo4SqWG0yp
 R0khGtZclT+pwpttuBWZGWyKjmS5GcRMldrILPkcSGtK04WTzaCjR4eHedDcdvfshxrp366w2CK
 1E+yf5IuElj/5pHQAbhqgvrjzlruAMG0eI+mQgahMdS8pC7yzhBQZ9PQDKqWHO
X-Google-Smtp-Source: AGHT+IHC1YK1PxXt7VvcP9j6+DndVWDh/H0pnL7zWdiZnl+7ewt3+aGS1ZzzUpdJT7pY4RRFtMZ7Fg==
X-Received: by 2002:a05:600c:46c4:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-47d84b18ef7mr256320355e9.10.1768258537251; 
 Mon, 12 Jan 2026 14:55:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ed9e76470sm1806885e9.2.2026.01.12.14.55.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:55:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/61] accel/tcg: Un-inline WatchPoint API user-emulation stubs
Date: Mon, 12 Jan 2026 23:48:53 +0100
Message-ID: <20260112224857.42068-59-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Currently we can not build files including "exec/watchpoint.h"
as meson common objects because the CONFIG_USER_ONLY definition
is poisoned. We can easily fix that by un-inlining the
user-emulation stubs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106231908.16756-5-philmd@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 17 -----------------
 include/exec/watchpoint.h   | 23 -----------------------
 accel/tcg/user-exec-stub.c  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index dd8ea300168..5950cdcaab1 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -281,21 +281,6 @@ struct TCGCPUOps {
 #endif /* !CONFIG_USER_ONLY */
 };
 
-#if defined(CONFIG_USER_ONLY)
-
-static inline void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
-                                        MemTxAttrs atr, int fl, uintptr_t ra)
-{
-}
-
-static inline int cpu_watchpoint_address_matches(CPUState *cpu,
-                                                 vaddr addr, vaddr len)
-{
-    return 0;
-}
-
-#else
-
 /**
  * cpu_check_watchpoint:
  * @cpu: cpu context
@@ -328,6 +313,4 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len);
 vaddr cpu_pointer_wrap_notreached(CPUState *, int, vaddr, vaddr);
 vaddr cpu_pointer_wrap_uint32(CPUState *, int, vaddr, vaddr);
 
-#endif
-
 #endif /* TCG_CPU_OPS_H */
diff --git a/include/exec/watchpoint.h b/include/exec/watchpoint.h
index 4b6668826c7..c4d069425ba 100644
--- a/include/exec/watchpoint.h
+++ b/include/exec/watchpoint.h
@@ -8,34 +8,11 @@
 #ifndef EXEC_WATCHPOINT_H
 #define EXEC_WATCHPOINT_H
 
-#if defined(CONFIG_USER_ONLY)
-static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
-                                        int flags, CPUWatchpoint **watchpoint)
-{
-    return -ENOSYS;
-}
-
-static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
-                                        vaddr len, int flags)
-{
-    return -ENOSYS;
-}
-
-static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
-                                                CPUWatchpoint *wp)
-{
-}
-
-static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
-{
-}
-#else
 int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
                           int flags, CPUWatchpoint **watchpoint);
 int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
                           vaddr len, int flags);
 void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
 void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
-#endif
 
 #endif /* EXEC_WATCHPOINT_H */
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 1d52f48226a..28286e11a60 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -1,6 +1,8 @@
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
+#include "accel/tcg/cpu-ops.h"
 #include "exec/replay-core.h"
+#include "exec/watchpoint.h"
 #include "internal-common.h"
 
 void cpu_resume(CPUState *cpu)
@@ -19,6 +21,37 @@ void cpu_exec_reset_hold(CPUState *cpu)
 {
 }
 
+int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
+                          int flags, CPUWatchpoint **watchpoint)
+{
+    return -ENOSYS;
+}
+
+int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
+                          vaddr len, int flags)
+{
+    return -ENOSYS;
+}
+
+void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
+{
+}
+
+void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
+{
+}
+
+int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
+{
+    return 0;
+}
+
+void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
+                          MemTxAttrs atr, int fl, uintptr_t ra)
+{
+}
+
+
 /* User mode emulation does not support softmmu yet.  */
 
 void tlb_init(CPUState *cpu)
-- 
2.52.0


