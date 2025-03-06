Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4291C28B24
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTi-0000sx-O4; Thu, 06 Mar 2025 10:49:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTN-0000OE-J4
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:28 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTL-0006N8-6K
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so9728715e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276157; x=1741880957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X8Saq/dqG9xCUSyrkXOExGdZvozj3jjUcX+27h5Z2go=;
 b=bP07UptFVuMFyGaSNuiW6PlW/YCahiaEZYQQZkqa+O0zOrVYTXcIOuAgCjwEpC1Xm9
 WD9fs14yJr9bZg7Sv5cI+wmAQ8Me7MDuVxibFqaACPWIbEA4Bxig1ERBiIWZR20BTXwN
 lV5VTSuRFKMawHd0BCTHQNiRex9ihjy5xCg94SwOxsxR4Aifhj86Z1U2/qjXtZZkYPUU
 o4SSjyrZ0tJwLIWSxoJ3UYDpb/LMXdrRjeA1GihHbIpzqNtwdM2EJPmTQOy/GjJChh6c
 +stYeCNZ8VcR5MJbxz4jGaXHhclwqahyDc3CaPyCOZEB5uLRRxZw3UF4w8glQVE83XPJ
 pgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276157; x=1741880957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X8Saq/dqG9xCUSyrkXOExGdZvozj3jjUcX+27h5Z2go=;
 b=dkVmuxXIQPFaN9XWsMMIZeWwz1q+cjg/WmgDHucYyvtCQAF+hQzyVguaVQGsycMkv3
 yYJI9bOIfjOtzLChgCOYCHsbdFfULwKKOs9rOipUbRCZy9Y1ycITO/h3qAOmLBjiMZWL
 pH6YFYkMP22VU88tawNxluLgUIZDx4CKfLvuIhYLCvx2D7vlbz9yBeVH2vQ7/jNUcHq0
 i5+K3ukmT+zoUXuojP7t22r+Q7sDsjJEl8nRm7dPvV2vu+kj1/C+hJjvXfp8lBUART1M
 vZDlNDfqWTe6qucnxcypgAq9dFbsnsyQFWSgq8VtNyt0YrUFroJqQndcqvCkDhbGiyl6
 AwOg==
X-Gm-Message-State: AOJu0YyOBywk6VarU1Sy2xHWbl4ax3acmE7I0PDiINwvQO0g7q1b+14z
 S6Kxkerjx/uAV41emZjAVcgMZCvd6g5AjMKvoDjGnn2hDfDCtWIVb44Mcpj4g+ZK6CK2nGG/GVU
 jpyg=
X-Gm-Gg: ASbGncuXpyj4+oKtm44N7/GGtyRsxYlPhmCRobRLmYQEZ7RIdx3jUZLpQFZzKovKXld
 cr/vAmuNht9p0kWiPqpwTJJxKadzpR5yFVf3SSctPcIBZWW+VKI6DU4HxlVNfoTuPnMcl+w+oMN
 9xfC46mJzJ/XDotDYu0Fk+5hQ43cLjBHzv67xnMXQvHPXsZxom9np9G+lW8QvxIDbZDcGUIh0SY
 QI1RHH7pxTa8+Y00x85JPxtlcMnLLt0BI0UDTL/v9I3bdnmcD+6g+Np+w9DHtUnTjKClb+68p76
 rGGVqCd5E+Qq4uRqQlxk5hoyv4lEtMpl2XVkAiFZ7BLIpQpMFhuXe6tId5fRdwDcvkzGcT9Xr3b
 y6SqLwkg9seXJh0zM9rQ=
X-Google-Smtp-Source: AGHT+IH9wdlnQxq7wbRbJX92lGMVU192CqrT8ag1QqbhsaemZW0TIgoFgjujrUxua/iPI+Ra+Q4miA==
X-Received: by 2002:a05:6000:4109:b0:391:2c67:7999 with SMTP id
 ffacd0b85a97d-3912c677bdfmr3208820f8f.48.1741276157402; 
 Thu, 06 Mar 2025 07:49:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e2f39sm2374704f8f.80.2025.03.06.07.49.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/54] cpus: Have cpu_class_init_props() per user / system
 emulation
Date: Thu,  6 Mar 2025 16:47:04 +0100
Message-ID: <20250306154737.70886-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Rather than maintaining a mix of system / user code for CPU
class properties, move system properties to cpu-system.c
and user ones to the new cpu-user.c unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-18-philmd@linaro.org>
---
 MAINTAINERS          |  1 +
 cpu-target.c         | 58 --------------------------------------------
 hw/core/cpu-system.c | 40 ++++++++++++++++++++++++++++++
 hw/core/cpu-user.c   | 27 +++++++++++++++++++++
 hw/core/meson.build  |  5 +++-
 5 files changed, 72 insertions(+), 59 deletions(-)
 create mode 100644 hw/core/cpu-user.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a0e462d03ca..1d1fadc3bc9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3791,6 +3791,7 @@ Overall usermode emulation
 M: Riku Voipio <riku.voipio@iki.fi>
 S: Maintained
 F: accel/tcg/user-exec*.c
+F: hw/core/cpu-user.c
 F: include/user/
 F: common-user/
 
diff --git a/cpu-target.c b/cpu-target.c
index 48446c90212..f4c834fd26a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,15 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-core.h"
-#include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "migration/vmstate.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/core/sysemu-cpu-ops.h"
 #include "exec/address-spaces.h"
-#include "exec/memory.h"
 #endif
 #include "system/accel-ops.h"
 #include "system/cpus.h"
@@ -178,61 +175,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     accel_cpu_common_unrealize(cpu);
 }
 
-/*
- * This can't go in hw/core/cpu.c because that file is compiled only
- * once for both user-mode and system builds.
- */
-static const Property cpu_common_props[] = {
-#ifdef CONFIG_USER_ONLY
-    /*
-     * Create a property for the user-only object, so users can
-     * adjust prctl(PR_SET_UNALIGN) from the command-line.
-     * Has no effect if the target does not support the feature.
-     */
-    DEFINE_PROP_BOOL("prctl-unalign-sigbus", CPUState,
-                     prctl_unalign_sigbus, false),
-#else
-    /*
-     * Create a memory property for system CPU object, so users can
-     * wire up its memory.  The default if no link is set up is to use
-     * the system address space.
-     */
-    DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
-#endif
-};
-
-#ifndef CONFIG_USER_ONLY
-static bool cpu_get_start_powered_off(Object *obj, Error **errp)
-{
-    CPUState *cpu = CPU(obj);
-    return cpu->start_powered_off;
-}
-
-static void cpu_set_start_powered_off(Object *obj, bool value, Error **errp)
-{
-    CPUState *cpu = CPU(obj);
-    cpu->start_powered_off = value;
-}
-#endif
-
-void cpu_class_init_props(DeviceClass *dc)
-{
-#ifndef CONFIG_USER_ONLY
-    ObjectClass *oc = OBJECT_CLASS(dc);
-
-    /*
-     * We can't use DEFINE_PROP_BOOL in the Property array for this
-     * property, because we want this to be settable after realize.
-     */
-    object_class_property_add_bool(oc, "start-powered-off",
-                                   cpu_get_start_powered_off,
-                                   cpu_set_start_powered_off);
-#endif
-
-    device_class_set_props(dc, cpu_common_props);
-}
-
 void cpu_exec_initfn(CPUState *cpu)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 6e307c89597..1310b4203fd 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -20,7 +20,10 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/memory.h"
 #include "exec/tswap.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
 bool cpu_paging_enabled(const CPUState *cpu)
@@ -147,3 +150,40 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
     }
     return res;
 }
+
+static const Property cpu_system_props[] = {
+    /*
+     * Create a memory property for system CPU object, so users can
+     * wire up its memory.  The default if no link is set up is to use
+     * the system address space.
+     */
+    DEFINE_PROP_LINK("memory", CPUState, memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static bool cpu_get_start_powered_off(Object *obj, Error **errp)
+{
+    CPUState *cpu = CPU(obj);
+    return cpu->start_powered_off;
+}
+
+static void cpu_set_start_powered_off(Object *obj, bool value, Error **errp)
+{
+    CPUState *cpu = CPU(obj);
+    cpu->start_powered_off = value;
+}
+
+void cpu_class_init_props(DeviceClass *dc)
+{
+    ObjectClass *oc = OBJECT_CLASS(dc);
+
+    /*
+     * We can't use DEFINE_PROP_BOOL in the Property array for this
+     * property, because we want this to be settable after realize.
+     */
+    object_class_property_add_bool(oc, "start-powered-off",
+                                   cpu_get_start_powered_off,
+                                   cpu_set_start_powered_off);
+
+    device_class_set_props(dc, cpu_system_props);
+}
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
new file mode 100644
index 00000000000..e5ccf6bf13a
--- /dev/null
+++ b/hw/core/cpu-user.c
@@ -0,0 +1,27 @@
+/*
+ * QEMU CPU model (user specific)
+ *
+ * Copyright (c) Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/core/cpu.h"
+
+static const Property cpu_user_props[] = {
+    /*
+     * Create a property for the user-only object, so users can
+     * adjust prctl(PR_SET_UNALIGN) from the command-line.
+     * Has no effect if the target does not support the feature.
+     */
+    DEFINE_PROP_BOOL("prctl-unalign-sigbus", CPUState,
+                     prctl_unalign_sigbus, false),
+};
+
+void cpu_class_init_props(DeviceClass *dc)
+{
+    device_class_set_props(dc, cpu_user_props);
+}
diff --git a/hw/core/meson.build b/hw/core/meson.build
index 65a1698ed1f..b5a545a0edd 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -46,4 +46,7 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-user_ss.add(files('qdev-user.c'))
+user_ss.add(files(
+  'cpu-user.c',
+  'qdev-user.c',
+))
-- 
2.47.1


