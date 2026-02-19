Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C635E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9cv-0006m3-D1; Thu, 19 Feb 2026 14:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bh-0003BP-4H
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bc-0008EF-Im
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4837907f535so12131935e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528948; x=1772133748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H6kLOb5sf0oiOLXCKzf8ybfs57Z7nX4EwutnQcKt5Kc=;
 b=EHFCV6cupYgzCkdP0o96oG1NlGLHQk5dzjt4LQbjc0jhun8JlGKifZrTPaK3zHloaT
 GCexnzpPY6jwVlCtz5RW4Hs2N6tMFs8cG6geq8/mbFpeO/K7J0l1S5u8zMuN2WJwXAML
 k2Gy6Oo7xl+w6hqqo0trB+i/cVhG+dZRS4E59xHVdExXZrs1CmvPAqRPxU/QoOFvdI1G
 3ifmVw+m96V2XXnk9iJcaLlFQK1vMJzVKv9Uosqp7M/SmklfLF7OqraUY6W4Ya1EAUah
 z7KaZpQL6MZMMfaGSbl5d0+GkLC+Cxs5CLjjOxW9RR8/E29t5hKL5euANAj7890ch80A
 uUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528948; x=1772133748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H6kLOb5sf0oiOLXCKzf8ybfs57Z7nX4EwutnQcKt5Kc=;
 b=Flvbvk8NnN1G88N5KJPuEcGLu/uE4klPDzfbJfXD7Dy53u7YmTPkG1UTzSZlwHLmrN
 K80WXnA22k+oU51x5yhdUVy4IDHI6NRgmI+hYw/xcxuJ8azdgGjK7EpElgX1dq08V7+e
 e6JUaG9TZ44BYgLdNHybll5dV3K5FABsHZjf+cvZeZnWkFW8/7NLsiQmI/myS0UpWES0
 rdg1QejncuV0qhqDXvGXRQ7eFrca04k4pTdZiQltKnp1QQBwdLyb2bktnKEsBZ55pVLC
 C016EVSPpOXcVQ05+GraLBUVnFdMow6+EkIZEFuSWgbeFVI6KgKHOaUmnxuoO9rQJs4m
 1a1w==
X-Gm-Message-State: AOJu0YwUjhUu4dfABhb2iupuCZ/Naq+mxfwEuyyadn12O3ZgKr7Ho/gQ
 C6lUtzDBRR3LiJYIwl8hXJYeW/WHGuo+dIxyXK9HExXZQ/M6sbzHygmzmohDHpuqRTshzvmuWtY
 B3Wl0eVpaQw==
X-Gm-Gg: AZuq6aLGFWVQtMRrIfXQdH2GZZ43cDXo4pd35AZWDclpk/pWx4UUzml+kOKAr9a8qNH
 9AkR7zZVdyv+ojL65H8gIn9Ulhh8d/i1ohElArQMEt55WJoSsyWcMujG9LLTOhB0f9s4WpfOj6T
 zwAyNG/JhephDqO651GM/X1TxXhpmvAcfhr06Db+O6F8+0YEFF3PH1GorYMYMTLpSI2fcEYZZ5m
 heqjZcj73sivA9S4XwwjBP59ikxv6mG9Wk6neRl2Hu5Zo+FTjyj87vyDDJVPnfMaEOUWaeZ8BPJ
 //md6kv5EqE2lOZa/lHirRNEIEGUMpSfTZ+kc754/Ag45CW5/jj28crQWlPvX4SoZEE3aT2sBfd
 q69KS711wP67iceUE2RzlYOHr6UuUoJ6uJkGv/ObluemhaXTtjvOibsWqaEJDr60XtjgpD/mkve
 606wZZrBhijUKAFH09BxMFN5Nw23t6YBXIUdnOwBh+UMqROJVYQRIeRTelTpwppem1gY9XXfDm
X-Received: by 2002:a05:600c:8709:b0:480:1c53:2085 with SMTP id
 5b1f17b1804b1-48379bd731emr310092395e9.19.1771528948321; 
 Thu, 19 Feb 2026 11:22:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31d3ebbsm19849735e9.13.2026.02.19.11.22.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v2 21/50] target/ppc: Extract monitor-related code to monitor.c
Date: Thu, 19 Feb 2026 20:19:23 +0100
Message-ID: <20260219191955.83815-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Keep ppc-qmp-cmds.c for QMP, use monitor.c for HMP.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/monitor.c      | 41 +++++++++++++++++++++++++++++++++++++++
 target/ppc/ppc-qmp-cmds.c | 16 +--------------
 target/ppc/meson.build    |  1 +
 3 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100644 target/ppc/monitor.c

diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
new file mode 100644
index 00000000000..46c49e96236
--- /dev/null
+++ b/target/ppc/monitor.c
@@ -0,0 +1,41 @@
+/*
+ * QEMU PPC (monitor definitions)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
+#include "cpu.h"
+
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    CPUArchState *env1 = mon_get_cpu_env(mon);
+
+    if (!env1) {
+        monitor_printf(mon, "No CPU available\n");
+        return;
+    }
+    dump_mmu(env1);
+}
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 66c3bcb2c38..96228919966 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -1,5 +1,5 @@
 /*
- * QEMU PPC (monitor definitions)
+ * QEMU PPC (QMP definitions)
  *
  * Copyright (c) 2003-2004 Fabrice Bellard
  *
@@ -24,26 +24,12 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "monitor/monitor.h"
 #include "qemu/ctype.h"
-#include "monitor/hmp-target.h"
-#include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
-void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-{
-    CPUArchState *env1 = mon_get_cpu_env(mon);
-
-    if (!env1) {
-        monitor_printf(mon, "No CPU available\n");
-        return;
-    }
-    dump_mmu(env1);
-}
-
 CpuModelExpansionInfo *
 qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                               CpuModelInfo *model,
diff --git a/target/ppc/meson.build b/target/ppc/meson.build
index b0d708bb519..d4ebbaf0a19 100644
--- a/target/ppc/meson.build
+++ b/target/ppc/meson.build
@@ -43,6 +43,7 @@ ppc_system_ss.add(files(
   'mmu-hash32.c',
   'mmu-booke.c',
   'mmu_common.c',
+  'monitor.c',
   'ppc-qmp-cmds.c',
 ))
 ppc_system_ss.add(when: 'CONFIG_TCG', if_true: files(
-- 
2.52.0


