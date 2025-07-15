Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63427C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 20:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublof-0001gC-Sg; Tue, 15 Jul 2025 15:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbE-0002zo-0m
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbB-0002iN-Vs
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-454ac069223so1181535e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608756; x=1753213556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8fk9V0N9x/W+vNzRtti/sddaZjw+YfCrgEKksP+0n4A=;
 b=rKlPE0/e9hmcz4HhJjt2kxTWsbs6gP5JyrAg4IGORdDkjos01Gt/XD7T9eap3dUhKB
 cBAPNS5mlnIGrA4yYL3sF3WLR5OniqXne0v+3N/X58iswWx2hZPcgnqChorTwmJbzG1r
 Fv2v3oC4/SXipHw3cmCFEK1vwVi6gJoS+JiRdE5yAigD2GF/3Y1rnZvsy17JukdROQrV
 9rZY+sgt9ZWmAAKd/6K8eCpz+EuaMoCp+RhY0yEgkLZfsdpsR2wiZ6xbfFv8oIW40Xoo
 Hp8FjJpOkSWSesInAG6sRZv+B6W/X/V1vofq40yMYuVHyGSuY1jurYoWbVAjmGYicae1
 NDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608756; x=1753213556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fk9V0N9x/W+vNzRtti/sddaZjw+YfCrgEKksP+0n4A=;
 b=Y6EWyN0r/MarpftejIOTAkKSNj05AT228rxZPEMaQy2qTYnDGPyNrYYNAN3AgJfShc
 +8tIwu3DrNbAe3vYRXqj7b2Mk4Zxaf1Wg6kRoTvEBozrRq/PM2J1b9w9eZYBfnO8zDH0
 tLKRDLb0yuY6tog/t56IAM7GJwQr146K0O1qgUI4sXZmhELxetlIKsZW8LPPxPS9o7rq
 hMSdCpaD9BckjDmz+EKQu+oN6G5gRd/7tbiAZK6hSbidzzAtowUpZtgzBbRjlg8y3v8P
 EgE1xuL0J0wHvlCyDe8biXwtZUG2Tz0wovDhcqKFUxC2X05c6I+X9CPHrAGyQEOB4z1c
 DVBA==
X-Gm-Message-State: AOJu0YwxbsDYi0z2y/XSrvu/RpUHfwl1gWPH9BcP/+7CmvWBETNTOq0M
 mbRza+kVcWT6ZpxhItFYnEbG4v0VwKAabQJiD4rmlLMXHJYS7ydJ79q0VX9gRmWkVTNmgDffaTN
 kwdAK
X-Gm-Gg: ASbGncuFCDpvFVkDj0jVa4vF5bn1glXJhtSsocaRTXsR6LwbdsBZL+mayfg8Y2jGHuu
 etd43StBjuQtBHJMAH0F+GimKFhu/6QTaH7+adHlPvWVhhIQiwD1WoIIx33njXX4qxauLSjLZME
 J8h3fEZOp4pdVyPvZMxIHErGJdl7cY/UJejfRmHQFyPUsYqMPyuogwxQR2VX/AuenBN1e2eyBux
 BJqMlis3zELK1oznzdVoq4dYRuSjJ5qBKCjJZw3ap8Mzk46pTHA6B36TGNOgOlx4P4it9qwOaAY
 OsRNmBtak9xqPS7xYbLs5Kz7xgF+MS/kazY1GDCdgAJy+2mp0mHSsC7E3ACZsmgOLVS+1vP8bjb
 JP9k78f6isKEvagjbhbFPj8XrCgHuPjfXDUxnrKMPrHpLQuvPAa+HQnv2g0GXUnMHM/XK6L9uux
 lXNA==
X-Google-Smtp-Source: AGHT+IFP+F0+N7LxTOOa23GeO8OWAxEbaY9tRnCFG6/wG8LGRy2Av5Q5skYT0w6Tv/S1NNF7lJcjCA==
X-Received: by 2002:a05:600c:3b9f:b0:455:f7b8:235c with SMTP id
 5b1f17b1804b1-4562dccb666mr4391545e9.14.1752608755900; 
 Tue, 15 Jul 2025 12:45:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd4669c3sm168689765e9.14.2025.07.15.12.45.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] accel: Rename 'system/accel-ops.h' ->
 'accel/accel-cpu-ops.h'
Date: Tue, 15 Jul 2025 21:45:06 +0200
Message-ID: <20250715194516.91722-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Unfortunately "system/accel-ops.h" handlers are not only
system-specific. For example, the cpu_reset_hold() hook
is part of the vCPU creation, after it is realized.

Mechanical rename to drop 'system' using:

  $ sed -i -e s_system/accel-ops.h_accel/accel-cpu-ops.h_g \
              $(git grep -l system/accel-ops.h)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250703173248.44995-38-philmd@linaro.org>
---
 include/{system/accel-ops.h => accel/accel-cpu-ops.h} | 8 ++++----
 accel/accel-system.c                                  | 2 +-
 accel/hvf/hvf-accel-ops.c                             | 2 +-
 accel/kvm/kvm-accel-ops.c                             | 2 +-
 accel/qtest/qtest.c                                   | 2 +-
 accel/tcg/tcg-accel-ops.c                             | 2 +-
 accel/xen/xen-all.c                                   | 2 +-
 cpu-target.c                                          | 2 +-
 gdbstub/system.c                                      | 2 +-
 system/cpus.c                                         | 2 +-
 target/i386/nvmm/nvmm-accel-ops.c                     | 2 +-
 target/i386/whpx/whpx-accel-ops.c                     | 2 +-
 12 files changed, 15 insertions(+), 15 deletions(-)
 rename include/{system/accel-ops.h => accel/accel-cpu-ops.h} (95%)

diff --git a/include/system/accel-ops.h b/include/accel/accel-cpu-ops.h
similarity index 95%
rename from include/system/accel-ops.h
rename to include/accel/accel-cpu-ops.h
index bf7383511d0..a9191dded7e 100644
--- a/include/system/accel-ops.h
+++ b/include/accel/accel-cpu-ops.h
@@ -1,5 +1,5 @@
 /*
- * Accelerator OPS, used for cpus.c module
+ * Accelerator per-vCPU handlers
  *
  * Copyright 2021 SUSE LLC
  *
@@ -7,8 +7,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_OPS_H
-#define ACCEL_OPS_H
+#ifndef QEMU_ACCEL_CPU_OPS_H
+#define QEMU_ACCEL_CPU_OPS_H
 
 #include "qemu/accel.h"
 #include "exec/vaddr.h"
@@ -89,4 +89,4 @@ struct AccelOpsClass {
 
 void generic_handle_interrupt(CPUState *cpu, int mask);
 
-#endif /* ACCEL_OPS_H */
+#endif /* QEMU_ACCEL_CPU_OPS_H */
diff --git a/accel/accel-system.c b/accel/accel-system.c
index c54c30f18ba..c2a955a6daa 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
 #include "accel-internal.h"
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index be8724ac896..214454bd0b4 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -54,7 +54,7 @@
 #include "gdbstub/enums.h"
 #include "exec/cpu-common.h"
 #include "hw/core/cpu.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 0eafc902c3f..b709187c7d7 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index 2b831260201..a7fc8bee6dd 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -18,7 +18,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qemu/accel.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/qtest.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 279dbfa1cf7..58ded9d6f0d 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
index bd0ff64befc..55a60bb42c2 100644
--- a/accel/xen/xen-all.c
+++ b/accel/xen/xen-all.c
@@ -19,7 +19,7 @@
 #include "chardev/char.h"
 #include "qemu/accel.h"
 #include "accel/dummy-cpus.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/xen.h"
 #include "system/runstate.h"
diff --git a/cpu-target.c b/cpu-target.c
index 1c90a307593..2049eb1d0f6 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "exec/cpu-common.h"
 #include "exec/tswap.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 8a32d8e1a1d..5b6f8d07334 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -19,7 +19,7 @@
 #include "gdbstub/commands.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/replay.h"
diff --git a/system/cpus.c b/system/cpus.c
index 8e6da2e0606..256723558d0 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -31,7 +31,7 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
 #include "exec/gdbstub.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/hw_accel.h"
 #include "exec/cpu-common.h"
 #include "qemu/thread.h"
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index a5517b0abf3..3799260bbde 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index 5f4841c9fa4..da58805b1a6 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "system/kvm_int.h"
 #include "qemu/main-loop.h"
-#include "system/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
 #include "system/cpus.h"
 #include "qemu/guest-random.h"
 
-- 
2.49.0


