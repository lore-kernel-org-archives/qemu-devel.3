Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCBCE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 18:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLoLi-0006XJ-CU; Thu, 12 Dec 2024 13:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLP-0006BG-4U
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:28 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLoLK-0006ni-Lf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 13:55:26 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21675fd60feso11385765ad.2
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734029721; x=1734634521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gpa7MaWk80JbZDJF1tLVqJgKe0L0noYL27xWxmaxilM=;
 b=jaUeTtWdqnpsXGeVxx3YbQMHiFyy/JVOXfeTC1hjluvcw8XrV6b99W2FNHKGnL0mIa
 YIXOfiQ0riTeiAZhITXy8sRYN12TxQ+TQxg0O01AOhKrPQqnhH2XunzEzGhdKKj9r6hb
 HSEqhtt0fFQYwNAp0i64fO0wvuw/hXzXf4rqJqAMgZm8/M1JqCouRyc4Dl2MXOOXji3X
 VueX/ugkmhe/lBu1keKSNCuwDkASyUPlk+lJklUsNPu3SJQxkUu+IiWXsxCzPMV8PMVt
 ApFiwImhDJUgEtEqzq0DN5xahWdpAacnJQtt/gzMlrg+otqCEFkexiE2JITj7CySnZMz
 uNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734029721; x=1734634521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gpa7MaWk80JbZDJF1tLVqJgKe0L0noYL27xWxmaxilM=;
 b=m4WavLunSCP/+d2gby2UFKrn/iLA4CLaRJaK+owUVH6SEVps3EpjwFsa5AATqsKnuS
 kEz/Z05W1rjNMFQT4CCsPmvDlyGywJShblAKCSSpSGcMfi9suCjIDdaWq8QLWrJDSOLy
 E+vtyeIDSa04jzQeuoqoCqFmIPNspp2ractG+JH5KC7N12fWqRQp+r/AN6x1s6TBInO2
 NcXykvyTXn8RITY+d+6q16Dyql83FzFekP4RDA3xQhOgIJcOxi3lyUSGFW+qtu7Um8wr
 AEa53UCoqd0/44XjorvapGQcdV94KME82UUuTuYY/goQJg0nc1M8xsWzxZ/SCJwOLDu8
 sC/w==
X-Gm-Message-State: AOJu0YzhAE3M9lmyjW+5Bm+SEFmtMubTky2oWB2dvH2pIwrOxCXjm/QY
 m2Z6lH3feL2c6qAtz2chJ0hH5/bpEB+cksPHkN6WRhhobNaNFPoPOfeKZU5VNJUzuj9nUDnmx+v
 D
X-Gm-Gg: ASbGncsyMw89KKgnAzEzJrtQa2TAOdLpEgImPqQsUXVaFd4K9O4Z90X9dI5WmINLtmI
 PFCa0m930IMZa3RtZ2ibwE06z3nMHXkaDjdxg+dzbzxQThqRk+kC0VTRE510twR2fGOp+zNGlOF
 yBAwatS5Jpk2FIv1FRnULwCMsYo/CU0ciY1T78pPM6m56cnY8AcsqvXbBjwOIhaIaXL69+RYQaL
 kcRHLF64H3KjAAsSN7+0qLN7WH/+rbs8Ol49HzG0G5KkGrnItRMCFqYzr7qbbtu/IX3aofOemUk
 xikbMJ0h+pm+RLOkt3FyT4S/AnA9Cdk=
X-Google-Smtp-Source: AGHT+IFB8zxPhJitCrvNVqhB8G2wFOTAWji+InjjbMpKknt1K5wyHmkSCeo5TmD+7ST6E/PHdgbqgw==
X-Received: by 2002:a17:902:f648:b0:216:6855:164 with SMTP id
 d9443c01a7336-2178aeefc23mr74158235ad.39.1734029721067; 
 Thu, 12 Dec 2024 10:55:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd1570ae4esm11093308a12.43.2024.12.12.10.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Dec 2024 10:55:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/18] accel/tcg: Move 'exec/translate-all.h' ->
 'tb-internal.h'
Date: Thu, 12 Dec 2024 19:53:31 +0100
Message-ID: <20241212185341.2857-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212185341.2857-1-philmd@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x634.google.com
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

"exec/translate-all.h" is only useful to TCG accelerator,
so move it to accel/tcg/, after renaming it 'tb-internal.h'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h  |  2 +-
 accel/tcg/tb-internal.h      | 14 ++++++++++++++
 include/exec/translate-all.h | 28 ----------------------------
 accel/tcg/cputlb.c           |  2 +-
 accel/tcg/tb-maint.c         |  2 +-
 accel/tcg/translate-all.c    |  2 +-
 accel/tcg/user-exec.c        |  1 +
 accel/tcg/watchpoint.c       |  2 +-
 8 files changed, 20 insertions(+), 33 deletions(-)
 create mode 100644 accel/tcg/tb-internal.h
 delete mode 100644 include/exec/translate-all.h

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index a03c05315a4..6f4ec0bd424 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -10,7 +10,7 @@
 #define ACCEL_TCG_INTERNAL_TARGET_H
 
 #include "exec/exec-all.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 
 /*
  * Access to the various translations structures need to be serialised
diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
new file mode 100644
index 00000000000..8313f90fd71
--- /dev/null
+++ b/accel/tcg/tb-internal.h
@@ -0,0 +1,14 @@
+/*
+ * TranslationBlock internal declarations (target specific)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
+#define ACCEL_TCG_TB_INTERNAL_TARGET_H
+
+void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
+
+#endif
diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
deleted file mode 100644
index 039668ff8ac..00000000000
--- a/include/exec/translate-all.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- *  Translated block handling
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef TRANSLATE_ALL_H
-#define TRANSLATE_ALL_H
-
-#include "exec/exec-all.h"
-
-
-/* translate-all.c */
-void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
-
-#endif /* TRANSLATE_ALL_H */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b76a4eac4e0..451cf13e876 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -37,7 +37,7 @@
 #include "exec/helper-proto-common.h"
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 #include "trace.h"
 #include "tb-hash.h"
 #include "internal-common.h"
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 97d2e39ec0d..bdf5a0b7d58 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -25,7 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/page-protection.h"
 #include "exec/tb-flush.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
 #include "tb-hash.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d586ac9bb1d..bad3fce0ffb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -45,7 +45,7 @@
 
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
-#include "exec/translate-all.h"
+#include "tb-internal.h"
 #include "exec/translator.h"
 #include "exec/tb-flush.h"
 #include "qemu/bitmap.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 636932303bb..815a39503f3 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -33,6 +33,7 @@
 #include "tcg/tcg-ldst.h"
 #include "internal-common.h"
 #include "internal-target.h"
+#include "tb-internal.h"
 
 __thread uintptr_t helper_retaddr;
 
diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 8923301b8b8..e24baead562 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -21,8 +21,8 @@
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
-#include "exec/translate-all.h"
 #include "exec/page-protection.h"
+#include "tb-internal.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "hw/core/tcg-cpu-ops.h"
-- 
2.45.2


