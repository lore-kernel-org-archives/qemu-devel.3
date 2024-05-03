Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E50BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p2s-0001kF-1h; Fri, 03 May 2024 05:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2q-0001jY-Ev
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2o-0003b7-T7
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so83312705e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714727849; x=1715332649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Tb/CgMjRwAYjJGSlcjkSqdpYLQYMSWtat67VigpwVw=;
 b=j7v/ejyavBhkW8SAeiXpAheO/6Dyk0yG5Y3UlNyFcg2KZDTpt9ebzh9jwjUwHRNau6
 XKMjBgivtcdGUmMe0qFncQdrT5r/auey7o9udv3lZ9NGSRDAB7OCFe5x1ODbs4la57J2
 WM8SYcWzjVRmFIHXjY5GX73Mma566Z4N8lME/uqzgYK+/9nXmmIQ5f8J3BKBdzH5cDw6
 mVYhqV2aeedBCzCF5CguO681Pwlw4gKG4bPuGv+Hu2ynU+zNvuvcvac8PMkmVHe+NPq6
 AHq1Qx51Y6lbE99pDdurvjY44oEUg2PL3QBoIQElOn2tGqOwkBOrqo7+08m3NbiC0d0/
 x9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727849; x=1715332649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Tb/CgMjRwAYjJGSlcjkSqdpYLQYMSWtat67VigpwVw=;
 b=pOuZuLoT7yfXzOp2wml2f2gDR3CJz5iuAzrJrQ5dfMI5DrvlBovgtAO1ooQJjMS0Io
 IP6NRq6EqabGhPhrCF7Vfl+HUzAjVZUNh3Hxt5Flj/6ZMdERcRCiVAA0M5eo0At8YWQQ
 WktF74YIuuE2VG3swiDr8WioIBx+OcVnre5WnUDA+ZJRu6FTKP1M00RNpyhL6V6yrRse
 tav7EUL7n4PlElG09kWJCFY1xIlIQ6PHNcD7nc/7gguXWBQ+gZ61BtTV9dfEeaQmHHLe
 EfMEeA7e8duMHdqn0FBY6Tomc0StOiGBvb4YO+iweKUbcsyUAgQ33O3r2/TNhfFgNzEa
 QiqQ==
X-Gm-Message-State: AOJu0YzzcJM47r+YdvhDrlLb0tLp6BK0pa+bnjQapMgUhPfzU2Nj4c8A
 yvnw3t1YgID5LjWygCAVSSYIHgrTyB5SsEmefZb9oBaYMVLRuKVyA8DE6p3uMR5C9jVO3i7H/tW
 4
X-Google-Smtp-Source: AGHT+IGmgTY76Kc4tJh9yCqXlOC9f7UFUY+gpFipcKMrAlZNqXIq2YolDGiE/o7hU15BQmF7hRCvjA==
X-Received: by 2002:a05:600c:3507:b0:41b:eaf2:f7e6 with SMTP id
 h7-20020a05600c350700b0041beaf2f7e6mr2189421wmq.2.1714727849170; 
 Fri, 03 May 2024 02:17:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 v28-20020a5d591c000000b0034db47c7e6dsm3259435wrd.115.2024.05.03.02.17.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 02:17:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 5/5] accel/tcg: Always call tcg_flush_jmp_cache() on reset
Date: Fri,  3 May 2024 11:16:57 +0200
Message-ID: <20240503091657.26468-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503091657.26468-1-philmd@linaro.org>
References: <20240503091657.26468-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In commit bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
we unfortunately restricted the tcg_flush_jmp_cache() to system
emulation. Move it to the common tcg_exec_cpu_reset_hold() handler
so user emulation gets the jmp_cache initialized when threads
are created.

Remove the NULL check in tcg_flush_jmp_cache() from commit 4e4fa6c12d
("accel/tcg: Complete cpu initialization before registration") which
was a band-aid fix for incorrect commit bb6cf6f016.

Cc: qemu-stable@nongnu.org
Fixes: bb6cf6f016 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c             | 2 ++
 accel/tcg/sysemu/tcg-accel-ops.c | 2 --
 accel/tcg/translate-all.c        | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1bf85c324d..7e04df2902 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -36,6 +36,7 @@
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
 #include "exec/helper-proto-common.h"
+#include "exec/tb-flush.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
@@ -1099,4 +1100,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 
 void tcg_exec_cpu_reset_hold(CPUState *cpu)
 {
+    tcg_flush_jmp_cache(cpu);
 }
diff --git a/accel/tcg/sysemu/tcg-accel-ops.c b/accel/tcg/sysemu/tcg-accel-ops.c
index 82c8368f87..13e450c088 100644
--- a/accel/tcg/sysemu/tcg-accel-ops.c
+++ b/accel/tcg/sysemu/tcg-accel-ops.c
@@ -34,7 +34,6 @@
 #include "qemu/timer.h"
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 #include "../internal-common.h"
 #include "hw/core/cpu.h"
@@ -83,7 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
 static void tcg_cpu_reset_hold(CPUState *cpu)
 {
     tcg_exec_cpu_reset_hold(cpu);
-    tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
 }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 83cc14fbde..93202fa3c1 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -663,11 +663,6 @@ void tcg_flush_jmp_cache(CPUState *cpu)
 {
     CPUJumpCache *jc = cpu->tb_jmp_cache;
 
-    /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(jc == NULL)) {
-        return;
-    }
-
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0


