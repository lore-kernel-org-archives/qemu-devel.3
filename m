Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797E4CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0swU-0004Gt-7U; Mon, 22 Sep 2025 22:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swO-0004Et-8D
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:40 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0swF-0003gj-Op
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:39:39 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f429ea4d5so1343007b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 19:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758595165; x=1759199965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXxBMnFQ/RPp+Yw4YVGAm6rlpqH3fZoa0yhbkR1+s/I=;
 b=oU4btQjNGfZ89YNHK6hhfU/LhpuQ4bFyTmjoxHJ1Kql+GZvc7MMoozseEw3DbIsWuC
 lvEsKK3F2GnsKQ08Do8Geb7Pbwu+7SqPsFbP4ZBNylGyv14CAkCTvuOOVdjHrR+v/LNz
 LesPptbeTlmPoBXM1EOVe6QY0sFomVwIx8Jv/VHvxzYuwxIpwM/SG3grZxhxb3xJlQ78
 u/3D626ogCuhMZakeosL5ssjaFmcOdkbme0fwhCmVoPDB5Todqb7vrETcWW+1GCnD6DF
 B8ltUlvosJWI+gZpWqzRO1y0qgAKy3/Wczu4+O4Gc1xcHsFlTWk1b0aCU23o8mKq5zCc
 /Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758595165; x=1759199965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXxBMnFQ/RPp+Yw4YVGAm6rlpqH3fZoa0yhbkR1+s/I=;
 b=SWtB+Wb6wksMR6xEFuIU+NwsYI/NM4y4uZ1S9BbpCUSa92ew4KlUC2mcgItOhAJ/4q
 e2RbkqLODCvisnfKDzyz5cHOQBBzbhXisoMsI8T7ge1G5wxKnNk3xD3MvhjZCrRCb2sc
 QQc2LbP6V7VoPcZQZI7kh8S5tmVTlobm04cOl4KdGrun4vHt44+nkBauI+FZYsCZac7Z
 pXl8tjRpGrr6hfV6CDGwreQLoIsuANLhrLHKwhkTfjSeLepwG7ZK+V/WXz8aaYKHYeeN
 I22m0PsZcmT0vapac1qYm7p5kMxapEMNkI+4Kg691PLLqBhEjHVdeC8hxjAaW9li8DZ/
 ml5Q==
X-Gm-Message-State: AOJu0Yx/tvtpsjyAWtbz0ycImBmDnZHH07iBCthT8TH2zqJsU58dd3g3
 Byplkks1xyxz4ucZbQ/L/5+yHswhBXNY+cf0qYO8OtLb75GpKjqT0AJ/gZAl03psRDlCmMhXJle
 7pxol
X-Gm-Gg: ASbGncvp4v8WERhd9kp26EQVNl92cUIap4PecZ8XyBSPNyQpEoWbq9ttj2McMjPx+GE
 q9AIK87o2AIbsaPw1HGAzqqestFYQt2h6aDhiCDMhpRHJ+tVfdKn8FniBS9DMIIOA1tc8RZpJuK
 cTxo+P+SwJ31MWtwosdLUpM6OgE62Jo1aifv+kBesT8matRdIBHTWSXMy/IxW9TS6A8kGf+cjME
 Ozz/oTMQQEdwrQBmeVNlNWck8RDd0xW/sZazkKoobPb28v5OZjFl+UIqD31E6uTPWst0D5jQyjm
 wmTBpwaf2yqNkLsUJP03okgrPs7HavOFW2eutHYTxABy3X5qxCc/H3RydvTy43ItlFk4bIT2gfr
 0BsPe4USrm8jp/1L0l1AfPQPnW8g6
X-Google-Smtp-Source: AGHT+IHHTlEXTDQ1RW6t++87xO4Ngrtj3p/9/GbmB0jrn4DQB7ty75wneSEfjD7S8EbAILSyM3637w==
X-Received: by 2002:a05:6a20:72a6:b0:263:b547:d0c3 with SMTP id
 adf61e73a8af0-2cff4d9234bmr1602620637.36.1758595164745; 
 Mon, 22 Sep 2025 19:39:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f0da43089sm9899622b3a.90.2025.09.22.19.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 19:39:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 01/12] gdbstub: Remove tb_flush uses
Date: Mon, 22 Sep 2025 19:39:05 -0700
Message-ID: <20250923023922.3102471-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923023922.3102471-1-richard.henderson@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This hasn't been needed since d828b92b8a6
("accel/tcg: Introduce CF_BP_PAGE").

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/system.c | 4 ----
 gdbstub/user.c   | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/gdbstub/system.c b/gdbstub/system.c
index 5be0d3c58c..df3514dc74 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -18,7 +18,6 @@
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
-#include "exec/tb-flush.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
@@ -174,9 +173,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
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


