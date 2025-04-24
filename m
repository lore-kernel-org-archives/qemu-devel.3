Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F31EC369D5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u84wl-0004TX-7k; Thu, 24 Apr 2025 18:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wj-0004TK-8t
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u84wf-0000wf-OI
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:21:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so13831825e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533284; x=1746138084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JBHgXf1VILUQD/n0uYXLzK5bDjPq3G+VbeYo1f99nf0=;
 b=shJfuCPyS33+OwDJm/G/aSbdWI1Tpbc6Fpg0jIBkceS43MboZ8x2QoSa3CsC6ilqmA
 gtQ0CFnO21IdRRq357iHV4QG7Vr596XMzyYqiFKn6RsJMI8h9nidze3vIgoRjHRzALPI
 6+OMG+4g25cUfMsDSwzWou43M5H9ONjl9zDEONzOEZLu8JElG4KF63U+DM0jEGTynogy
 xEYJruMsAeG6qjMqC6RqZqRu2gAi3fC43pXWL3Snn0hlodpT0Lh6pGhNP/G7GeYqCNso
 lC3Y1dWjn2f+YCro6uOysnVU8Ck6IvSYwsCdAcHNNRftg8Z577taNR7O5ZweQd1pRRvb
 bMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533284; x=1746138084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBHgXf1VILUQD/n0uYXLzK5bDjPq3G+VbeYo1f99nf0=;
 b=Q7CK5MyTpPLR7+tAnjr5BmRBdk7lhhmBNPilS+Z4gcq/OUQQY2OuUhSh+YYOQ8Ie76
 EZ7xzO7FCEDRduA1D0vDf8HeK1owXyxXpJMwp+ffTeF+uKYueHrGe6c2HmmK2hPuL2yd
 /K9tMEtUpXbzTd4UZHC1cOkRzMhmiRPmudoyRvLnrPp+6H3GYPWHXRvyu1bW4aAIlw/W
 FsVTSR5rPJsNbEr/2ErHiBSISJvaBHqzK1rnUqfJ8u9ExoGTWYkeTDGxYsobgv0C8QsK
 yluOaWx/pDp7wP9f08vPLHjrTY7/B7TAlpDIw/ZjVJ3TWbActZdBqO6Cm4n9bPTb4XCD
 xptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7VEwDsK3AELk2FAoUQfK6ysVxC6WeX4rLBdCHHgWqSsQL0YmWPh15DSUajo5PIgWqEPnJVJ3enBK5@nongnu.org
X-Gm-Message-State: AOJu0YxIhZmYHFWcUcNMaS8RDjwXBi1oYZJ3iT+Jn76KT9CnWkXroNNH
 GN9kw6oB9Bp7aG8gMPkPnoYhIv8kIDHwFPHV8trDqm1IOYs3Amnq2A609y3NtlY=
X-Gm-Gg: ASbGncvVmP0npTjnuH5Kilu9SMjWxH0xX+MOQqK8WP8TOLNIzzv5yI9h0fDly97HVl1
 MpNQLKgZzCkbolK+m4sh3t5ikpmoOWKQiC3vpshiFs1yv4lSqj9X0EAvbb4dU+8w7OZN4M56P7t
 zzL23IdtPQhsXskO7RO/tmLIFyQ6P75pqige7LV5PxP6XC5D1Genvqjth+D+itKhy/POZcoWJbr
 t3dhe9VW88w78Z4Plsd7bJvju1WvSXL+Z8/7zpmG6E6bL3VCb6Ajo9/56DLPj1r2KbQcK4nA3sS
 lnOdi6ZpcNug3kOYE1RwHQLig8aZDIGv1/cd++Mh2RhzMuGxPed5HjHUofy2ifN90KnDdDMVJJ1
 Bxwqmbz3sEDGFHLo=
X-Google-Smtp-Source: AGHT+IHyAPfrkygc2Slbhde5Vn+Aic9mIxc+irODqPLZJu/YjZk7jmsgZw9ryLpJgU+PM3ZeFZMdmQ==
X-Received: by 2002:a05:600c:1c08:b0:43b:cb12:ba6d with SMTP id
 5b1f17b1804b1-4409bd0a7e2mr45290525e9.3.1745533283614; 
 Thu, 24 Apr 2025 15:21:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a5a74314sm1923935e9.4.2025.04.24.15.21.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 15:21:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v5 02/21] qemu: Convert target_name() to TargetInfo API
Date: Fri, 25 Apr 2025 00:20:53 +0200
Message-ID: <20250424222112.36194-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424222112.36194-1-philmd@linaro.org>
References: <20250424222112.36194-1-philmd@linaro.org>
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

Have target_name() be a target-agnostic method, dispatching
to a per-target TargetInfo singleton structure.
By default a stub singleton is used. No logical change
expected.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS                     |  7 +++++++
 meson.build                     |  3 +++
 include/hw/core/cpu.h           |  2 --
 include/qemu/target-info-impl.h | 26 ++++++++++++++++++++++++++
 include/qemu/target-info.h      | 19 +++++++++++++++++++
 cpu-target.c                    |  5 -----
 hw/core/machine-qmp-cmds.c      |  1 +
 plugins/loader.c                |  2 +-
 system/vl.c                     |  2 +-
 target-info-stub.c              | 19 +++++++++++++++++++
 target-info.c                   | 16 ++++++++++++++++
 11 files changed, 93 insertions(+), 9 deletions(-)
 create mode 100644 include/qemu/target-info-impl.h
 create mode 100644 include/qemu/target-info.h
 create mode 100644 target-info-stub.c
 create mode 100644 target-info.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d82d962f1a4..451e2778888 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1926,6 +1926,13 @@ F: tests/functional/test_empty_cpu_model.py
 F: tests/unit/test-smp-parse.c
 T: git https://gitlab.com/ehabkost/qemu.git machine-next
 
+TargetInfo API
+M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
+M: Philippe Mathieu-Daudé <philmd@linaro.org>
+S: Supported
+F: include/qemu/target-info*.h
+F: target-info*.c
+
 Xtensa Machines
 ---------------
 sim
diff --git a/meson.build b/meson.build
index c736a6f4c4b..8ae70dbe45a 100644
--- a/meson.build
+++ b/meson.build
@@ -3795,6 +3795,9 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+common_ss.add(files('target-info.c'))
+specific_ss.add(files('target-info-stub.c'))
+
 subdir('backends')
 subdir('disas')
 subdir('migration')
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b645df59f5..9d9448341d1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1115,8 +1115,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-const char *target_name(void);
-
 #ifdef COMPILING_PER_TARGET
 
 extern const VMStateDescription vmstate_cpu_common;
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
new file mode 100644
index 00000000000..d30805f7f28
--- /dev/null
+++ b/include/qemu/target-info-impl.h
@@ -0,0 +1,26 @@
+/*
+ * QEMU TargetInfo structure definition
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_IMPL_H
+#define QEMU_TARGET_INFO_IMPL_H
+
+#include "qemu/target-info.h"
+
+typedef struct TargetInfo {
+    /* runtime equivalent of TARGET_NAME definition */
+    const char *target_name;
+} TargetInfo;
+
+/**
+ * target_info:
+ *
+ * Returns: The TargetInfo structure definition for this target binary.
+ */
+const TargetInfo *target_info(void);
+
+#endif
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
new file mode 100644
index 00000000000..1007dc9a5e4
--- /dev/null
+++ b/include/qemu/target-info.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU target info API
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_H
+#define QEMU_TARGET_INFO_H
+
+/**
+ * target_name:
+ *
+ * Returns: Canonical target name (i.e. "i386").
+ */
+const char *target_name(void);
+
+#endif
diff --git a/cpu-target.c b/cpu-target.c
index c99d208a7c4..3f82d3ea444 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -165,8 +165,3 @@ bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
 }
-
-const char *target_name(void)
-{
-    return TARGET_NAME;
-}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index a5e635152dc..d82043e1c68 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,6 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/target-info.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/plugins/loader.c b/plugins/loader.c
index 0d6e082e170..8f0d75c9049 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -29,7 +29,7 @@
 #include "qemu/xxhash.h"
 #include "qemu/plugin.h"
 #include "qemu/memalign.h"
-#include "hw/core/cpu.h"
+#include "qemu/target-info.h"
 #include "exec/tb-flush.h"
 
 #include "plugin.h"
diff --git a/system/vl.c b/system/vl.c
index c17945c4939..cdf6eb9ee49 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -40,6 +40,7 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
+#include "qemu/target-info.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
@@ -79,7 +80,6 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
-#include "hw/core/cpu.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
diff --git a/target-info-stub.c b/target-info-stub.c
new file mode 100644
index 00000000000..076b9254dd0
--- /dev/null
+++ b/target-info-stub.c
@@ -0,0 +1,19 @@
+/*
+ * QEMU target info stubs
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info-impl.h"
+
+static const TargetInfo target_info_stub = {
+    .target_name = TARGET_NAME,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_stub;
+}
diff --git a/target-info.c b/target-info.c
new file mode 100644
index 00000000000..84b18931e7e
--- /dev/null
+++ b/target-info.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU target info helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target-info.h"
+#include "qemu/target-info-impl.h"
+
+const char *target_name(void)
+{
+    return target_info()->target_name;
+}
-- 
2.47.1


