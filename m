Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB514C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:55:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F1t-0006nC-D6; Tue, 22 Apr 2025 10:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1q-0006mt-Eu
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:18 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F1o-0005Az-4p
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:55:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ee5ac4321so5653963f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333714; x=1745938514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RyJ6wMig2dFnUaLZ2DU4/UiCbn+0wTktCowVmGSdV8Y=;
 b=Q7I7UhlQrc33aUN45Q5XgRsfwrb1XjRgQ2k5/YnV3RmDMMZtvrxvOJoBOugwSsQicm
 Iu+GbdxcZGL319hxULTfuf1O9GuCDksoN5MKpGCjfzK5nmlR0G7MFlj8gIwmQFzB3ldW
 VJl5GAgvLP3IDCmncyl30qbXTGzJrDpuPCO+ecrnaigoPOBvRZ9pYeLujMViS4e/A/HL
 r+uWYmFut0zm6th5+Z9aUmyGfdWW/4Xfo/fkQoP1agXDgo7vlB5POgHxlPXbHyv7RGEE
 Psbn9eTwQgfV/d7Nx2otsK2+qLG4yDYdVDxH++ngjoy+YCGe1uwNO5C+UGhWZUPsSY3V
 TfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333714; x=1745938514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RyJ6wMig2dFnUaLZ2DU4/UiCbn+0wTktCowVmGSdV8Y=;
 b=siesV9xFVMxqz2AG42/kkiJpbmhtisYWlAnkwn7FBVy1Sv1go5WWpsMoVXstDe4a9p
 c7ON4ZwIh9FrTQlTNQypSU7UjzBY6hzhdupRtQcIPEcYX0QeiGHeUpiafYHF+TdwTuKs
 oHViuhcmL+km61q0D4pP/jF4kTHWVEe9qO2w3+PfdcttVQ0dEWpzhG4DptMTSBnVqC6s
 Huna1TatjZpepYw9ra3q6rXEAzhAzzgV3RRVfdfh7irf+cj5xDHYQ4dg/cXvXXk3byEl
 yAKupmVu1F2xdrL2e43sgK5s6RoUdvcagX4fI2ltfwxPT2vY6cmanEG6g35ICH0qtEiu
 thcg==
X-Gm-Message-State: AOJu0Yw6hlW5FkdwMRgWkqbxWkh+yUbWUF8DIvKIMUnQZaBWH6ysN1PG
 cF7suL9Hub1O3KENKakHUT7+HOevQT2oyHmHFzJOIAk8EOf0Xvg2it2++V7XXNxEOb5A80gojWs
 b
X-Gm-Gg: ASbGnctWC4E10l/TE2ooI96HUqPrl89ZXgc4jN0ClGTTK42pD5mOTPflaV0LSlpoeCR
 +bGre1KyXdexdJBbg5M4TIB4kTi4M5ZRvPSterFmdvUMRILe5Qo81UBeEWI4fJrX3Glc7FC3qex
 +wRcbHSVNBHJlK5X7JTUOYrgmPEdAmFXfJg8pEQKmWnzTRzNNBX1xBzF+JsKqdJXhRLEnUxZDzn
 GJ3UnAjpjxRz4kFbFooKj8jPAHmHZn8Mo86LfNZHnDdD+0UYvylkNWnxJ5c7q5YqUZmJaIvyjub
 JmwIwza/HGWELoNmuPXdRg48BmyfcTyjFWkufothsOosfia0N6ijamomJ/CyiOkqW5/jTXHhIha
 0NyzAB6lEF59J9PH6AlMNt4QJYA==
X-Google-Smtp-Source: AGHT+IEdjg36k5T2BY/GqmJxWB0tcWs1doKpgOoTW7fPMrGVUSL4ZsQzm+vh+dAh17UUK5fIkrNLfA==
X-Received: by 2002:a05:6000:188d:b0:391:3d12:9afa with SMTP id
 ffacd0b85a97d-39efba46487mr13215975f8f.21.1745333712898; 
 Tue, 22 Apr 2025 07:55:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4be2sm15260364f8f.83.2025.04.22.07.55.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:55:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 02/19] qemu: Convert target_name() to TargetInfo API
Date: Tue, 22 Apr 2025 16:54:44 +0200
Message-ID: <20250422145502.70770-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
---
 MAINTAINERS                     |  7 +++++++
 meson.build                     |  3 +++
 include/hw/core/cpu.h           |  2 --
 include/qemu/target-info-impl.h | 28 ++++++++++++++++++++++++++++
 include/qemu/target-info.h      | 19 +++++++++++++++++++
 cpu-target.c                    |  5 -----
 hw/core/machine-qmp-cmds.c      |  1 +
 plugins/loader.c                |  2 +-
 system/vl.c                     |  2 +-
 target-info-stub.c              | 19 +++++++++++++++++++
 target-info.c                   | 16 ++++++++++++++++
 11 files changed, 95 insertions(+), 9 deletions(-)
 create mode 100644 include/qemu/target-info-impl.h
 create mode 100644 include/qemu/target-info.h
 create mode 100644 target-info-stub.c
 create mode 100644 target-info.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c7083ab1d93..a055f67b5fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1913,6 +1913,13 @@ F: tests/functional/test_empty_cpu_model.py
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
index bcb9d39a387..09b16e2f7ae 100644
--- a/meson.build
+++ b/meson.build
@@ -3807,6 +3807,9 @@ endif
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
index 00000000000..c276b84ceca
--- /dev/null
+++ b/include/qemu/target-info-impl.h
@@ -0,0 +1,28 @@
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
+
+    /* runtime equivalent of TARGET_NAME definition */
+    const char *const target_name;
+
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
index 0e9ca1b90e2..529ce8dd9a0 100644
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
index 7523d554f03..ccde83414d6 100644
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


