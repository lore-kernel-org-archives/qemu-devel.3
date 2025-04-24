Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFA8C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kru-0006rE-Sj; Wed, 23 Apr 2025 20:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015L-PP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kq8-0004iJ-B6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so369378b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455999; x=1746060799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZ2uAEQVxje5/kiLSW050T/aRtTVB8F0yJpvuIXNmbQ=;
 b=zMXcDCWyPJUpwidv207hE77+cpXq4EI7jDnNJbDSwvwaX2MUVEpsqsf0CciqLq8e3f
 xrrtTX1GpMs7pvcf01p6J/p+InybXs5toyE4cP0sMFEJeomqasJwnz4ZZFrD1cnI9WfP
 5no3GlxBTzhAI1bx/a6zyG9sqifKeV7+iYMlD70qEyXiPlRaUVutXLrMrz3Us2AsiuCb
 dFDNYK3BT9QC251oJusVw2fSqdkFxmXxLE2+nxSoCI3J3yAp6wyVG8ZEAzqiQ/49aqO8
 kyF1uJlMoz/bBH8ZDvGBFm7C5vWuBmrVUqkkvF2l7nWCT5PAoesUvd/YTu7J3n8Z63fd
 PqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455999; x=1746060799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZ2uAEQVxje5/kiLSW050T/aRtTVB8F0yJpvuIXNmbQ=;
 b=wWUSGBL5cYbhZJnaFTlJzcR0+/ij/+pcF1g77EHG9k/lUBv2+ykVXsyGQa+5DfOceA
 ThxDvCKpjBhPbe3lHyXZajVKMouxJBzrcrbxrUs0sWNbVsT/CRP5QFrFhdoM0ms2R7/B
 FKg/lCZcSiXLncjjTXvsDILnyjFXCWPQB7VEzkif4OEz1gUInEuCPFpDHIKRmJ7w0u/B
 iDkcO2Yf57+KaJP4whaeQLJk6fUWQjYFiRhLDDR0ZuTVTnXMPN8sNAaKWU61iIuHJWcm
 TG/Z5QAnOveRDHNnpdQ5EwJbfuZMrKOsHpBFJ8ODyHDIbleUhKhdwrbbynbE893mlwj1
 oU6w==
X-Gm-Message-State: AOJu0Yywgm0X2HvA2opNAoQyoAUoQn7kLfpO3//5WNuqrD50lDyQpgTK
 9OS2tow+LeIcfJmHl7Hs4qP31eLZ5Mq5/YnkJ7EbJ8ytMncy64ea7GSYh3pqZU7uQo5nGXndv3j
 Y
X-Gm-Gg: ASbGncseg5PTVK3fYA/IsN1oB/YrcrKqnalHBBTtcX60ogdjIbj5/qduwmYw1cbkuB9
 Md3RkkONyg2KBUfxOxIFAxDHbk4fatmjbXFHNsHhkRlzHHhZGwhYRSRRm12W76ipy/J8V2GYOSR
 OX+MSIgQqhSmgqiDto4IJIqIHl3ufDls0HL0P9bj7xj5M4Oqnd9bsALCAOWsgLRbFN9CFM0qRKr
 qkCFIYOXSwarzDURg6vSDGgAIN+bxtexNmkh7rS6UtdHInCIYn1r/JtN3bw91S9ANqiIS4eBRaq
 AGSiIAQ2ri5K8cPGEE3IPkadRN7501i50T0D+T4127AnyfgORzhSxKKYQ6S6Za8dUxQdex/FIOc
 =
X-Google-Smtp-Source: AGHT+IE/83GfRzXcst/BYWWkbTHjl2Wg6LiS+SJOfGkSkKscW13TgFZ5jZtt09Mg2OgZa76CtBITFA==
X-Received: by 2002:a05:6a00:e1b:b0:73d:fa34:50c8 with SMTP id
 d2e1a72fcca58-73e23cbb5ddmr1073499b3a.0.1745455998747; 
 Wed, 23 Apr 2025 17:53:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 056/148] include/exec: Split out icount.h
Date: Wed, 23 Apr 2025 17:48:01 -0700
Message-ID: <20250424004934.598783-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Split icount stuff from system/cpu-timers.h.
There are 17 files which only require icount.h, 7 that only
require cpu-timers.h, and 7 that require both.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++
 include/system/cpu-timers.h      | 58 ---------------------------
 accel/tcg/cpu-exec.c             |  2 +-
 accel/tcg/icount-common.c        |  2 +-
 accel/tcg/monitor.c              |  1 +
 accel/tcg/tcg-accel-ops-icount.c |  2 +-
 accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
 accel/tcg/tcg-accel-ops-rr.c     |  2 +-
 accel/tcg/tcg-accel-ops.c        |  2 +-
 accel/tcg/tcg-all.c              |  2 +-
 accel/tcg/translate-all.c        |  2 +-
 hw/core/ptimer.c                 |  2 +-
 replay/replay.c                  |  2 +-
 stubs/icount.c                   |  2 +-
 system/cpu-timers.c              |  1 +
 system/dma-helpers.c             |  2 +-
 system/vl.c                      |  1 +
 target/arm/helper.c              |  1 +
 target/riscv/cpu_helper.c        |  2 +-
 target/riscv/csr.c               |  2 +-
 target/riscv/debug.c             |  1 +
 target/riscv/machine.c           |  2 +-
 target/riscv/pmu.c               |  2 +-
 util/async.c                     |  2 +-
 util/main-loop.c                 |  1 +
 util/qemu-timer.c                |  1 +
 26 files changed, 92 insertions(+), 75 deletions(-)
 create mode 100644 include/exec/icount.h

diff --git a/include/exec/icount.h b/include/exec/icount.h
new file mode 100644
index 0000000000..4964987ae4
--- /dev/null
+++ b/include/exec/icount.h
@@ -0,0 +1,68 @@
+/*
+ * icount - Instruction Counter API
+ * CPU timers state API
+ *
+ * Copyright 2020 SUSE LLC
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef EXEC_ICOUNT_H
+#define EXEC_ICOUNT_H
+
+/**
+ * ICountMode: icount enablement state:
+ *
+ * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
+ * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
+ * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
+ */
+typedef enum {
+    ICOUNT_DISABLED = 0,
+    ICOUNT_PRECISE,
+    ICOUNT_ADAPTATIVE,
+} ICountMode;
+
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+extern ICountMode use_icount;
+#define icount_enabled() (use_icount)
+#else
+#define icount_enabled() ICOUNT_DISABLED
+#endif
+
+/*
+ * Update the icount with the executed instructions. Called by
+ * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
+ */
+void icount_update(CPUState *cpu);
+
+/* get raw icount value */
+int64_t icount_get_raw(void);
+
+/* return the virtual CPU time in ns, based on the instruction counter. */
+int64_t icount_get(void);
+/*
+ * convert an instruction counter value to ns, based on the icount shift.
+ * This shift is set as a fixed value with the icount "shift" option
+ * (precise mode), or it is constantly approximated and corrected at
+ * runtime in adaptive mode.
+ */
+int64_t icount_to_ns(int64_t icount);
+
+/**
+ * icount_configure: configure the icount options, including "shift"
+ * @opts: Options to parse
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Return: true on success, else false setting @errp with error
+ */
+bool icount_configure(QemuOpts *opts, Error **errp);
+
+/* used by tcg vcpu thread to calc icount budget */
+int64_t icount_round(int64_t count);
+
+/* if the CPUs are idle, start accounting real time to virtual clock. */
+void icount_start_warp_timer(void);
+void icount_account_warp_timer(void);
+void icount_notify_exit(void);
+
+#endif /* EXEC_ICOUNT_H */
diff --git a/include/system/cpu-timers.h b/include/system/cpu-timers.h
index 64ae54f6d6..a1abed0d7a 100644
--- a/include/system/cpu-timers.h
+++ b/include/system/cpu-timers.h
@@ -15,64 +15,6 @@
 /* init the whole cpu timers API, including icount, ticks, and cpu_throttle */
 void cpu_timers_init(void);
 
-/* icount - Instruction Counter API */
-
-/**
- * ICountMode: icount enablement state:
- *
- * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
- * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
- * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
- */
-typedef enum {
-    ICOUNT_DISABLED = 0,
-    ICOUNT_PRECISE,
-    ICOUNT_ADAPTATIVE,
-} ICountMode;
-
-#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-extern ICountMode use_icount;
-#define icount_enabled() (use_icount)
-#else
-#define icount_enabled() ICOUNT_DISABLED
-#endif
-
-/*
- * Update the icount with the executed instructions. Called by
- * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
- */
-void icount_update(CPUState *cpu);
-
-/* get raw icount value */
-int64_t icount_get_raw(void);
-
-/* return the virtual CPU time in ns, based on the instruction counter. */
-int64_t icount_get(void);
-/*
- * convert an instruction counter value to ns, based on the icount shift.
- * This shift is set as a fixed value with the icount "shift" option
- * (precise mode), or it is constantly approximated and corrected at
- * runtime in adaptive mode.
- */
-int64_t icount_to_ns(int64_t icount);
-
-/**
- * icount_configure: configure the icount options, including "shift"
- * @opts: Options to parse
- * @errp: pointer to a NULL-initialized error object
- *
- * Return: true on success, else false setting @errp with error
- */
-bool icount_configure(QemuOpts *opts, Error **errp);
-
-/* used by tcg vcpu thread to calc icount budget */
-int64_t icount_round(int64_t count);
-
-/* if the CPUs are idle, start accounting real time to virtual clock. */
-void icount_start_warp_timer(void);
-void icount_account_warp_timer(void);
-void icount_notify_exit(void);
-
 /*
  * CPU Ticks and Clock
  */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 372b876604..034c2ded6b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -35,7 +35,7 @@
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-all.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "exec/replay-core.h"
 #include "system/tcg.h"
 #include "exec/helper-proto-common.h"
diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
index 402d3e3f4e..d6471174a3 100644
--- a/accel/tcg/icount-common.c
+++ b/accel/tcg/icount-common.c
@@ -35,7 +35,7 @@
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "hw/core/cpu.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/cpu-timers-internal.h"
 
 /*
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index eeb38a4d9c..1c182b6bfb 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -14,6 +14,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "internal-common.h"
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 27cf1044c7..d0f7b410fa 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "hw/core/cpu.h"
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index bdcc385ae9..dfcee30947 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f62cf24e1d..6eec5c9eee 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -27,7 +27,7 @@
 #include "qemu/lockable.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 5c88056157..ccdb781eef 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -29,7 +29,7 @@
 #include "system/accel-ops.h"
 #include "system/tcg.h"
 #include "system/replay.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c1a30b0121..7a5b810b88 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "system/tcg.h"
 #include "exec/replay-core.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "tcg/startup.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 167535bcb1..bb161ae61a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -55,7 +55,7 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
 #include "accel/tcg/cpu-ops.h"
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 7f63d17ca1..0aeb10fb53 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -11,7 +11,7 @@
 #include "migration/vmstate.h"
 #include "qemu/host-utils.h"
 #include "exec/replay-core.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/qtest.h"
 #include "block/aio.h"
 #include "hw/clock.h"
diff --git a/replay/replay.c b/replay/replay.c
index 3adc387b3d..a3e24c967a 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/replay.h"
 #include "system/runstate.h"
 #include "replay-internal.h"
diff --git a/stubs/icount.c b/stubs/icount.c
index edbf60cbfa..ceb73b4fc2 100644
--- a/stubs/icount.c
+++ b/stubs/icount.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 
 /* icount - Instruction Counter API */
 
diff --git a/system/cpu-timers.c b/system/cpu-timers.c
index 23dd82b465..cb35fa62b8 100644
--- a/system/cpu-timers.c
+++ b/system/cpu-timers.c
@@ -36,6 +36,7 @@
 #include "hw/core/cpu.h"
 #include "system/cpu-timers.h"
 #include "system/cpu-timers-internal.h"
+#include "exec/icount.h"
 
 /* clock and ticks */
 
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 6bad75876f..0d592f6468 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -13,7 +13,7 @@
 #include "trace.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/range.h"
 
 /* #define DEBUG_IOMMU */
diff --git a/system/vl.c b/system/vl.c
index ec93988a03..c17945c493 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -89,6 +89,7 @@
 #include "audio/audio.h"
 #include "system/cpus.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "migration/colo.h"
 #include "migration/postcopy-ram.h"
 #include "system/kvm.h"
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0454b06a6c..becbbbd0d8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -24,6 +24,7 @@
 #include "exec/translation-block.h"
 #include "hw/irq.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6c4391d96b..0dd8645994 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -31,7 +31,7 @@
 #include "accel/tcg/cpu-ops.h"
 #include "trace.h"
 #include "semihosting/common-semi.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "cpu_bits.h"
 #include "debug.h"
 #include "pmp.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7948188356..c52c87faae 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -27,7 +27,7 @@
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include <stdbool.h>
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index fea989afe9..7fc9e121e1 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -32,6 +32,7 @@
 #include "exec/helper-proto.h"
 #include "exec/watchpoint.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 
 /*
  * The following M-mode trigger CSRs are implemented:
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 889e2b6570..a1f70cc955 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -21,7 +21,7 @@
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "migration/cpu.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "debug.h"
 
 static bool pmp_needed(void *opaque)
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 0408f96e6a..a68809eef3 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -22,7 +22,7 @@
 #include "qemu/timer.h"
 #include "cpu.h"
 #include "pmu.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
diff --git a/util/async.c b/util/async.c
index 863416dee9..2719c629ae 100644
--- a/util/async.c
+++ b/util/async.c
@@ -35,7 +35,7 @@
 #include "block/raw-aio.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/coroutine-tls.h"
-#include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "trace.h"
 
 /***********************************************************/
diff --git a/util/main-loop.c b/util/main-loop.c
index acad8c2e6c..42bd75c193 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -27,6 +27,7 @@
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/replay.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 788466fe22..1fb48be281 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "qemu/lockable.h"
 #include "system/cpu-timers.h"
+#include "exec/icount.h"
 #include "system/replay.h"
 #include "system/cpus.h"
 
-- 
2.43.0


