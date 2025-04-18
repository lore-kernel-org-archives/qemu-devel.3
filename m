Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EDAC369CB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 00:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Zws-0001it-CY; Thu, 17 Apr 2025 20:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwp-0001iL-GV
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5Zwn-0005o6-Jc
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 20:51:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso11173695e9.2
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 17:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744937472; x=1745542272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OmLiEEj8BsSlPrrh5/WyA2e/HFVflcBaJVJKNxqZAeQ=;
 b=eAUcS54g2Dx97tCwyf0cOWiiQBOLpVsoIl5s0okrJtxmhiYuzc5lxqOgIEAcKsFPtY
 wKmdWBCxgdPItIvnGSI/xQDkMsaiJVynu10CLCp4pRGrglYIXbKfF4DuHpMNtPmSKaAe
 dDi8j8/383JQbYgu4ILZEAPdKJ86Y8ckZsnITDuesanvt4sci+CZXtGnVZBgRyisI6be
 CLWeUut3G8eUp3lJZtL8HNS1na05vuo7D0qeVgNE+VYGlrW3W2zq0tFqepmrPqniK2as
 IfyDg0zaolkkYMrfRyCtp7ylP21QYiDibxiMtu8kxx5PTgFABgTvJRvCtY/O1SZz2NnU
 RtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744937472; x=1745542272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OmLiEEj8BsSlPrrh5/WyA2e/HFVflcBaJVJKNxqZAeQ=;
 b=pQz7dyZ0GYkninCqP5aUp4fsS0ALsx1VAFQqlRRRR2bzFdGrtY5jVZ0fiVMDu0zdQm
 f7EOBjnAR52rcLsH1i0zpiUo+ur7p5qJ84cCZjJXoKnSBonc5+zwtVcH9lJ36qHYxQof
 2YDas8GQ+Pxa+JS6is9UYSEJqts2L5nXBy+haXlTssUgX5W/+Q/JGAkLGskz1Pzw2CdQ
 3F1+ZmfCgvHIb9Ci1Rn4FGt3TYRhX0edIxOnp0MieAc6oSSsqM8T+kbZj2TiF/m/LCKG
 GLL/4IGJ04Xlgs13sNW8cE4Onk3FC0CxIIEnI4Pax713B6nXoqEJ3vlJYivfWP4dQ/Zz
 yEOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuJRt6Kawe+fFn5PtjlvgyzEQQ2rVypE8NNnQBagdzZCXzdobwAIRQhsK6wOIvfqx6P7z4uKR3vZD+@nongnu.org
X-Gm-Message-State: AOJu0YwMb3mGAPiTuQNCFjCj3gx7zi4KE+ru50GdHMsIy5EnvEpBqzhv
 J7L73BuKcbgUmcJerRINUgiig2PF5gZqst4LDONHyR+jdflfy240V4KrKYu6Ggc=
X-Gm-Gg: ASbGncvv/0IlU4OQHWzIMiFDzLa/eHvhp0f55mjqNVAORjDK/FFji7MzFeMjg3x8obX
 cxdxPD2cVGCH7PLNN768hwOjk8Hm47uBvx3ws7QW8YjktfRYeoaxZ18zqV7FAENh0NlynFv+EcZ
 mJimSThSjfkSOaiQc52zq9XFJOi20Pch5l7uD5o8k1K2u4wctbqLbYYO6e6kj4yshjbIKOVWmq2
 uOivY5RCn9+2RMt40w0uV1wO89jF8obSgL1o/ZUjfVOdKzrQ6XDoZYId7TT1kUnL9fbu490GXRL
 RdcUz2DQi2RpoOLVS1lLY3nf3QgPSuTqOxDmELABbbrnWiI4p0Pq5sFglgcb7xUTKJI843/3gvL
 y21pYoYz7qbk94x8d2Jhu
X-Google-Smtp-Source: AGHT+IGXWvm0tYpsQUuwQFAaacstbh59eAuSi8HShuS1xlIPYXzeVr6Ko90ngJ4IPUc/WJt7FEw2Gw==
X-Received: by 2002:a05:600c:3b0d:b0:43d:7413:cb3e with SMTP id
 5b1f17b1804b1-4406ab7f548mr5341965e9.1.1744937471779; 
 Thu, 17 Apr 2025 17:51:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5ccd38sm2121845e9.28.2025.04.17.17.51.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 17 Apr 2025 17:51:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v2 02/11] qemu: Convert target_name() to TargetInfo API
Date: Fri, 18 Apr 2025 02:50:50 +0200
Message-ID: <20250418005059.4436-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418005059.4436-1-philmd@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_XBL=0.375, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 meson.build                     |  3 +++
 include/hw/core/cpu.h           |  2 --
 include/qemu/target_info-impl.h | 23 +++++++++++++++++++++++
 include/qemu/target_info.h      | 19 +++++++++++++++++++
 cpu-target.c                    |  5 -----
 hw/core/machine-qmp-cmds.c      |  1 +
 plugins/loader.c                |  2 +-
 system/vl.c                     |  2 +-
 target_info-stub.c              | 19 +++++++++++++++++++
 target_info.c                   | 16 ++++++++++++++++
 10 files changed, 83 insertions(+), 9 deletions(-)
 create mode 100644 include/qemu/target_info-impl.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 target_info-stub.c
 create mode 100644 target_info.c

diff --git a/meson.build b/meson.build
index bcb9d39a387..49a050a28a3 100644
--- a/meson.build
+++ b/meson.build
@@ -3807,6 +3807,9 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+common_ss.add(files('target_info.c'))
+specific_ss.add(files('target_info-stub.c'))
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
diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
new file mode 100644
index 00000000000..d5c94ed5296
--- /dev/null
+++ b/include/qemu/target_info-impl.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU binary/target API ...
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_IMPL_H
+#define QEMU_TARGET_INFO_IMPL_H
+
+#include "qemu/target_info.h"
+
+typedef struct TargetInfo {
+
+    /* runtime equivalent of TARGET_NAME definition */
+    const char *const name;
+
+} TargetInfo;
+
+const TargetInfo *target_info(void);
+
+#endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
new file mode 100644
index 00000000000..3f6cbbbd300
--- /dev/null
+++ b/include/qemu/target_info.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU binary/target API
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
index 408994b67d7..b317aec234f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,6 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/target_info.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/plugins/loader.c b/plugins/loader.c
index 7523d554f03..36a4e88d4db 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -29,7 +29,7 @@
 #include "qemu/xxhash.h"
 #include "qemu/plugin.h"
 #include "qemu/memalign.h"
-#include "hw/core/cpu.h"
+#include "qemu/target_info.h"
 #include "exec/tb-flush.h"
 
 #include "plugin.h"
diff --git a/system/vl.c b/system/vl.c
index c17945c4939..d8a0fe713c9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -40,6 +40,7 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
+#include "qemu/target_info.h"
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
diff --git a/target_info-stub.c b/target_info-stub.c
new file mode 100644
index 00000000000..1e44bb6f6fb
--- /dev/null
+++ b/target_info-stub.c
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
+#include "qemu/target_info-impl.h"
+
+static const TargetInfo target_info_stub = {
+    .name = TARGET_NAME,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_stub;
+}
diff --git a/target_info.c b/target_info.c
new file mode 100644
index 00000000000..877a6a15014
--- /dev/null
+++ b/target_info.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU binary/target helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "qemu/target_info.h"
+
+const char *target_name(void)
+{
+    return target_info()->name;
+}
-- 
2.47.1


