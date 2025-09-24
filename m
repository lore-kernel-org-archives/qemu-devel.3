Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D87CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Unw-0008J8-6M; Wed, 24 Sep 2025 15:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Um5-0006zJ-Ax
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:39 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk5-0007tv-3P
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:31 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32ed19ce5a3so153756a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740483; x=1759345283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkajwB0LkhYnqCNRGrXzrsBCk6tFlVZCMEBA7S1wExk=;
 b=nuksV6gUF5UJWZALSavgAY9kMIgNCjJkz0azfPVhFIaI6o11dgTA5ozkYevXDjOSv3
 H9Y6kRFIE+A/lhXYEarN0UBs+Lb69pxnemFcLXguJaJy1Q4mxgyjAQ1RGjKL9GRyaupi
 +XuXMYDVJHHFwk5eLnBb68Kgp4zOglMRBahhID8d3iIk70zuk17X8dGMuieNGDx8rRlA
 8vdJqwlVWdm86qilGZ4kXpiJDNi/os1KJEJv6Zk114utMiV6VguC6XAv4xYmA291S8xi
 b7whE0BdpywvMeiF+f3PFC6njFonhqipZSGzNO5Bx5Z1/DzXHhZqnoh6AkA/CC/cVjBl
 BkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740483; x=1759345283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tkajwB0LkhYnqCNRGrXzrsBCk6tFlVZCMEBA7S1wExk=;
 b=mhzinlesDZKub//MYnY4XchuyOUlzvZOvVFX0rjx5P7cvIpBMaZWzS3sGnBnGSfV7A
 0ZQI7NIk7ADz7jPiMkTFXYccKBXVEbPjT8xNEqfZD+3kdIsO9vS+RsalHOFC5P2fLbCM
 exguUp1VBxcUtI1KBso78c+fYw7AeoI+E6xB/HsXh/a3kIVBbwCMJexk+21ieAI4rn90
 fDnAbAIOa8mRvSZfbGk+VGaeje/V/Tu9xqccrrGVoeJU7NFr14W78EfAznqn0TTOwYVq
 S1TFj0QK1YFd372FZbFM3tivPsAGyjzeGCy2x5DJHl78m21LuRpnFXWsL13EjFfIx1tV
 l4ow==
X-Gm-Message-State: AOJu0YwBQRRRSK2GyfILikHp3/5xEtSGLiLh1WS1Ycnj65jyRxFdVQ2M
 LkTmsFoQjzZrvIVUpTEUfN64tLmYlwHNTap+lzE+OOgGA1JmmSLiq61u6jS8Nm99LW4a64SQ2+M
 dPYjw
X-Gm-Gg: ASbGncv2OJeAfIDPKQrRVsbR/1BvF5fiwysfIf6vh2OIoBwMLtmMtYLrTJO9/20Dh3b
 EbIE85NFOwRqipMf092iLHvBBohX9AAGOp78QxO8zSpsEq0BTX6aefK26WtQmctRkxyb1WxSPvz
 OJWVSAOjT3po6aG6HLhovpghwkILgCs3G/Ni9zImcp+1rbudu/SPlPHl+Yy+Yiev+zsL8EO9EXS
 XntXdvXte6YSYHu9iPKdqVA0d2o+ASvxNrOKP1KFue3wzDgbzJPgi5q5/iUcWX7/CUEOMZrk8dX
 CQ+UZLEf0WFG0umAWL6oY5T5wufhrqZ2eeOOcOELt9kTLBnEzGG9P3dfq3Lc2yjwh1iKmC7fEdB
 obLaoPqfudhEyNhdb5g5hAGZp4Zyn
X-Google-Smtp-Source: AGHT+IETfMFzeQdyrBH5ZIcbhuyKYUE22ENd0nkA2ZNP3+PnTgCDd78rYOjrki1/0iALISoyIeAPsA==
X-Received: by 2002:a17:90b:3a81:b0:32b:d79e:58a6 with SMTP id
 98e67ed59e1d1-3342a2cadc3mr632748a91.25.1758740483184; 
 Wed, 24 Sep 2025 12:01:23 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 21/32] gdbstub: Remove tb_flush uses
Date: Wed, 24 Sep 2025 12:00:54 -0700
Message-ID: <20250924190106.7089-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

This hasn't been needed since d828b92b8a6
("accel/tcg: Introduce CF_BP_PAGE").

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/system.c | 5 -----
 gdbstub/user.c   | 3 ---
 2 files changed, 8 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 5be0d3c58c..5221c579d9 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -18,13 +18,11 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
-#include "system/tcg.h"
 #include "hw/core/cpu.h"
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
@@ -174,9 +172,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
         } else {
             trace_gdbstub_hit_break();
         }
-        if (tcg_enabled()) {
-            tb_flush(cpu);
-        }
         ret = GDB_SIGNAL_TRAP;
         break;
     case RUN_STATE_PAUSED:
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 67403e5a25..2e14ded3f0 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -15,7 +15,6 @@
 #include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/commands.h"
 #include "gdbstub/syscalls.h"
@@ -220,7 +219,6 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
 
     /* disable single step if it was enabled */
     cpu_single_step(cpu, 0);
-    tb_flush(cpu);
 
     if (sig != 0) {
         gdb_set_stop_cpu(cpu);
@@ -539,7 +537,6 @@ static void disable_gdbstub(CPUState *thread_cpu)
         /* no cpu_watchpoint_remove_all for user-mode */
         cpu_single_step(cpu, 0);
     }
-    tb_flush(thread_cpu);
 }
 
 void gdbserver_fork_end(CPUState *cpu, pid_t pid)
-- 
2.43.0


