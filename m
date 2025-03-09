Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B02C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpL-0005Bv-4y; Sun, 09 Mar 2025 13:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpJ-0005BV-FW
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpH-0004pY-B3
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so360745e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542753; x=1742147553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QQMXAv5xvYvddKVDqqWSooantykqUZCrwTUpETmsqTQ=;
 b=Ri6BuPzrqyGI/zrtBYx8RGWD7PWZOnbcQTdP27z937dtE+mN6hQjvuF9kpuFLhzdFC
 02NyH6CZF3qxdO+XdIHdm1fRie6VgE8VqSykWxs4vWHPgCklo+9ro3haUPkwCD3JQ83Y
 lfycOBmBrlsl2Kn+E4pJzJ5k5zKT56hAnOnC1wCvB/gPpiGIaXNXvYj+NTMrNmCGYgtI
 yCmQRaZ5ZrMritCZsDJsY+zTcG7kAeEJaIkdMeT2mH8FAe4VXR9XY6pojZjxyfNh4OYs
 sL0jsG9G6zGjcZrzgmbrwa/UO8PUBien+tyYxGq53aHzb/iN/Es4S1dzhABzreTTR5df
 vnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542753; x=1742147553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QQMXAv5xvYvddKVDqqWSooantykqUZCrwTUpETmsqTQ=;
 b=AAYQEQSrROyniYlnyNxfwgQg5prILdf06DAJ5C37COQ1aQE56EpIFPZOjjhI6Z9KFN
 vBGkpuloqjDaLoPrHGSqQ/a3hKPyneD7ZAFc5vgBOg4wh+ZWh+/A/CpTwd2klWf+Bts7
 c1IZ0YOw3irJGe0B8knw5tmGlWmIii/HCGbth/OchfNKj9UshL66Dsvaiq8r89Glv7XP
 ezBdfJtlcjQo/ZGiKoaD0H4wJPkP5iD4ot/Q4NAB0/rKeQ4ifa304Mh0fWCXXgeTqZIz
 D2R+aGBcdIkXYPmXi/lmcA7rpQeewsq+gtUF0DU/ftjl2Jt2+41x/0ko0k3bRbMrUrJo
 9etA==
X-Gm-Message-State: AOJu0YyikHfb6VKQk+zWP9c/HDEhnTAhmeCFXYisyR4783m4IrQd0xaM
 lZUW8ri25zes5+CsAYNokv0u3VXzUaiq1sbiRwNFdDDg7k0bHBMhxeVpubuDkSbc/bWfWMwABVs
 XyJ8=
X-Gm-Gg: ASbGnctL+T+ic9KUBXfKQzY4OIEW09fZtpy0NeUJMl4Nk1+CkEaz5V19Z7vpV+osmQX
 n4Ez5CwEIYf5grVq4kyRgEVQQWXcUtYyrzrQ85Yjd5Kpy+8u56SBP5OCp0BKxVd/XFVVltAbkQg
 OIBYOhD13evb+K4C07IGK3GBGXyNOxFx+cWIwn6N1jvnrR2JBSFBFg1zVu4VRxn6qHu/XH4Q/nZ
 KQ/GsUxc1ew+ibeXIqqpF7ikeD4MX4zdTBEjty7HJQdEP7n0Kf5lTfYagnfTtu8G+rbgHBINkD4
 V5LDl2PJyZf6Tl1GRJZSoBLIzi7nzN5fZnMzKGGNFj84GsmNam+/31QVzPyUjhI1akfVy76Y/FO
 RJXInBPzlI9v17enu15c=
X-Google-Smtp-Source: AGHT+IFBQ2PzvPYM30ir5SMDietqS1NgRZHrfcxQshuaH4Sc4c6Lx+LC+3/Mvs5tYJvqne0Sr1eOfw==
X-Received: by 2002:a05:600c:1f92:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-43ce4dcf8e4mr32496245e9.12.1741542753119; 
 Sun, 09 Mar 2025 10:52:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c588dsm147408655e9.21.2025.03.09.10.52.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/38] cpus: Register VMState per user / system emulation
Date: Sun,  9 Mar 2025 18:51:34 +0100
Message-ID: <20250309175207.43828-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Simplify cpu-target.c by extracting mixed vmstate code
into the cpu_vmstate_register() / cpu_vmstate_unregister()
helpers, implemented in cpu-user.c and cpu-system.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-20-philmd@linaro.org>
---
 include/hw/core/cpu.h |   2 +
 cpu-target.c          | 121 +-----------------------------------------
 hw/core/cpu-system.c  | 115 +++++++++++++++++++++++++++++++++++++++
 hw/core/cpu-user.c    |  12 +++++
 4 files changed, 131 insertions(+), 119 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 9dd6ac7c763..bc0c9468344 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1165,6 +1165,8 @@ G_NORETURN void cpu_abort(CPUState *cpu, const char *fmt, ...)
 /* $(top_srcdir)/cpu.c */
 void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_initfn(CPUState *cpu);
+void cpu_vmstate_register(CPUState *cpu);
+void cpu_vmstate_unregister(CPUState *cpu);
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
diff --git a/cpu-target.c b/cpu-target.c
index b6e66d5ac02..bc9c537c575 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -21,115 +21,17 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
-#include "migration/vmstate.h"
-#ifndef CONFIG_USER_ONLY
-#include "hw/core/sysemu-cpu-ops.h"
-#endif
 #include "system/accel-ops.h"
 #include "system/cpus.h"
-#include "system/tcg.h"
 #include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
-#include "exec/cputlb.h"
-#include "exec/exec-all.h"
-#include "exec/tb-flush.h"
 #include "exec/log.h"
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 #include "hw/core/cpu.h"
 
-#ifndef CONFIG_USER_ONLY
-static int cpu_common_post_load(void *opaque, int version_id)
-{
-    if (tcg_enabled()) {
-        CPUState *cpu = opaque;
-
-        /*
-         * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
-         * version_id is increased.
-         */
-        cpu->interrupt_request &= ~0x01;
-
-        tlb_flush(cpu);
-
-        /*
-         * loadvm has just updated the content of RAM, bypassing the
-         * usual mechanisms that ensure we flush TBs for writes to
-         * memory we've translated code from. So we must flush all TBs,
-         * which will now be stale.
-         */
-        tb_flush(cpu);
-    }
-
-    return 0;
-}
-
-static int cpu_common_pre_load(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    cpu->exception_index = -1;
-
-    return 0;
-}
-
-static bool cpu_common_exception_index_needed(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    return tcg_enabled() && cpu->exception_index != -1;
-}
-
-static const VMStateDescription vmstate_cpu_common_exception_index = {
-    .name = "cpu_common/exception_index",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = cpu_common_exception_index_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_INT32(exception_index, CPUState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static bool cpu_common_crash_occurred_needed(void *opaque)
-{
-    CPUState *cpu = opaque;
-
-    return cpu->crash_occurred;
-}
-
-static const VMStateDescription vmstate_cpu_common_crash_occurred = {
-    .name = "cpu_common/crash_occurred",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .needed = cpu_common_crash_occurred_needed,
-    .fields = (const VMStateField[]) {
-        VMSTATE_BOOL(crash_occurred, CPUState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-const VMStateDescription vmstate_cpu_common = {
-    .name = "cpu_common",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .pre_load = cpu_common_pre_load,
-    .post_load = cpu_common_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(halted, CPUState),
-        VMSTATE_UINT32(interrupt_request, CPUState),
-        VMSTATE_END_OF_LIST()
-    },
-    .subsections = (const VMStateDescription * const []) {
-        &vmstate_cpu_common_exception_index,
-        &vmstate_cpu_common_crash_occurred,
-        NULL
-    }
-};
-#endif
-
 bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
 {
     if (!accel_cpu_common_realize(cpu, errp)) {
@@ -139,33 +41,14 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
-#ifdef CONFIG_USER_ONLY
-    assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
-           qdev_get_vmsd(DEVICE(cpu))->unmigratable);
-#else
-    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-        vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
-    }
-    if (cpu->cc->sysemu_ops->legacy_vmsd != NULL) {
-        vmstate_register(NULL, cpu->cpu_index, cpu->cc->sysemu_ops->legacy_vmsd, cpu);
-    }
-#endif /* CONFIG_USER_ONLY */
+    cpu_vmstate_register(cpu);
 
     return true;
 }
 
 void cpu_exec_unrealizefn(CPUState *cpu)
 {
-#ifndef CONFIG_USER_ONLY
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->legacy_vmsd != NULL) {
-        vmstate_unregister(NULL, cc->sysemu_ops->legacy_vmsd, cpu);
-    }
-    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
-        vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
-    }
-#endif
+    cpu_vmstate_unregister(cpu);
 
     cpu_list_remove(cpu);
     /*
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index e511507e13b..6c89d76e498 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -21,11 +21,15 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
+#include "exec/cputlb.h"
 #include "exec/memory.h"
+#include "exec/tb-flush.h"
 #include "exec/tswap.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/sysemu-cpu-ops.h"
+#include "migration/vmstate.h"
+#include "system/tcg.h"
 
 bool cpu_paging_enabled(const CPUState *cpu)
 {
@@ -194,3 +198,114 @@ void cpu_exec_initfn(CPUState *cpu)
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
 }
+
+static int cpu_common_post_load(void *opaque, int version_id)
+{
+    if (tcg_enabled()) {
+        CPUState *cpu = opaque;
+
+        /*
+         * 0x01 was CPU_INTERRUPT_EXIT. This line can be removed when the
+         * version_id is increased.
+         */
+        cpu->interrupt_request &= ~0x01;
+
+        tlb_flush(cpu);
+
+        /*
+         * loadvm has just updated the content of RAM, bypassing the
+         * usual mechanisms that ensure we flush TBs for writes to
+         * memory we've translated code from. So we must flush all TBs,
+         * which will now be stale.
+         */
+        tb_flush(cpu);
+    }
+
+    return 0;
+}
+
+static int cpu_common_pre_load(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    cpu->exception_index = -1;
+
+    return 0;
+}
+
+static bool cpu_common_exception_index_needed(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    return tcg_enabled() && cpu->exception_index != -1;
+}
+
+static const VMStateDescription vmstate_cpu_common_exception_index = {
+    .name = "cpu_common/exception_index",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_common_exception_index_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_INT32(exception_index, CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static bool cpu_common_crash_occurred_needed(void *opaque)
+{
+    CPUState *cpu = opaque;
+
+    return cpu->crash_occurred;
+}
+
+static const VMStateDescription vmstate_cpu_common_crash_occurred = {
+    .name = "cpu_common/crash_occurred",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = cpu_common_crash_occurred_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(crash_occurred, CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+const VMStateDescription vmstate_cpu_common = {
+    .name = "cpu_common",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = cpu_common_pre_load,
+    .post_load = cpu_common_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(halted, CPUState),
+        VMSTATE_UINT32(interrupt_request, CPUState),
+        VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_cpu_common_exception_index,
+        &vmstate_cpu_common_crash_occurred,
+        NULL
+    }
+};
+
+void cpu_vmstate_register(CPUState *cpu)
+{
+    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
+        vmstate_register(NULL, cpu->cpu_index, &vmstate_cpu_common, cpu);
+    }
+    if (cpu->cc->sysemu_ops->legacy_vmsd != NULL) {
+        vmstate_register(NULL, cpu->cpu_index,
+                         cpu->cc->sysemu_ops->legacy_vmsd, cpu);
+    }
+}
+
+void cpu_vmstate_unregister(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->sysemu_ops->legacy_vmsd != NULL) {
+        vmstate_unregister(NULL, cc->sysemu_ops->legacy_vmsd, cpu);
+    }
+    if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
+        vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
+    }
+}
diff --git a/hw/core/cpu-user.c b/hw/core/cpu-user.c
index cdd8de2fefa..1892acdee0f 100644
--- a/hw/core/cpu-user.c
+++ b/hw/core/cpu-user.c
@@ -10,6 +10,7 @@
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
+#include "migration/vmstate.h"
 
 static const Property cpu_user_props[] = {
     /*
@@ -30,3 +31,14 @@ void cpu_exec_initfn(CPUState *cpu)
 {
     /* nothing to do */
 }
+
+void cpu_vmstate_register(CPUState *cpu)
+{
+    assert(qdev_get_vmsd(DEVICE(cpu)) == NULL ||
+           qdev_get_vmsd(DEVICE(cpu))->unmigratable);
+}
+
+void cpu_vmstate_unregister(CPUState *cpu)
+{
+    /* nothing to do */
+}
-- 
2.47.1


