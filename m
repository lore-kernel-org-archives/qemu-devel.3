Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B0CC0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6uH-0002B2-Lh; Thu, 23 Jan 2025 18:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6td-0008V7-Bf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:46:05 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tX-0004Sx-Nx
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:58 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436341f575fso16147105e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675953; x=1738280753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MvtCakZyrGCXwv1NUluQigNUDDDoRJgD07DKcxozaAI=;
 b=YvKHHn5ZfVZi29RpK+uoYhF6jLID0zTCtwKGiGKjjeuMNTtCCATYrICRiEbjMD4Jea
 vikOePFYSrwXmYPlb6VhkIboq0NEwnopfaIC84G+s3ReY1Wbo9m65Tvlt6ECEziPIs7o
 KBtkRTJbFP6VDFBI+EtwJgfD2raK6F4bikwVHsDqPS5v9HLJx31oLBDkW+ywQLiEaxzz
 TjN9Unkng8pavhpSeBTWyRtsh6hDnGRGl66WHU1EDUvY6z8Hdw1JBzMoLIE3GdS04uVE
 dN9cGj7A7d4bo7rvXIIYP7IVytYQ6jiMPri/1//4xG1B39d3HKu/usgMzFXWsvlV+ArI
 YY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675953; x=1738280753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvtCakZyrGCXwv1NUluQigNUDDDoRJgD07DKcxozaAI=;
 b=P+koqzUU5MYRFHAZPk3vNAtrXJ5J14/0SPVSeVr915zqmjGy9zi+O4ZpAUUJ2DeF6u
 SNOoNe/0p2r7XI4r1SfiAbQCJKdmO6IGlguf79jTb0HRxwRranwR2d8Iqutq08izzUFX
 lr0XKN5u6LsO3Wcm1+/CwmAlqwTBJWpRAgcu/c/+ULtvgbjb6nVw0o1ispOV7QDuC5Ms
 B+sXWQ5Z0RDV81JOV0jHYrX/tg61VZWE2rIUtrVo27r+8e4gEDaON2bsX2mlaK8hYJ1k
 PTv+Nir2puWReNEplo/ePiFmq6l4Wy0yFEi1M34nkppehxzXmhfYmiuVIUD3zm16L9yq
 inXw==
X-Gm-Message-State: AOJu0YwxQs8fQIK72fT3G7pTHXV+x0n4X3omTFJn6wUQP6E9Gi5AMDDK
 PWcW0Ey29odt/oBKJ4P/ZovF1iDTmXGZ4mWNwkb4r2Pc++yEe0EzcnD5WapaHsO6TALiIm8ox0B
 mc8w=
X-Gm-Gg: ASbGncsMTp3nWy45Ou8FI9SMsrbr3SvLKbdn2Jvfl8klAdpXDeVW4s/LQmQqIGFD4Su
 ZZCV9rMh5pgV8THfIJdx4n46NLHB1zZMb4kc3WXwngXZfUcj6OG7mfOU9odIGwPkPjd+CdsPa13
 3p4t+qnhQR8hLHUBEq3/CcEm93vP1QjmqZ36SehZpyu43+xYDzetZLLm5RFLTGaJ9q9Rx937WxZ
 dArB09aUL8GJslcwEJoooxRdT15f0mlv4UVtNi8kBBPkRveMgkR9oqM69loTygPOYHIDKJXApJk
 m39XfO3b8h2cZvxzdFqPHRYUVhr1LPDuvLPxru+BgUNbxDSKgjFZzos=
X-Google-Smtp-Source: AGHT+IESHbhLNhi6WI+MIsv7kwcNIGaQJ9dXLlWxoyCR3XibduHPGVHiP0CzOiY9OItw0/7PMnFvyA==
X-Received: by 2002:a05:600c:1987:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-438913f2f4emr282730315e9.17.1737675953608; 
 Thu, 23 Jan 2025 15:45:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd43cdbbsm7488805e9.0.2025.01.23.15.45.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/20] cpus: Have cpu_class_init_props() per user / system
 emulation
Date: Fri, 24 Jan 2025 00:44:11 +0100
Message-ID: <20250123234415.59850-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 cpu-target.c         | 58 --------------------------------------------
 hw/core/cpu-system.c | 40 ++++++++++++++++++++++++++++++
 hw/core/cpu-user.c   | 27 +++++++++++++++++++++
 hw/core/meson.build  |  5 +++-
 4 files changed, 71 insertions(+), 59 deletions(-)
 create mode 100644 hw/core/cpu-user.c

diff --git a/cpu-target.c b/cpu-target.c
index c05ef1ff096..dff8c0747f9 100644
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
@@ -179,61 +176,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
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
index 6aae28a349a..c63c984a803 100644
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
@@ -142,3 +145,40 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
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


