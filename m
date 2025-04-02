Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92335C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Yh-0007Z2-OZ; Wed, 02 Apr 2025 17:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yd-0007X1-Vk
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Yc-00045y-3j
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:23:35 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43948021a45so1769725e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629011; x=1744233811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kv473foA2Lz/6LlrfWieB+cyNxqB+oMm/dNGpDxxZmg=;
 b=cDkx/KdgT+STlItAO89LCwm1JdcAgUWdqlip2pLdQ4b/3gN5MHZHZPstRZmPBJiQRQ
 LR+26TdPSM23mdEyoT1YU77CnJ0eqfoYV0Tuj6sMURGcC6Qut0KdHgfTEdSXYNQOIu1e
 tI/qQ9Ul+TCVAnTnqg1Jn6hHohYCz5NqZLlqAKLpM97voukFz2L+yv+hD1onrYkyvbJ4
 7jO51ukVwMh6+afg49H6kXvC4uBraFaBYd1vK1kPy8rxoGfEPGcns+1MWWC/wkYKVVVs
 WIVrfZZuNRTQGhT51NjQGR7PayZZNCrVpZjK2nhUeLEJkqHyo3vvMWbdBcNXaisZfjCd
 bazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629011; x=1744233811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kv473foA2Lz/6LlrfWieB+cyNxqB+oMm/dNGpDxxZmg=;
 b=JF1YF0W4NW+clnoyaIh0JQZi7a5wcKsYoh4coGWEsUKkYkjGEe2GnsL6hHPK+EvhSE
 x5tFOHOjDVFaifLJyMEr6PIoXrktHZ5YoXD+9cUIAxOEoFxKIFAKcFVfCHwiGCZdnJzP
 cnZ9zdon+7OyGjqXXbFnjPrbi+FT7icYnOYN2uQ7z01WqI6svC/sZWo7p2v1ePYlamkb
 qZWd4tiOIOVOKemlA9RMzKTFQLdTneXkoNmx9ZosFraRp2uEMR8pLWr70NqlZ5SDGs30
 uhGYnqH8z58PPsQoA9ByTVpIcWzd662ICJblc+S91Bh/roLllSDFhJZvVbZwdwife8H0
 iakQ==
X-Gm-Message-State: AOJu0Yyo9bGsHaRd+iFRXZCo3AFsiljlP+RcRl5LFF7PkADZePH1YiOV
 A6BlRB8LwD//c+ffRzVGnU8T7uL4bcTyQPv+ULDEdozeu2KY9dm7bi63WLwfa7I222kCfkESorB
 o
X-Gm-Gg: ASbGncsGeMpzdT2up6m4KDsWf/o+fsQKXTCfJzWCJQmsHcJL4BPw/7x9BVisnxWdj3x
 qodj7T2zkDeDC4BwLI7SUxJDaOQ/dxyn/I23M9MluimiiR3gUbh5B4Cp1ZaMuGVwxgiT1vAj3MK
 9dtAzbVfCuu49KqdAqne766qmb0dMgVts6hbcXer6GuJu1+OeV558YnJ/gqmK/f/yAC5D21bVn9
 vwcq8Kgpl3l6bPVZOv41MJcXnF2LAH9sJZP7zHGgZUOc7PpPr8VRbzjeaEolIkOjeqcvT4Gso6g
 3bs4FmjveRAwD4zt1K7dF9ZtlyPVo9ODkscUBX54ROO6z66RqDqvKguBTjHWJyjOoYDfgaU1SeM
 ZezyRwYaOq7k6aXAlAgE=
X-Google-Smtp-Source: AGHT+IEIMe2IY3ICdgZKl9e8nlk5/JOrZT8+QkJ2TTyC4MMQkGT74b87c5iwpqgpaZQ25tGa5oJAug==
X-Received: by 2002:a05:600c:c5:b0:43e:a7c9:8d2b with SMTP id
 5b1f17b1804b1-43ea7c99334mr60387585e9.24.1743629011198; 
 Wed, 02 Apr 2025 14:23:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec169abd7sm2470665e9.18.2025.04.02.14.23.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:23:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v2 39/43] tcg: Move qemu_tcg_mttcg_enabled() to
 'system/tcg.h'
Date: Wed,  2 Apr 2025 23:23:15 +0200
Message-ID: <20250402212319.58349-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402212319.58349-1-philmd@linaro.org>
References: <20250402212319.58349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

qemu_tcg_mttcg_enabled() is specific to 1/ TCG and
2/ system emulation. Move the prototype declaration
to "system/tcg.h", reducing 'mttcg_enabled' variable
scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/core/cpu.h      |  9 ---------
 include/system/tcg.h       |  8 ++++++++
 accel/tcg/tcg-all.c        | 16 ++++++++++++++--
 target/riscv/tcg/tcg-cpu.c |  1 +
 tcg/region.c               |  4 +++-
 5 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 10b6b25b344..c8d6abff19a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,15 +594,6 @@ extern CPUTailQ cpus_queue;
 
 extern __thread CPUState *current_cpu;
 
-/**
- * qemu_tcg_mttcg_enabled:
- * Check whether we are running MultiThread TCG or not.
- *
- * Returns: %true if we are in MTTCG mode %false otherwise.
- */
-extern bool mttcg_enabled;
-#define qemu_tcg_mttcg_enabled() (mttcg_enabled)
-
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
diff --git a/include/system/tcg.h b/include/system/tcg.h
index 73229648c63..7622dcea302 100644
--- a/include/system/tcg.h
+++ b/include/system/tcg.h
@@ -17,4 +17,12 @@ extern bool tcg_allowed;
 #define tcg_enabled() 0
 #endif
 
+/**
+ * qemu_tcg_mttcg_enabled:
+ * Check whether we are running MultiThread TCG or not.
+ *
+ * Returns: %true if we are in MTTCG mode %false otherwise.
+ */
+bool qemu_tcg_mttcg_enabled(void);
+
 #endif
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index a5a1fd6a11e..b8874430d30 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -38,6 +38,7 @@
 #include "hw/qdev-core.h"
 #else
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 #include "internal-common.h"
 #include "cpu-param.h"
@@ -58,6 +59,17 @@ typedef struct TCGState TCGState;
 DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
                          TYPE_TCG_ACCEL)
 
+#ifndef CONFIG_USER_ONLY
+
+static bool mttcg_enabled;
+
+bool qemu_tcg_mttcg_enabled(void)
+{
+    return mttcg_enabled;
+}
+
+#endif /* !CONFIG_USER_ONLY */
+
 /*
  * We default to false if we know other options have been enabled
  * which are currently incompatible with MTTCG. Otherwise when each
@@ -97,7 +109,6 @@ static void tcg_accel_instance_init(Object *obj)
 #endif
 }
 
-bool mttcg_enabled;
 bool one_insn_per_tb;
 
 static int tcg_init_machine(MachineState *ms)
@@ -107,10 +118,11 @@ static int tcg_init_machine(MachineState *ms)
     unsigned max_cpus = 1;
 #else
     unsigned max_cpus = ms->smp.max_cpus;
+
+    mttcg_enabled = s->mttcg_enabled;
 #endif
 
     tcg_allowed = true;
-    mttcg_enabled = s->mttcg_enabled;
 
     page_init();
     tb_htable_init();
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 50e81b2e521..88f7cdb887c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -36,6 +36,7 @@
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
+#include "system/tcg.h"
 #endif
 
 /* Hash that stores user set extensions */
diff --git a/tcg/region.c b/tcg/region.c
index 478ec051c4b..56d2e988719 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -34,7 +34,9 @@
 #include "exec/translation-block.h"
 #include "tcg-internal.h"
 #include "host/cpuinfo.h"
-
+#ifndef CONFIG_USER_ONLY
+#include "system/tcg.h"
+#endif
 
 /*
  * Local source-level compatibility with Unix.
-- 
2.47.1


