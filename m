Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7CAC83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNrW-0001rx-IF; Thu, 03 Jul 2025 13:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNrD-0001SO-Np
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNrB-0001u0-EY
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:36:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so1401795e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564179; x=1752168979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E/SAxbdiV3TRF5Yfo8PH+PsmR3gvFEsRHLctVVyuPU=;
 b=uEFM8ke1wmrhT+h3s5WOCUl+LqVReXMywRVIVikRNKw7EbVUrMZ0Mjh3h7svAggaUP
 998kCz8ghntBk2TLUra4p4wABW7nntth5AZ2KmTQFd/5RPAzefpXJ8pLhTrtHKpTonGY
 K4veprGH7GKYtNhI5Eq9AfttuNZVIM19jA2XtSwP1Xwp/RO4HZgvCyrirMGhfSvsH5S7
 27Ifaolo+zuHoKTv1RB/Fcu1o1AfZtgruVMTUSmMun7b2FSChN99YrzgfCAoqVzdQ0ap
 VAcK74Nnt+7rWkdqXgAnuW5k9lJSFUpymelWZgt+IK0X0qzRPJmGyVQ2/hfsSTgqCk5v
 Tl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564179; x=1752168979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E/SAxbdiV3TRF5Yfo8PH+PsmR3gvFEsRHLctVVyuPU=;
 b=Pi+1j5qAkmazgm0CRMkbsoTa4H7F1FWRppbvqXZVjIOj2rjtSzqXetaUKSufbG8685
 oPYyiV1oJHMJyhtYA5+t54Wd4DWlM1EgQi0dB6865UbjtfJLBbk4ZcTvFWh4zRaus066
 h3lfe/bplylOQsSkpP9WHqkjn6NefKeyHMB+nbm+XNyilIjF5s/8z/2geZyMCNPulMwD
 9BzpvJVKUJzNE4WcWt4emLApUzJmtXYiYLS3L7QZlmKVEc5/kwG6OCp2BphEDdQXAKf6
 A5koCSiHVy29tfWre0XpEfP+UcFvS7g72nyGXIF66By6MkADilPaU++yFiE01aU52buv
 hAwg==
X-Gm-Message-State: AOJu0Yz/G29yZ2BObbsz0r8Z1wVWOzuKxZW3CmIzpZ36EsvYYTfT+1/C
 4Z/rFO+waq1S6Aa/B6Wji8H/b1uo6nPQFyjFE2BG5Ga3QM6pp8LAXqGyMd7aYJDCR8spBOaFZ2z
 o0z+pzoM=
X-Gm-Gg: ASbGncvmY2l/pBKRxlVhZsFTz97p6jMjG3IZ7+Db6xO/OfRMJLKaTvTHBjal4qiKtY4
 bY0CtyDmSuejeV/q8o9zSPkyMU71R4wv2DrA8hEoG0XthcbBs84fekVPYe2vOVWEVBAi9EdCWQq
 7Y4I1d/6vADwjMJiijmJ5ieochF8KzBVy1TYwCdSEpF4OoObI+aOpII0Binvd56UOaI6GQAVCPw
 WKapMenNkwth+1fujY5QOuopsKD7XYeJKefAtlvtCn9u+FBCdSm8dMCmvy76gHPYNksaTHWeScW
 FOfYOglwkagX+YzzaG3tAPW0i2PcSBQ2ztmZwz7aXoNO+CIXJ4AXIlq63X7nRFsFnd/s1S99NoX
 CRtsTzNkXxZkkf8/n2mdLigO/7PYYYZXkOBuI
X-Google-Smtp-Source: AGHT+IGYkuYIeLocc6dsLio4WRAhQTPLG5g0dI2lw9ZYqsX2Hf52uwkNyyuJTdB+GW55XoGAazaZvQ==
X-Received: by 2002:a05:600c:4e8b:b0:443:48:66d2 with SMTP id
 5b1f17b1804b1-454a3704fc7mr101594355e9.16.1751564179105; 
 Thu, 03 Jul 2025 10:36:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a997e367sm32057155e9.15.2025.07.03.10.36.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:36:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v6 38/39] accel: Extract AccelClass definition to
 'accel/accel-ops.h'
Date: Thu,  3 Jul 2025 19:32:44 +0200
Message-ID: <20250703173248.44995-39-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
---
 MAINTAINERS                 |  2 +-
 include/accel/accel-ops.h   | 50 +++++++++++++++++++++++++++++++++++++
 include/qemu/accel.h        | 40 ++---------------------------
 include/system/hvf_int.h    |  3 ++-
 include/system/kvm_int.h    |  1 +
 accel/accel-common.c        |  1 +
 accel/accel-system.c        |  1 +
 accel/hvf/hvf-all.c         |  1 +
 accel/kvm/kvm-all.c         |  1 +
 accel/qtest/qtest.c         |  1 +
 accel/tcg/tcg-accel-ops.c   |  1 +
 accel/tcg/tcg-all.c         |  1 +
 accel/xen/xen-all.c         |  1 +
 bsd-user/main.c             |  1 +
 gdbstub/system.c            |  1 +
 linux-user/main.c           |  1 +
 system/memory.c             |  1 +
 target/i386/nvmm/nvmm-all.c |  1 +
 target/i386/whpx/whpx-all.c |  1 +
 19 files changed, 70 insertions(+), 40 deletions(-)
 create mode 100644 include/accel/accel-ops.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 37d02b2313c..e3e08d4607f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -501,7 +501,7 @@ F: include/exec/target_long.h
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
index 00000000000..35e7d4c3b26
--- /dev/null
+++ b/include/accel/accel-ops.h
@@ -0,0 +1,50 @@
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
+    bool (*has_memory)(AccelState *accel, AddressSpace *as,
+                       hwaddr start_addr, hwaddr size);
+    bool (*cpus_are_resettable)(AccelState *as);
+
+    /* gdbstub related hooks */
+    bool (*supports_guest_debug)(AccelState *as);
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
index 3c6350d6d63..71293a3e2a9 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -26,44 +26,8 @@
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
-    bool (*has_memory)(AccelState *accel, AddressSpace *as,
-                       hwaddr start_addr, hwaddr size);
-    bool (*cpus_are_resettable)(AccelState *as);
-
-    /* gdbstub related hooks */
-    bool (*supports_guest_debug)(AccelState *as);
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
index ecc49a309cf..8a443af3454 100644
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
index b490612447b..de2504e435e 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 451567e1a50..bce03c9ddeb 100644
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
index 4fae4c79805..11514533a84 100644
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
index 9d1dc56d7e8..683116f68ff 100644
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
index 8f071d2cfeb..20802e24d46 100644
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
index 93972bc0919..829a7293b80 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -39,6 +39,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/boards.h"
 #endif
+#include "accel/accel-ops.h"
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
index 1c48915b6a5..11870a1585f 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -20,6 +20,7 @@
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
+#include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
diff --git a/linux-user/main.c b/linux-user/main.c
index a9142ee7268..254cf2526a8 100644
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
index b072a6bef83..13e833851a6 100644
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
index 721c4782b9c..2a90cde6d50 100644
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


