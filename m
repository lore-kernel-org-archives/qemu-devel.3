Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F45C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dS-0006R0-63; Wed, 02 Jul 2025 14:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dD-0005Yv-4X
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dA-0002Tw-5j
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so4722557f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482585; x=1752087385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eg1QLrLP2BMZ9vGVeWVIdjZH5+H7wor9h9xhFdkEFm4=;
 b=pgOLK/WcfOoEvqZ4z/UuCb43FZBVeaYUU9genBuT7E2QMv7ID7AOnW/mcP91ojQqRE
 zQDrfNi1S9dzVWf3W/yvYDRilrx7XEYaTtuurs27ed+y897JYMo90PgTtfexDpm5Sdj5
 3SmKr1M86DXqrPc4XDg/LrE2gLzrVLFfQHAsqzoaKtH/TEZaQVJWlbD4Xce76jpXxvPV
 pmC2Y2vN9qHcLSu0RSaYr/kYC9s1+sZc1q00pv0D/sdVcjqFm6TxgMSvAQY0sJ6fym5K
 SQxhrpK07JAU0QdPYherDZ2JVnWf4b8aZBbJGa2o+XwCvp+tL3OAV7G23ZuZimCipuZv
 dmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482585; x=1752087385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eg1QLrLP2BMZ9vGVeWVIdjZH5+H7wor9h9xhFdkEFm4=;
 b=ShKbTTZB9KvPAoK7cCNAXJ7qR/hA+dfTwCt8MUTg9ioLYTaEGjlXTG9DJbm3cREEVj
 +qmf3r84pMeKW13XG6JNjvWAU7UYNil4kCKqIqLjQp8D9UKUHIFXodoDPL643LLJ/0Pe
 vDCN/3Ugf/q3eXvUiLNJsnNuWzvmL2F+XWg2UYQGKI1qED9eu6W9f6cUqhGTOH/3CAnF
 17amO1I7xksK8VzSP0H1Dw1XqirMAmKWrzZH2bhSiI4mblWdtQOF34BEqGSyMYDxaNKr
 MnBk0MksMkJ383Wsusn+4Hj5iG0K7k2ZFYxE8dVk6D7lvDs/BtR/3OTPuAOgUjeDXgix
 9p8A==
X-Gm-Message-State: AOJu0Ywt5AYvEVQLvGLXrHY4UIMBx+VUZ4YFc2pIwPAUyOxdnGgthPWv
 5ejh3RVKnNG85mXfg4QkvEhFfXNxey6lxkhyVZXPtenMCjpXHsQtIs1dUMpx1ISwsL5mKRBXXsu
 PdHmF
X-Gm-Gg: ASbGnctkOBYTpWrnKXxfziyJSzsCGxyNyAtPt5m4Hq+MmORmqZ3+2+XSdahSILwCi8A
 pn1WTB1eO4AwUCUvFophEs58X3NtpQK2CpixND8Me8p2zQIIWVIRQ4KzrxxUIrN6XoxTyk6YbRZ
 znStmM3BFJ5WjAlyAB6sHLpIrLXf9uaJRUdJcmJtCHJmvXBmX+OVGlW5iPtZ7oZf+/ZcvLdxhRo
 Hg/UAuvjtAyc2sps7mjHVjpl/2TVgGTMr2tU/gPvWZn+Ob6oprXQbH8yK6DgDj5tSciXgRJlJO1
 jQr8ioKQXT8wbe7DkO5Z9ZzUv7yKysDAzantcJ3eOg+DsywtqMmTkiIPNTqFzBigEHGW+8XKHWT
 pZ9bOEMFKLfUmNvbVCWE/0eTCCMZ6VhM6Hn5H
X-Google-Smtp-Source: AGHT+IH5acTYdfn6qoz2xOPcBTVv+InLxlJToiv4CwOuSaTe+SB1DB+Tr51i/fJFDkJCAcmPQ1yN2g==
X-Received: by 2002:a05:6000:43c9:b0:3a5:7944:c9b with SMTP id
 ffacd0b85a97d-3b32c0a188bmr190504f8f.16.1751482585133; 
 Wed, 02 Jul 2025 11:56:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5979dsm16670846f8f.75.2025.07.02.11.56.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 23/65] accel/system: Introduce @x-accel-stats QMP command
Date: Wed,  2 Jul 2025 20:52:45 +0200
Message-ID: <20250702185332.43650-24-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
index 1d2a83f1b22..88b536e5274 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -73,3 +73,20 @@
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


