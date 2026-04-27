Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57073FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH37-0007pa-T8; Mon, 27 Apr 2026 04:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2s-0007iw-1I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2q-0002We-2S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso98954845e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277418; x=1777882218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FEYVG77IATzxHN9K3rUtTEhkQ/61nsqF8+QMsN3xQbQ=;
 b=Uc8C1DgqWPsZqioqAaBQGH90WS98LNdP1O701eDwPWd+W57jckuo+7ud5fVZlD/QEZ
 jUof8KLE+W5rIpDrMVhd8x6hkfuZrfdmGNWVCtBZCjdw/D2X/LF3SjkCA+VVFPcpF1GP
 TzBKKhslIu2YNb7RUEHUYAkcPUiETG9ejWrtPHCnKPQQpTeYgo5ue+BNylo1y/vuvYFK
 5zvS1uUuHeCePfsx3N6Vh5/Hy9Vm9dv0LeoQaU3Ql1Q/I8cm84xL79nVc64R/pjGdcLo
 Av64zlC0sLXiPXcv1hmlvMxBFOdXc3H+rSmBs4RCHVZ2H0NvJu1v+oaab3fib8DF1RNU
 PjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277418; x=1777882218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FEYVG77IATzxHN9K3rUtTEhkQ/61nsqF8+QMsN3xQbQ=;
 b=e7RYnqsAj0r8rmEXmFZ9YlBZeuFiJwmuuGnma+PLPW4vDFx854cbYGPZZTMfRozlRM
 tl6infX4SPrBVHZgWcArt0rTuPIM64DnKLeS+c3aF89VBjATkc/MPP8YKEP0TYDF5NU7
 irIlsAb6DOuFtglpuIzHOg50BFMp64f3z6rOBey4Gl0ei0mWm8jFr1XtpgNZMJE8TF8M
 Zj6pQkC/i0Mg7jGKPXKZIqIaAkjtIvcs2lNfYBXfJwjG04/SK6zFu6JPxo1KvMAFHzr5
 yRKZ8BKuL8pEtaS1V4L8rGIFd+paj1G5QLldrHEVUcRtmKKMi4Ji5SDmulIiiRMihZzN
 4OWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85G3TD48KUxO7Ojeca9s07GJytXFyU6ms3qdVYg5qT+zPZi8GA0NXJ3LDFvXB89OY/zvxbVl2Y8LZC@nongnu.org
X-Gm-Message-State: AOJu0YzO08hvHnfYP1fEnuAOBm/U8TBlvuymg8aDEEDsAVlMxRzTdI/Q
 7LTPLmsxrTNSrkF8rO2TZxr91oRMdcU+vWfbNk6ELhng3dEE/2xFZwrdghDcqXYFpD85ReOScjA
 YOwaRd3o=
X-Gm-Gg: AeBDieuSpOQr097Mv341ZSk/dHJogW6JTgWOwvwqquBFb87pKCo6/1WiRtlX54CfkNw
 oxdcRlt4mYbleB0TpBILRnBmWNpDZjBus1S3KQF1H4tHMbjZx1sBf3FIyD+JEr53YQr7k/75Niq
 GCNZ4B9wrkRIjpPXLlhMProeSEZ4Ou8uEM27DXXALx+ZRwGS8zaCxtrprBEn32FfEcdcPq1Myv2
 FkR2OCih0vnQlP3OURIS/Cgqquuu9A1F2K4hYIAY/QV1TKi9kUHVA4JNvX/95VQ63ksCpWwyyPz
 /q7pjIXU77hQb+xY0CPc0FxyrHV1WMfDWPKOVNLubw3t4kcpQXyKsJlkFyVn1H0PAljKiNEoLva
 WKiNmEfuQZZ3AgCcEjp3VPY/RHvbk13BPyTTHYOxTu+ITuVQy5QzaXjM/hijEF3NfjMmPC0P8PL
 RiVkTK+jzrWRkAOXX+tkXq0dJrAYCqrVRA853Ur7bFdgonA/vVAyxnFXJzpK5sZOdmYnimXcJvx
 ZU2rC9eZSs=
X-Received: by 2002:a05:600c:c09c:b0:48a:5363:8cac with SMTP id
 5b1f17b1804b1-48a53638e07mr285628435e9.22.1777277418079; 
 Mon, 27 Apr 2026 01:10:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52d232afsm162750135e9.31.2026.04.27.01.10.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 23/32] monitor: Reduce target-specific methods further
Date: Mon, 27 Apr 2026 10:07:29 +0200
Message-ID: <20260427080738.77138-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
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

get_monitor_def() doesn't use any target-specific declaration
anymore, move it to hmp.c to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 monitor/monitor-internal.h |  1 -
 monitor/hmp-target.c       | 33 ---------------------------------
 monitor/hmp.c              | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 34 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index eaf9a607783..a5c4aba306e 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -191,7 +191,6 @@ void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
 void qmp_dispatcher_co_wake(void);
 
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index c2ddcd67e51..550a7178052 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -57,39 +57,6 @@ HMPCommand *hmp_cmds_for_target(bool info_command)
     return info_command ? hmp_info_cmds : hmp_cmds;
 }
 
-/*
- * Set @pval to the value in the register identified by @name.
- * return 0 if OK, -1 if not found
- */
-int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
-{
-    const MonitorDef *md = target_monitor_defs();
-    CPUState *cs = mon_get_cpu(mon);
-    void *ptr;
-
-    if (cs == NULL || md == NULL) {
-        return -1;
-    }
-
-    for(; md->name != NULL; md++) {
-        if (hmp_compare_cmd(name, md->name)) {
-            if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
-            } else {
-                CPUArchState *env = mon_get_cpu_env(mon);
-                ptr = (uint8_t *)env + md->offset;
-                *pval = *(int32_t *)ptr;
-            }
-            return 0;
-        }
-    }
-
-    if (!cs->cc->sysemu_ops->monitor_get_register) {
-        return -1;
-    }
-    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
-}
-
 static int
 compare_mon_cmd(const void *a, const void *b)
 {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index e881c26c305..618ded40207 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "hw/core/qdev.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
 #include "monitor/hmp-target.h"
@@ -359,6 +360,8 @@ static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(Monitor *mon, const char *fmt, ...)
 {
@@ -1599,3 +1602,36 @@ void monitor_register_hmp_info_hrt(const char *name,
     }
     g_assert_not_reached();
 }
+
+/*
+ * Set @pval to the value in the register identified by @name.
+ * return 0 if OK, -1 if not found
+ */
+static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+{
+    const MonitorDef *md = target_monitor_defs();
+    CPUState *cs = mon_get_cpu(mon);
+    void *ptr;
+
+    if (cs == NULL || md == NULL) {
+        return -1;
+    }
+
+    for(; md->name != NULL; md++) {
+        if (hmp_compare_cmd(name, md->name)) {
+            if (md->get_value) {
+                *pval = md->get_value(mon, md, md->offset);
+            } else {
+                CPUArchState *env = mon_get_cpu_env(mon);
+                ptr = (uint8_t *)env + md->offset;
+                *pval = *(int32_t *)ptr;
+            }
+            return 0;
+        }
+    }
+
+    if (!cs->cc->sysemu_ops->monitor_get_register) {
+        return -1;
+    }
+    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
+}
-- 
2.53.0


