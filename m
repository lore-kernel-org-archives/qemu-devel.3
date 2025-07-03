Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356BFC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgx-0000Tz-Ni; Thu, 03 Jul 2025 07:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHe1-0005Lt-2V
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHdy-0002co-5w
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so47381415e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540296; x=1752145096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZ/hvC4u2jp7Pix4yjeZfPZoKMalJ7KXbdnBXGN8XCk=;
 b=WN0qrLVvyfemlA9gLQYAP01rJzW5elNUD1NKCmtboORJmjkEuglkNPielYrRHvQ6UX
 3ItzlDxVK518ubxFwhT8cEnQVvoH56bsEvHoE8xhZC67nCSsgiYRIBWAQJFw/s4YzuIC
 4oG+FeiC3BDe8zFao43MZszMIVO1cC9X2Ma19eP7Zt7SqpxzEf83PYee+h5tLkutXpjR
 DgsYDFs63HOgWIY7CF1JR045Bl6Mmq5PY0wjGFDhisTj4VmriAoxSNg98T7GHyKrqayT
 U+eV1HKgQyuevqdXfABLw413qYO5AUfG/6L0HRgu3j4nK1qwx1BMSr3FelciZU2/1nrh
 hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540296; x=1752145096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZ/hvC4u2jp7Pix4yjeZfPZoKMalJ7KXbdnBXGN8XCk=;
 b=HxgnOMaGdbQRS5aK2Yz7zMY5fLgMf3B3t+pyiGqBT65oJtcYY2/uBTQdcTsORBMDJR
 mSxFgF2caQ2krYNUVhBZkuyJZdzswqIAxofz6CHS1wQLzJWlMQ+y2GUkIEnEFghfrmfF
 tnn9xNA9saEVwavaIOjPM7hwLtgo+ssHDEADwAI+KrRBvvXLHGZqUQi0xIF8XLeE6UJx
 K6tPEWf2k+jSPLU77fpXj0DZNbliYIf+ugklKR83WI35QnqiIJSOEykZKMT13ArDczqq
 RTmGidRA7wzB7yPBNErgdH598raNXjwmGO+khzPlmq3gQKLfScI+2tRlhICNOwrRWjjp
 xwpA==
X-Gm-Message-State: AOJu0Yx2KuYvmZ55VYbvFfSnp9FMX7ENf8Ddw0ewzM00ZEFLYC8R8x4H
 LUMKElkeprTaIrER6nLavg9TMkTQJUdQy5UoQwE0xEH40BN08K0IuTcEPoj2EN31AqdRBHxdnof
 fDA+Nsj4=
X-Gm-Gg: ASbGncut7xa6mLvSh5pGcw6a3iXvRUNV8YKldDKAGHS8eMe4jAvOFieaHpIs2iaaGNi
 87646UqKLwi7NJxu7UzXHkASmANUkdABBzLYVG97TzjqRa9QOu0WRBFJeLyXP5byuF/p7nSjXvS
 BwlSt7WVjDTVbHPfETcNcNuIswUrRNoAxAGk0K2pYGMs5Vj+124TaEDir6qJcy12LWZTdCmaXET
 57ovKDItOcCPeMyZKF7RSuPe9JYxi5IrN+jEbuyqK8loNtpUEommzY/qw5aeyfH6PKVjcjzcMez
 bRFf7XXIAXVSV2FN7iQqpdCZVBdv98iEafxpp5S5+YA7GYJ3vo/JmUPIM4z92czCC/jZd3GS3H7
 2N63I64J8yd4=
X-Google-Smtp-Source: AGHT+IEuN0jVmRpBpWx/3F8JjrZDICpuvuBuWma263BrzMgnHysFP/hDSn3CyvPN+WSuLtCvOQGX6Q==
X-Received: by 2002:a05:600c:190f:b0:44a:ac77:26d5 with SMTP id
 5b1f17b1804b1-454a36e926fmr70940985e9.14.1751540296019; 
 Thu, 03 Jul 2025 03:58:16 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969a8bsm23507045e9.2.2025.07.03.03.58.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v5 29/69] accel/system: Introduce @x-accel-stats QMP command
Date: Thu,  3 Jul 2025 12:54:55 +0200
Message-ID: <20250703105540.67664-30-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Unstable QMP 'x-accel-stats' dispatches to the
AccelOpsClass::get_stats() and get_vcpu_stats() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 qapi/accelerator.json      | 17 +++++++++++++++++
 include/qemu/accel.h       |  2 ++
 include/system/accel-ops.h |  3 +++
 accel/accel-qmp.c          | 34 ++++++++++++++++++++++++++++++++++
 accel/accel-system.c       |  1 +
 accel/meson.build          |  2 +-
 6 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 accel/accel-qmp.c

diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 00d25427059..81308493c66 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -55,3 +55,20 @@
   'returns': 'HumanReadableText',
   'if': 'CONFIG_TCG',
   'features': [ 'unstable' ] }
+
+##
+# @x-accel-stats:
+#
+# Query accelerator statistics
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: accelerator statistics
+#
+# Since: 10.1
+##
+{ 'command': 'x-accel-stats',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ] }
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 065de80a87b..598796bdca9 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -41,6 +41,8 @@ typedef struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
+    /* get_stats: Append statistics to @buf */
+    void (*get_stats)(AccelState *as, GString *buf);
 
     /* system related hooks */
     void (*setup_post)(AccelState *as);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index af54302409c..2a89641aa81 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -50,6 +50,9 @@ struct AccelOpsClass {
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    /* get_vcpu_stats: Append statistics of this @cpu to @buf */
+    void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
+
     /**
      * @get_virtual_clock: fetch virtual clock
      * @set_virtual_clock: set virtual clock
diff --git a/accel/accel-qmp.c b/accel/accel-qmp.c
new file mode 100644
index 00000000000..318629665b3
--- /dev/null
+++ b/accel/accel-qmp.c
@@ -0,0 +1,34 @@
+/*
+ * QMP commands related to accelerators
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "qapi/type-helpers.h"
+#include "qapi/qapi-commands-accelerator.h"
+#include "system/accel-ops.h"
+#include "hw/core/cpu.h"
+
+HumanReadableText *qmp_x_accel_stats(Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    g_autoptr(GString) buf = g_string_new("");
+
+    if (acc->get_stats) {
+        acc->get_stats(accel, buf);
+    }
+    if (acc->ops->get_vcpu_stats) {
+        CPUState *cpu;
+
+        CPU_FOREACH(cpu) {
+            acc->ops->get_vcpu_stats(cpu, buf);
+        }
+    }
+
+    return human_readable_text_from_str(buf);
+}
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 11ba8e24d60..246ea55425f 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "hw/boards.h"
+#include "hw/core/cpu.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "qemu/error-report.h"
diff --git a/accel/meson.build b/accel/meson.build
index 52909314bfa..25b0f100b51 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,6 +1,6 @@
 common_ss.add(files('accel-common.c'))
 specific_ss.add(files('accel-target.c'))
-system_ss.add(files('accel-system.c', 'accel-blocker.c'))
+system_ss.add(files('accel-system.c', 'accel-blocker.c', 'accel-qmp.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
-- 
2.49.0


