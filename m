Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1860C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublsh-0007iv-4D; Tue, 15 Jul 2025 16:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbK-00039m-Ds
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbG-0002io-Gh
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:04 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so3333110f8f.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608761; x=1753213561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJSJKfpTNzHi1jnqzNrlZAkGPIYhBAycDFjBaXl6h9M=;
 b=BMb3UOuEMQNxrZzURfbigKsgjn0oFFJqpmZGogbO9t/KQT1aa/B1NeIztWJcd6FKha
 Y1PtP19q5+DEuTSs+bPhbV9iLgzlfUTKKrov8nq+piC6u+2jABj/vp9BspJFkplwiQdz
 v1nTJH6M8iQIhPltOCPgHSn5E1RPKGyTzuM2RLNKzkDmxVHp4mzzxiaBN1cZXYWYTgGn
 8VuUIMhESuPFAWLQLyu6WN5HAQFPOESMPv055pB3S1jcJa5wCEio+52WjerGzWnU0Sm4
 DOVw/YkJmQM7d0MwY+sv6RQfBld60a4FhwpoluacvmF92favyyAXPz1ztv+5wWHO1bYG
 PNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608761; x=1753213561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJSJKfpTNzHi1jnqzNrlZAkGPIYhBAycDFjBaXl6h9M=;
 b=pv4vJraTxCgCh8czEJrGiY57KajbTUSIutzp3Wt0ChfklBpggyligyH7EEMhvsI8gK
 DS7kFr8T4rmKqyUhrj2zCiPpT7LiM8XjQG41AW4CJMb1TNra6HrGe1AGlesmP+NsS74w
 tMeb/m1MONmFiOWCJJx5kdDeowi+Ab15RaKak4+a2BR2dQa82njZJkXKHuZV9oZm/9rO
 K9fjoRUHk6JYg6ix1LVTEr7G+PeHGsiR1sVpAe8WGT3gtNiEoGHezcs/el/fYQVbv6+y
 F0bGZR99gLAkuMilUlZ2T4wQxbFa7zVLHmT5ksnB2vnyaWtorXj6ax6bdWLrWATm2+yx
 8TRg==
X-Gm-Message-State: AOJu0Yz0yfcaBLA0XClB/DSVYEFYsF9VLXUKz/mEy+KGQMicmZa5Dum/
 Iu52VhMYLMJLM/vW5NPoA994VhuML3mERGn4fPv+Y/ZEAzcqbOE9MFfZD+Kfssw4Z4gF+HvkS3/
 5bZ+w
X-Gm-Gg: ASbGnctG1PUFQVt3SOgmrXVQLec5Srr8Meqo71WJfLHANPfi1QFudGBRlQPsKcUVWuV
 laA8iT4juO2xFEXnv5sVCAdR9en/CMy4oPSGTa1syJVh5Ml7LJohHHHO5Dkfv+dXC0S9uMX0fZ0
 1WeAS4ao3zejEXhNKUritbAJL7jpEnlDsiBK+WQCOictgT5cxjoVZj2XNoBQuIB7dWMkpIiaj0P
 sk6ATolUbfrNfvEAcW+1Ib5TT1uqpCfryjyFd3lPoyHtn5xHZk0zqyInHaEvtzalarkRsNy5jFU
 HR1blNUmgrXb8hnm1IjO/VVR6nHpHPFpnkWXS+vV3lI63r+FfbZkycMG5gBVfD3TinDLRw8QiW0
 W113FXp3n9Wz12182n9u0eUaAOIjacaQ8wA+WBwyhxJF9bNjolmbzhPiP54Sqs1k6Vm8jNIgxo5
 K5BA==
X-Google-Smtp-Source: AGHT+IH83fA8jRm1gBDT3szyVaCwNqF+aJh9bmpEmtpeu2mCCaq3/OQjsifnggBgdSWRGiUy8IKJ7g==
X-Received: by 2002:a05:6000:2b07:b0:3a5:8934:493a with SMTP id
 ffacd0b85a97d-3b60dd80da6mr229356f8f.44.1752608760450; 
 Tue, 15 Jul 2025 12:46:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc201asm15701166f8f.22.2025.07.15.12.45.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/17] accel: Extract AccelClass definition to
 'accel/accel-ops.h'
Date: Tue, 15 Jul 2025 21:45:07 +0200
Message-ID: <20250715194516.91722-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Only accelerator implementations (and the common accelator
code) need to know about AccelClass internals. Move the
definition out but forward declare AccelState and AccelClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-39-philmd@linaro.org>
---
 MAINTAINERS                 |  2 +-
 include/accel/accel-ops.h   | 49 +++++++++++++++++++++++++++++++++++++
 include/qemu/accel.h        | 39 ++---------------------------
 include/system/hvf_int.h    |  3 ++-
 include/system/kvm_int.h    |  1 +
 accel/accel-common.c        |  2 ++
 accel/accel-system.c        |  1 +
 accel/hvf/hvf-all.c         |  1 +
 accel/kvm/kvm-all.c         |  1 +
 accel/qtest/qtest.c         |  1 +
 accel/tcg/tcg-accel-ops.c   |  1 +
 accel/tcg/tcg-all.c         |  2 ++
 accel/xen/xen-all.c         |  1 +
 bsd-user/main.c             |  1 +
 gdbstub/system.c            |  1 +
 linux-user/main.c           |  1 +
 system/memory.c             |  1 +
 target/i386/nvmm/nvmm-all.c |  1 +
 target/i386/whpx/whpx-all.c |  1 +
 19 files changed, 71 insertions(+), 39 deletions(-)
 create mode 100644 include/accel/accel-ops.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e945f3bd26..9d88c174331 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -502,7 +502,7 @@ F: include/exec/target_long.h
 F: include/qemu/accel.h
 F: include/system/accel-*.h
 F: include/system/cpus.h
-F: include/accel/accel-cpu*.h
+F: include/accel/accel-*.h
 F: accel/accel-*.?
 F: accel/dummy-cpus.?
 F: accel/Makefile.objs
diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
new file mode 100644
index 00000000000..86a27c30fa4
--- /dev/null
+++ b/include/accel/accel-ops.h
@@ -0,0 +1,49 @@
+/*
+ * Accelerator handlers
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef ACCEL_OPS_H
+#define ACCEL_OPS_H
+
+#include "exec/hwaddr.h"
+#include "qemu/accel.h"
+#include "qom/object.h"
+
+struct AccelState {
+    Object parent_obj;
+};
+
+struct AccelClass {
+    ObjectClass parent_class;
+
+    const char *name;
+    /* Cached by accel_init_ops_interfaces() when created */
+    AccelOpsClass *ops;
+
+    int (*init_machine)(AccelState *as, MachineState *ms);
+    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
+    void (*cpu_common_unrealize)(CPUState *cpu);
+
+    /* system related hooks */
+    void (*setup_post)(AccelState *as);
+    void (*pre_resume_vm)(AccelState *as, bool step_pending);
+    bool (*has_memory)(AccelState *accel, AddressSpace *as,
+                       hwaddr start_addr, hwaddr size);
+
+    /* gdbstub related hooks */
+    int (*gdbstub_supported_sstep_flags)(AccelState *as);
+
+    bool *allowed;
+    /*
+     * Array of global properties that would be applied when specific
+     * accelerator is chosen. It works like MachineClass.compat_props
+     * but it's for accelerators not machines. Accelerator-provided
+     * global properties may be overridden by machine-type
+     * compat_props or user-provided global properties.
+     */
+    GPtrArray *compat_props;
+};
+
+#endif /* ACCEL_OPS_H */
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 9e821d0faea..d3638c7bfda 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -26,43 +26,8 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 
-struct AccelState {
-    /*< private >*/
-    Object parent_obj;
-};
-
-typedef struct AccelClass {
-    /*< private >*/
-    ObjectClass parent_class;
-    /*< public >*/
-
-    const char *name;
-    /* Cached by accel_init_ops_interfaces() when created */
-    AccelOpsClass *ops;
-
-    int (*init_machine)(AccelState *as, MachineState *ms);
-    bool (*cpu_common_realize)(CPUState *cpu, Error **errp);
-    void (*cpu_common_unrealize)(CPUState *cpu);
-
-    /* system related hooks */
-    void (*setup_post)(AccelState *as);
-    void (*pre_resume_vm)(AccelState *as, bool step_pending);
-    bool (*has_memory)(AccelState *accel, AddressSpace *as,
-                       hwaddr start_addr, hwaddr size);
-
-    /* gdbstub related hooks */
-    int (*gdbstub_supported_sstep_flags)(AccelState *as);
-
-    bool *allowed;
-    /*
-     * Array of global properties that would be applied when specific
-     * accelerator is chosen. It works like MachineClass.compat_props
-     * but it's for accelerators not machines. Accelerator-provided
-     * global properties may be overridden by machine-type
-     * compat_props or user-provided global properties.
-     */
-    GPtrArray *compat_props;
-} AccelClass;
+typedef struct AccelState AccelState;
+typedef struct AccelClass AccelClass;
 
 #define TYPE_ACCEL "accel"
 
diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 5150c7dd9c9..a3b06a3e75b 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -14,6 +14,7 @@
 #include "qemu/queue.h"
 #include "exec/vaddr.h"
 #include "qom/object.h"
+#include "accel/accel-ops.h"
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
@@ -45,7 +46,7 @@ typedef struct hvf_vcpu_caps {
 } hvf_vcpu_caps;
 
 struct HVFState {
-    AccelState parent;
+    AccelState parent_obj;
 
     hvf_slot slots[32];
     int num_slots;
diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 756a3c0a250..9247493b029 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -14,6 +14,7 @@
 #include "qemu/accel.h"
 #include "qemu/queue.h"
 #include "system/kvm.h"
+#include "accel/accel-ops.h"
 #include "hw/boards.h"
 #include "hw/i386/topology.h"
 #include "io/channel-socket.h"
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 591ff4cbb65..850c5ab4b8e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,7 +10,9 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu.h"
+#include "accel/accel-cpu-ops.h"
 #include "accel-internal.h"
 
 /* Lookup AccelClass from opt_name. Returns NULL if not found */
diff --git a/accel/accel-system.c b/accel/accel-system.c
index c2a955a6daa..8df561b9539 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 1fa07c8b695..e67a8105a66 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "accel/accel-ops.h"
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "system/hvf.h"
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a106d1ba0f0..659ff881563 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -32,6 +32,7 @@
 #include "system/runstate.h"
 #include "system/cpus.h"
 #include "system/accel-blocker.h"
+#include "accel/accel-ops.h"
 #include "qemu/bswap.h"
 #include "exec/tswap.h"
 #include "system/memory.h"
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index a7fc8bee6dd..1d4337d698e 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -18,6 +18,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/accel.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/qtest.h"
 #include "system/cpus.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 58ded9d6f0d..3b0d7d298e6 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/tcg.h"
 #include "system/replay.h"
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 5904582a68d..eaeb465dfd5 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -39,6 +39,8 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
+#include "accel/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
 
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 55a60bb42c2..97377d67d1c 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -19,6 +19,7 @@
 #include "chardev/char.h"
 #include "qemu/accel.h"
 #include "accel/dummy-cpus.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/xen.h"
diff --git a/bsd-user/main.c b/bsd-user/main.c
index d0cc8e0088f..7e5d4bbce09 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -38,6 +38,7 @@
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
+#include "accel/accel-ops.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 5b6f8d07334..5be0d3c58ce 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -19,6 +19,7 @@
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index f4f20074396..68972f00a15 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -42,6 +42,7 @@
 #include "user/page-protection.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
+#include "accel/accel-ops.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
 #include "qemu/envlist.h"
diff --git a/system/memory.c b/system/memory.c
index e8d9b15b28f..0983ff89622 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -29,6 +29,7 @@
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "qemu/accel.h"
+#include "accel/accel-ops.h"
 #include "hw/boards.h"
 #include "migration/vmstate.h"
 #include "system/address-spaces.h"
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b4a4d50e860..aab12d77326 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -12,6 +12,7 @@
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "qemu/accel.h"
+#include "accel/accel-ops.h"
 #include "system/nvmm.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index faf56e19722..10df2d398f7 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -14,6 +14,7 @@
 #include "system/ioport.h"
 #include "gdbstub/helpers.h"
 #include "qemu/accel.h"
+#include "accel/accel-ops.h"
 #include "system/whpx.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
-- 
2.49.0


