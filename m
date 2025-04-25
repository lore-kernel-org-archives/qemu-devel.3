Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1E4C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L3z-0004WN-QK; Fri, 25 Apr 2025 11:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3V-00035t-1M
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:36 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L3S-0004Lm-AV
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:33:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so1851879f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595208; x=1746200008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vgi3F/XiUjNgUT62Bho6JGcvUTnUJjVfW1I8RmJHA1w=;
 b=Pn0wRUxFfi6+OFZfzh7coD9g7MYdm+IIKasa1VjWHYkyN6+cFxbdar+Vt93D8s88LL
 jG5eKiyKBIPrYuH0hpzGRl8zSNeVFuiWcbaelqpZSVtkBv/0uRmxB4+AHnRZcwiU9CuQ
 m1n8gZuuEiyr0ClN52iJ2znaFuyhzj6nvd6yheyzf7mxshvvw4FiIU7z1lZTPheowu/O
 bu86K/ZyLs+ZG0jmdSBhLJ+zR5aX6bOsMsrWqIceA4zULuyWfOMxJAdM425HvGhuxNOr
 YOfMmkxN96euqM3xscHhY+9fsMunu1l+t+s1j48J8ySpIGUE5CGLwG+RRwFWc4jVYPCl
 dfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595208; x=1746200008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vgi3F/XiUjNgUT62Bho6JGcvUTnUJjVfW1I8RmJHA1w=;
 b=fKQ1+qUqa1dt3XsK12noIl3cjWiRO/8z9X2JQwFlND0mVZHINjp7kTxkhro2+nlBPr
 zRC9q/tH8xibNhL9N7mEX7E9G6heLM3ygeaAXY9eaod1G/Q9cNEZWhspJeMOHwJ7lKTk
 h6YFMdL5jD/PkltSY6HcUcFmgR0t+bBu7kbbGQMCoXYN6UwOyk09/5ogi/2AbxzNGWqA
 blnArTRGgx5ibCP4Jike/fZGZToWN4o8GqhiM+PI7Bkd82wOVKJjjUEwWyamozXtMJ2Q
 sCmWnKI6N8czDlG2D93ExdX3mglGWriKjTbtTQ386jyxBHvt8lErtXNLSoR15dY8rRpb
 4kVg==
X-Gm-Message-State: AOJu0Yx/9ay6tHTWXHJDf+BVZEHKGspKlrpZisKdet3ie1TcZTnJ06gL
 YmD2+sJqT+A2jUbHzTYVbfGyHs6jAIkEZ7Jqoe0oi+t9QyjNdBas0mjvWzwfli/NfOc0ykGnOBv
 e
X-Gm-Gg: ASbGncu+aWxCQhyjnk01SBNQr2338nLvU/QC3z9i3Q4tgna1QuCXVCZOMnnzP7SV2tL
 jlDvDbN7sjc3MF6bbJQEjelI7tZPbAOljyh2pfD5aFHleKTT3ALowGRXU2w3osQTanvA/hPGvgF
 M6a2/WLCozjvByO1biRgR+dJOIibTQogMJdP9eXCiyYKtKoGz2YE3onM8qNhPqh4flF/NEnoBDv
 NcR2Po9x6K+0byQvKoBL/V5wcJWrs7122NmDXitcUwW7rzFYC29jozWIVb8JY8bqfEHoWfNmRdk
 22e6eV4QprV7tvqz0GtPkaDmZjQfqzIXZ4LM4fhipsYoT/G+JZx+9EF46GO1nfuU7xddp3OQa7b
 O7rYwslQ6YnS6AEg=
X-Google-Smtp-Source: AGHT+IFBc94vpB3MaDkk8/1D6VMJmL6HT5UzfUondmYa3qCYLuPsyAxyF012RKzK1qDgrLinWmPZJQ==
X-Received: by 2002:a5d:6da5:0:b0:39e:cbd2:986b with SMTP id
 ffacd0b85a97d-3a074e14164mr2735884f8f.7.1745595208416; 
 Fri, 25 Apr 2025 08:33:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5d9f6sm2713255f8f.91.2025.04.25.08.33.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:33:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 58/58] qemu: Convert target_name() to TargetInfo API
Date: Fri, 25 Apr 2025 17:28:42 +0200
Message-ID: <20250425152843.69638-59-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
Message-Id: <20250424222112.36194-3-philmd@linaro.org>
---
 MAINTAINERS                     |  9 +++++++--
 meson.build                     |  1 +
 include/hw/core/cpu.h           |  2 --
 include/qemu/target-info-impl.h | 26 ++++++++++++++++++++++++++
 include/qemu/target-info.h      |  7 +++++++
 cpu-target.c                    |  5 -----
 hw/core/machine-qmp-cmds.c      |  1 +
 plugins/loader.c                |  2 +-
 system/vl.c                     |  2 +-
 target-info-stub.c              | 10 ++++++++++
 target-info.c                   | 16 ++++++++++++++++
 11 files changed, 70 insertions(+), 11 deletions(-)
 create mode 100644 include/qemu/target-info-impl.h
 create mode 100644 target-info.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 59d97128199..f8fee87c704 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -496,7 +496,6 @@ F: include/exec/cpu*.h
 F: include/exec/exec-all.h
 F: include/exec/target_long.h
 F: include/qemu/accel.h
-F: include/qemu/target-info*.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
 F: include/accel/accel-cpu*.h
@@ -505,7 +504,6 @@ F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
 F: cpu-common.c
 F: cpu-target.c
-F: target-info*.c
 F: system/cpus.c
 
 Apple Silicon HVF CPUs
@@ -1928,6 +1926,13 @@ F: tests/functional/test_empty_cpu_model.py
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
index 185c2fb0d1b..8ae70dbe45a 100644
--- a/meson.build
+++ b/meson.build
@@ -3795,6 +3795,7 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+common_ss.add(files('target-info.c'))
 specific_ss.add(files('target-info-stub.c'))
 
 subdir('backends')
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 2a02d4f0789..12b2ff1f7d2 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1121,8 +1121,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
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
index b4cc4888cac..58d41368974 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -9,6 +9,13 @@
 #ifndef QEMU_TARGET_INFO_H
 #define QEMU_TARGET_INFO_H
 
+/**
+ * target_name:
+ *
+ * Returns: Canonical target name (i.e. "i386").
+ */
+const char *target_name(void);
+
 /**
  * target_cpu_type:
  *
diff --git a/cpu-target.c b/cpu-target.c
index b5645ff0dbb..1c90a307593 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -91,8 +91,3 @@ bool target_big_endian(void)
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
index 4ab2001df75..520956f4a19 100644
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
index e5d2195e896..773a10188c8 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -8,8 +8,18 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target-info.h"
+#include "qemu/target-info-impl.h"
 #include "cpu.h"
 
+static const TargetInfo target_info_stub = {
+    .target_name = TARGET_NAME,
+};
+
+const TargetInfo *target_info(void)
+{
+    return &target_info_stub;
+}
+
 const char *target_cpu_type(void)
 {
     return CPU_RESOLVING_TYPE;
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


