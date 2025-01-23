Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FAEC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6tG-0007bs-OS; Thu, 23 Jan 2025 18:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tD-0007Oj-NM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:35 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tA-0004Lk-F8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:35 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso15569025e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675930; x=1738280730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGO8rj66FytAuOx0HD2g/yFD3gx++HeKfsSZtvEWB0o=;
 b=c1My6B2r3Mk1NAb3VDrgTKx3BrtzmKRV+149VgQBRPggYRWBSOoqVucHlHRUUYqiGC
 g4IrJ/sAm81IQGvAUNRwsmq5ok2QVaY/RvWQ5bL+IAiECFCT0vs3R56SOZWJQXJ7SXo5
 dEgAPYdOtxqPqoUWSDCQcApnIYTBCsiKtxLvp7KvS0rQig5Zk6y98JMcujKugn+6gKwC
 r6j4icsPbOgT5jzOBFYdV4kCU/Z55Bv+aFv0gmn4Xa6DqXYlp4xJ9glTCqi0vR7XAYvY
 Sjk+JMt87JMEE3jnhKl36p48ZUmNuuOEhXGppzB/zokZPjYYFqY/wJ7dbOTibMMWhKr0
 IJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675930; x=1738280730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGO8rj66FytAuOx0HD2g/yFD3gx++HeKfsSZtvEWB0o=;
 b=ZLOyYXFBR4bCMvxQETGjwz59s6+ZH5IIZ11EIwes9lWUxpnVQzHabhY6qDhCTeXml9
 HWQVaAI9AXu5y/NPsTPZqx7iODZGXgtgeZkDkYVZ6DPrksCgF8Ffm6gFRg9l0xZApDcx
 DrfJAGXoOS5kopl9glYD8ef0lfjGg5m6AG/Ct86jzbqjrUfVsfFRhXE/I79MtM9/X5ex
 9aSnT9/thUbg85lDsK/1AuKItdW5T5DLYb3L/ccRWNMNTvclN+QW2VtOf6WoWtYsPRul
 SI8pyLcCf1KMzVXsRHysW8umdIXU/GdtWZoupct9TDQtNj0E31+l+boVJicx8Jzs5W2R
 54AQ==
X-Gm-Message-State: AOJu0YyHDslgMVCL0DRYPssIVcJEu3E3GbMLJt8zFGyvq86iQeb7/W6D
 uWImlKRkzstwwrcYdF60taUkZkLDWS7fLksUsyDsdeYeIWYuT0dOX8jWwO/m5emv91LZacpgoGa
 lVXw=
X-Gm-Gg: ASbGncu2nM58CUcl2749Eyax+/F6wl4Fjmt8gGVGv3q5MSL45zPUYvAmqO0VGocM/Zo
 CuchLuL0D9VNsoUpBdtygAm2exgHu7FK2x+r6m+1nz7Qwlot4VTCsL9IrzoSuvFsLH+uvqVlGC7
 dP74c25LJtMsciWD2I0kGJxySxvRfddHLxftLFpPq/D0qYj8zmo56J1SjDmaL78DVFM61Mp/HVv
 7P8QBf5tV9C9CsFdAmW9Tuz3rLzHAkPKivv1zd6AgF6+m0ynU2qaRjwJkgtSGGKCxaBO4jOqvj9
 5/CYQc8d0e+Ky3H38hYICTl291wDUFc72PztNakzuwS1pR+EYW+V8Ag=
X-Google-Smtp-Source: AGHT+IGTWWuqfdRG1OdMv1JrJhUNbIyiZqrhlB9MFbw+o6IkF6P0PGvSwNrik0HZ18U5C5r24zY0/A==
X-Received: by 2002:a05:600c:1e0e:b0:438:a20b:6a2a with SMTP id
 5b1f17b1804b1-438a20b6b71mr242006995e9.14.1737675930187; 
 Thu, 23 Jan 2025 15:45:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9990sm7076685e9.29.2025.01.23.15.45.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:28 -0800 (PST)
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
Subject: [PATCH 13/20] accel: Forward-declare AccelOpsClass in
 'qemu/typedefs.h'
Date: Fri, 24 Jan 2025 00:44:07 +0100
Message-ID: <20250123234415.59850-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The heavily imported "system/cpus.h" header includes "accel-ops.h"
to get AccelOpsClass type declaration. Reduce headers pressure by
forward declaring it in "qemu/typedefs.h", where we already
declare the AccelCPUState type.

Reduce "system/cpus.h" inclusions by only including
"system/accel-ops.h" when necessary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/typedefs.h           | 1 +
 include/system/accel-ops.h        | 1 -
 include/system/cpus.h             | 2 --
 accel/accel-system.c              | 1 +
 accel/hvf/hvf-accel-ops.c         | 1 +
 accel/kvm/kvm-accel-ops.c         | 1 +
 accel/qtest/qtest.c               | 1 +
 accel/tcg/cpu-exec-common.c       | 1 -
 accel/tcg/cpu-exec.c              | 1 -
 accel/tcg/monitor.c               | 1 -
 accel/tcg/tcg-accel-ops.c         | 1 +
 accel/tcg/translate-all.c         | 1 -
 accel/xen/xen-all.c               | 1 +
 cpu-common.c                      | 1 -
 cpu-target.c                      | 1 +
 gdbstub/system.c                  | 1 +
 system/cpus.c                     | 1 +
 target/i386/nvmm/nvmm-accel-ops.c | 1 +
 target/i386/whpx/whpx-accel-ops.c | 1 +
 19 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 3d84efcac47..465cc501773 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -22,6 +22,7 @@
  * Please keep this list in case-insensitive alphabetical order.
  */
 typedef struct AccelCPUState AccelCPUState;
+typedef struct AccelOpsClass AccelOpsClass;
 typedef struct AccelState AccelState;
 typedef struct AddressSpace AddressSpace;
 typedef struct AioContext AioContext;
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 137fb96d444..4c99d25aeff 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -17,7 +17,6 @@
 #define TYPE_ACCEL_OPS "accel" ACCEL_OPS_SUFFIX
 #define ACCEL_OPS_NAME(name) (name "-" TYPE_ACCEL_OPS)
 
-typedef struct AccelOpsClass AccelOpsClass;
 DECLARE_CLASS_CHECKERS(AccelOpsClass, ACCEL_OPS, TYPE_ACCEL_OPS)
 
 /**
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 1cffeaaf5c4..3226c765d01 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -1,8 +1,6 @@
 #ifndef QEMU_CPUS_H
 #define QEMU_CPUS_H
 
-#include "system/accel-ops.h"
-
 /* register accel-specific operations */
 void cpus_register_accel(const AccelOpsClass *i);
 
diff --git a/accel/accel-system.c b/accel/accel-system.c
index a7596aef59d..5df49fbe831 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
 #include "accel-system.h"
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 945ba720513..12fc30c2761 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -54,6 +54,7 @@
 #include "exec/exec-all.h"
 #include "gdbstub/enums.h"
 #include "hw/boards.h"
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index a81e8f3b03b..54ea60909e2 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "system/accel-ops.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index ad7e3441a5a..7fae80f6a1b 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -18,6 +18,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/accel.h"
+#include "system/accel-ops.h"
 #include "system/qtest.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 100746d555a..c5c513f1e4a 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "exec/log.h"
-#include "system/cpus.h"
 #include "system/tcg.h"
 #include "qemu/plugin.h"
 #include "internal-common.h"
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8ee76e14b0d..4070d532bf1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -33,7 +33,6 @@
 #include "qemu/rcu.h"
 #include "exec/log.h"
 #include "qemu/main-loop.h"
-#include "system/cpus.h"
 #include "exec/cpu-all.h"
 #include "system/cpu-timers.h"
 #include "exec/replay-core.h"
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index ae1dbeb79f8..eeb38a4d9ce 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -13,7 +13,6 @@
 #include "qapi/type-helpers.h"
 #include "qapi/qapi-commands-machine.h"
 #include "monitor/monitor.h"
-#include "system/cpus.h"
 #include "system/cpu-timers.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b2..132c5d14613 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -26,6 +26,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "system/accel-ops.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "system/cpu-timers.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 786e2f6f1a7..0914d6e98b2 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -54,7 +54,6 @@
 #include "qemu/cacheinfo.h"
 #include "qemu/timer.h"
 #include "exec/log.h"
-#include "system/cpus.h"
 #include "system/cpu-timers.h"
 #include "system/tcg.h"
 #include "qapi/error.h"
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index 852e9fbe5fe..7aa28b9ab93 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -18,6 +18,7 @@
 #include "hw/xen/xen_igd.h"
 #include "chardev/char.h"
 #include "qemu/accel.h"
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/xen.h"
 #include "system/runstate.h"
diff --git a/cpu-common.c b/cpu-common.c
index 4248b2d727e..f5dcc2d136b 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -21,7 +21,6 @@
 #include "qemu/main-loop.h"
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
-#include "system/cpus.h"
 #include "qemu/lockable.h"
 #include "trace/trace-root.h"
 
diff --git a/cpu-target.c b/cpu-target.c
index f97f3a14751..20933bde7d4 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -35,6 +35,7 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #endif
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/tcg.h"
 #include "exec/tswap.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 7f047a285c8..416c1dbe1e9 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -19,6 +19,7 @@
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
diff --git a/system/cpus.c b/system/cpus.c
index 37e5892c240..2cc5f887ab5 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
+#include "system/accel-ops.h"
 #include "system/hw_accel.h"
 #include "exec/cpu-common.h"
 #include "qemu/thread.h"
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index e7b56662fee..4e4e63de78e 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index ab2e014c9ea..81fdd06e487 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
+#include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
-- 
2.47.1


