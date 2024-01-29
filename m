Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66797C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUae3-0006nS-1h; Mon, 29 Jan 2024 18:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadx-0006W5-9D
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:22 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadv-0008US-2b
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:20 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6de24201aa6so1057966b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569338; x=1707174138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmzrBNQK2eDwb+/K0EzCDtsTU1SD4iiHNXZIgeBMj8o=;
 b=xlIilcGnalkvK4ddm6B/XB0qAKs/G7/V1tgYnRoWzuOI6wewrCXd0qHsZcgleuCB90
 RQ6H5alWmJA+zCToARsRR6NSLGanS7sEMsutkNUT34iWA5AnoL+Q80kt5iaVlVkqOpe2
 L++uMONxgylKGps1M9om1IP2XKi/GUjD1X9ZQsWHRtLMMavP3hv7XLaaBlfRprhaZzh+
 ABJqcjOf5fFY7SOg+e+mryslldmx8KTANpFbPJNlahNiIRrVr2xklYGxAgho13ZipfAF
 FpGt2sv4SRKQsDjoyuEgNOYy4XtTaviFuf4fyux+m05VwOPF5rfR8jW7/gZjC8Kyr2Uz
 ligw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569338; x=1707174138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmzrBNQK2eDwb+/K0EzCDtsTU1SD4iiHNXZIgeBMj8o=;
 b=kw19q5Rh5Jxuo6PbXFXLwSvAI4MN/kIuVHrqPt4HOzTWnj8beMyo8dk9ABjvX9CFvZ
 E+Eotng7COpU4LUncYVSnys3akmTsMOW8GmGQPpfkrTXVwQKKNyoIJ8uW/XtlhbASAU3
 gjqbtT0pIDTtvZVQtDlj0RW0RRuTtSSQoOVczz2JlxVpAs0TLEnXc3ANLiSaETBhPIAy
 TITWZU4aFwHnmSaQm7Lmf08odxfRJJg9Y9wOfurR2rEtBuscrPoRK73ku3SH8+y0rsTj
 rjSWrbLcektrRO10YLJRsgHr8Uj+mx3BQijX4QWYR0wGZ/gwMBHtmRM6TPkM9Q5hte8m
 H0tw==
X-Gm-Message-State: AOJu0Yzc/GtqLFAHVaICG+k/WNJ6l9plgBQ/PslnX5/bgJel+SLe0Azw
 LXvZz2lOFZqHw8ervl/y7+gP891FWvNBX1ZnaSLxNsjzT5vNw3t8ZzFoGgIP2/WLaOea9Q7XEes
 Ufhc=
X-Google-Smtp-Source: AGHT+IGkxkirXd/IyFRi4AgJLEbEwLJbjBz7WWsgqnY4gkifuj1lV0YtGWPwZgoomyKUEh/ReSf/Pg==
X-Received: by 2002:a05:6a00:1798:b0:6db:d5b5:e380 with SMTP id
 s24-20020a056a00179800b006dbd5b5e380mr5067325pfg.24.1706569337663; 
 Mon, 29 Jan 2024 15:02:17 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/31] accel/tcg: Move perf and debuginfo support to tcg/
Date: Tue, 30 Jan 2024 09:01:09 +1000
Message-Id: <20240129230121.8091-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

tcg/ should not depend on accel/tcg/, but perf and debuginfo
support provided by the latter are being used by tcg/tcg.c.

Since that's the only user, move both to tcg/.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231212003837.64090-5-iii@linux.ibm.com>
Message-Id: <20240125054631.78867-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 {accel => include}/tcg/debuginfo.h | 4 ++--
 {accel => include}/tcg/perf.h      | 4 ++--
 accel/tcg/translate-all.c          | 2 +-
 hw/core/loader.c                   | 2 +-
 linux-user/elfload.c               | 2 +-
 linux-user/exit.c                  | 2 +-
 linux-user/main.c                  | 2 +-
 system/vl.c                        | 2 +-
 {accel/tcg => tcg}/debuginfo.c     | 3 +--
 {accel/tcg => tcg}/perf.c          | 7 +++----
 tcg/tcg.c                          | 2 +-
 accel/tcg/meson.build              | 4 ----
 tcg/meson.build                    | 5 +++++
 13 files changed, 20 insertions(+), 21 deletions(-)
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (99%)

diff --git a/accel/tcg/debuginfo.h b/include/tcg/debuginfo.h
similarity index 96%
rename from accel/tcg/debuginfo.h
rename to include/tcg/debuginfo.h
index f064e1c144..858535b5da 100644
--- a/accel/tcg/debuginfo.h
+++ b/include/tcg/debuginfo.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_DEBUGINFO_H
-#define ACCEL_TCG_DEBUGINFO_H
+#ifndef TCG_DEBUGINFO_H
+#define TCG_DEBUGINFO_H
 
 #include "qemu/bitops.h"
 
diff --git a/accel/tcg/perf.h b/include/tcg/perf.h
similarity index 95%
rename from accel/tcg/perf.h
rename to include/tcg/perf.h
index f92dd52c69..c96b5920a3 100644
--- a/accel/tcg/perf.h
+++ b/include/tcg/perf.h
@@ -4,8 +4,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#ifndef ACCEL_TCG_PERF_H
-#define ACCEL_TCG_PERF_H
+#ifndef TCG_PERF_H
+#define TCG_PERF_H
 
 #if defined(CONFIG_TCG) && defined(CONFIG_LINUX)
 /* Start writing perf-<pid>.map. */
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 1737bb3da5..1c695efe02 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -63,7 +63,7 @@
 #include "tb-context.h"
 #include "internal-common.h"
 #include "internal-target.h"
-#include "perf.h"
+#include "tcg/perf.h"
 #include "tcg/insn-start-words.h"
 
 TBContext tb_ctx;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index e7a9b3775b..b8e52f3fb0 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -62,7 +62,7 @@
 #include "hw/boards.h"
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #include <zlib.h>
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index daf7ef8435..b8eef893d0 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -22,7 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "target_signal.h"
-#include "accel/tcg/debuginfo.h"
+#include "tcg/debuginfo.h"
 
 #ifdef TARGET_ARM
 #include "target/arm/cpu-features.h"
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 50266314e0..1ff8fe4f07 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -17,7 +17,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #include "gdbstub/syscalls.h"
 #include "qemu.h"
 #include "user-internals.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index c9470eeccf..74b2fbb393 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -54,7 +54,7 @@
 #include "signal-common.h"
 #include "loader.h"
 #include "user-mmap.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
diff --git a/system/vl.c b/system/vl.c
index 788d88ea03..60fd1e56b6 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -96,7 +96,7 @@
 #endif
 #include "sysemu/qtest.h"
 #ifdef CONFIG_TCG
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #endif
 
 #include "disas/disas.h"
diff --git a/accel/tcg/debuginfo.c b/tcg/debuginfo.c
similarity index 98%
rename from accel/tcg/debuginfo.c
rename to tcg/debuginfo.c
index 71c66d04d1..3753f7ef67 100644
--- a/accel/tcg/debuginfo.c
+++ b/tcg/debuginfo.c
@@ -6,11 +6,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
+#include "tcg/debuginfo.h"
 
 #include <elfutils/libdwfl.h>
 
-#include "debuginfo.h"
-
 static QemuMutex lock;
 static Dwfl *dwfl;
 static const Dwfl_Callbacks dwfl_callbacks = {
diff --git a/accel/tcg/perf.c b/tcg/perf.c
similarity index 99%
rename from accel/tcg/perf.c
rename to tcg/perf.c
index 68a46b1b52..412a987d95 100644
--- a/accel/tcg/perf.c
+++ b/tcg/perf.c
@@ -11,13 +11,12 @@
 #include "qemu/osdep.h"
 #include "elf.h"
 #include "exec/target_page.h"
-#include "exec/exec-all.h"
+#include "exec/translation-block.h"
 #include "qemu/timer.h"
+#include "tcg/debuginfo.h"
+#include "tcg/perf.h"
 #include "tcg/tcg.h"
 
-#include "debuginfo.h"
-#include "perf.h"
-
 static FILE *safe_fopen_w(const char *path)
 {
     int saved_errno;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e2c38f6d11..eeff4c1d51 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -55,7 +55,7 @@
 #include "tcg/tcg-ldst.h"
 #include "tcg/tcg-temp-internal.h"
 #include "tcg-internal.h"
-#include "accel/tcg/perf.h"
+#include "tcg/perf.h"
 #ifdef CONFIG_USER_ONLY
 #include "exec/user/guest-base.h"
 #endif
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index c15ac9ac8f..46f7d53eeb 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -16,10 +16,6 @@ tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
   tcg_ss.add(files('plugin-gen.c'))
 endif
-tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
-if host_os == 'linux'
-  tcg_ss.add(files('perf.c'))
-endif
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
diff --git a/tcg/meson.build b/tcg/meson.build
index 5afdec1e1a..8251589fd4 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -22,6 +22,11 @@ if get_option('tcg_interpreter')
   tcg_ss.add(files('tci.c'))
 endif
 
+tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
+if host_os == 'linux'
+  tcg_ss.add(files('perf.c'))
+endif
+
 tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
-- 
2.34.1


